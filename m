Return-Path: <bpf+bounces-78431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517EBD0C999
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F85302A3AA
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7F1400C;
	Sat, 10 Jan 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY1rNu/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D648125B2
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003439; cv=none; b=N3fV32AuX1jpGumCXlKkQGGfpfGnscOhW7tTARGZ5TyJXmriGBlkVVQzfUaI6wAhu6We1pfRig71pCbQeKgIQ8aXeO9/RozNpmJJjnJxU4QObjmyj6eURhM93fGFGWl3aXrJNsVdIGmEg43rmyUVslxqotVOYvHWzJ17sjzW/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003439; c=relaxed/simple;
	bh=VCyd8prpFs+r6ufiNAemZDlsMn2SE8KB4nswE+0O5RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKqbtXeNeJF2W6TkSTcVGtL4AHDfxeftctMHLPrEqG7OXrUx66wnwDOBzOdb2cY1UY3nGeJeYY2a8Jq0aKYilx1HRuUuUUsgf4yDIwvdqW4SF5C/qHhUrVgDGn5tttk9rxM2t80Tt/IkjUAvBwG17CIFfiEckDovkL/dHQcK2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY1rNu/9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso2050913a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 16:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768003437; x=1768608237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq/YatfMXveI/0yaFb5ZeuT2QVcJWckXRunzJtggiIQ=;
        b=QY1rNu/9W7qg59IY6aqQa8ziYPdj5R/KPY2BVBCaOmaELsZRhYO4826CA/FRrlO7Up
         5Ig4x1wLau1N8C+X70jTFxfVWJTM1yRsb3DMV8/LAbIFkgtoL02nuX9cQZp6CGcAhIn4
         bm1++fyFZNhQdM3n1EBd+PaX4PbylfQ2iHPTqkp8rwUP8XVbM5cibp0i/v2TthvFpClz
         1LA1iM5Yv5nrLkysD+lYlscY2wVV7AYG9aO2njovhSsJM3KN66lH+iusKbikyhn3YWBN
         GlQv+loFmzNP1OVpSbLImqsf40nQ4/sKyLoWDdmjhB5MXVqTBSA9Xw/tuzKzT0QzZZ4j
         ujQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003437; x=1768608237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cq/YatfMXveI/0yaFb5ZeuT2QVcJWckXRunzJtggiIQ=;
        b=MHGu4I9TwrTHRKbL1f5jCoJHVUy2sTIbf7YZ1ElgyczDwqWoQmWzyuzg25S5p8Bxws
         BYGsJZk+CYnXeux+OPxgFROFYu2T6RzRPTsWkHtced4ED6Lo7K8AjoXnFYGRieLnxGrQ
         4zEAx+5Lk0RlwXZcyYSJiVFLGr8kDNPm8B/YZYp6GQTg9ADPeQhwxbYDNQ/U8eMIdclt
         UaNpUVtXHw3wA/zVMZpFGU0NqSe3Xwzf3nmogVta4yfFJULUt+dTEPuSsPTFmyHY6KbO
         pCXVG0kRcs3XLvB8O8YI0l1Ft3zB2w7quuoca7BOaZK1HUwXgskNvhspfV3lyxHVT+DN
         zsrw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxvxWMcWlpBOrfwKkVuUsCwze3y3qYcXug7c+s9ZfrpTGAb3EuNBceHnpxnDzwbKuQEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZEZrCe6P3wohANQsnaEgGkFOuliLFKgeZ9ewCRYbUgq764OhT
	kQ/+Zgoe5NyntVvY8AdfmbmWRWgaRz1Cd444Kf4ZfGSWPDqGnoFeyNOi5bQzd6hmlZVZaFu+WpW
	tFySX7uXvAQLGe3olHma/pB6dhftv7BuexQ==
X-Gm-Gg: AY/fxX6X02qzGlFxnHD2xycKKsm0QAd2q+GyjiSxLIUV8+22aigM7PyagRd95jgO6vV
	AuVB4dEbYcew1TWKdPXXGkuO0jtLMB2rTxDouW1TD5KEzMN0oOnQBwBN7bE1reOMZ0KA7qVj9yS
	VYr5LGi7t6oJDFy0v6CvseqLaNjpvlJDFDHjyWZZfW/nkLt8oyEWh0jBEJ7yAAyMIz0IlAH710W
	AC2/cizHAZqB10xBGdPy86DmBPz0jlU6+/BLRxtcD83+NZVZY9RfPinHx/0TW21nOUHqbVx0mpr
	Z36d3KOY
X-Google-Smtp-Source: AGHT+IEOYBAPbHV856hYyzmgG8mfhCDRHn4Hf1+wZVv04LpFmcCJP0J9s1TEuN/g31hWHCBJPblN4ti+Ogn2DszHgqM=
X-Received: by 2002:a17:90b:568d:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-34f68c01825mr10878754a91.11.1768003437329; Fri, 09 Jan 2026
 16:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com> <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
 <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com> <CAEf4BzYY0s6yF8JACTENANzJXd6abZctiB1iP+jYARq_xPDm0A@mail.gmail.com>
 <c5269858-7285-4e44-a5ef-72e69e9c00a2@gmail.com> <CAEf4BzZNGnufqerj=FY8K+oj3hpZ_xwzvOG5kPZN3UATACU_Dg@mail.gmail.com>
 <CAADnVQLwDqcKSRHKy+F-mtOn85_QiBvwe+-=Zj2W6r-pbu=LPQ@mail.gmail.com>
