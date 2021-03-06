DBSINDXS	;Private;Select Access key value 
	;;Copyright(c)2003 Sanchez Computer Associates, Inc.  All Rights Reserved - 02/13/03 12:35:39 - RUSSELL
	;     ORIG:  CHIANG - 12 JUN 1991
	;     DESC:  Select access method and return key value
	;
	; I18N=QUIT: Exclude from I18N standards
	;---------- Revision History -------------------------------------------
	; 09/28/04 - RussellDS - CR12334
	;	     Replaced obsoleted calls to ^DBSANS1 with new procedure
	;	     DBSGETID.
	;
	; 01/13/03 - Dan Russell - 51351
	;	     Remove references to ^DBSSQLCV.  Removed direct calls to 
	;	     ^CUVAR global.
	;
	;	     Remove old change history.
        ;
	;----------------------------------------------------------------------
	;
	N FID
	;
	I $G(%LIBS)="" S %LIBS="SYSDEV"
	;
	S FID=$$FIND^DBSGETID("DBTBL1",0) Q:FID=""
	;
	; ---------- Build Access key and index option prompts
	;
	D ACCESS(FID,1,"*")
	;
	Q
	;----------------------------------------------------------------------
ACCESS(file,mode,idxopt,noframe)	; Public ; Select acccess keys
	;----------------------------------------------------------------------
	;
	; ARGUMENTS:
	;
	;  .  file	DQ File Name		/TYP=T/REQ/MECH=VAL
	;  .  mode	Access Mode		/TYP=N/NOREQ/DEF=0/MECH=VAL
	;                 0 = Create
	;                 1 = Others (modify,delete,inquiry,...)
	;  . idxopt	Index options		/TYP=T/NOREQ/MECH=VAL
	;               (List of index names or * for all)
	;
	;  . noframe    Skip default screen frame	/TYP=L/NOREQ/DEF=0
	;
	; RETURNS:
	;
	;     If VFMQ="F"  Value of access keys
	;        VFMQ="Q"  Nothing selected
	;
	; EXAMPLE:
	;
	;  D ACCESS^DBSINDXS("APS",0)       return VENDNO (vendor number)
	;  D ACCESS^DBSINDXS("DEP",1,"*")   return CID (Account Number)
	;  D ACCESS^DBSINDXS("DEP",1,"XCC") Display XCC index prompt
	;  D ACCESS^DBSINDXS("ACH1",1)      Return COID and PTYPE
	;
	;-----------------------------------------------------------------------
	N %READ,%TAB,OLNTB,idx,idxn,Z,tbl,i,indexnm,zolntb,gbl,q,qq,pp,fmt,FID
	N zprimary,zkeys,order,pre,tbl1,X2,z,zhdr,zzhdr,prompt,z2,ztbl,zmsg
	N ZREAD,DBOPT,FIND,I,%MAX,vni,KVAR,GDSP,ZB,di,vbk,vglvn,zlev
	;
	I $G(file)="" Q
	I $G(%LIBS)="" N %LIBS S %LIBS="SYSDEV"
	;
	I '$D(^DBTBL(%LIBS,1,file)) Q		; *** - BC - Check valid file
	D fsn^DBSDD(.fsn,file)			; *** 07/03/96 file attributes
	I $P(fsn(file),"|",3)="" S VFMQ="F" Q	; *** Access key not defined
	;
	S mode=$G(mode)+0
	S idxopt=$G(idxopt)
	S zprimary=""
	;
	I $G(%LIBS)="" S %LIBS="SYSDEV"
	;
	S %READ="@@%FN,,",tbl="",tbl1="",q="""",qq=q_q	; *** BC - 06/28/94
	;
	; ---------- Use default look-up table syntax or global syntax
	;
	S gbl="^"_^DBTBL(%LIBS,1,file,0)
	I $P($G(^DBTBL(%LIBS,1,file,10)),"|",6)'="" S tbl="["_file_"]"
	S tbl1=gbl_"("
	S gbl=gbl_"("_qq_")"
	;					; Primary access key
	S Z=$P(^DBTBL(%LIBS,1,file,16),",",1),fmt=$p(^(9,Z),"|",9)
	;
	S pp=""
	;
	;----------------------------------------------------------------------
	; Set up prompts for access keys
	;----------------------------------------------------------------------
	;
	S z=$G(^DBTBL(%LIBS,1,file,16)),zlev=$L(z,",")
	;
	F i=1:1:zlev D
	.	;
	.	S di=$P(z,",",i),z2=tbl1 i tbl'="",i=zlev s z2=tbl
	.	S Z=$$TBLREF(z2)			; *** 09/08/95 BC
	.	I 'mode D				; Removed LASKKEY variable
	..		I i=zlev S pp="S:$D("_Z_") ER=1,RM=$$^MSG(2327)"
	..		S z2=z2_":NOVAL"		; Skip table validation
	.	D TAB(file,di,z2,pp)			; Create %TAB()
	.	S ZREAD(di)=i				; Key sequence
	.	I $E(tbl1)="^" S tbl1=tbl1_di_"," ; Primary Key
	.	;
	.	S zprimary=zprimary_di_","
	; Index Options
	S zmsg=$J("",25)_$$^MSG(8000)      ;   "Index Options"
	;
	; ---------- If key information entered, skip INDEX OPTION prompt
	;
	S z="I $L(X) S indexnm=""""" I 'mode s z=pp_" "_z	; *** 10/23/95 BC
	S $P(%TAB(di),"|",7)=z
	;
	S indexnm=""
	;
	; ---------- Index file option, create table in index name order
	;
	I idxopt'="",$D(^DBTBL(%LIBS,8,file)) S I=99,i=1 D
	.	I idxopt="*" D  Q			; Select all
	..	  	F  S I=$O(^DBTBL(%LIBS,8,file,I)) Q:I=""  D INDEX(file,I)
	.	F Z=1:1 S I=$P(idxopt,",",Z) Q:I=""  D
	..		I '$D(^DBTBL(%LIBS,8,file,I)) Q
	..		D INDEX(file,I)				; Create Prompt
	;
	;---------- Prompt for access keys and index keys
	;
	S OLNTB=40 I '$G(noframe) S %FRAME=2
	;					; Remove screen banner
	I $L(%READ,",")>22 S %READ=$P(%READ,",",3,99) I '$G(noframe) S %FRAME=1
	S %READ=$P(%READ,",",1,22)		; Maximum 16 index options
	D ^UTLREAD
	I VFMQ="Q" Q				; Exit
	;
	I indexnm="" Q				; Nothing selected
	;
	S indexnm=idxn(indexnm)
	;
	D INDEX(file,indexnm)
	;
	Q
	;----------------------------------------------------------------------
