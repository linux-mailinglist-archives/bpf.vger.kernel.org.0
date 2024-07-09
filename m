Return-Path: <bpf+bounces-34261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A523592C1EC
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5031F235F8
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6817B041;
	Tue,  9 Jul 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL0c9JQa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6E12C498
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543548; cv=none; b=hcyL/Fz2PIkqxTXrqh413bWobUHpOY8K80FVfyL6cje8eFRwbQd9tL6256zAZj0Yd+eJicl8hE9sqOeW0GvnSP/nMZj7/Mg2R4OjC9xsFZItl4nH5bjEAihTLGMPbpcyIOEtejtI438YawwQe2R8LfDdjj95g8J5aITxKwFBOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543548; c=relaxed/simple;
	bh=HR1ASpksMDBsMUmW/uyyACL4PpCz6RcQR1Wed+Kq+XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhZ1B+SFlVsB7WODisq6kxWeO5EgHsMSUJHE3qmorE0aSLatFJoeL5hbvMlMOGhY738vqWq796LDn9C4RM339xsct0n+tAReZxjMNY1Ofr1iCqErI0ksP8Z1D1ifiWYIJHzwno2Dkp3BVTZxdxX+EWdKfhl7ygRVbrnl8SE4Phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL0c9JQa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7662181d487so2199221a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720543546; x=1721148346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEBD109qJ9iYLCoTulpm5mQ2/g2v2NyitN3Vuj7+Bl8=;
        b=GL0c9JQaUYsFrtYWGZN1M4ZBgwVf5TwjmkBxT0RcjRaIIA5xDAzfrgQR15/jqbSqko
         ORWOmkgsi8AWvFPfUN/Ei7ZErlGxpAG/VipNwbSp/mnogXCRIsSJZFbpSHXgEOAUzGaF
         4D5Y9HIZclxqlZXgd+s8b0PUf5CETGy1dqjQzIyk9jXS5kiSrjZnvP9bWayKQ2ASPQNG
         i+B2872mjxo+4hoK7wnQzuaFpYUSTNDuJdt36sdZNb16UYMZsy2S4voAkjGnuGdXHn60
         zkrmA0wA86VMzvEaGFA55fN6XdRWRiPwh+KS9Nm01K20wyPCmyvoL+cLI7rofzKPruvD
         J+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543546; x=1721148346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEBD109qJ9iYLCoTulpm5mQ2/g2v2NyitN3Vuj7+Bl8=;
        b=uQw2iXEi+3tE7j++7y0MPjuH2mwkIOCKeW+NqONnhS4ite8lTneJoebFugATuryTZC
         7ZjXl3+9ygJma+egvM+MMv26Wdgld5AvVr2UYVGpoUkK5TUzkMjciAl2NMdouTZis1Xp
         huh33Pk6yc0/xBd/zhUXecdWpoWL1vrms4o9Bb5nlTSKGBQrVb6f6N8HzUJe6Nwvo305
         K2RzDW/2+VuSXed/BckFYW76Sv0ip7HLdKJH+WdjbcgwjmeJcv83ZGVI/PxAmxpA+6fR
         2/r5f8P2sFtG84+3iZZpGOfYH/DuEBmvJRx2/CK78eY8FTrHF2+jONqAXE9/lKlwT8HB
         4chw==
X-Forwarded-Encrypted: i=1; AJvYcCWTAJalhCA25I2vwV3fK0ExIoeNt9UTR4IsBpZkVHpTPAZiRxU8N7RoTFgvNytuT+kChuyYaYxKwfuVFjQS3+NPFzFi
X-Gm-Message-State: AOJu0YzzmWf5414aT8jZISyo2viW5Au+lPJbz92S6rsVocQALgjPJnFw
	LCLvmlsnT/iDumVF6NKZonpPFhE9GgLX9FQR+r5ZwsAiOpDQeTvd0ZIf4iLSw1w2utesZ31AWfi
	iZaQKoFPhN+AZd45L4u2UHoNvCf0=
