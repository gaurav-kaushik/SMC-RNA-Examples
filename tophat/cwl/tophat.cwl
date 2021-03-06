#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "Tophat Fusion Detection"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/tophat
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 60000

inputs:

  - id: r
    type: ["null",int]
    inputBinding:
      position: 2
      prefix: -r

  - id: p
    type: ["null",int]
    description: | 
      Change number of threads used
    inputBinding:
      position: 2
      prefix: -p

  - id: mate-std-dev
    type: ["null",int]
    inputBinding:
      position: 2
      prefix: --mate-std-dev

  - id: max-intron-length
    type: ["null",int]
    inputBinding:
      position: 2
      prefix: --max-intron-length

  - id: fusion-min-dist
    type: ["null",int]
    inputBinding:
      position: 2
      prefix: --fusion-min-dist

  - id: fusion-anchor-length
    type: ["null",int]
    inputBinding:
      position: 2
      prefix: --fusion-anchor-length

  - id: fusion-ignore-chromosomes
    type: ["null",string]
    inputBinding:
      position: 2
      prefix: --fusion-ignore-chromosomes

  - id: fusion-search
    type: ["null",boolean]
    description: | 
      Turn on fusion algorithm (tophat-fusion)
    inputBinding:
      prefix: --fusion-search
      position: 2

  - id: keep-fasta-order
    type: ["null",boolean]
    description: | 
      Keep ordering of fastq file
    inputBinding:
      prefix: --keep-fasta-order
      position: 2
  
  - id: bowtie1
    type: ["null",boolean]
    description: | 
      Use bowtie1
    inputBinding:
      prefix: --bowtie1
      position: 2

  - id: no-coverage-search
    type: ["null",boolean]
    description: | 
      Turn off coverage-search, which takes lots of memory and is slow
    inputBinding:
      prefix: --no-coverage-search
      position: 2

  - id: fastq1
    type: File
    inputBinding:
      position: 4

  - id: fastq2
    type: File
    inputBinding:
      position: 5
  
  - id: o
    type: string
    inputBinding:
      prefix: -o
      position: 1

  - id: bowtie_index
    type:
      type: array
      items: File

outputs:
  - id: tophatOut
    type: File
    outputBinding:
      glob: $(inputs.o+'/fusions.out')

baseCommand: [tophat]
arguments:
  - valueFrom: $(inputs.bowtie_index[0].path.split("/").slice(0,-1).join("/") + "/genome")
    position: 3
