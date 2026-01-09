Return-Path: <bpf+bounces-78350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F3D0BEA7
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A064030188C5
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF12D9EC8;
	Fri,  9 Jan 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg/pngey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29F2D9784
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984436; cv=none; b=Ax3KGqM9QVOQj0MYqVBXDkPkmUyV3topvp7voGaIjnIfD8bmVeZ5fTgXtT8zWpZvU3O12gD/nXdo0Jce7Wg/EUJpOaRs79Y2tTUjUXfJBA2X6pO8OmV50B4hVKPVhpJrDhvL5fB/fQ/Z8zMhPHK76ibJU9LTWZLVLpK6vWLYtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984436; c=relaxed/simple;
	bh=3Ih4MI9kS4MldSyVi0fRb2lJPE6EtpcZFZjCTjuOKnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWMCmKoa2eaWUADQpMBWb/OrAR85o8iTgZhU0uDQpZkdtaWnOZO9NlKDcRUEWw4PxdgnIihzm5FvNvd/Q/WafiHv7JOTKcN2sDpap64jLn8WaK0LBWWfYR99n+y5fiPlFe/MQ7tzYBq4q9pnsg7207yO7JvvZjPYqs38eD3z4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg/pngey; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0c09bb78cso25936045ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984433; x=1768589233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGBvDDpxTKsSKi/PBBmzaVZCoI4skoibmdHf0mi5fA0=;
        b=Hg/pngeyTA7GrLdmE7PBe4ZmQbpbM/erhU3hsCRQetBnlXqo+IESQzLbFbaeYxGORZ
         4QnMnt3Xet7y+PtjkgueUKQKUj2N0nU+dwAV5pCluBbnnUeGXjH/aSFqRYoefcsr70Lw
         jog2ezLQZ1J20QCddbGAbHnmw8xQDJnZyKyA7F2ZwAs1sUKsS6bVQ1Y3haas06Uxltn9
         aCLVaxXBx8iPj9XZQCBb+irk+s4P0UwjykPxL9lTgPdQWJPB439HRoCobxVXJTlrcPI9
         lOyzzcp4+PlIc68RJ/5hJfPjUKQHj2rs439LI5sfqcspNwuXkOPwUBfhU15bxPCT4QV7
         IFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984433; x=1768589233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGBvDDpxTKsSKi/PBBmzaVZCoI4skoibmdHf0mi5fA0=;
        b=sj6Zy2x01wvJE8tlgnFgSXxzVssgpBtJUnZEyFpFzfLH73Pc/+oycXENfQQJfBNH0Z
         1jSuDA8biRjKCHET98pFYOErn2iDVSPv0Jif/CYvBsWO2+XYgU5GBtrg8Hwz0eLIrAC8
         ep285Jc2EPF5SWK+R00fl16cGK52/lXhvEgQRELEfXnuThOzcXddu7AfJwMFVatKAv8H
         UYkBbKphj/ovMXKeP7WJcIiRT6YZRgN5ccPkiza1LEPUDyaQHv8Qf6wlhMoIILmbuXTF
         w6poG/KbgVAq8R0MWfKOvbO80k/o+LjUSy19p1M9RelAsOqTXneO4L555aU9IWjgGTj5
         QVWg==
X-Forwarded-Encrypted: i=1; AJvYcCWUGEYf3cPUJmcq+P2EmrTqQruf6K3IwNOvegEBhoKJVBI1QWBwmKGBm93eKG5p0AD5v8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMBYWU0avzLshdIDyq8LqPo1wgJJK395ybwNLdWEHZEZuzBAN
	wW+SLTLvkLz6ksVAi4Yd0RkddcecDMcD7IiHmKva6HLQhqntQDcxqorfDrRknIfUzvA6YPp1vcW
	/FFxih+FKoxoiWT0szNUq74tuAgnwccM=
X-Gm-Gg: AY/fxX5NyhFrC2/+hrdRwuxP3IcfMfJxbPCYX7wMPxYEAQK6EJFBF5c5yfzh5hIwG1b
	CubRWkNwFJw5jv/WQVwUkwZfJXzoP1IWXQJPHjzw1MJkx2arRa1aWugWGasNJsIvEtRSp/BlAGi
	3PvtbDMpaFHp3BlPhf/V5HW/BdCPCZUgS6WeOpLKtCV8l58PFOaCmTijo7fzJQTXMJvcorVNS+V
	nHmoLamlK6067ldyom7FAGbD+nljNvtbVTa61B+rYVhXBiBr8FCCpIlpyLbMbcvzENSnkVvtbKf
	rKFin/Dd
