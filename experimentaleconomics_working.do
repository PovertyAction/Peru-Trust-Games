clear
set mem 100m
set matsize 800
set more off
use usingexperimentaleconomics.karlan.aer.dta

log using analyzetrust.aer.final.log, replace

*****TABLE 1 TRUST GAME RESULTS
***Basic Reusults
tab j2recib if j2a==0
tab j2return if j2a==0

***Player B's reciprocity
tab j2recib j2return if j2a==0, row

*****TABLE 2 SUMMARY STATS
ci j2samebc Ncult_cu_al_p j2both5 j2both1 j2Popp1 j2Popp5 j2cul5 j2cul1 if nocult==0 & (j2a~=.)
ci Ndist_cu_al2 j2Pw100 Ndistw100_cu_al_p if nodist==0 & (j1action~=. | j2a~=.)
ci r_ef_soc men_sum j2consc2 j2agedifabs edhi j2age j2age2 if j1action~=. | j2a~=.
ci j2samsig j2fiestaboth rel_ultd rel_no rel_bigig if  Mrelig==3 & (j1action~=. | j2a~=.)
ci simul_calc Cdescmax Cdropbad Cahovolsum if j1action~=. | j2a~=.

*****Table 3
**THE REAL ONE, MULTIVARIATE (col 1&2)
for Y in num 1/0: xi: regress j2dadoN j2recib SGSS_b SGSS_g simul_calc Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum j2samebc j2both5 j2both1 j2Popp1 j2Popp5 j2Pw100 j2samsig j2consc2 j2fiestaboth j2agedifabs edhi j2lnage j2cul5 j2cul1 rel_ultd rel_no rel_bigig nodist noPdist j2Enoage nocult rel_mis nor_ef nomen_sum if j2a==Y, cluster(BCCode) 

**NOW DO PARTNER CHARACTERISTICS ON ACTION (col 3-5)
for Z in any j2P: xi: regress j2dadoN ZSGSS_b ZSGSS_g Zsimul_calc ZNcult_cu_al_p ZNdist_cu_al ZNdistw100_cu_al_p Zr_ef_soc Zmen_sum Zedhi Zj2lnage Zj2cul5 Zj2cul1 Zrel_ultd Zrel_no Zrel_bigig Znodist Zj2Enoage Znocult Zrel_mis Znor_ef Znomen_sum noj2Pcultdist if j2a==1, cluster(BCCode) 
for Z in any j2P: xi: regress j2dadoNpos ZSGSS_b ZSGSS_g Zsimul_calc ZNcult_cu_al_p ZNdist_cu_al ZNdistw100_cu_al_p Zr_ef_soc Zmen_sum Zedhi Zj2lnage Zj2cul5 Zj2cul1 Zrel_ultd Zrel_no Zrel_bigig Znodist Zj2Enoage Znocult Zrel_mis Znor_ef Znomen_sum noj2Pcultdist if j2a==1, cluster(BCCode) 
for Z in any j2P: xi: regress j2dadoN ZSGSS_b ZSGSS_g Zsimul_calc ZNcult_cu_al_p ZNdist_cu_al ZNdistw100_cu_al_p Zr_ef_soc Zmen_sum Zedhi Zj2lnage Zj2cul5 Zj2cul1 Zrel_ultd Zrel_no Zrel_bigig Znodist Zj2Enoage Znocult Zrel_mis Znor_ef Znomen_sum noj2Pcultdist if j2a==0, cluster(BCCode) 

*PUBLIC GOODS GAME (col6&7)
xi: regress j1action j2dadoN_incmis cul01 cul5678 misj2 Dsumm3_b Dsumm3_g simul_calc Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum edhi lnage rel_ultd rel_no rel_bigig nodist noherms nocult rel_mis noage nor_ef nomen_sum, cluster(BCCode) 
regress j1PCont Gj1j2dadoN Gj1Dsumm3_bg Gj1simul_calc NGj1cult_cu_al_pjune2004 NGj1dist_cu_aljune2004 if onebank==1, robust

*****TABLE 4
***Panel A&B
*WITHOUT CONTROLS
foreach Z in "regress Cdescmax" "dprobit Cdropbad" "regress Cahovolsum" {
	for Y in num 1/0: `Z' j2dadoN if j2a==Y, cluster(BCCode) 
	}
*WITH CONTROLS
foreach Z in "regress Cdescmax" "dprobit Cdropbad" "regress Cahovolsum" {
	for Y in num 1/0: `Z' j2dadoN j2dadoN j2dadoN_j2samebc j2recib SGSS_g SGSS_b simul_calc  Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum j2samebc j2both5 j2both1 j2Popp1 j2Popp5 j2Pw100 j2samsig j2consc2 j2fiestaboth j2agedifabs edhi j2age j2age2 j2cul5 j2cul1 rel_ultd rel_no rel_bigig nodist noPdist j2Enoage rel_mis nocultrefmen if j2a==Y, cluster(BCCode) 
}
foreach Z in "regress Cdescmax" "dprobit Cdropbad" "regress Cahovolsum" {
	for Y in num 1/0: `Z' j2dadoN j2recib SGSS_g SGSS_b simul_calc Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum j2samebc j2both5 j2both1 j2Popp1 j2Popp5 j2Pw100 j2samsig j2consc2 j2fiestaboth j2agedifabs edhi j2lnage j2cul5 j2cul1 rel_ultd rel_no rel_bigig nodist noPdist j2Enoage rel_mis nocultrefmen if j2a==Y, cluster(BCCode)
}


*Panel C, D&E: TABLE 4 PUBLIC GOODS + GSS
foreach Z in "regress Cdescmax" "dprobit Cdropbad" "regress Cahovolsum" {
	`Z' j1action , cluster(BCCode)
	`Z' j1action j2dadoN_incmis misj2 Dsumm3_b Dsumm3_g simul_calc Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum edhi age age2 cul01 cul5678 rel_ultd rel_no rel_bigig nodist noherms nocult rel_mis, cluster(BCCode)  
	`Z' SGSS_g , cluster(BCCode) 
	`Z' SGSS_g j2dadoN_incmis misj2 simul_calc Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum edhi age age2 cul01 cul5678 rel_ultd rel_no rel_bigig nodist noherms nocult rel_mis noage_nor_ef_mensum , cluster(BCCode) 
	`Z' SGSS_b , cluster(BCCode) 
	`Z' SGSS_b j2dadoN_incmis misj2 simul_calc Ncult_cu_al_p Ndist_cu_al Ndistw100_cu_al_p r_ef_soc men_sum edhi age age2 cul01 cul5678 rel_ultd rel_no rel_bigig nodist noherms nocult rel_mis noage_nor_ef_mensum , cluster(BCCode)
}


log close

exit
