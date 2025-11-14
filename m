Return-Path: <bpf+bounces-74519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4200C5DF97
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2661A3863C7
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A32331235;
	Fri, 14 Nov 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbbyIwY9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7033122A
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132274; cv=none; b=m3wM7NNhB8hNtg9f/yFvImZ3IoRXMZjMbSvAOAITSefeIJ7DO/Wl+ee/KbIIng5jH16wHfBrllz3Z+N0B2nOOeDOewKlZpOfFN1pdQVrlhSagB1Nk6MYADoPp+xvggdGyp50gaTA1E8odoVkMlXLlqULmAczwQZOx1fr+EemUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132274; c=relaxed/simple;
	bh=MY7clR5dNniRtgMJSoCyTwnIZV58Ijn96Zxx4z/ZHlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hri1lrrxuHNY+hgpX10ODVXGXAJO34pRD4cERbczcdUyr3VJWlgtuW4MMjCDjOLgcKV1qT9qsVqW5Ug4YQhz94/Xzk2//NjnkNjhPU+9usndrJub4jpvs6Q67dHSrpNhQ6DOBYW/Q/aUuKbxxgvTPcUJZo17qgM/Q16R82bl38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbbyIwY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A6AC4CEF5;
	Fri, 14 Nov 2025 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763132273;
	bh=MY7clR5dNniRtgMJSoCyTwnIZV58Ijn96Zxx4z/ZHlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qbbyIwY9l3vEoQFs6OqspJwgLhC0TQzbbEVlRpWIpCI7VXujcUc/p5efHxZuvVdqA
	 dI9rVE78ZXWEhfUJY5BHK9qIsCzIlrxbEb2r8918RAScXxQtMzCi07cAE8XcV8O4rh
	 CvIKpyK5Gsi9QTX/qbRP0qJo/xHrLHCVcjacd0r+UcE82Ln5CCWGtQtW+kg1tOCwda
	 3+r/kyAbUwF8VgVPKSi4lK9maG+LnDXWiaVbrdFSY+fe5j3eO7kPJq7nf0znBBtIy0
	 mVLQ7gL9fJPz1p89ApsTEXKACF/rZnXYAdM22ANqR+EVWRl/38ugxotQKDFb3yz7jc
	 yPE3S5l3GlsmA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 1/4] bpf: arena: populate vm_area without
 allocating memory
In-Reply-To: <5542c931e3200fd81c95abc6bbdfc1e37ca2951a9a480164558c05fe1b9044a4@mail.kernel.org>
References: <20251114111700.43292-2-puranjay@kernel.org>
 <5542c931e3200fd81c95abc6bbdfc1e37ca2951a9a480164558c05fe1b9044a4@mail.kernel.org>
Date: Fri, 14 Nov 2025 14:57:50 +0000
Message-ID: <mb61pms4ofyq9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 1074ac445..48b8ffba3 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> @@ -92,6 +93,62 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
>>  	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
>>  }
>>
>> +struct apply_range_data {
>> +	struct page **pages;
>> +	int i;
>> +};
>> +
>> +static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
>> +{
>> +	struct apply_range_data *d = data;
>> +	struct page *page;
>> +
>> +	if (!data)
>> +		return 0;
>> +	/* sanity check */
>> +	if (unlikely(!pte_none(ptep_get(pte))))
>> +		return -EBUSY;
>> +
>> +	page = d->pages[d->i++];
>> +	/* paranoia, similar to vmap_pages_pte_range() */
>> +	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>> +		return -EINVAL;
>> +
>> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
>> +	return 0;
>> +}
>> +
>> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
>> +{
>> +	pte_t old_pte;
>> +	struct page *page;
>> +
>> +	/* sanity check */
>> +	old_pte = ptep_get(pte);
>> +	if (pte_none(old_pte) || !pte_present(old_pte))
>> +		return 0; /* nothing to do */
>> +
>> +	/* get page and free it */
>> +	page = pte_page(old_pte);
>> +	if (WARN_ON_ONCE(!page))
>> +		return -EINVAL;
>> +
>> +	pte_clear(&init_mm, addr, pte);
>> +
>> +	/* ensure no stale TLB entries */
>> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +
>> +	__free_page(page);
>> +
>> +	return 0;
>> +}
>> +
>> +static int populate_pgtable_except_pte(struct bpf_arena *arena)
>> +{
>> +	return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
>> +				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, NULL);
>> +}
>> +
>>  static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>>  {
>>  	struct vm_struct *kern_vm;
>
> [ ... ]
>
>> @@ -144,6 +201,11 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>>  		goto err;
>>  	}
>>  	mutex_init(&arena->lock);
>> +	err = populate_pgtable_except_pte(arena);
>> +	if (err) {
>> +		bpf_map_area_free(arena);
>> +		goto err;
>> +	}
>                      ^^^^
>
> Can this leak the range tree? Looking at the code, range_tree_set() was
> called earlier in this function and can allocate range_node structures
> via range_tree_clear()->kmalloc_nolock(). If populate_pgtable_except_pte()
> fails here, the error path calls bpf_map_area_free(arena) but doesn't call
> range_tree_destroy(&arena->rt) first. Compare with arena_map_free() which
> always calls range_tree_destroy() before freeing the arena.

As the range tree is empty at this point, we can be sure that
range_tree_clear() in range_tree_set() will not allocate anything. 

>>
>>  	return &arena->map;
>>  err:
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19363121319

