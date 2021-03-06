#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "command line: tar"

inputs:
  - id: index
    type: File
    inputBinding:
      position: 1

outputs:
  - id: output
    type:
      type: array
      items: File
    outputBinding:
      glob: "rsem_references/*"

baseCommand: [tar, xvzf]
