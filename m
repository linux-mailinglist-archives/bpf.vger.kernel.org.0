Return-Path: <bpf+bounces-17963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4BE8141FE
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B02836CE
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22532D27D;
	Fri, 15 Dec 2023 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cSb745NF"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11B11CA9
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d22fb5f7-9b51-47c4-93d2-69064f2fb550@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702623067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sJhptAwudjgBm+Vvp927KUt2AVw+5+lbcZ/j2jlews=;
	b=cSb745NFZ2t/mdbeeXli5Iq2N/Bn3abo/CBVj6L9xLpHEGckMvcihh9wQh8VqitCRIQMzQ
	zOHvdHjMWfutqaHnuoU13+V5Vh09SeNKkL4GaHoxHi2GTajyp9lYsylkcLASLDL34o250/
	d+JkGEmsF//yhtRYbGYRC8GiLj4vL0g=
Date: Thu, 14 Dec 2023 22:50:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001209.3252729-1-yonghong.song@linux.dev>
 <a8856c91-b8af-2293-3505-7a20d79cc89c@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a8856c91-b8af-2293-3505-7a20d79cc89c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/14/23 7:19 PM, Hou Tao wrote:
>
> On 12/15/2023 8:12 AM, Yonghong Song wrote:
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
> SNIP
>> index bb1223b21308..43e635c67150 100644
>> --- a/include/linux/bpf_mem_alloc.h
>> +++ b/include/linux/bpf_mem_alloc.h
>> @@ -21,8 +21,15 @@ struct bpf_mem_alloc {
>>    * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
>>    * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
>>    * the returned object is given by the size argument of bpf_mem_alloc().
>> + * If percpu equals true, error will be returned in order to avoid
>> + * large memory consumption and the below bpf_mem_alloc_percpu_unit_init()
>> + * should be used to do on-demand per-cpu allocation for each size.
>>    */
>>   int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
>> +/* Initialize a non-fix-size percpu memory allocator */
>> +int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma);
>> +/* The percpu allocation with a specific unit size. */
>> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
>>   void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>>   
>>   /* kmalloc/kfree equivalent: */
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index c34513d645c4..4a9177770f93 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -64,8 +64,8 @@
>>   #define OFF	insn->off
>>   #define IMM	insn->imm
>>   
>> -struct bpf_mem_alloc bpf_global_ma;
>> -bool bpf_global_ma_set;
>> +struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
>> +bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>>   
>>   /* No hurry in this branch
>>    *
>> @@ -2938,7 +2938,9 @@ static int __init bpf_global_ma_init(void)
>>   
>>   	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>>   	bpf_global_ma_set = !ret;
>> -	return ret;
>> +	ret = bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
>> +	bpf_global_percpu_ma_set = !ret;
>> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>>   }
>>   late_initcall(bpf_global_ma_init);
>>   #endif
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 472158f1fb08..aea4cd07c7b6 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -121,6 +121,8 @@ struct bpf_mem_caches {
>>   	struct bpf_mem_cache cache[NUM_CACHES];
>>   };
>>   
>> +static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
> Is it better to make it being const ?

Right. We can make it as const.

>> +
>>   static struct llist_node notrace *__llist_del_first(struct llist_head *head)
>>   {
>>   	struct llist_node *entry, *next;
>> @@ -520,12 +522,14 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
>>    */
>>   int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>>   {
>> -	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
>>   	int cpu, i, err, unit_size, percpu_size = 0;
>>   	struct bpf_mem_caches *cc, __percpu *pcc;
>>   	struct bpf_mem_cache *c, __percpu *pc;
>>   	struct obj_cgroup *objcg = NULL;
>>   
>> +	if (percpu && size == 0)
>> +		return -EINVAL;
>> +
>>   	/* room for llist_node and per-cpu pointer */
>>   	if (percpu)
>>   		percpu_size = LLIST_NODE_SZ + sizeof(void *);
>> @@ -625,6 +629,68 @@ static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
>>   	drain_mem_cache(c);
>>   }
>>   
>> +int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma)
>> +{
>> +	struct bpf_mem_caches __percpu *pcc;
>> +
>> +	pcc = __alloc_percpu_gfp(sizeof(struct bpf_mem_caches), 8, GFP_KERNEL | __GFP_ZERO);
>> +	if (!pcc)
>> +		return -ENOMEM;
> __GFP_ZERO is not needed. __alloc_percpu_gfp() will zero the returned
> area by default.

Thanks. Checked the comments in __alloc_percpu_gfp() and indeed, the returned
buffer has been zeroed.

>> +
>> +	ma->caches = pcc;
>> +	ma->percpu = true;
>> +	return 0;
>> +}
>> +
>> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>> +{
>> +	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
>> +	int cpu, i, err, unit_size, percpu_size = 0;
>> +	struct bpf_mem_caches *cc, __percpu *pcc;
>> +	struct obj_cgroup *objcg = NULL;
>> +	struct bpf_mem_cache *c;
>> +
>> +	/* room for llist_node and per-cpu pointer */
>> +	percpu_size = LLIST_NODE_SZ + sizeof(void *);
>> +
>> +	i = bpf_mem_cache_idx(size);
>> +	if (i < 0)
>> +		return -EINVAL;
>> +
>> +	err = 0;
>> +	pcc = ma->caches;
>> +	unit_size = sizes[i];
>> +
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	objcg = get_obj_cgroup_from_current();
>> +#endif
>> +	for_each_possible_cpu(cpu) {
>> +		cc = per_cpu_ptr(pcc, cpu);
>> +		c = &cc->cache[i];
>> +		if (cpu == 0 && c->unit_size)
>> +			goto out;
>> +
>> +		c->unit_size = unit_size;
>> +		c->objcg = objcg;
>> +		c->percpu_size = percpu_size;
>> +		c->tgt = c;
>> +
>> +		init_refill_work(c);
>> +		prefill_mem_cache(c, cpu);
>> +
>> +		if (cpu == 0) {
>> +			err = check_obj_size(c, i);
>> +			if (err) {
>> +				bpf_mem_alloc_destroy_cache(c);
> It seems drain_mem_cache() will be enough. Have you considered setting

At prefill stage, looks like the following is enough:
     free_all(__llist_del_all(&c->free_llist), percpu);
But I agree that drain_mem_cache() is simpler and is
easier for future potential code change.

> low_watermark as 0 to prevent potential refill in unit_alloc() if the
> initialization of the current unit fails ?

I think it does make sense. For non-fix-size non-percpu prefill,
if check_obj_size() failed, the prefill will fail, which include
all buckets.

In this case, if it fails for a particular bucket, we should
make sure that bucket always return NULL ptr, so setting the
low_watermark to 0 does make sense.

>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>> +out:
>> +	return err;
>> +}
>> +
>>   static void check_mem_cache(struct bpf_mem_cache *c)
>>   {
>>   	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
>>
> .
>

