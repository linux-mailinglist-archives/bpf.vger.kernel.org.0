Return-Path: <bpf+bounces-34272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EF492C328
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380D41F22FBE
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7F18005C;
	Tue,  9 Jul 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvjVsnyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB417B04B
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548739; cv=none; b=NGdnhXvQgr6jTSwnlnMar6vMqtL0gbwtGDMul7cY9YgDb6np7/W7VbmxQnmS0A9gSRIWVb2cCgpmD0j99hYeqB45tXEnHgZQ5qcvEomtziva0GmaQXgFJ+CoBDJt5B+GZCRaMYKhLnOlB7M7932o/P6ej3Gnz0gD2Q77tr8rIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548739; c=relaxed/simple;
	bh=gFdXud0gx3n1LBZXaS11O38PZ56HP2jQJVKDP4A3jAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c70Umz68SxqqC/7ZuWR3guCWXufg9cZWX7uv2NaH1/Na124Qut/yTWMU5dmWftTii/Rx9u/yaSvqKH7q0BPNdJPFHPq4luoP+YYqgYqhdRBVgg8wtu2+eZgXHBflb3rNs80i/2eEp7NpsAikVyI+wisH2IHvtjPTD3T12r3jghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvjVsnyB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af81e8439so4435528b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548738; x=1721153538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEVQfXYkYUOrVMWOJ8wWrFTZaxc0I3WvK7mXLFb4ZZA=;
        b=bvjVsnyBrxu7Mcs0nuHmdi+w3lWBh8uWuyWmaihUMcwLKtuooi6H5tJHPuRLkEE4Ks
         WZtxdkmsjVFOy8M40S7WoTEp4CJVzwZn6DnzDRHH0+4I6qZH/rnakLsDjERvoy9EgkOD
         2omRkxIevt+jI6egLCFlDYjjdEs0wAXDdB0mYdi4pW9Y+7GNuwh4+W1dKpnVUhkYLo5O
         5BNCQ2gynor3mI73MfoBE9H+4+S6HqFoKORKal+hBBHFJ/wYHXyo7F2n4x4O7imHntWz
         K2LsKxFGNLInICAXKW3UtFsXtFMkIjnB/+bN1uCD6QZ3GVzTE1nD61Oc5J+Lv6TPogJs
         weqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548738; x=1721153538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEVQfXYkYUOrVMWOJ8wWrFTZaxc0I3WvK7mXLFb4ZZA=;
        b=VHr18oSR4kNySvR0MNtcfuKpW89kZRBmJ6GBH+WSMSZzg7gu9V7eYJlCILy/r2EuGY
         5LeiGrNLqnZAWTQ5Or+Z4Wt0R3YeOXvLwsfwiSQxhYPgFP3JBgPkDNtsET0SYxJtByJv
         mGgPfjx2dYNpF9f0Cuc3ge6GzfDzqqKOqPXidjkGTktBU6r70GaE/mpXhSHwLJyM32yn
         az6FEtWBrK45GXqWl0v58ardf/qUSoQuRYNEuarK9AymZ3sJyLE5HEXfhb5pwjC88bRo
         F5LpsULmuMNXkD2hTGDSxyu353f+ICP4hm3FTuBkRHgDpubtFXpB/cC6t3DFeaLZ0mAm
         yQ/g==
X-Gm-Message-State: AOJu0YxqCY8V91qVrl0AcUP+DOrJPdSKOGRIm25U5iuBzTo/BxlOsuxl
	NgitxIgCxZSESKHAuQRQ0frhcq3df7LW7CUq0NCGxu6HxEMea/jtYQKKO1joLjkbnhlLJZf//Y8
	Uy5h3y64PjVbQPggD8ur3uBr/dYE=
X-Google-Smtp-Source: AGHT+IFZtywyO1IntFUhgS7BBYrDkeXLNxFFrw18GQ5tWvSgqLXlwriuEP0yV5EU6IwGEzKKdqF7UUYDWtlCeFHWWJo=
X-Received: by 2002:a05:6a00:180e:b0:70b:cf1:8dc9 with SMTP id
 d2e1a72fcca58-70b435f6239mr4547195b3a.25.1720548737457; Tue, 09 Jul 2024
 11:12:17 -0700 (PDT)
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
 <CAADnVQK9LbN2AbHj653RE45MeZYmpzJOHFRGRjRUVqeLEGRmsA@mail.gmail.com>
 <CAEf4BzZJ-d3RB-n-URBs23saLYTn7nLFfjsymHW_ZG_N=EJ41A@mail.gmail.com> <CAADnVQK+96cCOSLfrkP5bxDcK7oLG8BFrhzoJ72P2P0D90HZjw@mail.gmail.com>
