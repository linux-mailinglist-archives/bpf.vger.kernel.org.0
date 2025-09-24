Return-Path: <bpf+bounces-69514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F915B9896F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D52C1B20F1D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083327E060;
	Wed, 24 Sep 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/jncfPZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D87262E
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699839; cv=none; b=S0k+SfNOcdNGKjMHgpwiTWng2aHSyQpDzdqKxjGmdQ+yFogR9Uo+WbRwvt0I5J3eYV+vVFJ94439pV2Q6zhmVn/kbR1iwY+gdqWxv3okOISZi/CjiAGnQHvDJRMAp3xbKH9JcjzaSHYBhotdrNTMsfS0qY4pcTEd8dQD60BDOig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699839; c=relaxed/simple;
	bh=6jIVOdpjF7hLWv8K0O0CIwp4V2jVrWHCE2m5zd7rDnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z73Smr9sDjiDFmQKOylhFeITeimm+TznlwwBzy8gyhHTfieff2zu2KTfiIWhBmvW/7EgHpQZRrElOjBaVGuwdZMcn5d8FQ/Kf1T8Orgp96xZp2i+knc0utsmsKgH5HIjnQt6uXMuDhJimSt9+9/3ZMcSoNJ7+ppymERaDKGM/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/jncfPZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46db5bb2e9dso3271485e9.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758699836; x=1759304636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frTPUrkK2UtIrSktvJErOKGACg/qrYMYkNJq7wZnIzo=;
        b=g/jncfPZISyo6A3lF/NulA2pcaC658YbSzPMg6d3UqWlas204gRTZ1JeF9EQBR5vbq
         0Kd50qszJr5QHt7rE7uqvumzmgq0OD5O/ylE7X+GLSjhbbxXY38nSY4CMg+UU8JWrYBE
         IWWeMsiYVoh+ksJpmts0HgKgrv93oNu4/XTR3HlzFrCoOFY/tymtOKfTXVJJz/cHuy8o
         8x/9P4h8bzD4nUBAIFW86FuiBtnmu6jDKG0lu7oiUMt5SnqAwLLpsynnW4eD9pJXQi6H
         BFw+JEgDgjgR8FZgndpptGFrzQmhJ2sQrtBlyc1jVE3LwgYa+P8V2utRgESpHLYkyScN
         S7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699836; x=1759304636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frTPUrkK2UtIrSktvJErOKGACg/qrYMYkNJq7wZnIzo=;
        b=PMHSoRUsDQZwkIuSrH/maEuc0i0OCOUD+17Z5l/taXTz6NCYS82TAqBrKJd/C3V7PA
         1U1XWENZt85QimGE2ew566+6feFU6iWVAF28vEoezFXBWc7mjQShxAAN8e5HQC8g28yR
         GkfMtYsuy6O7c2G3y98cM66UPqAH7pqylYzaN1dqsH+uv3CUfPpWla6c3X0Yyrl4njbC
         0O20nVdGPP0QEVF5KfZERBZqLu5Ege+bDGtweg87zclQZk3wXVDJAX1GpCxdNH1Qju6a
         FVEE3c+F7nwUQ/aVKAfaU01uT1l7VdwX+FAbLBkZHYwtaV+6MGALp9KYUM+lHkIiXdVW
         EAwA==
X-Gm-Message-State: AOJu0YygpSdybCshBGOQ4ksPtbww89ugibagdH9i0YM4xzseJ81LZ9Ym
	0gyt6O1jxG9LkTIB/EyJ4eKtnVjLdZxdDlmRHHHifvBWQo3tHv+ZYHA9VvPZteg4Vlmf60+HS4J
	Gx7iOI7ADvCS6lHFYCAcVCVxmcdr+/+8=
X-Gm-Gg: ASbGncsLU+mCIxQozQ4JAk4+RtqMEnBoH/uwfr9U7FG/ZHSIVdUmHR/V+L6XtXzDHjm
	gJM8/gJXn9977Furiai6CeIRrn7zdPuDBfmz2kTXGJGdVhlDc2j6GcJCnpeWkgRRiFj4WwKss86
	vLdICadbXcpCEQVUAni+G5OBwlQwSdzbqkV+yP/PPP1CxjBHSb0tb1ouK+YnT7JN8xveHp5eo1q
	hVx9cce
X-Google-Smtp-Source: AGHT+IFeSvGFdTAg6SbA5V2QuwWWkKFqtUByAMy6HTgCTwSDkCwT/0AuWhnDCRxkb5JZaEcrx/NRUs8w/jN9j3HSApM=
X-Received: by 2002:a05:600c:c084:b0:45d:d86b:b386 with SMTP id
 5b1f17b1804b1-46e2b5959camr9036435e9.14.1758699835931; Wed, 24 Sep 2025
 00:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com> <aNM-Esr0v_95qmEa@hyeyoo>
In-Reply-To: <aNM-Esr0v_95qmEa@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 09:43:45 +0200
X-Gm-Features: AS18NWDeAMrjjtfpXXRptTmZHrkySpGxWA_vASLXbV5Wtzy4kLnoifAGbihM3rY
Message-ID: <CAADnVQ+7W9MBG5i-r1Bh+ya=xN13LTVLN+EYwzP9dhVo4cUnjw@mail.gmail.com>
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:41=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Sep 08, 2025 at 06:00:07PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > kmalloc_nolock() relies on ability of local_trylock_t to detect
> > the situation when per-cpu kmem_cache is locked.
> >
> > In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> > disables IRQs and marks s->cpu_slab->lock as acquired.
> > local_lock_is_locked(&s->cpu_slab->lock) returns true when
> > slab is in the middle of manipulating per-cpu cache
> > of that specific kmem_cache.
> >
> > kmalloc_nolock() can be called from any context and can re-enter
> > into ___slab_alloc():
> >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > or
> >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -=
> bpf ->
> >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> >
> > Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> > can be acquired without a deadlock before invoking the function.
> > If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> > retries in a different kmalloc bucket. The second attempt will
> > likely succeed, since this cpu locked different kmem_cache.
> >
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current _task_. In this case
> > re-entrance into the same kmalloc bucket is unsafe, and
> > kmalloc_nolock() tries a different bucket that is most likely is
> > not locked by the current task. Though it may be locked by a
> > different task it's safe to rt_spin_lock() and sleep on it.
> >
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
> >
> > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > and (in_nmi() or in PREEMPT_RT).
> >
> > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > spin_trylock_irqsave(&n->list_lock) to allocate,
> > while kfree_nolock() always defers to irq_work.
> >
> > Note, kfree_nolock() must be called _only_ for objects allocated
> > with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> > were skipped on allocation, hence obj =3D kmalloc(); kfree_nolock(obj);
> > will miss kmemleak/kfence book keeping and will cause false positives.
> > large_kmalloc is not supported by either kmalloc_nolock()
> > or kfree_nolock().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> On the up-to-date version [1] of this patch,
> I tried my best to find flaws in the code, but came up empty this time.

Here's hoping :)
Much appreciate all the feedback and reviews during
this long journey (v1 was back in April).

