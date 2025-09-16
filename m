Return-Path: <bpf+bounces-68459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887DB58A4B
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 02:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB7F3B2FDD
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177BF1C3BE0;
	Tue, 16 Sep 2025 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g91yfmEp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAE2BB13
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984194; cv=none; b=r/7jq6E+MGSVmJoZsxjywCHNJOi5fm9P5XAmUFWRnrFsijMSSAEXH4IEXsTTMVG3vs7J1VsXsSrYJAgNpG0WRgbMovILBIzd6Vb4tgoia2z88GqRFcwy/uz0hR5jGCSfjFH8ELEWuRtjV2MnmEszq49y6INde8dlzgRvS/QAl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984194; c=relaxed/simple;
	bh=uy2ayFE3ycWuFL7E+puWaDWrwYAwKC1dT5lOFwTxuLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE07+7vO0wnfUDEJZXYFf1dz/yMz7B0FwHNZff0kUPi1PDjmWvzo34ce5MoQOkOcauoRr4dffifHgdIrmEYBhA5PNh+DMx60LvZ16F9MxmAPMbLplwIPoJ8N477y2WTZ+tlYi9p3ttU/5LSY/kGwY/bc5uqTo7OSXRQHdWhlyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g91yfmEp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso1099309f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757984191; x=1758588991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiLgYf6D3jEC57AgzquBhXF5i1lApomfHdREXpHN454=;
        b=g91yfmEpBsEbzy93mL0bIIy07qRkESYOEF4bp/nI3R8zzg6X4RCID1XkEsdCHgpNIz
         LkqfPzltMs0sVmqJh+dgSXG9STY4zbepiKda/wOa2LBgIzGZ5K+zDimBJwnyPOIokabQ
         jMtCD1dTIOIqUd5CR4eLk5R8WeX+uWO/xUG73FagGW+HlK3AFF1t0Mmds2iuB+98k/Zi
         AqAps1nwhu9WWC6xsHV+siippcp7M2hEMz8zkVIV4xb+R6YCmM/lnffWGSR2SSEMlTv/
         Zkpv5o9gDidw4ADaMGXClmiwn8+Il+9Mdogdsar648Aiqz6MWFxZ+3ARtg5yQtT3Dvxq
         u2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984191; x=1758588991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiLgYf6D3jEC57AgzquBhXF5i1lApomfHdREXpHN454=;
        b=L9sCMJBaCln1thjGkc2pVNFLTIZ7p4WY9u4c0IJbgs9VBxgRZLy5IGzSDSouaPk+4K
         bE08KAL1dEDdhCov499ZkaHGAeq3UXwHxFp3Epoi5GrG2EsPnYHs+Z3joZRvS7xmXLdz
         w7/xcBArqxxYkWzvG+vPlFcfqDj70hKuAV61LiPOglxQLHtBEf6ndEPGn6puUF88Zxdq
         BYjlbxKzW8/XeT5/AT8IGHkrKgm5whn+VQkpBT4RXCZAuvmmCnsk6feEhSmEeq7y6Lc1
         7jPd0ngcvPoAkp6Ve3bX4DfZqilK8JCTpccZ2QHzMxnyTjzKqN40VeTwp+UPpk0oT2Ub
         oUtw==
X-Forwarded-Encrypted: i=1; AJvYcCUfCfn7N/amq7ghbJdGvIBBCBFyjb0nl5Y6yho5FXRF0841pJAQ4AQ15bDM0b/oXtGVdI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQX7SpqlcELUEjXY0Tl0uZCDgdzoW9AW0Uy9F/9KmEok27bzg
	ppaPd4nmEzbzj9b9yxxauMpY9TwGHwKmfYEvNlRrd5HlxFUtYWk81YoPrRMRmjg+339DxfVrJzM
	BpCRnG+BjuVA/moqypIr7DXiLhAxMpZ11bcQI
X-Gm-Gg: ASbGncsVOFFUYst1Z3XnGixMHUfbgsnaQUQWDBJRX7x8s+XJpH/qXWmIubcL6ykcCZ5
	qa6+Fy1ZaWdEuKLkr+ENhjMr45DbcSkCT3gyfncV7JNSWsCweSUxK3Y+PX649dFJXIvjYXst7pP
	mjVpDfH8toUoa/zk0vMOgvICJuFYy+y4LpfdWsf4L3l2peF3oitZWez2zZY3+QiQptIOR6L+Os0
	d0IjTvY3goU65mELKKpY/0ucec2/vlzURAL
X-Google-Smtp-Source: AGHT+IGFlGJIoK5ZUsaOwb586HCPIbfPVyUQh1WbZv2OmQrk5XYYtC5YYb0VRb1ejdHUEPi98odbmMRH1yhd4sqIA7o=
X-Received: by 2002:a5d:5d0a:0:b0:3e5:50:e070 with SMTP id ffacd0b85a97d-3e765a19cbbmr11529191f8f.50.1757984190560;
 Mon, 15 Sep 2025 17:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com> <aMgMIQVYnAq2weuE@hyeyoo>
 <451c6823-40fa-4ef1-91d7-effb1ca43c90@suse.cz>
