Return-Path: <bpf+bounces-43182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789AC9B0D5A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69A1B232D7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC83206505;
	Fri, 25 Oct 2024 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSdKPwj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7921534E9
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881114; cv=none; b=hjgOj3MXQDxSGBicgycKs00EHDdzNOSmRYm1wVHjDTuDhTqu5PfFpH8t509sZ0mPYHbnvwSzraeoKgd77kTf/LSTzdc42d5KvLmTiBz4HXvWumv2L/fyaeiuZzdbxsl/heEO6EkZN+HcTxE/I6NKUtdlRRDlDCADkbV9/t9gZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881114; c=relaxed/simple;
	bh=+Ja9TtQRVpVdbwIndUX98pcJYjHqwpE4/V1Bu1wKNu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8+t/UZZ+neohIqe5UZ+LTNV1/23o4p4vMnnLujtGwc5F1bT00ypIjgKf3fl1HIEQ+DgT2VWoXW2eP0qO4Jg5BGoN5Vku0FTOA3I3YQ+9w4QVLs69jaJOoCeEeK3xNtyLYNrSZME/Eh90Cg3iJSsZbxMgMLTwwXQcfg27XidA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSdKPwj3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5130832aso1686361b3a.0
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729881111; x=1730485911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckwGbgsT7DMtS1pduR3Qv5jTqG+iusFYJJnKzN3idqI=;
        b=LSdKPwj3TbtO8Pimji3OdKtJbtG+ze0HBzecJbQ2dTdAYYPXlPKoIP8qvLwUQeKVQJ
         HHIP4f/dyPCYM+sFrehoeDzFFR2WA9Jmy/edCzFwRotZMekRJQBmief8Nt0e2uU4uRya
         DB4ZDd9mkkj5/xhx106GongWtD4knZqq6BF37UzCA7Tbcq6tRuKD6GoacW3JU6vwJ3Sb
         I+7tzTfpPWcWlb7d0sspcYdglxjhE14h7DSi94f53I7tDSb59UqRm008yTqdA+DLCoEV
         d9AjGFiNsLFtFfBf/vXOixFrjlPEjKr7fk9U7AoRY5m1TW+Y5Wl3L1qhWjEE92rkLvbX
         WrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881111; x=1730485911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckwGbgsT7DMtS1pduR3Qv5jTqG+iusFYJJnKzN3idqI=;
        b=xSZCYq1ay2oTuD5pDnU7ECAZ+dRP7MDlPvHbnpXmB1t1i7q2A0LIvXeVJP5gQus0pb
         AU6xa6ET/T8nHuBKaBcGBJu1ZvrCwVh7PStSUzDNOJTaHwSU7Vo1IEwc7XjtsS/O2Zlg
         1qmkgoa8vc6dke8daoGK9vW9YP6d8DL3Ok1YGMK39iQPIkMGaesuDQ//jIqz/Yx1qYjw
         VenepoA3+h9ITtaqociIFGV7oTKV44RswLobmEZof5MqseKwvro/ldvaVVBCvi4+D2KU
         oRFCGH+EFkveAXlfyOrC27zwD2z3AvMCeD0YPDfD7IIAywhsO6D9GT+dKFM+zd5LUhDO
         zm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvy//xIO6rLCM/HZVB9GJGrEAWT8pQc5MVKz+oALeltsJ+DJG3QTZGg2xjysMP9/4bnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRsCE9jq595EkXSFwRanWYieZErHYkcsccXUEc/OTw+1UQuRC
	I4TBSZGc7acBHQ/ci/wii3PsBagOYQwBV5cMVMbhb1gY239nLh8eUbzAd4t77gYXb3MKZGGMbhP
	CIh+yeKTZHcqHpMNIhb51h8MSdPE=
X-Google-Smtp-Source: AGHT+IGDE/bgP1zeIvO7wQsfzxpc2oep23FfJOyp6EnGFsyklS4If857je0SxaddWOcohuFomG3LOtk76H31mdxUxu8=
X-Received: by 2002:a05:6a00:4fc4:b0:71e:b1dc:f255 with SMTP id
 d2e1a72fcca58-72062f83a3cmr631561b3a.9.1729881111138; Fri, 25 Oct 2024
 11:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205113.762622-1-vadfed@meta.com> <CAEf4BzZa8QCxFO0YPk3LQE2A_kp2yawN-h24V+RoiH7q8BLVVw@mail.gmail.com>
 <d5222de7-020c-4bff-b314-86a232d42065@linux.dev>
