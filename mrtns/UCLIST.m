	; I18N=QUIT
	;
	; **** Routine compiled from DATA-QWIK Procedure UCLIST ****
	;
	; 09/10/2007 17:31 - chenardp
	;
	; *******************************************************************
	; * IMPORTANT NOTE:                                                 *
	; * According to the rules that apply to PSL compiler upgrades,     *
	; * the generated M routine associated with this procedure must be  *
	; * checked into StarTeam and released with the procedure whenever  *
	; * changes are made to this procedure.                             *
	; *                                                                 *
	; * The M routine will be loaded to the mrtns directory during      *
	; * upgrades and will then be removed from that directory as part   *
	; * of the upgrade process.  Therefore, other than during an        *
	; * upgrade an mrtns version of this routine should not exist.      *
	; *                                                                 *
	; * Keep these comments as single line to ensure they exist in the  *
	; * generated M code.                                               *
	; *******************************************************************
	Q 
	;
add	; Method: List.add(element,delimiter,allowDuplicate,inOrder)
	I (""""""[actual(1)) S return=objectName Q 
	I (""""""[actual(2)) S actual(2)=""","""
	;
	N allowDup S allowDup=actual(3)
	N inOrder S inOrder=actual(4)
	;
	I (""""""[allowDup) S allowDup=1 ; default = Yes
	I (""""""[inOrder) S inOrder=0 ; default = No
	;
	I $$isLit^UCGM(allowDup),$$isLit^UCGM(inOrder),'$$QSUB^%ZS(inOrder,"""") D  Q 
	.	;
	.	S allowDup=$$QSUB^%ZS(allowDup,"""")
	.	;
	.	I (""""""[objectName) S return=actual(1) Q 
	.	;
	.	N obj S obj=$$tokenPush^UCPATCH(objectName,"List")
	.	N ap1 S ap1=$$tokenPush^UCPATCH(actual(1),"String")
	.	N ap2 S ap2=$$tokenPush^UCPATCH(actual(2),"String")
	.	;
	.	I $$isLit^UCGM(objectName) D
	..		;
	..		I $$isLit^UCGM(ap2) S return=$$QADD^%ZS(($$QSUB^%ZS(obj,"""")_$$QSUB^%ZS(ap2,"""")),"""")_"_"_ap1
	..		E  S return=obj_"_"_ap2_"_"_ap1
	..		Q 
	.	;
	.	E  S return="$S("_obj_".isNull():"_ap1_",1:"_obj_"_"_ap2_"_"_ap1_")"
	.	;
	.	I 'allowDup S return="$S({List}"_obj_".contains("_ap1_","_ap2_"):"_obj_",1:"_return_")"
	.	;
	.	; translate PSL expression to M expression
	.	S return=$$tokenPop^UCPATCH($$vMExpr(return),3)
	.	;
	.	Q 
	;
	N label S label="vLstAdd"
	;
	I '$D(labels("vLstAdd")) D
	.	;
	.	N buf S buf=$$vopenBuf("(String object, String p1, String p2, Boolean p3, Boolean p4)","List.add")
	.	;
	.	D vaddBuff(buf,"if object.isNull() quit p1")
	.	D vaddBuff(buf,"if p2.isNull() set p2="",""")
	.	D vaddBuff(buf,"if 'p3,'p3.isNull(),{List}object.contains(p1,p2) quit object")
	.	D vaddBuff(buf,"if 'p4 quit object_p2_p1")
	.	D vaddBuff(buf,"")
	.	D vaddBuff(buf,"if object.piece(p2,1)]]p1 quit p1_p2_object")
	.	D vaddBuff(buf,"if p1]]object.piece(p2,object.length(p2)) quit object_p2_p1")
	.	D vaddBuff(buf,"")
	.	D vaddBuff(buf,"type Number i")
	.	D vaddBuff(buf,"for i=1:1:object.length(p2) if object.piece(p2,i)]]p1 quit")
	.	D vaddBuff(buf,"quit object.piece(p2,1,i-1)_p2_p1_p2_object.piece(p2,i,object.length())")
	.	;
	.	D INSERT^UCMETHOD(buf,"vLstAdd","")
	.	K vobj(+$G(buf)) Q 
	;
	S return="$$"_label_"("_objectName_","_actual(1)_","_actual(2)_","_allowDup_","_inOrder_")"
	;
	Q 
	;
contains	; Method List.contains(String expr,String delimiter,Boolean ignoreCase)
	;
	I (""""""[actual(1)) S return="("_objectName_"="""")" Q 
	I (""""""[actual(2)) S actual(2)=""","""
	I (""""""[actual(3)) S actual(3)=0
	;
	S return=$$tokenPush^UCPATCH(objectName,"List")
	N ap1 S ap1=$$tokenPush^UCPATCH(actual(1),"String")
	N ap2 S ap2=$$tokenPush^UCPATCH(actual(2),"String")
	N ap3 S ap3=$$tokenPush^UCPATCH(actual(3),"Number")
	;
	; Apply ignorCase function if appropriate
	I $$isLit^UCGM(ap3),$$QSUB^%ZS(ap3,"""") D
	.	;
	.	I $$isLit^UCGM(return) S return=$$vStrUC(return)
	.	E  S return=return_".upperCase()"
	.	;
	.	I $$isLit^UCGM(ap1) S ap1=$$vStrUC(ap1)
	.	E  S ap1=ap1_".upperCase()"
	.	Q 
	;
	I $$isLit^UCGM(ap2) D
	.	;
	.	N delim S delim=$$QSUB^%ZS(ap2,"""")
	.	I $$isLit^UCGM(return) S return=$$QADD^%ZS((delim_$$QSUB^%ZS(return,"""")_delim),"""")
	.	I $$isLit^UCGM(ap1) S ap1=$$QADD^%ZS((delim_$$QSUB^%ZS(ap1,"""")_delim),"""")
	.	Q 
	;
	;if 'PSL.return.isLiteral() set PSL.return="("_ap2_"_"_PSL.return_"_"_ap2_")"
	I '$$isLit^UCGM(return) S return="("_ap2_"_{String}"_return_"_"_ap2_")"
	I '$$isLit^UCGM(ap1) S ap1="("_ap2_"_"_ap1_"_"_ap2_")"
	;
	;set PSL.return=PSL.mExpr("({String}"_PSL.return_"["_ap1_")")
	I $$isLit^UCGM(ap3) S return="("_return_"["_ap1_")"
	E  S return="$S("_ap3_":"_return_".upperCase()["_ap1_".upperCase(),1:"_return_"["_ap1_")"
	;
	S return=$$tokenPop^UCPATCH($$vMExpr(return),4)
	;
	I $$isLit^UCGM(objectName) S return=$$toLit^UCSTRING(return)
	;
	Q 
	;
count	; Method: List.count(String delimiter) - Number of elements in a list
	;
	I (""""""[actual(1)) S actual(1)=""","""
	S return=$$vMExpr("$S({String}"_objectName_".isNull():0,1:{String}"_objectName_".length("_actual(1)_"))")
	Q 
	;
elemAt	; Method: List.elementAt(Number position,String delimiter)
	I (""""""[actual(2)) S actual(2)=""","""
	S return=$$vMExpr("{String}"_objectName_".piece("_actual(2)_","_actual(1)_")")
	Q 
	;
position	; Method: List.position(String expr,String delimiter,Boolean ignoreCase) - String is at list position
	;
	; reduce source object to Constant if possible
	N expr S expr=$$toLit^UCGM(objectName)
	;
	N val S val=actual(1) ; element to look for
	N del S del=actual(2) ; delimiter
	N ignore S ignore=actual(3)
	;
	I (""""""[del) S del=""","""
	I (""""""[ignore) S ignore=0
	;
	I $$isLit^UCGM(del),$$isLit^UCGM(ignore),'$$QSUB^%ZS(ignore,"""") D  Q 
	.	;
	.	I $$isLit^UCGM(expr) S expr=$$QADD^%ZS(($$QSUB^%ZS(del,"""")_$$QSUB^%ZS(expr,"""")_$$QSUB^%ZS(del,"""")),"""")
	.	E  S expr="("_del_"_{String}"_expr_"_"_del_")"
	.	;
	.	I $$isLit^UCGM(val) S val=$$QADD^%ZS(($$QSUB^%ZS(del,"""")_$$QSUB^%ZS(val,"""")_$$QSUB^%ZS(del,"""")),"""")
	.	E  S val=del_"_"_val_"_"_del
	.	;
	.	S return=$$vMExpr(expr_".piece("_val_",1).length("_del_")")
	.	Q 
	;
	N label S label="vlstPos"
	;
	I '$D(labels("vlstPos")) D
	.	;
	.	N buf S buf=$$vopenBuf("(String object, String p1, String p2, Boolean p3)","List.position")
	.	;
	.	D vaddBuff(buf,"if p3 set object=object.upperCase(),p1=p1.upperCase()")
	.	D vaddBuff(buf,"set object=p2_object_p2,p1=p2_p1_p2")
	.	D vaddBuff(buf,"if object'[p1 quit 0")
	.	D vaddBuff(buf,"quit object.piece(p1,1).length(p2)")
	.	;
	.	D INSERT^UCMETHOD(buf,"vlstPos","")
	.	K vobj(+$G(buf)) Q 
	;
	S return="$$"_label_"("_objectName_","_actual(1)_","_del_","_actual(3)_")"
	;
	Q 
	;
sort	; Method: List.sort( String delimiter, Boolean allowDuplicate) - Sort a list in collating order
	;
	I (""""""[actual(1)) S actual(1)=""",""" ; Default = comma
	I (actual(2)="") S actual(2)=1 ; Default = YES
	;
	N label S label="vlstSor"
	;
	I '$D(labels("vlstSor")) D
	.	;
	.	N buf S buf=$$vopenBuf("(String object, String p1, Boolean p2)","List.sort")
	.	;
	.	D vaddBuff(buf,"if object.isNull() quit object")
	.	D vaddBuff(buf,"")
	.	D vaddBuff(buf,"type String e")
	.	D vaddBuff(buf,"type Number n,s()")
	.	D vaddBuff(buf,"if p1.isNull() set p1="",""")
	.	D vaddBuff(buf,"if p2.isNull() set p2=1")
	.	D vaddBuff(buf,"for n=1:1:object.length(p1) do {")
	.	D vaddBuff(buf,"  set e=object.piece(p1,n)")
	.	D vaddBuff(buf,"  if e.isNull() quit")
	.	D vaddBuff(buf,"  if p2 set s(e) = 1 + s(e).get()") ; s(e) = # elems
	.	D vaddBuff(buf,"  else  set s(e) = 1") ; no dups: 1 elem
	.	D vaddBuff(buf,"}")
	.	D vaddBuff(buf,"set e=s("""").order(),s(e)=s(e)-1,object=e")
	.	D vaddBuff(buf,"while 'e.isNull() do {")
	.	D vaddBuff(buf,"  for n=1:1:s(e) set object=object_p1_e")
	.	D vaddBuff(buf,"  set e=s(e).order()")
	.	D vaddBuff(buf,"}")
	.	D vaddBuff(buf,"quit object")
	.	;
	.	D INSERT^UCMETHOD(buf,"vlstSor","")
	.	K vobj(+$G(buf)) Q 
	;
	S return="$$"_label_"("_objectName_","_actual(1)_","_actual(2)_")"
	;
	Q 
	; ----------------
	;  #OPTION ResultClass 0
vMExpr(v1)	; PSL.mExpr
	;
	;  #OPTIMIZE FUNCTIONS OFF
	N vExp N mcode N tok
	N vFun S vFun=$get(commands("OPTIMIZE","FUNCTIONS"),0)
	S commands("OPTIMIZE","FUNCTIONS")=0
	S mcode="" S v1=$$TOKEN^%ZS(v1,.tok) S vExp=$$valExpr^UCGM(v1,,0)
	S commands("OPTIMIZE","FUNCTIONS")=vFun
	Q vExp
	; ----------------
	;  #OPTION ResultClass 0
vopenBuf(v1,v2)	; PSL.openBuffer
	;
	;  #OPTIMIZE FUNCTIONS OFF
	N vOid
	S vOid=$order(vobj(""),-1)+1
	I $E(v1,1)'="(",'(v1="") S v1="("_v1_")"
	S vobj(vOid,-1)=v1
	S vobj(vOid,-2)=v2
	S vobj(vOid,1)=v1_" // "_v2
	Q vOid
	; ----------------
	;  #OPTION ResultClass 0
vaddBuff(object,p1)	; PSLBuffer.add
	;
	;  #OPTIMIZE FUNCTIONS OFF
	N line
	S line=$order(vobj(object,""),-1)+1
	S vobj(object,line)=" "_p1
	Q 
	; ----------------
	;  #OPTION ResultClass 0
vStrUC(vObj)	; String.upperCase
	;
	;  #OPTIMIZE FUNCTIONS OFF
	Q $translate(vObj,"abcdefghijklmnopqrstuvwxyz����������������������������������������","ABCDEFGHIJKLMNOPQRSTUVWXYZ����������������������������������������")