X-Google-Smtp-Source: AGHT+IE1oMv04+pjB2sGdJhPF1mMtjjU2SHeSXJ7nafoDxLPhSJBVXd3Z2q0yG3h3JVYq6/trfj1vb/oYVlW/m/mtAM=
X-Received: by 2002:a17:902:d50e:b0:29f:cb81:8be2 with SMTP id
 d9443c01a7336-2a3e39e58dcmr129420785ad.20.1767984433218; Fri, 09 Jan 2026
 10:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com> <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
 <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com> <CAEf4BzYY0s6yF8JACTENANzJXd6abZctiB1iP+jYARq_xPDm0A@mail.gmail.com>
 <c5269858-7285-4e44-a5ef-72e69e9c00a2@gmail.com>
In-Reply-To: <c5269858-7285-4e44-a5ef-72e69e9c00a2@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 10:47:00 -0800
X-Gm-Features: AQt7F2qopkyMd3ofhXN8fUaVyfJ7WOobwJ3alPE5OCXmr7MxA_ag9j-h0HoXd_4
Message-ID: <CAEf4BzZNGnufqerj=FY8K+oj3hpZ_xwzvOG5kPZN3UATACU_Dg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:22=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/9/26 01:18, Andrii Nakryiko wrote:
> > On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> On 1/7/26 18:30, Kumar Kartikeya Dwivedi wrote:
> >>> On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.=
com> wrote:
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> Introduce mpmc_cell, a lock-free cell primitive designed to support
> >>>> concurrent writes to struct in NMI context (only one writer advances=
),
> >>>> allowing readers to consume consistent snapshot.
> >>>>
> >>>> Implementation details:
> >>>>    Double buffering allows writers run concurrently with readers (re=
ad
> >>>>    from one cell, write to another)
> >>>>
> >>>>    The implementation uses a sequence-number-based protocol to enabl=
e
> >>>>    exclusive writes.
> >>>>     * Bit 0 of seq indicates an active writer
> >>>>     * Bits 1+ form a generation counter
> >>>>     * (seq & 2) >> 1 selects the read cell, write cell is opposite
> >>>>     * Writers atomically set bit 0, write to the inactive cell, then
> >>>>       increment seq to publish
> >>>>     * Readers snapshot seq, read from the active cell, then validate
> >>>>       that seq hasn't changed
> >>>>
> >>>> mpmc_cell expects users to pre-allocate double buffers.
> >>>>
> >>>> Key properties:
> >>>>    * Writers never block (fail if lost the race to another writer)
> >>>>    * Readers never block writers (double buffering), but may require
> >>>>    retries if write updates the snapshot concurrently.
> >>>>
> >>>> This will be used by BPF timer and workqueue helpers to defer NMI-un=
safe
> >>>> operations (like hrtimer_start()) to irq_work effectively allowing B=
PF
> >>>> programs to initiate timers and workqueues from NMI context.
> >>>>
> >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>>> ---
> >>> We already have a dual-versioned concurrency control primitive in the
> >>> kernel (seqcount_latch_t). I would just use that instead of
> >>> reinventing it here. I don't see much of a difference except writer
> >>> serialization, which can be done on top of it. If it was already
> >>> considered and discarded for some reason, please add that reason to
> >>> the commit message.
> >> yes, multiple concurrent  writers support would is the main difference
> >> between seqcount_latch_t and my implementation. I'll switch to
> >> seqcount_latch_t and external synchronization for writers.
> > One advantage of custom primitive is that we don't need a second
> > atomic counter for writers. Here we combine the reader latch counter
> > (it's just scaled 2x for custom implementation) and "writer is active"
> > bit (even/odd counter).
> >
> > With potentially millions of timer activations per second for some
> > extreme cases, would performance be enough reason to have custom
> > "seqlock latch"? (I'm not sure myself, trying to get opinions)
> >
> Actually seqcount_latch_t variant may be faster (correct me if I'm wrong)=
,
> because mpmc_cell requires 2 lock prefixed instructions to enter the writ=
e
> critical section and seqcount_latch_t just 1.
>
> mpmc_cell:
>
> if (1&atomic_fetch_or_acquire(1, &ctl->seq)) // first lock prefixed insn
> return;
> ...
>        atomic_fetch_add_release(1, &ctl->seq);     // second lock
> prefixed insn
>
> seqcount_latch_t based:
>
>      if (atomic_cmpxchg(&ctl->lock, 0, 1))        // first lock prefixed
> insn
>          return;
> write_seqcount_latch_begin(&ctl->seq);       // inc with barriers
>      ...
>      write_seqcount_latch(&ctl->seq);            // inc with barriers
>      atomic_set(&ctl->lock, 0);            // plain mov on x86_64
>
> Does it look right?

So I think you are overpivoting on atomic vs non-atomic differences
here: when uncontended, atomic is almost as fast as non-atomic
(difference is irrelevant). But under contention, those four writes
due to separate latch is four cache line bounces (potentially) between
competing CPUs, while with custom sequence logic it's just two.

I'm not dead set on one approach or the other, but I don't think that
latch adds that match value. But if Kumar or others insist on latch, I
don't mind, in the end both will work.

> >>>>    [...]
> >>>>
>

