Return-Path: <bpf+bounces-54160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F60A63F1B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 06:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F037A48BE
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7F215066;
	Mon, 17 Mar 2025 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="hRYAmMvY"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB611CD2C;
	Mon, 17 Mar 2025 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742187914; cv=none; b=QRRHsY6nwhkThwwZ2Ix3zDQ9CIIGN886hBwPipztj4Yx0ZCQUxHdvHtW3EoQC6etbSDWX++i5g0Y90Cy8WyjNzUqy5pW95oXOI9edbiSLqUaFoFgPDOG8nAEMjz06kfP2Q/JiDP/aMQt4wUTEDw272yf8hKQ659pV7O6fYV8HFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742187914; c=relaxed/simple;
	bh=2j2cV21FgM/8/ZWuQEAf2CTVTrE95v9rMrKC1HP20ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPQROmG+QKghY9CxvDZldLJn0RyDQFqyb0LZOMi+jZJpRXXNbzP/eyQWyBiC3CRhLl9B2byDqJUr+dz/QSLBRsj5MCFtnC6spayCZnWYTZpYVb+9rYCcTVgXoT9MWQxiXWjtxW7w0BLwfxYXPe7TfeJG5AyWDgOEg1eZjT8LYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=hRYAmMvY; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742187899;
	bh=M2UUyPvJ2y1MZA15wI3jxejuhS+GebCXKcVs2DOBs/Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=hRYAmMvYO6VsMN6MSpcC4ECIbLb7hkRcJyF78nYlVGsR4B4Y5erfre2sSAZoPys2n
	 HU7bTpxHv4jywwhyPmYz1AW1jPuLQOc0MDRFpAcDC3H0LsxciQojKzf3ogkpo0A2jg
	 uOrs07SaA/frFBAIqa6Y3XVywRBKUVnazBsTuleA=
