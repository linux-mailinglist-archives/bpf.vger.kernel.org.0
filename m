Return-Path: <bpf+bounces-73573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1EFC340FA
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 07:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 989B54E8216
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853427FD5D;
	Wed,  5 Nov 2025 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4kVA9Cc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F3139579
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324250; cv=none; b=k2k4ws+dHFa/fFc71twJewjyePAesYg3KR96Nw/ms0jDZ1veaMXe5ufZyi+lRlugn3bXmTZW9wnWkxLnjfFbFNr1Z30vLua6/X1EA5+DOJWVugiijj/HX2GaDObLuarc75cwE/96sq8suH5huqkvd30NKPXws1MPoy5tdM28YA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324250; c=relaxed/simple;
	bh=Z26x65XH0JvMFVrGzQRGfCEMlF+dnmzNZBws3MYMQZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fn5gWoimiG3IdTOgGoy/2X4lbGU0nnxGEAJGAChA1B6uXkjlYQExEHAkXb/mPNWzT0vj7Tj22wwLlZTvP2dPPoXq1ELWaUNCAw1C8rFzprcgzZCwEkwludDJqyfRT/fhvFWEqAnYL+RzxWJhuMXHrS55nDizQsek1kxSnD3PWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4kVA9Cc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7272012d30so18451666b.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 22:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762324246; x=1762929046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNamFYeKrgkfYpGqDEC4ISP3aOvnwP62I1mojV63yjQ=;
        b=B4kVA9CckEGnSgUUxhOjVPQ4DSw7FVFLT0fg6vkFjYvtV+I49jJAOCQ9s/7mdAv4oC
         vosS8eAf2/A0K0lghXBrVGQPPGsZ/zga0zkHCM0zt/7gNK/pUjbQZ33YwJS3UtU5afZf
         5/nYDxFKGdYPAkHHDZQl3MOyZ9L2n6wkTN2SJyq+7ly3C6J0rB3jzBOTGUJa3U8hPowb
         eLt9FbEhhT9wqK6sjjDZ81J3RJUlXA/J8xlgCYxNmPm+Z/hAbktg68OiTM3EeXJwlg+u
         O5Gu6k+xqm0d+8acomlaE2cgw0zssWMwNLbQ4i3Wtd797X2IMtvnxZKa65y8uecux/aW
         O80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324246; x=1762929046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNamFYeKrgkfYpGqDEC4ISP3aOvnwP62I1mojV63yjQ=;
        b=npVa1eecjWPERD4jWu1FqYHooqwkKP2mhiE39dBhEe6sNPFyGtKVeNEQWjMB+6U/Dh
         B7jwx4yKfXrfeRs1Sk6dT2K7lKAq4IGHf7IcwFGt2o+CcLqYcYPXglvQAK714mav2q2x
         DozmCJ9XFMtf1hDE02lYe9Tjg1xpOY6r5LzlScW/xahAmi4kSpKwrc7P39WEVkxOGATF
         7ukryDPgDE8i8bPcqo+Ktr+5rP3Zd1AS56ClND5HhHajmUamLwPdMOoJaOz3qVR2W4Kd
         GRrR90mWdstUPUkHedS/wQnpB10JVtbwLw0jfnfgQAwCzV/0M32wpnQIAf/NwkHhMvlS
         NU8A==
X-Forwarded-Encrypted: i=1; AJvYcCVulXOxKtrbxp/jq8mFYcn/X9Ao9IGw3exZ9jMiL5n+ZeyK2OFBo9yrft2BU2e203p6noo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PUv3im48gxXVqOyFOypjTZOSPtzx70623eNHSKxQcz7SreFY
	hGrbgBgnWpRVYvqPoXR4UQyM2ey/BRc1HiMOvxalNUGQN9/DLdeFhkfBTlox7UZNJz5Tj/xwxI8
	q9nKfyfVAMZnlaRuI0iBfwNmdBWc3Rjw=
X-Gm-Gg: ASbGncsdwW5iOvRXlWwzxhVYIQVp6wPH4opFiKJ3oyM4/Huvc0fGMcX4ClKTEJOrYLP
	tqfvN3cSMSXv4kmbzRoPA9koU4bpyT5TYxI1sBxGtaUuuneJPq392VuoH0axM6JPTwZRHEFyw2b
	+YaTEs4o0ZE+hDXAvEyCH5dSzgP1y1c6g5YTlg/RJE2tWupUJx4WnH1Z0ArZzHEv20KKIf2qSNE
	N/xXlsKbpncQ/9b9TH5NyzWqhl7e4huC2AB2jgZZez5Ik/kPfTsQX/BJK1O6g==
