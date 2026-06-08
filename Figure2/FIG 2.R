##
source activate metaphlan3

##
for i in *1.fq.gz; do metaphlan --nproc 48 --input_type fastq ${i},${i%1.fq.gz}2.fq.gz --bowtie2db /ME4012-Vol01/database/metaphlan_databases --bowtie2out ./${i%1.fq.gz}.bowtie2.bz2 -o ./${i%1.fq.gz}.tsv;done


##
merge_metaphlan_tables.py *fq.gz.tsv > merged_abundance_table.txt 

##
grep -E '(s__)|(clade_name)' merged_abundance_table.txt |grep -v 't__'|sed 's/^.*s__//g'|awk '{$2=null;print}'|sed 's/\ \ /\ /g'|sed 's/\ /\t/g' > merged_abundance_table_species.txt
grep -E '(g__)|(clade_name)' merged_abundance_table.txt |grep -v 's__'|sed 's/^.*g__//g'|awk '{$2=null;print}'|sed 's/\ \ /\ /g'|sed 's/\ /\t/g' > merged_abundance_table_genus.txt
grep -E '(f__)|(clade_name)' merged_abundance_table.txt |grep -v 'g__'|sed 's/^.*f__//g'|awk '{$2=null;print}'|sed 's/\ \ /\ /g'|sed 's/\ /\t/g' > merged_abundance_table_family.txt
grep -E '(o__)|(clade_name)' merged_abundance_table.txt |grep -v 'f__'|sed 's/^.*o__//g'|awk '{$2=null;print}'|sed 's/\ \ /\ /g'|sed 's/\ /\t/g' > merged_abundance_table_order.txt
grep -E '(c__)|(clade_name)' merged_abundance_table.txt |grep -v 'o__'|sed 's/^.*c__//g'|awk '{$2=null;print}'|sed 's/\ \ /\ /g'|sed 's/\ /\t/g' > merged_abundance_table_class.txt
grep -E '(p__)|(clade_name)' merged_abundance_table.txt |grep -v 'c__'|sed 's/^.*p__//g'|awk '{$2=null;print}'|sed 's/\ \ /\ /g'|sed 's/\ /\t/g' > merged_abundance_table_phylum.txt