X-QQ-mid: bizesmtpsz9t1742187895taj7j1y
X-QQ-Originating-IP: Z5C9+vlboSe8gW7/MYXuaRljzoEiXeNTh6d8mTpRtTo=
Received: from mail-yb1-f180.google.com ( [209.85.219.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 13:04:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14577142841368056084
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso3027648276.2;
        Sun, 16 Mar 2025 22:04:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVghobj7YH88mE9czZAaN1XSd3qq0g7VamUFN4Jn/Ynk8wZAiQGBZXyDIpwYHzpviCyQIU=@vger.kernel.org, AJvYcCWXV5GG1CUxlYNrr/cEBTxtSDKIDT8UF4OjQvFpeeqHaMwrsdyQGktrx/TuocBr75iXwXzM6vrv@vger.kernel.org, AJvYcCWx26V7GA75d8WSKwAoFJCBLxzCDa+aSkwCg6aks/cU82SnGc5l90ckmG060rP3un1q8eZu2D3vMkBpVBYR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ao3+D66Euf4f8WifBOmpolm1lmBRuJKw8b/NpDNZQh9dcci/
	dl55LrvSYk5Uz4S2upJ4XyVrBDhH3oYB46V4eZ1MTf0zmqRHOq+8IQED+wPtTSORp6wm5wTNgS/
	DPoVhcJkr3Zb3cI0TfJuBqzm6cQ4=
X-Google-Smtp-Source: AGHT+IEclvi37l+5wwO8UmE2nDEZ7P2yrAPC5bWt1YuMHgdSe08lN5oTlUNdlPZn2kALuCGJK82TUIC2DrHQhJs+K4Y=
X-Received: by 2002:a05:6902:2504:b0:e63:c2d2:94f2 with SMTP id
 3f1490d57ef6-e63f64d6613mr12913981276.4.1742187892688; Sun, 16 Mar 2025
 22:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org> <2025031759-sacrifice-wreckage-9948@gregkh>
In-Reply-To: <2025031759-sacrifice-wreckage-9948@gregkh>
From: Chen Linxuan <chenlinxuan@deepin.org>
Date: Mon, 17 Mar 2025 13:04:41 +0800
X-Gmail-Original-Message-ID: <90633147F3110D54+CAC1kPDNNBj3Hd6s72mA3qxwxC0B69aE7qhM+Az5msvjPy41N5w@mail.gmail.com>
X-Gm-Features: AQ5f1JosL4TAodELERN3orTFlcWSuf3HluXcDHfk5v-mc_DcPgobK1IZuHPieJM
Message-ID: <CAC1kPDNNBj3Hd6s72mA3qxwxC0B69aE7qhM+Az5msvjPy41N5w@mail.gmail.com>
Subject: Re: [PATCH stable 6.6 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
To: Greg KH <greg@kroah.com>
Cc: Chen Linxuan <chenlinxuan@deepin.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Jann Horn <jannh@google.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: OH/oXo99N/TG8mylz+IzWatGYXRibEcyvlAzrNL0VlFXupXGcw66w6a4
	hCzjgYdXpdWRrEUsgQYqv+yUIdkO7V2KIz5F40/221+0SXNrHAmZd5io45T+DsujC2+enDe
	mwgfUJDk/Et7jFUZ5qPgyEQRLqOQbpUcl+4gZPlNtOaAx2KiZ39LVrGTUDmqyA0nXKzuSw7
	Y1+vCpI08n00GP4O1XDFawTZZECo+FV3f7/rz8XobBFwQCzLTQA486QsT3gLSCobhY1RDU0
	gzqOfAbaeC2B9Tvw0Hba2OVjz12lm1LiQrY4d6sgdaSfwP/AZAJfjCaU9t31UkpXugPQkPV
	odplmYzsHwlCHVzCadpRvkUIhQ2Rm9FvcjHFRSHvr2unSVdLWPK4vUGpYXaSlyZLDOKBEqi
	oSEW5+LAcLjmCLlsfhEmWeTDOEtck1axvJCTminWOXBJcAuppNKB8XKIThi1r/rth9l8ZSO
	eaiUEtXSY4L6ammhsRXaQeTZJqPSb/vwSTRMgOpNwxUaFm4jz5OqIRw3mBeDRJ3Hm2wSAGe
	5vQ0259CINzYtE4o6Y8G9qQhrp1NxTs+0vm7gjlGK/ouJw61HcTwnYxhf336tQmkwTCvW7n
	elQ9J3EAqiUbdRn5e/3HW9IbO5ND6vnUMHpINkGtXs/7AcPqnn5Ium6YU2NYAdHpRLcch7K
	Nart/+Jzo2ViuGMJ+XAreVIgsiC1k+fueKcgeZJqyXtcwrXcpnH1EtmgGSicqbhv3dRrYV4
	tC2SJPc/GlvTrMjVjdep4uH+CJwFYY8oajvMNUVoyngYRhkaglIYKp1blxZ5WS41vHIGYTj
	72+aVWaW0mZySFK50z31NyaF3jnrva2N0OmBfTykmynSmWp5lLX17GJsfFMHF+0sg/yzAkl
	1+kZ4FXWb7AAGA2/HXiVll4PS2oiU+MZOScSs3aqWAyWFFPJeNiv1eu97dJIQnBGL5ZDXrD
	sPwNNZQFcEdd/+Gbwcok6lF/W1gn3AqHzusgjH150IN8oeSMwesarENz8V1MmzmDUVTAHj1
	9y6F2CDgt1RIxNmVFqUilwKiwrdIuoLLABILuqqLUqrQ7NQt7Q
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Greg KH <greg@kroah.com> =E4=BA=8E2025=E5=B9=B43=E6=9C=8817=E6=97=A5=E5=91=
=A8=E4=B8=80 12:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Mar 17, 2025 at 09:16:04AM +0800, Chen Linxuan wrote:
> > [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
> >
> > >>From memfd_secret(2) manpage:
> >
> >   The memory areas backing the file created with memfd_secret(2) are
> >   visible only to the processes that have access to the file descriptor=
.
> >   The memory region is removed from the kernel page tables and only the
> >   page tables of the processes holding the file descriptor map the
> >   corresponding physical memory. (Thus, the pages in the region can't b=
e
> >   accessed by the kernel itself, so that, for example, pointers to the
> >   region can't be passed to system calls.)
> >
> > We need to handle this special case gracefully in build ID fetching
> > code. Return -EFAULT whenever secretmem file is passed to build_id_pars=
e()
> > family of APIs. Original report and repro can be found in [0].
> >
> >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> >
> > Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader a=
bstraction")
> > Reported-by: Yi Lai <yi1.lai@intel.com>
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.c=
om
> > Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kerne=
l.org
> > [ Chen Linxuan: backport same logic without folio-based changes ]
> > Cc: stable@vger.kernel.org
> > Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> > Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> > ---
> > v1 -> v2: use vma_is_secretmem() instead of directly checking
> >           vma->vm_file->f_op =3D=3D &secretmem_fops
> > ---
> >  lib/buildid.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 9fc46366597e..34315d09b544 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/elf.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/secretmem.h>
> >
> >  #define BUILD_ID 3
> >
> > @@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma, uns=
igned char *build_id,
> >       if (!vma->vm_file)
> >               return -EINVAL;
> >
> > +     /* reject secretmem */
>
> Why is this comment different from what is in the original commit?  Same
> for your other backports.  Please try to keep it as identical to the
> original whenever possible as we have to maintain this for a very long
> time.
>
> thanks,
>
> greg k-h
>
>

Original comment is in a function named freader_get_folio(),
but folio related changes has not been backported yet.

thanks,

Chen Linxuan

