R01S231	; DBSTRGLST - List Trigger Definition
	;
	; **** Routine compiled from DATA-QWIK Report DBSTRGLST ****
	;
	; 09/14/2007 09:23 - chenardp
	;
	; Copyright(c)2007 Sanchez Computer Associates, Inc.  All Rights Reserved - 09/14/2007 09:23 - chenardp
	;
	 S ER=0
	N OLNTB
	N %READ N RID N RN N %TAB N VFMQ
	N VIN1 S VIN1="ALL"
	N VIN2 S VIN2="ALL"
	N VIN3 S VIN3="ALL"
	N VIN4 S VIN4="ALL"
	N VIN5 S VIN5="ALL"
	;
	S RID="DBSTRGLST"
	S RN="List Trigger Definition"
	I $get(IO)="" S IO=$I
	;
	D INIT^%ZM()
	;
	S %TAB("IO")=$$IO^SCATAB
	S %TAB("VIN1")="|255||[DBTBL7]TABLE|[DBTBL1]:NOVAL||D EXT^DBSQRY||T|Table Name|||||"
	S %TAB("VIN2")="|255||[DBTBL7]TRGID|[DBTBL7]TRGID:DISTINCT:NOVAL||D EXT^DBSQRY||T|Trigger Name|||||"
	S %TAB("VIN3")="|255||[DBTBL7]COLUMNS|||D EXT^DBSQRY||T|List of Columns|||||"
	S %TAB("VIN4")="|255||[DBTBL7]TLD|||D EXT^DBSQRY||T|Date Last Updated|||||"
	S %TAB("VIN5")="|255||[DBTBL7]USER|||D EXT^DBSQRY||T|User|||||"
	;
	S %READ="IO/REQ,VIN1#0,VIN2#0,VIN3#0,VIN4#0,VIN5#0,"
	;
	; Skip device prompt option
	I $get(VRWOPT("NOOPEN")) S %READ="VIN1#0,VIN2#0,VIN3#0,VIN4#0,VIN5#0,"
	;
	S VFMQ=""
	I %READ'="" D  Q:$get(VFMQ)="Q" 
	.	S OLNTB=30
	.	S %READ="@RN/CEN#1,,"_%READ
	.	D ^UTLREAD
	.	Q 
	;
	I '$get(vbatchq) D V0
	Q 
	;