In-Reply-To: <CAADnVQLwDqcKSRHKy+F-mtOn85_QiBvwe+-=Zj2W6r-pbu=LPQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 16:03:45 -0800
X-Gm-Features: AQt7F2rzA0JnTO6YnrGdsmxsHzjW4uyp4N4lhOgRPAZxoYtZCeapSas2sSPRGLw
Message-ID: <CAEf4BzZJADRyETO=rQeOBkvzHTanZr3Fj5xg2uTzJ8avJ39-Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:51=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 10:47=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 9, 2026 at 10:22=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > On 1/9/26 01:18, Andrii Nakryiko wrote:
> > > > On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Mykyta Yatsenko
> > > > <mykyta.yatsenko5@gmail.com> wrote:
> > > >> On 1/7/26 18:30, Kumar Kartikeya Dwivedi wrote:
> > > >>> On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gm=
ail.com> wrote:
> > > >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> > > >>>>
> > > >>>> Introduce mpmc_cell, a lock-free cell primitive designed to supp=
ort
> > > >>>> concurrent writes to struct in NMI context (only one writer adva=
nces),
> > > >>>> allowing readers to consume consistent snapshot.
> > > >>>>
> > > >>>> Implementation details:
> > > >>>>    Double buffering allows writers run concurrently with readers=
 (read
> > > >>>>    from one cell, write to another)
> > > >>>>
> > > >>>>    The implementation uses a sequence-number-based protocol to e=
nable
> > > >>>>    exclusive writes.
> > > >>>>     * Bit 0 of seq indicates an active writer
> > > >>>>     * Bits 1+ form a generation counter
> > > >>>>     * (seq & 2) >> 1 selects the read cell, write cell is opposi=
te
> > > >>>>     * Writers atomically set bit 0, write to the inactive cell, =
then
> > > >>>>       increment seq to publish
> > > >>>>     * Readers snapshot seq, read from the active cell, then vali=
date
> > > >>>>       that seq hasn't changed
> > > >>>>
> > > >>>> mpmc_cell expects users to pre-allocate double buffers.
> > > >>>>
> > > >>>> Key properties:
> > > >>>>    * Writers never block (fail if lost the race to another write=
r)
> > > >>>>    * Readers never block writers (double buffering), but may req=
uire
> > > >>>>    retries if write updates the snapshot concurrently.
> > > >>>>
> > > >>>> This will be used by BPF timer and workqueue helpers to defer NM=
I-unsafe
> > > >>>> operations (like hrtimer_start()) to irq_work effectively allowi=
ng BPF
> > > >>>> programs to initiate timers and workqueues from NMI context.
> > > >>>>
> > > >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > >>>> ---
> > > >>> We already have a dual-versioned concurrency control primitive in=
 the
> > > >>> kernel (seqcount_latch_t). I would just use that instead of
> > > >>> reinventing it here. I don't see much of a difference except writ=
er
> > > >>> serialization, which can be done on top of it. If it was already
> > > >>> considered and discarded for some reason, please add that reason =
to
> > > >>> the commit message.
> > > >> yes, multiple concurrent  writers support would is the main differ=
ence
> > > >> between seqcount_latch_t and my implementation. I'll switch to
> > > >> seqcount_latch_t and external synchronization for writers.
> > > > One advantage of custom primitive is that we don't need a second
> > > > atomic counter for writers. Here we combine the reader latch counte=
r
> > > > (it's just scaled 2x for custom implementation) and "writer is acti=
ve"
> > > > bit (even/odd counter).
> > > >
> > > > With potentially millions of timer activations per second for some
> > > > extreme cases, would performance be enough reason to have custom
> > > > "seqlock latch"? (I'm not sure myself, trying to get opinions)
> > > >
> > > Actually seqcount_latch_t variant may be faster (correct me if I'm wr=
ong),
> > > because mpmc_cell requires 2 lock prefixed instructions to enter the =
write
> > > critical section and seqcount_latch_t just 1.
> > >
> > > mpmc_cell:
> > >
> > > if (1&atomic_fetch_or_acquire(1, &ctl->seq)) // first lock prefixed i=
nsn
> > > return;
> > > ...
> > >        atomic_fetch_add_release(1, &ctl->seq);     // second lock
> > > prefixed insn
> > >
> > > seqcount_latch_t based:
> > >
> > >      if (atomic_cmpxchg(&ctl->lock, 0, 1))        // first lock prefi=
xed
> > > insn
> > >          return;
> > > write_seqcount_latch_begin(&ctl->seq);       // inc with barriers
> > >      ...
> > >      write_seqcount_latch(&ctl->seq);            // inc with barriers
> > >      atomic_set(&ctl->lock, 0);            // plain mov on x86_64
> > >
> > > Does it look right?
> >
> > So I think you are overpivoting on atomic vs non-atomic differences
> > here: when uncontended, atomic is almost as fast as non-atomic
> > (difference is irrelevant). But under contention, those four writes
> > due to separate latch is four cache line bounces (potentially) between
> > competing CPUs, while with custom sequence logic it's just two.
> >
> > I'm not dead set on one approach or the other, but I don't think that
> > latch adds that match value. But if Kumar or others insist on latch, I
> > don't mind, in the end both will work.
>
> I think it's worth writing a micro benchmark for it.
> Intuitively I feel seqcount_latch_t approach will be faster
> and it has all the kcsan annotation around it,
> while this new primitive still needs work to teach kcsan
> about it.

Let's just stick to latch, no need to have more unnecessary work. As I
mentioned to Mykyta offline, latch's advantage (regardless of
performance implications) is that someone already thought and
validated all the memory barriers, so let's take advantage of that and
concentrate on other important aspects here.