TBLREF(tbl)	; Translate table reference into global always
	;----------------------------------------------------------------------
	;
	I "^["'[$E(tbl) Q ""
	N vglvn,x,y,z,def,i
	S def=""
	;
	I $E(tbl)="[" D
	.	N file
	.	S file=$E($P(tbl,"]",1),2,99)
	.	I '$D(fsn(file)) N fsn D fsn^DBSDD(.fsn,file)
	.	S tbl=$P(fsn(file),"|",2)		; Global reference
	.	I tbl'["," S tbl=$P(tbl,"(",1)_"("
	.	E  S tbl=$P(tbl,",",1,$L(tbl,",")-1)_","
	;
	I $E(tbl)="^" S z=tbl_"X)"
	;
	S x=$P(z,"(",2),x=$P(x,")",1) F i=1:1 s y=$P(x,",",i) q:y=""  D
	.	I y="X" Q			; Single level key
	.	I $E(y)="""" Q			; Dummy key "..."
	.	I $E(y)?1N Q			; Dummy key
	.	I $E(y)="[" Q			; ^GLOBAL([key]di,[... v 5.1
	.	S def=def_",$G("_y_")'="""""
	Q z
	;
	;-----------------------------------------------------------------------
INDEX(file,indexnm)	; Private ; Return global syntax based on an index name
	;-----------------------------------------------------------------------
	; ARGUMENTS:
	;
	;  file		DQ File Name		/TYP=T/REQ/MECH=VAL
	;  indexnm	Index Name		/TYP=T/REQ/MECH=VAL
	;
	; INPUTS:
	;
	;   %LIBS,%READ
	;
	; RETURNS:
	;
	; . %TAB()	Data Entry Table	/TYP=T/MECH=REFNAM:W
	; . %READ	Prompt order		/TYP=T/MECH=VAL
	;
	;----------------------------------------------------------------------
	;
	N di,gbl,i,lev,order,pp,pre,prompt,q,s,z,Q,OLNTB,QRY,upcase
	;
	I $G(file)="" Q
	I $G(indexnm)="" Q
	;
	S z=0,Q=$C(34)
	;
	; ---------- locate index name
	;
	I '$D(^DBTBL(%LIBS,8,file,indexnm)) Q
	;
	S gbl=$P(^(indexnm),"|",2),order=$P(^(indexnm),"|",3),s=$L(order,",")-1
	S prompt=$P(^(indexnm),"|",5)
	S upcase=$p(^(indexnm),"|",14)			; *** 09/26/94 BC
	I gbl="DAYEND" Q				; Skip IBS DAYEND index
	I order["<<" Q					; Skip <<var>> index
	;
	I gbl="" S lev(1)="^XDBREF("_Q_file_"."_indexnm_Q_","
	E  S lev(1)="^"_gbl_"("
	;
	; ---------- set up look-up tables for each index key level
	;
	F i=1:1:s S lev(i+1)=lev(i)_$P(order,",",i)_","
	;
	; ---------- set up prompts for each index level
	;
	S pp="D PP1^DBSINDXS"
	;
	F i=1:1:s+1 S di=$P(order,",",i) I $e(di)'="""" Q
	S pre="s ztbl="_""""_$$DOUBLE(lev(i))_""""
	S pre=pre_",zhdr="_""""_prompt_""""
	;
	S di=$P(order,",",i)			; First key for this index
	I $D(ZREAD(di)) Q			; Already in %READ list
	S ZREAD(di)=order
	;	
	I %READ'["@zmsg#2" S %READ=%READ_",@zmsg#2,,"
	D TAB(file,di,lev(i),pp,pre,prompt,upcase)	; Create %TAB() and %READ list
	;
	Q
	;-----------------------------------------------------------------------
TAB(file,di,table,pp,pre,prompt,upcase)	; private ; Build %TAB() table
	;-----------------------------------------------------------------------
	;
	; ARGUMENTS:
	;
	; . file	DQ File Name		/TYP=T/REQ/MECH=VAL
	; . di		Data Item Name		/TYP=T/REQ/MECH=VAL
	; . table	Lookup Table		/TYP=T/REQ/MECH=VAL
	; . pp		Field Post-Processor	/TYP=T/REQ/MECH=VAL
	; . pre		Field Pre-Processor	/TYP=T/NOREQ/MECH=VAL
	; . prompt	Field Prompt		/TYP=T/NOREQ/MECH=VAL
	; . upcase	Uppercase format	/TYP=L/NOREQ/MECH=VAL
	;
	; INPUTS:
	;
	;   %LIBS,%READ
	;
	; RETURNS:
	;
	; . %TAB()	Data Entry Table	/TYP=T/MECH=REFNAM:W
	; . %READ	Prompt order		/TYP=T/MECH=VAL
	;
	;-----------------------------------------------------------------------
	N i,x,x3,z,zkeys
	;
	I di?1N.E Q					; Numeric key
	I $D(zkeys(di)) Q				; Already Assigned
	;
	S %READ=$G(%READ)				; Prompts
	S zkeys(di)=""
	I $E(di)="""" Q  				; "text"
	I di["=" S di=$P(di,"=",1)			; key1,key2,...=value
	I di?1"<<"1E.E1">>" Q 				; <<variable>>
	S z="",x=^DBTBL(%LIBS,1,file,9,di)		; data item attributes
	S x3=$P(x,"|",3)
	F i=2,3,5,9,10 s $p(z,"|",i)=$p(x,"|",i)	; length,type,prompt
	I x3?1"<<".E S $p(z,"|",3)=$$VARIABLE^DBSCRT8(x3)
	I $L(pp) s $p(z,"|",7)=pp			; post-processor
	S $p(z,"|",8)=$G(pre)
	I $p(x,"|",5)'="" D				;2/7/96 mas
	.	N zfile,global
	.	S global="^"_$p(^DBTBL(%LIBS,1,file,0),"|",1)
	.	S table=$P(x,"|",5)
	.	I mode Q
	.	S zfile="["_file_"]"
	.	I table'[zfile,table'[global Q
	.	S table=table_$S('mode:":NOVAL",1:"")
	S $P(z,"|",5)=$G(table)			
	I $G(prompt)'="" S $P(z,"|",10)=prompt
	;
	I $P(z,"|",12)="" S $P(z,"|",12)=$P(x,"|",12)	; Min
	I $P(z,"|",13)="" S $P(z,"|",13)=$P(x,"|",13)	; Max
	;						; *** 09/26/94 BC
	I $G(upcase) S $P(z,"|",9)="U"			; *** Uppercase format
	S %TAB(di)=z ;					; set up table entry
	;
	; ---------- Not required if prompt for keys and index information
	;
	I di="%LIBS" Q					; *** 03/15/96
	I $O(^DBTBL(%LIBS,8,file,""))'="" S %READ=%READ_di_"/NOREQ,"
	E  S %READ=%READ_di_"/REQ," ;			; prompts
	I $E(di)'="%",$G(@di)="" S @di=$p(z,"|",3)	; *** BC - Changed from ;1/4/96 mas 
	Q						; NULL to default value
	;						; v4.4 changes
	;-----------------------------------------------------------------------
PP1	; Private ; Post-processor for each index key prompt
	;-----------------------------------------------------------------------
	I X="" Q
	N zgbl,gbl,ngbl,len,zzz,z,q,line,quit,keys,i,n,key,ytbl,zimp
	;
	K RM
	;
	S quit=0,q="""" I X=+X S q=""
	S gbl=ztbl_q_X,ngbl=gbl_q_")",zimp=""
	S ytbl=ztbl I $E(ytbl,1,2)="^[" S ytbl="^"_$P(ztbl,"]",2,99),zimp=$P(ztbl,"]",1)_"]"
	S zgbl=$P(gbl,"(",2),len=$L(zgbl)		; 05/11/93 BC
	F i=1:1 S ngbl=$Q(@ngbl) Q:$E($P(ngbl,"(",2),1,len)'=zgbl  D  I quit Q
	.	;
	.	S z=$P(ngbl,ytbl,2)
	.	I $E(z)="""" s z2=$E($P(z,$C(34),3,99),2,99),z2=$P(z2,")",1)
	.	I  S z1=$E($P(z,$C(34),1,2),2,99)
	.	E  s z1=$P(z,",",1),z2=$P($p(z,",",2,99),")",1)
	.	;
	.	S zzz(i)=z1_$J("",40-$L(z1))_z2
	.	; ~p1 entries selected ... Continue?
	.	I i#50=0,'$$YN^DBSMBAR("",$$^MSG(3033,i),1) S quit=1
	.	;
	.	I zimp'="" s ngbl=zimp_$E(ngbl,2,999)	; ^[...]global
	; No matches found
	I '$D(zzz) S ER=1,RM=$$^MSG(1955) Q
	;
	I i=2 S i=1 D PP1A Q
	I E67>14 S zzhdr=$J("",14)_$G(zhdr)
	E  S zzhdr=$J("",E67+2)_$G(zhdr)
	S i=$$^DBSTBL("zzz(","","N",zzhdr)
	S vdspscr=1				; *** - BC - Redisplay screen
	S X="" I i="" S NI=NI-1 Q
	;
PP1A	;---------- Parse out access keys
	;
	S line=zzz(i),n=1
	S keys=$E(line,41,999),RM(1)=$E(line,1,E67)
	;
	S zkeys=$E(I(1),2,99)				; Index Name
	S order=ZREAD(zkeys)				; Order By Info
	F j=1:1 S z=$P(order,",",j) Q:z=""  I z=zkeys Q
	S order=$P(order,",",j+1,99)			; Remaining keys
	;
	F i=1:1 S z=$P(keys,",",i) Q:z=""  D
	.	;
	.	S key=$P(order,",",i)			; Map to key name
	.	I '(($E(key)?1A)!($E(key)="%")) Q	; Dummy key name
	.	I $G(ZREAD(key)) D
	..		I $E(z)="""" S z=$E(z,2,$L(z)-1)
	..		S RM(n+1)=z_"|"_ZREAD(key),n=n+1 ; Display Primary keys
	..		S @key=z			; Update key value
	;
	S X=""
	Q
	;
	;----------------------------------------------------------------------
MODE(file)	; Return %O   0=create  1=modify  -1=invalid keys
	;----------------------------------------------------------------------
	;
	;  Input:  file  - DQ file name
	;          variables for access keys
	;          (example:  CID for LN file, ACN for CIF file)
	;
	N I,ER,name,gbl
	;
	S ER=0
	;
	I $G(%LIBS)="" S %LIBS="SYSDEV"
	;
	I $G(file)="" q -1
	I '$D(^DBTBL(%LIBS,1,file)) q -1
	;
	s gbl="^"_^DBTBL(%LIBS,1,file,0)_"(" ;		^global(
	;
	S z=^DBTBL(%LIBS,1,file,16)			; *** 10/17/96
	F I=1:1:$L(z,",") S name=$P(z,",",I) D MODE1 Q:ER
	I ER Q -1
	;
	S gbl=$E(gbl,1,$L(gbl)-1)_")" ;			Full global syntax
	;
	I '$D(@gbl) Q 0 ;				Create
	E  Q 1 ;					Modify
	;
MODE1	;
	I name?1A.AN,$G(@name)="" S ER=1 Q  ;			Invalid key name
	;
	s gbl=gbl_name_","
	Q
	;----------------------------------------------------------------------
DOUBLE(X)	; Change every " to ""
	;----------------------------------------------------------------------
	;
	I X["""""" Q X
	N I,L
	S L=0
	F I=1:1 S L=$F(X,$C(34),L) Q:L<1  S X=$E(X,1,L-2)_$C(34)_$C(34)_$E(X,L,999),L=L+1
	Q X
