(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



MakeParameterScans:=Block[{i,j,k},
If[DirectoryQ[SSP`RunningDir]==False,CreateDirectory[SSP`RunningDir]];
For[i=1,i<=Length[RunScans],
SSP`ScanData={};
Print["Starting parameter scan ", RunScans[[i]]];
If[Head[LoadSettings]=== String&& LoadSetting=!="",
If[FileExistsQ[ToFileName[SSP`Dir,LoadSettings]]===False,
SettingsFile::NotExisiting="The file `` for loading the setting does not exist. Please, locate that file in the root directory of SSP.";
Message[SettingsFile::NotExisiting,LoadSettings];
Interrupt[];,
Get[ToFileName[SSP`Dir,LoadSettings]];
];,
SettingsFile::NotDefined="No file for the setting defined. Please, locate a file in the root directory of SSP to define the location of the different programs and load it in the input file using LoadSettings=[Filename].";
Message[SettingsFile::NotDefined];
Interrupt[];
];

If[Head[DEFINITION[RunScans[[i]]][OutputDirectory]]=!=String,
DEFINITION[RunScans[[i]]][OutputDirectory]=ToString[RunScans[[i]]];
];

SSP`CurrentOutputDir=ToFileName[SSP`OutputDir,DEFINITION[RunScans[[i]]][OutputDirectory]];
If[DirectoryQ[SSP`CurrentOutputDir]==False,CreateDirectory[SSP`CurrentOutputDir]];

StartScan[RunScans[[i]]];
SetDirectory[SSP`CurrentOutputDir];

If[SSP`totalnumber>1,
If[FileExistsQ[SSP`CurrentSPCFile],
Print["Reading all spectrum files"];
If[Head[DEFINITION[RunScans[[i]]][ShortDataM]]=!=Symbol,DEFINITION[RunScans[[i]]][ShortDataM]=False;];
If[NumericQ[DEFINITION[RunScans[[i]]][SignificantDigits]]===False,DEFINITION[RunScans[[i]]][SignificantDigits]=MachinePrecision;];
If[NumericQ[DEFINITION[RunScans[[i]]][Chop]]===False,DEFINITION[RunScans[[i]]][Chop]=0;];
If[DEFINITION[RunScans[[i]]][MCMC]=!=True,
ReadSpectrumFileFunc[SSP`CurrentSPCFile,"ENDOFPARAMETERFILE",DEFINITION[RunScans[[i]]][ShortDataM],DEFINITION[RunScans[[i]]][SaveBlocks],None,DEFINITION[RunScans[[i]]][SignificantDigits],DEFINITION[RunScans[[i]]][Chop]];,
ReadSpectrumFileFunc[SSP`CurrentSPCFileMCMC,"ENDOFPARAMETERFILE",DEFINITION[RunScans[[i]]][ShortDataM],DEFINITION[RunScans[[i]]][SaveBlocks],None,DEFINITION[RunScans[[i]]][SignificantDigits],DEFINITION[RunScans[[i]]][Chop]];
];
SSP`ScanData=AllLesHouchesInput;,
Print["No valid parameter point found during scan"];
];
];

If[FileExistsQ[SSP`CurrentSPCFile],
Put[SSP`ScanData,DEFINITION[RunScans[[i]]][OutputFile]];
MakePlots[RunScans[[i]]];
];


Print[""];
Print["  finished! "];



Print["-----------------------------------------------"];
i++;];

SetDirectory[SSP`RunningDir];
Run["rm *"];
DeleteDirectory[SSP`RunningDir];

];


StartScan[name_]:=Block[{i,j,scandata={},percent,mod,next=1,stpwidth,scaleFactor},
CheckOfDirectories[name];
AllPoints=GeneratePoints[name];

SSP`totalnumber=Length[AllPoints];
If[SSP`totalnumber>=1000,
stpwidth = Length[AllPoints]/100;,
stpwidth = Length[AllPoints]/10;
];

SetLocalDefinitions[name];

If[DEFINITION[name][MCMC]===True,
StartMCMC[name];,

For[i=1,i<=Length[AllPoints],
SSP`CurrentPointNumber=i;
If[i>next*stpwidth && stpwidth >=1, Print["       ",100.i/SSP`totalnumber,"% done"];next++];
If[DEFINITION[name][MakeCountourScan]===True,
PerformContourScan[name,AllPoints[[i]],i];,

If[Head[DEFINITION[name][FitValues]]===List,
bestfit=PerformFitToValues[name,AllPoints[[i]],i];
RunAll[name,AllPoints[[i]]//.bestfit,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],True];,
RunAll[name,AllPoints[[i]],DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],True];
];
];
i++;];
];
];


GeneratePoints[name_]:=Block[{i,j,k,minpar,extpar,scales,temp,temp2,minTemp,extTemp,blocks},
BlockList=Table[{},{Length[DEFINITION[name][Blocks]]}];
blocks=DEFINITION[name][Blocks];

 For[i=1,i<=Length[BlockList],
If[DEFINITION[name][ScatterPlot]===True,
BlockList[[i]]=CreateValueList[DEFINITION[name][blocks[[i]]],True,DEFINITION[name][ScatterPoints]];,
BlockList[[i]]=CreateValueList[DEFINITION[name][blocks[[i]]],False,1];
];

If[DEFINITION[name][ScatterPlot]===True,
BlockList[[i]]=CreateAllCombination2[BlockList[[i]],blocks[[i]]];,
BlockList[[i]]=CreateAllCombination[BlockList[[i]],blocks[[i]]];
];
i++;];



If[DEFINITION[name][ScatterPlot]===True,
AllPoints=CreatePoints2[BlockList];,
If[DEFINIITION[name][ExternalPoints]===True,
AllPoints=CreatePointsExternal[BlockList,name];,
AllPoints=CreatePoints[BlockList];
];
];

If[DEFINITION[name][MCMC]=!=True,
Print["   total number of parameter points: ",Length[AllPoints]];
];
Return[AllPoints];


];


CreateValueList[list_,scatter_,spoints_]:=Block[{i,j,temp},
temp = Table[{},{Length[list]}];
For[i=1,i<=Length[list],
If[scatter,
If[FreeQ[list[[i,2]],Min],
temp[[i]]=Table[{list[[i,1]], (Value /. list[[i,2]])},{j,1,spoints}];,
temp[[i]]=Table[{list[[i,1]],1. (Min /. list[[i,2]])+((Max-Min) /. list[[i,2]])Random[]},{j,1,spoints}];
];,
Switch[Distribution /. list[[i,2]] /. {Distribution->FIXED},
USERDEFINED,
	temp[[i]]=Tuples[{{list[[i,1]]},Values/.list[[i,2]]}];,
FIXED,
	temp[[i]]= {{list[[i,1]],Value  /. list[[i,2]]}};,
LINEAR,
	temp[[i]]=Table[{list[[i,1]],1. (Min /. list[[i,2]])+((Max-Min) /. list[[i,2]])/((Steps-1) /. list[[i,2]])(j-1)},{j,1,(Steps /. list[[i,2]])}];,
LOG,
temp[[i]]=Table[{list[[i,1]],1. 10^((Log[10,Min]/.list[[i,2]])+(((Log[10,(Max)]-Log[10,(Min)])/.list[[i,2]])/((Steps-1)/.list[[i,2]]) (j-1)))},{j,1,(Steps/.list[[i,2]])}];,
RANDOM,
	temp[[i]]=Table[{list[[i,1]],1. (Min /. list[[i,2]])+((Max-Min) /. list[[i,2]])Random[]},{j,1,(Steps /. list[[i,2]])}];
	];
];
i++;];
Return[temp];
];

CreateAllCombination[list_,blockname_]:=Block[{i,j,k,temp,temp2},
points=Table[{list[[1,i]]},{i,1,Length[list[[1]]]}];
For[k=2,k<=Length[list],
temp=Flatten[Table[Join[points[[j]],{list[[k,i]]}],{j,1,Length[points]},{i,1,Length[list[[k]]]}],1];
points=temp;
k++;];
temp2=Table[{blockname,points[[i]]},{i,1,Length[points]}];
Return[temp2];];

CreateAllCombinationExternal[list_,blockname_]:=Block[{i,j,k,temp,temp2},
points=Table[{list[[1,i]]},{i,1,Length[list[[1]]]}];
For[k=2,k<=Length[list],
temp=Flatten[Table[Join[points[[j]],{list[[k,i]]}],{j,1,Length[points]},{i,1,Length[list[[k]]]}],1];
points=temp;
k++;];
temp2=Table[{blockname,points[[i]]},{i,1,Length[points]}];

temp={};
For[k=1,k<=Length[SSP`SubNumericalValues],
temp = Join[temp,{temp2[[1]] /. SSP`SubNumericalValues[[k]]}];
k++;];

Return[temp];
];

CreateAllCombination2[list_,blockname_]:=Block[{i,j,k,temp,temp2},
points=Table[{list[[1,i]]},{i,1,Length[list[[1]]]}];
For[k=2,k<=Length[list],
If[Length[points]==Length[list[[k]]],
temp=Table[Join[points[[i]],{list[[k,i]]}],{i,1,Length[list[[k]]]}];,
If[Length[points]==1,
temp=Table[Join[points,list[[k,i]]],{i,1,Length[list[[k]]]}];,
temp=Table[Join[points[[i]],list[[k]]],{i,1,Length[points]}];
];
];
points=temp;
k++;];
temp2=Table[{blockname,points[[i]]},{i,1,Length[points]}];
Return[temp2];];


CreatePoints[list_]:=Block[{i,j,k,temp,temp2},
points =Table[{list[[1,i]]},{i,1,Length[list[[1]]]}];

For[k=2,k<=Length[list],
temp=Table[Join[points[[j]],{list[[k,i]]}],{j,1,Length[points]},{i,1,Length[list[[k]]]}];
points=Flatten[temp,1];
k++;];

Return[points];
];

CreatePointsExternal[list_,name_]:=Block[{i,j,k,temp,temp2},
ReadSpectrumFile[DEFINIITION[name][FileExternalPoints],"ENDOFPARAMETERFILE"];
SSP`SubNumericalValues=MakeSubNum/@AllLesHouchesInput;
points =Table[{list[[1,i]]},{i,1,Length[list[[1]]]}];

For[k=2,k<=Length[list],
temp=Table[Join[points[[j]],{list[[k,i]]}],{j,1,Length[points]},{i,1,Length[list[[k]]]}];
points=Flatten[temp,1];
k++;];

temp={};
For[k=1,k<Length[SSP`SubNumericalValues],
temp=Join[temp,{points[[1]] /. SSP`SubNumericalValues[[k]]}];
k++;];
Return[temp];
];


CreatePoints2[list_]:=Block[{i,j,k,temp,temp2},
points =Table[{list[[1,i]]},{i,1,Length[list[[1]]]}];

For[k=2,k<=Length[list],
If[Length[points]==Length[list[[k]]],
temp=Table[Join[points[[i]],{list[[k,i]]}],{i,1,Length[list[[k]]]}];,
If[Length[points]==1,
temp=Table[Join[points[[1]],{list[[k,i]]}],{i,1,Length[list[[k]]]}];,
temp=Table[Join[points[[i]],{list[[k,1]]}],{i,1,Length[points]}];
];
];
points=temp;
k++;];

Return[points];
];


RunSPheno[point_,lhin_,bin_]:=Block[{},
WriteLH[point //. MakeSubNum2[point],lhin];
If[Head[MaximalTimeSPheno]===Integer,
Run["./timeoutSSP -t "<>ToString[MaximalTimeSPheno]<>" "<>bin <>" >> SPhenoScreen.out"];,
Run[bin <>" >> SPhenoScreen.out"];
];

];

RunAll[name_,point_,dir_,bin_,spc_,lhin_,save_]:=Block[{n,i,j,k,savepoint,comment},
(* SetDirectory[dir]; *)
SetDirectory[SSP`RunningDir];
RunSPheno[point,lhin,bin];
If[FileExistsQ[spc],
ReadSpectrumFile[spc,False];
SSP`SuccessfullRun=True;

If[DEFINITION[name][IncludeHiggsBounds]==True,
RunHiggsBounds[name];
Run["echo \"Block HIGGSBOUNDS  # Output of HiggsBounds \" >> "<>SSP`RunningDir<>"/"<>spc ];
For[n=2,n<=Length[SSP`HB],
If[n<= ((Length[SSP`HB])-4),
comment="HB Mass "<>ToString[n-1];,
Switch[n-((Length[SSP`HB])-4),
1,comment="HB Result (1: allowed, 0: excluded, -1: unphysical)";,
2,comment="HB most sensitive channel ";,
3,comment="HB ratio [sig x BR]_model/[sig x BR]_limit (<1: allowed, >1: excluded)";,
4,comment="HB number of Higgs bosons combined in most sensitive channel";
];
];
Run["echo \" "<>ToString[SSP`HB[[n,1]]]<>"  "<>ToString[FortranForm[SSP`HB[[n,2]]]]<>"   # "<>comment<>"\" >> "<>SSP`RunningDir<>"/"<>spc ];
n++;];
LesHouchesInput=Join[LesHouchesInput,{SSP`HB}];
];

If[DEFINITION[name][IncludeHiggsSignals]==True,
RunHiggsSignals[name];
Run["echo \"Block HIGGSSIGNALS  # Output of HiggsSignals \" >> "<>SSP`RunningDir<>"/"<>spc ];
For[n=2,n<=Length[SSP`HS],
If[n<= ((Length[SSP`HS])-7),
comment="HS Mass "<>ToString[n-1];,
Switch[n-((Length[SSP`HS])-7),
1,comment="HS Chi^2 from the signal strengths observables";,
2,comment="HS Chi^2 from the Higgs mass observables";,
3,comment="HS total Chi^2";,
4,comment="HS number of signal strength observables";,
5,comment="HS number of Higgs mass observables";,
6,comment="HS total number of observables";,
7,comment="HS P-value";
];
];
Run["echo \" "<>ToString[SSP`HS[[n,1]]]<>"  "<>ToString[FortranForm[SSP`HS[[n,2]]]]<>"   # "<>comment<>"\" >> "<>SSP`RunningDir<>"/"<>spc ];
n++;];
LesHouchesInput=Join[LesHouchesInput,{SSP`HS}];
];

If[DEFINITION[name][IncludeMicrOmegas]==True,
(* If[FindValue["LSP",1,LesHouchesInput,1]===DEFINITION[name][DarkMatterCandidate] || DEFINITION[name][DarkMatterCandidate]===ALL, *)
If[(FreeQ[DEFINITION[name][DarkMatterCandidate],FindValue["LSP",1,LesHouchesInput,1]]==False) || DEFINITION[name][DarkMatterCandidate]===ALL,
RunMicrOmegas[name,spc];
LesHouchesInput=Join[LesHouchesInput,{SSP`Omega}];
Run["echo \"Block DARKMATTER  # MicrOmegas results \" >> "<>SSP`RunningDir<>"/"<>spc ];
For[n=2,n<=Length[SSP`Omega],
Run["echo \" "<>ToString[SSP`OmegaWC[[n,1]]]<>"  "<>ToString[FortranForm[SSP`OmegaWC[[n,2]]]]<>"  "<>SSP`OmegaWC[[n,3]]<>"\" >> "<>SSP`RunningDir<>"/"<>spc ];
n++;]; 
If[Head[SSP`OmegaChannels]===List && SSP`OmegaChannels=!={},
Run["echo \"Block DMCHANNELS  # main annihilation channels \" >> "<>SSP`RunningDir<>"/"<>spc ];
For[n=2,n<=Length[SSP`OmegaChannels],
Run["echo \" "<>ToString[SSP`OmegaChannels[[n,1]]]<>"  "<>ToString[SSP`OmegaChannels[[n,2]]]<>"  "<>ToString[SSP`OmegaChannels[[n,3]]]<>"  "<>ToString[SSP`OmegaChannels[[n,4]]]<>"  "<>ToString[FortranForm[SSP`OmegaChannels[[n,5]]]]<>"  "<>SSP`OmegaChannels[[n,6]]<>"\" >> "<>SSP`RunningDir<>"/"<>spc ];
n++;]; 
];,
LesHouchesInput=Join[LesHouchesInput,{{"DARKMATTER",{1,-1}}}];
Run["echo \"Block DARKMATTER  # MicrOmegas results \" >> "<>SSP`RunningDir<>"/"<>spc ];
Run["echo \"1  -1 # Wrong LSP\" >> "<>SSP`RunningDir<>"/"<>spc ];
];
];

If[DEFINITION[name][IncludeCalcHep]==True,
SSP`CHep={"CHEP"};
For[k=1,k<=Length[DEFINITION[name][CalcHepRuns]],
RunCalcHep[DEFINITION[name][CalcHepRuns][[k]],k,spc,name];
k++;];
Run["echo \"Block CHEP  # CalcHep results \" >> "<>SSP`RunningDir<>"/"<>spc ];
For[n=2,n<=Length[SSP`CHep],
Run["echo \" "<>ToString[SSP`CHep[[n,1]]]<>"  "<>ToString[FortranForm[SSP`CHep[[n,2]]]]<>"   # \" >> "<>SSP`RunningDir<>"/"<>spc ];
n++;];
LesHouchesInput=Join[LesHouchesInput,{SSP`CHep}];
];

If[DEFINITION[name][IncludeWHIZARD]==True,
For[w=1,w<=Length[DEFINITION[name][WHIZARDruns]],
SSP`CurrentOutputDirWHIZARD=ToFileName[{SSP`CurrentOutputDir,"WHIZARD_point_"<>ToString[SSP`CurrentPointNumber]<>"_"<>ToString[w]}];
CreateDirectory[SSP`CurrentOutputDirWHIZARD];
RunWHIZARD[name,DEFINITION[name][WHIZARDruns][[w]],SSP`CurrentOutputDirWHIZARD];
w++;];
];

If[DEFINITION[name][IncludeMadGraph]==True,
For[w=1,w<=Length[DEFINITION[name][MadGraphRuns]],
SSP`CurrentOutputDirMG=ToFileName[{SSP`CurrentOutputDir,"MG_point_"<>ToString[SSP`CurrentPointNumber]<>"_"<>ToString[w]}];
CreateDirectory[SSP`CurrentOutputDirMG];
RunMG[name,DEFINITION[name][MadGraphRuns][[w,1]],DEFINITION[name][MadGraphRuns][[w,2]],SSP`CurrentOutputDirMG];
w++;];
];

If[DEFINITION[name][IncludeVevacious]==True,
RunVevacious[name];
];

If[Head[DEFINITION[name][FitValues]]===List || DEFINITION[name][MakeCountourScan]===True,
Run["cat "<>SSP`RunningDir<>"/"<>spc <>"  >> "<>SSP`CurrentSPCFileAll  ];
Run["echo \"ENDOFPARAMETERFILE\"  >> "<>SSP`CurrentSPCFileAll  ];
];

If[save==True&&DEFINITION[name][UseCheckSavingPoints]=!=True,
savepoint=True;,
If[save==True,
savepoint=DEFINITION[name][CheckSavingPoints][MakeSubNum[LesHouchesInput]];,
savepoint=False;
];
];

If[savepoint==True,
Run["cat "<>SSP`RunningDir<>"/"<>spc <>"  >> "<>SSP`CurrentSPCFile  ]; 
Run["echo \"ENDOFPARAMETERFILE\"  >> "<>SSP`CurrentSPCFile  ];

If[SSP`totalnumber<=100,
SSP`ScanData = Join[SSP`ScanData,{LesHouchesInput}];
];
];
(* Run["rm "<>dir<>"/"<>spc];, *)
If[DEFINITION[name][MCMC]=!=True,
Run["rm "<>SSP`RunningDir<>"/"<>spc];
];,
SSP`SuccessfullRun=False;
];
];


WriteLH[list_,leshouches_]:=Block[{i,j},
lh=OpenWrite[leshouches];
For[i=1,i<=Length[list],
WriteString[lh, "BLOCK "<>ToString[list[[i,1]]] <>"\t \t # \n"];
For[j=1,j<=Length[list[[i,2]]],
Switch[Length[list[[i,2,j,1]]],
1,
	WriteString[lh,ToString[list[[i,2,j,1,1]]]];,
2,
	WriteString[lh,ToString[list[[i,2,j,1,1]]]<>"\t"<>ToString[list[[i,2,j,1,2]]]];,
3,
	WriteString[lh,ToString[list[[i,2,j,1,1]]]<>"\t"<>ToString[list[[i,2,j,1,2]]]<>"\t"<>ToString[list[[i,2,j,1,3]]]];
];
If[FreeQ[{MODSEL,SPhenoInput},list[[i,1]]],
WriteString[lh,"\t"<>ToString[FortranForm[1. list[[i,2,j,2]]]]<>"\t \t # \n"];,
WriteString[lh,"\t"<>ToString[FortranForm[list[[i,2,j,2]]]]<>"\t \t # \n"];
];
j++;];
i++;];
Close[lh];
];





PerformContourScan[name_,basicpoint_,nr_]:=Block[{i,PointCounter=1},
Print["    Sampling parameter space: please, be patient..."];

currentInfo=DEFINITION[name][CountourScan];
SSP`CurrentDataSet={};

TestFunction[a_,b_]:=Block[{val},
PointCounter++;
(*
RunAll[name,basicpoint //. {CONTOURSCANPARAMTER[1]->a,CONTOURSCANPARAMTER[2]->b},DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPhenoBin],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],True];
*)
RunAll[name,basicpoint //. {CONTOURSCANPARAMTER[1]->a,CONTOURSCANPARAMTER[2]->b},DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],True];
If[SSP`SuccessfullRun===True,
val = DEFINITION[name][CountourScan][[1]] /.  MakeSubNum[LesHouchesInput];
SSP`CurrentDataSet = Join[SSP`CurrentDataSet,{LesHouchesInput}];
Return[val];,
Return[NIX];
];
];

