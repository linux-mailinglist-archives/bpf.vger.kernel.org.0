Return-Path: <bpf+bounces-36948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDDD94F8B2
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AE01F21496
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264316BE03;
	Mon, 12 Aug 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Llw2Kx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA07139597;
	Mon, 12 Aug 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496586; cv=none; b=UPFGysDrHtuPljVEpBkbzaC2SeQywebq8e5BlfRmRdjnYgaZUD3A67zPDJ8tNGZ0rs59IymbZ3OyZl5RQIplaDbo2DK1QMxCKjANYkajCVuJfeYY1+5sN0rF6wR/kqXIfaRKe5fOpcF4hNGumx3NOmiv6nesyXiXXamFlfMXERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496586; c=relaxed/simple;
	bh=r3Y8fYhLCUxDZT78PzQPsphnBBNWdXOoKXPQwzbaauE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQDCbriO+TWxnxXXUcMDq6o1XziZoveI+antfEsFf7I+b+ZBxilLziMMtdLiCjLxhdIy8TRdgeefLJ8wRoKpIY+3N5+gpY6ok8eJQE35JZW2Gqb/F9KkQy9VYsva6PeSVav1Ao2YGwAjO/0QvyOnH9B33Y55abbVcqx43O/w0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+Llw2Kx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d37e5b7b02so760610a91.1;
        Mon, 12 Aug 2024 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723496584; x=1724101384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb6gdPq87OqxZCVBjG5F3SsyS4cmABBcSEGd4+uu1lE=;
        b=I+Llw2KxGmt0usxSiuU1aT/0bfBvfDiBqeu20hRtYzNa4NxqEvUFRHtFljsgm+Fsvb
         Wh/WPhIXJLpwLSra+3bDg07I7vI6qrh5hH5ouASMg0xrklQR5iti/NZc4ZjcEqsZFJ1T
         nKiPSCDIo5/ZYFJDnBn+02oDhIp0b6OTMWsV2JuV3/mhjSUoCoFhC8hWlkFNMNgnayvS
         qSh8moiIMZ+jHmZ7yUYW4tt20zvOIlsW5Cxs5RoGdLMOsHIQdX1qP2ZRfMVGzy402cwL
         9uyBiHWJvb8JGc8iiVJBWDXWklO/UQpkzN23DsOHD0aZArpQ5ngvTKMFL1rv9hz1zvyb
         HfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496584; x=1724101384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb6gdPq87OqxZCVBjG5F3SsyS4cmABBcSEGd4+uu1lE=;
        b=OIM4oUxTKjnv5aiZhMdxRNAMizMAO6p1cQWSHt4fn89ScXsfrhJVTn4OUf72TgAelP
         YLH6ttPVSezDv6NC0FCIsoRmoao8VwAJjYXthSVkTCE4RBpfV+6YlauT0iYvhvkcwLG5
         r8+3k9HDObfX5JWjDqfqHukjCuLpFcjmFn6o+XqaxH6vi1ur/G5qNSsDQypZdVZrzh5k
         2qgfgLYxmRFcqZB10FmpS2gXMGZ1YMyLNvbhHcoqESjVhVfcv1eX7O/wRizrJ2G/sT5S
         iIf9zWQyhIbNTq2EgiUNTOzUxE2+scjYr1gmuyf9LtUJrK9aVFZyHBfv41DP2xMt/d2C
         MQMg==
X-Forwarded-Encrypted: i=1; AJvYcCWiTNBJGSss5+TxJyw8hEwn+3WEXaWrkiU8/kBN6ORAjukrdNYXjqMuI/u3Z4rKXjF0/5AQ6WmEhOLVRA9iC7A8/i4L9g+ojY80W9Ub1pI3f7pgzt10RyorVVeF3AI9xQII
X-Gm-Message-State: AOJu0YwM8EB6V8Ht93bOuyq6kka20eeBFPVZ/LXG3wjggOoBasQrxMoc
	BsvN9UPNO4a+VwuXtgiMrU03KjPuOMWGSMbt1vxTp2xv4LwSR//kUhytG0m82tXHFupgYIphBTr
	zxqzwI93yv4IjHxWPnRCHv/8xtXI=
X-Google-Smtp-Source: AGHT+IFOJHZTC8EeRQS5yjjQMVOVEENflZ5CGyDuDMFGkw6oRbApFHiGIDFsiCVCftrrKZ0VZXMLDRNRHM1rzmwcovQ=
X-Received: by 2002:a17:90a:9f85:b0:2cb:f9e:3bfb with SMTP id
 98e67ed59e1d1-2d3926236e2mr1551193a91.32.1723496583981; Mon, 12 Aug 2024
 14:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>
 <61cf5568-7a01-4231-8189-006bde4ec0ad@oracle.com>
In-Reply-To: <61cf5568-7a01-4231-8189-006bde4ec0ad@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 14:02:51 -0700
Message-ID: <CAEf4Bza3RH6p=KJu8cm2jb4QwKCHc5ZUskE9cvWTBXyXFUKHuA@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: workaround -Wmaybe-uninitialized false positive
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Sam James <sam@gentoo.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Andrew Pinski <quic_apinski@quicinc.com>, 
	=?UTF-8?B?S2FjcGVyIFPFgm9tacWEc2tp?= <kacper.slominski72@gmail.com>, 
	=?UTF-8?Q?Arsen_Arsenovi=C4=87?= <arsen@gentoo.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 12/08/2024 11:37, Sam James wrote:
