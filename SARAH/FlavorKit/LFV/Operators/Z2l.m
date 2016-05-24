(* Code automatically generated by 'PreSARAH' *) 
(* Expressions for amplitudes are obtained by FeynArts/FormCalc *) 
(* This file is supposed to be loaded and used by SARAH *) 
(* Created at 10:49 on 14.1.2016 *) 
 
 
Print["   ... ",Z2l]; 
NamesParticles =  {ChargedLepton, bar[ChargedLepton], Zboson}; 
 NamesOperators =  {OZ2lSL, OZ2lSR, OZ2lVL, OZ2lVR}; 
 NameProcess = Z2l; 
 
Generate[Z2l][file_]:=Block[{i,j,k}, 
 

 (* Creating all possible processes; extract information about involved masses/couplings *) 


(* ------------------------------- *)
(* {ChargedLepton, bar[ChargedLepton], Zboson} *)
(* ------------------------------- *)
 
GetInformtion2Fermion1BosonProcess[ChargedLepton,bar[ChargedLepton],Zboson,Z2l,file]; 
NeededMassesAll=Intersection[NeededMasses];
NeededCouplingsAll=Intersection[NeededCouplings];
WriteCodeObservablePreSARAH[Z2l][NeededMassesAll,NeededCouplingsAll,TreeContributions,WaveContributions,PenguinContributions,file]; 
NeededMassAllSaved[Z2l] = masses 
]; 