plot=ReleaseHold[Hold[ContourPlot[TestFunction[x1,x2],{x1,currentInfo[[2,2]],currentInfo[[2,3]]},{x2,currentInfo[[3,2]],currentInfo[[3,3]]},tempCSTYLE]]/. tempCSTYLE->currentInfo[[4]]];

SSP`CurrentOutputDir=ToFileName[SSP`OutputDir,DEFINITION[name][OutputDirectory]];
SetDirectory[SSP`CurrentOutputDir];
Put[SSP`CurrentDataSet,"Data_ContourPlot_"<>ToString[nr]<>".dat"];
Export["Nr"<>ToString[nr]<>"_"<>currentInfo[[5]],plot];

Print["    ... done: ",PointCounter," points in parameter space evaluated"];

];


PerformFitToValues[name_,basicpoint_,nr_]:=Block[{i,temp},
Print["Fitting values"];
fittedValues = DEFINITION[name][FitValues];
freeParameters=DEFINITION[name][FreeParameters];

SSP`ValuesToFit=Table[fittedValues[[i,1]],{i,1,Length[fittedValues]}];
SSP`BestFit=Table[fittedValues[[i,2]],{i,1,Length[fittedValues]}];
SSP`Sigmas=Table[fittedValues[[i,3]],{i,1,Length[fittedValues]}];

SSP`FreeParamters=Table[freeParameters[[i,1]],{i,1,Length[freeParameters]}];
subDummFree =Table[SSP`FreeParamters[[i]] -> ToExpression["D"<>ToString[SSP`FreeParamters[[i]]]],{i,1,Length[freeParameters]}];
SSP`StartingPoints=Table[freeParameters[[i,2]],{i,1,Length[freeParameters]}];
SSP`Constraints=Table[freeParameters[[i,2,1]]<freeParameters[[i,1]]<freeParameters[[i,2,2]],{i,1,Length[freeParameters]}];
SSP`Constraints=SSP`Constraints /. subDummFree;
SSP`Constraints2=Table[{freeParameters[[i,2,1]],freeParameters[[i,2,2]]},{i,1,Length[freeParameters]}];
Counter=1;
FoundMinimum=False;

BestFitParameters={};
BestFitPoint={};
sumBestFit=10^12;



StretchParameters[x_]:=Block[{len,xl,stemp},
len=Length[x];
stemp={};
For[xl=1,xl<=len,
stemp=Join[stemp,{SSP`Constraints2[[xl,1]]+(SSP`Constraints2[[xl,2]]-SSP`Constraints2[[xl,1]])/2+ArcTan[x[[xl]]]/( Pi)*(SSP`Constraints2[[xl,2]]-SSP`Constraints2[[xl,1]])}];  
xl++;];
Return[stemp];
];

