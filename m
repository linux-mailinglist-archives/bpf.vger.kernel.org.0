Return-Path: <bpf+bounces-14431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4327E455F
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 17:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881601C20D1D
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5920A321B7;
	Tue,  7 Nov 2023 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rskXPIaK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C8321B2
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 16:04:46 +0000 (UTC)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [IPv6:2001:41d0:1004:224b::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8137A4D
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:04:45 -0800 (PST)
Message-ID: <40ba7904-ade6-4a06-bb40-26b3853d0c0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699373083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=st+7MpelTQaq+BJz4L9bOreKGHdKyNQXyjJLMPHDopg=;
	b=rskXPIaKH/iA53bBL7+bQREXXkCUl5e1vNvXYkFWAbBDw8mou4TEDF+qrwlqwmYJUokvSR
	eN5GT5T+8ME/pO8taRoJzzJsffmwFruly/zDCI3wflK0SWoIKzzT6K9uXTAjldVYsIlbaZ
	MZcOf2AbDLFUdF74wkC8eLF0U10PfEw=
Date: Tue, 7 Nov 2023 08:04:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [bpf] c930472552:
 WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "houtao1@huawei.com" <houtao1@huawei.com>
References: <202310302113.9f8fe705-oliver.sang@intel.com>
 <7506b682-3be3-fcd0-4bb4-c1db48f609a2@huaweicloud.com>
 <99e9d615-b720-7f33-3df0-9824a92f6644@huaweicloud.com>
 <52383a4f-6efd-43ce-bedb-a91e130850f3@linux.dev>
 <3629948c-793e-307b-6b6e-00557f3f6212@huaweicloud.com>
 <3b3b1384-88ba-4796-8e11-d6632afb35ac@linux.dev>
 <f413cce7-db58-fd5c-63b9-5dfc5876c1aa@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f413cce7-db58-fd5c-63b9-5dfc5876c1aa@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/7/23 2:43 AM, Hou Tao wrote:
> Hi,
>
> On 11/4/2023 12:49 AM, Yonghong Song wrote:
>> On 11/2/23 11:54 PM, Hou Tao wrote:
>>> Hi,
>>>
>>> On 11/3/2023 12:08 AM, Yonghong Song wrote:
>>>> On 11/2/23 6:40 AM, Hou Tao wrote:
>>>>> Hi Alexei,
>>>>>
>>>>> On 10/31/2023 4:01 PM, Hou Tao wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 10/30/2023 10:11 PM, kernel test robot wrote:
>>>>>>> hi, Hou Tao,
>>>>>>>
>>>>>>> we noticed a WARN_ONCE added in this commit was hit in our tests.
>>>>>>> FYI.
>>>>>>>
>>>>>>>
> SNIP
>>>>> I see what has happened. The problem is twofold:
>>>>> (1) The object_size of kmalloc-cg-96 is adjust from 96 to 128 due to
>>>>> slab merge in __kmem_cache_alias(). For SLAB, SLAB_HWCACHE_ALIGN is
>>>>> enabled by default for kmalloc slab, so align is 64 and size is 128
>>>>> for
>>>>> kmalloc-cg-96. So when unit_alloc() does kmalloc_node(96,
>>>>> __GFP_ACCOUNT,
>>>>> node), ksize() will return 128 instead of 96 for the returned pointer.
>>>>> SLUB has a similar merge logic, but because its align is 8 under
>>>>> x86-64,
>>>>> so the warning doesn't happen for i386 + SLUB, but I think the similar
>>>>> problem may exist for other architectures.
>>>>> (2) kmalloc_size_roundup() returns the object_size of kmalloc-96
>>>>> instead
>>>>> of kmalloc-cg-96, so bpf_mem_cache_adjust_size() doesn't adjust
>>>>> size_index accordingly. The reason why the object_size of
>>>>> kmalloc-96 is
>>>>> 96 instead of 128 is that there is slab merge for kmalloc-96.
>>>>>
>>>>> About how to fix the problem, I have two ideas:
>>>>> The first is to introduce kmalloc_size_roundup_flags(), so
>>>>> bpf_mem_cache_adjust_size() could use kmalloc_size_roundup_flags(size,
>>>>> __GFP_ACCOUNT) to get the object_size of kmalloc-cg-xxx. It could fix
>>>>> the warning for now, but the warning may pop-up occasionally due to
>>>>> SLUB
>>>>> merge and unusual slab align. The second is just using the
>>>>> bpf_mem_cache
>>>>> pointer to get the unit_size which is saved before the to-be-free
>>>>> pointer. Its downside is that it may can not be able to skip the free
>>>>> operation for pointer which is not allocated from bpf ma, but I
>>>>> think it
>>>>> is acceptable. I prefer the latter solution. What do you think ?
>>>> Is it possible that in bpf_mem_cache_adjust_size(), we do a series of
>>>> kmalloc (for supported bucket size) and call ksize() to get the actual
>>>> allocated object size. So eventually all possible allocated object
>>>> sizes
>>>> will be used for size_index[]. This will avoid all kind of special
>>>> corner cases due to config/macro/arch etc. WDYT?
>>> It is basically the same as the first proposed solution and it has the
>>> same flaw. The problem is that slab merge can happen in any time, so the
>>> return value of ksize() may change even all passed pointers are
>>> allocated from the same slab. Considering the following case: during the
>>> invocation of bpf_mem_cache_adjust_size() or the initialization of
>>> bpf_global_ma, there is no slab merge and ksize() for a 96-bytes object
>>> returns 96. But after these invocations, a new slab created by a kernel
>>> module is merged to kmalloc-cg-96 and the object_size of kmalloc-cg-96
>>> is adjust from 96 to 128 (which is possible for x86-64 + CONFIG_SLAB,
>>> because it is alignment requirement is 64 for 96-bytes slab). So soon or
>> So, the object_size for allocated objects in that is adjusted from 96
>> to 128
>> while previously allocated objects should have no change, it is merely
>> ksize(old_obj)
>> previous return 96, now returns 128, right? Okay, so this is indeed a
>> problem
>> since we use ksize() to decide the bucket.
> Yes. The object_size of underlying slab changes, so the return value of
> ksize() will change as well.
>>
>>> later, when bpf_global_ma frees a 96-byte-sized pointer which is
>>> allocated from a bpf_mem_cache in which unit_size is 96, bpf_mem_free()
>>> will free the pointer through a bpf_mem_cache in which unit_size is 128,
>>> because the return value of ksize() changes. Maybe we should introduce a
>>> new API in mm which returns size instead of object_size of underlying
>>> slab, so the return value will not change due to slab merge.
>> In this case, to avoid the warning, indeed we need to use '96' instead
>> of '128'.
>> So use the original ksize() return value is indeed a solution.
>> We could use the mechanism similar to percpu alloc to save '96' in the
>> memory.
> We have already saved the pointer of bpf_mem_cache in the extra space
> (aka LLIST_NODE_SZ) which is allocated together with the returned
> pointer, so I think we could use bpf_mem_cache->unit_size to get the
> size of the free pointer directly. I will check whether or not there is
> performance degradation before posting the patch.

See:

bpf_local_storage.c:            err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
bpf_local_storage.c:            err = bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct bpf_local_storage), false);
core.c: ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
core.c: ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
cpumask.c:      ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
hashtab.c:              err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
hashtab.c:                      err = bpf_mem_alloc_init(&htab->pcpu_ma,
memalloc.c:int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)

Some 'size' parameter in core.c is zero.
Not sure how exactly you will resolve this issue based on
bpf_mem_cache->unit_size. But looking forward to your patch!

>
> Regards,
> Tao
>

