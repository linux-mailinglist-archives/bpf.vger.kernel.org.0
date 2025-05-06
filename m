Return-Path: <bpf+bounces-57509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1091AAC353
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F96A3AA691
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357327E1B2;
	Tue,  6 May 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/HzpAO9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yp0PF/sN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/HzpAO9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yp0PF/sN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB827D789
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532913; cv=none; b=q0wD+ZwC4t56Zc3b6cgyrrtu+82QwUvjVYPF8QTze59GqM5ZMuglEYbGjj0+FVbAWXCtG9S2Wfq1dSdmiSYLo6FBu/D+3Ry19KU8JPjzaM98XgLPaQPnfWfnlcuVC2MXL0l+9zTG3nJ4mOJ1o5TO6we7lmg+97wm98X1/4ajL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532913; c=relaxed/simple;
	bh=Y7LOi+Qr2ghCw+OypALqBTloC9GTAf05PDDqyvn8UmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPTM3Fkr53EmbHigcEcWC7EY7gnjk5AdGUVTlkTCOk7RTUbrpFJXzwvbrdIA+Q0bAPs+M+S2csDA7P9Q45rqCaQJKqKnk7jQOK3QcYjDAaKme1VhC3GRXwnP97NyTwbvplUXPfg04hVj7Bhz1UJsCV5zhrLxJfmbYnJy6ge+BOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/HzpAO9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yp0PF/sN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/HzpAO9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yp0PF/sN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 661B11F395;
	Tue,  6 May 2025 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746532909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy10q/chmakb6t9Knn2dhtwHUF+2eAGNL0MO5J+fUKQ=;
	b=G/HzpAO9a77uWas87rhcWkQdrVmO8BmJEC6hkVlquIbnbCIdc/phAXo9guo6ZV1vpJWG4n
	9dqOj38cSwJ/dblFJNTuWoQZS71yhoIZplm/o1oYfQy5gnsm52576jUtDE7JzPMKVwYIXL
	re25/ZBqpkj1ShbvMfhQRmJ+Gg885qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746532909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy10q/chmakb6t9Knn2dhtwHUF+2eAGNL0MO5J+fUKQ=;
	b=Yp0PF/sNUDw78/z+B5hmsAB50i4QYaE+SYAD6o5V6XtqD6OLgHo8mW69G/JNh8hPTgpZ/U
	8dos3bo4lhE0zRBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="G/HzpAO9";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Yp0PF/sN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746532909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy10q/chmakb6t9Knn2dhtwHUF+2eAGNL0MO5J+fUKQ=;
	b=G/HzpAO9a77uWas87rhcWkQdrVmO8BmJEC6hkVlquIbnbCIdc/phAXo9guo6ZV1vpJWG4n
	9dqOj38cSwJ/dblFJNTuWoQZS71yhoIZplm/o1oYfQy5gnsm52576jUtDE7JzPMKVwYIXL
	re25/ZBqpkj1ShbvMfhQRmJ+Gg885qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746532909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy10q/chmakb6t9Knn2dhtwHUF+2eAGNL0MO5J+fUKQ=;
	b=Yp0PF/sNUDw78/z+B5hmsAB50i4QYaE+SYAD6o5V6XtqD6OLgHo8mW69G/JNh8hPTgpZ/U
	8dos3bo4lhE0zRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 401AF137CF;
	Tue,  6 May 2025 12:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 15XXDS36GWidIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 May 2025 12:01:49 +0000
Message-ID: <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
Date: Tue, 6 May 2025 14:01:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250501032718.65476-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 661B11F395
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 5/1/25 05:27, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_lock to detect the situation
> when it's locked.
> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> In that case retry the operation in a different kmalloc bucket.
> The second attempt will likely succeed, since this cpu locked
> different kmem_cache_cpu.
> When lock_local_is_locked() sees locked memcg_stock.stock_lock
> fallback to atomic operations.
> 
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> a different bucket that is most likely is not locked by current
> task. Though it may be locked by a different task it's safe to
> rt_spin_lock() on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