In-Reply-To: <451c6823-40fa-4ef1-91d7-effb1ca43c90@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 17:56:18 -0700
X-Gm-Features: AS18NWDoijexVV3I4ZuOqf6kTb_heztvckNsKdsfc8goyLACjGgfAmPHGSP44to
Message-ID: <CAADnVQKC=BA73ifNnyiE2c8ExtzS4LjR00--m5Xe8pqPLSGJfA@mail.gmail.com>
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/15/25 14:52, Harry Yoo wrote:
> > On Mon, Sep 08, 2025 at 06:00:07PM -0700, Alexei Starovoitov wrote:
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> kmalloc_nolock() relies on ability of local_trylock_t to detect
> >> the situation when per-cpu kmem_cache is locked.
> >>
> >> In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> >> disables IRQs and marks s->cpu_slab->lock as acquired.
> >> local_lock_is_locked(&s->cpu_slab->lock) returns true when
> >> slab is in the middle of manipulating per-cpu cache
> >> of that specific kmem_cache.
> >>
> >> kmalloc_nolock() can be called from any context and can re-enter
> >> into ___slab_alloc():
> >>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> >> or
> >>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe =
-> bpf ->
> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> >>
> >> Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> >> can be acquired without a deadlock before invoking the function.
> >> If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> >> retries in a different kmalloc bucket. The second attempt will
> >> likely succeed, since this cpu locked different kmem_cache.
> >>
> >> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> >> per-cpu rt_spin_lock is locked by current _task_. In this case
> >> re-entrance into the same kmalloc bucket is unsafe, and
> >> kmalloc_nolock() tries a different bucket that is most likely is
> >> not locked by the current task. Though it may be locked by a
> >> different task it's safe to rt_spin_lock() and sleep on it.
> >>
> >> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> >> immediately if called from hard irq or NMI in PREEMPT_RT.
> >>
> >> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> >> and (in_nmi() or in PREEMPT_RT).
> >>
> >> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> >> spin_trylock_irqsave(&n->list_lock) to allocate,
> >> while kfree_nolock() always defers to irq_work.
> >>
> >> Note, kfree_nolock() must be called _only_ for objects allocated
> >> with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> >> were skipped on allocation, hence obj =3D kmalloc(); kfree_nolock(obj)=
;
> >> will miss kmemleak/kfence book keeping and will cause false positives.
> >> large_kmalloc is not supported by either kmalloc_nolock()
> >> or kfree_nolock().
> >>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> ---
> >>  include/linux/kasan.h      |  13 +-
> >>  include/linux/memcontrol.h |   2 +
> >>  include/linux/slab.h       |   4 +
> >>  mm/Kconfig                 |   1 +
> >>  mm/kasan/common.c          |   5 +-
> >>  mm/slab.h                  |   6 +
> >>  mm/slab_common.c           |   3 +
> >>  mm/slub.c                  | 473 +++++++++++++++++++++++++++++++++---=
-
> >>  8 files changed, 453 insertions(+), 54 deletions(-)
> >> @@ -3704,6 +3746,44 @@ static void deactivate_slab(struct kmem_cache *=
s, struct slab *slab,
> >>      }
> >>  }
> >>
> >> +/*
> >> + * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_=
cache_cpu::lock
> >> + * can be acquired without a deadlock before invoking the function.
> >> + *
> >> + * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() =
is
> >> + * using local_lock_is_locked() properly before calling local_lock_cp=
u_slab(),
> >> + * and kmalloc() is not used in an unsupported context.
> >> + *
> >> + * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_loc=
k_irqsave().
> >> + * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
> >> + * lockdep_assert() will catch a bug in case:
> >> + * #1
> >> + * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_n=
olock()
> >> + * or
> >> + * #2
> >> + * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bp=
f -> kmalloc_nolock()
> >> + *
> >> + * On PREEMPT_RT an invocation is not possible from IRQ-off or preemp=
t
> >> + * disabled context. The lock will always be acquired and if needed i=
t
> >> + * block and sleep until the lock is available.
> >> + * #1 is possible in !PREEMPT_RT only.
> >> + * #2 is possible in both with a twist that irqsave is replaced with =
rt_spinlock:
> >> + * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> >> + *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(km=
em_cache_B)
> >> + *
> >> + * local_lock_is_locked() prevents the case kmem_cache_A =3D=3D kmem_=
cache_B
> >> + */
> >> +#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
> >> +#define local_lock_cpu_slab(s, flags)       \
> >> +    local_lock_irqsave(&(s)->cpu_slab->lock, flags)
> >> +#else
> >> +#define local_lock_cpu_slab(s, flags)       \
> >> +    lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags)=
)
> >> +#endif
> >> +
> >> +#define local_unlock_cpu_slab(s, flags)     \
> >> +    local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
> >
> > nit: Do we still need this trick with patch "slab: Make slub local_(try=
)lock
> > more precise for LOCKDEP"?
>
> I think we only make it more precise on PREEMPT_RT because on !PREEMPT_RT=
 we
