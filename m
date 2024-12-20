Return-Path: <bpf+bounces-47439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF039F9695
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6DF16CC85
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FD219E82;
	Fri, 20 Dec 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="ylScyeoc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C533062;
	Fri, 20 Dec 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712123; cv=none; b=h+Ysk9JTCUmOucB1iUt2NXLArpsAqpKlPTV91AgPM9NTtv68QXcnObTk0mkHdxoodXBnXj9eby/B1J0GD6XAQ91BZQTZDRZHE5haDFxOGpUPzSo3nRLUFJFvTqcpMPf1PNaqHrjiKjUYr7kg+tysKV15vF83NjeghoYaIlaKwgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712123; c=relaxed/simple;
	bh=PA3ZJkqXu9pMasVcAutpfftrCDpDHcnMzzbP4VgFp2Y=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=P51t/pAiVBO1C8yqX7nzUa25biqQqe44ihR86enzYSfusQ44/s45/8RaRtdWAOTJhm1qqHsrb69+ZPrf5DNxC9T4AFcvdMT63fmWRyryF3RsCk0+1fi16obSW6EFOu9WxzBJIll9akHqBnynJg1piCpYM79TGeKh4LmraY6hgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=ylScyeoc; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734712119; x=1766248119;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=PA3ZJkqXu9pMasVcAutpfftrCDpDHcnMzzbP4VgFp2Y=;
  b=ylScyeoc7TopQS528imsICvl/8a/LIR+ttftQbil+HmvhLebkB2LDCM+
   FczVDsPDmlWHFCV+7kOtxE+JGjRbrr/eeVoOOJfEYmhPub+0mXLsDBbP+
   ERlEEIAxwTAqBfWOgOsZmC+xzY8PnJxqo7mcHIvibGMcsc0RMSVikC238
   c=;
X-CSE-ConnectionGUID: XVGw9OvtQ/2b0OoQkojBwQ==
X-CSE-MsgGUID: VmnHP89GQbu75PBmc1IH9Q==
X-IronPort-AV: E=Sophos;i="6.12,251,1728943200"; 
   d="scan'208";a="28280029"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 20 Dec 2024 17:28:36 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <26180f2e-1ef7-45de-8e9e-f08a4e6a6d36@qmon.net>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
 <20241211220012.714055-2-ariel.otilibili-anieli@eurecom.fr> <26180f2e-1ef7-45de-8e9e-f08a4e6a6d36@qmon.net>
Date: Fri, 20 Dec 2024 17:28:36 +0100
Cc: bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Shuah Khan" <shuah@kernel.org>, linux-kernel@vger.kernel.org
To: "Quentin Monnet" <qmo@qmon.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a83-67659b00-a301-5cf12280@99585095>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/1] =?utf-8?q?selftests/bpf=3A?= clear out Python 
 syntax warnings
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

On Friday, December 20, 2024 17:24 CET, Quentin Monnet <qmo@qmon.net> w=
rote:

