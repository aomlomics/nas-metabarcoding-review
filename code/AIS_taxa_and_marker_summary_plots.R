#Holmes, Thompson & Hunter review of AIS detection in eDNA metabarcoding
setwd("/Users/ann.holmes/Desktop/github/ais-metabarcoding-review")

#modified from https://geneticslab.letgen.org/mikes-genetics-genomics-workbook/phylogenetics/make-a-phylogenetic-tree/
#which is modified from https://cran.r-project.org/web/packages/rotl/vignettes/rotl.html
library(ape)
library(rotl)

verts <- c(#fishes
  "Acheilognathus imberbis ","Acheilognathus rhombeus","Acipenser schrenckii","Alburnus alburnus","Alosa pseudoharengus","Alosa sapidissima","Ameiurus melas","Ameriurus nebulosus ","Anabas testudineus","Ancherythroculter lini","Andinoacara rivulatus","Anguilla anguilla","Anguilla rostrata","Arenigobius bifrenatus","Astronotus ocellatus","Atherinella schultzi","Australoheros facetus","Babka gymnotrachelus","Barbatula toni","Carassius auratus","Carassius cuvieri ","Carassius gibelio","Channa argus","Channa maculata","Channa striata","Cirrhinus molitorella","Cirrhinus mrigala","Clarias gariepinus","Iksookimia hugowolfeldi","Cobitis melanoleuca ","Coilia brachygnathus","Coptodon zillii","Coreoperca herzi","Coreoperca kawamebari","Ctenopharyngodon idella","Culter mongolicus","Cyprinus carpio","Cyprinus megalophthalmus","Cyprinus multitaeniata","Danio rerio","Dionda episcopa ","Dorosoma cepedianum","Dorosoma petenense","Esox lucius","Etrumeus golanii","Gambusia affinis","Gambusia holbrooki","Gasterosteus aculeatus","Gnathopogon caerulescens","Gnathopogon elongatus","Gobio gobio","Gobio soldatovi","Gymnocephalus cernua","Gymnogobius breunigii","Heteropneustes fossilis","Hypomesus nipponensis","Hypophthalmichthys molitrix","Hyporhamphus intermedius","Hypostomus plecostomus","Ictalurus furcatus","Ictalurus punctatus","Labeo rohita","Labeobarbus intermedius","Labeobarbus natalensis","Lateolabrax masclulatus","Lateolabrax japonicus","Lepomis cyanellus","Lepomis gibbosus","Lepomis gulosus","Lepomis macrochirus","Leuciscus idus","Liza saliens","Macropodus opercularis","Megalobrama amblycephala","Megalobrama terminalis","Microphysogobio brevirostris","Microphysogobio fukiensis","Micropterus dolomieu","Micropterus salmoides","Misgurnus bipartitus","Misgurnus mizolepis","Misgurnus dabryanus","Misgurnus mohoity","Misgurnus nikolskyi","Monopterus albus","Morone americana","Morone chrysops","Morone saxatilis","Mylopharyngodon piceus","Myxocyprinus asiaticus","Nemipterys randalli","Neogobius fluviatilis","Neogobius melanostomus","Neosalanx cf. tangkahkeii","Neosalanx taihuensis","Odontobutis potamophila","Oncorhynchus formosanus","Oncorhynchus gorbuscha","Oncorhynchus kisutch","Oncorhynchus mykiss","Oncorhynchus tshawytscha","Monopterus cuchia","Opsariichthys uncirostris","Oreochromis aureus","Oreochromis korogwe ","Oreochromis mossambicus","Oreochromis niloticus","Oreochromis tanganicae","Oreochromis urolepis","Oryzias haugiangensis","Oryzias latipes","Osmerus mordax","Osteochilus salsburyi","Pagellus bellottii","Paramisgurnus dabryanus","Perca fluviatilis","Perccottus glenii","Petromyzon marinus","Phoxinus bigerri","Piaractus mesopotamicus","Platygobio gracilis","Plecoglossus altivelis altivelis","Poecilia latipinna","Poecilia reticulata","Poecilia vivipara","Procypris rabaudi","Proterorhinus semilunaris","Protosalanx chinensis","Protosalanx hyalocranius","Pseudaspius hakonensis", "Pseudorasbora parva","Pterygoplichthys pardalis","Pylodictis olivaris","Rhinogobius brunneus ","Rhinogobius formosanus","Rhinogobius gigas","Rhinogobius nagoyae","Rhodeus notatus","Rhodeus ocellatus ocellatus","Rhodeus uyekii","Salmo salar","Salmo trutta","Salvelinus confluentus","Salvelinus fontinalis","Sarcocheilichthys davidi ","Sarcocheilichthys soldatovi","Sarotherodon galilaeus","Scophthalmus maximus","Siganus luridus","Siganus rivulatus","Silurus asotus","Silurus soldatovi","Sinibrama macrops ","Siniperca chuatsi","Sinobdella sinensis","Smilosicyopus bitaeniatus","Sparus aurata","Squalidus argentatus","Squaliobarbus curriculus","Tachysurus nitidus","Tanakia lanceolata","Tilapia niloticus","Tinca tinca","Tridentiger trigonocephalus","Xiphophorus hellerii ","Zacco acanthogenys","Zacco platypus",
  #reptiles
  "Trachemys scripta", "Apalone ferox", "Chelydra serpentina", 
  #amphibians
  "Lithobates catesbeianus", "Triturus carnifex", "Lissotriton vulgaris meridionalis",
  #mammal
  "Neovison vison")


