mkdir ../training
pypy ../dataPrepScripts/ExtractVariantCandidates.py --bam_fn ../testingData/chr21/chr21.bam --ref_fn ../testingData/chr21/chr21.fa --can_fn ../training/can_chr21 --ctgName chr21 --ctgStart 10269870 --ctgEnd 46672937 &
pypy ../dataPrepScripts/GetTruth.py --vcf_fn ../testingData/chr21/chr21.vcf --var_fn ../training/var_chr21 --ctgName chr21 &
pypy ../dataPrepScripts/ExtractVariantCandidates.py --bam_fn ../testingData/chr22/chr22.bam --ref_fn ../testingData/chr22/chr22.fa --can_fn ../training/can_chr22 --ctgName chr22 --ctgStart 18924717 --ctgEnd 49973797 &
pypy ../dataPrepScripts/GetTruth.py --vcf_fn ../testingData/chr22/chr22.vcf --var_fn ../training/var_chr22 --ctgName chr22 &
wait

pypy ../dataPrepScripts/CreateTensor.py --bam_fn ../testingData/chr21/chr21.bam --can_fn ../training/can_chr21 --ref_fn ../testingData/chr21/chr21.fa --tensor_fn ../training/tensor_can_chr21 --ctgName chr21 --ctgStart 10269870 --ctgEnd 46672937 &
pypy ../dataPrepScripts/CreateTensor.py --bam_fn ../testingData/chr22/chr22.bam --can_fn ../training/can_chr22 --ref_fn ../testingData/chr22/chr22.fa --tensor_fn ../training/tensor_can_chr22 --ctgName chr22 --ctgStart 18924717 --ctgEnd 49973797 &
wait

cat ../training/can_chr21 ../training/can_chr22 > ../training/can_mul
cat ../training/var_chr21 ../training/var_chr22 > ../training/var_mul
cat ../training/tensor_can_chr21 ../training/tensor_can_chr22 > ../training/tensor_can_mul
cat ../testingData/chr21/chr21.bed ../testingData/chr22/chr22.bed > ../training/bed
python ../clairvoyante/tensor2Bin.py --tensor_fn ../training/tensor_can_mul --var_fn ../training/var_mul --bed_fn ../training/bed --bin_fn ../training/tensor.bin