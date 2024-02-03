Return-Path: <bpf+bounces-21129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500788483C2
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 05:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F0728266E
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF814FBEE;
	Sat,  3 Feb 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="I7VxGQzr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="QCc1XVvl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iZR1vKqI"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63001FBF2
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934975; cv=none; b=oaiE0xM7sd/si+CjZUTUOhhtIK7lCF4tkqOLVPmpEpiDSyPAQV2oiuNRqqxe+e2+CqAjC9qDZ/Kcf5paVwRIucCNpZ20oriXuQgL6ov/hL0q2EVeQuviC5gmf7VaZsA94avtM9jHjPgEbc4JBx4rSQKcWSjGPjtMosYk8b8Bwh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934975; c=relaxed/simple;
	bh=FrqoOgCOlVXjTD059kXKsdNq2QN5LidMI5czUcUOsfE=;
	h=To:Cc:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=JUu7g8nFE63K/2b97Gt+45ROhgugjUyQil9H80+og5XuhMz7i0OPxniwd3AZUC3YdHTkyINZBgt9LMjSa5ppsA1O4uXDLmE/VYyLqJrxYbqrzpyHQbD0t+HS/6cb4cZ+71JdJCSLDn3INUTTL2I3Xa3o1zq7lJnBLdWk+PU3DCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=I7VxGQzr; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=QCc1XVvl reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iZR1vKqI reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7654DC14F70D
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 20:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706934972; bh=FrqoOgCOlVXjTD059kXKsdNq2QN5LidMI5czUcUOsfE=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I7VxGQzrujm2JseWU/PHPQd9+YeRDvni3IJ8Y0GYxcg31pmCxgv5Ww/KHQzyb4CXk
	 C0acRy0dvCctpXHUU8WQQJ+WFGD7VxeDsgyUupOZun/K7iXeQu4EbDBcqfBWNFRYzD
	 94gG/Lpp+dxJwDeWbdQ3DHSgUCp4PON+//iKD4gk=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 48E40C14F68C;
 Fri,  2 Feb 2024 20:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706934972; bh=h0hMoQUgEZWC5oZyAQiL6NdVoL42DSmcRwr5rEzQztk=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=QCc1XVvl9WOrRp/O66c1HqGMrAo5IDuuEEIxLbFzt84akBHk5krRrkynR/4t+brF3
 ikIIcget+++9u64wjI0zLfwUEOIYgP3I9cDD9uE0cg7mPhvk9r/CfrOIlbG5O20Kg/
 tXlL8PPwTy6QFvzZqYWP8LeafZdm1jWpGnAt/5HY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2B8BEC14F619
 for <bpf@ietfa.amsl.com>; Fri,  2 Feb 2024 20:36:11 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.854
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gQKNESXT6XjO for <bpf@ietfa.amsl.com>;
 Fri,  2 Feb 2024 20:36:07 -0800 (PST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 51E64C14F68C
 for <bpf@ietf.org>; Fri,  2 Feb 2024 20:36:07 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso23691085ad.1
 for <bpf@ietf.org>; Fri, 02 Feb 2024 20:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706934966; x=1707539766; darn=ietf.org;
 h=content-language:thread-index:mime-version:message-id:date:subject
 :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=npm7Z4Lq33QJTE+Z98CpkT6DjsCbzkGdtf8MGrm3X4M=;
 b=iZR1vKqIP5dTkVxit7lmu2liOXp4smxrukivu8seOJGyaVlUfoM8zv3bfA4dbVM+CM
 bbNMgDXb3XSeIw1h1hWTKkKo/8xliSyVyqrJ7SffRh2MRb+Gt/TrqDdWprSvfIjxBvnn
 tEcbFHI/HqIYNXNaezOikMhhV0X7AphTvi7NMav+AHeJw4u7aPwUB9H7JenXQwMp0r2E
 QzB8CMrFmRM7a2b8HL1p1DHqg413Rp/s3TU9vVEsMMbiSNFNQ0jRz9dhjvZVDnYSDwaV
 FrgAHe+4+W7zPYsI1DMXVp+E4tBRjjQSaLHDFu2qiw9lM6n/NQNHhLbVN0Eqf0fEvKlc
 52EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706934966; x=1707539766;
 h=content-language:thread-index:mime-version:message-id:date:subject
 :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npm7Z4Lq33QJTE+Z98CpkT6DjsCbzkGdtf8MGrm3X4M=;
 b=NjRREAbcpl/yIAVbbt2sKkWfswooJASrzr9vslYgN2Mg+wRIZpNh/Ll2KMAm9roSxG
 oiVUUWDle9GnuPSY2WvmkJnjQ/+7phNm7QKAtpvZopSOHb7IuP2NE3dvrLjyxzMFI1qW
 +LhvtfJEgTNUsiUW4ophC15co2K4EOVGZ4QW4ZPG2CNiGUKOGINgDiBQpcLOQUJ3qMti
 tyNKk6c8w8DQ6uLR1YKTd0kdjoefXqpktVyaqprq1Vb6GpOB/TJLMyKwqlqA5lvlw+a+
 IkwAR1Bbce8xbdbhx2prTzS2vbp8OMypSck0m4OC5X1bYUuEGg2HL4mIvbbXE0pwru9i
 J7Vw==
X-Gm-Message-State: AOJu0YxQGJJW90Tfz4/SnDl2JTR/huiPhbaULag+fGaDz2nuQx+Coe2j
 4kZNM89ClHclOfqwBLWSrdRIseLwbCWIxGIPzB31J27Jzw4ljYSxPjMOsyOnlTg=
X-Google-Smtp-Source: AGHT+IHXpz/UwtTwC8pOKtcqXduqG53eQ13+GZqu2o+YitcVAE+v7LTAOq4hX846lTmJnkXfQnExWQ==
X-Received: by 2002:a17:902:f7cf:b0:1d9:62bc:a55d with SMTP id
 h15-20020a170902f7cf00b001d962bca55dmr4604175plw.25.1706934966159; 
 Fri, 02 Feb 2024 20:36:06 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 ks14-20020a170903084e00b001d963d963aasm2390094plb.308.2024.02.02.20.36.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Feb 2024 20:36:05 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>
Cc: <bpf@vger.kernel.org>
Date: Fri, 2 Feb 2024 20:36:02 -0800
Message-ID: <00f801da565a$7e999250$7bccb6f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpWWeO4ijzebLSvS6KOsKOfv93Zpw==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/NsQLGU5TjKP7hlyeO9PFZ_w91lw>
Subject: [Bpf] ISA: do individual instructions still need their own IANA
 status?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============6191048414342598716=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

This is a multipart message in MIME format.

--===============6191048414342598716==
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_00F9_01DA5617.7076A070"
Content-Language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_00F9_01DA5617.7076A070
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously (draft -00) we said that each instruction would have a status of

Permanent, Provisional, or Historical in the IANA registry.

 

However, we now have conformance groups about to be merged into the ISA doc,

and at IETF 118 we discussed having each conformance group have a status of

Permanent, Provisional, or Historical.  That is, it makes sense for the
status to
be at the granularity of conformance group since one should implement all

instructions in a conformance group together.

 

As a result I now believe that each individual instruction no longer needs
its own

status since it can be derived from the status of the conformance group(s)
it

belongs to.  So in the IANA Considerations section, I plan to remove
"status"

from the list of fields in the instruction sub-registry and ONLY have
"status"

in the list of fields for the conformance group sub-registry).

 