new_tiplabels <- c(#fishes
  "Acheilognathus imberbis ","Acheilognathus rhombeus","Acipenser schrenckii","Alburnus alburnus","Alosa pseudoharengus","Alosa sapidissima","Ameiurus melas","Ameriurus nebulosus ","Anabas testudineus","Ancherythroculter lini","Andinoacara rivulatus","Anguilla anguilla","Anguilla rostrata","Arenigobius bifrenatus","Astronotus ocellatus","Atherinella schultzi","Australoheros facetus","Babka gymnotrachelus","Barbatula toni","Carassius auratus","Carassius cuvieri ","Carassius gibelio","Channa argus","Channa maculata","Channa striata","Cirrhinus molitorella","Cirrhinus mrigala","Clarias gariepinus","Iksookimia hugowolfeldi","Cobitis melanoleuca ","Coilia brachygnathus","Coptodon zillii","Coreoperca herzi","Coreoperca kawamebari","Ctenopharyngodon idella","Culter mongolicus","Cyprinus carpio","Cyprinus megalophthalmus","Cyprinus multitaeniata","Danio rerio","Dionda episcopa ","Dorosoma cepedianum","Dorosoma petenense","Esox lucius","Etrumeus golanii","Gambusia affinis","Gambusia holbrooki","Gasterosteus aculeatus","Gnathopogon caerulescens","Gnathopogon elongatus","Gobio gobio","Gobio soldatovi","Gymnocephalus cernua","Gymnogobius breunigii","Heteropneustes fossilis","Hypomesus nipponensis","Hypophthalmichthys molitrix","Hyporhamphus intermedius","Hypostomus plecostomus","Ictalurus furcatus","Ictalurus punctatus","Labeo rohita","Labeobarbus intermedius","Labeobarbus natalensis","Lateolabrax masclulatus","Lateolabrax japonicus","Lepomis cyanellus","Lepomis gibbosus","Lepomis gulosus","Lepomis macrochirus","Leuciscus idus","Liza saliens","Macropodus opercularis","Megalobrama amblycephala","Megalobrama terminalis","Microphysogobio brevirostris","Microphysogobio fukiensis","Micropterus dolomieu","Micropterus salmoides","Misgurnus bipartitus","Misgurnus mizolepis","Misgurnus dabryanus","Misgurnus mohoity","Misgurnus nikolskyi","Monopterus albus","Morone americana","Morone chrysops","Morone saxatilis","Mylopharyngodon piceus","Myxocyprinus asiaticus","Nemipterys randalli","Neogobius fluviatilis","Neogobius melanostomus","Neosalanx cf. tangkahkeii","Neosalanx taihuensis","Odontobutis potamophila","Oncorhynchus formosanus","Oncorhynchus gorbuscha","Oncorhynchus kisutch","Oncorhynchus mykiss","Oncorhynchus tshawytscha","Monopterus cuchia","Opsariichthys uncirostris","Oreochromis aureus","Oreochromis korogwe ","Oreochromis mossambicus","Oreochromis niloticus","Oreochromis tanganicae","Oreochromis urolepis","Oryzias haugiangensis","Oryzias latipes","Osmerus mordax","Osteochilus salsburyi","Pagellus bellottii","Paramisgurnus dabryanus","Perca fluviatilis","Perccottus glenii","Petromyzon marinus","Phoxinus bigerri","Piaractus mesopotamicus","Platygobio gracilis","Plecoglossus altivelis altivelis","Poecilia latipinna","Poecilia reticulata","Poecilia vivipara","Procypris rabaudi","Proterorhinus semilunaris","Protosalanx chinensis","Protosalanx hyalocranius","Pseudaspius hakonensis", "Pseudorasbora parva","Pterygoplichthys pardalis","Pylodictis olivaris","Rhinogobius brunneus ","Rhinogobius formosanus","Rhinogobius gigas","Rhinogobius nagoyae","Rhodeus notatus","Rhodeus ocellatus ocellatus","Rhodeus uyekii","Salmo salar","Salmo trutta","Salvelinus confluentus","Salvelinus fontinalis","Sarcocheilichthys davidi ","Sarcocheilichthys soldatovi","Sarotherodon galilaeus","Scophthalmus maximus","Siganus luridus","Siganus rivulatus","Silurus asotus","Silurus soldatovi","Sinibrama macrops ","Siniperca chuatsi","Sinobdella sinensis","Smilosicyopus bitaeniatus","Sparus aurata","Squalidus argentatus","Squaliobarbus curriculus","Tachysurus nitidus","Tanakia lanceolata","Tilapia niloticus","Tinca tinca","Tridentiger trigonocephalus","Xiphophorus hellerii ","Zacco acanthogenys","Zacco platypus",
  #reptiles
  "Trachemys scripta", "Apalone ferox", "Chelydra serpentina", 
  #amphibians
  "Lithobates catesbeianus", "Triturus carnifex", "Lissotriton vulgaris meridionalis",
  #mammal
  "Neovison vison")
