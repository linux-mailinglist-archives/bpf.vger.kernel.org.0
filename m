Return-Path: <bpf+bounces-48923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF57A1225B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 12:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C039B3A64A3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBA1E98F2;
	Wed, 15 Jan 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxQxyKGj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7KZeIYFE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxQxyKGj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7KZeIYFE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A11ACE12
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939972; cv=none; b=iIsPFsZiGjuk/9aWNtccvZ7nlKpMlU9b4jGV+Ufwe9hiX3AF3WHMy+za1RcexDhtsQLhs5acPgsoBK4AdpTFhttGecamo3sCS6hL6YUtBx1mn/iJL9ty4HcaOzZp+w2jAD6se2Jpucmra7k1mR7aXLXFrrxt1PFEwQqVkWLufk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939972; c=relaxed/simple;
	bh=kgL1wJx0mgcgDPHpr0+Afp94lNbpiGizetAEU16NDRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkm/i9pKbHQwqZ8PQ/wVgpCah6QCFo7slRr3xhNvyC3TE0Jc1j9Hi0KelQF+Jmj8HqMGKRSZ1F9YKf9CDNQeOU7QTPbSFGDWelTfxj9VnfiWnQ3XQjXFt/Lr26y7LrVumA2TzTT39+7zUr3Nf0mpCIY82PRxb/FdsHaGivCxyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxQxyKGj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7KZeIYFE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxQxyKGj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7KZeIYFE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 158841F786;
	Wed, 15 Jan 2025 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736939968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qgq7Sqi/qA/Tq0Ti2gdDhXcShCmwErnfJi0qC6lApXI=;
	b=zxQxyKGjKPdb2Zr8Uz0uJ1+JFJzC2zAwwqNvlX/ELGp9RnvOHLmYZwz4mHOXIZrCGB1/kG
	XJdP0hHutPjKSiAvL3vKCxcpIuYyMWk4FzoRF67m5RVvd56WoC9EqSNOg8oY7GDuoSVqTq
	zlyTJoKUK48x6Q6IbM9AZCRHRiUeFeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736939968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qgq7Sqi/qA/Tq0Ti2gdDhXcShCmwErnfJi0qC6lApXI=;
	b=7KZeIYFEgIpjODTohkRT4Ag3Onw+pdZMpsD+ih+w0/Wi9DDzlrlaCXKtfdpyaz/DSyhJuS
	r92orGl0wSrp0ECA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zxQxyKGj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7KZeIYFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736939968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qgq7Sqi/qA/Tq0Ti2gdDhXcShCmwErnfJi0qC6lApXI=;
	b=zxQxyKGjKPdb2Zr8Uz0uJ1+JFJzC2zAwwqNvlX/ELGp9RnvOHLmYZwz4mHOXIZrCGB1/kG
	XJdP0hHutPjKSiAvL3vKCxcpIuYyMWk4FzoRF67m5RVvd56WoC9EqSNOg8oY7GDuoSVqTq
	zlyTJoKUK48x6Q6IbM9AZCRHRiUeFeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736939968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qgq7Sqi/qA/Tq0Ti2gdDhXcShCmwErnfJi0qC6lApXI=;
	b=7KZeIYFEgIpjODTohkRT4Ag3Onw+pdZMpsD+ih+w0/Wi9DDzlrlaCXKtfdpyaz/DSyhJuS
	r92orGl0wSrp0ECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D54C13A6F;
	Wed, 15 Jan 2025 11:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mIgFGb+Zh2fqNwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Jan 2025 11:19:27 +0000
Message-ID: <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
Date: Wed, 15 Jan 2025 12:19:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-2-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250115021746.34691-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 158841F786
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 1/15/25 03:17, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs execute from tracepoints and kprobes where
> running context is unknown, but they need to request additional
> memory. The prior workarounds were using pre-allocated memory and
> BPF specific freelists to satisfy such allocation requests.
> Instead, introduce gfpflags_allow_spinning() condition that signals
> to the allocator that running context is unknown.
> Then rely on percpu free list of pages to allocate a page.
> try_alloc_pages() -> get_page_from_freelist() -> rmqueue() ->
> rmqueue_pcplist() will spin_trylock to grab the page from percpu
> free list. If it fails (due to re-entrancy or list being empty)
> then rmqueue_bulk()/rmqueue_buddy() will attempt to
> spin_trylock zone->lock and grab the page from there.
> spin_trylock() is not safe in RT when in NMI or in hard IRQ.
> Bailout early in such case.
> 
> The support for gfpflags_allow_spinning() mode for free_page and memcg
> comes in the next patches.
> 
> This is a first step towards supporting BPF requirements in SLUB
> and getting rid of bpf_mem_alloc.
> That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below:

