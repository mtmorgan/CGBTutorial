# CGBTutorial

This tutorial illustrates how files obtained from the
[Cancer Genomics Browser]() (CGB) can be loaded into appropriate R /
Bioconductor data structures, and how data can be handled to arrive at
results comparable to those in CGB demos.

The CGBTutorial [vignette](CGBTutorial.pdf) can be used as a stand-alone reference.

## Package Installation

Two functions to help with data import are provide in this package. To
use these, the package requires at least the `2.4` branch of
[Bioconductor](http://bioconductor.org). This is the
[`devel` branch](http://bioconductor.org/developers/how-to/useDevel/)
on 6 November, 2013.

1. Export this repository github.
2. Install the package dependencies

    source("http://bioconductor.org/biocLite.R")
    biocLite("Biobase")
    
3. Download `TCGA_BRCA_G4502A_07_3-2013-10-29.tgz` and
   `TCGA_BRCA_GSNP6noCNV-2013-10-29.tgz` from the CGB, and place this
   in the `CGBTutorial/inst/bigdata` directory
4. Build and install the package

       R CMD build CGBTutorial
       R CMD INSTALL CGBTutorial_0.0.2.tar.gz
       
