Return-Path: <bpf+bounces-34266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742D92C249
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16D12828E3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCCB155C83;
	Tue,  9 Jul 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSmXIPed"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD21B86C8
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545773; cv=none; b=cbqPm1UiCiWmBKNipF9njcOsoP13jRRS6hY66rUBA/L3nP+Clrfp5B48HK1uPvbpaBSdk+wOI5PQQ6sxUZdLHehrD3MZzFmBAqZYX7obSPIuiNsiT12RnZrHxI9thdl9lRnSwUqP401BxZ2FMxX5aU2QdTKvutceOtinMGBkO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545773; c=relaxed/simple;
	bh=hhU54i7fJ2j05Z+OddbF+Gv5oSI58ZxUPjy6HNpum9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZC5FnBqvelvxWiL9hMt1N2tIZAO5AvLf/K3tnhSxK8WIUCUkFbRp1RalKfdyaEtHGXOCovSUS+CHM+FfAb7pAdRic5wE7KB1E5CXgtJ07r+OrM5Hy/+p9RN81ecrQqG1M1DqGzv3zjIXgY12j6RsE/NpRRi7CZMpo4Ra67dyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSmXIPed; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-356c4e926a3so3496776f8f.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720545770; x=1721150570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIjIu0emLFWHkRbOaTFnNl2YKz219SiJJMy04UlKrZU=;
        b=iSmXIPedsbq8FCs9GkbpzOs+rEh8ChKt80HgelD18xWWyVeKJit13RqnffJngrrAS/
         AzJPmdwFVIKAsK/WNl5TX8tn7+leezsbl8JeSPGRRfAMUJvkcs587haEC+cwtUau/bCY
         baR7FkAF4s1nHiRTH3wA1gMBknRt+fkzzM7B0yAjPt8WXgerhqiDS0kx8UqYj0/FeWZy
         rKCZZx27OYHxl2oO2hR2H6ngOVwAwSmkIFPL1nsegLPb1AerM7jLRkJyrME32c5KWhfx
         VT5/QhmxAmviylH5xNxzxF5JiDy/M4YxLrBjxBcLtevsJ5VWULxiavr6KqMzJpUyf3yU
         oh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545770; x=1721150570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIjIu0emLFWHkRbOaTFnNl2YKz219SiJJMy04UlKrZU=;
        b=q47JPPvpeuJJAbIqGH9lpuNdQjHj81NHrNgfQBfJ4vYqO4NINZOoR3f/wHttM1pFsv
         gLq32djSciF/ScRWF1fCEUYo34msrGhZE+7QOwDjAdpsjLsZPPYAMfINHxx+HNKsrrWN
         VnhgCEmqD3eWHIrYwLbUV8fnNHnR726vvCXHqfK3ii/r3L+UYNbwcG/DQ+1ojo4FgOKD
         Sxr67M6YbbgIrhQCo8a90WdFSQZ6XOe5daT+pMgZuBn6lA8XHuGOWAPvJUihcPSITH3k
         JjrACTYPXU8LVNM+YrlZGIpnHue9ac8XQeuWAmZeM7qaYIaiSGECZBPGEQNPUieiAVmm
         2yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtecDTxFHbXwvRQjXcYrO31GnCTCflWgEZMerjAYvlGZlDyW9ugmlWLnCGlbACzyvgSCunSwgrfJhdmyNmWGzbXdZm
X-Gm-Message-State: AOJu0Yy0JAJ4IyFCjcoOa43kcvgYSWUvrpngQnZlFcWZbGYJKfV8k63V
	OH672raWMVDjov31Q9WVYdIa4OLtv0MslJTkFfMr0Dh/aLN6koNxiPjJafaCMDaRhvfIM6vE/4R
	NhhOKGJ81J0LiRWMaKHXUAEtuSK8=
