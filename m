Return-Path: <bpf+bounces-46494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728949EAAC9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A53E188A131
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A4230998;
	Tue, 10 Dec 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwu/6blq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+3uj5BQL"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA01D0F7D
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819709; cv=none; b=KKMOn4Vv6LjeZeovhcv13M8uD2zt6AeGq2hShVhF4j9acCDS36TW3/DNMXutlWHpVIV4LjuHNPW8PHM7/NAhAVHRvfNjb0ssLcAwBo7YEFra3lKYgufBvC4buw4UvlF0N1564Nq4F/Ili2c5ry1XF9NGVMhaQL4JqXHbx5Pa6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819709; c=relaxed/simple;
	bh=x7+oY+fANuPmWBA9cafe1ykREEj23DCDOzpPURApH7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Imu0YekTM7e6lJbSa87SsRlN2hCVp9vZWHJKXMKBhpoxiRTL1x6X1cWyNvoCkD+jm8d41ghpLSazjY6eFTMwBVnjas7XH2Pr4AXMwDAygwmDLPTjEpGTdCdCuZnlLAdicARw/LfeYHKwLLjFCcoKPTfy/u5cjKDhSx82pYxenwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwu/6blq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+3uj5BQL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 09:35:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733819705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTfFEA3zLze3dY8TnsP8XmhHkHHlADbqk1HHeOcTcMA=;
	b=mwu/6blqI6oQwyXfSLfhKGZUGvssGHl9+Yyv0gi9OTfWDP/zTM57MK3EsXZNOseebk7Gcl
	qMAsVkSE5hcG1a2+Ry3TkFmYV4vZL+Djd0M8oDf9eHkez3PMvFMoVptXXOOPCShlcSJckO
	TbmkNw+id3sf3EHcs2dO2iLnaYptHdwXSNzBYsjPB+DSsFUcwUN7TCb0U836A+yU42v3YN
	WQz0fAfQlJI6BLfHBlpvAuYfb8sxQqgQo3V2qKc/fEgcvoG6KeJj9MWSBTM3LivaEf7N6u
	jBfLdesdW6PuetMJHZ2MFV7aPfB9FhdPGOvsXwHa1lmo8JcfaDRFSrIQGK+Gig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733819705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTfFEA3zLze3dY8TnsP8XmhHkHHlADbqk1HHeOcTcMA=;
	b=+3uj5BQLJR+XsLt5R521gJHScEIH4M9Ffn4Hy1iCAxBRApt++y5m+sozNLZO+WfH5V2CTn
	jjev0lMzlbdL9MAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, tj@kernel.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 2/6] mm, bpf: Introduce free_pages_nolock()
Message-ID: <20241210083503.zJdPI8s5@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210023936.46871-3-alexei.starovoitov@gmail.com>

On 2024-12-09 18:39:32 [-0800], Alexei Starovoitov wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d511e68903c6..a969a62ec0c3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1251,9 +1254,33 @@ static void free_one_page(struct zone *zone, struct page *page,
>  			  unsigned long pfn, unsigned int order,
>  			  fpi_t fpi_flags)
>  {
> +	struct llist_head *llhead;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&zone->lock, flags);
> +	if (!spin_trylock_irqsave(&zone->lock, flags)) {
> +		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +			/* Remember the order */
> +			page->order = order;
> +			/* Add the page to the free list */
> +			llist_add(&page->pcp_llist, &zone->trylock_free_pages);
> +			return;
> +		}
> +		spin_lock_irqsave(&zone->lock, flags);
> +	}
> +
> +	/* The lock succeeded. Process deferred pages. */
> +	llhead = &zone->trylock_free_pages;
> +	if (unlikely(!llist_empty(llhead))) {
> +		struct llist_node *llnode;
> +		struct page *p, *tmp;
> +
> +		llnode = llist_del_all(llhead);

Do you really need to turn the list around?

> +		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
> +			unsigned int p_order = p->order;
> +			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
> +			__count_vm_events(PGFREE, 1 << p_order);
> +		}

We had something like that (returning memory in IRQ/ irq-off) in RT tree
and we got rid of it before posting the needed bits to mm.

If we really intend to do something like this, could we please process
this list in an explicitly locked section? I mean not in a try-lock
fashion which might have originated in an IRQ-off region on PREEMPT_RT
but in an explicit locked section which would remain preemptible. This
would also avoid the locking problem down the road when
shuffle_pick_tail() invokes get_random_u64() which in turn acquires a
spinlock_t.

> +	}
>  	split_large_buddy(zone, page, pfn, order, fpi_flags);
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  

Sebastian