TestFunction[a___?NumericQ]:=Block[{k,j,len,var,res,sum},
len=Length[SSP`FreeParamters];
sub=Table[SSP`FreeParamters[[k]]-> StretchParameters[{a}][[k]],{k,1,len}];
If[FoundMinimum==False,
subBestFit=sub;,
sub=subBestFit;
];
(*
RunAll[name,basicpoint //. sub,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPhenoBin],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],False];
*)

RunAll[name,basicpoint //. sub,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],False];

If[SSP`SuccessfullRun===True,
subLHout=MakeSubNum[LesHouchesInput];
values = Table[SSP`ValuesToFit[[k]] /. subLHout,{k,1,Length[SSP`ValuesToFit]}];
sum=0;
For[k=1,k<=Length[values],
If[((Abs[values[[k]]-SSP`BestFit[[k]]])//.subLHout)>SSP`Sigmas[[k]],
sum+=((Abs[values[[k]]-SSP`BestFit[[k]]])/SSP`Sigmas[[k]])^2//.subLHout;
];
k++;];
SSP`Chi2=sum;
If[sum<sumBestFit,
sumBestFit=sum;
BestFitPoint=basicpoint //. sub;
BestFitParameters=values;
];
If[ShowAllSteps,
Print["Input Points: ",{a}];
Print["Stretched Points: ", StretchParameters[{a}],"  Chi2:",sum];
Print["Values: ", values];
Print["Demanded: ", SSP`BestFit];
];
If[Abs[sum]<10^-10,FoundMinimum=True;
Optimization`NMinimizeDump`result = Table[{i},{i,1,Length[freeParameters]},{i,1,Length[freeParameters]},{i,1,Length[freeParameters]},{i,1,Length[freeParameters]},{i,1,Length[freeParameters]},{i,1,Length[freeParameters]}];
Break[];
];
Return[sum];,
Return[1000];
];
];