> can avoid it using this trick. It's probably better for lockdep's overhea=
d
> to avoid the class-per-cache when we can.

yes.

> Perhaps we can even improve by having a special class only for kmalloc
> caches? With kmalloc_nolock we shouldn't ever recurse from one non-kmallo=
c
> cache to another non-kmalloc cache?

Probably correct.
The current algorithm of kmalloc_nolock() (pick a different bucket)
works only for kmalloc caches, so other caches won't see _nolock()
version any time soon...
but caches are mergeable, so other kmem_cache_create()-d cache
might get merged with kmalloc ? Still shouldn't be an issue.

I guess we can fine tune "bool finegrain_lockdep" in that patch
to make it false for non-kmalloc caches, but I don't know how to do it.
Some flag struct kmem_cache ? I can do a follow up.

> >>
> >> +/**
> >> + * kmalloc_nolock - Allocate an object of given size from any context=
.
> >> + * @size: size to allocate
> >> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> >> + * @node: node number of the target node.
> >> + *
> >> + * Return: pointer to the new object or NULL in case of error.
> >> + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> >> + * There is no reason to call it again and expect !NULL.
> >> + */
> >> +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> >> +{
> >> +    gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> >> +    struct kmem_cache *s;
> >> +    bool can_retry =3D true;
> >> +    void *ret =3D ERR_PTR(-EBUSY);
> >> +
> >> +    VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> >> +
> >> +    if (unlikely(!size))
> >> +            return ZERO_SIZE_PTR;
> >> +
> >> +    if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> >> +            /* kmalloc_nolock() in PREEMPT_RT is not supported from i=
rq */
> >> +            return NULL;
> >> +retry:
> >> +    if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> >> +            return NULL;
> >> +    s =3D kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> >> +
> >> +    if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> >> +            /*
> >> +             * kmalloc_nolock() is not supported on architectures tha=
t
> >> +             * don't implement cmpxchg16b, but debug caches don't use
> >> +             * per-cpu slab and per-cpu partial slabs. They rely on
> >> +             * kmem_cache_node->list_lock, so kmalloc_nolock() can
> >> +             * attempt to allocate from debug caches by
> >> +             * spin_trylock_irqsave(&n->list_lock, ...)
> >> +             */
> >> +            return NULL;
> >> +
> >> +    /*
> >> +     * Do not call slab_alloc_node(), since trylock mode isn't
> >> +     * compatible with slab_pre_alloc_hook/should_failslab and
> >> +     * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
> >> +     * and slab_post_alloc_hook() directly.
> >> +     *
> >> +     * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> >> +     * in irq saved region. It assumes that the same cpu will not
> >> +     * __update_cpu_freelist_fast() into the same (freelist,tid) pair=
.
> >> +     * Therefore use in_nmi() to check whether particular bucket is i=
n
> >> +     * irq protected section.
> >> +     *
> >> +     * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means=
 that
> >> +     * this cpu was interrupted somewhere inside ___slab_alloc() afte=
r
> >> +     * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
> >> +     * In this case fast path with __update_cpu_freelist_fast() is no=
t safe.
> >> +     */
> >> +#ifndef CONFIG_SLUB_TINY
> >> +    if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> >> +#endif
> >
> > On !PREEMPT_RT, how does the kernel know that it should not use
> > the lockless fastpath in kmalloc_nolock() in the following path:
> >
> > kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> =
kmalloc_nolock()
> >
> > For the same reason as in NMIs (as slowpath doesn't expect that).
>
> Hmm... seems a good point, unless I'm missing something.

Good point indeed.
tracepoints are not an issue, since there are no tracepoints
in the middle of freelist operations,
but kprobe in the middle of ___slab_alloc() is indeed problematic.

>
> > Maybe check if interrupts are disabled instead of in_nmi()?

but calling if (irqs_disabled()) isn't fast (list time I benchmarked it)
and unnecessarily restrictive.

I think it's better to add 'notrace' to ___slab_alloc
or I can denylist that function on bpf side to disallow attaching.

>
> Why not just check for local_lock_is_locked(&s->cpu_slab->lock) then and
> just remove the "!in_nmi() ||" part? There shouldn't be false positives?

That wouldn't be correct. Remember you asked why
access &s->cpu_slab->lock is stable? in_nmi() guarantees that
the task won't migrate.
Adding slub_put_cpu_ptr() wrap around local_lock_is_locked() _and_
subsequent call to __slab_alloc_node() will fix it,
but it's ugly.
Potentially can do
if (!allow_sping && local_lock_is_locked())
right before calling __update_cpu_freelist_fast()
but it's even uglier, since it will affect the fast path for everyone.

So I prefer to leave this bit as-is.
I'll add filtering of ___slab_alloc() on bpf side.
We already have a precedent: btf_id_deny set.
That would be one line patch that I can do in bpf tree.
Good to disallow poking into ___slab_alloc() anyway.

