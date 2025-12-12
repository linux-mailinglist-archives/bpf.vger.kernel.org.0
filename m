Return-Path: <bpf+bounces-76500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21410CB7806
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 02:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A02301D668
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8C26FA6E;
	Fri, 12 Dec 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcUicZ9s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668C221FD0
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501512; cv=none; b=nkNifxy+5gCXbSMIcKJBHX9E0Vx0LmvPtSVseWLJlQvUzgD1/DEksR7pq+BeBKAJyL5E/nX6d2d1p+sAu23985VllxNpy3D642tnQaptZD87AvqzhUad0RuH+N0Nn0UficsNxtZhnlC1dntIR6XksVaqVw9kQ5LmlpaUKo1Eb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501512; c=relaxed/simple;
	bh=YDLbFBYEwlX73pXFaA0x83W9e3+BYORFhexxI8iILrM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ds7VF52/lDxcSz5z3iqQ2tRoyW1ma7SbTCmtbFC/h2JwGxtg5WKXkT2kynnVcY4XE5YNX+uizinFqn+88N20jLtzVLBq2MrzOLvVCGTvIar42IOJtnaDGTM5+BmNmgMCpmm7TlMwSKZzoRHq7m6cM0YYW6/w2aQmP+eC2+Qni4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcUicZ9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0D2C4CEF7;
	Fri, 12 Dec 2025 01:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765501512;
	bh=YDLbFBYEwlX73pXFaA0x83W9e3+BYORFhexxI8iILrM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AcUicZ9sITCgGG1+0jBtxMxU7Ll2e+h+a5XaMs5Q7a/MBIK502WFxcn4ip8P51Dy7
	 I9VgXvJVW2kL0vYquhMwFtCSyEMfbn2vStelczlsm0sTJkeV1urQcdcxiDRmsVWf1/
	 nThDPlqj6kPaio4khFNQ3WXeUs7ircc6QnwJ4fW9BDyjbFnd5l5b5bK39313JDKF1X
	 cwsxmY/t4KUuvJ09x6uCfvRM2Vg1DxPT49DlIXldEUWfAGr+PdY0ct/namMIyuPhiX
	 OnIN2ORbdBHGxjhb94+lvidgNIr7IXK31b56lwwOaugPQwTtmn4uqYPDU7h1mKxAUO
	 XFmNILfY1QiEg==
Content-Type: multipart/mixed; boundary="===============8033971715467952224=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a493961a3e344496c8a1333525c15d995a3f0742ac8a2cc21ddf58cc0f5d647@mail.kernel.org>
In-Reply-To: <20251212004350.6520-2-puranjay@kernel.org>
References: <20251212004350.6520-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: arena: populate vm_area without allocating memory
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Dec 2025 01:05:11 +0000 (UTC)

--===============8033971715467952224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1074ac4459f2..214a4da54162 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -465,6 +529,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	if (ret)
>  		goto out_free_pages;
>
> +	struct apply_range_data data = { .pages = pages, .i = 0 };
>  	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>  	if (ret)
>  		goto out;
> @@ -477,8 +542,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
                        ^^^^

Can this create PTEs pointing to freed memory? If apply_to_page_range()
fails after partially setting PTEs, the callback will have been invoked
multiple times, and data.i will reflect how many PTEs were successfully
set. The error path frees all pages in the array, including those that
were already mapped into PTEs.

Later access to those addresses via arena_vm_fault()->vmalloc_to_page()
or arena_free_pages()->vmalloc_to_page() would return pointers to the
freed pages, leading to use-after-free.

The next commit (3b7e9448213a) fixes this by tracking data.i and only
freeing pages that weren't successfully mapped.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20152458491

--===============8033971715467952224==--

