Return-Path: <bpf+bounces-63423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14670B0741A
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1890A4E7375
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AC2F2C7B;
	Wed, 16 Jul 2025 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gUyunF6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4FtoyN+k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ESzTp5C3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BTaS6WmR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F8194A60
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663489; cv=none; b=atAqiXWyoRelp9+VcGE2CwmhheOuzbNVQY3pxwMYwx0788lSSLqFvrgt4+gHARQlNq11C/Cao4sBHnn5AECSwGv+AB6bCSLjzTaWUAHuyXwsrbxlhk68QQMfGh9a5t65K76fXKOJOIMDeVU4vQ2mbgKdTsMdenBtzlvUjnxlUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663489; c=relaxed/simple;
	bh=Mlyl4xI8JtpCHLOYKXiLUR+T8wqV40vrH257a6qW5ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dh/ZYpzgILnsCxloizBP4QkBpS8dnwo9qf4yQkMxiK3kLrzcu+N5ifXM86cg4WTBOlvJMK1QWjGdgId4TE1TKeCqBV0m0p/s88wFbxJlYA/s4i8xGOTgdOuh+O2C9ZVXikSLRN8NjmEmmpnvwUL3IywziMHaAjKgJORFzqBOaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gUyunF6V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4FtoyN+k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ESzTp5C3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BTaS6WmR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0793A21272;
	Wed, 16 Jul 2025 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752663483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WKxxRROorBCL6lJNdzPEBZy8XAVPM0HA47Lnk062zX0=;
	b=gUyunF6VSa/DqwWzIc5IJAnL9n7XDSnJdvAX6QiJbHChXIlAxDl7z82KW9Lc3CtUkYHsE2
	qFSr7kebsVDTFFFneE8ZphoTq85pMIxchQZbKMFzxX1UVmy22PcUGjdw9p+bHXno335D8W
	/if0Q+axiO2OK0lXa4AswN0gSSN+44M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752663483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WKxxRROorBCL6lJNdzPEBZy8XAVPM0HA47Lnk062zX0=;
	b=4FtoyN+ksUw4SIVn9y9XA2NBZcmBaSlwkvtdrJcpy6jzfpBwRZzhUYPiW/zLcmczjDTA/j
	4YtakH/MlgdRsZDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ESzTp5C3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BTaS6WmR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752663482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WKxxRROorBCL6lJNdzPEBZy8XAVPM0HA47Lnk062zX0=;
	b=ESzTp5C3vkOaHN1jTlTjnDPfjAd7nKqZ94khB2nNr32I1HFK5J5ZCP/mGAL442IYuOetIY
	E2ctmSW2lhItQIiOfdwmAZu0AuWYnIMumvXxGYpw1dfd366r58AzFa8bdqiTSM8gHUps8t
	Qix9UDE4IhcfceQ1NInq06NVpTZBY+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752663482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WKxxRROorBCL6lJNdzPEBZy8XAVPM0HA47Lnk062zX0=;
	b=BTaS6WmRF+TioyPmotlBpqvwdIJUdxxk2oljNWI7PMcQzvbOCE5r8KNQ5KS/mwp1UlaFUD
	/e0VfsYxe93fsqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE20F13306;
	Wed, 16 Jul 2025 10:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J76bNbmFd2hCRgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Jul 2025 10:58:01 +0000
Message-ID: <a28390e4-23cf-4615-93e3-611b046e1973@suse.cz>
Date: Wed, 16 Jul 2025 12:58:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250716022950.69330-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0793A21272
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 7/16/25 04:29, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_lock to detect the situation

					^ local_trylock_t perhaps?

> when it's locked.
> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.

It can be also true when you call it from the bpf hook, no?

> In that case retry the operation in a different kmalloc bucket.
> The second attempt will likely succeed, since this cpu locked
> different kmem_cache_cpu.
> 
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> a different bucket that is most likely is not locked by the current
> task. Though it may be locked by a different task it's safe to
> rt_spin_lock() on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> and in_nmi() or in PREEMPT_RT.
> 
> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> always defers to irq_work.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Haven't seen an obvious bug now but will ponder it some more. Meanwhile some
nits and maybe one bit more serious concern.

