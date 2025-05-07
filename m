Return-Path: <bpf+bounces-57609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A066AAD335
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632EA981DE6
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC318C937;
	Wed,  7 May 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTUOSkr1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D64183CCA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584448; cv=none; b=Lqe/Dvq5DCGno/aVqeMXPyVRufyd1/k4rdTpjtoo3jv+9kOHImJOCDX0XEgeCpUojHNLcHFZjSKfojrJ44zyMAHUyvFgrH7PnZ/thyTKlixB8iPuiwpZzrXrdHSLu2jlNO5p+sHlHWnROgQwH9mA3g9mgbQnwlUoMaWCvR2DwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584448; c=relaxed/simple;
	bh=sXX40oIVRh01LGJZmeHq80SqRFICHWcL1ZhTt+k/oXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5iWb2DuQ4ynQh3TFOmZHnq4hm840oFQWIwH4urleK+SntYdJcHdanp+IVpwK1L1hvxb1eoXvQ1JOANosNOCJ0wJUoB3ENaXOGItiWrPOjnW8FGQOLtxpIoaomu1Ekc9ehuat2apOL0/mDuC03hE/704KCpVA2t7uMCx3vg/RoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTUOSkr1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so63427115e9.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 19:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746584444; x=1747189244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E+c1WyGMrj9RHkYHYay+xLHQEL8y5IHjkKQFpF45v8=;
        b=XTUOSkr14hGNiAZ+DGQV2Vk+s4sL2cawgF1aV0UqRSm0bz25ZB8ugwvqDL2FETT/Jg
         mEkTZ7X+nSpKKdCOe9s6VRkzEHlI2Prjz4oZvaA3kye9ENnrL4oOeEIEH/6hICx0SWhx
         bxhaigQzWuLeku+uk/4iKgJpMVjpCFpL0jOk1fOvd6Y0hZUZyasx5MTAGc/2e7QICzq2
         XIfSToSYmqfC6U4RZI+9ioddjLvEqL4TcY0HoxlHg6MaQp4+MKGAmDu7r8V/RprvIeMk
         yzekAcJlEfm0tfk/IKQKfi0X9xs9EEA8P5+h4yqLY1ecStkcqeP3+eY0iXkocj+BLOIB
         bwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746584444; x=1747189244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E+c1WyGMrj9RHkYHYay+xLHQEL8y5IHjkKQFpF45v8=;
        b=MTsoUui02kpGHjdcdO/LclFJ8qgHdZ6Vr0kmUdpoIQ+OoNBdykQmwVP8O/3/5UT66P
         J/s/9Z7CwW6/lTX7fkefEKjsy1VlQL0MZGmjXLbpXh2DtthCGzz98MJSwab5M9hnIcKc
         OdW9YB7X58IVZVb866AHnNvCL9O+JkdBcJ2XFt7hSM2Qzly1HMzUUsV5mxdXhIT593YB
         RP8rJ3CgW8zAKEMiWdrFw4k7ypTwn8jb3FiFSCPQ+8qVVVD5Dg5D1/gcjtILZaI+wwXS
         5oTAOVZfnU3SYg4nWZSVMgXSgGdUFEJlaALTV/cme/ToGG7MPLt7nj2NE6j6eGu4bHge
         YTEA==
X-Gm-Message-State: AOJu0YyrvDj0Sfol0oxSVdPuqeYlnzrycZvqBs8VOr/UVk8Bfpt5oh+m
	3av782guVm1eQ4nuwVhYyhggXJJJpf1NcKBaqPkr2KpTBB7/SN9CrNHb0fWkeUt0xRg7pJ/ecme
	JCAyCt9RjD5e+a+bFV3p2EuUUm3Q=
X-Gm-Gg: ASbGncs/USUeNOQqE0IwwIuOCf9y2do20i2rGsvxZfxb+zBA/r/4F9JUt1wenk9kGhn
	ygtIYmcuod4Hm4MZAtkZJbpUb8s6cMolZP+W23vsRp1gHPKKbPNs+up8i1sa4YPqI7B7lXhIV/W
	0Y+VKIsdoND8ZufGGxShxDLvNCRHyJX4IgST6TWg5tswN0Z4cLjLnxyonap7lq
