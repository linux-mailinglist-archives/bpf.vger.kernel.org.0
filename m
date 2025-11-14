Return-Path: <bpf+bounces-74520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E9C5E2A9
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEA403A354A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2732939A;
	Fri, 14 Nov 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQIubY2r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E53329382
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133186; cv=none; b=omNedBWrvqsaRzZIGD8+vOajN/Lw+02TJh8ZmgKmUICJJH7bJ7f8GZdrVnr6B+wOLfbOG/xvobwiHDHjTOReqSgN1dKPQMbzAc+dPIE2xd6fh0mBAWeVZq2JSWn9+nDvmlrzEJO4AE5gPViUNy/Q14OWiUVE2SWOJfuPctIaNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133186; c=relaxed/simple;
	bh=3egq2h7Dxes4ZoZCZ0HLD51VHYDp1SuYuxuVxAO4P+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZczMNbE/d8WbMnzHuO7nrJ7iagP3Zwx4NW9cR/c4/dGyHgCaptZpEL2zKBi9IAhT8fhYy+c+o/bBsHvGkKjlEwAt+TOqWs7L5n4AabttR0GNBeJzRnkbjeVGZvwEOHDi5aF0sED+T2lI14jhlulOY0O3gKaExL+zKrPDVhQIGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQIubY2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCCFC4CEF5;
	Fri, 14 Nov 2025 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763133186;
	bh=3egq2h7Dxes4ZoZCZ0HLD51VHYDp1SuYuxuVxAO4P+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pQIubY2r6jlRwCaCJCMzBU1NiyFend6CDQtYZ84aK7TTAmJ1Z1iOpKyXGcubmGdgr
	 n1TmjqdoZdCgSnOXmDjjqYtv0mcyGSFWhkDHV2DyhzgPG2PwLn1mR58nNX4B9lmGEV
	 NztcqQ1ij3NlVU/p79Eho/3n87/+Gfvzj+MOPQlXsAr2MPFuubm1xZjR0w3p20EkLs
	 /p3ijTvFBMB9qyGm96iNLn7i1db4CPChLhbyHTyjaoAl2e1lZp6UG5ZsVMIlVYGQ9n
	 xnFALrCs1nVxlFxdKoVTek5I4gzhzGprJWLAuaUTOnlwPkFTNfMnnDpU6/SDdsBjd3
	 0hzRV267hcGMQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 2/4] bpf: arena: use kmalloc_nolock() in
 place of kvcalloc()
In-Reply-To: <c871e306ebf808780314848670550ae276b2a136bcd98e26e3f6de1a2c77d2b9@mail.kernel.org>
References: <20251114111700.43292-3-puranjay@kernel.org>
 <c871e306ebf808780314848670550ae276b2a136bcd98e26e3f6de1a2c77d2b9@mail.kernel.org>
Date: Fri, 14 Nov 2025 15:13:02 +0000
Message-ID: <mb61p5xbc641t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 48b8ffba3..7fa6e40ab 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> @@ -528,32 +537,51 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>>  	if (ret)
>>  		goto out_free_pages;
>>
>> -	struct apply_range_data data = { .pages = pages, .i = 0 };
>> -	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>> -	if (ret)
>> -		goto out;
>> -
>> +	remaining = page_cnt;
>>  	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
>> -	/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
>> -	 * will not overflow 32-bit. Lower 32-bit need to represent
>> -	 * contiguous user address range.
>> -	 * Map these pages at kern_vm_start base.
>> -	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
>> -	 * lower 32-bit and it's ok.
>> -	 */
>> -	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
>> -				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
>> -	if (ret) {
>> -		for (i = 0; i < page_cnt; i++)
>> -			__free_page(pages[i]);
>> -		goto out;
>> +
>> +	while(remaining) {
>> +		long this_batch = min(remaining, alloc_pages);
>> +		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
>> +		memset(pages, 0, this_batch * sizeof(struct page *));
>> +		data.i = 0;
>> +
>> +		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
>> +		if (ret)
>> +			goto out;
>> +
>> +		/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
>> +		 * will not overflow 32-bit. Lower 32-bit need to represent
>> +		 * contiguous user address range.
>> +		 * Map these pages at kern_vm_start base.
>> +		 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
>> +		 * lower 32-bit and it's ok.
>> +		 */
>> +		ret = apply_to_page_range(&init_mm,
>> +					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
>> +					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
>> +		if (ret) {
>> +			/* data.i pages were mapped, account them and free the remaining */
>> +			mapped += data.i;
>> +			for (i = data.i; i < this_batch; i++)
>> +				__free_page(pages[i]);
>> +			goto out;
>> +		}
>> +
>> +		mapped += this_batch;
>> +		remaining -= this_batch;
>>  	}
>> -	kvfree(pages);
>> +	mutex_unlock(&arena->lock);
>> +	kfree_nolock(pages);
>>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>>  out:
>> -	range_tree_set(&arena->rt, pgoff, page_cnt);
>> +	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
>> +	mutex_unlock(&arena->lock);
>> +	if (mapped)
>> +		arena_free_pages(arena, clear_lo32(arena->user_vm_start) + uaddr32, mapped);
>                                       ^^^^
>
> Can arena_free_pages() be called here while holding arena->lock?
> arena_free_pages() at line 618 acquires arena->lock using guard(mutex),
> which will deadlock since the lock was already acquired at line 525 in
> arena_alloc_pages().

arena_free_pages() will not be called with arena->lock taken, there is
mutex_unlock() before calling arena_free_pages()

>> +out_free_pages:
>> +	mutex_unlock(&arena->lock);
>              ^^^^
>
> Does this code unlock arena->lock twice in the error path? When the
> "goto out" executes from the while loop, the mutex is unlocked at the
> "out:" label above, then falls through to "out_free_pages:" and unlocks
> again here.

This is fixed by the next patch by adding another label, but I missed it
here.
Will fix it in the next version.

>> +	kfree_nolock(pages);
>>  	return 0;
>>  }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19363121319

