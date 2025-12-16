Return-Path: <bpf+bounces-76665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E192CC09CA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EEB03019892
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03B285071;
	Tue, 16 Dec 2025 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TxI7E3/S"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFE2C027E
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852565; cv=none; b=YgzgFPSo1DB6qzUa1P/h4YdUjoJr/SU/4awnEDCZpKZO5G8lxKOD2JxUSyMB3lcyihxo4ugG+fDBOGMAc4XV5pXz1BAnvwOKt9oq8rWhlsjvMX3s3YQ4iGmmUjInJJT6rK3W1DBYQ0rxhoWT+sdLBsKdQK9BRMOEGj/Og2T74O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852565; c=relaxed/simple;
	bh=JPeaMZtvPrn4JDeyPvd8OGnQClDxkNnfU1n1HQ0I+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf52xrtPHdIH4P91w4IeA7GcbG9uU8rtRWl7taJ5fdV5CSiUB2ECUhvThzuJrUfu3F+vgzcYFUtNWAoUS2kBU8ndGMPjMi7a008hG/XOts66dgV2NyoQTmZ6zm7vlVHqpAIwS/+vWeO4llsDYIy+pOBzPh655uW/g+5QooCIMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TxI7E3/S; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Dec 2025 10:35:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765852550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14Qnu6glJrs2grpIMzCNPU4lzsGBr4BJiAY7oS1kvoU=;
	b=TxI7E3/S7+4rZCQiKf2z+nSpsjXv+tW2r+ReSrfzDPjxW8ym0KAf3HLlrO8k+fZMNghWQg
	rsDmHDr7bfSLTfChuKT90dtdQvKT0wF57vu4O49CYaMNzdreB68BU/fx8kIu4+OHg+7LnB
	RuSslJFJZoAwtcWSqNWEcv+ik+jJNM4=
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
Subject: Re: [PATCH RFC 14/19] slab: simplify kmalloc_nolock()
Message-ID: <4ukrk3ziayvxrcfxm2izwrwt3qrmr4fcsefl4n7oodc4t2hxgt@ijk63r4f3rkr>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-14-6ffa2c9941c0@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-sheaves-for-all-v1-14-6ffa2c9941c0@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 23, 2025 at 03:52:36PM +0200, Vlastimil Babka wrote:
> The kmalloc_nolock() implementation has several complications and
> restrictions due to SLUB's cpu slab locking, lockless fastpath and
> PREEMPT_RT differences. With cpu slab usage removed, we can simplify
> things:
> 
> - the local_lock_cpu_slab() macros became unused, remove them
> 
> - we no longer need to set up lockdep classes on PREEMPT_RT
> 
> - we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
>   since there's no lockless cpu freelist manipulation anymore
> 
> - __slab_alloc_node() can be called from kmalloc_nolock_noprof()
>   unconditionally
> 
> Note that we still need __CMPXCHG_DOUBLE, because while it was removed
> we don't use cmpxchg16b on cpu freelist anymore, we still use it on
> slab freelist, and the alternative is slab_lock() which can be
> interrupted by a nmi. Clarify the comment to mention it specifically.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h |   1 -
>  mm/slub.c | 100 ++++----------------------------------------------------------
>  2 files changed, 6 insertions(+), 95 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index b2663cc594f3..7dde0b56a7b0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -208,7 +208,6 @@ struct kmem_cache_order_objects {
>   */
>  struct kmem_cache {
>  	struct kmem_cache_cpu __percpu *cpu_slab;
> -	struct lock_class_key lock_key;
>  	struct slub_percpu_sheaves __percpu *cpu_sheaves;
>  	/* Used for retrieving partial slabs, etc. */
>  	slab_flags_t flags;
> diff --git a/mm/slub.c b/mm/slub.c
> index 6f5ca26bbb00..6dd7fd153391 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3679,29 +3679,12 @@ static inline unsigned int init_tid(int cpu)
>  
>  static void init_kmem_cache_cpus(struct kmem_cache *s)
>  {
> -#ifdef CONFIG_PREEMPT_RT
> -	/*
> -	 * Register lockdep key for non-boot kmem caches to avoid
> -	 * WARN_ON_ONCE(static_obj(key))) in lockdep_register_key()
> -	 */
> -	bool finegrain_lockdep = !init_section_contains(s, 1);
> -#else
> -	/*
> -	 * Don't bother with different lockdep classes for each
> -	 * kmem_cache, since we only use local_trylock_irqsave().
> -	 */
> -	bool finegrain_lockdep = false;
> -#endif
>  	int cpu;
>  	struct kmem_cache_cpu *c;
>  
> -	if (finegrain_lockdep)
> -		lockdep_register_key(&s->lock_key);
>  	for_each_possible_cpu(cpu) {
>  		c = per_cpu_ptr(s->cpu_slab, cpu);
>  		local_trylock_init(&c->lock);
> -		if (finegrain_lockdep)
> -			lockdep_set_class(&c->lock, &s->lock_key);
>  		c->tid = init_tid(cpu);
>  	}
>  }
> @@ -3792,47 +3775,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	}
>  }
>  
> -/*
> - * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
> - * can be acquired without a deadlock before invoking the function.
> - *
> - * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
> - * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
> - * and kmalloc() is not used in an unsupported context.
> - *
> - * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
> - * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
> - * lockdep_assert() will catch a bug in case:
> - * #1
> - * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
> - * or
> - * #2
> - * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
> - *
> - * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
> - * disabled context. The lock will always be acquired and if needed it
> - * block and sleep until the lock is available.
> - * #1 is possible in !PREEMPT_RT only.
> - * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
> - * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> - *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
> - *
> - * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
> - */
> -#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
> -#define local_lock_cpu_slab(s, flags)	\
> -	local_lock_irqsave(&(s)->cpu_slab->lock, flags)
> -#else
> -#define local_lock_cpu_slab(s, flags)					       \
> -	do {								       \
> -		bool __l = local_trylock_irqsave(&(s)->cpu_slab->lock, flags); \
> -		lockdep_assert(__l);					       \
> -	} while (0)
> -#endif
> -
> -#define local_unlock_cpu_slab(s, flags)	\
> -	local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
> -
>  static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
>  {
>  	unsigned long flags;
> @@ -4320,19 +4262,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  	return freelist;
>  }
> -/*
> - * We disallow kprobes in ___slab_alloc() to prevent reentrance
> - *
> - * kmalloc() -> ___slab_alloc() -> local_lock_cpu_slab() protected part of
> - * ___slab_alloc() manipulating c->freelist -> kprobe -> bpf ->
> - * kmalloc_nolock() or kfree_nolock() -> __update_cpu_freelist_fast()
> - * manipulating c->freelist without lock.
> - *
> - * This does not prevent kprobe in functions called from ___slab_alloc() such as
> - * local_lock_irqsave() itself, and that is fine, we only need to protect the
> - * c->freelist manipulation in ___slab_alloc() itself.
> - */
> -NOKPROBE_SYMBOL(___slab_alloc);
>  
>  static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
>  		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> @@ -5201,10 +5130,11 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>  		/*
>  		 * kmalloc_nolock() is not supported on architectures that
> -		 * don't implement cmpxchg16b, but debug caches don't use
> -		 * per-cpu slab and per-cpu partial slabs. They rely on
> -		 * kmem_cache_node->list_lock, so kmalloc_nolock() can
> -		 * attempt to allocate from debug caches by
> +		 * don't implement cmpxchg16b and thus need slab_lock()
> +		 * which could be preempted by a nmi.
> +		 * But debug caches don't use that and only rely on
> +		 * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
> +		 * to allocate from debug caches by
>  		 * spin_trylock_irqsave(&n->list_lock, ...)
>  		 */
>  		return NULL;
> @@ -5214,27 +5144,13 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  	if (ret)
>  		goto success;
>  
> -	ret = ERR_PTR(-EBUSY);
> -
>  	/*
>  	 * Do not call slab_alloc_node(), since trylock mode isn't
>  	 * compatible with slab_pre_alloc_hook/should_failslab and
>  	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
>  	 * and slab_post_alloc_hook() directly.
> -	 *
> -	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> -	 * in irq saved region. It assumes that the same cpu will not
> -	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
> -	 * Therefore use in_nmi() to check whether particular bucket is in
> -	 * irq protected section.
> -	 *
> -	 * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
> -	 * this cpu was interrupted somewhere inside ___slab_alloc() after
> -	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
> -	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
>  	 */
> -	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> -		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
> +	ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
>  
>  	if (PTR_ERR(ret) == -EBUSY) {

After Patch 10 is applied, the logic that returns `EBUSY` has been
removed along with the `s->cpu_slab` logic. As a result, it appears that
`__slab_alloc_node` will no longer return `EBUSY`.

>  		if (can_retry) {
> @@ -7250,10 +7166,6 @@ void __kmem_cache_release(struct kmem_cache *s)
>  {
>  	cache_random_seq_destroy(s);
>  	pcs_destroy(s);
> -#ifdef CONFIG_PREEMPT_RT
> -	if (s->cpu_slab)
> -		lockdep_unregister_key(&s->lock_key);
> -#endif
>  	free_percpu(s->cpu_slab);
>  	free_kmem_cache_nodes(s);
>  }
> 
> -- 
> 2.51.1
> 

