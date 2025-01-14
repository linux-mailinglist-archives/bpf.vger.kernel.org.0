Return-Path: <bpf+bounces-48751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674BA10433
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90B23A40F5
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7289229612;
	Tue, 14 Jan 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NVETNcpm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17740229603
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850698; cv=none; b=WcVSSgPwMVjPPeCWWNAiG7HZHE+FwOesV4rpD5+6eM+LGRDzBCugiNcc7jRKASEj1RhrsT7/8Rc6Wgt5IXfPNzlGKANZrow1FdriSzIAesWCCptJCsmSQDw3CT2aKxK06BxmwbmxpVbBXnch6VwUGeMkoenVw2SBDXLdJCivgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850698; c=relaxed/simple;
	bh=sjgkhIKQ+daNZK+sdN/uATbZyvH4aF+F4U/0dkfZdlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlN9fyTbcNKa8bPnTNh2z6mGa25ELil7G7qMWU0pvkgwn4f6KHmv7xGUiNNSMLnorlZSVPNII96iL8OX/oxFZRZKWqx4CrxSbeyKwobpEQmmuxWAGNpvnPP/tWlIY6pAvI0/nUHrPr5MHBK8Wz8uPzV1TqA4ILM+0au1pnueAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NVETNcpm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43621d27adeso36492245e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736850694; x=1737455494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRE92pmkbnMF6hIf2dQZfyPPqndDQfFd76z+Var3uis=;
        b=NVETNcpmI7OLynPrq+P4fWmZd7S98/ZIBb9e9IUPARCZTdk+CQaYDsJmwcdP1zbBVE
         P9zDJdZa9CbPkq6knFEo82UAIYWIiyN2NKPVr+W+bM57CpZabpBIav1ij/1lZKwS+oJq
         1gOyCqIvhVEfS4ZeBdIznbS7oar4rOh7KrIkgiy3MDOgQ/E9BqTIylKR289uPfHwAwgF
         cFtKsuoME8NdIkbyb1bPt7StVRsHeXM5aSiNLJr1NTXrb7dftQJlrtpegq7l++4BryG0
         mZRnBRENmdt3FavPdVitsHK1mes1hUPpE4Ml77ihHA0UrqsxOHt+F/H53o6Mq/UWavY9
         FH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850694; x=1737455494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRE92pmkbnMF6hIf2dQZfyPPqndDQfFd76z+Var3uis=;
        b=PR+h5ypcRRHDokmSe2XsqGCtziOsaqL5hGepsFex6nMbm+6BpcQ7RfTfweVu+ED0Vc
         Jyak3hg6O6mreDs+daf0bjuQ2nDrGp3ebVgia8s2SYFB6RcX4z/P31ALN7dplpQKGr1L
         ZaSekVH9b4tFXiLNWoiTWlVv+D7azipNlPwOlNBV4qYc8+s9RqeZDJzRShdRXHP3gsTT
         K5XlHenBNbFbw1SE6vjNm83mSzn3+CmyEA7OBcW17XD4EPYsWGPuM2BhJOJ1brgxUp4B
         h17RRWPNSLmTmLdCAd+69oDcEbqSbB+eiaX3vzuf4rvb811LSKiO7Vg4n7nAe/tEPxQN
         wyNQ==
X-Gm-Message-State: AOJu0YzvpULt6tTWbvLEQJWwJWyiKeBkuY1pkxh8R/FXuWUfSI42iIZx
	/0JLlw706ktuShH9LZZHCjSs8SgDh5Jd/jiOKLN5AMul5CC1WaLfrJAqEXHhl6s=
X-Gm-Gg: ASbGncsfEgiriOF7sVGcHYZoAWbzHmfTUtLD2l2/KtDyv4VlIRPdJES79ILJYtqnAyL
	gkad7tZEr6bUi/M3h94JPz9hU2VvdRTYin7VByoGzQWD7JqdJpYttKPmhdHChSvgkku6OpII5B1
	5/M6PorzWipWdOYT8tfvbrtDEyIsGShAg5mntzG5zms72GKtfHWwU5AW0jQjoP93lnWmTBn+jCV
	Y28joSFBPhjH3tw4xIggaw+MaYdzYcEUMp2pBN9uTr2U9QsCKH4vJstNLNwwu4Z+jieCQ==
X-Google-Smtp-Source: AGHT+IF+F/lO+cl3eE7Z2r+FMHP9SrnQeYSXk2JHXeyZ82uqrwzFOTlI6itWbrD8ysfA/IKYifwJNw==
X-Received: by 2002:a05:6000:1fa1:b0:388:caf4:e909 with SMTP id ffacd0b85a97d-38a872e8bc4mr24664584f8f.25.1736850694287;
        Tue, 14 Jan 2025 02:31:34 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm14355005f8f.3.2025.01.14.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:31:34 -0800 (PST)
Date: Tue, 14 Jan 2025 11:31:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z4Y9BVygLcRTjhMh@tiehlicka>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114021922.92609-2-alexei.starovoitov@gmail.com>

On Mon 13-01-25 18:19:17, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs execute from tracepoints and kprobes where
> running context is unknown, but they need to request additional
> memory. The prior workarounds were using pre-allocated memory and
> BPF specific freelists to satisfy such allocation requests.
> Instead, introduce gfpflags_allow_spinning() condition that signals
> to the allocator that running context is unknown.
> Then rely on percpu free list of pages to allocate a page.
> The rmqueue_pcplist() should be able to pop the page from.
> If it fails (due to IRQ re-entrancy or list being empty) then
> try_alloc_pages() attempts to spin_trylock zone->lock
> and refill percpu freelist as normal.
> BPF program may execute with IRQs disabled and zone->lock is
> sleeping in RT, so trylock is the only option. In theory we can
> introduce percpu reentrance counter and increment it every time
> spin_lock_irqsave(&zone->lock, flags) is used, but we cannot rely
> on it. Even if this cpu is not in page_alloc path the
> spin_lock_irqsave() is not safe, since BPF prog might be called
> from tracepoint where preemption is disabled. So trylock only.
> 
> Note, free_page and memcg are not taught about gfpflags_allow_spinning()
> condition. The support comes in the next patches.
> 
> This is a first step towards supporting BPF requirements in SLUB
> and getting rid of bpf_mem_alloc.
> That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

LGTM, I am not entirely clear on kmsan_alloc_page part though.
As long as that part is correct you can add
Acked-by: Michal Hocko <mhocko@suse.com>

Other than that try_alloc_pages_noprof begs some user documentation.

/**
 * try_alloc_pages_noprof - opportunistic reentrant allocation from any context
 * @nid - node to allocate from
 * @order - allocation order size
 *
 * Allocates pages of a given order from the given node. This is safe to
 * call from any context (from atomic, NMI but also reentrant 
 * allocator -> tracepoint -> try_alloc_pages_noprof).
 * Allocation is best effort and to be expected to fail easily so nobody should
 * rely on the succeess. Failures are not reported via warn_alloc().
 *
 * Return: allocated page or NULL on failure.
 */
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
> +
> +	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> +
> +	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> +	kmsan_alloc_page(page, order, alloc_gfp);
> +	return page;
> +}
> -- 
> 2.43.5
-- 
Michal Hocko
SUSE Labs

