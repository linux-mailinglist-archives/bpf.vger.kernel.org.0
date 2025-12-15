Return-Path: <bpf+bounces-76608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D266CBDC6B
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 13:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025AB305D42C
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3421531C1;
	Mon, 15 Dec 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OpOHNmeb"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029031D95A3
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801102; cv=none; b=NSjcfQgpnwY3yfYDo0YdvduVv8IzvMWrkBqW50c4isxkm9efkablAnvFGpMSUnthypx/vMTt5KxGZ8zx54cAkd66NidA1eL9vRaC7aqeue0ura49bVZCxTRwGjvc3fv18JCisZ49aWzcqMIZPTmstRYowBtAxX1LcZbW9kX4Ju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801102; c=relaxed/simple;
	bh=zWPlDMrXoHksqLEI+Q9jNtjOZuOq8St2TadW5e6zU9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hth+7v8pcHiGOg9fF7+EVqbdYXyfR9EVz/X6+IgEBcAUev9rcw6KP1zHNf5/nJchf0/qMo4iw8eQ9isnDZOwJgk/AjCrYucM5/PEW6ZaWHP4zNVBRIFId9TxBhxDuOVq3AHzgukDsUHnyhainaGqF77TyhW4fn1EmAG2IFOiLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OpOHNmeb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 20:17:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765801087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQyowvHu09ybpNC76sRIKOM8wjKkC+jHN9wA1E3FUh4=;
	b=OpOHNmebkuVD+CaR8k7iu7rWCKZZ4lB6ccBvk01SUtAA5Yj+/PIEOHwXklkW4zhqmVhj8b
	pkZwK5KdtosDocXBQ/ikEeRH32jMkjYazz6Vz7u37DT25Tby9qgYnBHeN8C/vAuqzGp0UT
	Y+0OCHOOCybj5RFhSdq5HyT0QehSHV4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC 06/19] slab: introduce percpu sheaves bootstrap