> +static inline void local_lock_cpu_slab(struct kmem_cache *s, unsigned long *flags)
> +{
> +	/*
> +	 * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
> +	 * can be acquired without a deadlock before invoking the function.
> +	 *
> +	 * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
> +	 * disabled context. The lock will always be acquired and if needed it
> +	 * block and sleep until the lock is available.
> +	 *
> +	 * On !PREEMPT_RT allocations from any context but NMI are safe. The lock
> +	 * is always acquired with disabled interrupts meaning it is always
> +	 * possible to it.
> +	 * In NMI context it is needed to check if the lock is acquired. If it is not,

This also could mention the bpf instrumentation context?

> +	 * it is safe to acquire it. The trylock semantic is used to tell lockdep
> +	 * that we don't spin. The BUG_ON() will not trigger if it is safe to acquire
> +	 * the lock.
> +	 *
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags));

Linus might still spot the BUG_ON() and complain, lockdep_assert() would be
safer maybe :)
Or just use local_lock_irqsave() with !CONFIG_LOCKDEP as well.

Nit: maybe could be a #define to avoid the unusual need for "&flags" instead
of "flags" when calling.

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
> +	if (unlikely(!size))
> +		return ZERO_SIZE_PTR;
> +
> +	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))

Nit: maybe just due explicit PREEMPT_RT checks when the code isn't about
lockless fastpaths,

> +		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> +		return NULL;
> +retry:
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return NULL;
> +	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> +
> +	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> +		/*
> +		 * kmalloc_nolock() is not supported on architectures that
> +		 * don't implement cmpxchg16b, but debug caches don't use
> +		 * per-cpu slab and per-cpu partial slabs. They rely on
> +		 * kmem_cache_node->list_lock, so kmalloc_nolock() can
> +		 * attempt to allocate from debug caches by
> +		 * spin_trylock_irqsave(&n->list_lock, ...)
> +		 */
> +		return NULL;
> +
> +	/*
> +	 * Do not call slab_alloc_node(), since trylock mode isn't
> +	 * compatible with slab_pre_alloc_hook/should_failslab and
> +	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
> +	 * and slab_post_alloc_hook() directly.
> +	 *
> +	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> +	 * in irq saved region. It assumes that the same cpu will not
> +	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
> +	 * Therefore use in_nmi() to check whether particular bucket is in
> +	 * irq protected section.
> +	 *
> +	 * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
> +	 * this cpu was interrupted somewhere inside ___slab_alloc() after
> +	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
> +	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
> +	 */
> +#ifndef CONFIG_SLUB_TINY
> +	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> +#endif
> +		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);

Nit: use IS_DEFINED(CONFIG_SLUB_TINY) to make this look better?

