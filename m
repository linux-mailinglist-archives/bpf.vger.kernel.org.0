Return-Path: <bpf+bounces-62903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA471AFFE42
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DFE17E4C8
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93982D3ED0;
	Thu, 10 Jul 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3HtqvJiN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvj8PJKv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3HtqvJiN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvj8PJKv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D720B80A
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140172; cv=none; b=IDDI1JgRq1vlA/cCiuxm05ASIo3xhcxrCCTlyskiAv4ncdJ1CI1J5tPU8ZPdr1FsrTk1em30I+JZ5aSisoeyIFtFHgme992Pepr1o4u7kaeUST4cKp9ZCGP+RmFI+PGLtEiY2Lt7geYpASkHQEBKuIBK84xsDeZtUpzwGUtzAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140172; c=relaxed/simple;
	bh=6SZNizaL3I4WJZ8Se2ri22OE98lYH9tqo9ReUXi0as8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ru4ie6TZRpYUrrTpEU0+kgMtyIKiLnYwXFPtZgcIScfvdsA/QU0IVHPnOpruh24nCmgen/T9+iShH4nuGoZpllvYK+tHwVLlg/9JcdIyBg6ns/MksgtJRfGaJhZ36c0yvbjDc8QZqbvYWQLaSLvvFclc4x+A6lnrQOH5dmMpMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3HtqvJiN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvj8PJKv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3HtqvJiN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvj8PJKv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73C341F385;
	Thu, 10 Jul 2025 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752140162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lHlXzHrcGn58ullX7mpSkYhYsJW7eBCgiba+w6ctkC0=;
	b=3HtqvJiN+Z3PjcIgUkzb38HqmsQ43S0ycLfcMBcpziZVjnB2YsD4KjogmxtPYqMxqq+gmj
	KH44cPNJGYXwIspY8+lCIeIrLERkG5RBRRLLHR2zc+QNr08xrBmiPMankfLDGd2J4zF49q
	QIcj1NiO9iMY/14BlSjuLk74Ek1eHJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752140162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lHlXzHrcGn58ullX7mpSkYhYsJW7eBCgiba+w6ctkC0=;
	b=zvj8PJKvVGtETVhwaFIe3bz8w9YOlMakWB7VRO1wEDQ9knm+UNaK2G3QxTpVmvddGhWdrB
	8i6f/GpfvAOfa8Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752140162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lHlXzHrcGn58ullX7mpSkYhYsJW7eBCgiba+w6ctkC0=;
	b=3HtqvJiN+Z3PjcIgUkzb38HqmsQ43S0ycLfcMBcpziZVjnB2YsD4KjogmxtPYqMxqq+gmj
	KH44cPNJGYXwIspY8+lCIeIrLERkG5RBRRLLHR2zc+QNr08xrBmiPMankfLDGd2J4zF49q
	QIcj1NiO9iMY/14BlSjuLk74Ek1eHJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752140162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lHlXzHrcGn58ullX7mpSkYhYsJW7eBCgiba+w6ctkC0=;
	b=zvj8PJKvVGtETVhwaFIe3bz8w9YOlMakWB7VRO1wEDQ9knm+UNaK2G3QxTpVmvddGhWdrB
	8i6f/GpfvAOfa8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D358136CB;
	Thu, 10 Jul 2025 09:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EOifEYKJb2g2TwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Jul 2025 09:36:02 +0000
Message-ID: <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
Date: Thu, 10 Jul 2025 11:36:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250709015303.8107-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 7/9/25 03:53, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_lock to detect the situation
> when it's locked.
> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
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

>  static __fastpath_inline
> @@ -2442,13 +2453,17 @@ static void *setup_object(struct kmem_cache *s, void *object)
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
> +		folio = (struct folio *)alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
> +								  node, order);
> +	} else if (node == NUMA_NO_NODE)
>  		folio = (struct folio *)alloc_frozen_pages(flags, order);
>  	else
>  		folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);

Nit: should use { } either for everything or nothing (seems your new branch
would work without them)

>  			stat(s, ALLOC_NODE_MISMATCH);
> @@ -3730,7 +3762,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	 * PFMEMALLOC but right now, we are losing the pfmemalloc
>  	 * information when the page leaves the per-cpu allocator
>  	 */
> -	if (unlikely(!pfmemalloc_match(slab, gfpflags)))
> +	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))
>  		goto deactivate_slab;
>  
>  	/* must check again c->slab in case we got preempted and it changed */
> @@ -3803,7 +3835,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		slub_set_percpu_partial(c, slab);
>  
>  		if (likely(node_match(slab, node) &&
> -			   pfmemalloc_match(slab, gfpflags))) {
> +			   pfmemalloc_match(slab, gfpflags)) ||
> +		    /*
> +		     * Reentrant slub cannot take locks necessary
> +		     * for __put_partials(), hence downgrade to any node
> +		     */
> +		    !allow_spin) {

Uh this seems rather ugly, I'd move the comment above everything. Also it's
not "downgrade" as when you assign NUMA_NO_NODE earlier, I'd say "ignore the
preference".
Note that it would be bad to ignore with __GFP_THISNODE but then it's not
allowed for kmalloc_nolock() so that's fine.

> @@ -3911,6 +3953,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		void *flush_freelist = c->freelist;
>  		struct slab *flush_slab = c->slab;
>  
> +		if (unlikely(!allow_spin))
> +			/*
> +			 * Reentrant slub cannot take locks
> +			 * necessary for deactivate_slab()
> +			 */
> +			return NULL;

Hm but this is leaking the slab we allocated and have in the "slab"
variable, we need to free it back in that case.

>  		c->slab = NULL;
>  		c->freelist = NULL;
>  		c->tid = next_tid(c->tid);

> @@ -4593,10 +4792,31 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	barrier();
>  
>  	if (unlikely(slab != c->slab)) {
> -		__slab_free(s, slab, head, tail, cnt, addr);
> +		/* cnt == 0 signals that it's called from kfree_nolock() */
> +		if (unlikely(!cnt)) {
> +			/*
> +			 * __slab_free() can locklessly cmpxchg16 into a slab,
> +			 * but then it might need to take spin_lock or local_lock
> +			 * in put_cpu_partial() for further processing.
> +			 * Avoid the complexity and simply add to a deferred list.
> +			 */
> +			defer_free(head);
> +		} else {
> +			__slab_free(s, slab, head, tail, cnt, addr);
> +		}
>  		return;
>  	}
>  
> +	if (unlikely(!cnt)) {
> +		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> +		    local_lock_is_locked(&s->cpu_slab->lock)) {
> +			defer_free(head);
> +			return;
> +		}
> +		cnt = 1;

Hmm we might end up doing a "goto redo" later and then do the wrong thing above?

> +		kasan_slab_free(s, head, false, false, /* skip quarantine */true);
> +	}
> +
>  	if (USE_LOCKLESS_FAST_PATH()) {
>  		freelist = READ_ONCE(c->freelist);
>  