subLH=MakeSubNum2[basicpoint];

If[Head[DEFINITION[name][FitOptions]]===List,
options=DEFINITION[name][FitOptions];,
options={};
];

Off[Part::partw];
 sol=NMinimize[TestFunction@@(SSP`FreeParamters/. subDummFree),(SSP`FreeParamters/. subDummFree),options];  
If[FoundMinimum==False,
Print["Warning! Fit to constraints not succesesfull. "];

(*
RunAll[name,BestFitPoint,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPhenoBin],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],False];
*)

RunAll[name,BestFitPoint,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],False];

Print["Chi^2: ",sumBestFit];
Print["Best fit values: ",BestFitParameters];
Print["Constraints: ",SSP`BestFit//.subLHout];
Print["Input point: ", basicpoint];,
If[DEFINITION[name][FitMessages]==True,
Print["Fit sucessfull: ", values];
Print["Fitted values: ",values];
Print["Demanded values: ",SSP`BestFit//.subLHout];
Print["Chi^2: ", SSP`Chi2];
];
];
On[Part::partw];
Return[subBestFit];


];


ReadCalcHep[file_,spc_]:=Block[{t="",ch,empty,pos=1,start,fin=False},
If[FileExistsQ["decaySLHA1.txt"],
ch=OpenRead["decaySLHA1.txt"];
t=Find[ch,"DECAY"];
If[t=!=EndOfFile,
While[t=!=EndOfFile,
Run["echo \""<>t<>" \" >> "<>SSP`RunningDir<>"/"<>spc ];
t=Read[ch,String];
];
];
Run["mv decaySLHA1.txt decaySLHA1_read.txt"];
];
t="";
If[FileExistsQ[file],
ch=OpenRead[file];
While[t=!=EndOfFile,line=t;t=Read[ch,String];];

line=StringReplace[line,{"<"->"",">"->""}];
empty=StringPosition[line," "] /.{a_,a_}->a;

start=empty[[1]];
While[fin=!=True,If[(empty[[pos+1]]-start)==1,pos++;start=empty[[pos]];,fin=True;];];
Return[ToExpression[StringReplace[StringTake[line,{empty[[pos]],empty[[pos+1]]}],{"E"->"*10^"}]] ];,
Return[0];
];
];