In general I'd prefer if we could avoid local_lock_is_locked() usage outside
of debugging code. It just feels hacky given we have local_trylock()
operations. But I can see how this makes things simpler so it's probably
acceptable.

> @@ -2458,13 +2468,21 @@ static void *setup_object(struct kmem_cache *s, void *object)
>   * Slab allocation and freeing
>   */
>  static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> -		struct kmem_cache_order_objects oo)
> +					   struct kmem_cache_order_objects oo,
> +					   bool allow_spin)
>  {
>  	struct folio *folio;
>  	struct slab *slab;
>  	unsigned int order = oo_order(oo);
>  
> -	if (node == NUMA_NO_NODE)
> +	if (unlikely(!allow_spin)) {
> +		struct page *p = alloc_pages_nolock(__GFP_COMP, node, order);
> +
> +		if (p)
> +			/* Make the page frozen. Drop refcnt to zero. */
> +			put_page_testzero(p);

This is dangerous. Once we create a refcounted (non-frozen) page, someone
else (a pfn scanner like compaction) can do a get_page_unless_zero(), so the
refcount becomes 2, then we decrement the refcount here to 1, the pfn
scanner realizes it's not a page it can work with, do put_page() and frees
it under us.

The solution is to split out alloc_frozen_pages_nolock() to use from here,
and make alloc_pages_nolock() use it too and then set refcounted.

> +		folio = (struct folio *)p;
> +	} else if (node == NUMA_NO_NODE)
>  		folio = (struct folio *)alloc_frozen_pages(flags, order);
>  	else
>  		folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);

<snip>

> @@ -3958,8 +3989,28 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	 */
>  	c = slub_get_cpu_ptr(s->cpu_slab);
>  #endif
> +	if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
> +		struct slab *slab;
> +
> +		slab = c->slab;
> +		if (slab && !node_match(slab, node))
> +			/* In trylock mode numa node is a hint */
> +			node = NUMA_NO_NODE;
> +
> +		if (!local_lock_is_locked(&s->cpu_slab->lock)) {
> +			lockdep_assert_not_held(this_cpu_ptr(&s->cpu_slab->lock));
> +		} else {
> +			/*
> +			 * EBUSY is an internal signal to kmalloc_nolock() to
> +			 * retry a different bucket. It's not propagated further.
> +			 */
> +			p = ERR_PTR(-EBUSY);
> +			goto out;

Am I right in my reasoning as follows?

- If we're on RT and "in_nmi() || in_hardirq()" is true then
kmalloc_nolock_noprof() would return NULL immediately and we never reach
this code

- local_lock_is_locked() on RT tests if the current process is the lock
owner. This means (in absence of double locking bugs) that we locked it as
task (or hardirq) and now we're either in_hardirq() (doesn't change current
AFAIK?) preempting task, or in_nmi() preempting task or hardirq.

- so local_lock_is_locked() will never be true here on RT

> +		}
> +	}
>  
>  	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> +out:
>  #ifdef CONFIG_PREEMPT_COUNT
>  	slub_put_cpu_ptr(s->cpu_slab);
>  #endif
> @@ -4162,8 +4213,9 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  		if (p[i] && init && (!kasan_init ||
>  				     !kasan_has_integrated_init()))
>  			memset(p[i], 0, zero_size);
> -		kmemleak_alloc_recursive(p[i], s->object_size, 1,
> -					 s->flags, init_flags);
> +		if (gfpflags_allow_spinning(flags))
> +			kmemleak_alloc_recursive(p[i], s->object_size, 1,
> +						 s->flags, init_flags);
>  		kmsan_slab_alloc(s, p[i], init_flags);
>  		alloc_tagging_slab_alloc_hook(s, p[i], flags);
>  	}
> @@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);
>  
> +/**
> + * kmalloc_nolock - Allocate an object of given size from any context.
> + * @size: size to allocate
> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> + * @node: node number of the target node.
> + *
> + * Return: pointer to the new object or NULL in case of error.
> + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> + * There is no reason to call it again and expect !NULL.
> + */
> +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> +{
> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> +	struct kmem_cache *s;
> +	bool can_retry = true;
> +	void *ret = ERR_PTR(-EBUSY);
> +
> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> +
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return NULL;
> +	if (unlikely(!size))
> +		return ZERO_SIZE_PTR;
> +
> +	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
> +		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> +		return NULL;
> +retry:
> +	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);