Let me know if anyone has a good reason to keep it per-instruction.

 

Dave


------=_NextPart_000_00F9_01DA5617.7076A070
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
	{mso-style-type:export-only;}
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
class=3DWordSection1><p class=3DMsoNormal>Previously (draft -00) we said =
that each instruction would have a status of<o:p></o:p></p><p =
class=3DMsoNormal>Permanent, Provisional, or Historical in the IANA =
registry.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>However, we now have conformance groups about to be =
merged into the ISA doc,<o:p></o:p></p><p class=3DMsoNormal>and at IETF =
118 we discussed having each conformance group have a status =
of<o:p></o:p></p><p class=3DMsoNormal>Permanent, Provisional, or =
Historical.&nbsp; That is, it makes sense for the status to<br>be at the =
granularity of conformance group since one should implement =
all<o:p></o:p></p><p class=3DMsoNormal>instructions in a conformance =
group together.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>As a result =
I now believe that each individual instruction no longer needs its =
own<o:p></o:p></p><p class=3DMsoNormal>status since it can be derived =
from the status of the conformance group(s) it<o:p></o:p></p><p =
class=3DMsoNormal>belongs to.&nbsp; So in the IANA Considerations =
section, I plan to remove &#8220;status&#8221;<o:p></o:p></p><p =
class=3DMsoNormal>from the list of fields in the instruction =
sub-registry and ONLY have &#8220;status&#8221;<o:p></o:p></p><p =
class=3DMsoNormal>in the list of fields for the conformance group =
sub-registry).<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Let me know =
if anyone has a good reason to keep it per-instruction.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Dave<o:p></o:p></p></div></body></html>
------=_NextPart_000_00F9_01DA5617.7076A070--


--===============6191048414342598716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============6191048414342598716==--


