Return-Path: <bpf+bounces-74514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F5C5CEF0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120ED421847
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0DF314B61;
	Fri, 14 Nov 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/I80zT1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164B3148C6
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120854; cv=none; b=R990jgYJv8iz4jiuRcDyv509msLLv1i4XW2iyRqR7GCTgdEIaeudryXHFj4/Enr7789yURubyPQ+wVMnp6Bb9xEsycp+2iAy2aQKN6xmuL4zDX/KnyJd/8dIxcwkOGYPOSWTQPgBwNvtTsegmgYbl+DRP9awbN2Lta4Yy0rE1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120854; c=relaxed/simple;
	bh=JyWWtahOEVYPNT9o3joxec8r8IiVd+lvJZtxEe8TN2o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KZoUoPkCr8BAC0fF7Yhca0TOGOrJinergWfTlEqsySiad5ry6oA7+aiojfI27TJuXN/CbHoOMdKBTFQNgXdtVW0JGIleOnalnsqRh7Z8UPKQJ+RLs0Dk/btxUNecx/o2YvXXNWzR7XFjE2VE8qR9EtXoHapHrpOx4ItyvkAM/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/I80zT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B492DC4CEFB;
	Fri, 14 Nov 2025 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763120854;
	bh=JyWWtahOEVYPNT9o3joxec8r8IiVd+lvJZtxEe8TN2o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Q/I80zT1Ow44QykHfhz7qGpDrXq/rxijuJ+VOZ5bYRDXlM+OFRdt3uWpO4xFomY6T
	 yXoNT51R0yEStsXwrMbYTCJzlMaiUoYHYI+0ae4TTZugMQru6eYFKY2VAuk4yUicdZ
	 cYaSZALKwIMoywJIaJ0OljwY7rAKzuoDcdEpxg0/qyYiNEdGY7rbE/JvtWzUePbXWj
	 QgEtOYRDbSIyMu+eYroDvd/5CQsrRTo9v3SSBhgGtwNluNSgjGdqINXJjL0GnmjyLj
	 wyE0EMfnkAkq+R2q26CP6ECYC3qtRPS2KLX4+vrFmkHUtxBC4mGfZNASilu7JrBfoR
	 pHH6VZ2eAW1Mw==
Content-Type: multipart/mixed; boundary="===============5234828101529785392=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0a8bdc792e9424566da4b764770c86f4af787e6bd714162917163768f2af4b4@mail.kernel.org>
In-Reply-To: <20251114111700.43292-4-puranjay@kernel.org>
References: <20251114111700.43292-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any context safe
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 11:47:33 +0000 (UTC)

--===============5234828101529785392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7fa6e40ab..ca443c113 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -331,12 +355,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>  	struct page *page;
>  	long kbase, kaddr;
> +	unsigned long flags;
>  	int ret;
>
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> -	guard(mutex)(&arena->lock);
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +		/*
> +		 * This is an impossible case and would only trigger if res_spin_lock is buggy or
> +		 * due to another kernel bug.
> +		 */
> +		return VM_FAULT_RETRY;
> +
>  	page = vmalloc_to_page((void *)kaddr);
>  	if (page)
>  		/* already have a page vmap-ed */
> @@ -348,26 +379,30 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>
>  	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
>  	if (ret)
> -		return VM_FAULT_SIGSEGV;
> +		goto out_unlock_sigsegv;
>
>  	struct apply_range_data data = { .pages = &page, .i = 0 };
>  	/* Account into memcg of the process that created bpf_arena */
>  	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		return VM_FAULT_SIGSEGV;
> +		goto out_unlock_sigsegv;
>  	}
>
>  	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		__free_page(page);
> -		return VM_FAULT_SIGSEGV;
> +		free_pages_nolock(page, 0);
> +		goto out_unlock_sigsegv;
>  	}
>  out:
>  	page_ref_add(page, 1);
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	vmf->page = page;
>  	return 0;

In arena_vm_fault(), there's a path between acquiring the spinlock and
the new goto labels that doesn't release the lock:

>  	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>  		return VM_FAULT_SIGSEGV;

This return statement is reached after raw_res_spin_lock_irqsave()
succeeds but before any of the unlock paths. If BPF_F_SEGV_ON_FAULT is
set, subsequent page faults on this arena will deadlock. All other
return paths in the function properly jump to out_unlock_sigsegv to
release the lock.

> +out_unlock_sigsegv:
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	return VM_FAULT_SIGSEGV;
>  }

[ ... ]

> @@ -594,42 +633,65 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  {
>  	struct vma_list *vml;
>
> +	guard(mutex)(&arena->lock);
> +	/* iterate link list under lock */
>  	list_for_each_entry(vml, &arena->vma_list, head)
>  		zap_page_range_single(vml->vma, uaddr,
>  				      PAGE_SIZE * page_cnt, NULL);
>  }
>
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
> +	/*
> +	 * Can't proceed without holding the spinlock so defer the free
> +	 */
> +	if (ret)
> +		goto defer;

[ ... ]

> +	return;
> +
> +defer:
> +	s = kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
> +	if (!s)
> +		return;

In arena_free_pages(), when the deferred free path is taken but
kmalloc_nolock() fails, the function returns silently without freeing
the pages. These pages remain mapped in the kernel page tables and
marked as allocated in the range tree, but become unusable.

This can happen when:
- The function is called from a non-sleepable context (sleepable=false)
- Lock acquisition fails and falls through to defer
- kmalloc_nolock() returns NULL (PREEMPT_RT+IRQ, lock contention, or
  unsupported arch)

The deferred free path is called from arena_alloc_pages() error
handling and bpf_arena_free_pages_non_sleepable(). In both cases, the
pages that should be freed will leak.

Should there be a fallback mechanism or at least a warning when
deferral fails?

> +
> +	s->page_cnt = page_cnt;
> +	s->uaddr = uaddr;
> +	llist_add(&s->node, &arena->free_spans);
> +	irq_work_queue(&arena->free_irq);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19363121319

--===============5234828101529785392==--

