Return-Path: <bpf+bounces-15309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419037EFFBE
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77FE1F22927
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104712E73;
	Sat, 18 Nov 2023 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C4D129;
	Sat, 18 Nov 2023 05:12:32 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXZ1h4cY9z4f3lfn;
	Sat, 18 Nov 2023 21:12:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C14771A0175;
	Sat, 18 Nov 2023 21:12:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAng0M4uFhlhuA5BQ--.16460S2;
	Sat, 18 Nov 2023 21:12:27 +0800 (CST)
Subject: Re: [linus:master] [bpf] c930472552:
 WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
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
 <40ba7904-ade6-4a06-bb40-26b3853d0c0b@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4c17dbf2-6ead-4d87-10d5-a0c9256242d9@huaweicloud.com>
Date: Sat, 18 Nov 2023 21:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <40ba7904-ade6-4a06-bb40-26b3853d0c0b@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAng0M4uFhlhuA5BQ--.16460S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4DArW3Gr4DJr1fJryfXrb_yoWxXry8pF
	WfJF10yrWDAr18Ar42qw18AFy8tw1Ig34UW34Yqr1UZrn0vr1vqr4ktrWj9a4kXr48Ga1U
	trs5tFyfZr1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/8/2023 12:04 AM, Yonghong Song wrote:
