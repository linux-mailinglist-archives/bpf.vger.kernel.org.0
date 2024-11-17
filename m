Return-Path: <bpf+bounces-45044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3E9D0320
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55335B23CEC
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1313212B;
	Sun, 17 Nov 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBKPEv5F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/nOGJ0Ei";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dE/8gZvI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lbQfqFtE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F91392
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731840873; cv=none; b=VxFVAzvDX/LTNxfuU7RFX7t1OVLue8fScyR6AOR/lYH3aj/t9McS1/Chmy/TbvPlXF/VOKcTL0aGxevxVoJCr2XQDyZhALoKPwqK8NIAqHzbfI6ZlWTGzpQn+xpi4qObaIbv09zfVz38dF7iAKJnxPbQQoFdXdmlevAfFbZBrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731840873; c=relaxed/simple;
	bh=anNeMursR8ZrcENchpwpo/qhLzyCHBdH28M4CUF3qUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecPMnebHQS0Ah4dNYNNs7+LQ/LGsZpPwgxvCjuf6MhDv2VjvEd4KsbFbKHiM/B4v3rkMp1/OFlVDQe1SjofUy9VcAlDmd8FQ84vIPLsjqCmKQGmyuypgHUAYG3VETD7yotdsMtdPU9rmyNNRr28tNlpiVgjv4hUUG/F8dpKgMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBKPEv5F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/nOGJ0Ei; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dE/8gZvI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lbQfqFtE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12457211CB;
	Sun, 17 Nov 2024 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731840869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BHveVuRboL/EgttrVGmDGLx2aQ+wT0MYaPdzYKEcZRk=;
	b=iBKPEv5FStMt7jQUQpvpJBm8HoCJOUhxyNt5lI4Yd4ymiy/9LF1BkbUueuBkK6mYaZw304
	gvbSLPnmFXxqDc9iZEsJFIr+UcZOOw76s1OBEsZnRXwo3Ym0bFsN9ztU8I8CVW1TR4Hf58
	itcdkLL0e9BMbKGcdmq5qFrrI72jQNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731840869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BHveVuRboL/EgttrVGmDGLx2aQ+wT0MYaPdzYKEcZRk=;
	b=/nOGJ0EiK3psstWOwDr4BEq7fggUQwGjdiOGkyzIB/e8VR+M/qoKOaIhqBbeDXU/YinLUx
	elI/weptcZ+DjACA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731840868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BHveVuRboL/EgttrVGmDGLx2aQ+wT0MYaPdzYKEcZRk=;
	b=dE/8gZvI+RhXTo2d72Xqon8gycyLo8c9qW8oDNgteXr21iI2sRNaBqRq25Wv+KcD8AHvnM
	AgCEp603hVSYL0HfE+a3Oy5VtDqaKp8aRmitcAQOjll+uMiTHc9kMQ+2nbDJnKdkmqYs88
	p87ZL0A2GDyfOXcmbD8g8ygzLlBnkLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731840868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BHveVuRboL/EgttrVGmDGLx2aQ+wT0MYaPdzYKEcZRk=;
	b=lbQfqFtE5Fs8FKLwA4gC3/qRwBRjcNHTr/NrOFGJS8zIXEXRbr0zEtnxw92Fg1GEYYc/4N
	NVbRAPS3iEMRf5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3ADD13297;
	Sun, 17 Nov 2024 10:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JDhNmPLOWcdTAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 17 Nov 2024 10:54:27 +0000
Message-ID: <8fce9510-a690-4b7a-91fb-62f6facfe0b5@suse.cz>
Date: Sun, 17 Nov 2024 11:54:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, houtao1@huawei.com, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@suse.com, tj@kernel.org, linux-mm@kvack.org,
 kernel-team@fb.com
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 11/16/24 02:48, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs execute from tracepoints and kprobes where running
> context is unknown, but they need to request additional memory.
> The prior workarounds were using pre-allocated memory and BPF specific
> freelists to satisfy such allocation requests. Instead, introduce
> __GFP_TRYLOCK flag that makes page allocator accessible from any context.
> It relies on percpu free list of pages that rmqueue_pcplist() should be
> able to pop the page from. If it fails (due to IRQ re-entrancy or list
> being empty) then try_alloc_page() attempts to spin_trylock zone->lock
> and refill percpu freelist as normal.
> BPF program may execute with IRQs disabled and zone->lock is sleeping in RT,
> so trylock is the only option.
> In theory we can introduce percpu reentrance counter and increment it
> every time spin_lock_irqsave(&zone->lock, flags) is used,
> but we cannot rely on it. Even if this cpu is not in page_alloc path
> the spin_lock_irqsave() is not safe, since BPF prog might be called
> from tracepoint where preemption is disabled. So trylock only.
> 
> There is no attempt to make free_page() to be accessible from any
> context (yet). BPF infrastructure will asynchronously free pages from
> such contexts.
> memcg is also not charged in try_alloc_page() path. It has to be
> done asynchronously to avoid sleeping on
> local_lock_irqsave(&memcg_stock.stock_lock, flags).
> 
> This is a first step towards supporting BPF requirements in SLUB
> and getting rid of bpf_mem_alloc.
> That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Thanks for looking into this. I agree that something like __GFP_TRYLOCK
would be necessary to distinguish those allocation contexts. But I'm
wondering if the page allocator is the best place to start (or even
necessary in the end) if the goal is to replace the kmalloc-sized
allocations in bpf and not page sized? SLUB could have preallocated slab
pages to not call into the page allocator in such situations?

I've posted the first SLUB sheaves RFC this week [1]. The immediate
motivation was different, but I did mention there this could perhaps become
a basis for the bpf_mem_alloc replacement too. I'd imagine something like a
set of kmem_buckets with sheaves enabled and either a flag like
__GFP_TRYLOCK or a different variant of kmalloc() to only try using the
sheaves. Didn't Cc you/bpf as if seemed too vague yet, but guess I should have.