> +static void defer_deactivate_slab(struct slab *slab)
> +{

Nit: for more consistency this could thake the freelist argument and assign
it here, and not in the caller.

> +	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
> +
> +	if (llist_add(&slab->llnode, &df->slabs))
> +		irq_work_queue(&df->work);
> +}
> +
> +void defer_free_barrier(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
> +}
> +
>  #ifndef CONFIG_SLUB_TINY
>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
> @@ -4575,6 +4857,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  				struct slab *slab, void *head, void *tail,
>  				int cnt, unsigned long addr)
>  {
> +	/* cnt == 0 signals that it's called from kfree_nolock() */
> +	bool allow_spin = cnt;
>  	struct kmem_cache_cpu *c;
>  	unsigned long tid;
>  	void **freelist;
> @@ -4593,10 +4877,30 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	barrier();
>  
>  	if (unlikely(slab != c->slab)) {
> -		__slab_free(s, slab, head, tail, cnt, addr);
> +		if (unlikely(!allow_spin)) {
> +			/*
> +			 * __slab_free() can locklessly cmpxchg16 into a slab,
> +			 * but then it might need to take spin_lock or local_lock
> +			 * in put_cpu_partial() for further processing.
> +			 * Avoid the complexity and simply add to a deferred list.
> +			 */
> +			defer_free(s, head);
> +		} else {
> +			__slab_free(s, slab, head, tail, cnt, addr);
> +		}
>  		return;
>  	}
>  
> +	if (unlikely(!allow_spin)) {
> +		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&

Same nit about USE_LOCKLESS_FAST_PATH

> +		    local_lock_is_locked(&s->cpu_slab->lock)) {
> +			defer_free(s, head);
> +			return;
> +		}
> +		cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
> +		kasan_slab_free(s, head, false, false, /* skip quarantine */true);
> +	}
> +
>  	if (USE_LOCKLESS_FAST_PATH()) {
>  		freelist = READ_ONCE(c->freelist);
>  
> @@ -4607,8 +4911,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  			goto redo;
>  		}
>  	} else {
> +		__maybe_unused long flags = 0;
> +
>  		/* Update the free list under the local lock */
> -		local_lock(&s->cpu_slab->lock);
> +		local_lock_cpu_slab(s, &flags);
>  		c = this_cpu_ptr(s->cpu_slab);
>  		if (unlikely(slab != c->slab)) {
>  			local_unlock(&s->cpu_slab->lock);
> @@ -4621,7 +4927,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  		c->freelist = head;
>  		c->tid = next_tid(tid);
>  
> -		local_unlock(&s->cpu_slab->lock);
> +		local_unlock_cpu_slab(s, &flags);
>  	}
>  	stat_add(s, FREE_FASTPATH, cnt);
>  }
> @@ -4844,6 +5150,62 @@ void kfree(const void *object)
>  }
>  EXPORT_SYMBOL(kfree);
>  
> +/*
> + * Can be called while holding raw_spinlock_t or from IRQ and NMI,
> + * but only for objects allocated by kmalloc_nolock(),
> + * since some debug checks (like kmemleak and kfence) were
> + * skipped on allocation. large_kmalloc is not supported either.
> + */
> +void kfree_nolock(const void *object)
> +{
> +	struct folio *folio;
> +	struct slab *slab;
> +	struct kmem_cache *s;
> +	void *x = (void *)object;
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(object)))
> +		return;
> +
> +	folio = virt_to_folio(object);
> +	if (unlikely(!folio_test_slab(folio))) {
> +		WARN(1, "Buggy usage of kfree_nolock");
> +		return;
> +	}
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +
> +	memcg_slab_free_hook(s, slab, &x, 1);
> +	alloc_tagging_slab_free_hook(s, slab, &x, 1);
> +	/*
> +	 * Unlike slab_free() do NOT call the following:
> +	 * kmemleak_free_recursive(x, s->flags);
> +	 * debug_check_no_locks_freed(x, s->object_size);
> +	 * debug_check_no_obj_freed(x, s->object_size);
> +	 * __kcsan_check_access(x, s->object_size, ..);
> +	 * kfence_free(x);
> +	 * since they take spinlocks.
> +	 */

So here's the bigger concern. What if someone allocates with regular
kmalloc() so that the debugging stuff is performed as usual, and then tries
to use kfree_nolock() whre we skip it? You might not be planning such usage,
but later someone can realize that only their freeing context is limited,
finds out kfree_nolock() exists and tries to use it?

Can we document this strongly enough? Or even enforce it somehow? Or when
any of these kinds of debugs above are enabled, we play it safe and use
defer_free()?

> +	kmsan_slab_free(s, x);
> +	/*
> +	 * If KASAN finds a kernel bug it will do kasan_report_invalid_free()
> +	 * which will call raw_spin_lock_irqsave() which is technically
> +	 * unsafe from NMI, but take chance and report kernel bug.
> +	 * The sequence of
> +	 * kasan_report_invalid_free() -> raw_spin_lock_irqsave() -> NMI
> +	 *  -> kfree_nolock() -> kasan_report_invalid_free() on the same CPU
> +	 * is double buggy and deserves to deadlock.
> +	 */
> +	if (kasan_slab_pre_free(s, x))
> +		return;
> +#ifndef CONFIG_SLUB_TINY
> +	do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +#else
> +	defer_free(s, x);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(kfree_nolock);
> +
>  static __always_inline __realloc_size(2) void *
>  __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  {


