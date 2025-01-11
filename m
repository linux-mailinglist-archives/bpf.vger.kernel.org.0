Return-Path: <bpf+bounces-48612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A0A09F46
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 01:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3A81888B7F
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340C1FDD;
	Sat, 11 Jan 2025 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1XWCf7J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD6137E;
	Sat, 11 Jan 2025 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736555020; cv=none; b=YCfggN51lAe+Y2yqqXA5n3l2F68UWR9L8ZH3kJdx5SfVdoD/W6Wdp26auojiZPaE6uiljqIFv3bYgrn9yrDOkh0sR+XlcaB8vuflxHFuy8OGGvn1m2IE2OFhzwPoG8eBsL0zAtoF23k9yeoa04v/DSBhwZ8p1j+V/8Vv3jiq9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736555020; c=relaxed/simple;
	bh=hULAW5zNUxy2HHwEhYJHoBbEKDeRqobTSUtZ0q3TbJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAWMvXie9kpItOvxfwZYLqY8C5LutYohZrKXhZAhaWl5YwOLnRGl8pz0L89HF4Vebl8eJLEcvfW4VQBo+vEhEB8yBYl58Nzj8j2dz0Iz7fdbyN+xPKYKSa+3HbLunX39ne6gMpxmZsUb0od9NhJHzke/mDir8p3UH0FbP0vHD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1XWCf7J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so3567212a91.0;
        Fri, 10 Jan 2025 16:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736555019; x=1737159819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MqBZtFDQnU9SQi0Cdc0pNrcqU0DhfyLF9Syg6I1xU8=;
        b=c1XWCf7J8fQGlAhlGPl5nsDnWwrS/3sSYdzxVe4QfRpF4EH5eJ4bHPurJcCpCL9Plw
         yTwJlk/rRavHj84h6zOgbzappYCLzSVFKaQ8FQHba76ehwgIwMgAqJGm6EMP3MQmUZ5e
         jyGWKNu+o7UZQV4BAkocW+58CRLNDimQBa/UEhFQHazi2L9wc7TYejgghvtSXHdbAhYw
         mPL0EuEMQdfaiZbp2RY/TQiQYXZMDSmWfK2U9U0WayActHpAikxChjEOc32rtFyFdLXh
         rN6Q2Lo9tZFC1OyCvJnwrJePIO+Mc8+N82V2OBIFlotSzkFeW1ZMSMiWOrujcLpLwapO
         mjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736555019; x=1737159819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MqBZtFDQnU9SQi0Cdc0pNrcqU0DhfyLF9Syg6I1xU8=;
        b=toY6cKMRRvNOg1RZ68BR6jvy9jnf0h0JVU8ZhxiJoQtNW6hyjs5mlIY+TpjSNy4pHH
         xqGAe56SbyOMrjZ9kuuL+exYX37HYBUBm/RB0aWUjcdX8yW+gzgTa489/TzexQCDpmAw
         JVIhTX5jD/XM4H+0n0D+pqUMaYMbstYipbdkxMUM3AYaolNbzRiyzDvnAF83MOLv+1e9
         mZ/ELpX6FMaDrKUrK/inEtS0PQZe5svb5os2RxCwwIRu9mZ4cVJydNI44ClDbX8lSfRV
         MR9Xr1Kwr4RA+UqiogerGMsiF78IvOkTlw+02owA6Z73ZTCQM1hqWU885tZSrObR9M/G
         7PRA==
X-Forwarded-Encrypted: i=1; AJvYcCUDEKn2/+DfFbmI07XmxOGlL4detgAF5pMrfWVoVhBs2hv57CJ5GMtv5gFymPA7cgmfu2qwuiiKhWZ76SR/@vger.kernel.org, AJvYcCUSayDh38/kpPa8VoJ2+iXE0Hkuv9FBT5EettMxHop45GXSAHf0wj6+zeizKWR7EcgtF9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9coC3HqRGc/YYyW/8CuDsoP42JDcsZOwalY/39rTrIKJnaHW
	xSLyntllEprI6dTIqmX6vBG6L272HbdAjQOf/De40iZ+zikK1TliWWMk+wcIVYuU076RCQ1Fsxq
	9zGi1Jo9R3f2Nnuo5OtvUDz7IUAn3lg==
X-Gm-Gg: ASbGnctBFVefrutFlMDU4r1FaRwmHuh/PH4ui2Qz1nU+AwTEWwn9qwHiG6AeaXcvENK
	gHIYXDm0LsfoPWRteBsxT1soQX26lSHLvjSC68pWzse7EIJwZH9vSaA==
X-Google-Smtp-Source: AGHT+IEcFWo8nllSnpLchlkEG4j05rmXl1z8wMLdxLAr6D2cFq+qPvNNdfg6Va7n7qtCNhVCnDmv+fNq6LlL0rgm+8I=
X-Received: by 2002:a17:90b:5241:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2f548f6a009mr21056166a91.17.1736555018636; Fri, 10 Jan 2025
 16:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
 <20241211220012.714055-2-ariel.otilibili-anieli@eurecom.fr>
 <26180f2e-1ef7-45de-8e9e-f08a4e6a6d36@qmon.net> <2f7a83-67659b00-a301-5cf12280@99585095>
