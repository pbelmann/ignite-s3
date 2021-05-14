nextflow.enable.dsl=2



process runBBMapDeinterleave {

    label 'large'

    tag "$sample"

    stageOutMode 'copy'

    stageInMode 'copy'

    container "quay.io/biocontainers/bbmap:${params.bbmap_tag}"

    input:
    tuple val(sample), path(interleaved_reads, stageAs: "interleaved.fq.gz")

    output:
    tuple val("${sample}"), path("read1.fq.gz"), path("read2.fq.gz")

    shell:
    """
    reformat.sh in=interleaved.fq.gz out1=read1.fq.gz out2=read2.fq.gz
    """
}


workflow {
   main:
     Channel.fromPath(file(params.input)) | splitCsv(sep: '\t', header: true) \
             | view() | map { it -> [ it.SAMPLE, it.READS ]} \
             | view() | runBBMapDeinterleave  
}

