workflow umitools_dedup {
	call umitools_dedup_task
}

task umitools_dedup_task {
	File bam
	String id
	Int memoryGb
	Int diskSpaceGb
  Int num_preempt
  Int num_cores

	command {
    umitools dedup -I ${bam} \
									--output-stats=dedup \
									-S ${id}.dedup.bam
	output {
		File dedup_edit_distance = "dedup_edit_distance.tsv"
		File dedup_per_umi = "dedup_per_umi.tsv"
		File dedup_per_umi_per_position = "dedup_per_umi_per_position.tsv"
		File dedup_bam = "${id}.dedup.bam"
	}

	runtime {
		docker: "gcr.io/broad-cga-sanand-gtex/umi-tools:latest"
		memory: "${memoryGb} GB"
		cpu: "${num_cores}"
		disks: "local-disk ${diskSpaceGb} HDD"
    preemptible: "${num_preempt}"
	}
}