V0	; External report entry point
	;
	N vcrt N VD N VFMQ N vh N vI N vlc N VLC N VNEWHDR N VOFFLG N VPN N VR N VRG N vs N VSEQ N VT
	N VWHERE
	N %TIM N CODE N CONAM N RID N RN N VL N VLOF N VRF N VSTATS N ZSETAUD N ZSYSGEN N vCOL N vHDG N vc1 N vc10 N vc11 N vc12 N vc13 N vc2 N vc3 N vc4 N vc5 N vc6 N vc7 N vc8 N vc9 N vovc1 N vovc2 N vovc3 N vrundate N vsysdate
	;
	N cuvar S cuvar=$$vDb2()
	 S cuvar=$G(^CUVAR("BANNER"))
	;
	S CONAM="DATA-QWIK 7.2"
	S ER=0 S RID="DBSTRGLST" S RN="List Trigger Definition"
	S VL=""
	;
	USE 0 I '$get(VRWOPT("NOOPEN")) D  Q:ER 
	.	I '($get(VRWOPT("IOPAR"))="") S IOPAR=VRWOPT("IOPAR")
	.	E  I (($get(IOTYP)="RMS")!($get(IOTYP)="PNTQ")),('($get(IOPAR)["/OCHSET=")),$$VALID^%ZRTNS("UCIOENCD") D
	..		; Accept warning if ^UCIOENCD does not exist
	..		;    #ACCEPT Date=07/26/06; Pgm=RussellDS; CR=22121; Group=MISMATCH
	..		N CHRSET S CHRSET=$$^UCIOENCD("Report","DBSTRGLST","V0","*")
	..		I '(CHRSET="") S IOPAR=IOPAR_"/OCHSET="_CHRSET
	..		Q 
	.	D OPEN^SCAIO
	.	Q 
	S vcrt=(IOTYP="TRM")
	I 'vcrt S IOSL=60 ; Non-interactive
	E  D  ; Interactive
	.	D TERM^%ZUSE(IO,"WIDTH=133")
	.	WRITE $$CLEARXY^%TRMVT
	.	WRITE $$SCR132^%TRMVT ; Switch to 132 col mode
	.	Q 
	;
	D INIT^%ZM()
	;
	; Build WHERE clause to use for dynamic query
	D
	.	N SEQ S SEQ=1
	.	N DQQRY N FROM
	.	I $get(VIN1)="" S VIN1="ALL"
	.	I VIN1'="ALL" S DQQRY(1)="[DBTBL7]TABLE "_VIN1 S SEQ=SEQ+1
	.	I $get(VIN2)="" S VIN2="ALL"
	.	I VIN2'="ALL" S DQQRY(SEQ)="[DBTBL7]TRGID "_VIN2 S SEQ=SEQ+1
	.	I $get(VIN3)="" S VIN3="ALL"
	.	I VIN3'="ALL" S DQQRY(SEQ)="[DBTBL7]COLUMNS "_VIN3 S SEQ=SEQ+1
	.	I $get(VIN4)="" S VIN4="ALL"
	.	I VIN4'="ALL" S DQQRY(SEQ)="[DBTBL7]TLD "_VIN4 S SEQ=SEQ+1
	.	I $get(VIN5)="" S VIN5="ALL"
	.	I VIN5'="ALL" S DQQRY(SEQ)="[DBTBL7]USER "_VIN5 S SEQ=SEQ+1
	.	S FROM=$$DQJOIN^SQLCONV("DBTBL7") Q:ER 
	.	S VWHERE=$$WHERE^SQLCONV(.DQQRY,"")
	.	Q 
	;
	; Print Report Banner Page
	I $P(cuvar,$C(124),1),'$get(VRWOPT("NOBANNER")),IOTYP'="TRM",'$get(AUXPTR) D
	.	N VBNRINFO
	.	;
	.	S VBNRINFO("PROMPTS",1)="WC2|"_"Table Name"_"|VIN1|"_$get(VIN1)
	.	S VBNRINFO("PROMPTS",2)="WC2|"_"Trigger Name"_"|VIN2|"_$get(VIN2)
	.	S VBNRINFO("PROMPTS",3)="WC2|"_"List of Columns"_"|VIN3|"_$get(VIN3)
	.	S VBNRINFO("PROMPTS",4)="WC2|"_"Date Last Updated"_"|VIN4|"_$get(VIN4)
	.	S VBNRINFO("PROMPTS",5)="WC2|"_"User"_"|VIN5|"_$get(VIN5)
	.	;
	.	D
	..		N SEQ
	..		N VALUE N VAR N X
	..		S X=VWHERE
	..		S SEQ=""
	..		F  S SEQ=$order(VBNRINFO("PROMPTS",SEQ)) Q:SEQ=""  D
	...			S VAR=$piece(VBNRINFO("PROMPTS",SEQ),"|",3)
	...			S VALUE=$piece(VBNRINFO("PROMPTS",SEQ),"|",4,99)
	...			S X=$$replace^DBSRWUTL(X,":"_VAR,"'"_VALUE_"'")
	...			Q 
	..		S VBNRINFO("WHERE")=X
	..		Q 
	.	;
	.	S VBNRINFO("DESC")="List Trigger Definition"
	.	S VBNRINFO("PGM")="R01S231"
	.	S VBNRINFO("RID")="DBSTRGLST"
	.	S VBNRINFO("TABLES")="DBTBL7"
	.	;
	.	S VBNRINFO("ORDERBY",1)="[SYSDEV,DBTBL7]%LIBS"
	.	S VBNRINFO("ORDERBY",2)="[SYSDEV,DBTBL7]TABLE"
	.	S VBNRINFO("ORDERBY",3)="[SYSDEV,DBTBL7]TRGID"
	.	;
	.	D ^DBSRWBNR(IO,.VBNRINFO) ; Print banner
	.	Q 
	;
	; Initialize variables
	S (vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9,vc10,vc11,vc12,vc13)=""
	S (VFMQ,vlc,VLC,VOFFLG,VPN,VRG)=0
	S VNEWHDR=1
	S VLOF=""
	S %TIM=$$TIM^%ZM
	S vrundate=$$vdat2str($P($H,",",1),"MM/DD/YEAR") S vsysdate=$S(TJD'="":$ZD(TJD,"MM/DD/YEAR"),1:"")
	;
	D
	.	N I N J N K
	.	F I=0:1:3 D
	..		S (vh(I),VD(I))=0 S vs(I)=1 ; Group break flags
	..		S VT(I)=0 ; Group count
	..		F J=1:1:0 D
	...			F K=1:1:3 S VT(I,J,K)="" ; Initialize function stats
	...			Q 
	..		Q 
	.	Q 
	;
	 N V1 S V1=$J D vDbDe1() ; Report browser data
	S vh(0)=0
	;
	; Run report directly
	D VINILAST
	;
	;  #ACCEPT DATE=09/14/2007;PGM=Report Writer Generator;CR=20967
	N rwrs,vos1,vos2,sqlcur,exe,sqlcur,vd,vi,vsql,vsub S rwrs=$$vOpen0(.exe,.vsql,"DBTBL7.%LIBS,DBTBL7.TABLE,DBTBL7.TRGID,DBTBL7.DES,DBTBL7.ACTBI,DBTBL7.ACTAI,DBTBL7.ACTBU,DBTBL7.ACTAU,DBTBL7.ACTBD,DBTBL7.ACTAD,DBTBL7.TLD,DBTBL7.USER,DBTBL7.COLUMNS","DBTBL7",VWHERE,"DBTBL7.%LIBS,DBTBL7.TABLE,DBTBL7.TRGID","","/DQMODE=1")
	I $get(ER) USE 0 WRITE $$MSG^%TRMVT($get(RM),"",1) ; Debug Mode
	I '$G(vos1) D VEXIT(1) Q 
	F  Q:'($$vFetch0())  D  Q:VFMQ 
	.	N V N VI
	.	S V=rwrs
	.	S VI=""
	.	D VGETDATA(V,"")
	.	D VPRINT Q:VFMQ 
	.	D VSAVLAST
	.	Q 
	D VEXIT(0)
	;
	Q 
	;
VINILAST	; Initialize last access key values
	S vovc1="" S vovc2="" S vovc3=""
	Q 
	;
VSAVLAST	; Save last access keys values
	S vovc1=vc1 S vovc2=vc2 S vovc3=vc3
	Q 
	;
VGETDATA(V,VI)	;
	S vc1=$piece(V,$char(9),1) ; DBTBL7.%LIBS
	S vc2=$piece(V,$char(9),2) ; DBTBL7.TABLE
	S vc3=$piece(V,$char(9),3) ; DBTBL7.TRGID
	S vc4=$piece(V,$char(9),4) ; DBTBL7.DES
	S vc5=$piece(V,$char(9),5) ; DBTBL7.ACTBI
	S vc6=$piece(V,$char(9),6) ; DBTBL7.ACTAI
	S vc7=$piece(V,$char(9),7) ; DBTBL7.ACTBU
	S vc8=$piece(V,$char(9),8) ; DBTBL7.ACTAU
	S vc9=$piece(V,$char(9),9) ; DBTBL7.ACTBD
	S vc10=$piece(V,$char(9),10) ; DBTBL7.ACTAD
	S vc11=$piece(V,$char(9),11) ; DBTBL7.TLD
	S vc12=$piece(V,$char(9),12) ; DBTBL7.USER
	S vc13=$piece(V,$char(9),13) ; DBTBL7.COLUMNS
	Q 
	;
VBRSAVE(LINE,DATA)	; Save for report browser
	N tmprptbr,vop1,vop2,vop3,vop4,vop5 S tmprptbr="",vop4="",vop3="",vop2="",vop1="",vop5=0
	S vop4=$J
	S vop3=LINE
	S vop2=0
	S vop1=0
	S $P(tmprptbr,$C(12),1)=DATA
	N vTp S vTp=0 S:($Tlevel=0) vTp=1 Tstart:vTp (vobj):transactionid="CS" S ^TMPRPTBR(vop4,vop3,vop2,vop1)=tmprptbr S vop5=1 Tcommit:vTp  
	Q 
	;
MEMO(MEMO,LINE,SIZE)	; Print all lines of memo, except last - return it in V
	;
	N I N TAB N VLLEN
	N X
	;
	S TAB=(LINE#1000)-1 ; Location
	S MEMO=$$vStrTrim(MEMO,0," ")
	;
	I $L(MEMO)'>SIZE Q MEMO
	;
	S VLLEN=$L(VL)
	F  D  Q:VFMQ!(MEMO="") 
	.	S X=$E(MEMO,1,SIZE)
	.	I X[" " D
	..		F I=SIZE:-1:1 Q:$E(X,I)=" " 
	..		S X=$E(X,1,I-1)
	..		Q 
	.	S MEMO=$E(MEMO,$L(X)+1,1048575)
	.	S X=$$vStrTrim(X,0," ")
	.	S MEMO=$$vStrTrim(MEMO,0," ") Q:(MEMO="") 
	.	; Print this portion
	.	I VLC+1>IOSL D VHDG0 I VFMQ S VFMQ=1 Q 
	.	S VL=VL_$J("",TAB-$L(VL))_X D VOM
	.	S VL=$J("",TAB)
	.	Q 
	S VL=$J("",VLLEN)
	Q X
	;
VEXIT(NOINFO)	; Exit from report
	N I N PN N vs N z
	N VL S VL=""
	S vs(1)=0 S vs(2)=0 S vs(3)=0
	I 'VFMQ D VSUM
	I 'vh(0) D VHDG0
	I 'VFMQ D
	.	; No information available to display
	.	I NOINFO=1 S VL=$$^MSG(4655) D VOM
	.	I vcrt S VL="" F z=VLC+1:1:IOSL D VOM
	.	;
	.	I '($D(VTBLNAM)#2) D
	..		S vs(2)=0
	..		Q 
	.	Q 
	;
	I 'VFMQ,vcrt S PN=-1 D ^DBSRWBR(2)
	I '$get(VRWOPT("NOCLOSE")) D CLOSE^SCAIO
	 N V1 S V1=$J D vDbDe2() ; Report browser data
	;
	Q 
	;
VPRINT	; Print section
	N vskp
	;
	I $get(VRWOPT("NODTL")) S vskp(1)=1 S vskp(2)=1 S vskp(3)=1 ; Skip detail
	D VBREAK
	D VSUM Q:VFMQ 
	;
	I $get(VH0) S vh(0)=0 S VNEWHDR=1 K VH0 ; Page Break
	I 'vh(0) D VHDG0 Q:VFMQ 
	I '$get(vskp(3)) D VDTL3 Q:VFMQ 
	D VSTAT
	Q 
	;
VBREAK	;
	Q:'VT(3) 
	N vb1 N vb2 N vb3
	S (vb1,vb2,vb3)=0
	I 0!(vovc1'=vc1) S vs(2)=0 S vh(2)=0 S VD(1)=0 S vb2=1 S vb3=1
	I vb2!(vovc2'=vc2) S vs(3)=0 S vh(3)=0 S VD(2)=0 S vb3=1 S VH0=1
	Q 
	;
VSUM	; Report Group Summary
	I 'vs(3) S vs(3)=1 D stat^DBSRWUTL(3)
	I 'vs(2) S vs(2)=1 D stat^DBSRWUTL(2)
	Q 
	;
VSTAT	; Data field statistics
	;
	S VT(3)=VT(3)+1
	Q 
	;
VDTL3	; Detail
	;
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	;
	S VL=$E(vc2,1,12)
	S VL=VL_$J("",14-$L(VL))_$E(vc3,1,20)
	S VL=VL_$J("",36-$L(VL))_$E(vc4,1,40)
	S VL=VL_$J("",78-$L(VL))_$S(vc5:"Y",1:"N")
	S VL=VL_$J("",82-$L(VL))_$S(vc6:"Y",1:"N")
	S VL=VL_$J("",86-$L(VL))_$S(vc7:"Y",1:"N")
	S VL=VL_$J("",90-$L(VL))_$S(vc8:"Y",1:"N")
	S VL=VL_$J("",94-$L(VL))_$S(vc9:"Y",1:"N")
	S VL=VL_$J("",98-$L(VL))_$S(vc10:"Y",1:"N")
	S VL=VL_$J("",102-$L(VL))_$J($S(vc11'="":$ZD(vc11,"MM/DD/YEAR"),1:""),10)
	S VL=VL_$J("",113-$L(VL))_$E(vc12,1,18)
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	D VOM
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	S VL="" D VOM
	S VL="          "_"UPDATE action by columns:"
	S V=vc13 S VO=V D VP1 Q:VFMQ!$get(verror)  S V=$$MEMO(V,3037,90)
	S VL=VL_$J("",36-$L(VL))_V
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	I '($translate(VL," ")="") D VOM
	S VL="          "_"-------------------------------------------------- Procedural Code"
	S VL=VL_$J("",77-76)_"-------------------------------------------"
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	D VOM
	S VL="          "_"(System Generated): "
	D VP2 Q:VFMQ!$get(verror)  S V=$E(ZSYSGEN,1,70)
	S VL=VL_$J("",32-$L(VL))_V
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	D VOM
	D VP3 Q:VFMQ!$get(verror)  S V=$E(ZSETAUD,1,70) S VL="                                "_V
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	D VOM
	D VP4 Q:VFMQ!$get(verror)  S V=$E(CODE,1,110) S VL="          "_V
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	D VOM
	S VL="          "_"--------------------------------------------------------------------------------------------------------------"
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	D VOM
	I VLC+1>IOSL D VHDG0 Q:VFMQ 
	S VL="" D VOM
	Q 
	;
VHDG0	; Page Header
	N PN N V N VO
	I $get(VRWOPT("NOHDR")) Q  ; Skip page header
	S vh(0)=1 S VRG=0
	I VL'="" D VOM
	I vcrt,VPN>0 D  Q:VFMQ!'VNEWHDR 
	.	N PN N X
	.	S VL=""
	.	F X=VLC+1:1:IOSL D VOM
	.	S PN=VPN
	.	D ^DBSRWBR(2)
	.	S VLC=0
	.	Q:VFMQ 
	.	I VNEWHDR WRITE $$CLEARXY^%TRMVT
	.	E  S VLC=VLC+6 S VPN=VPN+1
	.	Q 
	;
	S ER=0 S VPN=VPN+1 S VLC=0
	;
	S VL=$E(($get(CONAM)),1,45)
	S VL=VL_$J("",100-$L(VL))_"Run Date:"
	S VL=VL_$J("",110-$L(VL))_$E(vrundate,1,10)
	S VL=VL_$J("",123-$L(VL))_$E(%TIM,1,8)
	D VOM
	S VL=RN_"  ("_RID_")"
	S VL=VL_$J("",102-$L(VL))_"System:"
	S VL=VL_$J("",110-$L(VL))_$E(vsysdate,1,10)
	S VL=VL_$J("",122-$L(VL))_"Page:"
	S VL=VL_$J("",128-$L(VL))_$J(VPN,3)
	D VOM
	S VL="" D VOM
	S VL="                                                                              "_"--- Trigger Actions ---      Last"
	D VOM
	S VL="Table Name    Trigger Name          Description                               BI  AI  BU  AU  BD  AD    Updated  By User"
	D VOM
	S VL="===================================================================================================================================="
	D VOM
	;
	S VNEWHDR=0
	I vcrt S PN=VPN D ^DBSRWBR(2,1) ; Lock report page heading
	;
	Q 
	;
VOM	; Output print line
	;
	USE IO
	;
	; Advance to a new page
	I 'VLC,'vcrt D  ; Non-CRT device (form feed)
	.	I '$get(AUXPTR) WRITE $char(12),!
	.	E  WRITE $$PRNTFF^%TRMVT,!
	.	S $Y=1
	.	Q 
	;
	I vcrt<2 WRITE VL,! ; Output line buffer
	I vcrt S vlc=vlc+1 D VBRSAVE(vlc,VL) ; Save in BROWSER buffer
	S VLC=VLC+1 S VL="" ; Reset line buffer
	Q 
	;
	; Pre/post-processors
	;
VP1	; Column pre-processor - Variable: COLUMNS
	;
	N COLUMNS
	;
	S COLUMNS=vc13
	;
	; Make blank to null blank line
	I (COLUMNS="") S (VL)=""
	;
	Q 
	;
VP2	; Column pre-processor - Variable: ZSYSGEN
	;
	S ZSYSGEN=" type public Record"_vc2_" "_$$vStrLC(vc2,0)
	;
	Q 
	;
VP3	; Column pre-processor - Variable: ZSETAUD
	;
	S ZSETAUD=""
	;
	Q:'vc7 
	;
	; Before update trigger
	S ZSETAUD=" do "_$$vStrLC(vc2,0)_".setAuditFlag(1)"
	;
	Q 
	;
VP4	; Column pre-processor - Variable: CODE
	;
	N TABLE N TRGID
	;
	S verror=0
	S CODE=""
	;
	S TABLE=vc2
	S TRGID=vc3
	;
	N rs,vos1,vos2,vos3,vos4,vos5 S rs=$$vOpen1()
	;
	F  Q:'($$vFetch1())  D  Q:verror 
	.	S VL="          "_rs
	.	I VLC+2>IOSL D
	..		D VHDG0
	..		I VFMQ S verror=1
	..		Q 
	.	E  D VOM
	.	Q 
	;
	Q 
	; ----------------
	;  #OPTION ResultClass 0
vdat2str(object,mask)	; Date.toString
	;
	;  #OPTIMIZE FUNCTIONS OFF
	I (object="") Q ""
	I (mask="") S mask="MM/DD/YEAR"
	N cc N lday N lmon
	I mask="DL"!(mask="DS") D  ; Long or short weekday
	.	S cc=$get(^DBCTL("SYS","DVFM")) ; Country code
	.	I (cc="") S cc="US"
	.	S lday=$get(^DBCTL("SYS","*DVFM",cc,"D",mask))
	.	S mask="DAY" ; Day of the week
	.	Q 
	I mask="ML"!(mask="MS") D  ; Long or short month
	.	S cc=$get(^DBCTL("SYS","DVFM")) ; Country code
	.	I (cc="") S cc="US"
	.	S lmon=$get(^DBCTL("SYS","*DVFM",cc,"D",mask))
	.	S mask="MON" ; Month of the year
	.	Q 
	Q $ZD(object,mask,$get(lmon),$get(lday))
	; ----------------
	;  #OPTION ResultClass 0
vDbDe1()	; DELETE FROM TMPRPTBR WHERE JOBNO=:V1
	;
	;  #OPTIMIZE FUNCTIONS OFF
	N v1 N v2 N v3 N v4
	Tstart (vobj):transactionid="CS"
	N vRs,vos1,vos2,vos3,vos4,vos5 S vRs=$$vOpen2()
	F  Q:'($$vFetch2())  D
	.	S v1=$P(vRs,$C(9),1) S v2=$P(vRs,$C(9),2) S v3=$P(vRs,$C(9),3) S v4=$P(vRs,$C(9),4)
	.	;     #ACCEPT CR=18163;DATE=2006-01-09;PGM=FSCW;GROUP=BYPASS
	.	;*** Start of code by-passed by compiler
	.	ZWI ^TMPRPTBR(v1,v2,v3,v4)
	.	;*** End of code by-passed by compiler ***
	.	Q 
	Tcommit:$Tlevel 
	Q 
	; ----------------
	;  #OPTION ResultClass 0
vStrTrim(object,p1,p2)	; String.trim
	;
	;  #OPTIMIZE FUNCTIONS OFF
	I p1'<0 S object=$$RTCHR^%ZFUNC(object,p2)
	I p1'>0 F  Q:$E(object,1)'=p2  S object=$E(object,2,1048575)
	Q object
	; ----------------
	;  #OPTION ResultClass 0
vDbDe2()	; DELETE FROM TMPRPTBR WHERE JOBNO=:V1
	;
	;  #OPTIMIZE FUNCTIONS OFF
	N v1 N v2 N v3 N v4
	Tstart (vobj):transactionid="CS"
	N vRs,vos1,vos2,vos3,vos4,vos5 S vRs=$$vOpen3()
	F  Q:'($$vFetch3())  D
	.	S v1=$P(vRs,$C(9),1) S v2=$P(vRs,$C(9),2) S v3=$P(vRs,$C(9),3) S v4=$P(vRs,$C(9),4)
	.	;     #ACCEPT CR=18163;DATE=2006-01-09;PGM=FSCW;GROUP=BYPASS
	.	;*** Start of code by-passed by compiler
	.	ZWI ^TMPRPTBR(v1,v2,v3,v4)
	.	;*** End of code by-passed by compiler ***
	.	Q 
	Tcommit:$Tlevel 
	Q 
	; ----------------
	;  #OPTION ResultClass 0
vStrLC(vObj,v1)	; String.lowerCase
	;
	;  #OPTIMIZE FUNCTIONS OFF
	S vObj=$translate(vObj,"ABCDEFGHIJKLMNOPQRSTUVWXYZ����������������������������������������","abcdefghijklmnopqrstuvwxyz����������������������������������������")
	I v1 S vObj=$$vStrUC($E(vObj,1))_$E(vObj,2,1048575)
	Q vObj
	; ----------------
	;  #OPTION ResultClass 0
vStrUC(vObj)	; String.upperCase
	;
	;  #OPTIMIZE FUNCTIONS OFF
	Q $translate(vObj,"abcdefghijklmnopqrstuvwxyz����������������������������������������","ABCDEFGHIJKLMNOPQRSTUVWXYZ����������������������������������������")
	;
vDb2()	;	voXN = Db.getRecord(CUVAR,,0)
	;
	I '$D(^CUVAR)
	I $T S $ZS="-1,"_$ZPOS_",%PSL-E-RECNOFL,,CUVAR" X $ZT
	Q ""
	;
vOpen0(exe,vsql,vSelect,vFrom,vWhere,vOrderby,vGroupby,vParlist)	;	Dynamic MDB ResultSet
	;
	set sqlcur="V0.rwrs"
	N ER,vExpr,mode,RM,vTok S ER=0 ;=noOpti
	;
	S vExpr="SELECT "_vSelect_" FROM "_vFrom
	I vWhere'="" S vExpr=vExpr_" WHERE "_vWhere
	I vOrderby'="" S vExpr=vExpr_" ORDER BY "_vOrderby
	I vGroupby'="" S vExpr=vExpr_" GROUP BY "_vGroupby
	S vExpr=$$UNTOK^%ZS($$SQL^%ZS(vExpr,.vTok),vTok)
	;
	S sqlcur=$O(vobj(""),-1)+1
	;
	I $$FLT^SQLCACHE(vExpr,vTok,.vParlist)
	E  S vsql=$$OPEN^SQLM(.exe,vFrom,vSelect,vWhere,vOrderby,vGroupby,vParlist,,1,,sqlcur) I 'ER D SAV^SQLCACHE(vExpr,.vParlist)
	I ER S $ZS="-1,"_$ZPOS_",%PSL-E-SQLFAIL,"_$TR($G(RM),$C(10,44),$C(32,126)) X $ZT
	;
	S vos1=vsql
	Q ""
	;
vFetch0()	; MDB dynamic FETCH
	;
	; type public String exe(),sqlcur,vd,vi,vsql()
	;
	I vsql=0 Q 0
	S vsql=$$^SQLF(.exe,.vd,.vi,.sqlcur)
	S rwrs=vd
	S vos1=vsql
	S vos2=$G(vi)
	Q vsql
	;
vOpen1()	;	CODE FROM DBTBL7D WHERE %LIBS='SYSDEV' AND TABLE=:TABLE AND TRGID=:TRGID ORDER BY SEQ ASC
	;
	;
	S vos1=2
	D vL1a1
	Q ""
	;
vL1a0	S vos1=0 Q
vL1a1	S vos2=$G(TABLE) I vos2="" G vL1a0
	S vos3=$G(TRGID) I vos3="" G vL1a0
	S vos4=""
vL1a4	S vos4=$O(^DBTBL("SYSDEV",7,vos2,vos3,vos4),1) I vos4="" G vL1a0
	Q
	;
vFetch1()	;
	;
	I vos1=1 D vL1a4
	I vos1=2 S vos1=1
	;
	I vos1=0 Q 0
	;
	S vos5=$G(^DBTBL("SYSDEV",7,vos2,vos3,vos4))
	S rs=$P(vos5,$C(1),1)
	;
	Q 1
	;
vOpen2()	;	JOBNO,LINENO,PAGENO,SEQ FROM TMPRPTBR WHERE JOBNO=:V1
	;
	;
	S vos1=2
	D vL2a1
	Q ""
	;
vL2a0	S vos1=0 Q
vL2a1	S vos2=$G(V1) I vos2="" G vL2a0
	S vos3=""
vL2a3	S vos3=$O(^TMPRPTBR(vos2,vos3),1) I vos3="" G vL2a0
	S vos4=""
vL2a5	S vos4=$O(^TMPRPTBR(vos2,vos3,vos4),1) I vos4="" G vL2a3
	S vos5=""
vL2a7	S vos5=$O(^TMPRPTBR(vos2,vos3,vos4,vos5),1) I vos5="" G vL2a5
	Q
	;
vFetch2()	;
	;
	;
	I vos1=1 D vL2a7
	I vos1=2 S vos1=1
	;
	I vos1=0 Q 0
	;
	S vRs=vos2_$C(9)_$S(vos3=$$BYTECHAR^SQLUTL(254):"",1:vos3)_$C(9)_$S(vos4=$$BYTECHAR^SQLUTL(254):"",1:vos4)_$C(9)_$S(vos5=$$BYTECHAR^SQLUTL(254):"",1:vos5)
	;
	Q 1
	;
vOpen3()	;	JOBNO,LINENO,PAGENO,SEQ FROM TMPRPTBR WHERE JOBNO=:V1
	;
	;
	S vos1=2
	D vL3a1
	Q ""
	;
vL3a0	S vos1=0 Q
vL3a1	S vos2=$G(V1) I vos2="" G vL3a0
	S vos3=""
vL3a3	S vos3=$O(^TMPRPTBR(vos2,vos3),1) I vos3="" G vL3a0
	S vos4=""
vL3a5	S vos4=$O(^TMPRPTBR(vos2,vos3,vos4),1) I vos4="" G vL3a3
	S vos5=""
vL3a7	S vos5=$O(^TMPRPTBR(vos2,vos3,vos4,vos5),1) I vos5="" G vL3a5
	Q
	;
vFetch3()	;
	;
	;
	I vos1=1 D vL3a7
	I vos1=2 S vos1=1
	;
	I vos1=0 Q 0
	;
	S vRs=vos2_$C(9)_$S(vos3=$$BYTECHAR^SQLUTL(254):"",1:vos3)_$C(9)_$S(vos4=$$BYTECHAR^SQLUTL(254):"",1:vos4)_$C(9)_$S(vos5=$$BYTECHAR^SQLUTL(254):"",1:vos5)
	;
	Q 1
