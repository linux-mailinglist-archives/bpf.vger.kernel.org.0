Return-Path: <bpf+bounces-48994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B70A12EE2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C657A4235
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF511DDA14;
	Wed, 15 Jan 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA1QNCbg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D41DD87D
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982025; cv=none; b=grgoQVqa1HpWw+0mHZpmG/e6nTD4BJ4Mb0Wy2RvpWhIxbxSpizkvWa4Sq7YiyDHk/AYCB3+QCG2Zea1SGx3vK14ss/RCUGqJFTcYyj0Y2NLWdzIvUEiXJefGssPfPgkPjDLiFNDP88EZMQlvoW3P6UOVnnvPh8CCcBcccJHgU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982025; c=relaxed/simple;
	bh=87d+3M59uK3W2wWwUiv/yPrp9AO0UcDTKLil+k3USPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWA1IEj8KBJa9y3N2RpF8RTbkO8sigJIJ0Est8oxyiKcaKuZpDe31+1H95L4/33YxStCnuRzppLMK+oSSt5/fSwq/keJCMhzn3PEeCL/WvjdrexIvbQqBzPw+sbSlikmoIl+SE9EisCx8s+sQW/bS5r5gK6NIc+psPeJ/IQW/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA1QNCbg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436341f575fso2135625e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 15:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736982021; x=1737586821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDiLtXy3mDukE7KokmiuY0qdo8zYuEuR0EeKTl2FepU=;
        b=VA1QNCbgAj3933TNLboISsLhatJkgrCiO+tXnuoAWHB5QgYcElGafSNeRkTTAsADTK
         /4J5vmud/hXar7NBMtZF1amV5IlmOk6RtiBp+8MasVi8PeCmn6a8Y6DMMcKT2ti3t34F
         2eXFyuv24Ia3qSZ9jSWv0+8nDfZD2/bqNxhtkTj8WxAEPcTWjWY/8xxGVwCU6DIc3aCm
         YQa1sHDp3xYLMqJMoQbgoSDv/7lJ/IQ9s59RviKcksC9STddHbhmi/lnbgMWpV8Pap2q
         3DQmhW0oI67koJoXPB7nbbdV9BXm4eQK1CfT0jV1JjdfU859JO/e7WuHRYBOXy4R0elz
         JAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736982021; x=1737586821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDiLtXy3mDukE7KokmiuY0qdo8zYuEuR0EeKTl2FepU=;
        b=nR5f1U/ojoDC21C0JpKjTIdPDiR4Gz/lMQwwvWvMdlhUSt0VEEDyTeM4+MftJrUGyb
         1cHPBtHP2AqtMqeIfdLZ2WOORu+ebMucPulKWSRwgzqzRlv/KmguRs+NIhdI2tJyXc3N
         rDKiDDe434iEIgtJHpM8fLaQhNhj3qaPXUsYUEDZskDV8sMvseacNW7njTCn61dZzly2
         d73atrSmwfXMCGpk2nbkFcT7o6d9LF9p0ckGyqVbgoTqm7u3Mhod5jAs8HMfPaQBYWzK
         hIT53D74gmU5kNnIcjWtDQLjBZeqjSh3nZ3LnvlNyiG/kDsehBl8G9QBAkv3Mx1lZr55
         wS3Q==
X-Gm-Message-State: AOJu0Yx8xXBPK4xDdW2WKpLwxy7Fiv2kNZTe3OUC9sMldYronaTAYsFD
	PRm+pIvc5eel+GCGi3HTVt7KCyoilwuLkbzDfwkk41pheTuuP69Fw7xE71U/nD4rxcnswAMtXys
	KBMZkhjecmINC8dfsFfQlJdOX/L4=
X-Gm-Gg: ASbGnctXkAghvA56XQ9NX8Ds7ctBSwM2FmYeSRPnC3q04yenOkTRn/zY9MYyxMZc/Ht
	7H2U1n+wJKWJgTwhuTyXv7SHwQjfNyMffqPjUQzDV3rhrEKYKXWfjUg==
X-Google-Smtp-Source: AGHT+IFvAWZqhvjWTlWWrUxUYUlrsbwmsa6i91GddSK+ksfnvUV72QDfB024X3jaOZwJhKmOFkVRZ/PeL4GK0KYRr7w=
X-Received: by 2002:a05:600c:1c1a:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-436e2679a94mr309980085e9.7.1736982021269; Wed, 15 Jan 2025
 15:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-2-alexei.starovoitov@gmail.com> <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
