library(tidyverse)

path <- here::here("data-raw/12859_2009_3643_MOESM1_ESM.XLS")

copies <- rep(rep(3.14 * 10 ^(7:2), each = 12), 50)
dilution <- as.integer((3.14 * 10 ^7) / copies)
raw_runs_calib <-
  readxl::read_excel(path,
                     sheet = "curve calibration Runs",
                     range = "B5:BU54",
                     col_names = as.character(1:72))

raw_runs_tannic_acid <-
  readxl::read_excel(path,
                     sheet = "Tannic acid Runs",
                     range = "B5:BC44",
                     col_names = as.character(1:54))

raw_runs_IgG <-
  readxl::read_excel(path,
                     sheet = "IgG Runs",
                     range = "B5:BC44",
                     col_names = as.character(1:54))

raw_runs_quercitin <-
  readxl::read_excel(path,
                     sheet = "Quercitin Runs",
                     range = "B5:AW44",
                     col_names = as.character(1:48))

runs_calib <-
  raw_runs_calib |>
  tidyr::pivot_longer(cols = everything(),
                      names_to = "run",
                      values_to = "fluor") |>
  dplyr::mutate(run = as.integer(run)) |>
  dplyr::bind_cols(list(
    cycle = rep(1:50, each = 72),
    copies = copies,
    dilution = dilution
  )) |>
  dplyr::arrange(run, cycle) |>
  dplyr::transmute(
    plate = "calibration",
    run = run,
    well = NA_character_,
    target = "MT-ND1",
    dye = "SYBR",
    sample = "pGEM-T",
    sample_type = "std",
    inhibitor = "none",
    inhibitor_conc = 0,
    replicate = rep(rep(1:12, each = 50), 6),
    copies = copies,
    dilution = dilution,
    cycle = cycle,
    fluor = fluor
  )

tannic_acid_conc <- purrr::accumulate(1:8, ~ .x / 2, .init = 0.1)
runs_tannic_acid <-
  raw_runs_tannic_acid |>
  tidyr::pivot_longer(cols = everything(),
                      names_to = "run",
                      values_to = "fluor") |>
  dplyr::mutate(run = as.integer(run)) |>
  dplyr::bind_cols(list(
    inhibitor_conc = rep(rep(tannic_acid_conc, each = 6), 40),
    cycle = rep(1:40, each = 54)
  )) |>
  dplyr::arrange(run, cycle) |>
  dplyr::transmute(
    plate = "tannic acid",
    run = run,
    well = NA_character_,
    target = "MT-ND1",
    dye = "SYBR",
    sample = "pGEM-T",
    sample_type = "std",
    inhibitor = "tannic acid",
    inhibitor_conc = inhibitor_conc,
    replicate = rep(rep(1:6, each = 40), 9),
    copies = 31400L,
    dilution = (3.14 * 10 ^7) / copies,
    cycle = cycle,
    fluor = fluor
  )

IgG_conc <- purrr::accumulate(1:8, ~ .x / 2, .init = 2)
runs_IgG <-
  raw_runs_IgG |>
  tidyr::pivot_longer(cols = everything(),
                      names_to = "run",
                      values_to = "fluor") |>
  dplyr::mutate(run = as.integer(run)) |>
  dplyr::bind_cols(list(
    inhibitor_conc = rep(rep(IgG_conc, each = 6), 40),
    cycle = rep(1:40, each = 54)
  )) |>
  dplyr::arrange(run, cycle) |>
  dplyr::transmute(
    plate = "IgG",
    run = run,
    well = NA_character_,
    target = "MT-ND1",
    dye = "SYBR",
    sample = "pGEM-T",
    sample_type = "std",
    inhibitor = "IgG",
    inhibitor_conc = inhibitor_conc,
    replicate = rep(rep(1:6, each = 40), 9),
    copies = 3140000L,
    dilution = (3.14 * 10 ^7) / copies,
    cycle = cycle,
    fluor = fluor
  )

quercitin_conc <- purrr::accumulate(1:7, ~ .x / 2, .init = 0.04)
runs_quercitin <-
  raw_runs_quercitin |>
  tidyr::pivot_longer(cols = everything(),
                      names_to = "run",
                      values_to = "fluor") |>
  dplyr::mutate(run = as.integer(run)) |>
  dplyr::bind_cols(list(
    inhibitor_conc = rep(rep(quercitin_conc, each = 6), 40),
    cycle = rep(1:40, each = 48)
  )) |>
  dplyr::arrange(run, cycle) |>
  dplyr::transmute(
    plate = "quercitin",
    run = run,
    well = NA_character_,
    target = "MT-ND1",
    dye = "SYBR",
    sample = "pGEM-T",
    sample_type = "std",
    inhibitor = "quercitin",
    inhibitor_conc = inhibitor_conc,
    replicate = rep(rep(1:6, each = 40), 8),
    copies = 31400L,
    dilution = (3.14 * 10 ^7) / copies,
    cycle = cycle,
    fluor = fluor
  )

sisti <-
  dplyr::bind_rows(
    runs_calib,
    runs_tannic_acid,
    runs_IgG,
    runs_quercitin
  ) |>
  dplyr::transmute(
    plate = as.factor(plate),
    well = as.factor(well),
    target = as.factor(target),
    dye = as.factor(dye),
    sample = as.factor(sample),
    sample_type = as.factor(sample_type),
    inhibitor = as.factor(inhibitor),
    inhibitor_conc = as.double(inhibitor_conc),
    replicate = as.factor(replicate),
    copies = as.integer(copies),
    dilution = as.integer(dilution),
    cycle = as.integer(cycle),
    fluor = as.double(fluor)
  )

usethis::use_data(sisti, overwrite = TRUE)