X-Google-Smtp-Source: AGHT+IGzyCfjUQQ0GVZYfCKRrFGd76wXqmgBCDTjo9Zxn+pl1IG8tcnnVuBVgATzZ+lr4FPuu259+dTar6M3152NK1g=
X-Received: by 2002:a05:600c:608f:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-441d44c3348mr9201755e9.13.1746584443574; Tue, 06 May 2025
 19:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com> <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
In-Reply-To: <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 19:20:32 -0700
X-Gm-Features: ATxdqUFAQ4Z2MIutfsfIgdZ6neFvCQUnfowkIpubpnkGzCgejeWyzXzqOK1brQQ
Message-ID: <CAADnVQLO9YX2_0wEZshHbwXoJY2-wv3OgVGvN-hgf6mK0_ipxw@mail.gmail.com>
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 5/1/25 05:27, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > kmalloc_nolock() relies on ability of local_lock to detect the situatio=
n
> > when it's locked.
> > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> > In that case retry the operation in a different kmalloc bucket.
> > The second attempt will likely succeed, since this cpu locked
> > different kmem_cache_cpu.
> > When lock_local_is_locked() sees locked memcg_stock.stock_lock
> > fallback to atomic operations.
> >
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current task. In this case re-entranc=
e
> > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > a different bucket that is most likely is not locked by current
> > task. Though it may be locked by a different task it's safe to
> > rt_spin_lock() on it.
> >
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> In general I'd prefer if we could avoid local_lock_is_locked() usage outs=
ide
> of debugging code. It just feels hacky given we have local_trylock()
> operations. But I can see how this makes things simpler so it's probably
> acceptable.

local_lock_is_locked() is not for debugging.
It's gating further calls into slub internals.
If a particular bucket is locked the logic will use a different one.
There is no local_trylock() at all here.
In that sense it's very different from alloc_pages_nolock().
There we trylock first and if not successful go for plan B.
For kmalloc_nolock() we first check whether local_lock_is_locked(),
if not then proceed and do
local_lock_irqsave_check() instead of local_lock_irqsave().
Both are unconditional and exactly the same without
CONFIG_DEBUG_LOCK_ALLOC.
Extra checks are there in _check() version for debugging,
since local_lock_is_locked() is called much earlier in the call chain
and far from local_lock_irqsave. So not trivial to see by just
code reading.
If local_lock_is_locked() says that it's locked
we go for a different bucket which is pretty much guaranteed to
be unlocked.

>
> > @@ -2458,13 +2468,21 @@ static void *setup_object(struct kmem_cache *s,=
 void *object)
