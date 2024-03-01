# with npy_length setting

### core dumped, but can run with --npy_length 32
CUDA_VISIBLE_DEVICES=0 ./DSDP_blind_docking/DSDP                \
--ligand ./testing/3m2t_ligand.pdbqt     \
--protein ./testing/3m2t_protein.pdbqt   \
--site_npy ./testing/3m2t_no.npy                                           \
--out ./testing/out/3m2t_no_out.pdbqt                                          \
--log ./testing/out/3m2t_no_out.log                                            \
--top_n 1 --exhaustiveness 384 --search_depth 40                \
--npy_length 64

### success
CUDA_VISIBLE_DEVICES=0 ./DSDP_blind_docking/DSDP                \
--ligand ./testing/3m2t_ligand.pdbqt     \
--protein ./testing/3m2t_protein.pdbqt   \
--site_npy ./testing/3m2t_yes.npy                                           \
--out ./testing/out/3m2t_yes_out.pdbqt                                          \
--log ./testing/out/3m2t_yes_out.log                                            \
--top_n 1 --exhaustiveness 384 --search_depth 40                \
--npy_length 64

# without npy_length setting, the original DSDP

### success
CUDA_VISIBLE_DEVICES=0 ./DSDP_blind_docking/DSDP_36                \
--ligand ./testing/3m2t_ligand.pdbqt     \
--protein ./testing/3m2t_protein.pdbqt   \
--site_npy ./testing/3m2t_no.npy                                     \
--out ./testing/out/3m2t_no_out_36.pdbqt                                  \
--log ./testing/out/3m2t_no_out_36.log                                    \
--top_n 1 --exhaustiveness 384 --search_depth 40


### success, but empty output file
CUDA_VISIBLE_DEVICES=0 ./DSDP_blind_docking/DSDP_36                \
--ligand ./testing/3m2t_ligand.pdbqt     \
--protein ./testing/3m2t_protein.pdbqt   \
--site_npy ./testing/3m2t_yes.npy                               \
--out ./testing/out/3m2t_yes_out_36.pdbqt                             \
--log ./testing/out/3m2t_yes_out_36.log                            \
--top_n 1 --exhaustiveness 384 --search_depth 40 