#Script to install all requirements for Microbiome tutorial

#Now get required packages
if(!require(devtools)){install.packages("devtools")}
source("https://bioconductor.org/biocLite.R") #install bioconductor

if(!require(munsell)){install.packages("munsell")}
if(!require(vegan)){install.packages("vegan")}
if(!require(gplots)){install.packages("gplots")}
if(!require(plyr)){install.packages("plyr")}
if(!require(reshape2)){install.packages("reshape2")}
if(!require(ggplot2)){devtools::install_github("tidyverse/ggplot2")}
if(!require(seqinr)){install.packages("seqinr")}
if(!require(DT)){install.packages("DT")}
if(!require(textmineR)){install.packages("textmineR")}
if(!require(plotly)){install.packages("plotly")}

if(!require(phyloseq)){biocLite("phyloseq")}
if(!require(genefilter)){biocLite("genefilter")}
if(!require(DECIPHER)){biocLite("DECIPHER")}
if(!require(phangorn)){biocLite("phangorn")}
if(!require(ggtree)){biocLite("ggtree")}
if(!require(DESeq2)){biocLite("DESeq2")}
if(!require(dada2)){biocLite("dada2")}


require(devtools)
devtools::install_github("jbisanz/MicrobeR") #always resinstall this as it is in development phase

if(.Platform$OS.type=="unix"){
  print("Downloading raw for OSX and Ubuntu using curl")
  
download.file("https://zenodo.org/record/158955/files/rdp_train_set_14.fa.gz", "rdp_train_set_14.fa.gz", method="curl", quiet=F)
download.file("https://zenodo.org/record/158955/files/rdp_species_assignment_14.fa.gz", "rdp_species_assignment_14.fa.gz", method="curl", quiet=F)
download.file("https://raw.githubusercontent.com/jbisanz/BMS270_BMI219/master/Tutorial_metadata.txt","Tutorial_metadata.txt", method="curl", quiet=F)
download.file("https://raw.githubusercontent.com/jbisanz/BMS270_BMI219/master/error_profile.RDS","error_profile.RDS", method="curl", quiet=F)
download.file("https://raw.githubusercontent.com/jbisanz/BMS270_BMI219/master/tree.RDS","tree.RDS", method="curl", quiet=F)

metadata<-data.frame(
FTP=c(
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH02UP.BFF10F.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH39U.BFF10V.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH41N.BFF10T.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH43N.BFF105.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH48N.BFF10A.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH49N.BFF10C.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH54N.BFF103.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH57N.BFF10E.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH60N.BFF117.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH62O.BFF10K.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH64O.BFF10M.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH83NP.BFF111.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH84NP.BFF104.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH85NP.BFF10J.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH87NP.BFF10G.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH88NP.BFF110.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH93NP.BFF101.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH94NP.BFF100.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH97NP.BFF10L.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.birth.MNIH99NP.BFF115.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH02UP.BFB10D.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH39U.BFB10P.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH41N.BFB100.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH43N.BFB102.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH48N.BFB109.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH49N.BFB10A.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH54N.BFB10H.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH57N.BFB10L.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH60N.BFB10Q.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH62O.BFB10W.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH64O.BFB11D.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH83NP.BFB111.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH84NP.BFB112.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH85NP.BFB113.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH87NP.BFB115.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH88NP.BFB117.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH93NP.BFB11G.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH94NP.BFB11H.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH97NP.BFB11J.V.fastq.gz",
      "ftp.sra.ebi.ac.uk/vol1/ERA678/ERA678400/fastq/2024.visit1.MNIH99NP.BFB11Q.V.fastq.gz"
),sample_name=c(
              "2024.birth.MNIH02UP.BFF10F.V",
              "2024.birth.MNIH39U.BFF10V.V",
              "2024.birth.MNIH41N.BFF10T.V",
              "2024.birth.MNIH43N.BFF105.V",
              "2024.birth.MNIH48N.BFF10A.V",
              "2024.birth.MNIH49N.BFF10C.V",
              "2024.birth.MNIH54N.BFF103.V",
              "2024.birth.MNIH57N.BFF10E.V",
              "2024.birth.MNIH60N.BFF117.V",
              "2024.birth.MNIH62O.FF10K.V",
              "2024.birth.MNIH64O.BFF10M.V",
              "2024.birth.MNIH83NP.BFF111.V",
              "2024.birth.MNIH84NP.BFF104.V",
              "2024.birth.MNIH85NP.BFF10J.V",
              "2024.birth.MNIH87NP.BFF10G.V",
              "2024.birth.MNIH88NP.BFF110.V",
              "2024.birth.MNIH93NP.BFF101.V",
              "2024.birth.MNIH94NP.BFF100.V",
              "2024.birth.MNIH97NP.BFF10L.V",
              "2024.birth.MNIH99NP.BFF115.V",
              "2024.visit1.MNIH02UP.BFB10D.V",
              "2024.visit1.MNIH39U.BFB10P.V",
              "2024.visit1.MNIH41N.BFB100.V",
              "2024.visit1.MNIH43N.BFB102.V",
              "2024.visit1.MNIH48N.BFB109.V",
              "2024.visit1.MNIH49N.BFB10A.V",
              "2024.visit1.MNIH54N.BFB10H.V",
              "2024.visit1.MNIH57N.BFB10L.V",
              "2024.visit1.MNIH60N.BFB10Q.V",
              "2024.visit1.MNIH62O.BFB10W.V",
              "2024.visit1.MNIH64O.BFB11D.V",
              "2024.visit1.MNIH83NP.BFB111.V",
              "2024.visit1.MNIH84NP.BFB112.V",
              "2024.visit1.MNIH85NP.BFB113.V",
              "2024.visit1.MNIH87NP.BFB115.V",
              "2024.visit1.MNIH88NP.BFB117.V",
              "2024.visit1.MNIH93NP.BFB11G.V",
              "2024.visit1.MNIH94NP.BFB11H.V",
              "2024.visit1.MNIH97NP.BFB11J.V",
              "2024.visit1.MNIH99NP.BFB11Q.V"
              )
              )

dir.create("RawData") # A directory to store all of our data
for (i in 1:nrow(metadata)){
  if(!file.exists(paste0("RawData/", metadata[i,"sample_name"],".fastq.gz"))){
    download.file(paste0(metadata[i,"FTP"]), paste0("RawData/", metadata[i,"sample_name"],".fastq.gz"), method="curl", quiet=F)
  } else {
    print(paste0("You have already downloaded: ", metadata[i,"sample_name"]))
  }
}
} else {
    print("Sequencing data could not be automatically downloaded. Please download from the following link: https://github.com/jbisanz/BMS270_BMI219/raw/master/tutorialdata.zip")
  }
