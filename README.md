## ignite-s3 Nextflow test


### Prerequisites

#### S3 access

How to run:

```
nextflow run -plugins nf-amazon,nf-ignite -work-dir 's3://bucket/directory' main.nf --input test.tsv -resume  -profile ignite
```
