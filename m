Return-Path: <bpf+bounces-74241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A1C4F2A6
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 926C04E2DB2
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C53339707;
	Tue, 11 Nov 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNuW5Rb5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D3173
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880475; cv=none; b=uIgnH6vzdtrDM1OTTz5zBum3U33nRV96vz8cKcJYX/6x2S5Vldi9nQmNl5ggqJO/3xerwECR7PbvKh+LCJ/m22W19FRbEj+9LeMsBteVeS0UQQf5J9RlRE5PblhMX/tO6szNmk8Z3X/9nEHSOmAtniFxGone1sIe4WETylO1y6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880475; c=relaxed/simple;
	bh=6HvuJ4Nfhtp22lv7s4PZIRYBq5f8VxqSwLUHpFReJcE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=koFqQQR9SjArtP0dGOSYcDZ45ODiPiGopFet8P0czYsbjBqjJP72EXhhjYRonUbKmdvOqawOR64eY9fkTK9R2eeUCM06j5tJbNuQ+W198H0DTfGqIE0Ckd/0ts0KkZ/NgZAuHc3KjiXQbHZJ16RWaZHa6qgx7NAb2jnFd9CPP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNuW5Rb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F516C116D0;
	Tue, 11 Nov 2025 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880475;
	bh=6HvuJ4Nfhtp22lv7s4PZIRYBq5f8VxqSwLUHpFReJcE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rNuW5Rb5zqofZMUXnZTP2xxC44ZPvcV/4q7TgN7lgeqmCFtcQuwltFXDszZ7YJjWz
	 XH3ZCYUzZsZv3QAaOpSheQIUuTHGgSJNFCPANmWJp/B0plduAKAzelvzwxaUl2IdbU
	 PM4KZj2gzzuGNFtVuJkREbtQEmhV266g5Eph2wFxNB2x9hT5B2L7pokHkCM1CKpTHI
	 yA8omLC8ABIMLwz1/ybLEqdOn7OefMpLQj47fZ/3bXu8SJ/+NzXBP6jVwMl+929lfm
	 gVgGWhKtR9wT6UNwx7NksMqhYgTyZ/ha9CrjnpjuqXDk98rNLZG+cV7o0gorHXAZc/
	 c00cbP8bffQNg==
Content-Type: multipart/mixed; boundary="===============2542208700318680381=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e04dae3b764c7076dd68094db235b0aab2683bf176b1bdb951e7b50137927553@mail.kernel.org>
In-Reply-To: <20251111163424.16471-3-puranjay@kernel.org>
References: <20251111163424.16471-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Nov 2025 17:01:15 +0000 (UTC)

--===============2542208700318680381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index dd5100a2f..9d8a8eb44 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -506,8 +506,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  			return 0;
>  	}
>
> -	/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
> -	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
> +	pages = kmalloc_nolock(page_cnt * sizeof(struct page *), __GFP_ZERO, -1);

Can kmalloc_nolock() handle the same allocation sizes as kvcalloc()?

Looking at arena_alloc_pages(), page_cnt can be up to the full arena
size (4GB / 4KB = 1M pages). This means the allocation size can reach
1M * 8 = 8MB for the pages array.

In mm/slub.c:5686, kmalloc_nolock() returns NULL for allocations larger
than KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) = 8KB on systems
with 4KB pages.

kvcalloc() could handle larger allocations by falling back to vmalloc.
With kmalloc_nolock(), arena allocations requiring more than 1024 pages
will fail where they previously succeeded.

For example, arena_alloc_pages(arena, 0, 1025, node_id) allocates
1025 * 8 = 8200 bytes, which exceeds the 8KB limit and will return NULL.

>  	if (!pages)
>  		return 0;
>
[ ... ]

> @@ -546,12 +545,12 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  			__free_page(pages[i]);
>  		goto out;
>  	}
> -	kvfree(pages);
> +	kfree_nolock(pages);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
>  	range_tree_set(&arena->rt, pgoff, page_cnt);
>  out_free_pages:
> -	kvfree(pages);
> +	kfree_nolock(pages);
>  	return 0;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19272481461

--===============2542208700318680381==--

