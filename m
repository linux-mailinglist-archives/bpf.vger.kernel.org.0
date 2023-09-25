Return-Path: <bpf+bounces-10731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B17AD2A8
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0402A281552
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274D111A6;
	Mon, 25 Sep 2023 08:06:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4863D6
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 08:06:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF63A2
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 01:06:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RvFmz3QdSz4f3nZp
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:05:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBX7NtgPxFlRbZgBQ--.3736S2;
	Mon, 25 Sep 2023 16:05:56 +0800 (CST)
Subject: Re: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache
 object size
To: Nathan Chancellor <nathan@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, houtao1@huawei.com, Guenter Roeck <linux@roeck-us.net>
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
 <20230908133923.2675053-4-houtao@huaweicloud.com>
 <20230914181407.GA1000274@dev-arch.thelio-3990X>
 <9c286bd1-7551-0853-1f47-830847ecd04d@huaweicloud.com>
 <20230919234650.GA49569@dev-arch.thelio-3990X>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <14ec8267-b06d-8dbc-1a86-924f0b3ad320@huaweicloud.com>
Date: Mon, 25 Sep 2023 16:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230919234650.GA49569@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBX7NtgPxFlRbZgBQ--.3736S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KFW5ZFW5XF45Cr4UKw18Grg_yoWkXFyrpF
	y7KF4UCr4kXry7Jw129w1q9Fy3tw18C3W7Gr12qr1rZF1q9r1DJr4kZry3WF90qrW0kF4x
	AF1qgrsY9w4UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/20/2023 7:46 AM, Nathan Chancellor wrote:
