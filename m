Return-Path: <bpf+bounces-62808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E091AFEEB4
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659811C20842
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338482C0327;
	Wed,  9 Jul 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RyNYcQyG"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD772DA743
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077391; cv=none; b=mwS/hPEpkhdvBPchZD2P4peVa/7TEyjxHWEoLPhRGuDyUg4GllwbTt4YC3SE5Nr187OXP7iATpWwTtNyeez4yTjF1f6SmkNUDpx7xfCV0bA6CmBenndsnp52Z/ZmhXO/kARRJl+iIHM6o00vZeGwfcBCQPBNsxPzcxZOOY1OY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077391; c=relaxed/simple;
	bh=qHCWWOyAQfjOYqvXB6ldUZNTyIV3q5zu9dppURhSHxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0VYpE09blvhepuVfrqxWCR9LYpqHIKnxs3tEna5V+aPYMWP86J18gh65rUJaY91N8MxtnGRvW0ymgsjteQhdTLOfSBXR1QZ52dSVQCrpp0Yk6m1Gq1JPjaS/qZn6StEf+IR0sKJS56YgSs98VJ3CZw/7QvrHjJP628pr3RWcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RyNYcQyG; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbbe127a-436a-459a-93d6-517e9377fa39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752077387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PradAITGF5prNVyuH8XR607H8+fPgrzCR0nu2aV95ms=;
	b=RyNYcQyGg55eGwcxwYz4SEmJ8O/lXik/M2sOH22VQkIgA77voECkH+4q9gI4v42dXNgdNu
	zNICAxexEnaCCUcH4jqb0Xh25R+SMM6cCfy6GYwmxLpFRplTMYrgDcVz2hGb5LwYNXHiyj
	jPoCVHWYi7gMWTZDIDjPcZW5FC3Hfdg=
Date: Wed, 9 Jul 2025 09:09:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] selftests/bpf: add selftests for
 bpf_arena_reserve_pages
Content-Language: en-GB
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, memxor@gmail.com,
 sched-ext@meta.com
References: <20250709015712.97099-1-emil@etsalapatis.com>
 <20250709015712.97099-3-emil@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250709015712.97099-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/25 6:57 PM, Emil Tsalapatis wrote:
> Add selftests for the new bpf_arena_reserve_pages kfunc.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

