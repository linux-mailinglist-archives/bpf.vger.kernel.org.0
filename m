Return-Path: <bpf+bounces-76906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE2CC95DB
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CA130D08C2
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B59293C42;
	Wed, 17 Dec 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGKL9pts"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7322D29C7
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998415; cv=none; b=XNkJsdS0+OaemnUVUc06L/VSL3FF1vk+GPNffJsiyi5pj6c0cym9RzGrnv1iPs2eP4GCu1JvjAhuqFuiorxKOVMhsd3+d8HKm0Nwdp9cYt7pG/feJviHIy0uMW4Pb4Vc/OvcFdiN2Ty2/BiHhgf4nsoAKpzQzwhjaJUTNFFj6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998415; c=relaxed/simple;
	bh=B31QHAod5lFIrQCFE/R2n6Uxr3VOSVVBc61u+VsisTg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U27YpB96Kd6Tah3keLNE7gHjiSeEEgJdIBO55NEiiI8bVuJfAgYDMTg8XROayozmf0ty8Hq4e4lSYAegOxfn6KWWvxBPO1r87RVkz2QtFm6Ya7L+fofxeLPA9V8mHMsOT4v0LC+xyW4Z1N9NGlmZKvoPRVrUBo/meIFsj2rTT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGKL9pts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9600AC4CEF5;
	Wed, 17 Dec 2025 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765998414;
	bh=B31QHAod5lFIrQCFE/R2n6Uxr3VOSVVBc61u+VsisTg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OGKL9ptsCtGJNZvjhC+rkkDiUzCgqXeNWDsY0u4TgjnR5fv3EqTRvqQ3+NDDjf+XK
	 amwGg6kUBOyxe0GUhIre04y246L/zapNb08bYC6roFuVdQVixtZpqxo/D5kBMpNF8v
	 2d7+2AjBcgfMe0nAlNQkhA7+HK63IGfY9kubT2TEaxvDt3lbIgzoW1kUjNuiaU6PRN
	 EIW1rN/+5Q/zCdZ5R7JmokZGq6UqTRV/YCAM289zC/dg8Bsoo21/S0Fp0a1zca9g1J
	 n/RBcnJM3nnQTfirFYWYgzlYlPPvmsFj2FBCrTG6QH73RsUxTXZ8lWroLM2Y2nB9RP
	 TYeW4+6rnG/yA==
Content-Type: multipart/mixed; boundary="===============4069848939569761835=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a85d544551fcd6d0b770c1824dcce7e39caff71380a36fb77e33397fd2457bc@mail.kernel.org>
In-Reply-To: <20251217184438.3557859-2-puranjay@kernel.org>
References: <20251217184438.3557859-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: arena: populate vm_area without allocating memory
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Dec 2025 19:06:54 +0000 (UTC)

--===============4069848939569761835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 872dc0e41c65..039f25fc074b 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -7,6 +7,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/vmalloc.h>
>  #include <linux/pagemap.h>
> +#include <asm/tlbflush.h>
>  #include "range_tree.h"
>
>  /*
> @@ -92,6 +93,63 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
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
> +	page = d->pages[d->i];
> +	/* paranoia, similar to vmap_pages_pte_range() */
> +	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
> +		return -EINVAL;
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> +	d->i++;
> +	return 0;
> +}

The old code path used vm_area_map_pages() which calls vmap_pages_range(),
and vmap_pages_range() calls flush_cache_vmap() after setting up the
mappings. This new callback sets PTEs but doesn't flush the cache.

Several architectures (arc, nios2, sh, xtensa) have non-trivial
flush_cache_vmap() implementations that flush the entire cache or
specific ranges. Is the cache flush intentionally omitted here, or could
this cause stale cache data on those architectures?

[ ... ]

> @@ -428,7 +493,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  	/* user_vm_end/start are fixed before bpf prog runs */
>  	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
>  	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
> -	struct page **pages;
> +	struct page **pages = NULL;
> +	long mapped = 0;
>  	long pgoff = 0;
>  	u32 uaddr32;
>  	int ret, i;

[ ... ]

>
> +	struct apply_range_data data = { .pages = pages, .i = 0 };
>  	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>  	if (ret)
>  		goto out;
> @@ -477,17 +544,20 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
>  	 * lower 32-bit and it's ok.
>  	 */
> -	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
> -				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
> +	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> +				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
>  	if (ret) {
> -		for (i = 0; i < page_cnt; i++)
> +		mapped = data.i;
> +		for (i = mapped; i < page_cnt; i++)
>  			__free_page(pages[i]);
>  		goto out;
>  	}
>  	kvfree(pages);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +	if (mapped)
> +		arena_free_pages(arena, uaddr32, mapped);
>  out_free_pages:

The new error handling calls arena_free_pages() when apply_to_page_range()
partially succeeds. However, arena_alloc_pages() takes arena->lock via
guard(mutex) at the start of the function, and arena_free_pages() also
tries to take arena->lock via guard(mutex).

Doesn't this create a deadlock? The call path would be:

  arena_alloc_pages() takes lock ->
  apply_to_page_range() fails after mapping some pages ->
  arena_free_pages() tries to take the same lock ->
  deadlock

The old code didn't have this issue because vm_area_map_pages() would
either succeed completely or fail before any pages were mapped, so the
error path only freed page structures, not kernel mappings.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20313834837

--===============4069848939569761835==--