> > In `elf_close`, we get this with GCC 15 -O3 (at least):
> > ```
> > In function =E2=80=98elf_close=E2=80=99,
> >     inlined from =E2=80=98elf_close=E2=80=99 at elf.c:53:6,
> >     inlined from =E2=80=98elf_find_func_offset_from_file=E2=80=99 at el=
f.c:384:2:
> > elf.c:57:9: warning: =E2=80=98elf_fd.elf=E2=80=99 may be used uninitial=
ized [-Wmaybe-uninitialized]
> >    57 |         elf_end(elf_fd->elf);
> >       |         ^~~~~~~~~~~~~~~~~~~~
> > elf.c: In function =E2=80=98elf_find_func_offset_from_file=E2=80=99:
> > elf.c:377:23: note: =E2=80=98elf_fd.elf=E2=80=99 was declared here
> >   377 |         struct elf_fd elf_fd;
> >       |                       ^~~~~~
> > In function =E2=80=98elf_close=E2=80=99,
> >     inlined from =E2=80=98elf_close=E2=80=99 at elf.c:53:6,
> >     inlined from =E2=80=98elf_find_func_offset_from_file=E2=80=99 at el=
f.c:384:2:
> > elf.c:58:9: warning: =E2=80=98elf_fd.fd=E2=80=99 may be used uninitiali=
zed [-Wmaybe-uninitialized]
> >    58 |         close(elf_fd->fd);
> >       |         ^~~~~~~~~~~~~~~~~
> > elf.c: In function =E2=80=98elf_find_func_offset_from_file=E2=80=99:
> > elf.c:377:23: note: =E2=80=98elf_fd.fd=E2=80=99 was declared here
> >   377 |         struct elf_fd elf_fd;
> >       |                       ^~~~~~
> > ```
> >
> > In reality, our use is fine, it's just that GCC doesn't model errno
> > here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly
> > by initializing elf_fd.elf to -1.
> >
> > I've done this in two other functions as well given it could easily
> > occur there too (same access/use pattern).
> >
>
> hmm, looking at this again - given that there are multiple consumers -

yes, I don't like that each caller has to remember to initialize the
struct that is clearly initialized by elf_open() itself, so see below.

pw-bot: cr

> I suppose another option would perhaps be to
>
> - have elf_open() to init int fd =3D -1, Elf *elf =3D NULL.

I'd do just

elf_fd->elf =3D NULL;
elf_fd->fd =3D -1;

and do nothing else. This should be enough for compiler to not trigger this=
.

> - have error paths in elf_open() "goto out"; at out: we set elf_fd->fd,
> elf_fd->elf to fd, elf
> - have elf_close() exit it elf_fd < 0 (since 0 is a valid fd), as it
> will for the error cases
>

Let's not touch anything else, this should be enough.


> Might all be bit excessive, and might not even fix the false positive
> issue here, so
>
> > Link: https://gcc.gnu.org/PR114952
> > Signed-off-by: Sam James <sam@gentoo.org>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> > v3: Initialize to -1 instead of using a pragma.
> >
> > Range-diff against v2:
> > 1:  8f5c3b173e4cb < -:  ------------- libbpf: workaround -Wmaybe-uninit=
ialized false positive
> > -:  ------------- > 1:  12cec1262be71 libbpf: workaround -Wmaybe-uninit=
ialized false positive
> >
> >  tools/lib/bpf/elf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index c92e02394159e..00ea3f867bbc8 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -374,7 +374,7 @@ long elf_find_func_offset(Elf *elf, const char *bin=
ary_path, const char *name)
> >   */
> >  long elf_find_func_offset_from_file(const char *binary_path, const cha=
r *name)
> >  {
> > -     struct elf_fd elf_fd;
> > +     struct elf_fd elf_fd =3D { .fd =3D -1 };
> >       long ret =3D -ENOENT;
> >
> >       ret =3D elf_open(binary_path, &elf_fd);
> > @@ -412,7 +412,7 @@ int elf_resolve_syms_offsets(const char *binary_pat=
h, int cnt,
> >       int err =3D 0, i, cnt_done =3D 0;
> >       unsigned long *offsets;
> >       struct symbol *symbols;
> > -     struct elf_fd elf_fd;
> > +     struct elf_fd elf_fd =3D { .fd =3D -1 };
> >
> >       err =3D elf_open(binary_path, &elf_fd);
> >       if (err)
> > @@ -507,7 +507,7 @@ int elf_resolve_pattern_offsets(const char *binary_=
path, const char *pattern,
> >       int sh_types[2] =3D { SHT_SYMTAB, SHT_DYNSYM };
> >       unsigned long *offsets =3D NULL;
> >       size_t cap =3D 0, cnt =3D 0;
> > -     struct elf_fd elf_fd;
> > +     struct elf_fd elf_fd =3D { .fd =3D -1 };
> >       int err =3D 0, i;
> >
> >       err =3D elf_open(binary_path, &elf_fd);

