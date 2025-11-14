Return-Path: <bpf+bounces-74511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368EC5CE48
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46233BBC83
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7A221DB6;
	Fri, 14 Nov 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1uoxou+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3D2877D5
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120371; cv=none; b=QihQ9mdnfuimzgzsKLdoY3SOATDQ4OrX0E2FBvcVL6ET1n4zQsmuyNLf5hrk0bfB1HNt8B9Wd5XG80qPk1Gm0p8fx3YWR9QcwQpEgElSrNjY5k/w2HyHsvWboauha2IquuRxgkTaYE1QRs3yDegXklRxPzE4GZR/bgKQpPp9qB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120371; c=relaxed/simple;
	bh=dINigCqtYDMJTGyd6buoXu9zLSusazcYlGDjYQK4btM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SAio7XUzvS5n/2X/9ZfbddK7jtOXrDPW11c5iOCNFGwGcVHnIwyeUx069UZL40QBD0U8q6COCI9bCylcWMb90SrjG6xJrL/AY2C0soYAm8RmDnwYm+PGi8KkcfkDDRtw0w3YOQlh51o7k1BnwL1ImQWsxn6E8/2cAoKeRDENvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1uoxou+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133BFC16AAE;
	Fri, 14 Nov 2025 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763120371;
	bh=dINigCqtYDMJTGyd6buoXu9zLSusazcYlGDjYQK4btM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=J1uoxou+wabQ8enuaSpDm+KJJQdUKvrGMB8yKdfNlGpaQg0Z8pjeo/6uaMoYxLz5d
	 VIVoapBOJcMyJpX7T73bpLouqntHeWcrzpaMhOh1q/K6nhY8oRUebhzv879RsSgi9Q
	 dB6PRo6lyEhtPrDenu0VthULal5PgS/+GwoDxil2Nosgg/Uq625pyeOSx93AmE/G3B
	 gQ0oTj0005QARax99AoriZi6dZECSpTVbEbyoPL2DurpRfQCIkR0Jyj5T6ui+/YAR7
	 HCoWl4mWtwiltSkEOM2b71gIMjHRA8bzeTrM/7AuUFZOwhfMiY52M0RHn0nvcdsZYM
	 /yuuYBebP55gg==
Content-Type: multipart/mixed; boundary="===============3648508565374726781=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c871e306ebf808780314848670550ae276b2a136bcd98e26e3f6de1a2c77d2b9@mail.kernel.org>
In-Reply-To: <20251114111700.43292-3-puranjay@kernel.org>
References: <20251114111700.43292-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 11:39:30 +0000 (UTC)

--===============3648508565374726781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 48b8ffba3..7fa6e40ab 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -528,32 +537,51 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	if (ret)
>  		goto out_free_pages;
>
> -	struct apply_range_data data = { .pages = pages, .i = 0 };
> -	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
> -	if (ret)
> -		goto out;
> -
> +	remaining = page_cnt;
>  	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> -	/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
> -	 * will not overflow 32-bit. Lower 32-bit need to represent
> -	 * contiguous user address range.
> -	 * Map these pages at kern_vm_start base.
> -	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
> -	 * lower 32-bit and it's ok.
> -	 */
> -	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> -				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
> -	if (ret) {
> -		for (i = 0; i < page_cnt; i++)
> -			__free_page(pages[i]);
> -		goto out;
> +
> +	while(remaining) {
> +		long this_batch = min(remaining, alloc_pages);
> +		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
> +		memset(pages, 0, this_batch * sizeof(struct page *));
> +		data.i = 0;
> +
> +		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
> +		if (ret)
> +			goto out;
> +
> +		/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
> +		 * will not overflow 32-bit. Lower 32-bit need to represent
> +		 * contiguous user address range.
> +		 * Map these pages at kern_vm_start base.
> +		 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
> +		 * lower 32-bit and it's ok.
> +		 */
> +		ret = apply_to_page_range(&init_mm,
> +					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
> +					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
> +		if (ret) {
> +			/* data.i pages were mapped, account them and free the remaining */
> +			mapped += data.i;
> +			for (i = data.i; i < this_batch; i++)
> +				__free_page(pages[i]);
> +			goto out;
> +		}
> +
> +		mapped += this_batch;
> +		remaining -= this_batch;
>  	}
> -	kvfree(pages);
> +	mutex_unlock(&arena->lock);
> +	kfree_nolock(pages);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +	mutex_unlock(&arena->lock);
> +	if (mapped)
> +		arena_free_pages(arena, clear_lo32(arena->user_vm_start) + uaddr32, mapped);
                                      ^^^^

Can arena_free_pages() be called here while holding arena->lock?
arena_free_pages() at line 618 acquires arena->lock using guard(mutex),
which will deadlock since the lock was already acquired at line 525 in
arena_alloc_pages().

> +out_free_pages:
> +	mutex_unlock(&arena->lock);
             ^^^^

Does this code unlock arena->lock twice in the error path? When the
"goto out" executes from the while loop, the mutex is unlocked at the
"out:" label above, then falls through to "out_free_pages:" and unlocks
again here.

> +	kfree_nolock(pages);
>  	return 0;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19363121319

--===============3648508565374726781==--

