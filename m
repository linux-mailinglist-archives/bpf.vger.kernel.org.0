Return-Path: <bpf+bounces-44972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4299CF182
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1EC295C1B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683181D47AE;
	Fri, 15 Nov 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YjxND6d6"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B61632F1
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688249; cv=none; b=HRghq+YFKfg9t6+Lcblq9HATUHNNmhHqlD7jmZgj7MXB8GDq6qXu5B+F1buZwgbntpuUPxykuCsB4tIx+oZ58WpS66usaxnK/Py/oTvhqpXZYlvYzKDLq2cl3nUgsKmYfdN+mwtGHprAKFOUbI0Z+Ldzcb854/1hKPCLI/BKcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688249; c=relaxed/simple;
	bh=Pe8fJkgd7Zaskzc42ork99f0MYlSn6Ce3xgfqCRmM8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MK/yzyCzKKZrIP4To3OLD3Pg9X6unj9pxH1BVzZeZGh+qydv0SOhn+rz8Z+Jon3zyLeiW85MeW9y6QvSJDvKUQ82ZBP+8+gJ/MsB57YDsTC5m4ce2eYmK7tpmh9oSmVkDz+b4XcoVEQLRbMBuu2xKQXkXFiGoVPCIaRZFPFz7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YjxND6d6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c98dc9c-0014-49a1-8d7a-910f0992cccc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731688245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y40YgIL3ENozyFk1Cl+tmCyVKVUxE9kL63oUaS5z6t8=;
	b=YjxND6d69F+tiCJzDyBljTtuWRy4Z8up7O7kWTQHvUdBWDHAwV9MGz8n3y1ykN4L/xFEDR
	s1CPuTP4mQcZXhvlDcFxajswBMSyw66GuvKVpN2Ta/xQ3yRoM8W3shoCVn3GK96IUNpIlI
	9wVGe/whZ3TUVGtp2emQpTxBmhkHPIk=
Date: Fri, 15 Nov 2024 08:30:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for arena range
 tree algorithm
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 djwong@kernel.org, kernel-team@fb.com
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
 <20241108025616.17625-3-alexei.starovoitov@gmail.com>
 <Zzc8pVMtTAkqUdvA@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zzc8pVMtTAkqUdvA@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/15/24 4:20 AM, Jiri Olsa wrote:
> On Thu, Nov 07, 2024 at 06:56:16PM -0800, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Add a test that verifies specific behavior of arena range tree
>> algorithm and just existing bif_alloc1 test due to use
>> of global data in arena.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>   .../bpf/progs/verifier_arena_large.c          | 110 +++++++++++++++++-
>>   1 file changed, 108 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> index 6065f862d964..8a9af79db884 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> @@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
>>   	if (!page1)
>>   		return 1;
>>   	*page1 = 1;
>> -	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
>> +	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
>>   				      1, NUMA_NO_NODE, 0);
>>   	if (!page2)
>>   		return 2;
>>   	*page2 = 2;
>> -	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
>> +	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
>>   					1, NUMA_NO_NODE, 0);
>>   	if (no_page)
>>   		return 3;
>> @@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
>>   #endif
>>   	return 0;
>>   }
>> +
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>> +#define PAGE_CNT 100
>> +__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
>> +__u8 __arena *base;
>> +
>> +/*
>> + * Check that arena's range_tree algorithm allocates pages sequentially
>> + * on the first pass and then fills in all gaps on the second pass.
>> + */
>> +__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
>> +		int max_idx, int step)
>> +{
>> +	__u8 __arena *pg;
>> +	int i, pg_idx;
>> +
>> +	for (i = 0; i < page_cnt; i++) {
>> +		pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
>> +					   NUMA_NO_NODE, 0);
>> +		if (!pg)
>> +			return step;
>> +		pg_idx = (pg - base) / PAGE_SIZE;
> hi,
> I'm getting compile error below with clang 20.0.0:
>
>        CLNG-BPF [test_progs] verifier_arena_large.bpf.o
>      progs/verifier_arena_large.c:90:24: error: unsupported signed division, please convert to unsigned div/mod.
>         90 |                 pg_idx = (pg - base) / PAGE_SIZE;
>
> should we just convert it to unsigned div like below?
>
> also I saw recent llvm change [1] that might help, I'll give it a try

I am using latest clang 20 and compilation is successful due to the llvm change [1].

>
> jirka
>
>
> [1] 38a8000f30aa [BPF] Use mul for certain div/mod operations (#110712)
> ---
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index 8a9af79db884..e743d008697e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -87,7 +87,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
>   					   NUMA_NO_NODE, 0);
>   		if (!pg)
>   			return step;
> -		pg_idx = (pg - base) / PAGE_SIZE;
> +		pg_idx = (unsigned int) (pg - base) / PAGE_SIZE;
>   		if (first_pass) {
>   			/* Pages must be allocated sequentially */
>   			if (pg_idx != i)

I think this patch is still good.
Compiling the current verifier_arena_large.c will be okay for llvm <= 18 and >= 20.
But llvm19 will have compilation failure as you mentioned in the above.

So once bpf ci upgrades compiler to llvm19 we will see the above compilation failure.

Please verifify it as well. If this is the case in your side, please submit a patch.
Thanks!