LGTM with some nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
>   .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
>   .../bpf/progs/verifier_arena_large.c          |  95 ++++++++++++++++
>   3 files changed, 204 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
> index 68a51dcc0669..16f8ce832004 100644
> --- a/tools/testing/selftests/bpf/bpf_arena_common.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_common.h
> @@ -46,8 +46,11 @@
>   
>   void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
>   				    int node_id, __u64 flags) __ksym __weak;
> +int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
>   void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
>   
> +#define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->user_vm_start)
> +
>   #else /* when compiled as user space code */
>   
>   #define __arena
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> index 67509c5d3982..35248b3327aa 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -114,6 +114,112 @@ int basic_alloc3(void *ctx)
>   	return 0;
>   }
>   
> +SEC("syscall")
> +__success __retval(0)
> +int basic_reserve1(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	char __arena *page;
> +	int ret;
> +
> +	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page)
> +		return 1;
> +
> +	page += __PAGE_SIZE;
> +
> +	/* Reserve the second page */
> +	ret = bpf_arena_reserve_pages(&arena, page, 1);
> +	if (ret)
> +		return 2;
> +
> +	/* Try to explicitly allocate the reserved page. */
> +	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
> +	if (page)
> +		return 3;
> +
> +	/* Try to implicitly allocate the page (since there's only 2 of them). */
> +	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (page)
> +		return 4;
> +#endif
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int basic_reserve2(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	char __arena *page;
> +	int ret;
> +
> +	page = arena_base(&arena);
> +	ret = bpf_arena_reserve_pages(&arena, page, 1);
> +	if (ret)
> +		return 1;
> +
> +	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
> +	if ((u64)page)
> +		return 2;
> +#endif
> +	return 0;
> +}
> +
> +/* Reserve the same page twice, should return -EBUSY. */
> +SEC("syscall")
> +__success __retval(0)
> +int reserve_twice(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	char __arena *page;
> +	int ret;
> +
> +	page = arena_base(&arena);
> +
> +	ret = bpf_arena_reserve_pages(&arena, page, 1);
> +	if (ret)
> +		return 1;
> +
> +	/* Should be -EBUSY. */
> +	ret = bpf_arena_reserve_pages(&arena, page, 1);
> +	if (ret != -16)
> +		return 2;

Maybe do the following is better:

#define EBUSY 16
...
if (ret != -EBUSY)
	return 2;


> +#endif
> +	return 0;
> +}
> +
> +/* Try to reserve past the end of the arena. */
> +SEC("syscall")
> +__success __retval(0)
> +int reserve_invalid_region(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	char __arena *page;
> +	int ret;
> +
> +	/* Try a NULL pointer. */
> +	ret = bpf_arena_reserve_pages(&arena, NULL, 3);
> +	if (ret != -22)
> +		return 1;

Same here.
#define EINVAL 22
...
if (ret != -EINVAL)
	return 1;
and a few cases below.

> +
> +	page = arena_base(&arena);
> +
> +	ret = bpf_arena_reserve_pages(&arena, page, 3);
> +	if (ret != -22)
> +		return 2;
> +
> +	ret = bpf_arena_reserve_pages(&arena, page, 4096);
> +	if (ret != -22)
> +		return 3;
> +
> +	ret = bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
> +	if (ret != -22)
> +		return 4;
> +#endif
> +	return 0;
> +}
> +
>   SEC("iter.s/bpf_map")
>   __success __log_level(2)
>   int iter_maps1(struct bpf_iter__bpf_map *ctx)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index f94f30cf1bb8..9eee51912280 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -67,6 +67,101 @@ int big_alloc1(void *ctx)
>   	return 0;
>   }
>   
> +/* Try to access a reserved page. Behavior should be identical with accessing unallocated pages. */
> +SEC("syscall")
> +__success __retval(0)
> +int access_reserved(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	volatile char __arena *page;
> +	char __arena *base;
> +	const size_t len = 4;
> +	int ret, i;
> +
> +	/* Get a separate region of the arena. */
> +	page = base = arena_base(&arena) + 16384 * PAGE_SIZE;
> +
> +	ret = bpf_arena_reserve_pages(&arena, base, len);
> +	if (ret)
> +		return 1;
> +
> +	/* Try to dirty reserved memory. */
> +	for (i = 0; i < len && can_loop; i++)
> +		*page = 0x5a;
> +
> +	for (i = 0; i < len && can_loop; i++) {
> +		page = (volatile char __arena *)(base + i * PAGE_SIZE);
> +
> +		/*
> +		 * Error out in case either the write went through,
> +		 * or the address has random garbage.
> +		 */
> +		if (*page == 0x5a)
> +			return 2 + 2 * i;
> +
> +		if (*page)
> +			return 2 + 2 * i + 1;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +/* Try to allocate a region overlapping with a reservation. */
> +SEC("syscall")
> +__success __retval(0)
> +int request_partially_reserved(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	volatile char __arena *page;
> +	char __arena *base;
> +	int ret;
> +
> +	/* Add an arbitrary page offset. */
> +	page = base = arena_base(&arena) + 4096 * __PAGE_SIZE;
> +
> +	ret = bpf_arena_reserve_pages(&arena, base + 3 * __PAGE_SIZE, 4);
> +	if (ret)
> +		return 1;
> +
> +	page = bpf_arena_alloc_pages(&arena, base, 5, NUMA_NO_NODE, 0);
> +	if ((u64)page != 0ULL)
> +		return 2;
> +#endif
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__success __retval(0)
> +int free_reserved(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	char __arena *addr;
> +	char __arena *page;
> +	int ret;
> +
> +	/* Add an arbitrary page offset. */
> +	addr = arena_base(&arena) + 32768 * __PAGE_SIZE;
> +
> +	page = bpf_arena_alloc_pages(&arena, addr, 4, NUMA_NO_NODE, 0);
> +	if (!page)
> +		return 1;
> +
> +	ret = bpf_arena_reserve_pages(&arena, addr + 4 * __PAGE_SIZE, 4);
> +	if (ret)
> +		return 2;
> +

[...]

> +	/* Freeing a reserved area, fully or partially, should succeed. */

You are not freeing a reserved area below. Actually you freeing an allocated area.
Maybe you need to add addr argument with 4 * __PAGE_SIZE?

> +	bpf_arena_free_pages(&arena, addr, 2);
> +	bpf_arena_free_pages(&arena, addr + 2 * __PAGE_SIZE, 2);
> +
> +	/* The free pages call above should have succeeded, so this allocation should too. */
> +	page = bpf_arena_alloc_pages(&arena, addr + 3 * __PAGE_SIZE, 1, NUMA_NO_NODE, 0);
> +	if (!page)
> +		return 3;
> +#endif
> +	return 0;
> +}
> +
>   #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   #define PAGE_CNT 100
>   __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */


