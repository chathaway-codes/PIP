V01S376(%O,fSCAU)	; -  - SID= <SCAUSR1> System User Input (With CIF Restrict)
	;
	; **** Routine compiled from DATA-QWIK Screen SCAUSR1 ****
	;
	; 12/06/2007 16:14 - chenardp
	;
	;;Copyright(c)2007 Sanchez Computer Associates, Inc.  All Rights Reserved - 12/06/2007 16:14 - chenardp
	;
	N KVAR N VPG N vPSL N VSID
	S VSID="SCAUSR1"
	S KVAR="kill %A,%TAB,vtab,VFSN,%OLD,%NEW,%FILE,%INDEX,%PAGE,%PG,UX,MULSCR"
	S:'($D(%PG)#2) %PG=1 S %PAG=%PG+2 S %PAGE=$S(($D(%PAGE)#2):%PAGE-1,1:0)+3
	S vPSL=1 ;compiled for PSL
	;
	S VPG(%PG+0)="PROFILE User Set-Up (Tables/ G/L Link)|SCAUSR"
	S VPG(%PG+1)="User Status Information|SCAUSTAT"
	S VPG(%PG+2)="User Related CIF Input|SCAUR"
	S:'($D(%PG)#2) %PG=1 S %PGSV=%PG S MULSCR=""
	I '%O D VNEW(.fSCAU)
	I %O D VLOD(.fSCAU) I $get(ER) S VFMQ="Q" Q 
	D VPG(.fSCAU)
	Q 
	;
VNEW(fSCAU)	;
	;
	Q 
	;
	;
VLOD(fSCAU)	; User defined access section
	Q 
	;
VPG(fSCAU)	;
	N vDONE
	S vDONE=0
	F  D  Q:vDONE 
	.	I %PG=(%PGSV+0) D VPG1(.fSCAU) D VPG0(.fSCAU) Q:vDONE 
	.	I %PG=(%PGSV+1) D VPG2(.fSCAU) D VPG0(.fSCAU) Q:vDONE 
	.	I %PG=(%PGSV+2) D VPG3(.fSCAU) D VPG0(.fSCAU) Q:vDONE 
	.	Q 
	Q 
	;
VPG0(fSCAU)	;
	N %LINK
	S %LINK=""
	I %O=2!(%O=3)!(%O=4) D VBTM(.fSCAU) I $get(VFMQ)="D" S vDONE=1 Q 
	I '($D(%PAGE)#2) S vDONE=1 Q 
	I %PG'<%PAG K %PAG,%PGSV,VPG S vDONE=1 Q 
	S %PG=%PG+1
	Q 
	;
VPG1(fSCAU)	; PROFILE User Set-Up (Tables/ G/L Link)
	N DFID N PGM
	S SID="SCAUSR" S DFID="SCAU"
	D ^USID I PGM="" S ET="INVLDSCR" D ^UTLERR Q 
	K VPTBL
	S VPGM=PGM
	D VREPRNT^V01S375
	I %O>1 Q 
	D VTAB^V01S375(.fSCAU)
	Q 
	;
VPG2(fSCAU)	; User Status Information
	N DFID N PGM
	S SID="SCAUSTAT" S DFID="SCAU"
	D ^USID I PGM="" S ET="INVLDSCR" D ^UTLERR Q 
	K VPTBL
	S VPGM=PGM
	D VREPRNT^V01S377
	I %O>1 Q 
	D VTAB^V01S377(.fSCAU)
	Q 
	;
VPG3(fSCAU)	; User Related CIF Input
	N DFID N PGM
	S SID="SCAUR" S DFID="SCAU"
	D ^USID I PGM="" S ET="INVLDSCR" D ^UTLERR Q 
	S %MODS=1 I '($D(%REPEAT)#2) S %REPEAT=16
	K VPTBL
	S VPGM=PGM
	D VREPRNT^V01S374
	I %O>1 Q 
	D VTAB^V01S374(.fSCAU)
	Q 
	;
VBTM(fSCAU)	;
	I %O=4,IO'=$P Q 
	D ^DBSCRT8A
	Q 