tip.label <- new_tiplabels

# Error: node_id 'ott3634495' was not found!list(ott3634495 = "pruned_ott_id")
# Toxotes microlepis is incertae sedis, delete this species

resolved_names_verts <- tnrs_match_names(verts)


tree_verts <- tol_induced_subtree(ott_ids = resolved_names_verts$ott_id)
strip_ott_ids(tip_labels, remove_underscores = FALSE)

write.tree(tree_verts, file = "tree_verts.nwk") 

#donut plots

library(ggplot2)
library(dplyr)
library(webr)

#https://statdoe.com/pie-donut-chart-in-r/
fish_marker_donut <- read.csv("/Users/ann.holmes/Desktop/github/ais-metabarcoding-review/fish_marker_donut_plot.csv")

fish_donut = fish_marker_donut %>% group_by(gene, marker) %>% summarise(n = sum(count))
print(fish_donut)

as.numeric(fish_donut$n)

PieDonut(fish_donut, aes(gene, marker, count=n))

#split by region: Asia
fish_marker_donut_asia <- read.csv("/Users/ann.holmes/Desktop/github/ais-metabarcoding-review/fish_marker_donut_plot_asia.csv")

fish_donut_asia = fish_marker_donut_asia %>% group_by(gene, marker) %>% summarise(n = sum(count))
print(fish_donut)

as.numeric(fish_donut_asia$n)

PieDonut(fish_donut_asia, aes(gene, marker, count=n))

#split by region: other regions: Africa, North and South America, Europe & Oceania
fish_marker_donut_nonasia <- read.csv("/Users/ann.holmes/Desktop/github/ais-metabarcoding-review/fish_marker_donut_plot_AfrAmerEurOce.csv")

fish_donut_AfrAmerEurOce = fish_marker_donut_AfrAmerEurOce %>% group_by(gene, marker) %>% summarise(n = sum(count))
print(fish_donut)

as.numeric(fish_donut_AfrAmerEurOce$n)

PieDonut(fish_donut_AfrAmerEurOce, aes(gene, marker, count=n))
