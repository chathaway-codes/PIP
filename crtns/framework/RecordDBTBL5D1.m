 ; 
 ; **** Routine compiled from DATA-QWIK Filer RecordDBTBL5D1 ****
 ; 
 ; 02/24/2010 18:40 - pip
 ; 
 ;
 ; Record Class code for table DBTBL5D1
 ;
 ; Generated by PSLRecordBuilder on 02/24/2010 at 18:40 by
 ;
vcdmNew() ; 
 N vOid
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=BYPASS
 ;*** Start of code by-passed by compiler
 S vOid=$O(vobj(""),-1)+1,vobj(vOid,-1)="RecordDBTBL5D1",vobj(vOid,-2)=0,vobj(vOid)=""
 S vobj(vOid,-3)=""
 S vobj(vOid,-4)=""
 S vobj(vOid,-5)=""
 S vobj(vOid,-6)=""
 S vobj(vOid,-7)=""
 ;*** End of code by-passed by compiler ***
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=SCOPE
 Q vOid
 ;
vRCgetRecord0(v1,v2,v3,v4,v5,vfromDbSet) ; 
 N vOid
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=BYPASS
 ;*** Start of code by-passed by compiler
 S vOid=$O(vobj(""),-1)+1,vobj(vOid,-1)="RecordDBTBL5D1"
 S vobj(vOid)=$G(^DBTBL(v1,5,v2,v3,v4,v5))
 I '(v4>100)
 E  I vobj(vOid)="",'($D(^DBTBL(v1,5,v2,v3,v4,v5))#2)
 S vobj(vOid,-2)=1
 I $T K vobj(vOid) S $ZE="0,"_$ZPOS_",%PSL-E-RECNOFL,,DBTBL5D1",$EC=",U1001,"
 S vobj(vOid,-3)=v1
 S vobj(vOid,-4)=v2
 S vobj(vOid,-5)=v3
 S vobj(vOid,-6)=v4
 S vobj(vOid,-7)=v5
 ;*** End of code by-passed by compiler ***
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=SCOPE
 Q vOid
 ;
vRCgetRecord1(v1,v2,v3,v4,v5,vfromDbSet) ; 
 N vOid
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=BYPASS
 ;*** Start of code by-passed by compiler
 S vOid=$O(vobj(""),-1)+1,vobj(vOid,-1)="RecordDBTBL5D1"
 S vobj(vOid)=$G(^DBTBL(v1,5,v2,v3,v4,v5))
 I '(v4>100)
 E  I vobj(vOid)="",'($D(^DBTBL(v1,5,v2,v3,v4,v5))#2)
 S vobj(vOid,-2)='$T
 S vobj(vOid,-3)=v1
 S vobj(vOid,-4)=v2
 S vobj(vOid,-5)=v3
 S vobj(vOid,-6)=v4
 S vobj(vOid,-7)=v5
 ;*** End of code by-passed by compiler ***
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=SCOPE
 Q vOid
 ;
vRCgetRecord0Opt(v1,v2,v3,v4,v5,vfromDbSet,v2out) ; 
 N dbtbl5d1
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=BYPASS
 ;*** Start of code by-passed by compiler
 S dbtbl5d1=$G(^DBTBL(v1,5,v2,v3,v4,v5))
 I '(v4>100)
 E  I dbtbl5d1="",'($D(^DBTBL(v1,5,v2,v3,v4,v5))#2)
 S v2out=1
 I $T S $ZE="0,"_$ZPOS_",%PSL-E-RECNOFL,,DBTBL5D1",$EC=",U1001,"
 ;*** End of code by-passed by compiler ***
 Q dbtbl5d1
 ;