X-Google-Smtp-Source: AGHT+IFqGAYKg1ejlrjyHHac/R5Epzr/8vxUNR2hpLrsHc9aurh/urydqFAsyXfJZctx/1QWABChs5p7yxOyy5Zv9Sw=
X-Received: by 2002:a17:906:f59b:b0:b6d:519f:2389 with SMTP id
 a640c23a62f3a-b72655b73f5mr169921266b.52.1762324246104; Tue, 04 Nov 2025
 22:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104164948.33408-1-puranjay@kernel.org> <CAADnVQJabNCvyT_b2JcW6YdtwCaSs8YVPcdk1FacLJjpz=KFqQ@mail.gmail.com>
 <CAADnVQJtq7LeV2afFKVOd5VP8Mo12fZPhSF3-Y1U0UgMbDtafg@mail.gmail.com>
In-Reply-To: <CAADnVQJtq7LeV2afFKVOd5VP8Mo12fZPhSF3-Y1U0UgMbDtafg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 5 Nov 2025 07:30:34 +0100
X-Gm-Features: AWmQ_bnd7t_t1vVkOEIxd0EuaWEvhbwNDZiP7ubnxZu4N6XW7zZkIdMGstBAXcM
Message-ID: <CANk7y0hHtEojP=Vt3rpGCt2OPctLcBR8HyYVrr4ZOdvzj-MDKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Optimize recursion detection for arm64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 8:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> > >
> > > BPF programs detect recursion by a per-cpu active flag in struct
> > > bpf_prog. This flag is set/unset in the trampoline using atomic
> > > operations to prevent inter-context recursion.
> > >
> > > Some arm64 platforms have slow per-CPU atomic operations, for example=
,
> > > the Neoverse V2.  This commit therefore changes the recursion detecti=
on
> > > mechanism to allow four levels of recursion (normal -> softirq -> har=
dirq
> > > -> NMI). With allowing limited recursion, we can now stop using atomi=
c
> > > operations. This approach is similar to get_recursion_context() in pe=
rf.
> > >
> > > Change active to a per-cpu array of four u8 values, one for each cont=
ext
> > > and use non-atomic increment/decrement on them.
> > >
> > > This improves the performance on ARM64 (64-CPU Neoverse-N1):
> > >
> > >  +----------------+-------------------+-------------------+---------+
> > >  |    Benchmark   |     Base run      |   Patched run     |  =CE=94 (=
%)  |
> > >  +----------------+-------------------+-------------------+---------+
> > >  | fentry         |  3.694 =C2=B1 0.003M/s |  3.828 =C2=B1 0.007M/s |=
 +3.63%  |
> > >  | fexit          |  1.389 =C2=B1 0.006M/s |  1.406 =C2=B1 0.003M/s |=
 +1.22%  |
> > >  | fmodret        |  1.366 =C2=B1 0.011M/s |  1.398 =C2=B1 0.002M/s |=
 +2.34%  |
> > >  | rawtp          |  3.453 =C2=B1 0.026M/s |  3.714 =C2=B1 0.003M/s |=
 +7.56%  |
> > >  | tp             |  2.596 =C2=B1 0.005M/s |  2.699 =C2=B1 0.006M/s |=
 +3.97%  |
> > >  +----------------+-------------------+-------------------+---------+
> >
> > The gain is nice, but absolute numbers look very low.
> > I see fentry doing 52M on the debug kernel with kasan inside VM.
> >
> > The patch itself looks good to me, but I realized that we cannot
> > use this approach for progs with a private stack,
> > since they require a strict one user per cpu.
> >
> > Also tracing progs might have conceptually similar restriction.
> > A prog could use per-cpu map to store some data.
> > If prog is attached to some function that may be called from
> > task and irq context the irq execution will write over per-cpu data
> > and when it returns the same prog in task context will see garbage.
> > I'm afraid get_recursion_context() approach won't work. Sorry for
> > not-thought-through suggestion.
>
> Actually the get_recursion_context() approach can be salvaged.
> Instead of:
> +       active =3D this_cpu_ptr(prog->active);
> +       if (unlikely(++active[rctx] !=3D 1)) {
>
> how about
> active =3D this_cpu_ptr(prog->active);
> ++active[rctx];
> if (unlikely(*(u32 *)active !=3D 1 << rctx * 8)) {

Yes, I think this should work after changing it to be endianness safe.

This should be the fastest as it doesn't use any atomic operations.

> that should preserve single prog per cpu rule,
> and hopefully have better performance than this_cpu_inc_return,
> xchg, and this_cpu_xchg.
>
> Also noticed that we use this_cpu_dec() which is probably just as slow.
> So the first experiment to do is:
> - this_cpu_dec(*(prog->active));
> + this_cpu_dec_return(*(prog->active));

Okay, I will try this first.

>
> Also as a pre-patch please wrap inc/dec into two helpers
> and use them everywhere.
> Will simplify all these experiments.

So, I will go ahead and test all the different setups on arm64 and see
which is the best.

Thanks,
Puranjay

