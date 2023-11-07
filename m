Return-Path: <bpf+bounces-14389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36057E3A25
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 11:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9470FB20CCB
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A829424;
	Tue,  7 Nov 2023 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB914F94
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 10:43:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00D6B0;
	Tue,  7 Nov 2023 02:43:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SPlDq5g5Xz4f3n68;
	Tue,  7 Nov 2023 18:43:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 847171A0175;
	Tue,  7 Nov 2023 18:43:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCn9w3LFEpleJsZAQ--.59006S2;
	Tue, 07 Nov 2023 18:43:27 +0800 (CST)
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f413cce7-db58-fd5c-63b9-5dfc5876c1aa@huaweicloud.com>
Date: Tue, 7 Nov 2023 18:43:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3b3b1384-88ba-4796-8e11-d6632afb35ac@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCn9w3LFEpleJsZAQ--.59006S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw48ur15KF1xCr47tFW5Wrg_yoWrtF1DpF
	WayFyxtF4kAry7Ar42qw48uF40ywsagryUW34Yqr1UZrn0vr18tr48t3yUuaykZr48Cayj
	qrs5ta4fZr4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/4/2023 12:49 AM, Yonghong Song wrote:
>
> On 11/2/23 11:54 PM, Hou Tao wrote:
>> Hi,
>>
>> On 11/3/2023 12:08 AM, Yonghong Song wrote:
>>> On 11/2/23 6:40 AM, Hou Tao wrote:
>>>> Hi Alexei,
>>>>
>>>> On 10/31/2023 4:01 PM, Hou Tao wrote:
>>>>> Hi,
>>>>>
>>>>> On 10/30/2023 10:11 PM, kernel test robot wrote:
>>>>>> hi, Hou Tao,
>>>>>>
>>>>>> we noticed a WARN_ONCE added in this commit was hit in our tests.
>>>>>> FYI.
>>>>>>
>>>>>>
SNIP
>>>> I see what has happened. The problem is twofold:
>>>> (1) The object_size of kmalloc-cg-96 is adjust from 96 to 128 due to
>>>> slab merge in __kmem_cache_alias(). For SLAB, SLAB_HWCACHE_ALIGN is
>>>> enabled by default for kmalloc slab, so align is 64 and size is 128
>>>> for
>>>> kmalloc-cg-96. So when unit_alloc() does kmalloc_node(96,
>>>> __GFP_ACCOUNT,
>>>> node), ksize() will return 128 instead of 96 for the returned pointer.
>>>> SLUB has a similar merge logic, but because its align is 8 under
>>>> x86-64,
>>>> so the warning doesn't happen for i386 + SLUB, but I think the similar
>>>> problem may exist for other architectures.
>>>> (2) kmalloc_size_roundup() returns the object_size of kmalloc-96
>>>> instead
>>>> of kmalloc-cg-96, so bpf_mem_cache_adjust_size() doesn't adjust
>>>> size_index accordingly. The reason why the object_size of
>>>> kmalloc-96 is
>>>> 96 instead of 128 is that there is slab merge for kmalloc-96.
>>>>
>>>> About how to fix the problem, I have two ideas:
>>>> The first is to introduce kmalloc_size_roundup_flags(), so
>>>> bpf_mem_cache_adjust_size() could use kmalloc_size_roundup_flags(size,
>>>> __GFP_ACCOUNT) to get the object_size of kmalloc-cg-xxx. It could fix
>>>> the warning for now, but the warning may pop-up occasionally due to
>>>> SLUB
>>>> merge and unusual slab align. The second is just using the
>>>> bpf_mem_cache
>>>> pointer to get the unit_size which is saved before the to-be-free
>>>> pointer. Its downside is that it may can not be able to skip the free
>>>> operation for pointer which is not allocated from bpf ma, but I
>>>> think it
>>>> is acceptable. I prefer the latter solution. What do you think ?
>>>
>>> Is it possible that in bpf_mem_cache_adjust_size(), we do a series of
>>> kmalloc (for supported bucket size) and call ksize() to get the actual
>>> allocated object size. So eventually all possible allocated object
>>> sizes
>>> will be used for size_index[]. This will avoid all kind of special
>>> corner cases due to config/macro/arch etc. WDYT?
>> It is basically the same as the first proposed solution and it has the
>> same flaw. The problem is that slab merge can happen in any time, so the
>> return value of ksize() may change even all passed pointers are
>> allocated from the same slab. Considering the following case: during the
>> invocation of bpf_mem_cache_adjust_size() or the initialization of
>> bpf_global_ma, there is no slab merge and ksize() for a 96-bytes object
>> returns 96. But after these invocations, a new slab created by a kernel
>> module is merged to kmalloc-cg-96 and the object_size of kmalloc-cg-96
>> is adjust from 96 to 128 (which is possible for x86-64 + CONFIG_SLAB,
>> because it is alignment requirement is 64 for 96-bytes slab). So soon or
>
> So, the object_size for allocated objects in that is adjusted from 96
> to 128
> while previously allocated objects should have no change, it is merely
> ksize(old_obj)
> previous return 96, now returns 128, right? Okay, so this is indeed a
> problem
> since we use ksize() to decide the bucket.

Yes. The object_size of underlying slab changes, so the return value of
ksize() will change as well.
>
>
>> later, when bpf_global_ma frees a 96-byte-sized pointer which is
>> allocated from a bpf_mem_cache in which unit_size is 96, bpf_mem_free()
>> will free the pointer through a bpf_mem_cache in which unit_size is 128,
>> because the return value of ksize() changes. Maybe we should introduce a
>> new API in mm which returns size instead of object_size of underlying
>> slab, so the return value will not change due to slab merge.
>
> In this case, to avoid the warning, indeed we need to use '96' instead
> of '128'.
> So use the original ksize() return value is indeed a solution.
> We could use the mechanism similar to percpu alloc to save '96' in the
> memory.

We have already saved the pointer of bpf_mem_cache in the extra space
(aka LLIST_NODE_SZ) which is allocated together with the returned
pointer, so I think we could use bpf_mem_cache->unit_size to get the
size of the free pointer directly. I will check whether or not there is
performance degradation before posting the patch.

Regards,
Tao


