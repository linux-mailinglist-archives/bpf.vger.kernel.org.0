Return-Path: <bpf+bounces-63548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C582B08322
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1067F3B6059
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A51E25E1;
	Thu, 17 Jul 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2OkXfOF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60521B4244
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720652; cv=none; b=f+3d9zdW0yoxmJEShrS3nhihW08cZpqkCTq5iXXF5JGCbAC5IKgseBM1pbZmB1ApUUl35DRdovaRNQcCpDdGF/EUimEItBk5xUu0UFrCfdDXKbmxwtVCdbqp39KaoDBfwfMeik32RZoelsNimqlFmCceRfei0CkZLxpjyAJq8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720652; c=relaxed/simple;
	bh=9rIo/RdJduyTdiU4HQjP0nzHHueoX/Myf/4T7dnIhao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAehL8VSds9yhtV1doLgzRLAZ6icaG6exMEmfb4RQD4u+isJF9SgOp5OO3Z2Gu6ys+P2IFwH7X19BH5a9v94Q++Lnr5ZUGUbCqphflrEbGYdwSWJMbj6ZOw1AyHw0yKBaZL2COfitegmZDcR9XC1WT7YHTGAqDxAbIpDZ8qGcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2OkXfOF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45555e3317aso2441865e9.3
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752720649; x=1753325449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZZjqBPfc9UtG7UUAMJwc8EPjG/Uu9Ens89MSZaC6TA=;
        b=X2OkXfOF4XxWvEIbwMyckLik6LQEbzhX5rl/NRzIreWwKLfM1pdP17GDnr++C3CRZw
         Ie/3fMhaFGnOuXNaUpekzmOp15+w1/yS5cVRXv83UBHMhpIn7xuXVsquDkXLSfghPPRQ
         CH6ZKY1Aq3yEUOJPm3x8f5PU2ePqM/O8PXpfLV0LnygC0qTK2h9RJEnoV/Y+cFx+6hyp
         dfYJMNCSvomYN1Z+0JMqLI+0BxBghqPIdL+unVokJrdBHTuLA35SWMtl6ZZxgF5WhdFV
         DgOfD9OgP1SD1cbay28iIo1m8vAC1sFnzaiqh40+0zY+AQHLMUlbApdeLYuW65T/w2Yb
         zdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752720649; x=1753325449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZZjqBPfc9UtG7UUAMJwc8EPjG/Uu9Ens89MSZaC6TA=;
        b=kxck4h8Zgu+BCiIICxnnyKhpZtvKOaTYuJedkeuhQUNGH7h05rLBQsQobeulAFmVQ3
         QhnA4SijxMCEdq8HD7nmcT6ETp8NGvw0c0zQFJ4BaX+E9QK4InoVhKNsZ93l3xJbQzCw
         hfBzO3SVr/PnAuHHIjehgCLkpmn1krApWd5Fmorh2zT1LGCZLOgUoFWfQ5ZYzshgFqMj
         KkioQhhWaqABNYjk8sE/QzXCAT1KeOPkcR7ofQUDj0e1Oc5G02x0lA8dPk826BvNamt2
         MwBqD3neurVRYi0+FDOzKGbXsvZ82D0t4AuK9sYujOx4taYZUXNPa5UFGkR0InddEx6D
         LxpQ==
X-Gm-Message-State: AOJu0Yz1oAdffZtSWONb2UehmgQJ0h4WETnUkrHeonnyfwNq22aYnncD
	EPgoRRo24u3vTssXFIFOPkFOVzjdXGqlLtvEO4Tp3kXofUAQC8EgBjzjDv8NyOYb7uzssNx+Ivg
	3Vu12eRNEc022XqbTHXM9ICWWhZ61RwY=
X-Gm-Gg: ASbGncsJxIloX75bDtU1EcWk10WJxeNF9BF2bZgsruKt5BSXmVNloTXXLjAWeEIC7H8
	XPyOMIXlFikUOpp3AgFbESKK78oPCYU24bML7jyB3NpbXvJa3cI4saOhPpJVl3yRefeVawy+SF2
	67qEIrQAT+MSoX05fU1fygqA5OeY3s7NMPqpcqztIibIpNAQrUzScBgn0WL6b72QDDAQKLQFHRt
	OtkxPn2mrS9++siFSnsAdkTOvfivCPMNbiTqHnDc7PG7xE=
X-Google-Smtp-Source: AGHT+IFwf79lhlrKdmgN/tnNI+U/m0kQE/g0MlTcZs62ALz3xisFAj6QVSDtRUNGn/K/PbhY4HVto/er9P5BK8K/Oi8=
X-Received: by 2002:a05:600c:a10e:b0:456:1204:e7e2 with SMTP id
 5b1f17b1804b1-4562e815fc8mr38932485e9.12.1752720648400; Wed, 16 Jul 2025
 19:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com> <a28390e4-23cf-4615-93e3-611b046e1973@suse.cz>
