workflow mixcr {
	call mixcr_task
}

task mixcr_task {
	File bam
	String id
	Int memoryGb
	Int diskSpaceGb
  Int num_preempt
  Int num_cores

	command {
    java -Xmx${memoryGb}g -jar /opt/picard-tools/picard.jar SamToFastq \
        I=${bam} \
        FASTQ=fastq_R1.fastq \
        SECOND_END_FASTQ=fastq_R2.fastq

		java -Xmx${memoryGb}g -jar /opt/mixcr-3.0.10/mixcr.jar analyze shotgun \
        -s hsa \
        --starting-material rna \
        --align "-t ${num_cores}" \
        --assemble "-t ${num_cores}" \
        --report report.txt \
        --receptor-type xcr \
        --only-productive  \
        fastq_R1.fastq fastq_R2.fastq ${id}

	}

	output {
		File report = "report.txt"
		File mixcr_aligned = "${id}.vdjca"
		File mixcr_aligned_rescued_1 = "${id}.rescued_0.vdjca"
		File mixcr_aligned_rescued_2 = "${id}.rescued_1.vdjca"
		File mixcr_extended = "${id}.extended.vdjca"
		File mixcr_assembled = "${id}.clna"
    File all_clones = "${id}.clonotypes.ALL.txt"
	}

	runtime {
		docker: "gcr.io/broad-cga-sanand-gtex/mixcr:latest"
		memory: "${memoryGb} GB"
		cpu: "${num_cores}"
		disks: "local-disk ${diskSpaceGb} HDD"
    preemptible: "${num_preempt}"
	}
}