RunCalcHep[{dir_,bin_,file_},nr_,spc_,name_]:=Block[{res},
If[dir=!=DEFINITION[name][SPhenoSpectrumFile] || bin=!=DEFINITION[name][SPhenoDirectory],
Run["cp "<>spc<>" "<>dir];
];
SetDirectory[dir];
If[Head[MaximalTimeCalcHep]===Integer,
Run["./timeoutSSP -t "<>ToString[MaximalTimeCalcHep]<>" "<>bin];,
Run[bin];
];

res=ReadCalcHep[file,spc];
SSP`CHep=Join[SSP`CHep,{{nr,res}}];
Run["rm "<>file];
(* SetDirectory[DEFINITION[name][SPhenoDirectory]]; *)

SetDirectory[SSP`RunningDir];
];

RunWHIZARD[name_,Sinfile_,outputdir_]:=Block[{},
(* Run["cp "<>DEFINITION[name][SPhenoDirectory]<>DEFINITION[name][WHIZARDparFile]<>"  "<>outputdir]; *)
SetDirectory[outputdir];
Run["rm *"];
Run["cp "<>SSP`RunningDir<>DEFINITION[name][WHIZARDparFile]<>"  "<>outputdir];
If[Head[MaximalTimeWHIZARD]===Integer,
Run["./timeoutSSP -t "<>ToString[MaximalTimeWHIZARD]<>" "<>DEFINITION[name][WHIZARDexecution]<>" "<>Sinfile];,
Run[DEFINITION[name][WHIZARDexecution]<>" "<>Sinfile];
];

SetDirectory[SSP`RunningDir];
];

RunMG[name_,dir_,inputfile_,outputdir_]:=Block[{},
(* Run["cp "<>DEFINITION[name][SPhenoDirectory]<>DEFINITION[name][WHIZARDparFile]<>"  "<>outputdir]; *)
SetDirectory[outputdir];
Run["rm *"];
Run["cp "<>SSP`RunningDir<>DEFINITION[name][SPhenoSpectrumFile]<>"  "<>dir<>"Cards/param_card.dat"];
SetDirectory[dir];
Run["./bin/mg5 "<>inputfile];
If[Head[MaximalTimeMG]===Integer,
Run["./timeoutSSP -t "<>ToString[MaximalTimeMG]<>" "<>DEFINITION[name][WHIZARDexecution]<>" "<>inputfile];,
Run[DEFINITION[name][WHIZARDexecution]<>" "<>inputfile];
];
Run["cp -R SubProcesses/* "<>outputdir];
SetDirectory[SSP`RunningDir];
];


RunHiggsBounds[name_]:=Block[{hb,t="",line,fin=False,pos=1,n},
Run[DEFINITION[name][HiggsBounds]<>" '"<>SSP`RunningDir<>"' > HiggsBoundsScreen.out"];
HBres={};

