Return-Path: <bpf+bounces-57467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD11AAB8C5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B07A7295
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1418B0F;
	Tue,  6 May 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEUSpYtE"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CA2D9DDE
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494710; cv=none; b=Jbj8revMO1sYv2nrWaowLYW9EKk0we+Z0wp9XeLULj3ViZBbm2ugd8D2AdLS9qq/VtzvvXGRzav5EPX+0Vbfp14FICXyc6XU/n/hdov3ZIB31TkpTN/Zw725i5+oE/0PRSK1QEreyi8yNF+qFT9eltJ3EpkjQ/z3OGVTTu6fgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494710; c=relaxed/simple;
	bh=k4E8/Wf3fXWGvQsCcV3yzTej+tuBVLo+a4KiucoDb9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0WKEf6VRaZHJmirP6QkNNQWaAmyX3jSuDW9UBltqD9N3XfB39DBOLYJlP0h80EO85G8V7I51iv+uN3KvnjfjQs5SyfZwbHq2qBefgAL0yuLBY9oqFGzPU4qN+bPW1ytwpqBOg+g3IW6+qQqMqar+SwkOajLowwIoODWPsVxzZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEUSpYtE; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 18:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746494705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcKf3ZnERF7BUr1vw6W2BgJU183whVAFQP4h2oIJf5M=;
	b=iEUSpYtEueO6vD8eNz6epby8CnAKHXq0A+F+y29y1cI54Q2b2c3VSWEUt5+nxNhuwux43E
	bmdlz5VnElBnBYC10tFJwMeK1SIvXeMtsULLg/InoLkwg/yXNyooZawepTdJIbhv7L+x74
	KiyMPFeJP6Kiaac9bxqP50ymRxmgRAQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Message-ID: <d25b6lxjjzi3zqbotlrapx57ukjl7frmyvg2lgx5omos3zqg4m@ukkod2jdmieb>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
 <a74hjevi7tyq36vekcft7mlfdgwtcg6ddvr3bekb3amcf4fiuc@z7xszkyjcrbb>
 <CAADnVQ+OroM-auGvC7GPzaOUz90zHktF545BC7wRz5s_tW6z4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+OroM-auGvC7GPzaOUz90zHktF545BC7wRz5s_tW6z4w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 05, 2025 at 05:49:47PM -0700, Alexei Starovoitov wrote:
> On Mon, May 5, 2025 at 11:46 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Apr 30, 2025 at 08:27:18PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -595,7 +595,13 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> > >       if (!val)
> > >               return;
> > >
> > > -     cgroup_rstat_updated(memcg->css.cgroup, cpu);
> > > +     /*
> > > +      * If called from NMI via kmalloc_nolock -> memcg_slab_post_alloc_hook
> > > +      * -> obj_cgroup_charge -> mod_memcg_state,
> > > +      * then delay the update.
> > > +      */
> > > +     if (!in_nmi())
> > > +             cgroup_rstat_updated(memcg->css.cgroup, cpu);
> >
> > I don't think we can just ignore cgroup_rstat_updated() for nmi as there
> > is a chance (though very small) that we will loose these stats updates.
> 
> I'm failing to understand why it's an issue.
> Not doing cgroup_rstat_updated() can only cause updated_next link
> to stay NULL when it should be set,
> but it should be harmless, and no different from racy check
> that the code already doing:
> if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
>   return;
> 
> Imaging it was !NULL, the code would return,
> but then preemption, something clears it to NULL,
> and here we're skipping a set of updated_next.

cgroup_rstat_updated() puts the given cgroup whose stats are modified in
the per-cpu update tree which later the read side will flush to get the
uptodate stats. Not putting in the update tree will cause the read side
to not flush the stats cached on that cpu. Though there is a possibility
that someone else in non-nmi context may put that cgroup on that cpu's
update tree but there is no guarantee.

> 
> > In addition, memcg_rstat_updated() itself is not reentrant safe along
> > with couple of functions leading to it like __mod_memcg_lruvec_state().
> 
> Sure. __mod_memcg_lruvec_state() is not reentrant,
> but it's not an issue for kmalloc_nolock(), since objcg/memcg
> charge/uncharge from slub is not calling it (as far as I can tell).

Without this patch:

__memcg_slab_post_alloc_hook() -> obj_cgroup_charge_account() ->
consume_obj_stock() -> __account_obj_stock() -> __account_obj_stock() ->
__mod_objcg_mlstate() -> __mod_memcg_lruvec_state()

With this patch:
__memcg_slab_post_alloc_hook() -> obj_cgroup_charge_atomic() ->
obj_cgroup_charge_pages() -> mod_memcg_state() -> __mod_memcg_state()

Other than __mod_memcg_state() being not reentrant safe, we will be
missing NR_SLAB_RECLAIMABLE_B and NR_SLAB_UNRECLAIMABLE_B after the
patch.