X-Google-Smtp-Source: AGHT+IFGL9AufBuDFW8FKMoh2jmPD9LTdrWEpL5uArIYUvoTWQJykVbX/p6wzqO7cbaZVQp2i6hxZ9BK4gDGDYwAHck=
X-Received: by 2002:a5d:438f:0:b0:367:9765:b2ae with SMTP id
 ffacd0b85a97d-367ceadb47bmr2129744f8f.61.1720545770130; Tue, 09 Jul 2024
 10:22:50 -0700 (PDT)
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
 <CAEf4BzZ3iTi1KGU6toCaKrzjQvP5SrJiB5LK0sSOTdctB_93+A@mail.gmail.com>
 <CAADnVQK9LbN2AbHj653RE45MeZYmpzJOHFRGRjRUVqeLEGRmsA@mail.gmail.com> <CAEf4BzZJ-d3RB-n-URBs23saLYTn7nLFfjsymHW_ZG_N=EJ41A@mail.gmail.com>
In-Reply-To: <CAEf4BzZJ-d3RB-n-URBs23saLYTn7nLFfjsymHW_ZG_N=EJ41A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jul 2024 10:22:38 -0700
Message-ID: <CAADnVQK+96cCOSLfrkP5bxDcK7oLG8BFrhzoJ72P2P0D90HZjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 7:04=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 3:12=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jul 8, 2024 at 3:11=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > the 32bit_sign_ext will indicate the register r1 is from 32bi=
t sign extension, so once w1 range is refined, the upper 32bit can be recal=
culated.
> > > > > > >
> > > > > > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > > > > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=
=3D0x7fffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax=
32=3D32,var_off=3D(0x0; 0x3f))
> > > > > > >    if w1 < w6 goto pc+4
> > > > > > > where r1 achieves is trange through other means than 32bit si=
gn extension e.g.
> > > > > > >    call bpf_get_prandom_u32;
> > > > > > >    r1 =3D r0;
> > > > > > >    r1 <<=3D 32;
> > > > > > >    call bpf_get_prandom_u32;
> > > > > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > > > > >    r2 =3D 0xffffffff80000000 ll;
> > > > > > >    if r1 s< r2 goto end;
> > > > > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=
=3D0xffffffff80000000,smax=3D0x7fffffff) */
> > > > > > >    if w1 < w6 goto end;
> > > > > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > > > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff....=
...., then the range will be
> > > > > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] a=
nd this range is not possible compared to original r1 range.
> > > > > >
> > > > > > Just rephrasing for myself...
> > > > > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffff=
FFFF
> > > > > > then lower 32-bit has to be negative.
> > > > > > and because we're doing unsigned compare w1 < w6
> > > > > > and w6 is less than 80000000
> > > > > > we can conclude that upper bits are zero.
> > > > > > right?
> > > > >
> > > > > Sorry, could you please explain this a bit more.
> > > >
> > > > Yep, also curious.
> > > >
> > > > But meanwhile, I'm intending to update bpf_for() to something like
> > > > below to avoid this code generation pattern:
> > > >
> > >
> > > Well, thank you, Gmail, for messed up formatting. See [0] for properl=
y
> > > formatted diff.
> > >
> > >   [0] https://gist.github.com/anakryiko/08a4374259469803af4ea2185296b=
0cb
> >
> > Not that simple. It needs sizeof(start)=3D=3D8 extra hack like bpf_cmp(=
).
>
> I'm forgetting the details, but I feel like sizeof() =3D=3D 4 was
> important for bpf_cmp() to compare wX registers instead of always
> comparing Rx. But in this case I think we are fine with always working
> with full 64-bit Rx registers. Or is there some correctness issue
> involved?

it's a correctness issue.
sizeof()=3D=3D8 has to go via "r" otherwise it's a silent truncation
by llvm.

> > And the same with 'end'. So it will get just as ugly.
> > Let's make the verifier smarter instead.
>
> Oh, absolutely, let's. But that doesn't solve the problem of someone
> using bpf_for() with the latest Clang on an older kernel that doesn't
> yet have this smartness, does it? Which is why I want to mitigate that
> on the bpf_for() side in addition to improvements on the verifier
> side.

There is no urgency here.
Here it's a combination of the very latest llvm trunk and -mcpu=3Dv4.
-mcpu=3Dv4 is rare. Users can continue with -mcpu=3Dv3 or released llvm.

