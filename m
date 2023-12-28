Return-Path: <bpf+bounces-18701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BBC81F379
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 01:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6103A1C22790
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978131104;
	Thu, 28 Dec 2023 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaxNWeJo"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554210E3
	for <bpf@vger.kernel.org>; Thu, 28 Dec 2023 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e19d402-ee59-42e3-be27-838d834d3477@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703724588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9i19dPoGIuLs7roVLcxtYB3uFpdkh5lUpBaLUlaxSvg=;
	b=XaxNWeJoRWotifKXHnW9hIEu56V36k3k5EyIFLdKBIiVhU/HQjc7Gqbexr6mZOIIffgEnL
	11IHk851BoOKMCRTJidxkSUR/8J2DSKCuv7RMnqZZmiOaltmkmkobmeEUgx5V2tF+hLVQU
	9byXpMU1RvQU6Uk1eZ91bkLFJiBs884=
Date: Wed, 27 Dec 2023 16:49:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 0/8] bpf: Reduce memory usage for
 bpf_global_percpu_ma
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231222031729.1287957-1-yonghong.song@linux.dev>
 <cb8edf4b-f585-4e3e-9bed-10f5b36e427c@huaweicloud.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cb8edf4b-f585-4e3e-9bed-10f5b36e427c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/22/23 1:35 AM, Hou Tao wrote:
> Hi,
>
> On 12/22/2023 11:17 AM, Yonghong Song wrote:
>> Currently when a bpf program intends to allocate memory for percpu kptr,
>> the verifier will call bpf_mem_alloc_init() to prefill all supported
>> unit sizes and this caused memory consumption very big for large number
>> of cpus. For example, for 128-cpu system, the total memory consumption
>> with initial prefill is ~175MB. Things will become worse for systems
>> with even more cpus.
>>
>> Patch 1 avoids unnecessary extra percpu memory allocation.
>> Patch 2 adds objcg to bpf_mem_alloc at init stage so objcg can be
>> associated with root cgroup and objcg can be passed to later
>> bpf_mem_alloc_percpu_unit_init().
>> Patch 3 addresses memory consumption issue by avoiding to prefill
>> with all unit sizes, i.e. only prefilling with user specified size.
>> Patch 4 further reduces memory consumption by limiting the
>> number of prefill entries for percpu memory allocation.
>> Patch 5 has much smaller low/high watermarks for percpu allocation
>> to reduce memory consumption.
>> Patch 6 rejects percpu memory allocation with bpf_global_percpu_ma
>> when allocation size is greater than 512 bytes.
>> Patch 7 fixed test_bpf_ma test due to Patch 5.
>> Patch 8 added one test to show the verification failure log message.
> FYI. After applying the patch set, the memory consumption in bpf memory
> benchmark [1] on 8-CPU VM decreases a lot:
>
> Before the patch set:
>
> $ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |
> grep Summary
> Summary: per-prod alloc   14.16 ± 0.59M/s free   36.18 ± 0.39M/s, total
> memory usage  183.71 ± 10.38MiB
> Summary: per-prod alloc   12.35 ± 1.10M/s free   35.79 ± 0.51M/s, total
> memory usage  744.52 ± 11.64MiB
> Summary: per-prod alloc   11.15 ± 0.20M/s free   35.72 ± 0.27M/s, total
> memory usage 2545.98 ± 537.57MiB
>
> After the patch set:
>
> $ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |
> grep Summary
> Summary: per-prod alloc    0.86 ± 0.00M/s free   37.29 ± 0.11M/s, total
> memory usage    0.00 ± 0.00MiB
> Summary: per-prod alloc    0.85 ± 0.00M/s free   36.70 ± 0.24M/s, total
> memory usage    0.00 ± 0.00MiB
> Summary: per-prod alloc    0.84 ± 0.00M/s free   37.21 ± 0.17M/s, total
> memory usage    0.00 ± 0.00MiB
>
> However the allocation performance also degrades a lot. It seems it is
> due to patch 5 (bpf: Use smaller low/high marks for percpu allocation),
> because c->batch is 1 now, so each allocation needs one run of irq_work.

Thanks for benchmarking! With low watermark to be 1 and c->batch to 1
as well, there will be more overhead due to irq_work. In practice,
I expect we should not see a lot of such percpu map element updates or
percpu kptr allocaitons.

>
> [1]:
> https://lore.kernel.org/bpf/20231221141501.3588586-1-houtao@huaweicloud.com/
>> Changelogs:
>>    v5 -> v6:
>>      . Change bpf_mem_alloc_percpu_init() to add objcg as one of parameters.
>>        For bpf_global_percpu_ma, the objcg is NULL, corresponding root memcg.
>>    v4 -> v5:
>>      . Do not do bpf_global_percpu_ma initialization at init stage, instead
>>        doing initialization when the verifier knows it is going to be used
>>        by bpf prog.
>>      . Using much smaller low/high watermarks for percpu allocation.
>>    v3 -> v4:
>>      . Add objcg to bpf_mem_alloc during init stage.
>>      . Initialize objcg at init stage but use it in bpf_mem_alloc_percpu_unit_init().
>>      . Remove check_obj_size() in bpf_mem_alloc_percpu_unit_init().
>>    v2 -> v3:
>>      . Clear the bpf_mem_cache if prefill fails.
>>      . Change test_bpf_ma percpu allocation tests to use bucket_size
>>        as allocation size instead of bucket_size - 8.
>>      . Remove __GFP_ZERO flag from __alloc_percpu_gfp() call.
>>    v1 -> v2:
>>      . Avoid unnecessary extra percpu memory allocation.
>>      . Add a separate function to do bpf_global_percpu_ma initialization
>>      . promote.
>>      . Promote function static 'sizes' array to file static.
>>      . Add comments to explain to refill only one item for percpu alloc.
>>
>> Yonghong Song (8):
>>    bpf: Avoid unnecessary extra percpu memory allocation
>>    bpf: Add objcg to bpf_mem_alloc
>>    bpf: Allow per unit prefill for non-fix-size percpu memory allocator
>>    bpf: Refill only one percpu element in memalloc
>>    bpf: Use smaller low/high marks for percpu allocation
>>    bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
>>    selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
>>    selftests/bpf: Add a selftest with > 512-byte percpu allocation size
>>
>>   include/linux/bpf_mem_alloc.h                 |  8 ++
>>   kernel/bpf/memalloc.c                         | 93 ++++++++++++++++---
>>   kernel/bpf/verifier.c                         | 45 ++++++---
>>   .../selftests/bpf/prog_tests/test_bpf_ma.c    | 20 ++--
>>   .../selftests/bpf/progs/percpu_alloc_fail.c   | 18 ++++
>>   .../testing/selftests/bpf/progs/test_bpf_ma.c | 66 ++++++-------
>>   6 files changed, 184 insertions(+), 66 deletions(-)
>>