In-Reply-To: <a28390e4-23cf-4615-93e3-611b046e1973@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 19:50:37 -0700
X-Gm-Features: Ac12FXzgV1SLwvjx9o7CXhDloQ1VQYsZ8SKmaAcjc6AKedVK6c9K7IQZPXqGS2g
Message-ID: <CAADnVQJBGWdWkGOGSMSN2quSXfaKYdnFpAqfAYYEbpJgchyNbg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 04:29, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > kmalloc_nolock() relies on ability of local_lock to detect the situatio=
n
>
>                                         ^ local_trylock_t perhaps?
>
> > when it's locked.
> > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
>
> It can be also true when you call it from the bpf hook, no?

Correct. Technically one can disasm ___slab_alloc(),
find some instruction after pushfq;cli,
add kprobe there, attach bpf prog to kprobe, and call kmalloc_nolock
(eventually, when bpf infra switches to kmalloc_nolock).
I wouldn't call it malicious, but if somebody does that
they are looking for trouble. Even syzbot doesn't do such things.

> > In that case retry the operation in a different kmalloc bucket.
> > The second attempt will likely succeed, since this cpu locked
> > different kmem_cache_cpu.
> >
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current task. In this case re-entranc=
e
> > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > a different bucket that is most likely is not locked by the current
> > task. Though it may be locked by a different task it's safe to
> > rt_spin_lock() on it.
> >
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
> >
> > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > and in_nmi() or in PREEMPT_RT.
> >
> > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> > always defers to irq_work.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Haven't seen an obvious bug now but will ponder it some more. Meanwhile s=
ome
> nits and maybe one bit more serious concern.
>
> > +static inline void local_lock_cpu_slab(struct kmem_cache *s, unsigned =
long *flags)
> > +{
> > +     /*
> > +      * ___slab_alloc()'s caller is supposed to check if kmem_cache::k=
mem_cache_cpu::lock
> > +      * can be acquired without a deadlock before invoking the functio=
n.
> > +      *
> > +      * On PREEMPT_RT an invocation is not possible from IRQ-off or pr=
eempt
> > +      * disabled context. The lock will always be acquired and if need=
ed it
> > +      * block and sleep until the lock is available.
> > +      *
> > +      * On !PREEMPT_RT allocations from any context but NMI are safe. =
The lock
> > +      * is always acquired with disabled interrupts meaning it is alwa=
ys
> > +      * possible to it.
> > +      * In NMI context it is needed to check if the lock is acquired. =
If it is not,
>
> This also could mention the bpf instrumentation context?

Ok.

> > +      * it is safe to acquire it. The trylock semantic is used to tell=
 lockdep
> > +      * that we don't spin. The BUG_ON() will not trigger if it is saf=
e to acquire
> > +      * the lock.
> > +      *
> > +      */
> > +     if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +             BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags)=
);
>
> Linus might still spot the BUG_ON() and complain, lockdep_assert() would =
be
> safer maybe :)
> Or just use local_lock_irqsave() with !CONFIG_LOCKDEP as well.

Fair enough. Let's save one branch in the critical path.

> Nit: maybe could be a #define to avoid the unusual need for "&flags" inst=
ead
> of "flags" when calling.

When "bool allow_spin" was there in Sebastian's version it definitely
looked cleaner as a proper function,
but now, if (!IS_ENABLED(CONFIG_PREEMPT_RT)) can be
#ifdef CONFIG_PREEMPT_RT
and the comment will look normal (without ugly backslashes)
So yeah. I'll convert it to macro.

