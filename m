Return-Path: <bpf+bounces-18110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2B815DD1
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD661C21A1A
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203051851;
	Sun, 17 Dec 2023 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O24h1dpq"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A8184F
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c13f568-325c-4e5c-9f9e-ca5da5c2c75b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702797128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOn5pf9zgNApqvevOk8k+HShvz62ZXAU6ZYyum1JQ5M=;
	b=O24h1dpqBc5eML4Te+m2RB0muUHDZb75KQAYG/f7eWgsb/TkThFGXEE6BkNCLIqnexGfU3
	DkFgJUrRNtsCu2UYgjsIsIEWOWSxYWJ9TafXPxJTUNBEQp7+uL2Ea2l1GV+5eZVwDz0mo3
	OF0n8WhaKKFLtShhzwEsxE/OZSEfwJg=
Date: Sat, 16 Dec 2023 23:11:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231216023004.3738749-1-yonghong.song@linux.dev>
 <20231216023015.3741144-1-yonghong.song@linux.dev>
 <ca0512d6-fa01-9d94-017f-a717756dcf86@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ca0512d6-fa01-9d94-017f-a717756dcf86@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/15/23 7:12 PM, Hou Tao wrote:
> Hi,
>
> On 12/16/2023 10:30 AM, Yonghong Song wrote:
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
> SNIP
>> +__init int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma)
>> +{
>> +	struct bpf_mem_caches __percpu *pcc;
>> +
>> +	pcc = __alloc_percpu_gfp(sizeof(struct bpf_mem_caches), 8, GFP_KERNEL);
>> +	if (!pcc)
>> +		return -ENOMEM;
>> +
>> +	ma->caches = pcc;
>> +	ma->percpu = true;
>> +	return 0;
>> +}
>> +
>> +int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>> +{
>> +	int cpu, i, err = 0, unit_size, percpu_size;
>> +	struct bpf_mem_caches *cc, __percpu *pcc;
>> +	struct obj_cgroup *objcg;
>> +	struct bpf_mem_cache *c;
>> +
>> +	i = bpf_mem_cache_idx(size);
>> +	if (i < 0)
>> +		return -EINVAL;
>> +
>> +	/* room for llist_node and per-cpu pointer */
>> +	percpu_size = LLIST_NODE_SZ + sizeof(void *);
>> +
>> +	pcc = ma->caches;
>> +	unit_size = sizes[i];
>> +
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	objcg = get_obj_cgroup_from_current();
>> +#endif
> For bpf_global_percpu_ma, we also need to account the allocated memory
> to root memory cgroup just like bpf_global_ma did, do we ? So it seems
> that we need to initialize c->objcg early in bpf_mem_alloc_percpu_init ().

Good point. Agree. the original behavior percpu non-fix-size mem
allocation is to do get_obj_cgroup_from_current() at init stage
and charge to root memory cgroup, and we indeed should move
the above bpf_mem_alloc_percpu_init().

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
>> +				drain_mem_cache(c);
>> +				memset(c, 0, sizeof(*c));
> I also forgot about c->objcg. objcg may be leaked if we do memset() here.

The objcg gets a reference at init bpf_mem_alloc_init() stage
and released at bpf_mem_alloc_destroy(). For bpf_global_ma,
if there is a failure, indeed bpf_mem_alloc_destroy() will be
called and the reference c->objcg will be released.

So if we move get_obj_cgroup_from_current() to
bpf_mem_alloc_percpu_init() stage, we should be okay here.

BTW, is check_obj_size() really necessary here? My answer is no
since as you mentioned, the size->cache_index is pretty stable,
so check_obj_size() should not return error in such cases.
What do you think?

>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>> +out:
>> +	return err;
>> +}
>> +
>>   
> .
>

