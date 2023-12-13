Return-Path: <bpf+bounces-17685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8801811AEA
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51728B20480
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BBC56B7A;
	Wed, 13 Dec 2023 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4U3soXs"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84199
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:26:00 -0800 (PST)
Message-ID: <b917b011-545a-4804-b8b4-06b412e16610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702488358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqhYE0qRPS5MXnIouVC995+UobHLK6bjkNXqr+QueAM=;
	b=v4U3soXs9D53txzuFvc5w0/MH0FAHPtrpTzdtCQ3YottBrMDpzJPzd7P87/3SC2RfmAU/5
	35FixLA/iXaYMMdUzlRWVXX1Y2aIhppcWU7xG6BVwAUt2ivfpChHn5qGuFyrSXbaQ+ZlWA
	ixelzo2U+iADre/J5FAgtfmn12QbHOU=
Date: Wed, 13 Dec 2023 09:25:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Allow per unit prefill for non-fix-size
 percpu memory allocator
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
 <20231212223050.2137647-1-yonghong.song@linux.dev>
 <ab1146fa-db28-c1a3-bfef-3dc7b1575738@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ab1146fa-db28-c1a3-bfef-3dc7b1575738@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 3:03 AM, Hou Tao wrote:
> Hi,
>
> On 12/13/2023 6:30 AM, Yonghong Song wrote:
>> Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem allocation")
>> added support for non-fix-size percpu memory allocation.
>> Such allocation will allocate percpu memory for all buckets on all
>> cpus and the memory consumption is in the order to quadratic.
>> For example, let us say, 4 cpus, unit size 16 bytes, so each
>> cpu has 16 * 4 = 64 bytes, with 4 cpus, total will be 64 * 4 = 256 bytes.
>> Then let us say, 8 cpus with the same unit size, each cpu
>> has 16 * 8 = 128 bytes, with 8 cpus, total will be 128 * 8 = 1024 bytes.
>> So if the number of cpus doubles, the number of memory consumption
>> will be 4 times. So for a system with large number of cpus, the
>> memory consumption goes up quickly with quadratic order.
>> For example, for 4KB percpu allocation, 128 cpus. The total memory
>> consumption will 4KB * 128 * 128 = 64MB. Things will become
>> worse if the number of cpus is bigger (e.g., 512, 1024, etc.)
>>
>> In Commit 41a5db8d8161, the non-fix-size percpu memory allocation is
>> done in boot time, so for system with large number of cpus, the initial
>> percpu memory consumption is very visible. For example, for 128 cpu
>> system, the total percpu memory allocation will be at least
>> (16 + 32 + 64 + 96 + 128 + 196 + 256 + 512 + 1024 + 2048 + 4096)
>>    * 128 * 128 = ~138MB.
>> which is pretty big. It will be even bigger for larger number of cpus.
>>
>> Note that the current prefill also allocates 4 entries if the unit size
>> is less than 256. So on top of 138MB memory consumption, this will
>> add more consumption with
>> 3 * (16 + 32 + 64 + 96 + 128 + 196 + 256) * 128 * 128 = ~38MB.
>> Next patch will try to reduce this memory consumption.
>>
>> Later on, Commit 1fda5bb66ad8 ("bpf: Do not allocate percpu memory
>> at init stage") moved the non-fix-size percpu memory allocation
>> to bpf verificaiton stage. Once a particular bpf_percpu_obj_new()
>> is called by bpf program, the memory allocator will try to fill in
>> the cache with all sizes, causing the same amount of percpu memory
>> consumption as in the boot stage.
>>
>> To reduce the initial percpu memory consumption for non-fix-size
>> percpu memory allocation, instead of filling the cache with all
>> supported allocation sizes, this patch intends to fill the cache
>> only for the requested size. As typically users will not use large
>> percpu data structure, this can save memory significantly.
>> For example, the allocation size is 64 bytes with 128 cpus.
>> Then total percpu memory amount will be 64 * 128 * 128 = 1MB,
>> much less than previous 138MB.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf_mem_alloc.h |  5 +++
>>   kernel/bpf/memalloc.c         | 62 +++++++++++++++++++++++++++++++++++
>>   kernel/bpf/verifier.c         | 23 +++++--------
>>   3 files changed, 75 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
>> index bb1223b21308..b049c580e7fb 100644
>> --- a/include/linux/bpf_mem_alloc.h
>> +++ b/include/linux/bpf_mem_alloc.h
>> @@ -21,8 +21,13 @@ struct bpf_mem_alloc {
>>    * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
>>    * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
>>    * the returned object is given by the size argument of bpf_mem_alloc().
>> + * If percpu equals true, error will be returned in order to avoid
>> + * large memory consumption and the below bpf_mem_alloc_percpu_unit_init()
>> + * should be used to do on-demand per-cpu allocation for each size.
>>    */
>>   int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
>> +/* The percpu allocation is allowed for different unit size. */
>> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
>>   void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>>   
>>   /* kmalloc/kfree equivalent: */
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 75068167e745..84987e97fd0a 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -526,6 +526,9 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>>   	struct bpf_mem_cache *c, __percpu *pc;
>>   	struct obj_cgroup *objcg = NULL;
>>   
>> +	if (percpu && size == 0)
>> +		return -EINVAL;
>> +
>>   	/* room for llist_node and per-cpu pointer */
>>   	if (percpu)
>>   		percpu_size = LLIST_NODE_SZ + sizeof(void *);
>> @@ -625,6 +628,65 @@ static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
>>   	drain_mem_cache(c);
>>   }
>>   
>> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>> +{
>> +	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
> Why duplicate the sizes array ? It is better to move it out of these
> functions and share it between both bpf_mem_alloc_ini() and
> bpf_mem_alloc_percpu_unit_init().

Good point. Will do in the next revision.

>
>> +	int cpu, i, err, unit_size, percpu_size = 0;
>> +	struct bpf_mem_caches *cc, __percpu *pcc;
>> +	struct obj_cgroup *objcg = NULL;
>> +	struct bpf_mem_cache *c;
>> +
>> +	/* room for llist_node and per-cpu pointer */
>> +	percpu_size = LLIST_NODE_SZ + sizeof(void *);
>> +
>> +	if (ma->caches) {
>> +		pcc = ma->caches;
>> +	} else {
>> +		ma->percpu = true;
>> +		pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL | __GFP_ZERO);
>> +		if (!pcc)
>> +			return -ENOMEM;
>> +		ma->caches = pcc;
>> +	}
> It is a little weird to me that a single API does two things:
> initialization and incremental refill. How about introducing two APIs to
> reduce the memory usage of global per-cpu ma: one API to initialize the
> global per-cpu ma in bpf_global_ma_init(), and another API to
> incremental refill global per-cpu ma accordingly ?

This can ineed to make semantics and code easy to understand.
Will make the change in the next revision.

>> +
>> +	err = 0;
>> +	i = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
>> +	if (i < 0) {
>> +		err = -EINVAL;
>> +		goto out;
>> +	}
>> +	unit_size = sizes[i];
>> +
[...]