WriteCodeObservablePreSARAH[Z2l][masses_,couplings_,tree_,wave_,penguin_,file_] :=Block[{i,j,k,fermions,scalars}, 
 
NeededMassesAllSaved[Z2l] = masses; 
NeededCouplingsAllSaved[Z2l] = couplings; 
NeededCombinations[Z2l] = {{1, 2}, {1, 3}, {2, 3}}; 
Print["     writing SPheno code for ",Z2l]; 
MakeSubroutineTitle["CalculateZ2l",Flatten[{masses,couplings}],{"gt1","gt2","gt3","OnlySM"}, 
{"OZ2lSL", "OZ2lSR", "OZ2lVL", "OZ2lVR"},file]; 
WriteString[file,"! ---------------------------------------------------------------- \n"]; 
WriteString[file,"! Code based on automatically generated SARAH extensions by 'PreSARAH' \n"]; 
WriteString[file,"! Expressions for amplitudes are obtained by FeynArts/FormCalc \n"]; 
WriteString[file,"! Based on user input for process Z2l \n"]; 
WriteString[file,"! 'PreSARAH' output has been generated  at 10:49 on 14.1.2016 \n"]; 
WriteString[file,"! ---------------------------------------------------------------- \n \n"]; 
 
 
WriteString[file,"Implicit None \n"]; 
MakeVariableList[Flatten[{couplings,masses}],",Intent(in)",file];
WriteString[file,"Integer,Intent(in) :: gt1, gt2,gt3 \n"];
WriteString[file,"Integer :: gt4 \n"];
WriteString[file,"Logical, Intent(in) :: OnlySM \n"];
WriteString[file,"Integer :: iprop, i1, i2, i3, i4 \n"];
WriteString[file,"Real(dp) :: MassEx1,MassEx2,MassEx3,MassEx12,MassEx22,MassEx32 \n"];
WriteString[file,"Complex(dp), Intent(out) :: OZ2lSL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: OZ2lSR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: OZ2lVL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: OZ2lVR \n"]; 
WriteString[file,"Real(dp) ::  MP, MP2, IMP2, IMP, MFin, MFin2, IMFin, IMFin2, Finite  \n"];
WriteString[file,"Real(dp) ::  MS1, MS12, MS2, MS22, MF1, MF12, MF2, MF22, MV1, MV12, MV2, MV22  \n"];
WriteString[file,"Complex(dp) ::  chargefactor  \n"];
WriteString[file,"Complex(dp) ::  coup1L, coup1R, coup2L, coup2R, coup3L, coup3R, coup3, coup4L, coup4R \n\n"];

WriteString[file,"Complex(dp) ::  int1,int2,int3,int4,int5,int6,int7,int8 \n\n"];

WriteString[file,"Iname=Iname+1 \n"];
WriteString[file,"NameOfUnit(Iname)='CalculateZ2l' \n
"];
 
AddCalcSquaredMasses[masses,file]; 
(* Initaliziation *)
WriteString[file,"Finite=1._dp \n"];
WriteString[file,"MassEx1="<>SPhenoMass[ChargedLepton,gt1]<>"  \n"];
WriteString[file,"MassEx12="<>SPhenoMassSq[ChargedLepton,gt1]<>" \n"];
WriteString[file,"MassEx2="<>SPhenoMass[bar[ChargedLepton],gt2]<>"  \n"];
WriteString[file,"MassEx22="<>SPhenoMassSq[bar[ChargedLepton],gt2]<>" \n"];
WriteString[file,"MassEx3="<>SPhenoMass[Zboson,gt3]<>"  \n"];
WriteString[file,"MassEx32="<>SPhenoMassSq[Zboson,gt3]<>" \n"];
WriteString[file,"! ------------------------------ \n "];
WriteString[file,"! Amplitudes for external states \n "];
WriteString[file,"! {ChargedLepton, bar[ChargedLepton], Zboson} \n "];
WriteString[file,"! ------------------------------ \n \n"];
WriteString[sphenoTeX,"\\section{External states: $"<>TeXOutput[{ChargedLepton[{gt1}], bar[ChargedLepton][{gt2}], Zboson[{gt3}]}]<>"$} \n"];
WriteString[file,"OZ2lSL=0._dp \n"]; 
WriteString[file,"OZ2lSR=0._dp \n"]; 
WriteString[file,"OZ2lVL=0._dp \n"]; 
WriteString[file,"OZ2lVR=0._dp \n"]; 
WriteDiagramsObservable[Z2l,tree, wave, penguin, file];
WriteString[file,"OZ2lSL=oo16pi2*OZ2lSL \n"]; 
WriteString[file,"OZ2lSR=oo16pi2*OZ2lSR \n"]; 
WriteString[file,"OZ2lVL=oo16pi2*OZ2lVL \n"]; 
WriteString[file,"OZ2lVR=oo16pi2*OZ2lVR \n"]; 
WriteString[file,"Iname=Iname-1\n\n"]; 
WriteString[file,"End Subroutine CalculateZ2l \n\n"]; 
]; 
AddTreeResultPreSARAH[Z2l][top_,type_,file_]:=Block[{}, 

 (* This routine returns the generic expression for the amplitude of a given triangle diagram *) 
 
 Switch[top,  (* Check topology *) 
  1, 
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+ 157.91367041742973*coup1L\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["16 coup1L Pi^2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+ 157.91367041742973*coup1R\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["16 coup1R Pi^2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
]; 
]; 


AddPenguinResultPreSARAH[Z2l][top_,type_,file_]:=Block[{}, 

 (* This routine returns the generic expression for the amplitude of a given triangle diagram *) 
 
 Switch[top,  (* Check topology *) 
  1, 
  Switch[type,  (* Check the generic type of the diagram *) 
	SFF, 
	 	 WriteString[file,"  int1=B0(MassEx32, mF12, mF22)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx32, mF12, mF22)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=C0(MassEx32, 0._dp, 0._dp, mF22, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["C_0(MassEx32, 0, 0, mF22, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int3=Cget(\"C00 \",MassEx32, 0._dp, 0._dp, mF22, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_3= & "<> StringReplace["C_{00}(MassEx32, 0, 0, mF22, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int4=Cget(\"C1  \",MassEx32, 0._dp, 0._dp, mF22, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_4= & "<> StringReplace["C_1(MassEx32, 0, 0, mF22, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int5=Cget(\"C2  \",MassEx32, 0._dp, 0._dp, mF22, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_5= & "<> StringReplace["C_2(MassEx32, 0, 0, mF22, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+2.*chargefactor*coup1L*coup2L*(-1.*coup3L*int4*mF1 + coup3R*(int2 + int4 + int5)*mF2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["2 chargefactor coup1L coup2L (-(coup3L I_4 mF1) + coup3R (I_2 + I_4 + I_5) mF2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,2*coup1L*coup2L*(coup3R*mF2*cc0[MassEx32, 0, 0, mF22, mF12, mS12] + (-(coup3L*mF1) + coup3R*mF2)*cc1[MassEx32, 0, 0, mF22, mF12, mS12] + coup3R*mF2*cc2[MassEx32, 0, 0, mF22, mF12, mS12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+2.*chargefactor*coup1R*coup2R*(-1.*coup3R*int4*mF1 + coup3L*(int2 + int4 + int5)*mF2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["2 chargefactor coup1R coup2R (-(coup3R I_4 mF1) + coup3L (I_2 + I_4 + I_5) mF2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,2*coup1R*coup2R*(coup3L*mF2*cc0[MassEx32, 0, 0, mF22, mF12, mS12] + (-(coup3R*mF1) + coup3L*mF2)*cc1[MassEx32, 0, 0, mF22, mF12, mS12] + coup3L*mF2*cc2[MassEx32, 0, 0, mF22, mF12, mS12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+chargefactor*coup1L*coup2R*(coup3L*int2*mF1*mF2 - 1.*coup3R*(int1 - 2.*int3 + int2*mS12))\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["chargefactor coup1L coup2R (coup3L I_2 mF1 mF2 - coup3R (I_1 - 2 I_3 + I_2 mS12))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,coup1L*coup2R*(-(coup3R*bb0[MassEx32, mF12, mF22]) + (coup3L*mF1*mF2 - coup3R*mS12)*cc0[MassEx32, 0, 0, mF22, mF12, mS12] + 2*coup3R*cc00[MassEx32, 0, 0, mF22, mF12, mS12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+chargefactor*coup1R*coup2L*(coup3R*int2*mF1*mF2 - 1.*coup3L*(int1 - 2.*int3 + int2*mS12))\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["chargefactor coup1R coup2L (coup3R I_2 mF1 mF2 - coup3L (I_1 - 2 I_3 + I_2 mS12))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,coup1R*coup2L*(-(coup3L*bb0[MassEx32, mF12, mF22]) + (coup3R*mF1*mF2 - coup3L*mS12)*cc0[MassEx32, 0, 0, mF22, mF12, mS12] + 2*coup3L*cc00[MassEx32, 0, 0, mF22, mF12, mS12])} " ];
,
	FSS, 
	 	 WriteString[file,"  int1=C0(0._dp, MassEx32, 0._dp, mF12, mS22, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["C_0(0, MassEx32, 0, mF12, mS22, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=Cget(\"C00 \",0._dp, MassEx32, 0._dp, mF12, mS22, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["C_{00}(0, MassEx32, 0, mF12, mS22, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int3=Cget(\"C1  \",0._dp, MassEx32, 0._dp, mF12, mS22, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_3= & "<> StringReplace["C_1(0, MassEx32, 0, mF12, mS22, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int4=Cget(\"C2  \",0._dp, MassEx32, 0._dp, mF12, mS22, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_4= & "<> StringReplace["C_2(0, MassEx32, 0, mF12, mS22, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+-2.*chargefactor*coup1L*coup2L*coup3*(int1 + int3 + int4)*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["-2 chargefactor coup1L coup2L coup3 (I_1 + I_3 + I_4) mF1",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,-2*coup1L*coup2L*coup3*mF1*(cc0[0, MassEx32, 0, mF12, mS22, mS12] + cc1[0, MassEx32, 0, mF12, mS22, mS12] + cc2[0, MassEx32, 0, mF12, mS22, mS12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+-2.*chargefactor*coup1R*coup2R*coup3*(int1 + int3 + int4)*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["-2 chargefactor coup1R coup2R coup3 (I_1 + I_3 + I_4) mF1",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,-2*coup1R*coup2R*coup3*mF1*(cc0[0, MassEx32, 0, mF12, mS22, mS12] + cc1[0, MassEx32, 0, mF12, mS22, mS12] + cc2[0, MassEx32, 0, mF12, mS22, mS12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+-2.*chargefactor*coup1L*coup2R*coup3*int2\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["-2 chargefactor coup1L coup2R coup3 I_2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,-2*coup1L*coup2R*coup3*cc00[0, MassEx32, 0, mF12, mS22, mS12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+-2.*chargefactor*coup1R*coup2L*coup3*int2\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["-2 chargefactor coup1R coup2L coup3 I_2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,-2*coup1R*coup2L*coup3*cc00[0, MassEx32, 0, mF12, mS22, mS12]} " ];
,
	VFF, 
	 	 WriteString[file,"  int1=B0(MassEx32, mF12, mF22)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx32, mF12, mF22)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=C0(MassEx32, 0._dp, 0._dp, mF22, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["C_0(MassEx32, 0, 0, mF22, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int3=Cget(\"C00 \",MassEx32, 0._dp, 0._dp, mF22, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_3= & "<> StringReplace["C_{00}(MassEx32, 0, 0, mF22, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int4=Cget(\"C2  \",MassEx32, 0._dp, 0._dp, mF22, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_4= & "<> StringReplace["C_2(MassEx32, 0, 0, mF22, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+-4.*chargefactor*coup1L*coup2R*int4*(coup3R*mF1 + coup3L*mF2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["-4 chargefactor coup1L coup2R I_4 (coup3R mF1 + coup3L mF2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,-4*coup1L*coup2R*(coup3R*mF1 + coup3L*mF2)*cc2[MassEx32, 0, 0, mF22, mF12, mV12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+-4.*chargefactor*coup1R*coup2L*int4*(coup3L*mF1 + coup3R*mF2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["-4 chargefactor coup1R coup2L I_4 (coup3L mF1 + coup3R mF2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,-4*coup1R*coup2L*(coup3L*mF1 + coup3R*mF2)*cc2[MassEx32, 0, 0, mF22, mF12, mV12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+chargefactor*coup1L*coup2L*(2.*coup3R*int2*mF1*mF2 + coup3L*(Finite - 2.*(int1 - 2.*int3 + int2*mV12)))\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["chargefactor coup1L coup2L (2 coup3R I_2 mF1 mF2 + coup3L (1 - 2 (I_1 - 2 I_3 + I_2 mV12)))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,coup1L*coup2L*(-2*coup3L*bb0[MassEx32, mF12, mF22] + 2*(coup3R*mF1*mF2 - coup3L*mV12)*cc0[MassEx32, 0, 0, mF22, mF12, mV12] + coup3L*(Finite + 4*cc00[MassEx32, 0, 0, mF22, mF12, mV12]))}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+chargefactor*coup1R*coup2R*(2.*coup3L*int2*mF1*mF2 + coup3R*(Finite - 2.*(int1 - 2.*int3 + int2*mV12)))\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["chargefactor coup1R coup2R (2 coup3L I_2 mF1 mF2 + coup3R (1 - 2 (I_1 - 2 I_3 + I_2 mV12)))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,coup1R*coup2R*(-2*coup3R*bb0[MassEx32, mF12, mF22] + 2*(coup3L*mF1*mF2 - coup3R*mV12)*cc0[MassEx32, 0, 0, mF22, mF12, mV12] + coup3R*(Finite + 4*cc00[MassEx32, 0, 0, mF22, mF12, mV12]))} " ];
,
	FSV, 
	 	 WriteString[file,"  int1=C0(0._dp, MassEx32, 0._dp, mF12, mV22, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["C_0(0, MassEx32, 0, mF12, mV22, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=Cget(\"C1  \",0._dp, MassEx32, 0._dp, mF12, mV22, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["C_1(0, MassEx32, 0, mF12, mV22, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+-2.*chargefactor*coup1L*coup2R*coup3*int2\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["-2 chargefactor coup1L coup2R coup3 I_2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,-2*coup1L*coup2R*coup3*cc1[0, MassEx32, 0, mF12, mV22, mS12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+-2.*chargefactor*coup1R*coup2L*coup3*int2\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["-2 chargefactor coup1R coup2L coup3 I_2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,-2*coup1R*coup2L*coup3*cc1[0, MassEx32, 0, mF12, mV22, mS12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+-1.*chargefactor*coup1L*coup2L*coup3*int1*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["-(chargefactor coup1L coup2L coup3 I_1 mF1)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,-(coup1L*coup2L*coup3*mF1*cc0[0, MassEx32, 0, mF12, mV22, mS12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+-1.*chargefactor*coup1R*coup2R*coup3*int1*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["-(chargefactor coup1R coup2R coup3 I_1 mF1)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,-(coup1R*coup2R*coup3*mF1*cc0[0, MassEx32, 0, mF12, mV22, mS12])} " ];
,
	FVS, 
	 	 WriteString[file,"  int1=C0(0._dp, MassEx32, 0._dp, mF12, mS22, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["C_0(0, MassEx32, 0, mF12, mS22, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=Cget(\"C2  \",0._dp, MassEx32, 0._dp, mF12, mS22, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["C_2(0, MassEx32, 0, mF12, mS22, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+-2.*chargefactor*coup1L*coup2L*coup3*int2\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["-2 chargefactor coup1L coup2L coup3 I_2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,-2*coup1L*coup2L*coup3*cc2[0, MassEx32, 0, mF12, mS22, mV12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+-2.*chargefactor*coup1R*coup2R*coup3*int2\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["-2 chargefactor coup1R coup2R coup3 I_2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,-2*coup1R*coup2R*coup3*cc2[0, MassEx32, 0, mF12, mS22, mV12]}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+-1.*chargefactor*coup1L*coup2R*coup3*int1*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["-(chargefactor coup1L coup2R coup3 I_1 mF1)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,-(coup1L*coup2R*coup3*mF1*cc0[0, MassEx32, 0, mF12, mS22, mV12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+-1.*chargefactor*coup1R*coup2L*coup3*int1*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["-(chargefactor coup1R coup2L coup3 I_1 mF1)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,-(coup1R*coup2L*coup3*mF1*cc0[0, MassEx32, 0, mF12, mS22, mV12])} " ];
,
	FVV, 
	 	 WriteString[file,"  int1=B0(MassEx32, mV12, mV22)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx32, mV12, mV22)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=C0(0._dp, MassEx32, 0._dp, mF12, mV22, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["C_0(0, MassEx32, 0, mF12, mV22, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int3=Cget(\"C00 \",0._dp, MassEx32, 0._dp, mF12, mV22, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_3= & "<> StringReplace["C_{00}(0, MassEx32, 0, mF12, mV22, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int4=Cget(\"C1  \",0._dp, MassEx32, 0._dp, mF12, mV22, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_4= & "<> StringReplace["C_1(0, MassEx32, 0, mF12, mV22, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int5=Cget(\"C2  \",0._dp, MassEx32, 0._dp, mF12, mV22, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_5= & "<> StringReplace["C_2(0, MassEx32, 0, mF12, mV22, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+6.*chargefactor*coup1L*coup2R*coup3*(int4 + int5)*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["6 chargefactor coup1L coup2R coup3 (I_4 + I_5) mF1",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,6*coup1L*coup2R*coup3*mF1*(cc1[0, MassEx32, 0, mF12, mV22, mV12] + cc2[0, MassEx32, 0, mF12, mV22, mV12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+6.*chargefactor*coup1R*coup2L*coup3*(int4 + int5)*mF1\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["6 chargefactor coup1R coup2L coup3 (I_4 + I_5) mF1",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,6*coup1R*coup2L*coup3*mF1*(cc1[0, MassEx32, 0, mF12, mV22, mV12] + cc2[0, MassEx32, 0, mF12, mV22, mV12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+chargefactor*coup1L*coup2L*coup3*(Finite - 2.*(int1 + 2.*int3 + int2*mF12))\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["chargefactor coup1L coup2L coup3 (1 - 2 (I_1 + 2 I_3 + I_2 mF12))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,coup1L*coup2L*coup3*(Finite - 2*bb0[MassEx32, mV12, mV22] - 2*mF12*cc0[0, MassEx32, 0, mF12, mV22, mV12] - 4*cc00[0, MassEx32, 0, mF12, mV22, mV12])}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+chargefactor*coup1R*coup2R*coup3*(Finite - 2.*(int1 + 2.*int3 + int2*mF12))\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["chargefactor coup1R coup2R coup3 (1 - 2 (I_1 + 2 I_3 + I_2 mF12))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,coup1R*coup2R*coup3*(Finite - 2*bb0[MassEx32, mV12, mV22] - 2*mF12*cc0[0, MassEx32, 0, mF12, mV22, mV12] - 4*cc00[0, MassEx32, 0, mF12, mV22, mV12])} " ];
]; 
];]; 


AddWaveResultPreSARAH[Z2l][top_,type_,file_]:=Block[{}, 

 (* This routine returns the generic expression for the amplitude of a given triangle diagram *) 
 
 Switch[top,  (* Check topology *) 
  1, 
  Switch[type,  (* Check the generic type of the diagram *) 
	FS | SF , 
	 	 WriteString[file,"  int1=B0(MassEx12, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx12, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=B1(MassEx12, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["B_1(MassEx12, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+(chargefactor*coup3L*(-1.*coup1L*coup2R*int2*MassEx12 + coup1R*coup2R*int1*MassEx1*mF1 - 1.*coup1R*coup2L*int2*MassEx1*MFin + coup1L*coup2L*int1*mF1*MFin))/(MassEx12 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["(chargefactor coup3L (-(coup1L coup2R I_2 MassEx12) + coup1R coup2R I_1 MassEx1 mF1 - coup1R coup2L I_2 MassEx1 MFin + coup1L coup2L I_1 mF1 MFin))/(MassEx12 - MFin2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,(coup3L*(mF1*(coup1R*coup2R*MassEx1 + coup1L*coup2L*MFin)*bb0[MassEx12, mF12, mS12] - (coup1L*coup2R*MassEx12 + coup1R*coup2L*MassEx1*MFin)*bb1[MassEx12, mF12, mS12]))/(MassEx12 - MFin2)}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+(chargefactor*coup3R*(-1.*coup1R*coup2L*int2*MassEx12 + coup1L*coup2L*int1*MassEx1*mF1 - 1.*coup1L*coup2R*int2*MassEx1*MFin + coup1R*coup2R*int1*mF1*MFin))/(MassEx12 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["(chargefactor coup3R (-(coup1R coup2L I_2 MassEx12) + coup1L coup2L I_1 MassEx1 mF1 - coup1L coup2R I_2 MassEx1 MFin + coup1R coup2R I_1 mF1 MFin))/(MassEx12 - MFin2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,(coup3R*(mF1*(coup1L*coup2L*MassEx1 + coup1R*coup2R*MFin)*bb0[MassEx12, mF12, mS12] - (coup1R*coup2L*MassEx12 + coup1L*coup2R*MassEx1*MFin)*bb1[MassEx12, mF12, mS12]))/(MassEx12 - MFin2)} " ];
,
	FV | VF , 
	 	 WriteString[file,"  int1=B0(MassEx12, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx12, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=B1(MassEx12, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["B_1(MassEx12, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+(-1.*chargefactor*coup3L*(coup1R*MassEx1*(-2.*coup2L*(Finite - 2.*int1)*mF1 + coup2R*(Finite + 2.*int2)*MFin) + coup1L*(coup2L*(Finite + 2.*int2)*MassEx12 - 2.*coup2R*(Finite - 2.*int1)*mF1*MFin)))/(MassEx12 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["-((chargefactor coup3L (coup1R MassEx1 (-2 coup2L (1 - 2 I_1) mF1 + coup2R (1 + 2 I_2) MFin) + coup1L (coup2L (1 + 2 I_2) MassEx12 - 2 coup2R (1 - 2 I_1) mF1 MFin)))/(MassEx12 - MFin2))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,-((coup3L*(Finite*(coup1L*coup2L*MassEx12 - 2*coup1R*coup2L*MassEx1*mF1 + coup1R*coup2R*MassEx1*MFin - 2*coup1L*coup2R*mF1*MFin) + 4*mF1*(coup1R*coup2L*MassEx1 + coup1L*coup2R*MFin)*bb0[MassEx12, mF12, mV12] + 2*(coup1L*coup2L*MassEx12 + coup1R*coup2R*MassEx1*MFin)*bb1[MassEx12, mF12, mV12]))/(MassEx12 - MFin2))}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+(-1.*chargefactor*coup3R*(coup1L*MassEx1*(-2.*coup2R*(Finite - 2.*int1)*mF1 + coup2L*(Finite + 2.*int2)*MFin) + coup1R*(coup2R*(Finite + 2.*int2)*MassEx12 - 2.*coup2L*(Finite - 2.*int1)*mF1*MFin)))/(MassEx12 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["-((chargefactor coup3R (coup1L MassEx1 (-2 coup2R (1 - 2 I_1) mF1 + coup2L (1 + 2 I_2) MFin) + coup1R (coup2R (1 + 2 I_2) MassEx12 - 2 coup2L (1 - 2 I_1) mF1 MFin)))/(MassEx12 - MFin2))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,-((coup3R*(Finite*(coup1R*coup2R*MassEx12 - 2*coup1L*coup2R*MassEx1*mF1 + coup1L*coup2L*MassEx1*MFin - 2*coup1R*coup2L*mF1*MFin) + 4*mF1*(coup1L*coup2R*MassEx1 + coup1R*coup2L*MFin)*bb0[MassEx12, mF12, mV12] + 2*(coup1R*coup2R*MassEx12 + coup1L*coup2L*MassEx1*MFin)*bb1[MassEx12, mF12, mV12]))/(MassEx12 - MFin2))} " ];
]; 
,
  2, 
  Switch[type,  (* Check the generic type of the diagram *) 
	FS | SF , 
	 	 WriteString[file,"  int1=B0(MassEx22, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx22, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=B1(MassEx22, mF12, mS12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["B_1(MassEx22, mF12, mS12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+(chargefactor*coup3L*(-1.*coup1R*coup2L*int2*MassEx22 + coup1L*coup2L*int1*MassEx2*mF1 - 1.*coup1L*coup2R*int2*MassEx2*MFin + coup1R*coup2R*int1*mF1*MFin))/(MassEx22 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["(chargefactor coup3L (-(coup1R coup2L I_2 MassEx22) + coup1L coup2L I_1 MassEx2 mF1 - coup1L coup2R I_2 MassEx2 MFin + coup1R coup2R I_1 mF1 MFin))/(MassEx22 - MFin2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,(coup3L*(mF1*(coup1L*coup2L*MassEx2 + coup1R*coup2R*MFin)*bb0[MassEx22, mF12, mS12] - (coup1R*coup2L*MassEx22 + coup1L*coup2R*MassEx2*MFin)*bb1[MassEx22, mF12, mS12]))/(MassEx22 - MFin2)}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+(chargefactor*coup3R*(-1.*coup1L*coup2R*int2*MassEx22 + coup1R*coup2R*int1*MassEx2*mF1 - 1.*coup1R*coup2L*int2*MassEx2*MFin + coup1L*coup2L*int1*mF1*MFin))/(MassEx22 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["(chargefactor coup3R (-(coup1L coup2R I_2 MassEx22) + coup1R coup2R I_1 MassEx2 mF1 - coup1R coup2L I_2 MassEx2 MFin + coup1L coup2L I_1 mF1 MFin))/(MassEx22 - MFin2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,(coup3R*(mF1*(coup1R*coup2R*MassEx2 + coup1L*coup2L*MFin)*bb0[MassEx22, mF12, mS12] - (coup1L*coup2R*MassEx22 + coup1R*coup2L*MassEx2*MFin)*bb1[MassEx22, mF12, mS12]))/(MassEx22 - MFin2)} " ];
,
	FV | VF , 
	 	 WriteString[file,"  int1=B0(MassEx22, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_1= & "<> StringReplace["B_0(MassEx22, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteString[file,"  int2=B1(MassEx22, mF12, mV12)\n" ];
	 	 WriteString[sphenoTeX,"I_2= & "<> StringReplace["B_1(MassEx22, mF12, mV12)",SA`SPhenoTeXSub]<>" \\\\ \n"];
	 	 WriteStringFLB[file,"  OZ2lSL=OZ2lSL+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSL,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lSR=OZ2lSR+0.\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lSR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lSR,0}, " ];
	 	 WriteStringFLB[file,"  OZ2lVL=OZ2lVL+(-1.*chargefactor*coup3L*(coup1R*MassEx2*(-2.*coup2L*(Finite - 2.*int1)*mF1 + coup2R*(Finite + 2.*int2)*MFin) + coup1L*(coup2L*(Finite + 2.*int2)*MassEx22 - 2.*coup2R*(Finite - 2.*int1)*mF1*MFin)))/(MassEx22 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVL= & "<> StringReplace["-((chargefactor coup3L (coup1R MassEx2 (-2 coup2L (1 - 2 I_1) mF1 + coup2R (1 + 2 I_2) MFin) + coup1L (coup2L (1 + 2 I_2) MassEx22 - 2 coup2R (1 - 2 I_1) mF1 MFin)))/(MassEx22 - MFin2))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVL,-((coup3L*(Finite*(coup1L*coup2L*MassEx22 - 2*coup1R*coup2L*MassEx2*mF1 + coup1R*coup2R*MassEx2*MFin - 2*coup1L*coup2R*mF1*MFin) + 4*mF1*(coup1R*coup2L*MassEx2 + coup1L*coup2R*MFin)*bb0[MassEx22, mF12, mV12] + 2*(coup1L*coup2L*MassEx22 + coup1R*coup2R*MassEx2*MFin)*bb1[MassEx22, mF12, mV12]))/(MassEx22 - MFin2))}, " ];
	 	 WriteStringFLB[file,"  OZ2lVR=OZ2lVR+(-1.*chargefactor*coup3R*(coup1L*MassEx2*(-2.*coup2R*(Finite - 2.*int1)*mF1 + coup2L*(Finite + 2.*int2)*MFin) + coup1R*(coup2R*(Finite + 2.*int2)*MassEx22 - 2.*coup2L*(Finite - 2.*int1)*mF1*MFin)))/(MassEx22 - 1.*MFin2)\n" ];
	 	 WriteString[sphenoTeX,"  OZ2lVR= & "<> StringReplace["-((chargefactor coup3R (coup1L MassEx2 (-2 coup2R (1 - 2 I_1) mF1 + coup2L (1 + 2 I_2) MFin) + coup1R (coup2R (1 + 2 I_2) MassEx22 - 2 coup2L (1 - 2 I_1) mF1 MFin)))/(MassEx22 - MFin2))",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {OZ2lVR,-((coup3R*(Finite*(coup1R*coup2R*MassEx22 - 2*coup1L*coup2R*MassEx2*mF1 + coup1L*coup2L*MassEx2*MFin - 2*coup1R*coup2L*mF1*MFin) + 4*mF1*(coup1L*coup2R*MassEx2 + coup1R*coup2L*MFin)*bb0[MassEx22, mF12, mV12] + 2*(coup1R*coup2R*MassEx22 + coup1L*coup2L*MassEx2*MFin)*bb1[MassEx22, mF12, mV12]))/(MassEx22 - MFin2))} " ];
]; 
];]; 

