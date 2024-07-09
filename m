Return-Path: <bpf+bounces-34262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86ED92C1F3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4881C23653
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E575182A5F;
	Tue,  9 Jul 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJJoxCx8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E3182A53
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543787; cv=none; b=GOMAjw+38gwT+NvlBp2wJyGGo2pDcoFHXNJIMDe1Z+BXQbsBLqIZ8kkJCB3mk0NyytYhb7iy99PfNEy74KclrCuQmjBmhrCDit+qzHrHYwx87535b9lsA63tJyKUfXaH5p/cVfqC1/SENfN65v6GuZ+Jkq1BtH7RkoGq/S2xtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543787; c=relaxed/simple;
	bh=lFptudgxU/pzvKGih9ppQTo3h69pdtzLaymdLylXV5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOLslRybFFw7LGAMAsdMOiUeoiCwOF1mL/FwWSZiC74y5EvPQ9P3E8tXpNtQnzRNcSdf7coe2L0Qj37Cirqz1IC3oJU+Cb72K4xfUFr0lVTXT58FazRUI0XfC60tEPyk3+rNLzvIbubxgllAM01GH73O4aA7hlMi8v5x0zX8lEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJJoxCx8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c98b22638bso3649728a91.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720543786; x=1721148586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b6B9sLWIs+i/zGhzrVkZPIFHsIaHMl6TVF82nW6t14=;
        b=BJJoxCx8Yk7bBPGPcRb3bY6Kbk654D2pSdxf+MsR+PpiQJnr8FgNk35rAMC10AnuOt
         5WdhTjzzZ1qMUKE2bFreGcI4QSXROm8W8Hv/2VwR/8CqRvxiBS4V3biLvduZ2jc4QeFh
         zXIoMLJmor06k0olqoHgzh2wRKXd1RHrLvSKR28qi+Q2ojR6c8YG+wzpxMeNtv9ab1di
         FqJOKHRp1j8ZjN77ugjBLUmfP6Qx5mXsjcfmARFlYa3i9IjCY++R4kWBwtmtFy7kepmk
         WFBDc21hxc0baiv+anNahcG/ka9+TaPIuDUX2Nd250N9urVNO8lFKb1MvnrSqFwgNmIq
         AV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543786; x=1721148586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b6B9sLWIs+i/zGhzrVkZPIFHsIaHMl6TVF82nW6t14=;
        b=d83ItdikjoTVp+RB7NmIDWItOpKgE725mNojbnwSWOWiitT2p1CKSnCiC3x0+m9hP0
         vudB7yEECcF+OFuMit/lKL/Z7ZIhZPq80zKG4FG5ZdYCUncW6jS4Br6ANtnNpDU6mT+c
         /oQOIf1cK2kvqCY2U/nhXrj03ZrGbYYCRYOgJkgnw4bDkJD/LhlzUZuEwiuj4G0Mp2M2
         wRihsqJ4VEUWcnTF8rZvwgwpK0JuaLERTduTOYh3DNXR8g0xiSiVY2xraHmi3Jk/wPLG
         oWnScAd0eaMSLWli5n3esAba4QXleMiVQAGr48TlfCqpSHuiAQRO+/Ndko49H0xGIDWp
         As8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLfCKhtNCWoYxa1g6i1kwORQTmg0/Fq1mFnkHlLZaSBVoNsu+u8ut/NNFSh3jww91LzgBhNaQ98VRQYMHv7oOqUmTY
X-Gm-Message-State: AOJu0YxpjUiorJbKExQqKpYPvJLHoALKMDUSljTIsedaJcizgKN9ISY4
	KBH39lvdDj3o9LIniPnmfub7XV9eS0ruAh4kCRvRaV0YvagjKVCFZlpF93XhE/wS8ptV1edurlU
	pkJvoOryPNhitXRG1oCj+k4iOg1Y=
X-Google-Smtp-Source: AGHT+IEpRFqTgI1yW53lGI0HhqsEnammQvmVeYtYtz8GUY3IJWsHyGKz+jycti+ovQ5qM7vgYJXyG/R9x4RPwAGwhqg=
X-Received: by 2002:a17:90a:c293:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2ca3a7c744amr4179408a91.9.1720543785598; Tue, 09 Jul 2024
 09:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
 <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev> <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
 <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com> <CAADnVQKMVwtX+=h72Xj0t_ijiUQPVv6_6iKBmx4k1P3cO=AS8g@mail.gmail.com>
In-Reply-To: <CAADnVQKMVwtX+=h72Xj0t_ijiUQPVv6_6iKBmx4k1P3cO=AS8g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 09:49:33 -0700
Message-ID: <CAEf4BzZrZ=XBsNJzXRFdZQSkQyASKWzXbPwubOBbVD6=743Sfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > > the 32bit_sign_ext will indicate the register r1 is from 32bit sign=
 extension, so once w1 range is refined, the upper 32bit can be recalculate=
d.
> > > >
> > > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7f=
ffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32=
,var_off=3D(0x0; 0x3f))
> > > >    if w1 < w6 goto pc+4
> > > > where r1 achieves is trange through other means than 32bit sign ext=
ension e.g.
> > > >    call bpf_get_prandom_u32;
> > > >    r1 =3D r0;
> > > >    r1 <<=3D 32;
> > > >    call bpf_get_prandom_u32;
> > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > >    r2 =3D 0xffffffff80000000 ll;
> > > >    if r1 s< r2 goto end;
> > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0xf=
fffffff80000000,smax=3D0x7fffffff) */
> > > >    if w1 < w6 goto end;
> > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff........, =
then the range will be
> > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and thi=
s range is not possible compared to original r1 range.
> > >
> > > Just rephrasing for myself...
> > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
> > > then lower 32-bit has to be negative.
> > > and because we're doing unsigned compare w1 < w6
> > > and w6 is less than 80000000
> > > we can conclude that upper bits are zero.
> > > right?
> >
> > Sorry, could you please explain this a bit more.
> > The w1 < w6 comparison only infers information about sub-registers.
> > So the range for the full register r1 would still have 0xffffFFFF
> > for upper bits =3D> r1 +=3D r2 would fail.
> > What do I miss?
>
> Not sure how to rephrase the above differently...
> Because smin=3D0xffffffff80000000...
> so full reg cannot be 0xffffFFFF0...123
> so when lower 32-bit are compared with unsigned and range of rhs
> is less than 8000000 it means that the upper 32-bit of full reg are zero.

yep, I think that makes sense. This has to be a special case when the
upper 32 bits are either all zeroes or ones, right?

