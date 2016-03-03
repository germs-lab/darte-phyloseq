#http://joey711.github.io/phyloseq/install

library(phyloseq)
library(plyr)
setwd('~/scratch/R-files/')
all <- readRDS('tetM.RDS')

#teasers
plot_bar(all, "Environment")
plot_richness(all, x='Environment')

#http://joey711.github.io/phyloseq-demo/phyloseq-demo.html
#Basic interactions
all
ntaxa(all)
head(otu_table(all))
sample_names(all)[1:10]
sample_variables(all)
rank_names(all)

#subsetting
topNOTUs = names(sort(taxa_sums(all), TRUE)[1:10])
all_top10 = prune_taxa(topNOTUs, all)
all_top10
plot_bar(all_top10,fill="taxa",facet_grid = ~Environment)
network_alltop10 = make_network(all_top10, "taxa", "jaccard", 0.3)
plot_network(network_alltop10, all, "taxa", color = "taxa")


#all sorts of tutorials
#http://joey711.github.io/phyloseq/tutorials-index
topNOTUs = names(sort(taxa_sums(all), TRUE)[1:100])
all_top100 = prune_taxa(topNOTUs, all)
all_top100
plot_heatmap(all_top100)

#A useful one 
#http://joey711.github.io/phyloseq/preprocess.html

#merging
otu_table <- otu_table(all)
sample_datat <- sample_data(all)
tax_table <- tax_table(all)
test <- phyloseq(otu_table, sample_datat, tax_table)
write.table(tax_table, file="taxa_to_get.txt", quote=FALSE, sep="\t", row.names = TRUE, col.names = FALSE)
#In shell, cut -f 6 taxa_to_get.txt > list-ncbi.txt
#you'll have to have biopython and a pycurl library installed
# python get-taxonomy-from-ID.py list-ncbi.txt > taxa-info.ann