In-Reply-To: <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 15:00:08 -0800
X-Gm-Features: AbW1kvbd_Bvn01PDqy4m0c5cxIca8IjdasmskFcO8KHTjl2zQB5aEDhGuSNSjLo
Message-ID: <CAADnVQ+TecNdNir8QK_3cOKf4WhYj9+j5oZKdzWUoE6H5PuetQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:19=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/15/25 03:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Tracing BPF programs execute from tracepoints and kprobes where
> > running context is unknown, but they need to request additional
> > memory. The prior workarounds were using pre-allocated memory and
> > BPF specific freelists to satisfy such allocation requests.
> > Instead, introduce gfpflags_allow_spinning() condition that signals
> > to the allocator that running context is unknown.
> > Then rely on percpu free list of pages to allocate a page.
> > try_alloc_pages() -> get_page_from_freelist() -> rmqueue() ->
> > rmqueue_pcplist() will spin_trylock to grab the page from percpu
> > free list. If it fails (due to re-entrancy or list being empty)
> > then rmqueue_bulk()/rmqueue_buddy() will attempt to
> > spin_trylock zone->lock and grab the page from there.
> > spin_trylock() is not safe in RT when in NMI or in hard IRQ.
> > Bailout early in such case.
> >
> > The support for gfpflags_allow_spinning() mode for free_page and memcg
> > comes in the next patches.
> >
> > This is a first step towards supporting BPF requirements in SLUB
> > and getting rid of bpf_mem_alloc.
> > That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some nits below:
>
> > ---
> >  include/linux/gfp.h | 22 ++++++++++
> >  mm/internal.h       |  1 +
> >  mm/page_alloc.c     | 98 +++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 118 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index b0fe9f62d15b..b41bb6e01781 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -39,6 +39,25 @@ static inline bool gfpflags_allow_blocking(const gfp=
_t gfp_flags)
> >       return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
> >  }
> >
> > +static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
> > +{
> > +     /*
> > +      * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
> > +      * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
> > +      * All GFP_* flags including GFP_NOWAIT use one or both flags.
> > +      * try_alloc_pages() is the only API that doesn't specify either =
flag.
> > +      *
> > +      * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
> > +      * those are guaranteed to never block on a sleeping lock.
> > +      * Here we are enforcing that the allaaction doesn't ever spin
>
>                                           allocation

oops.

> > +      * on any locks (i.e. only trylocks). There is no highlevel
> > +      * GFP_$FOO flag for this use in try_alloc_pages() as the
> > +      * regular page allocator doesn't fully support this
> > +      * allocation mode.
> > +      */
> > +     return !(gfp_flags & __GFP_RECLAIM);
> > +}
>
> This function seems unused, guess the following patches will use.
>
> > @@ -4509,7 +4517,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_=
mask, unsigned int order,
> >
> >       might_alloc(gfp_mask);
> >
> > -     if (should_fail_alloc_page(gfp_mask, order))
> > +     if (!(*alloc_flags & ALLOC_TRYLOCK) &&
> > +         should_fail_alloc_page(gfp_mask, order))
>
> Is it because should_fail_alloc_page() might take some lock or whatnot?
> Maybe comment?

This is mainly because all kinds of printk-s that fail* logic does.
We've seen way too many syzbot reports because of printk from
the unsupported context.
This part of the comment:
+    * Specify __GFP_NOWARN since failing try_alloc_pages() is not a reason
+    * to warn. Also warn would trigger printk() which is unsafe from
+    * various contexts. We cannot use printk_deferred_enter() to mitigate,
+    * since the running context is unknown.

and also because of get_random_u32() inside fail* logic
that grabs spin_lock.

We've seen syzbot reports about get_random() deadlocking.

Fixing printk and fail*/get_random is necessary too,
but orthogonal work for these patches.

Here I'm preventing this path from prepare_alloc_pages() to avoid
dealing with more syzbot reports than already there.

With try_alloc_pages() out of bpf attached to kprobe inside
printk core logic it would be too easy for syzbot.
And then people will yell at bpf causing problems
whereas the root cause is printk being broken.
We see this finger pointing all too often.