> > +/**
> > + * kmalloc_nolock - Allocate an object of given size from any context.
> > + * @size: size to allocate
> > + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> > + * @node: node number of the target node.
> > + *
> > + * Return: pointer to the new object or NULL in case of error.
> > + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> > + * There is no reason to call it again and expect !NULL.
> > + */
> > +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > +{
> > +     gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> > +     struct kmem_cache *s;
> > +     bool can_retry =3D true;
> > +     void *ret =3D ERR_PTR(-EBUSY);
> > +
> > +     VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> > +
> > +     if (unlikely(!size))
> > +             return ZERO_SIZE_PTR;
> > +
> > +     if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
>
> Nit: maybe just due explicit PREEMPT_RT checks when the code isn't about
> lockless fastpaths,

True. I wasn't sure what's better.
do_slab_free() does
if (USE_LOCKLESS_FAST_PATH())
but it's really meant to be PREEMPT_RT,
since 'else' part doesn't make sense otherwise.
It's doing local_lock() without _irqsave() which is
inconsistent with everything else and looks broken
when one doesn't have knowledge of local_lock_internal.h
This patch fixes this part:
-               local_lock(&s->cpu_slab->lock);
+               local_lock_cpu_slab(s, &flags);


Here, in this hunk, if (IS_ENABLED(CONFIG_PREEMPT_RT) might
look better indeed.

> > +             /* kmalloc_nolock() in PREEMPT_RT is not supported from i=
rq */
> > +             return NULL;
> > +retry:
> > +     if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > +             return NULL;
> > +     s =3D kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> > +
> > +     if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> > +             /*
> > +              * kmalloc_nolock() is not supported on architectures tha=
t
> > +              * don't implement cmpxchg16b, but debug caches don't use
> > +              * per-cpu slab and per-cpu partial slabs. They rely on
> > +              * kmem_cache_node->list_lock, so kmalloc_nolock() can
> > +              * attempt to allocate from debug caches by
> > +              * spin_trylock_irqsave(&n->list_lock, ...)
> > +              */
> > +             return NULL;
> > +
> > +     /*
> > +      * Do not call slab_alloc_node(), since trylock mode isn't
> > +      * compatible with slab_pre_alloc_hook/should_failslab and
> > +      * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
> > +      * and slab_post_alloc_hook() directly.
> > +      *
> > +      * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> > +      * in irq saved region. It assumes that the same cpu will not
> > +      * __update_cpu_freelist_fast() into the same (freelist,tid) pair=
.
> > +      * Therefore use in_nmi() to check whether particular bucket is i=
n
> > +      * irq protected section.
> > +      *
> > +      * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means=
 that
> > +      * this cpu was interrupted somewhere inside ___slab_alloc() afte=
r
> > +      * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
> > +      * In this case fast path with __update_cpu_freelist_fast() is no=
t safe.
> > +      */
> > +#ifndef CONFIG_SLUB_TINY
> > +     if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> > +#endif
> > +             ret =3D __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, s=
ize);
>
> Nit: use IS_DEFINED(CONFIG_SLUB_TINY) to make this look better?

ok.

> > +static void defer_deactivate_slab(struct slab *slab)
> > +{
>
> Nit: for more consistency this could thake the freelist argument and assi=
gn
> it here, and not in the caller.

ok.

> > +     struct defer_free *df =3D this_cpu_ptr(&defer_free_objects);
> > +
> > +     if (llist_add(&slab->llnode, &df->slabs))
> > +             irq_work_queue(&df->work);
> > +}
> > +
> > +void defer_free_barrier(void)
> > +{
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu)
> > +             irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->wor=
k);
> > +}
> > +
> >  #ifndef CONFIG_SLUB_TINY
> >  /*
> >   * Fastpath with forced inlining to produce a kfree and kmem_cache_fre=
e that
> > @@ -4575,6 +4857,8 @@ static __always_inline void do_slab_free(struct k=
mem_cache *s,
> >                               struct slab *slab, void *head, void *tail=
,
> >                               int cnt, unsigned long addr)
> >  {
> > +     /* cnt =3D=3D 0 signals that it's called from kfree_nolock() */
> > +     bool allow_spin =3D cnt;
> >       struct kmem_cache_cpu *c;
> >       unsigned long tid;
> >       void **freelist;
> > @@ -4593,10 +4877,30 @@ static __always_inline void do_slab_free(struct=
 kmem_cache *s,
> >       barrier();
> >
> >       if (unlikely(slab !=3D c->slab)) {
> > -             __slab_free(s, slab, head, tail, cnt, addr);
> > +             if (unlikely(!allow_spin)) {
> > +                     /*
> > +                      * __slab_free() can locklessly cmpxchg16 into a =
slab,
> > +                      * but then it might need to take spin_lock or lo=
cal_lock
> > +                      * in put_cpu_partial() for further processing.
> > +                      * Avoid the complexity and simply add to a defer=
red list.
> > +                      */
> > +                     defer_free(s, head);
> > +             } else {
> > +                     __slab_free(s, slab, head, tail, cnt, addr);
> > +             }
> >               return;
> >       }
> >
> > +     if (unlikely(!allow_spin)) {
> > +             if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
>
> Same nit about USE_LOCKLESS_FAST_PATH

Here, I have to disagree unless we fix the couple lines below as well.

> > +                 local_lock_is_locked(&s->cpu_slab->lock)) {
> > +                     defer_free(s, head);
> > +                     return;
> > +             }
> > +             cnt =3D 1; /* restore cnt. kfree_nolock() frees one objec=
t at a time */
> > +             kasan_slab_free(s, head, false, false, /* skip quarantine=
 */true);
> > +     }
> > +
> >       if (USE_LOCKLESS_FAST_PATH()) {
> >               freelist =3D READ_ONCE(c->freelist);
> >
> > @@ -4607,8 +4911,10 @@ static __always_inline void do_slab_free(struct =
kmem_cache *s,
> >                       goto redo;
> >               }
> >       } else {
> > +             __maybe_unused long flags =3D 0;
> > +
> >               /* Update the free list under the local lock */
> > -             local_lock(&s->cpu_slab->lock);
> > +             local_lock_cpu_slab(s, &flags);
> >               c =3D this_cpu_ptr(s->cpu_slab);
> >               if (unlikely(slab !=3D c->slab)) {
> >                       local_unlock(&s->cpu_slab->lock);
> > @@ -4621,7 +4927,7 @@ static __always_inline void do_slab_free(struct k=
mem_cache *s,
> >               c->freelist =3D head;
> >               c->tid =3D next_tid(tid);
> >
> > -             local_unlock(&s->cpu_slab->lock);
> > +             local_unlock_cpu_slab(s, &flags);
> >       }
> >       stat_add(s, FREE_FASTPATH, cnt);
> >  }
> > @@ -4844,6 +5150,62 @@ void kfree(const void *object)
> >  }
> >  EXPORT_SYMBOL(kfree);
> >
> > +/*
> > + * Can be called while holding raw_spinlock_t or from IRQ and NMI,
> > + * but only for objects allocated by kmalloc_nolock(),
> > + * since some debug checks (like kmemleak and kfence) were
> > + * skipped on allocation. large_kmalloc is not supported either.
> > + */
> > +void kfree_nolock(const void *object)
> > +{
> > +     struct folio *folio;
> > +     struct slab *slab;
> > +     struct kmem_cache *s;
> > +     void *x =3D (void *)object;
> > +
> > +     if (unlikely(ZERO_OR_NULL_PTR(object)))
> > +             return;
> > +
> > +     folio =3D virt_to_folio(object);
> > +     if (unlikely(!folio_test_slab(folio))) {
> > +             WARN(1, "Buggy usage of kfree_nolock");
> > +             return;
> > +     }
> > +
> > +     slab =3D folio_slab(folio);
> > +     s =3D slab->slab_cache;
> > +
> > +     memcg_slab_free_hook(s, slab, &x, 1);
> > +     alloc_tagging_slab_free_hook(s, slab, &x, 1);
> > +     /*
> > +      * Unlike slab_free() do NOT call the following:
> > +      * kmemleak_free_recursive(x, s->flags);
> > +      * debug_check_no_locks_freed(x, s->object_size);
> > +      * debug_check_no_obj_freed(x, s->object_size);
> > +      * __kcsan_check_access(x, s->object_size, ..);
> > +      * kfence_free(x);
> > +      * since they take spinlocks.
> > +      */
>
> So here's the bigger concern. What if someone allocates with regular
> kmalloc() so that the debugging stuff is performed as usual, and then tri=
es
> to use kfree_nolock() whre we skip it? You might not be planning such usa=
ge,
> but later someone can realize that only their freeing context is limited,
> finds out kfree_nolock() exists and tries to use it?
>
> Can we document this strongly enough? Or even enforce it somehow? Or when
> any of these kinds of debugs above are enabled, we play it safe and use
> defer_free()?

Let's break it one by one.
1.
kmemleak_free_recursive() will miss an object that was recorded
during normal kmalloc() and that's indeed problematic.

2.
debug_check_no_locks_freed() and
debug_check_no_obj_freed()
are somewhat harmless.
We miss checks, but it's not breaking the corresponding features.

3.
__kcsan_check_access() doesn't take locks, but its stack is
so deep and looks to be recursive that I doubt it's safe from
any context.

4.
kfence_free() looks like an existing quirk.
I'm not sure why it's there in the slab free path :)
kfence comment says:
 * KFENCE objects live in a separate page range and are not to be intermixe=
d
 * with regular heap objects (e.g. KFENCE objects must never be added to th=
e
 * allocator freelists). Failing to do so may and will result in heap
 * corruptions, therefore is_kfence_address() must be used to check whether
 * an object requires specific handling.

so it should always be a nop for slab.
I removed the call for peace of mind.

So imo only 1 is dodgy. We can add:
if (!(flags & SLAB_NOLEAKTRACE) && kmemleak_free_enabled)
  defer_free(..);

but it's ugly too.

My preference is to add a comment saying that only objects
allocated by kmalloc_nolock() should be freed by kfree_nolock().

