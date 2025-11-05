Return-Path: <bpf+bounces-73556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064AEC33A96
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B430A4645DF
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514BE27470;
	Wed,  5 Nov 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esvMdcWF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4717BA1
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306224; cv=none; b=g8D27gCtO3N+o0SeIHWpvAnRbppvvPf9fP2ReYp+NnQu7pZeDDHD0og+w2JN5wGA2qi/J9OJ/zOQNw5xdgIsuinOBFuIsXd8RIK2KjDnLXZaoTVFC5KKYPV9OpXCBeTxQukOCDF2NvYE/SwBzwfhhTNmPeLbRTKzADYOQ+RV1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306224; c=relaxed/simple;
	bh=+xTRQcfyXFHRB34pXgfjkMG/EJuVA288cQ/JW8hfN9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkIW21gP71BQHnmrkhDCs5aoe/kJPMJ1p1EnDr0i2gpyN06aYglibkl7uyPeDAKcIPxVNvQIjMDwM6wCzXxxgLDOKaiWMzQLNQK18ZvjaVVnJDw5VpqPrErhcjCdxD8rN+dFf1PaSl9nP2Xi6j7VYgSAbQRsEe/QgsvmmCocFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esvMdcWF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47117f92e32so49959555e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 17:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762306221; x=1762911021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXtylUDE+n3W+8CO0qfnAqML65Vl1fNO5GTlg6s0nvo=;
        b=esvMdcWF60Mh7yModN5PxwgewPf/+WM3M1rNSP7tpHtPkZokkquwkC+5jpHDGWLc9W
         zU5hn0kOpOTJiTuTn5ipl8P39HSCB/wmPdxcdRgbD7c5FoOEe3LakIbdA37mhF2qwuFc
         fXvhqZiIR9UZUHKnDJ/yK63wxcEmuy9WKmhyriH4Sa7hrUDBa3PhxRk6ONYPypoLlhgS
         OrCNp1zNya/SG9bDWfwL0qVQDUQC2XXI66w28+Rj1t5ZjRl0SgNmeXXIChkBofdCYXJL
         scMYP/+cMtWppsHZmqZrtBIC55GK6ClbnFrcCMmAmO4rU+Cy0DmwdnOuFn48bd5S5WZX
         7hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762306221; x=1762911021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXtylUDE+n3W+8CO0qfnAqML65Vl1fNO5GTlg6s0nvo=;
        b=ZVh3vPDatEka7AOBpkA3oraQKnETg8qsWQrtO9T3wndVy/E+xenC0X40pOSXVx1hzr
         y55vQ5cDrdOi3QTpwb/73+QTgRCbfX3/WwY9ADZKN4/qbMLPUVDcXz4dD0xq8aparLhC
         6+U+HFZgFzcCjCXRYdp/yT3hcYhcS+SVQwszfDxvFnC3ii6YqqEKFXZFgWhdiQpCrEay
         ZdhAivOt5tnXbSC1fY5pxxlX1EJiW+asOG+WkA8NPAnuouJ1snnG3FAcx3y/izTbnw/o
         lLyrSOJGK8mWkFKS3bs4HcYYMov8qKew52mSg47/QX94FyNiLmIhChq1P75GFg+vIpOu
         HUmA==
X-Gm-Message-State: AOJu0YwOYGnpU4DAtgIf9mpPa5b8AcNirMyTCxAndJymevt0odQjaYYF
	W5v66LEQmZQmkfp9/M0T8U6vdQpTYRDYybs0kd/AX+xqUR3DGqVhoGiQ8YIAyCdGNbqVJMdG27D
	h4KTFVAHxljiECxqy1tKZaBz0m2LkLdw=
X-Gm-Gg: ASbGncu4hnPc2ZVWpnHTSjMT6XPxdCFKykNvkUFA+9TOy0fNUC0AdQy4D1BCVyY+J4b
	SDhvRDw80+rkFdKHtUoFU8kWWv0tjwKERYJEf7wPYijP7o9Fpaq6ZuOoX2MNJ0Cq3RE8k2wrXcL
	vSJAmRpelinSSm2V4wLcSXfZdR+KThpgrhCR8P7RYyVu0s+GKQb5FBGi876Mssx8nAwN1Z0+eJH
	8tJz//aN8uFMhVYYa9zmrGX8S+guMj+lsppf4SPcynZD0/hnPjDGQ+CER6kPQ3a3G0+e85X0fqd
	Q1TIybmiJX6BLI34gA==