> ---
>  include/linux/gfp.h | 22 ++++++++++
>  mm/internal.h       |  1 +
>  mm/page_alloc.c     | 98 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 118 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b0fe9f62d15b..b41bb6e01781 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -39,6 +39,25 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>  }
>  
> +static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
> +{
> +	/*
> +	 * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
> +	 * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
> +	 * All GFP_* flags including GFP_NOWAIT use one or both flags.
> +	 * try_alloc_pages() is the only API that doesn't specify either flag.
> +	 *
> +	 * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
> +	 * those are guaranteed to never block on a sleeping lock.
> +	 * Here we are enforcing that the allaaction doesn't ever spin

					  allocation

> +	 * on any locks (i.e. only trylocks). There is no highlevel
> +	 * GFP_$FOO flag for this use in try_alloc_pages() as the
> +	 * regular page allocator doesn't fully support this
> +	 * allocation mode.
> +	 */
> +	return !(gfp_flags & __GFP_RECLAIM);
> +}

This function seems unused, guess the following patches will use.

> @@ -4509,7 +4517,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>  
>  	might_alloc(gfp_mask);
>  
> -	if (should_fail_alloc_page(gfp_mask, order))
> +	if (!(*alloc_flags & ALLOC_TRYLOCK) &&
> +	    should_fail_alloc_page(gfp_mask, order))

Is it because should_fail_alloc_page() might take some lock or whatnot?
Maybe comment?

>  		return false;
>  
>  	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
> @@ -7023,3 +7032,86 @@ static bool __free_unaccepted(struct page *page)
>  }
>  
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
> +
> +/**
> + * try_alloc_pages_noprof - opportunistic reentrant allocation from any context
> + * @nid - node to allocate from
> + * @order - allocation order size
> + *
> + * Allocates pages of a given order from the given node. This is safe to
> + * call from any context (from atomic, NMI, and also reentrant
> + * allocator -> tracepoint -> try_alloc_pages_noprof).
> + * Allocation is best effort and to be expected to fail easily so nobody should
> + * rely on the success. Failures are not reported via warn_alloc().
> + *
> + * Return: allocated page or NULL on failure.
> + */
> +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> +{
> +	/*
> +	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
> +	 * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
> +	 * is not safe in arbitrary context.
> +	 *
> +	 * These two are the conditions for gfpflags_allow_spinning() being true.
> +	 *
> +	 * Specify __GFP_NOWARN since failing try_alloc_pages() is not a reason
> +	 * to warn. Also warn would trigger printk() which is unsafe from
> +	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
> +	 * since the running context is unknown.
> +	 *
> +	 * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
> +	 * is safe in any context. Also zeroing the page is mandatory for
> +	 * BPF use cases.
> +	 *
> +	 * Though __GFP_NOMEMALLOC is not checked in the code path below,
> +	 * specify it here to highlight that try_alloc_pages()
> +	 * doesn't want to deplete reserves.
> +	 */
> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
> +	unsigned int alloc_flags = ALLOC_TRYLOCK;
> +	struct alloc_context ac = { };
> +	struct page *page;
> +
> +	/*
> +	 * In RT spin_trylock() may call raw_spin_lock() which is unsafe in NMI.
> +	 * If spin_trylock() is called from hard IRQ the current task may be
> +	 * waiting for one rt_spin_lock, but rt_spin_trylock() will mark the
> +	 * task as the owner of another rt_spin_lock which will confuse PI
> +	 * logic, so return immediately if called form hard IRQ or NMI.
> +	 *
> +	 * Note, irqs_disabled() case is ok. This function can be called
> +	 * from raw_spin_lock_irqsave region.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		return NULL;
> +	if (!pcp_allowed_order(order))
> +		return NULL;
> +
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	/* Bailout, since try_to_accept_memory_one() needs to take a lock */
> +	if (has_unaccepted_memory())
> +		return NULL;
> +#endif
> +	/* Bailout, since _deferred_grow_zone() needs to take a lock */
> +	if (deferred_pages_enabled())
> +		return NULL;

Is it fine for BPF that things will fail to allocate until all memory is
deferred-initialized and accepted? I guess it's easy to teach those places
later to evaluate if they can take the lock.

> +
> +	if (nid == NUMA_NO_NODE)
> +		nid = numa_node_id();
> +
> +	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> +			    &alloc_gfp, &alloc_flags);
> +
> +	/*
> +	 * Best effort allocation from percpu free list.
> +	 * If it's empty attempt to spin_trylock zone->lock.
> +	 */
> +	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);

What about set_page_owner() from post_alloc_hook() and it's stackdepot
saving. I guess not an issue until try_alloc_pages() gets used later, so
just a mental note that it has to be resolved before. Or is it actually safe?

> +
> +	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> +
> +	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> +	kmsan_alloc_page(page, order, alloc_gfp);
> +	return page;
> +}


