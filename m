Return-Path: <bpf+bounces-74513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FBDC5CEE1
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D684E35A86A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB13164BB;
	Fri, 14 Nov 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efRkmAfy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106793148C6
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120853; cv=none; b=B7O9Nlwbhb0lB76holZ5MkpjFarHULVvZGQL0UYUiu1151dZlh8oZYSbHb8BPwS3lg4fe8p3ZWbtU2mi/1fY/x7dNOkvXpNng//gjtBP1hqeEKKkKm1Q4luh4pclAnvUJpWH3KeHg9LTFbOGSRZr0upZ+B+fyGWxtDsaZyue3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120853; c=relaxed/simple;
	bh=BjER0vj3fM5QSiG+0v4fjJnppqEP6tnQZsERvsuO0NE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZNRBJHgw5fdyxjfUFuUoIgQtPAAC9kNJWrSa/imyrqgk5P3YPaPH0TOXMm8mNqckxqgssmj0yhSjkfmE9fy8DOJwmGEDqY5mZ4GxvopmNFBk66jxx4oOMkKnjS7GZfndUjEEgjxROFPQw5vRBq3XAP/dZMG6HWKes0RpNY1Fn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efRkmAfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16122C2BCB3;
	Fri, 14 Nov 2025 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763120852;
	bh=BjER0vj3fM5QSiG+0v4fjJnppqEP6tnQZsERvsuO0NE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=efRkmAfyT82GyoKQ2WzefQsDGjAY+yXHnkxzIFqYdxuUYAUSXrx+RKP29fzSewsdQ
	 AcLhEdk/dOP5LER2YQqSk2AYAUKAhjuUD7Gqznisvu5cbF4cINHMPJEPofTkzNjUVC
	 fjb51TXtdxc9zvNx6oEct7yJFVaoqTwm+e3ffD8rO7oO9iUDBsbKJFWxe4wdVGeNnf
	 vIcWpkjsKIhrqyxENQhsHOJ/dg1vcsICzAspmmcRYfHMzPpm3h7QEBRgv8zVjyTMvk
	 esfNv6lR9r1f458juQoyCcgTPGXLgburCRcNdGsJRQtpR9WXo20ubk+JrHRvY1NT8n
	 kDp0YmGOQrpuw==
Content-Type: multipart/mixed; boundary="===============1334053399124491186=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5542c931e3200fd81c95abc6bbdfc1e37ca2951a9a480164558c05fe1b9044a4@mail.kernel.org>
In-Reply-To: <20251114111700.43292-2-puranjay@kernel.org>
References: <20251114111700.43292-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: arena: populate vm_area without allocating memory
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 11:47:32 +0000 (UTC)

--===============1334053399124491186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1074ac445..48b8ffba3 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -92,6 +93,62 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
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
> +	pte_clear(&init_mm, addr, pte);
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

> @@ -144,6 +201,11 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  		goto err;
>  	}
>  	mutex_init(&arena->lock);
> +	err = populate_pgtable_except_pte(arena);
> +	if (err) {
> +		bpf_map_area_free(arena);
> +		goto err;
> +	}
                     ^^^^

Can this leak the range tree? Looking at the code, range_tree_set() was
called earlier in this function and can allocate range_node structures
via range_tree_clear()->kmalloc_nolock(). If populate_pgtable_except_pte()
fails here, the error path calls bpf_map_area_free(arena) but doesn't call
range_tree_destroy(&arena->rt) first. Compare with arena_map_free() which
always calls range_tree_destroy() before freeing the arena.

>
>  	return &arena->map;
>  err:

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19363121319

--===============1334053399124491186==--

