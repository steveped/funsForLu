% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootMeans.R
\name{bootMeans}
\alias{bootMeans}
\title{Bootstrap two gene sets and compare their mean values}
\usage{
bootMeans(valCol, data, testIds, refIds, idCol = 1L, binCol = "lengthBin",
  filt = "> -Inf", nGenes = 1000L, nBoot = 100L, minGenes = 200L, ...,
  na.rm = TRUE, replace = TRUE, maxP)
}
\arguments{
\item{valCol}{A singular column containing the value to be bootstrapped}

\item{data}{A data frame containing all the data required}

\item{testIds}{A \code{character vector} with test set of Ids}

\item{refIds}{A \code{character vector} with the reference setof Ids}

\item{idCol}{The column in \code{data} containing the Ids in the vectors \code{testIds} and \code{refIds}. Can be specified as an integer position or as a character (regular expression).}

\item{binCol}{The column in \code{data} containing the bin allocations for each gene. Can also be specified as an integer or by name.}

\item{filt}{A text expression passed to the NSE capabilities of the \code{filter_} function.}

\item{nGenes}{\code{integer}. The number of genes to sample at each iteration. Values greater than the number of testIds will automatically be capped at the number of testIds}

\item{nBoot}{\code{integer}. The number of bootstrap iterations to be performed}

\item{minGenes}{\code{integer}. The minimum number of IDs required to conduct a bootstrap procedure with any meaning.}

\item{...}{Passed to the function \code{mean} internally}

\item{na.rm}{\code{logical}. Also passed internally to the function \code{mean}}

\item{replace}{\code{logical}. Should the bootstrap use sampling with replacement (\code{replace = TRUE}) or without}

\item{maxP}{The maximum probability (weight) allowed for an individual gene in the reference set. 
Defaults to \code{1/nGenes}}
}
\value{
A \code{list} with components:
\itemize{
 \item \code{$samples} The sampled differences in the median values
 \item \code{$p} The proportion of sampled differences which are > 0
 \item \code{$nGenes} The number of genes sampled at each bootstrap iteration
 \item \code{$nBoot} The number of bootstrap iterations
 \item \code{$sampleSizes} A \code{data_frame} with the sample sizes for each dataset,
 broken down into Expressed and Not Expressed genes.
 \item \code{$testBins} The distributions of genes amongst the binning variable in the set of test IDs
 \item \code{$refBins} The distributions of genes amongst the binning variable in the set of reference IDs.
 The final column represents the sampling probability for each individual gene in the corresponding bin
 \item \code{$missingBins} These are the bins not commonly represented in the dataset. 
 If any are found a non-fatal warning message will be printed during running of the process.
}
}
\description{
A function for comparing two sets of genes without relying on any distributional assumptions.
}
\details{
This is a modification of the \code{bootMedians} function, 
but is written to only work with a single column of values to be bootstrapped.
To apply across multiple value columns, please use \code{lapply} or \code{sapply}.

This function breaks the supplied \code{data.frame} into two sets of test IDs & reference IDs.
The \code{data.frame} must contain a column (\code{binCol}) which classifies each ID into a bin.
The probabilities of bin membership in the test IDs are then used for sampling during the bootstrap procedure.

The values to be bootstrapped must be specified in the argument \code{valCol}, 
and this can be a regular expression or integer, but must specify only a single column
in the supplied \code{data.frame}.

The function will automatically filter the data to remove any values ouside
the specified criterion.

The function itself will sample the same number of IDs (\code{nGenes}) from each dataset, 
based on the probabilities of bin membership in the test dataset.
At each bootstrap iteration, the mean values for each column specified will be returned from both datasets,
with the reference values then subtracted from the tested values.
This allows direct comparison of these values as they will be drawn from similar
distributions based on the binning variable used.

If any genes have a probability of being resampled > \code{maxP} they may exert undue influence on the results.
If any are found the process will stop to allow removal of this grouping.
Alternatively, the value for \code{maxP} can be reset up to a maximum of 1, 
which would represent maximum permissability.
}
\author{
Steve Pederson
}

