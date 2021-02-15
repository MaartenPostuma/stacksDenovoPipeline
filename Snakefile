largeM=1:8
smallm=3:7


rule all:
    input:
        MparameterPNG=expand("output/parameterTest/Mparameter.png"),
       # mparameterPNG=expand("output/parameterTest/Mparameter.png")

rule subset_popmap:
    input:
        "data/popmap.tsv"
    output:
        "data/popmapSub.tsv"
    shell:
        "shuf -N 20 data/popmap.tsv > popmapSub.tsv"

rule mkdirLargeM:
    input:
        "data/popmapSub.tsv"
    output:
        expand("output/parameterTest/M{largeM}/",largeM=largeM)
    params:
        largeM=largeM
    shell:
        "mkdir -p output/parameterTest/M{params.largeM"

rule runStacksLargeM:
    input:
        popmapSub="data/popmapSub.tsv"
        inDir=expand("output/parameterTest/M{largeM}/",largeM=largeM)
    output:
        outLog=expand("output/parameterTest/M{largeM}/denovo_map.log",largeM=largeM)
    params:
        largeM=largeM
    shell:
        """
        denovo_map.pl --samples output/demultiplex/ --popmap {input.popmapSub} -T 1 \
        -o {input.inDir} -m 3 -M {params.largeM} \
        -X 'populations: --vcf -r 80'
        """