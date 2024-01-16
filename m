Return-Path: <bpf+bounces-19685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426F82FC33
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE0D28EFA8
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FD249E4;
	Tue, 16 Jan 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="sOXwwoyr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="gR0bRMCe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RnwGWQQp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945B3770B
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437531; cv=none; b=CJhP6gDYkxjbzZ3PnmShKm4tmJvEoew0Ly6JBK3dZ1PYcRioczqhLrL5gYUkBYLVLaHkU2Kd+gYH1HR3VHfLP56kl4OJsEz03dkRiCEOK0yMrvC9LjKzOV3O7VjtK2QnVTqUPv3lI8+0aJK9lbRzE49XvB29yuZRE9kIVGO3iwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437531; c=relaxed/simple;
	bh=S7BzbIbcrLqbktg+5GtF9xEWU3yeX7bP8Q7JopeNMGk=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:X-Original-To:
	 Delivered-To:Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spam-Status:Received:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:X-Google-Original-From:To:
	 Date:Message-ID:MIME-Version:X-Mailer:Thread-Index:
	 Content-Language:Archived-At:Subject:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:Content-Type:Errors-To:Sender:
	 X-Original-From:From; b=B0+y9K/LHm1wAnHQhaU5MQ98s5WmUClIBHr8U2HywIdeYX2Ly0wGCP+YsNNA7o0DHKPTe2auSBDmV04xG1S9PEs3RcX5xViUYwWHp/mXFL5pminQTqipOeX91q5NLJP8HZ1h8Pxzpsrz6zqZltt+gqAdTg1ROvsyhQTE3NYJcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=sOXwwoyr; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=gR0bRMCe reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RnwGWQQp reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AAE48C15152E
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705437529; bh=S7BzbIbcrLqbktg+5GtF9xEWU3yeX7bP8Q7JopeNMGk=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=sOXwwoyryc2hapCLAeWbpn7rVA762UQqqLrzl/yMAt1U/39ejTWQLoUJ7ejVyMNyL
	 nmoalHpMfhzl/vBtLcMlBq6S2C60o4QTkZ7jOnuswuKzW3BDMXkfNmKX7P8TdfXrhQ
	 E54nDFko8KKxsNoiPR95ZKJPB5vK7Ls1y/QJ/A+g=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7CABCC151063;
 Tue, 16 Jan 2024 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1705437529; bh=siJe7YRfjOsyfDJ+2/+85h+Z7WXvnwGCv9gbuNnECQI=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=gR0bRMCetakTyVKdQwtN+Hx0JKctUtECGe9hpBWpf2PagXvYaVswX2APPzY+UH5xe
 98rRuMYPVj2JDWFr5HCobFg8dxlENsfk3qHiqdO6DFhgX0FIsZ12nnyePW7MvRtboK
 ATyYqUVkDRyaaWGecRWIcv72ZKfiHYxuGtuqRVLE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2E5EBC151062
 for <bpf@ietfa.amsl.com>; Tue, 16 Jan 2024 12:38:49 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -0.455
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FS92vdwiJrgk for <bpf@ietfa.amsl.com>;
 Tue, 16 Jan 2024 12:38:44 -0800 (PST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id AD420C151063
 for <bpf@ietf.org>; Tue, 16 Jan 2024 12:38:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b267007fso6007519b3a.3
 for <bpf@ietf.org>; Tue, 16 Jan 2024 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1705437524; x=1706042324; darn=ietf.org;
 h=content-language:thread-index:mime-version:message-id:date:subject
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a6aLV83G/g9oXwzW9nTgRcwoTcclV+E6VHGM6Ipf8kM=;
 b=RnwGWQQpLaq8fQGvdKASrMoweMYas3ExFOtdFuCl4Au1tgj19ISfIJO5tAGm+HssCm
 TWVlEkSFpm6uvcmaxSIornZ4wmsK7uMNOFUBX2CtIDBUJx6X1/KNK9tnPaJMVPAt1tVe
 B1imehhi4Mh/0G/JiOCyinmYozUgwJBoTE+vQ8ap4Hw+zJJSQK2i3Hj/2XcmO1JCLEH6
 MExIU2FLP8O+rMGGjlU2FlHxrGnMvIqE4djYke2trA/tXeyAgfiWq8i+Ch5awhGltFVD
 G4Peuc7+DMH4+pTw4O+hYdr2JEbTizQhev9ADcvoXPkf23kWtDDNKXaWG1mK0B14bM8I
 DNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705437524; x=1706042324;
 h=content-language:thread-index:mime-version:message-id:date:subject
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a6aLV83G/g9oXwzW9nTgRcwoTcclV+E6VHGM6Ipf8kM=;
 b=efvP1ACTV3i5oyEz5InST8HxA+hiWBOUh0hyrdjbLOtbrYIoXJ9UHszoaACOl6lld1
 cUCRHnPUMRGUqMrt3oimUuvLFf7TRVFDSr7P1Fa3f6lKEFIuQDVaSeHPmUZ0THHIqDN0
 D0Ar+F8LTc5Iqq1AmRHcpXQimbEPpTmbVVb34WzAC81xI240r2U0dcNnHvj9rYDWGRxc
 5Q8Bw5dT8VNkLAd02Dfyagbdmm5mDtnv07wVvcPODKwi4zIQsCCloWegfPfrhfn+peFN
 xTl40Kqz4+wJzJTpiVRsyBx0VkiP19X9Mc8AA0p2BgXjQfP5MJHS2S7iUZb6+7a75wfU
 0q3w==
X-Gm-Message-State: AOJu0YyutRaEK9v0nWtJAKJt7QOVwQiyQfp+L0iouu8NY71EPMsppy7l
 Kkg8KHSGsFOMvq3gkimTRD6kknO9w/SURw==
X-Google-Smtp-Source: AGHT+IH1XZpeo0D7hcPL0EYwTC9k4FRBql2kN6T0tlosbEITVdoPboOU9nAKgBe0J0AREOFQP2gXRg==
X-Received: by 2002:a05:6a00:84e:b0:6d9:8a95:b028 with SMTP id
 q14-20020a056a00084e00b006d98a95b028mr4534377pfk.30.1705437523874; 
 Tue, 16 Jan 2024 12:38:43 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 fj30-20020a056a003a1e00b006db04fb3f00sm5587pfb.28.2024.01.16.12.38.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jan 2024 12:38:43 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Date: Tue, 16 Jan 2024 12:38:40 -0800
Message-ID: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpIu2mFhidWtddURq2fmYCsTNYW9g==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iSqW75mJYAetNARDd_mbpFvr6TM>
Subject: [Bpf] Sign extension ISA question
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============5728915665265021511=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

This is a multipart message in MIME format.

--===============5728915665265021511==
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0860_01DA4878.EFE923C0"
Content-Language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0860_01DA4878.EFE923C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Is there any semantic difference between the following two instructions?

 

{.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}

 

{.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}

 

>From my reading both of them treat imm as a signed 32-bit number and
sign-extend it to 64 bits.

 

Dave


------=_NextPart_000_0860_01DA4878.EFE923C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Is there any semantic =
difference between the following two instructions?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>{.opcode =3D =
BPF_ALU64 | BPF_MOV | BPF_K, .offset =3D 0, .imm =3D =
-1}<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>{.opcode =3D BPF_ALU64 | BPF_MOVSX | BPF_K, .offset =
=3D 32, .imm =3D -1}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>From my =
reading both of them treat imm as a signed 32-bit number and sign-extend =
it to 64 bits.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Dave<o:p></o:p></p></div></body></html>
------=_NextPart_000_0860_01DA4878.EFE923C0--


--===============5728915665265021511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============5728915665265021511==--