[1]
https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz/#t

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/gfp.h            | 17 +++++++++++++++++
>  include/linux/gfp_types.h      |  3 +++
>  include/trace/events/mmflags.h |  1 +
>  mm/internal.h                  |  1 +
>  mm/page_alloc.c                | 19 ++++++++++++++++---
>  tools/perf/builtin-kmem.c      |  1 +
>  6 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index a951de920e20..319d8906ef3f 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -347,6 +347,23 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
>  }
>  #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
>  
> +static inline struct page *try_alloc_page_noprof(int nid)
> +{
> +	/* If spin_locks are not held and interrupts are enabled, use normal path. */
> +	if (preemptible())
> +		return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZERO, 0);
> +	/*
> +	 * Best effort allocation from percpu free list.
> +	 * If it's empty attempt to spin_trylock zone->lock.
> +	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
> +	 * that may need to grab a lock.
> +	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
> +	 * Do not warn either.
> +	 */
> +	return alloc_pages_node_noprof(nid, __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO, 0);
> +}
> +#define try_alloc_page(nid)			alloc_hooks(try_alloc_page_noprof(nid))
> +
>  extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
>  #define __get_free_pages(...)			alloc_hooks(get_free_pages_noprof(__VA_ARGS__))
>  
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 65db9349f905..72b385a7888d 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -48,6 +48,7 @@ enum {
>  	___GFP_THISNODE_BIT,
>  	___GFP_ACCOUNT_BIT,
>  	___GFP_ZEROTAGS_BIT,
> +	___GFP_TRYLOCK_BIT,
>  #ifdef CONFIG_KASAN_HW_TAGS
>  	___GFP_SKIP_ZERO_BIT,
>  	___GFP_SKIP_KASAN_BIT,
> @@ -86,6 +87,7 @@ enum {
>  #define ___GFP_THISNODE		BIT(___GFP_THISNODE_BIT)
>  #define ___GFP_ACCOUNT		BIT(___GFP_ACCOUNT_BIT)
>  #define ___GFP_ZEROTAGS		BIT(___GFP_ZEROTAGS_BIT)
> +#define ___GFP_TRYLOCK		BIT(___GFP_TRYLOCK_BIT)
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define ___GFP_SKIP_ZERO	BIT(___GFP_SKIP_ZERO_BIT)
>  #define ___GFP_SKIP_KASAN	BIT(___GFP_SKIP_KASAN_BIT)
> @@ -293,6 +295,7 @@ enum {
>  #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
>  #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
>  #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
> +#define __GFP_TRYLOCK	((__force gfp_t)___GFP_TRYLOCK)
>  #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
>  #define __GFP_SKIP_KASAN ((__force gfp_t)___GFP_SKIP_KASAN)
>  
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index bb8a59c6caa2..592c93ee5f35 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -50,6 +50,7 @@
>  	gfpflag_string(__GFP_RECLAIM),		\
>  	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
>  	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
> +	gfpflag_string(__GFP_TRYLOCK),		\
>  	gfpflag_string(__GFP_ZEROTAGS)
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
> diff --git a/mm/internal.h b/mm/internal.h
> index 64c2eb0b160e..c1b08e95a63b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1173,6 +1173,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #endif
>  #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
> +#define ALLOC_TRYLOCK		0x1000000 /* Only use spin_trylock in allocation path */
>  
>  /* Flags that allow allocations below the min watermark. */
>  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 216fbbfbedcf..71fed4f5bd0c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2304,7 +2304,12 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	unsigned long flags;
>  	int i;
>  
> -	spin_lock_irqsave(&zone->lock, flags);
> +	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +		if (!spin_trylock_irqsave(&zone->lock, flags))
> +			return 0;
> +	} else {
> +		spin_lock_irqsave(&zone->lock, flags);
> +	}
>  	for (i = 0; i < count; ++i) {
>  		struct page *page = __rmqueue(zone, order, migratetype,
>  								alloc_flags);
> @@ -2904,7 +2909,12 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  
>  	do {
>  		page = NULL;
> -		spin_lock_irqsave(&zone->lock, flags);
> +		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +			if (!spin_trylock_irqsave(&zone->lock, flags))
> +				return 0;
> +		} else {
> +			spin_lock_irqsave(&zone->lock, flags);
> +		}
>  		if (alloc_flags & ALLOC_HIGHATOMIC)
>  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  		if (!page) {
> @@ -4001,6 +4011,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  	 */
>  	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
>  	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
> +	BUILD_BUG_ON(__GFP_TRYLOCK != (__force gfp_t) ALLOC_TRYLOCK);
>  
>  	/*
>  	 * The caller may dip into page reserves a bit more if the caller
> @@ -4009,7 +4020,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
>  	 */
>  	alloc_flags |= (__force int)
> -		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> +		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
>  
>  	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
>  		/*
> @@ -4509,6 +4520,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>  
>  	might_alloc(gfp_mask);
>  
> +	*alloc_flags |= (__force int) (gfp_mask & __GFP_TRYLOCK);
> +
>  	if (should_fail_alloc_page(gfp_mask, order))
>  		return false;
>  
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index a756147e2eec..d245ff60d2a6 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -682,6 +682,7 @@ static const struct {
>  	{ "__GFP_RECLAIM",		"R" },
>  	{ "__GFP_DIRECT_RECLAIM",	"DR" },
>  	{ "__GFP_KSWAPD_RECLAIM",	"KR" },
> +	{ "__GFP_TRYLOCK",		"TL" },
>  };
>  
>  static size_t max_gfp_len;


