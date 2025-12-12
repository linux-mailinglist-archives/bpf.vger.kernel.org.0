Return-Path: <bpf+bounces-76499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8176CB7803
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 02:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F85F300F58F
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA822222D1;
	Fri, 12 Dec 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kivcxjkq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6591DF271
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501510; cv=none; b=eNtfth1y8KzDQTsMXBxirACP90gmjPBKE1KnBFGNLfpU+s+6lAVFFsG+VORaHFpHwNfdsfvL4h1ma05vUWOI5vljKVaGlf8xJO2H2ZI+m0BIrqbzhM+Ibzbt4oYhlUUY6+0w7cvtv13pbJmzQq2x5jrFSTEUxAWlQWB0SBwz2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501510; c=relaxed/simple;
	bh=MhtvALmQVDWJithUp+yNSa9ZZEQzRYFkfQQpUMnJI54=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jMAgvlrns8Tn1Vq3c850GnQH7Ks+0NPqPqqv86B2nMFkclgKmNCcYfvQG3MyNZxmmKEhY80G3kd3r3yN4wNoD7UvOLih6lkS/mxD8vEnZO7v/Lq0LWkcqu+6isxzvqS86syZ9cqoLMse3nWqIJXbTrv8nwRHQ/6j/YxRTdIpX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kivcxjkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C16C4CEF7;
	Fri, 12 Dec 2025 01:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765501509;
	bh=MhtvALmQVDWJithUp+yNSa9ZZEQzRYFkfQQpUMnJI54=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KivcxjkqjzAV1z8X83q6y2PJoNnOfOrRZtM4VQIcR2sM6PHSlQ1nVpqsJl1AUqq77
	 ntyounaoCObD9C4f5QUBENfP75nAE7niJL002NnPYlkkKUd0zX7nXDdC8ik84xcY/l
	 3ucQ1y7I4+Mws/YJoZunNCSjlXH8oZIzues9Ilhv+CqAIDKALHkjDZXhgChfukWe/D
	 ZoElvvD3cNy3mwLvT7uw5l7qE1PwPMEm7oViA7oeGrPCxvYZEJmKS5F/8vvOieCfCz
	 bmPYJRsFna7UANHC0B7iYz7Ootj6tqShh24ijmPV4P1jIAfhGxu57njzoUlG6Is6gV
	 LG80wATJNRA5w==
Content-Type: multipart/mixed; boundary="===============6367550237844646632=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5daf712b2a51bf284ff8b01a0a0cf3a74b9bf30873dcdf83a8b4a5875c4427a@mail.kernel.org>
In-Reply-To: <20251212004350.6520-4-puranjay@kernel.org>
References: <20251212004350.6520-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: arena: make arena kfuncs any context safe
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Dec 2025 01:05:08 +0000 (UTC)

--===============6367550237844646632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 28d8d6b7bb1e..e873dc34fc2f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -673,6 +673,21 @@ void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
>  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>  				   struct bpf_dynptr *ptr__uninit);
>
> +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
> +					  u64 flags);
> +void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt);
> +#else
> +static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
> +							int node_id, u64 flags)
> +{
> +}

Should bpf_arena_alloc_pages_non_sleepable() return NULL here? The
function is declared to return void * but has no return statement.

> +
> +static inline void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
> +{
> +}
> +#endif

[ ... ]

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c

[ ... ]

> -static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
>  {
>  	u64 full_uaddr, uaddr_end;
> -	long kaddr, pgoff, i;
> +	long kaddr, pgoff;
>  	struct page *page;
> +	struct llist_head free_pages;
> +	struct llist_node *pos, *t;
> +	struct arena_free_span *s;
> +	unsigned long flags;
> +	int ret = 0;
>
>  	/* only aligned lower 32-bit are relevant */
>  	uaddr = (u32)uaddr;
>  	uaddr &= PAGE_MASK;
> +	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
>  	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
>  	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
>  	if (full_uaddr >= uaddr_end)
>  		return;
>
>  	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> +	pgoff = compute_pgoff(arena, uaddr);
>
> -	guard(mutex)(&arena->lock);
> +	if (!sleepable)
> +		goto defer;
> +
> +	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> +
> +	/* Can't proceed without holding the spinlock so defer the free */
> +	if (ret)
> +		goto defer;
>
> -	pgoff = compute_pgoff(arena, uaddr);
> -	/* clear range */
>  	range_tree_set(&arena->rt, pgoff, page_cnt);
>
> +	init_llist_head(&free_pages);
> +	/* clear ptes and collect struct pages */
> +	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
> +				     apply_range_clear_cb, &free_pages);
> +
> +	/* drop the lock to do the tlb flush and zap pages */
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
> +	/* ensure no stale TLB entries */
> +	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
> +
>  	if (page_cnt > 1)
>  		/* bulk zap if multiple pages being freed */
>  		zap_pages(arena, full_uaddr, page_cnt);
>
> -	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
> -	for (i = 0; i < page_cnt; i++, kaddr += PAGE_SIZE, full_uaddr += PAGE_SIZE) {
> -		page = vmalloc_to_page((void *)kaddr);
> -		if (!page)
> -			continue;
> +	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
> +		page = llist_entry(pos, struct page, pcp_llist);
>  		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
>  			/* Optimization for the common case of page_cnt==1:
>  			 * If page wasn't mapped into some user vma there
> @@ -640,9 +697,20 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  			 * page_cnt is big it's faster to do the batched zap.
>  			 */
>  			zap_pages(arena, full_uaddr, 1);
> -		apply_to_existing_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_clear_cb,
> -					     NULL);
> +		__free_page(page);
>  	}
> +
> +	return;
> +
> +defer:
> +	s = kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
> +	if (!s)
> +		return;

Does this leak pages when kmalloc_nolock() fails? The function returns
without clearing the PTEs, flushing TLB, or freeing the pages. The
range_tree bits are also not set back to free, so these pages become
permanently inaccessible until the arena is destroyed.

In the non-sleepable path when kmalloc_nolock() returns NULL:
- Pages remain allocated in the arena
- PTEs are not cleared
- range_tree bits remain cleared (pages marked as allocated)
- No retry mechanism exists to free these pages later

> +
> +	s->page_cnt = page_cnt;
> +	s->uaddr = uaddr;
> +	llist_add(&s->node, &arena->free_spans);
> +	irq_work_queue(&arena->free_irq);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20152458491

--===============6367550237844646632==--