> >   * Slab allocation and freeing
> >   */
> >  static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> > -             struct kmem_cache_order_objects oo)
> > +                                        struct kmem_cache_order_object=
s oo,
> > +                                        bool allow_spin)
> >  {
> >       struct folio *folio;
> >       struct slab *slab;
> >       unsigned int order =3D oo_order(oo);
> >
> > -     if (node =3D=3D NUMA_NO_NODE)
> > +     if (unlikely(!allow_spin)) {
> > +             struct page *p =3D alloc_pages_nolock(__GFP_COMP, node, o=
rder);
> > +
> > +             if (p)
> > +                     /* Make the page frozen. Drop refcnt to zero. */
> > +                     put_page_testzero(p);
>
> This is dangerous. Once we create a refcounted (non-frozen) page, someone
> else (a pfn scanner like compaction) can do a get_page_unless_zero(), so =
the
> refcount becomes 2, then we decrement the refcount here to 1, the pfn
> scanner realizes it's not a page it can work with, do put_page() and free=
s
> it under us.

Something like isolate_migratepages_block() does that?
ok. good to know.

> The solution is to split out alloc_frozen_pages_nolock() to use from here=
,
> and make alloc_pages_nolock() use it too and then set refcounted.

understood.

> > +             folio =3D (struct folio *)p;
> > +     } else if (node =3D=3D NUMA_NO_NODE)
> >               folio =3D (struct folio *)alloc_frozen_pages(flags, order=
);
> >       else
> >               folio =3D (struct folio *)__alloc_frozen_pages(flags, ord=
er, node, NULL);
>
> <snip>
>
> > @@ -3958,8 +3989,28 @@ static void *__slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
> >        */
> >       c =3D slub_get_cpu_ptr(s->cpu_slab);
> >  #endif
> > +     if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
> > +             struct slab *slab;
> > +
> > +             slab =3D c->slab;
> > +             if (slab && !node_match(slab, node))
> > +                     /* In trylock mode numa node is a hint */
> > +                     node =3D NUMA_NO_NODE;
> > +
> > +             if (!local_lock_is_locked(&s->cpu_slab->lock)) {
> > +                     lockdep_assert_not_held(this_cpu_ptr(&s->cpu_slab=
->lock));
> > +             } else {
> > +                     /*
> > +                      * EBUSY is an internal signal to kmalloc_nolock(=
) to
> > +                      * retry a different bucket. It's not propagated =
further.
> > +                      */
> > +                     p =3D ERR_PTR(-EBUSY);
> > +                     goto out;
>
> Am I right in my reasoning as follows?
>
> - If we're on RT and "in_nmi() || in_hardirq()" is true then
> kmalloc_nolock_noprof() would return NULL immediately and we never reach
> this code

correct.

> - local_lock_is_locked() on RT tests if the current process is the lock
> owner. This means (in absence of double locking bugs) that we locked it a=
s
> task (or hardirq) and now we're either in_hardirq() (doesn't change curre=
nt
> AFAIK?) preempting task, or in_nmi() preempting task or hardirq.

not quite.
There could be re-entrance due to kprobe/fentry/tracepoint.
Like trace_contention_begin().
The code is still preemptable.

> - so local_lock_is_locked() will never be true here on RT

hehe :)

To have good coverage I fuzz test this patch set with:

+extern void (*debug_callback)(void);
+#define local_unlock_irqrestore(lock, flags) \
+ do { \
+ if (debug_callback) debug_callback(); \
+ __local_unlock_irqrestore(lock, flags); \
+ } while (0)

and randomly re-enter everywhere from debug_callback().

> > +             }
> > +     }
> >
> >       p =3D ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> > +out:
> >  #ifdef CONFIG_PREEMPT_COUNT
> >       slub_put_cpu_ptr(s->cpu_slab);
> >  #endif
> > @@ -4162,8 +4213,9 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
> >               if (p[i] && init && (!kasan_init ||
> >                                    !kasan_has_integrated_init()))
> >                       memset(p[i], 0, zero_size);
> > -             kmemleak_alloc_recursive(p[i], s->object_size, 1,
> > -                                      s->flags, init_flags);
> > +             if (gfpflags_allow_spinning(flags))
> > +                     kmemleak_alloc_recursive(p[i], s->object_size, 1,
> > +                                              s->flags, init_flags);
> >               kmsan_slab_alloc(s, p[i], init_flags);
> >               alloc_tagging_slab_alloc_hook(s, p[i], flags);
> >       }
> > @@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
> >  }
> >  EXPORT_SYMBOL(__kmalloc_noprof);
> >
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
> > +     if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > +             return NULL;
> > +     if (unlikely(!size))
> > +             return ZERO_SIZE_PTR;
> > +
> > +     if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
> > +             /* kmalloc_nolock() in PREEMPT_RT is not supported from i=
rq */
> > +             return NULL;
> > +retry:
> > +     s =3D kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
>
> The idea of retrying on different bucket is based on wrong assumptions an=
d
> thus won't work as you expect. kmalloc_slab() doesn't select buckets trul=
y
> randomly, but deterministically via hashing from a random per-boot seed a=
nd
> the _RET_IP_, as the security hardening goal is to make different kmalloc=
()
> callsites get different caches with high probability.

There is no relying on randomness.
As Harry pointed out in the other reply,
there is one retry from a different bucket.
Everything is deterministic.

> And I wouldn't also recommend changing this for kmalloc_nolock_noprof() c=
ase
> as that could make the hardening weaker, and also not help for kernels th=
at
> don't have it enabled, anyway.