Message-ID: <ct5pjdx3k4sxw5qjuzs7rsblkxpkah3qdx6kbhe2oeuaontaii@fwgb6ovi36zj>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-6-6ffa2c9941c0@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-sheaves-for-all-v1-6-6ffa2c9941c0@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 23, 2025 at 03:52:28PM +0200, Vlastimil Babka wrote:
> Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
> sheaves enabled. Since we want to enable them for almost all caches,
> it's suboptimal to test the pointer in the fast paths, so instead
> allocate it for all caches in do_kmem_cache_create(). Instead of testing
> the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
> kmem_cache->sheaf_capacity for being 0, where needed.
> 
> However, for the fast paths sake we also assume that the main sheaf
> always exists (pcs->main is !NULL), and during bootstrap we cannot
> allocate sheaves yet.
> 
> Solve this by introducing a single static bootstrap_sheaf that's
> assigned as pcs->main during bootstrap. It has a size of 0, so during
> allocations, the fast path will find it's empty. Since the size of 0
> matches sheaf_capacity of 0, the freeing fast paths will find it's
> "full". In the slow path handlers, we check sheaf_capacity to recognize
> that the cache doesn't (yet) have real sheaves, and fall back. Thus
> sharing the single bootstrap sheaf like this for multiple caches and
> cpus is safe.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a6e58d3708f4..ecb10ed5acfe 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2850,6 +2850,10 @@ static void pcs_destroy(struct kmem_cache *s)
>  		if (!pcs->main)
>  			continue;
>  
> +		/* bootstrap or debug caches, it's the bootstrap_sheaf */
> +		if (!pcs->main->cache)
> +			continue;
> +
>  		/*
>  		 * We have already passed __kmem_cache_shutdown() so everything
>  		 * was flushed and there should be no objects allocated from
> @@ -4054,7 +4058,7 @@ static void flush_cpu_slab(struct work_struct *w)
>  
>  	s = sfw->s;
>  
> -	if (s->cpu_sheaves)
> +	if (s->sheaf_capacity)
>  		pcs_flush_all(s);
>  
>  	flush_this_cpu_slab(s);
> @@ -4176,7 +4180,7 @@ static int slub_cpu_dead(unsigned int cpu)
>  	mutex_lock(&slab_mutex);
>  	list_for_each_entry(s, &slab_caches, list) {
>  		__flush_cpu_slab(s, cpu);
> -		if (s->cpu_sheaves)
> +		if (s->sheaf_capacity)
>  			__pcs_flush_all_cpu(s, cpu);
>  	}
>  	mutex_unlock(&slab_mutex);
> @@ -4979,6 +4983,12 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>  
>  	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
> +	/* Bootstrap or debug cache, back off */
> +	if (unlikely(!s->sheaf_capacity)) {
> +		local_unlock(&s->cpu_sheaves->lock);
> +		return NULL;
> +	}
> +
>  	if (pcs->spare && pcs->spare->size > 0) {
>  		swap(pcs->main, pcs->spare);
>  		return pcs;
> @@ -5162,6 +5172,11 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  		struct slab_sheaf *full;
>  		struct node_barn *barn;
>  
> +		if (unlikely(!s->sheaf_capacity)) {
> +			local_unlock(&s->cpu_sheaves->lock);
> +			return allocated;
> +		}
> +
>  		if (pcs->spare && pcs->spare->size > 0) {
>  			swap(pcs->main, pcs->spare);
>  			goto do_alloc;
> @@ -5241,8 +5256,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>  	if (unlikely(object))
>  		goto out;
>  
> -	if (s->cpu_sheaves)
> -		object = alloc_from_pcs(s, gfpflags, node);
> +	object = alloc_from_pcs(s, gfpflags, node);
>  
>  	if (!object)
>  		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> @@ -6042,6 +6056,12 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  restart:
>  	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>  
> +	/* Bootstrap or debug cache, back off */
> +	if (unlikely(!s->sheaf_capacity)) {
> +		local_unlock(&s->cpu_sheaves->lock);
> +		return NULL;
> +	}
> +
>  	barn = get_barn(s);
>  	if (!barn) {
>  		local_unlock(&s->cpu_sheaves->lock);
> @@ -6240,6 +6260,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  		struct slab_sheaf *empty;
>  		struct node_barn *barn;
>  
> +		/* Bootstrap or debug cache, fall back */
> +		if (!unlikely(s->sheaf_capacity)) {
> +			local_unlock(&s->cpu_sheaves->lock);
> +			goto fail;
> +		}
> +
>  		if (pcs->spare && pcs->spare->size == 0) {
>  			pcs->rcu_free = pcs->spare;
>  			pcs->spare = NULL;
> @@ -6364,6 +6390,9 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	if (likely(pcs->main->size < s->sheaf_capacity))
>  		goto do_free;
>  
> +	if (unlikely(!s->sheaf_capacity))
> +		goto no_empty;
> +
>  	barn = get_barn(s);
>  	if (!barn)
>  		goto no_empty;
> @@ -6628,9 +6657,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>  		return;
>  
> -	if (s->cpu_sheaves && likely(!IS_ENABLED(CONFIG_NUMA) ||
> -				     slab_nid(slab) == numa_mem_id())
> -			   && likely(!slab_test_pfmemalloc(slab))) {
> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> +	    && likely(!slab_test_pfmemalloc(slab))) {
>  		if (likely(free_to_pcs(s, object)))
>  			return;
>  	}
> @@ -7437,8 +7465,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>  		size--;
>  	}
>  
> -	if (s->cpu_sheaves)
> -		i = alloc_from_pcs_bulk(s, size, p);
> +	i = alloc_from_pcs_bulk(s, size, p);
>  
>  	if (i < size) {
>  		/*
> @@ -7649,6 +7676,7 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
>  
>  static int init_percpu_sheaves(struct kmem_cache *s)
>  {
> +	static struct slab_sheaf bootstrap_sheaf = {};
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu) {
> @@ -7658,7 +7686,28 @@ static int init_percpu_sheaves(struct kmem_cache *s)
>  
>  		local_trylock_init(&pcs->lock);
>  
> -		pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
> +		/*
> +		 * Bootstrap sheaf has zero size so fast-path allocation fails.
> +		 * It has also size == s->sheaf_capacity, so fast-path free
> +		 * fails. In the slow paths we recognize the situation by
> +		 * checking s->sheaf_capacity. This allows fast paths to assume
> +		 * s->pcs_sheaves and pcs->main always exists and is valid.
> +		 * It's also safe to share the single static bootstrap_sheaf
> +		 * with zero-sized objects array as it's never modified.
> +		 *
> +		 * bootstrap_sheaf also has NULL pointer to kmem_cache so we
> +		 * recognize it and not attempt to free it when destroying the
> +		 * cache
> +		 *
> +		 * We keep bootstrap_sheaf for kmem_cache and kmem_cache_node,
> +		 * caches with debug enabled, and all caches with SLUB_TINY.
> +		 * For kmalloc caches it's used temporarily during the initial
> +		 * bootstrap.
> +		 */
> +		if (!s->sheaf_capacity)
> +			pcs->main = &bootstrap_sheaf;
> +		else
> +			pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
>  
>  		if (!pcs->main)
>  			return -ENOMEM;
> @@ -7733,8 +7782,7 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
>  void __kmem_cache_release(struct kmem_cache *s)
>  {
>  	cache_random_seq_destroy(s);
> -	if (s->cpu_sheaves)
> -		pcs_destroy(s);
> +	pcs_destroy(s);
>  #ifdef CONFIG_PREEMPT_RT
>  	if (s->cpu_slab)
>  		lockdep_unregister_key(&s->lock_key);
> @@ -7756,7 +7804,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>  			continue;
>  		}
>  
> -		if (s->cpu_sheaves) {
> +		if (s->sheaf_capacity) {
>  			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
>  
>  			if (!barn)
> @@ -8074,7 +8122,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  	flush_all_cpus_locked(s);
>  
>  	/* we might have rcu sheaves in flight */
> -	if (s->cpu_sheaves)
> +	if (s->sheaf_capacity)
>  		rcu_barrier();
>  
>  	/* Attempt to free all objects */
> @@ -8375,7 +8423,7 @@ static int slab_mem_going_online_callback(int nid)
>  		if (get_node(s, nid))
>  			continue;
>  
> -		if (s->cpu_sheaves) {
> +		if (s->sheaf_capacity) {
>  			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
>  
>  			if (!barn) {
> @@ -8608,12 +8656,10 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  
>  	set_cpu_partial(s);
>  
> -	if (s->sheaf_capacity) {
> -		s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
> -		if (!s->cpu_sheaves) {
> -			err = -ENOMEM;
> -			goto out;
> -		}
> +	s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);

After this change, all SLUB caches enable cpu_sheaves; therefore,
slab_unmergeable() will always return 1.

int slab_unmergeable(struct kmem_cache *s)
{
...
	if (s->cpu_sheaves)
		return 1;
...
}

Maybe we need to update slab_unmergeable() accordingly..

> +	if (!s->cpu_sheaves) {
> +		err = -ENOMEM;
> +		goto out;
>  	}
>  
>  #ifdef CONFIG_NUMA
> @@ -8632,11 +8678,9 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  	if (!alloc_kmem_cache_cpus(s))
>  		goto out;
>  
> -	if (s->cpu_sheaves) {
> -		err = init_percpu_sheaves(s);
> -		if (err)
> -			goto out;
> -	}
> +	err = init_percpu_sheaves(s);
> +	if (err)
> +		goto out;
>  
>  	err = 0;
>  
> 
> -- 
> 2.51.1
> 