X-Google-Smtp-Source: AGHT+IF2rAoXdS4zHQsSHKLMnDjtbT60ly7kHfRc4qzq8Hxy6kev4IowZkRLbjsXgdTtQ9b4bKGeqT+oB+yUC+zIw7Q=
X-Received: by 2002:a05:6a20:729f:b0:1c2:9320:758a with SMTP id
 adf61e73a8af0-1c298221cf1mr3287903637.15.1720543545891; Tue, 09 Jul 2024
 09:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
 <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev> <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
 <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com>
 <CAEf4BzZac9SXdNHT3SwzAF4OGddj1KKpMNNQRwW_Rf5o+Jakbg@mail.gmail.com>
 <CAEf4BzZ3iTi1KGU6toCaKrzjQvP5SrJiB5LK0sSOTdctB_93+A@mail.gmail.com> <CAADnVQK9LbN2AbHj653RE45MeZYmpzJOHFRGRjRUVqeLEGRmsA@mail.gmail.com>
In-Reply-To: <CAADnVQK9LbN2AbHj653RE45MeZYmpzJOHFRGRjRUVqeLEGRmsA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 09:45:32 -0700
Message-ID: <CAEf4BzZJ-d3RB-n-URBs23saLYTn7nLFfjsymHW_ZG_N=EJ41A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 3:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 3:11=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> > > >
> > > > [...]
> > > >
> > > > > > the 32bit_sign_ext will indicate the register r1 is from 32bit =
sign extension, so once w1 range is refined, the upper 32bit can be recalcu=
lated.
> > > > > >
> > > > > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > > > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D=
0x7fffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=
=3D32,var_off=3D(0x0; 0x3f))
> > > > > >    if w1 < w6 goto pc+4
> > > > > > where r1 achieves is trange through other means than 32bit sign=
 extension e.g.
> > > > > >    call bpf_get_prandom_u32;
> > > > > >    r1 =3D r0;
> > > > > >    r1 <<=3D 32;
> > > > > >    call bpf_get_prandom_u32;
> > > > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > > > >    r2 =3D 0xffffffff80000000 ll;
> > > > > >    if r1 s< r2 goto end;
> > > > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=
=3D0xffffffff80000000,smax=3D0x7fffffff) */
> > > > > >    if w1 < w6 goto end;
> > > > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff......=
.., then the range will be
> > > > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and=
 this range is not possible compared to original r1 range.
> > > > >
> > > > > Just rephrasing for myself...
> > > > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFF=
FF
> > > > > then lower 32-bit has to be negative.
> > > > > and because we're doing unsigned compare w1 < w6
> > > > > and w6 is less than 80000000
> > > > > we can conclude that upper bits are zero.
> > > > > right?
> > > >
> > > > Sorry, could you please explain this a bit more.
> > >
> > > Yep, also curious.
> > >
> > > But meanwhile, I'm intending to update bpf_for() to something like
> > > below to avoid this code generation pattern:
> > >
> >
> > Well, thank you, Gmail, for messed up formatting. See [0] for properly
> > formatted diff.
> >
> >   [0] https://gist.github.com/anakryiko/08a4374259469803af4ea2185296b0c=
b
>
> Not that simple. It needs sizeof(start)=3D=3D8 extra hack like bpf_cmp().

I'm forgetting the details, but I feel like sizeof() =3D=3D 4 was
important for bpf_cmp() to compare wX registers instead of always
comparing Rx. But in this case I think we are fine with always working
with full 64-bit Rx registers. Or is there some correctness issue
involved?

> And the same with 'end'. So it will get just as ugly.
> Let's make the verifier smarter instead.

Oh, absolutely, let's. But that doesn't solve the problem of someone
using bpf_for() with the latest Clang on an older kernel that doesn't
yet have this smartness, does it? Which is why I want to mitigate that
on the bpf_for() side in addition to improvements on the verifier
side.

