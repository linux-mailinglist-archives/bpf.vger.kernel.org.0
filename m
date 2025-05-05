Return-Path: <bpf+bounces-57362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB5AA9BDA
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 20:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45D07A5AA2
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A151B3955;
	Mon,  5 May 2025 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DC4qa+a3"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46335EEC3
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470800; cv=none; b=ZiBl4H3/Mf+Kq7lJw6dWFHWUjJe07Vu59nNEcAf/nL1FS4tSnJEaJ6BX6Dm6Z5ve4iyjlNVFU+H0C1pHkCklj7qYRqXSmk8AT2nGbf9amWFQSK+TwzFSpo+u1LrKoJrJfk+k5gjPeoYQA6w8iUZFdZvsvV4MdQM8F6X/NOZlGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470800; c=relaxed/simple;
	bh=AegFSyOOv4grWdByZkfKeWyg0oWxgN/qlLF/4qdJ7fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrO8eQ0Sfb+FuB8Y7jYxCnNbbrXIWz7rURF6qWOjn4aXnb4uAbFjQR/zSL/ML13Q+C7vQthEp+t3VClJF1qtP46Gl/zjqGy51I9wqL2ZsliAWDI00B8dxBQ9n/9EaylahedoEGAJ36ln2h2jpX2+auNdS71RMwZp3WxEP9vraqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DC4qa+a3; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 11:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746470795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnKxsV2L2fffvIQfQUdFUlww7mT05ivEl4wH2LZkKqU=;
	b=DC4qa+a3IVGQtg+5iEP1lHix3GfsKejrm/X2uAXD887G8EBSEms8BiKVwvaYqezI4Sr5z3
	XZ/PiFmCfecMxGquEk73+I4tiKYDs/SzcC+d7RilXQNgo0Tz1gVyoCenuX4eNzhrgdyGgE
	yZIWWdVl3udUJT04Z0RIWOgmj2R9NYk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	rostedt@goodmis.org, hannes@cmpxchg.org, willy@infradead.org
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Message-ID: <a74hjevi7tyq36vekcft7mlfdgwtcg6ddvr3bekb3amcf4fiuc@z7xszkyjcrbb>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501032718.65476-7-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 08:27:18PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -595,7 +595,13 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  	if (!val)
>  		return;
>  
> -	cgroup_rstat_updated(memcg->css.cgroup, cpu);
> +	/*
> +	 * If called from NMI via kmalloc_nolock -> memcg_slab_post_alloc_hook
> +	 * -> obj_cgroup_charge -> mod_memcg_state,
> +	 * then delay the update.
> +	 */
> +	if (!in_nmi())
> +		cgroup_rstat_updated(memcg->css.cgroup, cpu);

I don't think we can just ignore cgroup_rstat_updated() for nmi as there
is a chance (though very small) that we will loose these stats updates.

In addition, memcg_rstat_updated() itself is not reentrant safe along
with couple of functions leading to it like __mod_memcg_lruvec_state().

>  	statc = this_cpu_ptr(memcg->vmstats_percpu);
>  	for (; statc; statc = statc->parent) {
>  		/*
> @@ -2895,7 +2901,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	unsigned long flags;
>  	bool ret = false;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
> @@ -2995,7 +3001,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  	unsigned long flags;
>  	unsigned int nr_pages = 0;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> @@ -3088,6 +3094,27 @@ static inline size_t obj_full_size(struct kmem_cache *s)
>  	return s->size + sizeof(struct obj_cgroup *);
>  }
>  
> +/*
> + * Try subtract from nr_charged_bytes without making it negative
> + */
> +static bool obj_cgroup_charge_atomic(struct obj_cgroup *objcg, gfp_t flags, size_t sz)
> +{
> +	size_t old = atomic_read(&objcg->nr_charged_bytes);
> +	u32 nr_pages = sz >> PAGE_SHIFT;
> +	u32 nr_bytes = sz & (PAGE_SIZE - 1);
> +
> +	if ((ssize_t)(old - sz) >= 0 &&
> +	    atomic_cmpxchg(&objcg->nr_charged_bytes, old, old - sz) == old)
> +		return true;
> +
> +	nr_pages++;
> +	if (obj_cgroup_charge_pages(objcg, flags, nr_pages))
> +		return false;
> +
> +	atomic_add(PAGE_SIZE - nr_bytes, &objcg->nr_charged_bytes);
> +	return true;
> +}
> +
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  				  gfp_t flags, size_t size, void **p)
>  {
> @@ -3128,6 +3155,21 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  			return false;
>  	}
>  
> +	if (!gfpflags_allow_spinning(flags)) {
> +		if (local_lock_is_locked(&memcg_stock.stock_lock)) {
> +			/*
> +			 * Cannot use
> +			 * lockdep_assert_held(this_cpu_ptr(&memcg_stock.stock_lock));
> +			 * since lockdep might not have been informed yet
> +			 * of lock acquisition.
> +			 */
> +			return obj_cgroup_charge_atomic(objcg, flags,
> +							size * obj_full_size(s));

We can not just ignore the stat updates here.

> +		} else {
> +			lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_lock));
> +		}
> +	}
> +
>  	for (i = 0; i < size; i++) {
>  		slab = virt_to_slab(p[i]);
>  
> @@ -3162,8 +3204,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  			    void **p, int objects, struct slabobj_ext *obj_exts)
>  {
> +	bool lock_held = local_lock_is_locked(&memcg_stock.stock_lock);
>  	size_t obj_size = obj_full_size(s);
>  
> +	if (likely(!lock_held))
> +		lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_lock));
> +
>  	for (int i = 0; i < objects; i++) {
>  		struct obj_cgroup *objcg;
>  		unsigned int off;
> @@ -3174,8 +3220,12 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  			continue;
>  
>  		obj_exts[off].objcg = NULL;
> -		refill_obj_stock(objcg, obj_size, true, -obj_size,
> -				 slab_pgdat(slab), cache_vmstat_idx(s));
> +		if (unlikely(lock_held)) {
> +			atomic_add(obj_size, &objcg->nr_charged_bytes);

objcg->nr_charged_bytes is stats ignorant and the relevant stats need to
be updated before putting stuff into it.

> +		} else {
> +			refill_obj_stock(objcg, obj_size, true, -obj_size,
> +					 slab_pgdat(slab), cache_vmstat_idx(s));
> +		}
>  		obj_cgroup_put(objcg);
>  	}
>  }

I am actually working on making this whole call chain (i.e.
kmalloc/kmem_cache_alloc to memcg [un]charging) reentrant/nmi safe.

