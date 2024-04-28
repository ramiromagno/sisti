#' qPCR data sets by Sisti et al. (2010)
#'
#' @description
#' One single tabular tidy data set in long format, encompassing four data sets
#' of amplification curves: (i) six-point, ten-fold dilution series, (ii) tannic
#' acid inhibition, (iii) IgG inhibition and (iv) quercitin inhibition. The
#' target amplicon consisted of a 104 bp fragment of the mitochondrial gene NADH
#' dehydrogenase 1 (MT-ND1). Please read the Methods section of Sisti et al.
#' (2010) for more experimental details.
#'
#' ### Dilution series
#'
#' A six-point, ten-fold dilution series spanning an amplicon copy number range
#' \eqn{3.14 10^7} thru \eqn{3.14 10^2}. Each concentration is replicated twelve
#' times. Each reaction has been amplified through 50 cycles.
#'
#' ```{r}
#' dplyr::filter(sisti, plate == "calibration")
#' ```
#'
#' ### Tannic acid inhibition
#'
#' A series of reactions subjected to inhibition by tannic acid with
#' concentrations: 0.000391, 0.000781, 0.00156, 0.00312, 0.00625, 0.0125, 0.025,
#' 0.05 and 0.1 mg/mL. Each tannic acid concentration sample is replicated six
#' times. Each reaction has been amplified through 40 cycles.
#'
#' ```{r}
#' dplyr::filter(sisti, plate == "tannic acid")
#' ```
#'
#' ### Immunoglobulin G (IgG) inhibition
#'
#' A series of reactions subjected to inhibition by IgG with concentrations:
#' 0.00781, 0.0156, 0.0312, 0.0625, 0.125, 0.25, 0.5, 1 and 2 mg/mL. Each IgG
#' concentration sample is replicated six times. Each reaction has been
#' amplified through 40 cycles.
#'
#' ```{r}
#' dplyr::filter(sisti, plate == "IgG")
#' ```
#'
#' ### Quercitin inhibition
#'
#' A series of reactions subjected to inhibition by quercitin with
#' concentrations: 0.000312, 0.000625, 0.00125, 0.0025, 0.005, 0.01, 0.02, and
#' 0.04 mg/mL. Each quercitin concentration sample is replicated six times. Each
#' reaction has been amplified through 40 cycles.
#'
#' ```{r}
#' dplyr::filter(sisti, plate == "quercitin")
#' ```
#'
#' @format A [tibble][tibble::tibble-package] providing amplification curve data
#' in long format. Each row is for an amplification curve point.
#'
#' \describe{
#' \item{`plate`}{Plate identifier. There is one identifier for each of the four
#' data sets.}
#' \item{`well`}{Well identifier, i.e. the position within a PCR plate. This
#' information was not available from the original publication, thus all values
#' are `NA`.}
#' \item{`target`}{Target identifier. In all data sets the target is an amplicon
#' consisting of a 104 bp fragment of the mitochondrial gene NADH dehydrogenase
#' 1 (MT-ND1), thus the values are all `"MT-ND1"`.}
#' \item{`dye`}{Type of fluorescence dye, in this data set it is always SYBR
#' Green I master mix (Roche) (`"SYBR"`).}
#' \item{`sample`}{Name of the biological sample. All samples are based on a
#' pGEM-T Promega plasmid, so all values are `"pGEM-T"`.}
#' \item{`sample_type`}{Sample type. All reactions are standard curves, i.e.
#' `"std"`.}
#' \item{`inhibitor`}{Name of the molecule used as PCR inhibitor. In the case of
#' the dilution series the value is `"none"`.}
#' \item{`inhibitor_conc`}{Inhibitor concentration in mg/mL.}
#' \item{`replicate`}{Replicate identifier.}
#' \item{`copies`}{Standard copy number of the amplicon.}
#' \item{`dilution`}{Dilution factor. Higher number means greater dilution, e.g.
#' `10` means a 1:10 (ten-fold) dilution.}
#' \item{`cycle`}{PCR cycle.}
#' \item{`fluor`}{Raw fluorescence values.}
#' }
#'
#' @examples
#' sisti
#'
#' @source \doi{10.1186/1471-2105-11-186}
#' @name sisti
#' @keywords datasets
NULL