X-Google-Smtp-Source: AGHT+IGfa5NbatsVs5Q8hZs6k9w2nlCmpYTTpSxMbDnBNpl2dqUlOxc6/H+G2hIymH1812d7RYDhfXsPtgTRdg2Z5hw=
X-Received: by 2002:a05:600c:1e28:b0:471:13dd:baef with SMTP id
 5b1f17b1804b1-4775ce12d09mr7744805e9.26.1762306221337; Tue, 04 Nov 2025
 17:30:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104164948.33408-1-puranjay@kernel.org> <CAADnVQJabNCvyT_b2JcW6YdtwCaSs8YVPcdk1FacLJjpz=KFqQ@mail.gmail.com>
In-Reply-To: <CAADnVQJabNCvyT_b2JcW6YdtwCaSs8YVPcdk1FacLJjpz=KFqQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 17:30:09 -0800
X-Gm-Features: AWmQ_bmxr-jdjeYtz6U7mMZugcNdQ-ptnzpjosixQDci0VW-g8FZHNja4ITky5s
Message-ID: <CAADnVQJtq7LeV2afFKVOd5VP8Mo12fZPhSF3-Y1U0UgMbDtafg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Optimize recursion detection for arm64
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 8:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > BPF programs detect recursion by a per-cpu active flag in struct
> > bpf_prog. This flag is set/unset in the trampoline using atomic
> > operations to prevent inter-context recursion.
> >
> > Some arm64 platforms have slow per-CPU atomic operations, for example,
> > the Neoverse V2.  This commit therefore changes the recursion detection
> > mechanism to allow four levels of recursion (normal -> softirq -> hardi=
rq
> > -> NMI). With allowing limited recursion, we can now stop using atomic
> > operations. This approach is similar to get_recursion_context() in perf=
.
> >
> > Change active to a per-cpu array of four u8 values, one for each contex=
t
> > and use non-atomic increment/decrement on them.
> >
> > This improves the performance on ARM64 (64-CPU Neoverse-N1):
> >
> >  +----------------+-------------------+-------------------+---------+
> >  |    Benchmark   |     Base run      |   Patched run     |  =CE=94 (%)=
  |
> >  +----------------+-------------------+-------------------+---------+
> >  | fentry         |  3.694 =C2=B1 0.003M/s |  3.828 =C2=B1 0.007M/s | +=
3.63%  |
> >  | fexit          |  1.389 =C2=B1 0.006M/s |  1.406 =C2=B1 0.003M/s | +=
1.22%  |
> >  | fmodret        |  1.366 =C2=B1 0.011M/s |  1.398 =C2=B1 0.002M/s | +=
2.34%  |
> >  | rawtp          |  3.453 =C2=B1 0.026M/s |  3.714 =C2=B1 0.003M/s | +=
7.56%  |
> >  | tp             |  2.596 =C2=B1 0.005M/s |  2.699 =C2=B1 0.006M/s | +=
3.97%  |
> >  +----------------+-------------------+-------------------+---------+
>
> The gain is nice, but absolute numbers look very low.
> I see fentry doing 52M on the debug kernel with kasan inside VM.
>
> The patch itself looks good to me, but I realized that we cannot
> use this approach for progs with a private stack,
> since they require a strict one user per cpu.
>
> Also tracing progs might have conceptually similar restriction.
> A prog could use per-cpu map to store some data.
> If prog is attached to some function that may be called from
> task and irq context the irq execution will write over per-cpu data
> and when it returns the same prog in task context will see garbage.
> I'm afraid get_recursion_context() approach won't work. Sorry for
> not-thought-through suggestion.

Actually the get_recursion_context() approach can be salvaged.
Instead of:
+       active =3D this_cpu_ptr(prog->active);
+       if (unlikely(++active[rctx] !=3D 1)) {

how about
active =3D this_cpu_ptr(prog->active);
++active[rctx];
if (unlikely(*(u32 *)active !=3D 1 << rctx * 8)) {

that should preserve single prog per cpu rule,
and hopefully have better performance than this_cpu_inc_return,
xchg, and this_cpu_xchg.

Also noticed that we use this_cpu_dec() which is probably just as slow.
So the first experiment to do is:
- this_cpu_dec(*(prog->active));
+ this_cpu_dec_return(*(prog->active));


Also as a pre-patch please wrap inc/dec into two helpers
and use them everywhere.
Will simplify all these experiments.