> On Sat, Sep 16, 2023 at 10:38:09AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 9/15/2023 2:14 AM, Nathan Chancellor wrote:
>>> Hi Hou,
>>>
>>> On Fri, Sep 08, 2023 at 09:39:22PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
>>>> bpf_mem_cache is matched with the object_size of underlying slab cache.
>>>> If these two sizes are unmatched, print a warning once and return
>>>> -EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early and
>>>> the potential issue can be prevented.
>>>>
>>>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  kernel/bpf/memalloc.c | 33 +++++++++++++++++++++++++++++++--
>>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>>> index 90c1ed8210a2..1c22b90e754a 100644
>>>> --- a/kernel/bpf/memalloc.c
>>>> +++ b/kernel/bpf/memalloc.c
>>>> @@ -486,6 +486,24 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>>>>  	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
>>>>  }
>>>>  
>>>> +static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
>>>> +{
>>>> +	struct llist_node *first;
>>>> +	unsigned int obj_size;
>>>> +
>>>> +	first = c->free_llist.first;
>>>> +	if (!first)
>>>> +		return 0;
>>>> +
>>>> +	obj_size = ksize(first);
>>>> +	if (obj_size != c->unit_size) {
>>>> +		WARN_ONCE(1, "bpf_mem_cache[%u]: unexpected object size %u, expect %u\n",
>>>> +			  idx, obj_size, c->unit_size);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>> I am seeing the warning added by this change as commit c93047255202
>>> ("bpf: Ensure unit_size is matched with slab cache object size") when
>>> booting ARCH=riscv defconfig in QEMU. I have seen some discussion on the
>>> mailing list around this, so I apologize if this is a duplicate report
>>> but it sounded like the previously reported instance of this warning was
>>> already resolved by some other changeor supposed to be resolved by [1].
>>> Unfortunately, I tested both current bpf master (currently at
>>> 6bd5bcb18f94) with and without that change and I still see the warning
>>> in both cases. The rootfs is available at [2], if it is relevant.
>> Thanks for the report. It seems it is a new problem which should be
>> fixed by commit d52b59315bf5 ("bpf: Adjust size_index according to the
>> value of KMALLOC_MIN_SIZE"), but failed to. However I could not
>> reproduce the problem by using the provided steps. Do you configure any
>> boot cmd line in your local setup ? I suspect dma_get_cache_alignment()
>> returns 64 of 1 in your setup, so slab-96 is rounded up to slab-128.
>> Could you please run the attached debug patch and post its output ?

Sorry for the delay. I was in off-site training last week.

> Apologies for the delay, I have been traveling (and will be again
> shortly). It seems like your theory could be accurate, as I see:
>
> [    0.120969] ==== bpf_mem_cache: KMALLOC_MIN_SIZE 8 ARCH_KMALLOC_MINALIGN 8 min_align 64
>
> There are no cmdline arguments aside from 'earlycon'. Could the QEMU
> version matter here for reproduction purposes, as I am still able to
> reproduce with my commands on next-20230919? I am using 8.1.0.

The QEMU version matters. I can reproduce the problem by using v8.1.0
but can not reproduce by using v4.2.1. Will post a patch to fix it soon.
>
> Cheers,
> Nathan
>
>>> $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux- mrproper defconfig Image
>>>
>>> $ qemu-system-riscv64 \
>>>     -display none \
>>>     -nodefaults \
>>>     -bios default \
>>>     -M virt \
>>>     -append earlycon \
>>>     -kernel arch/riscv/boot/Image \
>>>     -initrd riscv-rootfs.cpio \
>>>     -m 512m \
>>>     -serial mon:stdio
>>> ...
>>> [    0.000000] Linux version 6.5.0-12679-gc93047255202 (nathan@dev-arch.thelio-3990X) (riscv64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP Thu Sep 14 10:44:41 MST 2023
>>> ...
>>> [    0.433002] ------------[ cut here ]------------
>>> [    0.433128] bpf_mem_cache[0]: unexpected object size 128, expect 96
>>> [    0.433585] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init+0x348/0x354
>>> [    0.433810] Modules linked in:
>>> [    0.433928] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-12679-gc93047255202 #1
>>> [    0.434025] Hardware name: riscv-virtio,qemu (DT)
>>> [    0.434105] epc : bpf_mem_alloc_init+0x348/0x354
>>> [    0.434140]  ra : bpf_mem_alloc_init+0x348/0x354
>>> [    0.434163] epc : ffffffff80112572 ra : ffffffff80112572 sp : ff2000000000bd30
>>> [    0.434177]  gp : ffffffff81501588 tp : ff600000018d0000 t0 : ffffffff808cd1a0
>>> [    0.434190]  t1 : 0720072007200720 t2 : 635f6d656d5f6670 s0 : ff2000000000bdd0
>>> [    0.434202]  s1 : ffffffff80e17620 a0 : 0000000000000037 a1 : ffffffff814866b8
>>> [    0.434215]  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
>>> [    0.434227]  a5 : 0000000000000000 a6 : 0000000000000047 a7 : 0000000000000046
>>> [    0.434239]  s2 : 000000000000000b s3 : 0000000000000000 s4 : 0000000000000000
>>> [    0.434251]  s5 : 0000000000000100 s6 : ffffffff815031f8 s7 : ffffffff8153a610
>>> [    0.434264]  s8 : 0000000000000060 s9 : 0000000000000060 s10: 0000000000000000
>>> [    0.434276]  s11: ff6000001ffe5410 t3 : ff60000001858f00 t4 : ff60000001858f00
>>> [    0.434288]  t5 : ff60000001858000 t6 : ff2000000000bb48
>>> [    0.434299] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
>>> [    0.434394] [<ffffffff80112572>] bpf_mem_alloc_init+0x348/0x354
>>> [    0.434492] [<ffffffff80a0f302>] bpf_global_ma_init+0x1c/0x30
>>> [    0.434516] [<ffffffff8000212c>] do_one_initcall+0x58/0x19c
>>> [    0.434526] [<ffffffff80a0105e>] kernel_init_freeable+0x214/0x27e
>>> [    0.434537] [<ffffffff808db4dc>] kernel_init+0x1e/0x10a
>>> [    0.434548] [<ffffffff80003386>] ret_from_fork+0xa/0x1c
>>> [    0.434618] ---[ end trace 0000000000000000 ]---
>>>
>>> [1]: https://lore.kernel.org/20230913135943.3137292-1-houtao@huaweicloud.com/
>>> [2]: https://github.com/ClangBuiltLinux/boot-utils/releases
>>>
>>> Cheers,
>>> Nathan
>>>
>>> # bad: [98897dc735cf6635f0966f76eb0108354168fb15] Add linux-next specific files for 20230914
>>> # good: [aed8aee11130a954356200afa3f1b8753e8a9482] Merge tag 'pmdomain-v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
>>> git bisect start '98897dc735cf6635f0966f76eb0108354168fb15' 'aed8aee11130a954356200afa3f1b8753e8a9482'
>>> # good: [ea1bbd78a48c8b325583e8c0bc2690850cb51807] bcachefs: Fix assorted checkpatch nits
>>> git bisect good ea1bbd78a48c8b325583e8c0bc2690850cb51807
>>> # bad: [9c4e2139cfa15d769eafd51bf3e051293b106986] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>>> git bisect bad 9c4e2139cfa15d769eafd51bf3e051293b106986
>>> # bad: [4f07b13481ab390108b015da2bc8f560416e48d2] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
>>> git bisect bad 4f07b13481ab390108b015da2bc8f560416e48d2
>>> # bad: [bcfe98207530e1ea0004f4e5dbd6e7e4d9eb2471] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
>>> git bisect bad bcfe98207530e1ea0004f4e5dbd6e7e4d9eb2471
>>> # bad: [95d3e99b1ca8ad3da86c525cc1c00e4ba27592ac] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
>>> git bisect bad 95d3e99b1ca8ad3da86c525cc1c00e4ba27592ac
>>> # good: [6836d373943afeeeb8e2989c22aaaa51218a83c6] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
>>> git bisect good 6836d373943afeeeb8e2989c22aaaa51218a83c6
>>> # good: [3d3e2fb5e45a08a45ae01f0dfaf9621ae0e439f9] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
>>> git bisect good 3d3e2fb5e45a08a45ae01f0dfaf9621ae0e439f9
>>> # bad: [51d56d51d3881addaea2c7242ae859155ae75607] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
>>> git bisect bad 51d56d51d3881addaea2c7242ae859155ae75607
>>> # bad: [1a49f4195d3498fe458a7f5ff7ec5385da70d92e] bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
>>> git bisect bad 1a49f4195d3498fe458a7f5ff7ec5385da70d92e
>>> # bad: [c930472552022bd09aab3cd946ba3f243070d5c7] bpf: Ensure unit_size is matched with slab cache object size
>>> git bisect bad c930472552022bd09aab3cd946ba3f243070d5c7
>>> # good: [7182e56411b9a8b76797ed7b6095fc84be76dfb0] selftests/bpf: Add kprobe_multi override test
>>> git bisect good 7182e56411b9a8b76797ed7b6095fc84be76dfb0
>>> # good: [b1d53958b69312e43c118d4093d8f93d3f6f80af] bpf: Don't prefill for unused bpf_mem_cache
>>> git bisect good b1d53958b69312e43c118d4093d8f93d3f6f80af
>>> # first bad commit: [c930472552022bd09aab3cd946ba3f243070d5c7] bpf: Ensure unit_size is matched with slab cache object size
>> From 369f2e59cc6c63c3924f654ba3f8491dba58b87b Mon Sep 17 00:00:00 2001
>> From: Hou Tao <houtao1@huawei.com>
>> Date: Sat, 16 Sep 2023 10:35:52 +0800
>> Subject: [PATCH] bpf: Check the return value of dma_get_cache_alignment()
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/memalloc.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 1c22b90e754a..c8d2c3097c43 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -6,6 +6,8 @@
>>  #include <linux/irq_work.h>
>>  #include <linux/bpf_mem_alloc.h>
>>  #include <linux/memcontrol.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/swiotlb.h>
>>  #include <asm/local.h>
>>  
>>  /* Any context (including NMI) BPF specific memory allocator.
>> @@ -958,6 +960,14 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
>>  	return !ret ? NULL : ret + LLIST_NODE_SZ;
>>  }
>>  
>> +static unsigned int __kmalloc_minalign(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>> +	    is_swiotlb_allocated())
>> +		return ARCH_KMALLOC_MINALIGN;
>> +	return dma_get_cache_alignment();
>> +}
>> +
>>  /* Most of the logic is taken from setup_kmalloc_cache_index_table() */
>>  static __init int bpf_mem_cache_adjust_size(void)
>>  {
>> @@ -992,6 +1002,9 @@ static __init int bpf_mem_cache_adjust_size(void)
>>  			size_index[(size - 1) / 8] = index;
>>  	}
>>  
>> +	pr_info("==== bpf_mem_cache: KMALLOC_MIN_SIZE %u ARCH_KMALLOC_MINALIGN %u min_align %u\n",
>> +		KMALLOC_MIN_SIZE, ARCH_KMALLOC_MINALIGN, __kmalloc_minalign());
>> +
>>  	return 0;
>>  }
>>  subsys_initcall(bpf_mem_cache_adjust_size);
>> -- 
>> 2.29.2
>>
> .