In-Reply-To: <CAADnVQK+96cCOSLfrkP5bxDcK7oLG8BFrhzoJ72P2P0D90HZjw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 11:12:05 -0700
Message-ID: <CAEf4BzZywtY+rmYpFGcAhidcwXVq_eWBkB0T_kkBaNbC0fCofw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 9, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 7:04=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 8, 2024 at 3:12=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Jul 8, 2024 at 3:11=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > > >
> > > > > > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > the 32bit_sign_ext will indicate the register r1 is from 32=
bit sign extension, so once w1 range is refined, the upper 32bit can be rec=
alculated.
> > > > > > > >
> > > > > > > > Can we avoid 32bit_sign_exit in the above? Let us say we ha=
ve
> > > > > > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,sma=
x=3D0x7fffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Duma=
x32=3D32,var_off=3D(0x0; 0x3f))
> > > > > > > >    if w1 < w6 goto pc+4
> > > > > > > > where r1 achieves is trange through other means than 32bit =
sign extension e.g.
> > > > > > > >    call bpf_get_prandom_u32;
> > > > > > > >    r1 =3D r0;
> > > > > > > >    r1 <<=3D 32;
> > > > > > > >    call bpf_get_prandom_u32;
> > > > > > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > > > > > >    r2 =3D 0xffffffff80000000 ll;
> > > > > > > >    if r1 s< r2 goto end;
> > > > > > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (sm=
in=3D0xffffffff80000000,smax=3D0x7fffffff) */
> > > > > > > >    if w1 < w6 goto end;
> > > > > > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > > > > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff..=
......, then the range will be
> > > > > > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000]=
 and this range is not possible compared to original r1 range.
> > > > > > >
> > > > > > > Just rephrasing for myself...
> > > > > > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xff=
ffFFFF
> > > > > > > then lower 32-bit has to be negative.
> > > > > > > and because we're doing unsigned compare w1 < w6
> > > > > > > and w6 is less than 80000000
> > > > > > > we can conclude that upper bits are zero.
> > > > > > > right?
> > > > > >
> > > > > > Sorry, could you please explain this a bit more.
> > > > >
> > > > > Yep, also curious.
> > > > >
> > > > > But meanwhile, I'm intending to update bpf_for() to something lik=
e
> > > > > below to avoid this code generation pattern:
> > > > >
> > > >
> > > > Well, thank you, Gmail, for messed up formatting. See [0] for prope=
rly
> > > > formatted diff.
> > > >
> > > >   [0] https://gist.github.com/anakryiko/08a4374259469803af4ea218529=
6b0cb
> > >
> > > Not that simple. It needs sizeof(start)=3D=3D8 extra hack like bpf_cm=
p().
> >
> > I'm forgetting the details, but I feel like sizeof() =3D=3D 4 was
> > important for bpf_cmp() to compare wX registers instead of always
> > comparing Rx. But in this case I think we are fine with always working
> > with full 64-bit Rx registers. Or is there some correctness issue
> > involved?
>
> it's a correctness issue.
> sizeof()=3D=3D8 has to go via "r" otherwise it's a silent truncation
> by llvm.
>
> > > And the same with 'end'. So it will get just as ugly.
> > > Let's make the verifier smarter instead.
> >
> > Oh, absolutely, let's. But that doesn't solve the problem of someone
> > using bpf_for() with the latest Clang on an older kernel that doesn't
> > yet have this smartness, does it? Which is why I want to mitigate that
> > on the bpf_for() side in addition to improvements on the verifier
> > side.
>
> There is no urgency here.
> Here it's a combination of the very latest llvm trunk and -mcpu=3Dv4.
> -mcpu=3Dv4 is rare. Users can continue with -mcpu=3Dv3 or released llvm.

Ok, fair enough, I can hold off on this for now (though eventually
people will switch and will want to run on old kernels, so the problem
doesn't really go away).


But really it's quite annoying that we don't have a proper way to just
say "give me whatever register makes sense so I can embed it in the
assembly and do something simple with it".

Yonghong, Eduard, is this something that can be figured out to let us
do straightforward pieces of embedded assembly like bpf_cmp() or this
bpf_for() hack?