vRCgetRecord1Opt(v1,v2,v3,v4,v5,vfromDbSet,v2out) ; 
 N dbtbl5d1
 ;  #ACCEPT DATE=02/26/2008; PGM=Dan Russell; CR=30801; Group=BYPASS
 ;*** Start of code by-passed by compiler
 S dbtbl5d1=$G(^DBTBL(v1,5,v2,v3,v4,v5))
 I '(v4>100)
 E  I dbtbl5d1="",'($D(^DBTBL(v1,5,v2,v3,v4,v5))#2)
 S v2out='$T
 ;*** End of code by-passed by compiler ***
 Q dbtbl5d1
 ;
vBypassSave(this) ; 
 D vSave(this,"/NOJOURNAL/NOTRIGAFT/NOTRIGBEF/NOVALDD/NOVALREQ/NOVALRI/NOVALST",0)
 Q 
 ;
vSave(this,vRCparams,vauditLogSeq) ; 
 N vRCaudit N vRCauditIns
 N %O S %O=$G(vobj(this,-2))
 I ($get(vRCparams)="") S vRCparams="/CASDEL/INDEX/JOURNAL/LOG/TRIGAFT/TRIGBEF/UPDATE/VALDD/VALFK/VALREQ/VALRI/VALST/"
 I (%O=0) D
 .	D AUDIT^UCUTILN(this,.vRCauditIns,1,$char(12))
 .	I (("/"_vRCparams_"/")["/VALREQ/") D vRCchkReqForInsert(this)
 .	I (("/"_vRCparams_"/")["/VALDD/") D vRCvalidateDD(this,%O)
 .	D vRCmiscValidations(this,vRCparams,%O)
 .	D vRCupdateDB(this,%O,vRCparams,.vRCaudit,.vRCauditIns)
 .	Q 
 E  I (%O=1) D
 .	D AUDIT^UCUTILN(this,.vRCaudit,1,$char(12))
 .	I ($D(vobj(this,-100,"1*","LIBS"))&($P($E($G(vobj(this,-100,"1*","LIBS")),5,9999),$C(12))'=vobj(this,-3)))!($D(vobj(this,-100,"2*","RID"))&($P($E($G(vobj(this,-100,"2*","RID")),5,9999),$C(12))'=vobj(this,-4)))!($D(vobj(this,-100,"3*","GRP"))&($P($E($G(vobj(this,-100,"3*","GRP")),5,9999),$C(12))'=vobj(this,-5)))!($D(vobj(this,-100,"4*","ITMSEQ"))&($P($E($G(vobj(this,-100,"4*","ITMSEQ")),5,9999),$C(12))'=vobj(this,-6)))!($D(vobj(this,-100,"5*","SEQ"))&($P($E($G(vobj(this,-100,"5*","SEQ")),5,9999),$C(12))'=vobj(this,-7))) D vRCkeyChanged(this,vRCparams,.vRCaudit) Q 
 .	I (("/"_vRCparams_"/")["/VALREQ/") D vRCchkReqForUpdate(this)
 .	I (("/"_vRCparams_"/")["/VALDD/") D vRCvalidateDD1(this)
 .	D vRCmiscValidations(this,vRCparams,%O)
 .	D vRCupdateDB(this,%O,vRCparams,.vRCaudit,.vRCauditIns)
 .	Q 
 E  I (%O=2) D
 .	I (("/"_vRCparams_"/")["/VALREQ/") D vRCchkReqForInsert(this)
 .	I (("/"_vRCparams_"/")["/VALDD/") D vRCvalidateDD(this,%O)
 .	D vRCmiscValidations(this,vRCparams,2)
 .	Q 
 E  I (%O=3) D
 .	  N V1,V2,V3,V4,V5 S V1=vobj(this,-3),V2=vobj(this,-4),V3=vobj(this,-5),V4=vobj(this,-6),V5=vobj(this,-7) Q:'$$vDbEx1() 
 .	D vRCdelete(this,vRCparams,.vRCaudit,0)
 .	Q 
 Q 
 ;
vcheckAccessRights() ; 
 Q ""
 ;
vinsertAccess(userclass) ; 
 Q 1
 ;
vinsertOK(this,userclass) ; PUBLIC access is allowed, no restrict clause
 Q 1
 ;
vupdateAccess(userclass) ; 
 Q 1
 ;
vupdateOK(this,userclass) ; PUBLIC access is allowed, no restrict clause
 Q 1
 ;
vdeleteAccess(userclass) ; 
 Q 1
 ;
vdeleteOK(this,userclass) ; PUBLIC access is allowed, no restrict clause
 Q 1
 ;
vselectAccess(userclass,restrict,from) ; 
 S (restrict,from)=""
 Q 1
 ;
vselectOK(this,userclass) ; PUBLIC access is allowed, no restrict clause
 Q 1
 ;
vselectOptmOK(userclass,dbtbl5d1,vkey1,vkey2,vkey3,vkey4,vkey5) ; PUBLIC access is allowed, no restrict clause
 Q 1
 ;
vgetLogging() ; 
 Q "0"
 ;
logUserclass(operation) ; 
 I (operation="INSERT") Q 0
 E  I (operation="UPDATE") Q 0
 E  I (operation="DELETE") Q 0
 E  I (operation="SELECT") Q 0
 Q 0
 ;
vlogSelect(statement,using) ; 
 Q 0
 ;
columnList() ; 
 Q $$vStrRep("DATA,GRP,ITMSEQ,LIBS,RID,SEQ",",",$char(9),0,0,"")
 ;
columnListBM() ; 
 Q ""
 ;
columnListCMP() ; 
 Q $$vStrRep("",",",$char(9),0,0,"")
 ;
getColumnMap(map) ; 
 ;
 S map(-7)="SEQ:N:"
 S map(-6)="ITMSEQ:N:"
 S map(-5)="GRP:U:"
 S map(-4)="RID:T:"
 S map(-3)="LIBS:T:"
 S map(-1)="DATA:T:1"
 Q 
 ;
vlegacy(processMode,params) ; 
 N vTp
 I (processMode=2) D
 .	N dbtbl5d1 S dbtbl5d1=$$vRCgetRecord0^RecordDBTBL5D1(LIBS,RID,GRP,ITMSEQ,SEQ,0)
 .	S vobj(dbtbl5d1,-2)=2
 . S vTp=($TL=0) TS:vTp (vobj):transactionid="CS" D vSave^RecordDBTBL5D1(dbtbl5d1,$$initPar^UCUTILN(params)) K vobj(dbtbl5d1,-100) S vobj(dbtbl5d1,-2)=1 TC:vTp  
 .	K vobj(+$G(dbtbl5d1)) Q 
 Q 
 ;
vhasLiterals() ; 
 Q 0
 ;
vRCmiscValidations(this,vRCparams,processMode) ; 
 I (("/"_vRCparams_"/")["/VALST/")  N V1,V2,V3,V4,V5 S V1=vobj(this,-3),V2=vobj(this,-4),V3=vobj(this,-5),V4=vobj(this,-6),V5=vobj(this,-7) I '(''$$vDbEx2()=''processMode) D
 .	N errmsg
 .	I (+processMode'=+0) S errmsg=$$^MSG(7932)
 .	E  S errmsg=$$^MSG(2327)
 .	D throwError(errmsg)
 .	Q 
 Q 
 ;
vRCupdateDB(this,processMode,vRCparams,vRCaudit,vRCauditIns) ; 
 I '(("/"_vRCparams_"/")["/NOUPDATE/") D
 .	;   #ACCEPT DATE=04/22/04; PGM=Dan Russell; CR=20602; GROUP=BYPASS
 .	;*** Start of code by-passed by compiler
 .	if $D(vobj(this)) S ^DBTBL(vobj(this,-3),5,vobj(this,-4),vobj(this,-5),vobj(this,-6),vobj(this,-7))=vobj(this)
 .	;*** End of code by-passed by compiler ***
 .	Q 
 Q 
 ;
vRCdelete(this,vRCparams,vRCaudit,isKeyChange) ; 
 ;  #ACCEPT DATE=04/22/04; PGM=Dan Russell; CR=20602; Group=BYPASS
 ;*** Start of code by-passed by compiler
 ZWI ^DBTBL(vobj(this,-3),5,vobj(this,-4),vobj(this,-5),vobj(this,-6),vobj(this,-7))
 ;*** End of code by-passed by compiler ***
 Q 
 ;
vRCchkReqForInsert(this) ; 
 I (vobj(this,-5)="") D vRCrequiredErr("GRP")
 I (vobj(this,-6)="") D vRCrequiredErr("ITMSEQ")
 I (vobj(this,-3)="") D vRCrequiredErr("LIBS")
 I (vobj(this,-4)="") D vRCrequiredErr("RID")
 I (vobj(this,-7)="") D vRCrequiredErr("SEQ")
 Q 
 ;
vRCchkReqForUpdate(this) ; 
 I (vobj(this,-3)="") D vRCrequiredErr("LIBS")
 I (vobj(this,-4)="") D vRCrequiredErr("RID")
 I (vobj(this,-5)="") D vRCrequiredErr("GRP")
 I (vobj(this,-6)="") D vRCrequiredErr("ITMSEQ")
 I (vobj(this,-7)="") D vRCrequiredErr("SEQ")
 Q 
 ;
vRCrequiredErr(column) ; 
 N ER S ER=0
 N RM S RM=""
 D SETERR^DBSEXECU("DBTBL5D1","MSG",1767,"DBTBL5D1."_column)
 I ER D throwError($get(RM))
 Q 
 ;
vRCvalidateDD(this,processMode) ; 
 N ER S ER=0
 N RM S RM=""
 N errmsg N X
 I ($L(vobj(this,-3))>12) D vRCvalidateDDerr("LIBS",$$^MSG(1076,12))
 I ($L(vobj(this,-4))>12) D vRCvalidateDDerr("RID",$$^MSG(1076,12))
 I (vobj(this,-5)'=$ZCONVERT(vobj(this,-5),"U")) D vRCvalidateDDerr("GRP",$$^MSG(1476))
 I ($L(vobj(this,-5))>33) D vRCvalidateDDerr("GRP",$$^MSG(1076,33))
 I '(vobj(this,-6)=""),'(+vobj(this,-6)=vobj(this,-6))  S vobj(this,-6)=$$vRCtrimNumber(vobj(this,-6))
 S X=vobj(this,-6) I '(X=""),(X'?1.12N),(X'?1"-"1.11N) D vRCvalidateDDerr("ITMSEQ",$$^MSG(742,"N"))
 I '(vobj(this,-7)=""),'(+vobj(this,-7)=vobj(this,-7))  S vobj(this,-7)=$$vRCtrimNumber(vobj(this,-7))
 S X=vobj(this,-7) I '(X="") S errmsg=$$VAL^DBSVER("N",12,1,,,,,3) I '(errmsg="") D vRCvalidateDDerr("SEQ",$$^MSG(979,"DBTBL5D1.SEQ"_" "_errmsg))
 I ($L($P(vobj(this),$C(12),1))>400) D vRCvalidateDDerr("DATA",$$^MSG(1076,400))
 Q 
 ;
vRCvalidateDD1(this) ; 
 N ER S ER=0
 N RM S RM=""
 N errmsg N X
 I ($D(vobj(this,-100,"1*","LIBS"))&($P($E($G(vobj(this,-100,"1*","LIBS")),5,9999),$C(12))'=vobj(this,-3))) I ($L(vobj(this,-3))>12) D vRCvalidateDDerr("LIBS",$$^MSG(1076,12))
 I ($D(vobj(this,-100,"2*","RID"))&($P($E($G(vobj(this,-100,"2*","RID")),5,9999),$C(12))'=vobj(this,-4))) I ($L(vobj(this,-4))>12) D vRCvalidateDDerr("RID",$$^MSG(1076,12))
 I (vobj(this,-5)'=$ZCONVERT(vobj(this,-5),"U")) D vRCvalidateDDerr("GRP",$$^MSG(1476))
 I ($D(vobj(this,-100,"3*","GRP"))&($P($E($G(vobj(this,-100,"3*","GRP")),5,9999),$C(12))'=vobj(this,-5))) I ($L(vobj(this,-5))>33) D vRCvalidateDDerr("GRP",$$^MSG(1076,33))
 I ($D(vobj(this,-100,"4*","ITMSEQ"))&($P($E($G(vobj(this,-100,"4*","ITMSEQ")),5,9999),$C(12))'=vobj(this,-6))),'(vobj(this,-6)=""),'(+vobj(this,-6)=vobj(this,-6))  S vobj(this,-6)=$$vRCtrimNumber(vobj(this,-6))
 I ($D(vobj(this,-100,"4*","ITMSEQ"))&($P($E($G(vobj(this,-100,"4*","ITMSEQ")),5,9999),$C(12))'=vobj(this,-6))) S X=vobj(this,-6) I '(X=""),(X'?1.12N),(X'?1"-"1.11N) D vRCvalidateDDerr("ITMSEQ",$$^MSG(742,"N"))
 I ($D(vobj(this,-100,"5*","SEQ"))&($P($E($G(vobj(this,-100,"5*","SEQ")),5,9999),$C(12))'=vobj(this,-7))),'(vobj(this,-7)=""),'(+vobj(this,-7)=vobj(this,-7))  S vobj(this,-7)=$$vRCtrimNumber(vobj(this,-7))
 I ($D(vobj(this,-100,"5*","SEQ"))&($P($E($G(vobj(this,-100,"5*","SEQ")),5,9999),$C(12))'=vobj(this,-7))) S X=vobj(this,-7) I '(X="") S errmsg=$$VAL^DBSVER("N",12,1,,,,,3) I '(errmsg="") D vRCvalidateDDerr("SEQ",$$^MSG(979,"DBTBL5D1.SEQ"_" "_errmsg))
 I ($D(vobj(this,-100,"0*","DATA"))&($P($E($G(vobj(this,-100,"0*","DATA")),5,9999),$C(12))'=$P(vobj(this),$C(12),1))) I ($L($P(vobj(this),$C(12),1))>400) D vRCvalidateDDerr("DATA",$$^MSG(1076,400))
 Q 
 ;
vRCvalidateDDerr(column,errmsg) ; 
 N ER S ER=0
 N RM S RM=""
 D SETERR^DBSEXECU("DBTBL5D1","MSG",979,"DBTBL5D1."_column_" "_errmsg)
 I ER D throwError($get(RM))
 Q 
 ;
vRCtrimNumber(str) ; 
 I ($E(str,1)="0") S str=$$vStrTrim(str,-1,"0") I (str="") S str="0"
 I (str["."),($E(str,$L(str))="0") S str=$$RTCHR^%ZFUNC(str,"0") I ($E(str,$L(str))=".") S str=$E(str,1,$L(str)-1) I (str="") S str="0"
 Q str
 ;
vRCkeyChanged(this,vRCparams,vRCaudit) ; 
 N vTp
 N newkeys N oldkeys N vRCauditIns
 N newKey1 S newKey1=vobj(this,-3)
 N oldKey1 S oldKey1=$S($D(vobj(this,-100,"1*","LIBS")):$P($E(vobj(this,-100,"1*","LIBS"),5,9999),$C(12)),1:vobj(this,-3))
 N newKey2 S newKey2=vobj(this,-4)
 N oldKey2 S oldKey2=$S($D(vobj(this,-100,"2*","RID")):$P($E(vobj(this,-100,"2*","RID"),5,9999),$C(12)),1:vobj(this,-4))
 N newKey3 S newKey3=vobj(this,-5)
 N oldKey3 S oldKey3=$S($D(vobj(this,-100,"3*","GRP")):$P($E(vobj(this,-100,"3*","GRP"),5,9999),$C(12)),1:vobj(this,-5))
 N newKey4 S newKey4=vobj(this,-6)
 N oldKey4 S oldKey4=$S($D(vobj(this,-100,"4*","ITMSEQ")):$P($E(vobj(this,-100,"4*","ITMSEQ"),5,9999),$C(12)),1:vobj(this,-6))
 N newKey5 S newKey5=vobj(this,-7)
 N oldKey5 S oldKey5=$S($D(vobj(this,-100,"5*","SEQ")):$P($E(vobj(this,-100,"5*","SEQ"),5,9999),$C(12)),1:vobj(this,-7))
  N V1,V2,V3,V4,V5 S V1=vobj(this,-3),V2=vobj(this,-4),V3=vobj(this,-5),V4=vobj(this,-6),V5=vobj(this,-7) I $$vDbEx3() D throwError($$^MSG(2327))
 S newkeys=newKey1_","_newKey2_","_newKey3_","_newKey4_","_newKey5
 S oldkeys=oldKey1_","_oldKey2_","_oldKey3_","_oldKey4_","_oldKey5
  S vobj(this,-3)=oldKey1
  S vobj(this,-4)=oldKey2
  S vobj(this,-5)=oldKey3
  S vobj(this,-6)=oldKey4
  S vobj(this,-7)=oldKey5
 S vRCparams=$$setPar^UCUTILN(vRCparams,"NOINDEX")
 I (("/"_vRCparams_"/")["/VALREQ/") D vRCchkReqForInsert(this)
 I (("/"_vRCparams_"/")["/VALDD/") D vRCvalidateDD(this,1)
 D vRCmiscValidations(this,vRCparams,1)
 D vRCupdateDB(this,1,vRCparams,.vRCaudit,.vRCauditIns)
  S vobj(this,-3)=newKey1
  S vobj(this,-4)=newKey2
  S vobj(this,-5)=newKey3
  S vobj(this,-6)=newKey4
  S vobj(this,-7)=newKey5
 N newrec S newrec=$$vReCp1(this)
 S vobj(newrec,-2)=0
 S vTp=($TL=0) TS:vTp (vobj):transactionid="CS" D vSave^RecordDBTBL5D1(newrec,$$initPar^UCUTILN($$initPar^UCUTILN("/NOVAL/NOCASDEL/NOJOURNAL/NOTRIGBEF/NOTRIGAFT/"))) K vobj(newrec,-100) S vobj(newrec,-2)=1 TC:vTp  
 D
 .	N %O S %O=1
 .	N ER S ER=0
 .	N RM S RM=""
 .	;   #ACCEPT Date=10/24/2008; Pgm=RussellDS; CR=30801; Group=ACCESS
 .	D CASUPD^DBSEXECU("DBTBL5D1",oldkeys,newkeys)
 .	I ER D throwError($get(RM))
 .	Q 
  S vobj(this,-3)=oldKey1
  S vobj(this,-4)=oldKey2
  S vobj(this,-5)=oldKey3
  S vobj(this,-6)=oldKey4
  S vobj(this,-7)=oldKey5
 S vRCparams=$$initPar^UCUTILN("/NOVAL/NOCASDEL/NOJOURNAL/NOTRIGBEF/NOTRIGAFT/")
 D vRCdelete(this,vRCparams,.vRCaudit,1)
  S vobj(this,-3)=newKey1
  S vobj(this,-4)=newKey2
  S vobj(this,-5)=newKey3
  S vobj(this,-6)=newKey4
  S vobj(this,-7)=newKey5
 K vobj(+$G(newrec)) Q 
 ;
throwError(MSG) ; 
 S $ZE="0,"_$ZPOS_","_"%PSL-E-DBFILER,"_$translate(MSG,",","~"),$EC=",U1001,"
 Q 
 ; ----------------
 ;  #OPTION ResultClass 1
vStrRep(object,p1,p2,p3,p4,qt) ; String.replace
 ;
 ;  #OPTIMIZE FUNCTIONS OFF
 ;
 I p3<0 Q object
 I $L(p1)=1,$L(p2)<2,'p3,'p4,(qt="") Q $translate(object,p1,p2)
 ;
 N y S y=0
 F  S y=$$vStrFnd(object,p1,y,p4,qt) Q:y=0  D
 .	S object=$E(object,1,y-$L(p1)-1)_p2_$E(object,y,1048575)
 .	S y=y+$L(p2)-$L(p1)
 .	I p3 S p3=p3-1 I p3=0 S y=$L(object)+1
 .	Q 
 Q object
 ; ----------------
 ;  #OPTION ResultClass 1
vStrTrim(object,p1,p2) ; String.trim
 ;
 ;  #OPTIMIZE FUNCTIONS OFF
 I p1'<0 S object=$$RTCHR^%ZFUNC(object,p2)
 I p1'>0 F  Q:$E(object,1)'=p2  S object=$E(object,2,1048575)
 Q object
 ; ----------------
 ;  #OPTION ResultClass 1
vStrFnd(object,p1,p2,p3,qt) ; String.find
 ;
 ;  #OPTIMIZE FUNCTIONS OFF
 ;
 I (p1="") Q $S(p2<1:1,1:+p2)
 I p3 S object=$ZCONVERT(object,"U") S p1=$ZCONVERT(p1,"U")
 S p2=$F(object,p1,p2)
 I '(qt=""),$L($E(object,1,p2-1),qt)#2=0 D
 .	F  S p2=$F(object,p1,p2) Q:p2=0!($L($E(object,1,p2-1),qt)#2) 
 .	Q 
 Q p2
 ;
vDbEx1() ; min(1): DISTINCT LIBS,RID,GRP,ITMSEQ,SEQ FROM DBTBL5D1 WHERE LIBS=:V1 and RID=:V2 and GRP=:V3 and ITMSEQ=:V4 and SEQ=:V5
 ;
 N vsql1
 S vsql1=$$BYTECHAR^SQLUTL(254)
 ;
 ;
 ;
 ;
 ;
 S V5=+V5
 I '(V4>100) Q 0
 I '($D(^DBTBL(V1,5,V2,V3,V4,V5))#2) Q 0
 Q 1
 ;
vDbEx2() ; min(1): DISTINCT LIBS,RID,GRP,ITMSEQ,SEQ FROM DBTBL5D1 WHERE LIBS=:V1 and RID=:V2 and GRP=:V3 and ITMSEQ=:V4 and SEQ=:V5
 ;
 N vsql1
 S vsql1=$$BYTECHAR^SQLUTL(254)
 ;
 ;
 ;
 ;
 ;
 S V5=+V5
 I '(V4>100) Q 0
 I '($D(^DBTBL(V1,5,V2,V3,V4,V5))#2) Q 0
 Q 1
 ;
vDbEx3() ; min(1): DISTINCT LIBS,RID,GRP,ITMSEQ,SEQ FROM DBTBL5D1 WHERE LIBS=:V1 and RID=:V2 and GRP=:V3 and ITMSEQ=:V4 and SEQ=:V5
 ;
 N vsql1
 S vsql1=$$BYTECHAR^SQLUTL(254)
 ;
 ;
 ;
 ;
 ;
 S V5=+V5
 I '(V4>100) Q 0
 I '($D(^DBTBL(V1,5,V2,V3,V4,V5))#2) Q 0
 Q 1
 ;
vReCp1(v1) ; RecordDBTBL5D1.copy: DBTBL5D1
 ;
 Q $$copy^UCGMR(this)