This patch doesn't affect hardening.
If RANDOM_KMALLOC_CACHES is enabled it will affect
all callers of kmalloc_slab(), normal kmalloc and this kmalloc_nolock.
Protection is not weakened.

>
> > +
> > +     if (!(s->flags & __CMPXCHG_DOUBLE))
> > +             /*
> > +              * kmalloc_nolock() is not supported on architectures tha=
t
> > +              * don't implement cmpxchg16b.
> > +              */
> > +             return NULL;
> > +
> > +     /*
> > +      * Do not call slab_alloc_node(), since trylock mode isn't
> > +      * compatible with slab_pre_alloc_hook/should_failslab and
> > +      * kfence_alloc.
> > +      *
> > +      * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> > +      * in irq saved region. It assumes that the same cpu will not
> > +      * __update_cpu_freelist_fast() into the same (freelist,tid) pair=
.
> > +      * Therefore use in_nmi() to check whether particular bucket is i=
n
> > +      * irq protected section.
> > +      */
> > +     if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> > +             ret =3D __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, s=
ize);
>
> Hm this is somewhat subtle. We're testing the local lock without having t=
he
> cpu explicitly pinned. But the test only happens in_nmi() which implicitl=
y
> is a context that won't migrate, so should work I think, but maybe should=
 be
> more explicit in the comment?

Ok. I'll expand the comment right above this 'if'.

>
> <snip>
>
> >  /*
> >   * Fastpath with forced inlining to produce a kfree and kmem_cache_fre=
e that
> >   * can perform fastpath freeing without additional function calls.
> > @@ -4605,10 +4762,36 @@ static __always_inline void do_slab_free(struct=
 kmem_cache *s,
> >       barrier();
> >
> >       if (unlikely(slab !=3D c->slab)) {
>
> Note this unlikely() is actually a lie. It's actually unlikely that the f=
ree
> will happen on the same cpu and with the same slab still being c->slab,
> unless it's a free following shortly a temporary object allocation.

I didn't change it, since you would have called it
an unrelated change in the patch :)
I can prepare a separate single line patch to remove unlikely() here,
but it's a micro optimization unrelated to this set.

> > -             __slab_free(s, slab, head, tail, cnt, addr);
> > +             /* cnt =3D=3D 0 signals that it's called from kfree_noloc=
k() */
> > +             if (unlikely(!cnt)) {
> > +                     /*
> > +                      * Use llist in cache_node ?
> > +                      * struct kmem_cache_node *n =3D get_node(s, slab=
_nid(slab));
> > +                      */
> > +                     /*
> > +                      * __slab_free() can locklessly cmpxchg16 into a =
slab,
> > +                      * but then it might need to take spin_lock or lo=
cal_lock
> > +                      * in put_cpu_partial() for further processing.
> > +                      * Avoid the complexity and simply add to a defer=
red list.
> > +                      */
> > +                     llist_add(head, &s->defer_free_objects);
> > +             } else {
> > +                     free_deferred_objects(&s->defer_free_objects, add=
r);
>
> So I'm a bit vary that this is actually rather a fast path that might
> contend on the defer_free_objects from all cpus.

Well, in my current stress test I could only get this list
to contain a single digit number of objects.

> I'm wondering if we could make the list part of kmem_cache_cpu to distrib=
ute
> it,

doable, but kmem_cache_cpu *c =3D raw_cpu_ptr(s->cpu_slab);
is preemptable, so there is a risk that
llist_add(.. , &c->defer_free_objects);
will be accessing per-cpu memory of another cpu.
llist_add() will work correctly, but cache line bounce is possible.
In kmem_cache I placed defer_free_objects after cpu_partial and oo,
so it should be cache hot.

> and hook the flushing e.g. to places where we do deactivate_slab() which
> should be much slower path,

I don't follow the idea.
If we don't process kmem_cache_cpu *c right here in do_slab_free()
this llist will get large.
So we have to process it here, but if we do, what's the point
of extra flush in deactivate_slab() ?
Especially with extra for_each_cpu() loop to reach all kmem_cache_cpu ?

> and also free_to_partial_list() to handle
> SLUB_TINY/caches with debugging enabled.

SLUB_TINY... ohh. I didn't try it. Will fix.

