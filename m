Return-Path: <bpf+bounces-74243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3CC4F28B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C88188560C
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5F377E82;
	Tue, 11 Nov 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e52L5gGY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB543730DB
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880479; cv=none; b=ShoMYFNV5DfG1S+dXXy15jq4nNHgUsfAgElM3AuyinOQXHOT9bTIvTL/bKqtAaTOiAjtJgiwOZgV+8rsxB0EI4oHaN0BMhK29IeenGaj6FvvUUE5my26E/qRGZeAbF7qVeUDoWKnvSzKPLZ52lG4jiEG+mu3VBbRKFJ15p1EQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880479; c=relaxed/simple;
	bh=GG8uHV0FmaqMPOs5Q6aTAzqlFriQK9XSeM8KFTVlID4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WUuSWGOOrwsjc/VBYQ5h+c5Mzzq5EceLMYsdKIVw0vnUmYLcPg5HtPcb7spL+wPbTar+t/oPvvqzLQQBepdvDvNXeQ4OQHQ5OQeqpPTe+8j6U8gJdAbs42l6xH5DdcRXvd/1UDLOVe8v7yc5q2y83gBdtlnMMQ32srFVfpWpVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e52L5gGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD52C4CEFB;
	Tue, 11 Nov 2025 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880478;
	bh=GG8uHV0FmaqMPOs5Q6aTAzqlFriQK9XSeM8KFTVlID4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=e52L5gGYG0Y2wO6QINYG9SEbwyxCTt2w/pljtEh4YAPIedU1yCySBphpzF5zNf8Fz
	 EMXzQffyn42RVqUunsoz2w06R1o5s6hYx4nJ36ikCbuQDMygvUV+Ej2/fBROeAn/SC
	 XH63GskBEXoQ/qDvgRgKJpcG3EpL7aSMJWl8WduQ7VNh236ZR2Uy6ZnAHB4tgAQT84
	 BTIhRAnHSrHw4JU7aubOgpY3m+Adg6xJn+M6x15VND10J6Jb78lT9E5W5oZ7sZgaFD
	 mGFGKgdH+QvqGPwclBw5a+pU5jJLDODEVHBCCQ6MCN0J8Tg0ukSusAH6KfRCfjQCTu
	 2Y52BVhy8D+vA==
Content-Type: multipart/mixed; boundary="===============7128587919362208443=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10e3bbd8dc718b20a0182ac11bfc44ed521f3857495e756972c79d205a9ea4eb@mail.kernel.org>
In-Reply-To: <20251111163424.16471-2-puranjay@kernel.org>
References: <20251111163424.16471-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 1/4] bpf: arena: populate vm_area without allocating memory
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Nov 2025 17:01:18 +0000 (UTC)

--===============7128587919362208443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1074ac445..dd5100a2f 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -92,6 +92,63 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
>  	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
>  }
>
> +struct apply_range_data {
> +	struct page **pages;
> +	int i;
> +};
> +
> +static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
> +{
> +	struct apply_range_data *d = data;
> +	struct page *page;
> +
> +	if (!data)
> +		return 0;
> +	/* sanity check */
> +	if (unlikely(!pte_none(ptep_get(pte))))
> +		return -EBUSY;
> +
> +	page = d->pages[d->i++];
> +	/* paranoia, similar to vmap_pages_pte_range() */
> +	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
> +		return -EINVAL;
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> +	return 0;
> +}
> +
> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
> +{
> +	struct mm_struct *mm = &init_mm;
> +	pte_t old_pte;
> +	struct page *page;
> +
> +	/* sanity check */
> +	old_pte = ptep_get(pte);
> +	if (pte_none(old_pte) || !pte_present(old_pte))
> +		return 0; /* nothing to do */
> +
> +	/* get page and free it */
> +	page = pte_page(old_pte);
> +	if (WARN_ON_ONCE(!page))
> +		return -EINVAL;
> +
> +	pte_clear(mm, addr, pte);
> +
> +	/* ensure no stale TLB entries */
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +	__free_page(page);
> +
> +	return 0;
> +}
> +
> +static int populate_pgtable_except_pte(struct bpf_arena *arena)
> +{
> +	return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
> +				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, NULL);
> +}
> +
>  static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  {
>  	struct vm_struct *kern_vm;

[ ... ]

> @@ -144,6 +201,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  		goto err;
>  	}
>  	mutex_init(&arena->lock);
> +	err = populate_pgtable_except_pte(arena);
> +	if (err)
> +		goto err;

Does this leak the arena and range_tree on error? The error path at the
range_tree_set() failure (above these lines) calls bpf_map_area_free(arena)
before goto err, but this new error path doesn't clean up arena or call
range_tree_destroy() before jumping to err.

>
>  	return &arena->map;
>  err:

[ ... ]

> @@ -286,6 +346,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	if (ret)
>  		return VM_FAULT_SIGSEGV;
>
> +	struct apply_range_data data = { .pages = &page, .i = 0 };
>  	/* Account into memcg of the process that created bpf_arena */
>  	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>  		return VM_FAULT_SIGSEGV;
>  	}
>
> -	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
> +	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>  		__free_page(page);

[ ... ]

> @@ -428,7 +489,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	/* user_vm_end/start are fixed before bpf prog runs */
>  	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
>  	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
> -	struct page **pages;
> +	struct page **pages = NULL;
>  	long pgoff = 0;
>  	u32 uaddr32;
>  	int ret, i;

[ ... ]

> @@ -465,6 +526,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	if (ret)
>  		goto out_free_pages;
>
> +	struct apply_range_data data = { .pages = pages, .i = 0 };
>  	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>  	if (ret)
>  		goto out;
> @@ -477,8 +539,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
>  	 * lower 32-bit and it's ok.
>  	 */
> -	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
> -				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
> +	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> +				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
>  	if (ret) {
>  		for (i = 0; i < page_cnt; i++)
>  			__free_page(pages[i]);

[ ... ]

> @@ -545,8 +607,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  			 * page_cnt is big it's faster to do the batched zap.
>  			 */
>  			zap_pages(arena, full_uaddr, 1);
> -		vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE);
> -		__free_page(page);
> +		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
> +					     apply_range_clear_cb, NULL);

Can this free pages multiple times? This is inside a loop that iterates
page_cnt times, with kaddr incrementing by PAGE_SIZE each iteration. But
apply_to_existing_page_range() is called with size page_cnt << PAGE_SHIFT,
which processes page_cnt pages starting from kaddr.

On the first iteration (i=0), it processes pages [0..page_cnt-1].
On the second iteration (i=1, kaddr+=PAGE_SIZE), it processes pages
[1..page_cnt], overlapping with the first iteration.

Since apply_range_clear_cb() calls __free_page() for each page, page 0
gets freed page_cnt times, page 1 gets freed page_cnt-1 times, etc.

The original code called vm_area_unmap_pages() with size PAGE_SIZE,
processing one page per iteration. Should the new code use PAGE_SIZE
instead of page_cnt << PAGE_SHIFT?

>  	}
>  }
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19272481461

--===============7128587919362208443==--