hb=OpenRead["HiggsBounds_results.dat"];
While[t=!=EndOfFile,line=t;t=Read[hb,String];];
HBres = ToExpression/@Drop[StringReplace[#,{"E"->"*10^"}]&/@StringSplit[line],1];
SSP`HB=Join[{"HIGGSBOUNDS"},Table[{n,HBres[[n]]},{n,1,Length[HBres]}]];
];

RunHiggsSignals[name_]:=Block[{hb,t="",line,fin=False,pos=1,n},
Run[DEFINITION[name][HiggsSignals]<>" '"<>SSP`RunningDir<>"' > HiggsSignalsScreen.out"];
HSres={};

hb=OpenRead["HiggsSignals_results.dat"];
While[t=!=EndOfFile,line=t;t=Read[hb,String];];
HSres = ToExpression/@Drop[StringReplace[#,{"E"->"*10^"}]&/@StringSplit[line],1];
SSP`HS=Join[{"HIGGSSIGNALS"},Table[{n,HSres[[n]]},{n,1,Length[HSres]}]];
];

RunVevacious[name_]:=Block[{hb,t="",line,fin=False,pos=1,n},
Run[DEFINITION[name][VevaciousBin]<>" --input="<>DEFINITION[name][VevaciousInit]<>" --slha_file="<>SSP`RunningDir<>DEFINITION[name][SPhenoSpectrumFile]<>" > VevaciousScreen.out"];
];


RunMicrOmegas[name_,spc_]:=Block[{i,res,int, comm, int1, int2, int3, int4},
Run["cp "<>spc<>" "<>DEFINITION[name][MicroOmegasDirectory]<>"/"<>DEFINITION[name][MicroOmegasInputFile]];
SetDirectory[DEFINITION[name][MicroOmegasDirectory]];
Run["rm "<>DEFINITION[name][MicroOmegasOutputFile]];
If[Head[MaximalTimeMO]===Integer,
Run["./timeoutSSP -t "<>ToString[MaximalTimeMO]<>" ./"<>DEFINITION[name][MicroOmegasBin]<>" > MOScree.out"];,
Run["./"<>DEFINITION[name][MicroOmegasBin]<>" > MOScree.out"];
];

SSP`Omega={"DARKMATTER"};
SSP`OmegaWC={"DARKMATTER"};
If[FileExistsQ[DEFINITION[name][MicroOmegasOutputFile]],
in=OpenRead[DEFINITION[name][MicroOmegasOutputFile]];
res="";
i=1;
While[res=!=EndOfFile, 
int=Read[in,Number];
res=Read[in,Number];
comm=Read[in,String];
If[res=!=EndOfFile,
SSP`Omega=Join[SSP`Omega,{{int,res}}];
SSP`OmegaWC=Join[SSP`OmegaWC,{{int,res,comm}}];
];
i++;
];
Close[in];
Run["rm "<>DEFINITION[name][MicroOmegasOutputFile]];,
SSP`Omega={{1,-1}};
SSP`OmegaWC={{1,-1,"# error in dark matter calculation"}};
];
If[FileExistsQ["channels.out"],
SSP`OmegaChannels={"DMCHANNELS"};
in=OpenRead["channels.out"];
res="";
While[res=!=EndOfFile, 
int1=Read[in,Number];
int2=Read[in,Number];
int3=Read[in,Number];
int4=Read[in,Number];
res=Read[in,Number];
comm=Read[in,String];
If[res=!=EndOfFile,
SSP`OmegaChannels=Join[SSP`OmegaChannels,{{int1,int2,int3,int4,res,comm}}];
];
];
Close[in];
Run["rm channels.out"];,
SSP`OmegaChannels={};
];

SetDirectory[SSP`RunningDir];
];





CheckOfDirectories[name_]:=Block[{},
(*
If[DEFINITION[name][SPhenoDirectory]==="" || Head[DEFINITION[name][SPhenoDirectory]]=!=String,
If[DEFAULT[SPhenoDirectory]==="" || Head[DEFAULT[SPhenoDirectory]]=!=String,
MissingPaths::SPheno="It is necessary to define first the paths of your SPheno installation in the input file!";
Message[MissingPaths::SPheno];
Interrupt[];,
DEFINITION[name][SPhenoDirectory]=DEFAULT[SPhenoDirectory];
];
];

If[DEFINITION[name][SPhenoBin]==="" || Head[DEFINITION[name][SPhenoBin]]=!=String,
If[DEFAULT[SPhenoBin]==="" || Head[DEFAULT[SPhenoBin]]=!=String,
MissingName::SPhenoBinary="It is necessary to define the name of the SPheno binary in the input file!";
Message[MissingName::SPhenoBinary];
Interrupt[];,
DEFINITION[name][SPhenoBin]=DEFAULT[SPhenoBin];
];
];
*)


If[DEFINITION[name][SPheno]==="" || Head[DEFINITION[name][SPheno]]=!=String,
If[DEFAULT[SPheno]==="" || Head[DEFAULT[SPheno]]=!=String,
MissingPaths::SPheno="It is necessary to define the command to run SPheno in the input file!";
Message[MissingPaths::SPheno];
Interrupt[];,
DEFINITION[name][SPheno]=DEFAULT[SPheno];
];
];



If[DEFINITION[name][SPhenoInputFile]==="" || Head[DEFINITION[name][SPhenoInputFile]]=!=String,
If[DEFAULT[SPhenoInputFile]==="" || Head[DEFAULT[SPhenoInputFile]]=!=String,
MissingName::SPhenoInput="It is necessary to define the name of the LesHouches file for SPheno in the input file!";
Message[MissingName::SPhenoInput];
Interrupt[];,
DEFINITION[name][SPhenoInputFile]=DEFAULT[SPhenoInputFile];
];
];

If[DEFINITION[name][SPhenoSpectrumFile]==="" || Head[DEFINITION[name][SPhenoSpectrumFile]]=!=String,
If[DEFAULT[SPhenoSpectrumFile]==="" || Head[DEFAULT[SPhenoSpectrumFile]]=!=String,
MissingName::SPhenoSpectrum="It is necessary to define the name of the spectrum file of SPheno in the input file!";
Message[MissingName::SPhenoSpectrum];
Interrupt[];,
DEFINITION[name][SPhenoSpectrumFile]=DEFAULT[SPhenoSpectrumFile];
];
];

If[DEFINITION[name][IncludeWHIZARD]==True,
If[DEFAULT[WHIZARD]==="" || Head[DEFAULT[WHIZARD]]=!=String,
MissingPaths::WO="It is necessary to define first the paths of your WHIZARD installation in the input file!";
Message[MissingPaths::WO];
Interrupt[];,
DEFINITION[name][WHIZARDexecution]=DEFAULT[WHIZARD];
];

If[DEFINITION[name][WHIZARDparFile]==="" || Head[DEFINITION[name][WHIZARDparFile]]=!=String,
If[DEFAULT[WHIZARDparFile]==="" || Head[DEFAULT[WHIZARDparFile]]=!=String,
MissingFile::WO="It is necessary to define of the WHIZARD parameter file written by SPheno!";
Message[MissingFile::WO];
Interrupt[];,
DEFINITION[name][WHIZARDparFile]=DEFAULT[WHIZARDparFile];
];
];
];

If[DEFINITION[name][IncludeMadGraph]==True,
If[Head[DEFINITION[name][MadGraphRuns]]=!=List || Length[DEFINITION[name][MadGraphRuns][[1]]]=!=2,
WrongInput::MG="To define a MadGraph run, please give the directory and the input file.";
Message[WrongInput::MG];
Interrupt[];
];
];
If[DEFINITION[name][IncludeMicrOmegas]==True,

If[DEFAULT[MicroOmegas]==="" || Head[DEFAULT[MicroOmegas]]=!=String,
MissingPaths::MO="It is necessary to define first the MicrOmegas main file";
Message[MissingPaths::MO];
Interrupt[];,
border=Last[StringPosition[DEFAULT[MicroOmegas],"/"]][[1]];
DEFINITION[name][MicroOmegasDirectory]=StringTake[DEFAULT[MicroOmegas],{1,border}];
DEFINITION[name][MicroOmegasBin]=StringTake[DEFAULT[MicroOmegas],{border+1,StringLength[DEFAULT[MicroOmegas]]}];
];

If[DEFAULT[MicroOmegasOutputFile]==="" || Head[DEFAULT[MicroOmegasOutputFile]]=!=String,
MissingName::MOOUT="It is necessary to define the name of the output file of MicrOmegas in the input file!";
Message[MissingName::MOOUT];
Interrupt[];,
DEFINITION[name][MicroOmegasOutputFile]=DEFAULT[MicroOmegasOutputFile];
];

If[Head[DEFINITION[name][DarkMatterCandidate]]=!=Integer  && Head[DEFINITION[name][DarkMatterCandidate]]=!=Alternatives && DEFINITION[name][DarkMatterCandidate]=!=ALL,
If[Head[DEFAULT[DarkMatterCandidate]]=!=Integer &&Head[DEFAULT[DarkMatterCandidate]]=!=Alternatives && DEFAULT[DarkMatterCandidate]=!=ALL,
MissingPDG::DMCandidate="It is necessary to define the PDG of the Dark Matter Candidate in the input file!";
Message[MissingPDG::DMCandidate];
Interrupt[];,
DEFINITION[name][DarkMatterCandidate]=DEFAULT[DarkMatterCandidate];
];
];
];


If[DEFINITION[name][IncludeVevacious]==True,
If[DEFAULT[VevaciousBin]==="" || Head[DEFAULT[VevaciousBin]]=!=String,
MissingPaths::Vev="It is necessary to define the executable of Vevacious";
Message[MissingPaths::Vev];
Interrupt[];,
DEFINITION[name][VevaciousBin]=DEFAULT[VevaciousBin];
];
If[DEFAULT[VevaciousInit]==="" || Head[DEFAULT[VevaciousInit]]=!=String,
MissingPaths::VevInit="It is necessary to define the initialization file for Vevacious";
Message[MissingPaths::VevInit];
Interrupt[];,
DEFINITION[name][VevaciousInit]=DEFAULT[VevaciousInit];
];
];


If[DEFINITION[name][IncludeHiggsBounds]==True,
If[DEFAULT[HiggsBounds]==="" || Head[DEFAULT[HiggsBounds]]=!=String,
MissingName::HB="It is necessary to define the command to execute HiggsBounds in the input file!";
Message[MissingName::HB];
Interrupt[];,
DEFINITION[name][HiggsBounds]=DEFAULT[HiggsBounds];
];
];

If[DEFINITION[name][IncludeHiggsSignals]==True,
If[DEFAULT[HiggsSignals]==="" || Head[DEFAULT[HiggsSignals]]=!=String,
MissingName::HS="It is necessary to define the command to execute HiggsSignals in the input file!";
Message[MissingName::HS];
Interrupt[];,
DEFINITION[name][HiggsSignals]=DEFAULT[HiggsSignals];
];
];


];

SetLocalDefinitions[name_]:=Block[{},
If[Head[DEFINITION[name][CalcHepInputFile]]=!=String,DEFINITION[name][CalcHepInputFile]=DEFINITION[name][SPhenoSpectrumFile];];
If[Head[DEFINITION[name][MicroOmegasInputFile]]=!=String,DEFINITION[name][MicroOmegasInputFile]=DEFINITION[name][SPhenoSpectrumFile];];
If[Head[DEFINITION[name][OutputFile]]=!=String,DEFINITION[name][OutputFile]="Data.m";];
If[Head[DEFINITION[name][SpectrumFiles]]=!=String,DEFINITION[name][SpectrumFiles]="SpectrumFiles";];

SSP`CurrentSPCFile = ToFileName[SSP`CurrentOutputDir,DEFINITION[name][SpectrumFiles]<>".spc"];
SSP`CurrentSPCFileMCMC = ToFileName[SSP`CurrentOutputDir,DEFINITION[name][SpectrumFiles]<>"_acceptedPoints.spc"];
If[Head[DEFINITION[name][FitValues]]===List || DEFINITION[name][MakeCountourScan]===True,
SSP`CurrentSPCFileAll = ToFileName[SSP`CurrentOutputDir,DEFINITION[name][SpectrumFiles]<>"_all.spc"];
];
If[DEFINITION[name][AttendPoints]=!=True,
Run["rm "<>SSP`CurrentSPCFile];
If[Head[DEFINITION[name][FitValues]]===List || DEFINITION[name][MakeCountourScan]===True,
Run["rm "<>SSP`CurrentSPCFileAll];
];
];


If[Head[MaximalTimeMO]===Integer || Head[MaximalTimeSPheno]===Integer || Head[MaximalTimeWHIZARD]===Integer || Head[MaximalTimeCalcHep]===Integer,
SSP`timeoutFile=ToFileName[ToFileName[{SSP`PackageDir,"timeout-4.09"}],"timeoutSSP"];
If[FileExistsQ[SSP`timeoutFile],
Run["cp "<>SSP`timeoutFile<>" "<>SSP`RunningDir];
If[Head[MaximalTimeMO]===Integer,
Run["cp "<>SSP`timeoutFile<>" "<>DEFINITION[name][MicroOmegasDirectory]];
];,
Timeout::NotFound="Exectubale 'timeoutSSP' not found. Please extract timeout-4.09.tar.gz in your package directory and compile timeout using make";
Message[Timeout::NotFound];
];
];
];

StartMCMC[name_]:=Block[{i,j,k,temp,converged,currentpoint,nextpoint,nextL,currentL,JumpinQ,steps,subnum,subnumLast},
Run["rm "<>SSP`CurrentSPCFileMCMC ];
MCMC`Steps=0;
MCMC`AllSteps=0;
nextstep=100;
currentpoint=FindFirstPointOfChain[name];
converged=False;
currentL=CheckJump[name,MakeSubNum[LesHouchesInput],0][[2]];
(* stepsize=DEFINITION[name][MCMCstepsize][MCMC`Steps]; *)
subnumLast=MakeSubNum[LesHouchesInput];
While[converged==False,
nextpoint=FindNextPointChain[name,subnumLast][[1]];
RunAll[name,nextpoint,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],True];
MCMC`AllSteps++;
If[SSP`SuccessfullRun,
subnum=MakeSubNum[LesHouchesInput];
temp=CheckJump[name,subnum,currentL];
(* Print["stepsize",stepsize]; *)
JumpingQ=temp[[1]];
nextL=temp[[2]];
If[JumpingQ,
Run["cat "<>SSP`RunningDir<>"/"<>DEFINITION[name][SPhenoSpectrumFile] <>"  >> "<>SSP`CurrentSPCFileMCMC  ]; 
Run["echo \"Block MCMCMINFO #\"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"1 "<>ToString[MCMC`Steps]<>" # accepted point \"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"2 "<>ToString[MCMC`AllSteps]<>" # all points \"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"3 "<>ToString[FortranForm[currentL]]<>" #  Likelyhood \"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"ENDOFPARAMETERFILE\"  >> "<>SSP`CurrentSPCFileMCMC  ];
currentpoint=nextpoint;
subnumLast = subnum;
currentL = nextL;
MCMC`CurrentL = currentL;
MCMC`Steps++;
(* stepsize=DEFINITION[name][MCMCstepsize][MCMC`Steps]; *)
If[MCMC`Steps==nextstep, Print["       ",nextstep,"steps are performed. Reached Likelyhood: ",currentL];nextstep=nextstep+100];
converged=CheckConvergenceMCMC[name];,
converged=False;
];
Run["rm "<>SSP`RunningDir<>"/"<>DEFINITION[name][SPhenoSpectrumFile]]; 
];
];
];

CheckConvergenceMCMC[name_]:=Block[{},
Return[DEFINITION[name][MCMCconvergenceCheck][MCMC`CurrentL]];
];

CheckJump[name_,spc_,oldvalue_]:=Block[{i,j,k,newvalue},
newvalue=Times@@(DEFINITION[name][ConstraintsMCMC]/.spc);
If[ShowConstraints===True && newvalue>oldvalue,Print[DEFINITION[name][ConstraintsMCMC]/.spc];];
If[Min[(DEFINITION[name][ConstraintsMCMC]/.spc)]<0,
Print["Constraints are not well defined: Likelyhood is negative"];
For[i=1,i<=Length[DEFINITION[name][ConstraintsMCMC]],
If[(DEFINITION[name][ConstraintsMCMC][[i]]/.spc)<0,
Print[DEFINITION[name][ConstraintsMCMC][[i]],": ",(DEFINITION[name][ConstraintsMCMC][[i]]/.spc)];
];
i++;];
Interrupt[];
];
If[NumericQ[newvalue]===False,
Print["Problem with calculating constraints. Result is not a number: ",newvalue];
Return[{False,oldvalue}];
];
If[DEFINITION[name][MCMCjumpingQ][newvalue,oldvalue],
Return[{True,newvalue}];,
Return[{False,oldvalue}];
];
];

FindFirstPointOfChain[name_]:=Block[{firstpoint,currentL},
currentL=-1;
DEFINITION[name][ScatterPlot]=True;
DEFINITION[name][ScatterPoints]=1;
Clear[LesHouchesInput];
While[SSP`SuccessfullRun=!=True || currentL<=0.,
SSP`SuccessfullRun=False;
firstpoint=GeneratePoints[name][[1]];
RunAll[name,firstpoint,DEFINITION[name][SPhenoDirectory],DEFINITION[name][SPheno],DEFINITION[name][SPhenoSpectrumFile],DEFINITION[name][SPhenoInputFile],True];
If[SSP`SuccessfullRun==True ,currentL=CheckJump[name,MakeSubNum[LesHouchesInput],0][[2]];];
];
Run["cat "<>SSP`RunningDir<>"/"<>DEFINITION[name][SPhenoSpectrumFile] <>"  >> "<>SSP`CurrentSPCFileMCMC  ]; 
Run["echo \"Block MCMCMINFO #\"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"1 1 # accepted point \"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"2 1 # all points \"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"3 "<>ToString[FortranForm[currentL]]<>" #  Likelyhood \"  >> "<>SSP`CurrentSPCFileMCMC  ];
Run["echo \"ENDOFPARAMETERFILE\"  >> "<>SSP`CurrentSPCFileMCMC  ];
Print["Found valid starting point. Likelyhood: ", currentL];
Return[firstpoint];
];

FindNextPointChain[name_,currentpoint_]:=Block[{i,j,temp},
BlockList=Table[{},{Length[DEFINITION[name][Blocks]]}];
blocks=DEFINITION[name][Blocks];

 For[i=1,i<=Length[BlockList],
BlockList[[i]]=CreateValueListMCMC[DEFINITION[name][blocks[[i]]],blocks[[i]],currentpoint,stepsize];
BlockList[[i]]=CreateAllCombination[BlockList[[i]],blocks[[i]]];
i++;];

Return[CreatePoints[BlockList]];
];

CreateValueListMCMC[list_,head_,spc_,stepsize_]:=Block[{i,j,temp},
temp = Table[{},{Length[list]}];
For[i=1,i<=Length[list],
If[FreeQ[list[[i,2]],Min],
temp[[i]]={{list[[i,1]], (Value /. list[[i,2]])}},
(* temp[[i]]={{list[[i,1]],(1-stepsize)* (head@@list[[i,1]] /. spc)+2*stepsize (head@@list[[i,1]] /. spc)*Random[]}}; *)
temp[[i]]={{list[[i,1]],ReleaseHold[(NextStep /. list[[i,2]]) /. spc ]}};
];
i++;];
Return[temp];
];