In-Reply-To: <d5222de7-020c-4bff-b314-86a232d42065@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Oct 2024 11:31:38 -0700
Message-ID: <CAEf4BzaBNNCYaf9a4oHsB2AzYyc6JCWXpHx6jk22Btv=UAgX4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 7:01=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 25/10/2024 00:17, Andrii Nakryiko wrote:
> > On Thu, Oct 24, 2024 at 1:51=E2=80=AFPM Vadim Fedorenko <vadfed@meta.co=
m> wrote:
> >>
> >> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT convert=
s
> >> it into rdtsc ordered call. Other architectures will get JIT
> >> implementation too if supported. The fallback is to
> >> __arch_get_hw_counter().
> >>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >> v1 -> v2:
> >> * Fix incorrect function return value type to u64
> >> * Introduce bpf_jit_inlines_kfunc_call() and use it in
> >>    mark_fastcall_pattern_for_call() to avoid clobbering in case of
> >>          running programs with no JIT (Eduard)
> >> * Avoid rewriting instruction and check function pointer directly
> >>    in JIT (Alexei)
> >> * Change includes to fix compile issues on non x86 architectures
> >> ---
> >>   arch/x86/net/bpf_jit_comp.c   | 30 ++++++++++++++++++++++++++++++
> >>   arch/x86/net/bpf_jit_comp32.c | 16 ++++++++++++++++
> >>   include/linux/filter.h        |  1 +
> >>   kernel/bpf/core.c             | 11 +++++++++++
> >>   kernel/bpf/helpers.c          |  7 +++++++
> >>   kernel/bpf/verifier.c         |  4 +++-
> >>   6 files changed, 68 insertions(+), 1 deletion(-)
> >>
> >
> > [...]
> >
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 5c3fdb29c1b1..f7bf3debbcc4 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -23,6 +23,7 @@
> >>   #include <linux/btf_ids.h>
> >>   #include <linux/bpf_mem_alloc.h>
> >>   #include <linux/kasan.h>
> >> +#include <vdso/datapage.h>
> >>
> >>   #include "../../lib/kstrtox.h"
> >>
> >> @@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *ds=
t, u32 dst__sz, const void __user
> >>          return ret + 1;
> >>   }
> >>
> >> +__bpf_kfunc u64 bpf_get_hw_counter(void)
> >
> > Hm... so the main idea behind this helper is to measure latency (i.e.,
> > time), right? So, first of all, the name itself doesn't make it clear
> > that this is **time stamp** counter, so maybe let's mention
> > "timestamp" somehow?
>
> Well, it's time stamp counter only on x86. Other architectures use cycle
> or time counter naming. We might think of changing it to
> bpf_get_hw_cycle_counter() if it gives more information.

bpf_get_cpu_cycles_counter()? or just bpf_get_cpu_cycles()?

>
> > But then also, if I understand correctly, it will return the number of
> > cycles, right?
>
> Yes, it will return the amount of cycles passed from the last CPU reset.
>
> > And users would need to somehow convert that to
> > nanoseconds to make it useful.
>
> That's questionable. If you think about comparing the performance of the
> same kernel function or bpf program on machines with the same
> architecture but different generation or slightly different base
> frequency. It's much more meaningful to compare CPU cycles instead of
> nanoseconds. And with current CPU base frequencies cycles will be more
> precise than nanoseconds.

I'm thinking not about narrow micro-benchmarking use cases, but
generic tracing and observability cases where in addition to
everything else, users almost always want to capture the duration of
whatever they are tracing. In human-relatable (and comparable across
various hosts) time units, not in cycles.

So in practice we'll have to show users how to convert this into
nanoseconds anyways. So let's at least have a test demonstrating how
to do it? (and an extra kfunc might be a solution, yep)

>
> > Is it trivial to do that from the BPF side?
>
> Unfortunately, it is not. The program has to have an access to the cycle
> counter configuration/specification to convert cycles to any time value.
>
>  > If not, can we specify this helper to return nanoseconds instead> of
> cycles, maybe?
>
> If we change the specification of the helper to return nanoseconds,
> there will be no actual difference between this helper and
> bpf_ktime_get_ns() which ends up in read_tsc() if tsc is setup as
> system clock source.
> At the same time I agree that it might be useful to have an option to
> convert cycles into nanoseconds. I can introduce another helper to do
> the actual conversion of cycles into nanoseconds using the same
> mechanics as in timekeeping or vDSO implementation of gettimeofday().
> The usecase I see here is that the program can save start point in
> cycles, then execute the function to check the latency, get the
> cycles right after function ends and then use another kfunc to convert
> cycles spent into nanoseconds. There will be no need to have this
> additional kfunc inlined because it won't be on hot-path. WDYT?

Sounds good to me. My main ask and the goal here is to *eventually*
have time units, because that's the only thing that can be compared
across hosts.

>
> > It would be great if selftest demonstratef the intended use case of
> > measuring some kernel function latency (or BPF helper latency, doesn't
> > matter much).
>
> I can implement a use case described above if it's OK.

Great, thanks.

>
> >
> > [...]
>