In-Reply-To: <2f7a83-67659b00-a301-5cf12280@99585095>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 16:23:26 -0800
X-Gm-Features: AbW1kvauuftRIoUQJ9hjf5iMLKEOAQPYsBRG7LCH1MppG3M1mJ8Tzq2Fw8pwQgY
Message-ID: <CAEf4BzbO=R-=4a2s8OF0Vhs+L4g+z0bwLm4q56eVRoWr6m5Zrw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selftests/bpf: clear out Python syntax warnings
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: Quentin Monnet <qmo@qmon.net>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 8:28=E2=80=AFAM Ariel Otilibili-Anieli
<Ariel.Otilibili-Anieli@eurecom.fr> wrote:
>
> On Friday, December 20, 2024 17:24 CET, Quentin Monnet <qmo@qmon.net> wro=
te:
>
> > 2024-12-11 22:57 UTC+0100 ~ Ariel Otilibili
> > <ariel.otilibili-anieli@eurecom.fr>
> > > Invalid escape sequences are used, and produced syntax warnings:
> > >
> > > ```
> > > $ test_bpftool_synctypes.py
> > > test_bpftool_synctypes.py:69: SyntaxWarning: invalid escape sequence =
'\['
> > >   self.start_marker =3D re.compile(f'(static )?const bool {self.array=
_name}\[.*\] =3D {{\n')
> > > test_bpftool_synctypes.py:83: SyntaxWarning: invalid escape sequence =
'\['
> > >   pattern =3D re.compile('\[(BPF_\w*)\]\s*=3D (true|false),?$')
> > > test_bpftool_synctypes.py:181: SyntaxWarning: invalid escape sequence=
 '\s'
> > >   pattern =3D re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
> > > test_bpftool_synctypes.py:229: SyntaxWarning: invalid escape sequence=
 '\*'
> > >   start_marker =3D re.compile(f'\*{block_name}\* :=3D {{')
> > > test_bpftool_synctypes.py:229: SyntaxWarning: invalid escape sequence=
 '\*'
> > >   start_marker =3D re.compile(f'\*{block_name}\* :=3D {{')
> > > test_bpftool_synctypes.py:230: SyntaxWarning: invalid escape sequence=
 '\*'
> > >   pattern =3D re.compile('\*\*([\w/-]+)\*\*')
> > > test_bpftool_synctypes.py:248: SyntaxWarning: invalid escape sequence=
 '\s'
> > >   start_marker =3D re.compile(f'"\s*{block_name} :=3D {{')
> > > test_bpftool_synctypes.py:249: SyntaxWarning: invalid escape sequence=
 '\w'
> > >   pattern =3D re.compile('([\w/]+) [|}]')
> > > test_bpftool_synctypes.py:267: SyntaxWarning: invalid escape sequence=
 '\s'
> > >   start_marker =3D re.compile(f'"\s*{macro}\s*" [|}}]')
> > > test_bpftool_synctypes.py:267: SyntaxWarning: invalid escape sequence=
 '\s'
> > >   start_marker =3D re.compile(f'"\s*{macro}\s*" [|}}]')
> > > test_bpftool_synctypes.py:268: SyntaxWarning: invalid escape sequence=
 '\w'
> > >   pattern =3D re.compile('([\w-]+) ?(?:\||}[ }\]])')
> > > test_bpftool_synctypes.py:287: SyntaxWarning: invalid escape sequence=
 '\w'
> > >   pattern =3D re.compile('(?:.*=3D\')?([\w/]+)')
> > > test_bpftool_synctypes.py:319: SyntaxWarning: invalid escape sequence=
 '\w'
> > >   pattern =3D re.compile('([\w-]+) ?(?:\||}[ }\]"])')
> > > test_bpftool_synctypes.py:341: SyntaxWarning: invalid escape sequence=
 '\|'
> > >   start_marker =3D re.compile('\|COMMON_OPTIONS\| replace:: {')
> > > test_bpftool_synctypes.py:342: SyntaxWarning: invalid escape sequence=
 '\*'
> > >   pattern =3D re.compile('\*\*([\w/-]+)\*\*')
> > > ```
> > >
> > > Escaping them clears out the warnings.
> > >
> > > ```
> > > $ tools/testing/selftests/bpf/test_bpftool_synctypes.py; echo $?
> > > 0
> > > ```
> > >
> > > Link: https://docs.python.org/fr/3/library/re.html
> >
> >
> > En version anglaise : https://docs.python.org/3/library/re.html
>
> Merci!
> >
> >
> > > CC: Alexei Starovoitov <ast@kernel.org>
> > > CC: Daniel Borkmann <daniel@iogearbox.net>
> > > CC: Andrii Nakryiko <andrii@kernel.org>
> > > CC: Shuah Khan <shuah@kernel.org>
> > > Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> >
> > Right, this seems to be a change in Python 3.12 [0][1]:
> >
> > 'A backslash-character pair that is not a valid escape sequence now
> > generates a SyntaxWarning, instead of DeprecationWarning. For example,
> > re.compile("\d+\.\d+") now emits a SyntaxWarning ("\d" is an invalid
> > escape sequence, use raw strings for regular expression:
> > re.compile(r"\d+\.\d+")).'
> >
> > although I can't remember seeing any DeprecationWarning before.
> >
> > Anyway, the fix makes sense, and does address the warnings. Thank you
> > for this!
> >
> > Tested-by: Quentin Monnet <qmo@kernel.org>
> > Reviewed-by: Quentin Monnet <qmo@kernel.org>
>
> Awesome, Quentin! Thanks for the feedback!

Seems like this was never applied, right? Ariel, can you please rebase
on latest bpf-next, add Quentin's tested-by and reviewed-by and
resend, so BPF CI can do another run on it? Thanks.

> >
> >
> > [0] https://docs.python.org/3.12/whatsnew/3.12.html#other-language-chan=
ges
> > [1] https://github.com/python/cpython/issues/98401
>