> 
> >
> > >       statc = this_cpu_ptr(memcg->vmstats_percpu);
> > >       for (; statc; statc = statc->parent) {
> > >               /*
> > > @@ -2895,7 +2901,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> > >       unsigned long flags;
> > >       bool ret = false;
> > >
> > > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +     local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
> > >
> > >       stock = this_cpu_ptr(&memcg_stock);
> > >       if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
> > > @@ -2995,7 +3001,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> > >       unsigned long flags;
> > >       unsigned int nr_pages = 0;
> > >
> > > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +     local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
> > >
> > >       stock = this_cpu_ptr(&memcg_stock);
> > >       if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > > @@ -3088,6 +3094,27 @@ static inline size_t obj_full_size(struct kmem_cache *s)
> > >       return s->size + sizeof(struct obj_cgroup *);
> > >  }
> > >
> > > +/*
> > > + * Try subtract from nr_charged_bytes without making it negative
> > > + */
> > > +static bool obj_cgroup_charge_atomic(struct obj_cgroup *objcg, gfp_t flags, size_t sz)
> > > +{
> > > +     size_t old = atomic_read(&objcg->nr_charged_bytes);
> > > +     u32 nr_pages = sz >> PAGE_SHIFT;
> > > +     u32 nr_bytes = sz & (PAGE_SIZE - 1);
> > > +
> > > +     if ((ssize_t)(old - sz) >= 0 &&
> > > +         atomic_cmpxchg(&objcg->nr_charged_bytes, old, old - sz) == old)
> > > +             return true;
> > > +
> > > +     nr_pages++;
> > > +     if (obj_cgroup_charge_pages(objcg, flags, nr_pages))
> > > +             return false;
> > > +
> > > +     atomic_add(PAGE_SIZE - nr_bytes, &objcg->nr_charged_bytes);
> > > +     return true;
> > > +}
> > > +
> > >  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> > >                                 gfp_t flags, size_t size, void **p)
> > >  {
> > > @@ -3128,6 +3155,21 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> > >                       return false;
> > >       }
> > >
> > > +     if (!gfpflags_allow_spinning(flags)) {
> > > +             if (local_lock_is_locked(&memcg_stock.stock_lock)) {
> > > +                     /*
> > > +                      * Cannot use
> > > +                      * lockdep_assert_held(this_cpu_ptr(&memcg_stock.stock_lock));
> > > +                      * since lockdep might not have been informed yet
> > > +                      * of lock acquisition.
> > > +                      */
> > > +                     return obj_cgroup_charge_atomic(objcg, flags,
> > > +                                                     size * obj_full_size(s));
> >
> > We can not just ignore the stat updates here.
> >
> > > +             } else {
> > > +                     lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_lock));
> > > +             }
> > > +     }
> > > +
> > >       for (i = 0; i < size; i++) {
> > >               slab = virt_to_slab(p[i]);
> > >
> > > @@ -3162,8 +3204,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> > >  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> > >                           void **p, int objects, struct slabobj_ext *obj_exts)
> > >  {
> > > +     bool lock_held = local_lock_is_locked(&memcg_stock.stock_lock);
> > >       size_t obj_size = obj_full_size(s);
> > >
> > > +     if (likely(!lock_held))
> > > +             lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_lock));
> > > +
> > >       for (int i = 0; i < objects; i++) {
> > >               struct obj_cgroup *objcg;
> > >               unsigned int off;
> > > @@ -3174,8 +3220,12 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> > >                       continue;
> > >
> > >               obj_exts[off].objcg = NULL;
> > > -             refill_obj_stock(objcg, obj_size, true, -obj_size,
> > > -                              slab_pgdat(slab), cache_vmstat_idx(s));
> > > +             if (unlikely(lock_held)) {
> > > +                     atomic_add(obj_size, &objcg->nr_charged_bytes);
> >
> > objcg->nr_charged_bytes is stats ignorant and the relevant stats need to
> > be updated before putting stuff into it.
> 
> I'm not following.
> It's functionally equivalent to refill_obj_stock() without
> __account_obj_stock().
> And the stats are not ignored.
> The next __memcg_slab_free_hook() from good context will update
> them. It's only a tiny delay in update.
> I don't see why it's an issue.

For the slab object of size obj_size which is being freed here, we need
to update NR_SLAB_RECLAIMABLE_B or NR_SLAB_UNRECLAIMABLE_B stat for the
corresponding objcg by the amount of obj_size. If we don't call
__account_obj_stock() here we will loose the context and information to
update these stats later.

> 
> > > +             } else {
> > > +                     refill_obj_stock(objcg, obj_size, true, -obj_size,
> > > +                                      slab_pgdat(slab), cache_vmstat_idx(s));
> > > +             }
> > >               obj_cgroup_put(objcg);
> > >       }
> > >  }
> >
> > I am actually working on making this whole call chain (i.e.
> > kmalloc/kmem_cache_alloc to memcg [un]charging) reentrant/nmi safe.
> 
> Thank you for working on it!
> You mean this set:
> https://lore.kernel.org/all/20250429061211.1295443-1-shakeel.butt@linux.dev/
> ?
> it's making css_rstat_updated() re-entrant,
> which is renamed/reworked version of memcg_rstat_updated().
> That's good, but not enough from slub pov.
> It removes the need for the first hunk in this patch from mm/memcontrol.c
> + if (!in_nmi())
> +               cgroup_rstat_updated(...);
> 
> but hunks in __memcg_slab_post_alloc_hook() and __memcg_slab_free_hook()
> are still needed.
> And I think the obj_cgroup_charge_atomic() approach in this patch is correct.
> The delay in rstat update seems fine.
> Please help me understand what I'm missing.
> 

The css_rstat_updated() is the new name of cgroup_rstat_updated() and it
is only a piece of the puzzle. My plan is to memcg stats reentrant which
would allow to call __account_obj_stock (or whatever new name would be)
in nmi context and then comsume_obj_stock() and refill_obj_stock() would
work very similar to consume_stock() and refill_stock().

Please give me couple of days and I can share the full RFC of the memcg
side.