The idea of retrying on different bucket is based on wrong assumptions and
thus won't work as you expect. kmalloc_slab() doesn't select buckets truly
randomly, but deterministically via hashing from a random per-boot seed and
the _RET_IP_, as the security hardening goal is to make different kmalloc()
callsites get different caches with high probability.

And I wouldn't also recommend changing this for kmalloc_nolock_noprof() case
as that could make the hardening weaker, and also not help for kernels that
don't have it enabled, anyway.

> +
> +	if (!(s->flags & __CMPXCHG_DOUBLE))
> +		/*
> +		 * kmalloc_nolock() is not supported on architectures that
> +		 * don't implement cmpxchg16b.
> +		 */
> +		return NULL;
> +
> +	/*
> +	 * Do not call slab_alloc_node(), since trylock mode isn't
> +	 * compatible with slab_pre_alloc_hook/should_failslab and
> +	 * kfence_alloc.
> +	 *
> +	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> +	 * in irq saved region. It assumes that the same cpu will not
> +	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
> +	 * Therefore use in_nmi() to check whether particular bucket is in
> +	 * irq protected section.
> +	 */
> +	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> +		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);

Hm this is somewhat subtle. We're testing the local lock without having the
cpu explicitly pinned. But the test only happens in_nmi() which implicitly
is a context that won't migrate, so should work I think, but maybe should be
more explicit in the comment?

<snip>

>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
>   * can perform fastpath freeing without additional function calls.
> @@ -4605,10 +4762,36 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	barrier();
>  
>  	if (unlikely(slab != c->slab)) {

Note this unlikely() is actually a lie. It's actually unlikely that the free
will happen on the same cpu and with the same slab still being c->slab,
unless it's a free following shortly a temporary object allocation.

> -		__slab_free(s, slab, head, tail, cnt, addr);
> +		/* cnt == 0 signals that it's called from kfree_nolock() */
> +		if (unlikely(!cnt)) {
> +			/*
> +			 * Use llist in cache_node ?
> +			 * struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> +			 */
> +			/*
> +			 * __slab_free() can locklessly cmpxchg16 into a slab,
> +			 * but then it might need to take spin_lock or local_lock
> +			 * in put_cpu_partial() for further processing.
> +			 * Avoid the complexity and simply add to a deferred list.
> +			 */
> +			llist_add(head, &s->defer_free_objects);
> +		} else {
> +			free_deferred_objects(&s->defer_free_objects, addr);

So I'm a bit vary that this is actually rather a fast path that might
contend on the defer_free_objects from all cpus.

I'm wondering if we could make the list part of kmem_cache_cpu to distribute
it, and hook the flushing e.g. to places where we do deactivate_slab() which
should be much slower path, and also free_to_partial_list() to handle
SLUB_TINY/caches with debugging enabled.

> +			__slab_free(s, slab, head, tail, cnt, addr);
> +		}
>  		return;
>  	}
>  
> +	if (unlikely(!cnt)) {
> +		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> +		    local_lock_is_locked(&s->cpu_slab->lock)) {
> +			llist_add(head, &s->defer_free_objects);
> +			return;
> +		}
> +		cnt = 1;
> +		kasan_slab_free(s, head, false, false, true);
> +	}
> +
>  	if (USE_LOCKLESS_FAST_PATH()) {
>  		freelist = READ_ONCE(c->freelist);
>  