>
> >               return false;
> >
> >       *alloc_flags =3D gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
> > @@ -7023,3 +7032,86 @@ static bool __free_unaccepted(struct page *page)
> >  }
> >
> >  #endif /* CONFIG_UNACCEPTED_MEMORY */
> > +
> > +/**
> > + * try_alloc_pages_noprof - opportunistic reentrant allocation from an=
y context
> > + * @nid - node to allocate from
> > + * @order - allocation order size
> > + *
> > + * Allocates pages of a given order from the given node. This is safe =
to
> > + * call from any context (from atomic, NMI, and also reentrant
> > + * allocator -> tracepoint -> try_alloc_pages_noprof).
> > + * Allocation is best effort and to be expected to fail easily so nobo=
dy should
> > + * rely on the success. Failures are not reported via warn_alloc().
> > + *
> > + * Return: allocated page or NULL on failure.
> > + */
> > +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> > +{
> > +     /*
> > +      * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not=
 allowed.
> > +      * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of k=
swapd
> > +      * is not safe in arbitrary context.
> > +      *
> > +      * These two are the conditions for gfpflags_allow_spinning() bei=
ng true.
> > +      *
> > +      * Specify __GFP_NOWARN since failing try_alloc_pages() is not a =
reason
> > +      * to warn. Also warn would trigger printk() which is unsafe from
> > +      * various contexts. We cannot use printk_deferred_enter() to mit=
igate,
> > +      * since the running context is unknown.
> > +      *
> > +      * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page(=
) below
> > +      * is safe in any context. Also zeroing the page is mandatory for
> > +      * BPF use cases.
> > +      *
> > +      * Though __GFP_NOMEMALLOC is not checked in the code path below,
> > +      * specify it here to highlight that try_alloc_pages()
> > +      * doesn't want to deplete reserves.
> > +      */
> > +     gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
> > +     unsigned int alloc_flags =3D ALLOC_TRYLOCK;
> > +     struct alloc_context ac =3D { };
> > +     struct page *page;
> > +
> > +     /*
> > +      * In RT spin_trylock() may call raw_spin_lock() which is unsafe =
in NMI.
> > +      * If spin_trylock() is called from hard IRQ the current task may=
 be
> > +      * waiting for one rt_spin_lock, but rt_spin_trylock() will mark =
the
> > +      * task as the owner of another rt_spin_lock which will confuse P=
I
> > +      * logic, so return immediately if called form hard IRQ or NMI.
> > +      *
> > +      * Note, irqs_disabled() case is ok. This function can be called
> > +      * from raw_spin_lock_irqsave region.
> > +      */
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > +             return NULL;
> > +     if (!pcp_allowed_order(order))
> > +             return NULL;
> > +
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +     /* Bailout, since try_to_accept_memory_one() needs to take a lock=
 */
> > +     if (has_unaccepted_memory())
> > +             return NULL;
> > +#endif
> > +     /* Bailout, since _deferred_grow_zone() needs to take a lock */
> > +     if (deferred_pages_enabled())
> > +             return NULL;
>
> Is it fine for BPF that things will fail to allocate until all memory is
> deferred-initialized and accepted? I guess it's easy to teach those place=
s
> later to evaluate if they can take the lock.

Exactly. If it becomes an issue it can be addressed.
I didn't want to complicate the code just-because.

> > +
> > +     if (nid =3D=3D NUMA_NO_NODE)
> > +             nid =3D numa_node_id();
> > +
> > +     prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > +                         &alloc_gfp, &alloc_flags);
> > +
> > +     /*
> > +      * Best effort allocation from percpu free list.
> > +      * If it's empty attempt to spin_trylock zone->lock.
> > +      */
> > +     page =3D get_page_from_freelist(alloc_gfp, order, alloc_flags, &a=
c);
>
> What about set_page_owner() from post_alloc_hook() and it's stackdepot
> saving. I guess not an issue until try_alloc_pages() gets used later, so
> just a mental note that it has to be resolved before. Or is it actually s=
afe?

set_page_owner() should be fine.
save_stack() has in_page_owner recursion protection mechanism.

stack_depot_save_flags() may be problematic if there is another
path to it.
I guess I can do:

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 245d5b416699..61772bc4b811 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -630,7 +630,7 @@ depot_stack_handle_t
stack_depot_save_flags(unsigned long *entries,
                        prealloc =3D page_address(page);
        }

-       if (in_nmi()) {
+       if (in_nmi() || !gfpflags_allow_spinning(alloc_flags)) {
                /* We can never allocate in NMI context. */
                WARN_ON_ONCE(can_alloc);
                /* Best effort; bail if we fail to take the lock. */
                if (!raw_spin_trylock_irqsave(&pool_lock, flags))
                        goto exit;

as part of this patch,
but not convinced whether it's necessary.
stack_depot* is effectively noinstr.
kprobe-bpf cannot be placed in there and afaict
it doesn't call any tracepoints.
So in_nmi() is the only way to reenter and that's already covered.