> 2024-12-11 22:57 UTC+0100 ~ Ariel Otilibili
> <ariel.otilibili-anieli@eurecom.fr>
> > Invalid escape sequences are used, and produced syntax warnings:
> >=20
> > ```
> > $ test=5Fbpftool=5Fsynctypes.py
> > test=5Fbpftool=5Fsynctypes.py:69: SyntaxWarning: invalid escape seq=
uence '\['
> >   self.start=5Fmarker =3D re.compile(f'(static )?const bool {self.a=
rray=5Fname}\[.*\] =3D {{\n')
> > test=5Fbpftool=5Fsynctypes.py:83: SyntaxWarning: invalid escape seq=
uence '\['
> >   pattern =3D re.compile('\[(BPF=5F\w*)\]\s*=3D (true|false),?$')
> > test=5Fbpftool=5Fsynctypes.py:181: SyntaxWarning: invalid escape se=
quence '\s'
> >   pattern =3D re.compile('^\s*(BPF=5F\w+),?(\s+/\*.*\*/)?$')
> > test=5Fbpftool=5Fsynctypes.py:229: SyntaxWarning: invalid escape se=
quence '\*'
> >   start=5Fmarker =3D re.compile(f'\*{block=5Fname}\* :=3D {{')
> > test=5Fbpftool=5Fsynctypes.py:229: SyntaxWarning: invalid escape se=
quence '\*'
> >   start=5Fmarker =3D re.compile(f'\*{block=5Fname}\* :=3D {{')
> > test=5Fbpftool=5Fsynctypes.py:230: SyntaxWarning: invalid escape se=
quence '\*'
> >   pattern =3D re.compile('\*\*([\w/-]+)\*\*')
> > test=5Fbpftool=5Fsynctypes.py:248: SyntaxWarning: invalid escape se=
quence '\s'
> >   start=5Fmarker =3D re.compile(f'"\s*{block=5Fname} :=3D {{')
> > test=5Fbpftool=5Fsynctypes.py:249: SyntaxWarning: invalid escape se=
quence '\w'
> >   pattern =3D re.compile('([\w/]+) [|}]')
> > test=5Fbpftool=5Fsynctypes.py:267: SyntaxWarning: invalid escape se=
quence '\s'
> >   start=5Fmarker =3D re.compile(f'"\s*{macro}\s*" [|}}]')
> > test=5Fbpftool=5Fsynctypes.py:267: SyntaxWarning: invalid escape se=
quence '\s'
> >   start=5Fmarker =3D re.compile(f'"\s*{macro}\s*" [|}}]')
> > test=5Fbpftool=5Fsynctypes.py:268: SyntaxWarning: invalid escape se=
quence '\w'
> >   pattern =3D re.compile('([\w-]+) ?(?:\||}[ }\]])')
> > test=5Fbpftool=5Fsynctypes.py:287: SyntaxWarning: invalid escape se=
quence '\w'
> >   pattern =3D re.compile('(?:.*=3D\')?([\w/]+)')
> > test=5Fbpftool=5Fsynctypes.py:319: SyntaxWarning: invalid escape se=
quence '\w'
> >   pattern =3D re.compile('([\w-]+) ?(?:\||}[ }\]"])')
> > test=5Fbpftool=5Fsynctypes.py:341: SyntaxWarning: invalid escape se=
quence '\|'
> >   start=5Fmarker =3D re.compile('\|COMMON=5FOPTIONS\| replace:: {')
> > test=5Fbpftool=5Fsynctypes.py:342: SyntaxWarning: invalid escape se=
quence '\*'
> >   pattern =3D re.compile('\*\*([\w/-]+)\*\*')
> > ```
> >=20
> > Escaping them clears out the warnings.
> >=20
> > ```
> > $ tools/testing/selftests/bpf/test=5Fbpftool=5Fsynctypes.py; echo $=
?
> > 0
> > ```
> >=20
> > Link: https://docs.python.org/fr/3/library/re.html
>=20
>=20
> En version anglaise : https://docs.python.org/3/library/re.html

Merci!
>=20
>=20
> > CC: Alexei Starovoitov <ast@kernel.org>
> > CC: Daniel Borkmann <daniel@iogearbox.net>
> > CC: Andrii Nakryiko <andrii@kernel.org>
> > CC: Shuah Khan <shuah@kernel.org>
> > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
>=20
> Right, this seems to be a change in Python 3.12 [0][1]:
>=20
> 'A backslash-character pair that is not a valid escape sequence now
> generates a SyntaxWarning, instead of DeprecationWarning. For example=
,
> re.compile("\d+\.\d+") now emits a SyntaxWarning ("\d" is an invalid
> escape sequence, use raw strings for regular expression:
> re.compile(r"\d+\.\d+")).'
>=20
> although I can't remember seeing any DeprecationWarning before.
>=20
> Anyway, the fix makes sense, and does address the warnings. Thank you
> for this!
>=20
> Tested-by: Quentin Monnet <qmo@kernel.org>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>

Awesome, Quentin! Thanks for the feedback!
>=20
>=20
> [0] https://docs.python.org/3.12/whatsnew/3.12.html#other-language-ch=
anges
> [1] https://github.com/python/cpython/issues/98401