>
> On 11/7/23 2:43 AM, Hou Tao wrote:
>> Hi,
>>
>> On 11/4/2023 12:49 AM, Yonghong Song wrote:
>>> On 11/2/23 11:54 PM, Hou Tao wrote:
>>>> Hi,
>>>>
>>>> On 11/3/2023 12:08 AM, Yonghong Song wrote:
>>>>> On 11/2/23 6:40 AM, Hou Tao wrote:
>>>>>> Hi Alexei,
>>>>>>
>>>>>> On 10/31/2023 4:01 PM, Hou Tao wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 10/30/2023 10:11 PM, kernel test robot wrote:
>>>>>>>> hi, Hou Tao,
>>>>>>>>
>>>>>>>> we noticed a WARN_ONCE added in this commit was hit in our tests.
>>>>>>>> FYI.
>>>>>>>>
>>>>>>>>
>> SNIP
>>>>>> I see what has happened. The problem is twofold:
>>>>>> (1) The object_size of kmalloc-cg-96 is adjust from 96 to 128 due to
>>>>>> slab merge in __kmem_cache_alias(). For SLAB, SLAB_HWCACHE_ALIGN is
>>>>>> enabled by default for kmalloc slab, so align is 64 and size is 128
>>>>>> for
>>>>>> kmalloc-cg-96. So when unit_alloc() does kmalloc_node(96,
>>>>>> __GFP_ACCOUNT,
>>>>>> node), ksize() will return 128 instead of 96 for the returned
>>>>>> pointer.
>>>>>> SLUB has a similar merge logic, but because its align is 8 under
>>>>>> x86-64,
>>>>>> so the warning doesn't happen for i386 + SLUB, but I think the
>>>>>> similar
>>>>>> problem may exist for other architectures.
>>>>>> (2) kmalloc_size_roundup() returns the object_size of kmalloc-96
>>>>>> instead
>>>>>> of kmalloc-cg-96, so bpf_mem_cache_adjust_size() doesn't adjust
>>>>>> size_index accordingly. The reason why the object_size of
>>>>>> kmalloc-96 is
>>>>>> 96 instead of 128 is that there is slab merge for kmalloc-96.
>>>>>>
>>>>>> About how to fix the problem, I have two ideas:
>>>>>> The first is to introduce kmalloc_size_roundup_flags(), so
>>>>>> bpf_mem_cache_adjust_size() could use
>>>>>> kmalloc_size_roundup_flags(size,
>>>>>> __GFP_ACCOUNT) to get the object_size of kmalloc-cg-xxx. It could
>>>>>> fix
>>>>>> the warning for now, but the warning may pop-up occasionally due to
>>>>>> SLUB
>>>>>> merge and unusual slab align. The second is just using the
>>>>>> bpf_mem_cache
>>>>>> pointer to get the unit_size which is saved before the to-be-free
>>>>>> pointer. Its downside is that it may can not be able to skip the
>>>>>> free
>>>>>> operation for pointer which is not allocated from bpf ma, but I
>>>>>> think it
>>>>>> is acceptable. I prefer the latter solution. What do you think ?
>>>>> Is it possible that in bpf_mem_cache_adjust_size(), we do a series of
>>>>> kmalloc (for supported bucket size) and call ksize() to get the
>>>>> actual
>>>>> allocated object size. So eventually all possible allocated object
>>>>> sizes
>>>>> will be used for size_index[]. This will avoid all kind of special
>>>>> corner cases due to config/macro/arch etc. WDYT?
>>>> It is basically the same as the first proposed solution and it has the
>>>> same flaw. The problem is that slab merge can happen in any time,
>>>> so the
>>>> return value of ksize() may change even all passed pointers are
>>>> allocated from the same slab. Considering the following case:
>>>> during the
>>>> invocation of bpf_mem_cache_adjust_size() or the initialization of
>>>> bpf_global_ma, there is no slab merge and ksize() for a 96-bytes
>>>> object
>>>> returns 96. But after these invocations, a new slab created by a
>>>> kernel
>>>> module is merged to kmalloc-cg-96 and the object_size of kmalloc-cg-96
>>>> is adjust from 96 to 128 (which is possible for x86-64 + CONFIG_SLAB,
>>>> because it is alignment requirement is 64 for 96-bytes slab). So
>>>> soon or
>>> So, the object_size for allocated objects in that is adjusted from 96
>>> to 128
>>> while previously allocated objects should have no change, it is merely
>>> ksize(old_obj)
>>> previous return 96, now returns 128, right? Okay, so this is indeed a
>>> problem
>>> since we use ksize() to decide the bucket.
>> Yes. The object_size of underlying slab changes, so the return value of
>> ksize() will change as well.
>>>
>>>> later, when bpf_global_ma frees a 96-byte-sized pointer which is
>>>> allocated from a bpf_mem_cache in which unit_size is 96,
>>>> bpf_mem_free()
>>>> will free the pointer through a bpf_mem_cache in which unit_size is
>>>> 128,
>>>> because the return value of ksize() changes. Maybe we should
>>>> introduce a
>>>> new API in mm which returns size instead of object_size of underlying
>>>> slab, so the return value will not change due to slab merge.
>>> In this case, to avoid the warning, indeed we need to use '96' instead
>>> of '128'.
>>> So use the original ksize() return value is indeed a solution.
>>> We could use the mechanism similar to percpu alloc to save '96' in the
>>> memory.
>> We have already saved the pointer of bpf_mem_cache in the extra space
>> (aka LLIST_NODE_SZ) which is allocated together with the returned
>> pointer, so I think we could use bpf_mem_cache->unit_size to get the
>> size of the free pointer directly. I will check whether or not there is
>> performance degradation before posting the patch.

Post for status update.

There is no benchmark for bpf_mem_free(), so I am stilling write the
benchmark for bpf_mem_alloc() and bpf_mem_free(). After the benchmark is
ready (I think it will be next week), I will post the fix patch.
>
> See:
>
> bpf_local_storage.c:            err =
> bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
> bpf_local_storage.c:            err =
> bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct
> bpf_local_storage), false);
> core.c: ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
> core.c: ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> cpumask.c:      ret = bpf_mem_alloc_init(&bpf_cpumask_ma,
> sizeof(struct bpf_cpumask), false);
> hashtab.c:              err = bpf_mem_alloc_init(&htab->ma,
> htab->elem_size, false);
> hashtab.c:                      err = bpf_mem_alloc_init(&htab->pcpu_ma,
> memalloc.c:int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size,
> bool percpu)
>
> Some 'size' parameter in core.c is zero.
> Not sure how exactly you will resolve this issue based on
> bpf_mem_cache->unit_size. But looking forward to your patch!
>
>>
>> Regards,
>> Tao
>>
>
> .


