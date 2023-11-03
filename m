Return-Path: <bpf+bounces-14081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2B7E0702
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD891F22A76
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1671D554;
	Fri,  3 Nov 2023 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J+hBJivp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FC1D53F
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:49:42 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184A125
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 09:49:37 -0700 (PDT)
Message-ID: <3b3b1384-88ba-4796-8e11-d6632afb35ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699030175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uszdkpoS+497OBYSli94OpXefHaiQHfyI1jh0hoCzQ=;
	b=J+hBJivpPkDYS3G4/2HLB+F6BMUxJczjAFkWYZj1VystNYa0ZKK3uDh7nsb15NWZY+xAhX
	sEhhiljDlvy7oRqZaWpeWroZauher6Lrclyx/vp12n6vgQcSln88q+bsXLJy6Gm64TBwVU
	H4dcXissfRa/2aFs69cLP3Pp3j8LNmM=
Date: Fri, 3 Nov 2023 09:49:28 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3629948c-793e-307b-6b6e-00557f3f6212@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/2/23 11:54 PM, Hou Tao wrote:
> Hi,
>
> On 11/3/2023 12:08 AM, Yonghong Song wrote:
>> On 11/2/23 6:40 AM, Hou Tao wrote:
>>> Hi Alexei,
>>>
>>> On 10/31/2023 4:01 PM, Hou Tao wrote:
>>>> Hi,
>>>>
>>>> On 10/30/2023 10:11 PM, kernel test robot wrote:
>>>>> hi, Hou Tao,
>>>>>
>>>>> we noticed a WARN_ONCE added in this commit was hit in our tests. FYI.
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> kernel test robot noticed
>>>>> "WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init" on:
>>>>>
>>>>> commit: c930472552022bd09aab3cd946ba3f243070d5c7 ("bpf: Ensure
>>>>> unit_size is matched with slab cache object size")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>
>>>>> [test failed on linus/master ffc253263a1375a65fa6c9f62a893e9767fbebfa]
>>>>> [test failed on linux-next/master
>>>>> c503e3eec382ac708ee7adf874add37b77c5d312]
>>>>>
>>>>> in testcase: boot
>>>>>
>>>>> compiler: gcc-12
>>>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
>>>>> 2 -m 16G
>>>>>
>>>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>>>
>>>>>
>>>>> +-------------------------------------------------------------+------------+------------+
>>>>>
>>>>> |                                                             |
>>>>> b1d53958b6 | c930472552 |
>>>>> +-------------------------------------------------------------+------------+------------+
>>>>>
>>>>> | WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init        |
>>>>> 0          | 14         |
>>>>> | EIP:bpf_mem_alloc_init                                      |
>>>>> 0          | 14         |
>>>>> +-------------------------------------------------------------+------------+------------+
>>>>>
>>>>>
>>>>>
>>>>> If you fix the issue in a separate patch/commit (i.e. not just a
>>>>> new version of
>>>>> the same patch/commit), kindly add following tags
>>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>> | Closes:
>>>>> https://lore.kernel.org/oe-lkp/202310302113.9f8fe705-oliver.sang@intel.com
>>>>>
>>>>>
>>>>> [   32.249545][    T1] ------------[ cut here ]------------
>>>>> [   32.250152][    T1] bpf_mem_cache[0]: unexpected object size
>>>>> 128, expect 96
>>>>> [ 32.250953][ T1] WARNING: CPU: 1 PID: 1 at
>>>>> kernel/bpf/memalloc.c:500 bpf_mem_alloc_init
>>>>> (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579)
>>>>> [   32.252065][    T1] Modules linked in:
>>>>> [   32.252548][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted:
>>>>> G        W          6.5.0-12679-gc93047255202 #1
>>>>> [ 32.253767][ T1] EIP: bpf_mem_alloc_init
>>>>> (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579)
>>>>> [ 32.254439][ T1] Code: 30 e8 7e 22 04 00 8b 56 20 39 d0 74 24 80
>>>>> 3d 18 c0 cc c2 00 75 3b c6 05 18 c0 cc c2 01 52 50 53 68 df 53 57
>>>>> c2 e8 47 70 ef ff <0f> 0b 83 c4 10 eb 20 43 83 c6 74 83 fb 0b 0f 85
>>>>> 6a ff ff ff 8b 45
>>>> Thanks for the report. I also could reproduce the warning in v6.6 by
>>>> following the reproducing steps in the link below.
>>>>
>>>> According the reproduce job, it seems that the kernel is built for i386
>>>> (make HOSTCC=gcc-12 CC=gcc-12 ARCH=i386 olddefconfig prepare
>>>> modules_prepare bzImage) and in .config CONFIG_SLAB instead of
>>>> CONFIG_SLUB is enabled, I will check whether or not these two setups
>>>> make any thing being different.
>>> I see what has happened. The problem is twofold:
>>> (1) The object_size of kmalloc-cg-96 is adjust from 96 to 128 due to
>>> slab merge in __kmem_cache_alias(). For SLAB, SLAB_HWCACHE_ALIGN is
>>> enabled by default for kmalloc slab, so align is 64 and size is 128 for
>>> kmalloc-cg-96. So when unit_alloc() does kmalloc_node(96, __GFP_ACCOUNT,
>>> node), ksize() will return 128 instead of 96 for the returned pointer.
>>> SLUB has a similar merge logic, but because its align is 8 under x86-64,
>>> so the warning doesn't happen for i386 + SLUB, but I think the similar
>>> problem may exist for other architectures.
>>> (2) kmalloc_size_roundup() returns the object_size of kmalloc-96 instead
>>> of kmalloc-cg-96, so bpf_mem_cache_adjust_size() doesn't adjust
>>> size_index accordingly. The reason why the object_size of kmalloc-96 is
>>> 96 instead of 128 is that there is slab merge for kmalloc-96.
>>>
>>> About how to fix the problem, I have two ideas:
>>> The first is to introduce kmalloc_size_roundup_flags(), so
>>> bpf_mem_cache_adjust_size() could use kmalloc_size_roundup_flags(size,
>>> __GFP_ACCOUNT) to get the object_size of kmalloc-cg-xxx. It could fix
>>> the warning for now, but the warning may pop-up occasionally due to SLUB
>>> merge and unusual slab align. The second is just using the bpf_mem_cache
>>> pointer to get the unit_size which is saved before the to-be-free
>>> pointer. Its downside is that it may can not be able to skip the free
>>> operation for pointer which is not allocated from bpf ma, but I think it
>>> is acceptable. I prefer the latter solution. What do you think ?
>>
>> Is it possible that in bpf_mem_cache_adjust_size(), we do a series of
>> kmalloc (for supported bucket size) and call ksize() to get the actual
>> allocated object size. So eventually all possible allocated object sizes
>> will be used for size_index[]. This will avoid all kind of special
>> corner cases due to config/macro/arch etc. WDYT?
> It is basically the same as the first proposed solution and it has the
> same flaw. The problem is that slab merge can happen in any time, so the
> return value of ksize() may change even all passed pointers are
> allocated from the same slab. Considering the following case: during the
> invocation of bpf_mem_cache_adjust_size() or the initialization of
> bpf_global_ma, there is no slab merge and ksize() for a 96-bytes object
> returns 96. But after these invocations, a new slab created by a kernel
> module is merged to kmalloc-cg-96 and the object_size of kmalloc-cg-96
> is adjust from 96 to 128 (which is possible for x86-64 + CONFIG_SLAB,
> because it is alignment requirement is 64 for 96-bytes slab). So soon or

So, the object_size for allocated objects in that is adjusted from 96 to 128
while previously allocated objects should have no change, it is merely ksize(old_obj)
previous return 96, now returns 128, right? Okay, so this is indeed a problem
since we use ksize() to decide the bucket.


> later, when bpf_global_ma frees a 96-byte-sized pointer which is
> allocated from a bpf_mem_cache in which unit_size is 96, bpf_mem_free()
> will free the pointer through a bpf_mem_cache in which unit_size is 128,
> because the return value of ksize() changes. Maybe we should introduce a
> new API in mm which returns size instead of object_size of underlying
> slab, so the return value will not change due to slab merge.

In this case, to avoid the warning, indeed we need to use '96' instead of '128'.
So use the original ksize() return value is indeed a solution.
We could use the mechanism similar to percpu alloc to save '96' in the memory.


>
> Regards,
> Tao
>>
>>>> Regards,
>>>> Tao
>>>>> All code
>>>>> ========
>>>>>      0:    30 e8                    xor    %ch,%al
>>>>>      2:    7e 22                    jle    0x26
>>>>>      4:    04 00                    add    $0x0,%al
>>>>>      6:    8b 56 20                 mov    0x20(%rsi),%edx
>>>>>      9:    39 d0                    cmp    %edx,%eax
>>>>>      b:    74 24                    je     0x31
>>>>>      d:    80 3d 18 c0 cc c2 00     cmpb
>>>>> $0x0,-0x3d333fe8(%rip)        # 0xffffffffc2ccc02c
>>>>>     14:    75 3b                    jne    0x51
>>>>>     16:    c6 05 18 c0 cc c2 01     movb
>>>>> $0x1,-0x3d333fe8(%rip)        # 0xffffffffc2ccc035
>>>>>     1d:    52                       push   %rdx
>>>>>     1e:    50                       push   %rax
>>>>>     1f:    53                       push   %rbx
>>>>>     20:    68 df 53 57 c2           push   $0xffffffffc25753df
>>>>>     25:    e8 47 70 ef ff           call   0xffffffffffef7071
>>>>>     2a:*    0f 0b                    ud2        <-- trapping
>>>>> instruction
>>>>>     2c:    83 c4 10                 add    $0x10,%esp
>>>>>     2f:    eb 20                    jmp    0x51
>>>>>     31:    43 83 c6 74              rex.XB add $0x74,%r14d
>>>>>     35:    83 fb 0b                 cmp    $0xb,%ebx
>>>>>     38:    0f 85 6a ff ff ff        jne    0xffffffffffffffa8
>>>>>     3e:    8b                       .byte 0x8b
>>>>>     3f:    45                       rex.RB
>>>>>
>>>>> Code starting with the faulting instruction
>>>>> ===========================================
>>>>>      0:    0f 0b                    ud2
>>>>>      2:    83 c4 10                 add    $0x10,%esp
>>>>>      5:    eb 20                    jmp    0x27
>>>>>      7:    43 83 c6 74              rex.XB add $0x74,%r14d
>>>>>      b:    83 fb 0b                 cmp    $0xb,%ebx
>>>>>      e:    0f 85 6a ff ff ff        jne    0xffffffffffffff7e
>>>>>     14:    8b                       .byte 0x8b
>>>>>     15:    45                       rex.RB
>>>>> [   32.256641][    T1] EAX: 00000037 EBX: 00000000 ECX: 00000002
>>>>> EDX: 80000002
>>>>> [   32.257402][    T1] ESI: fefbda30 EDI: da953a30 EBP: c3d49ef0
>>>>> ESP: c3d49ec0
>>>>> [   32.258176][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
>>>>> EFLAGS: 00010286
>>>>> [   32.259000][    T1] CR0: 80050033 CR2: 00000000 CR3: 02dd5000
>>>>> CR4: 000406d0
>>>>> [   32.259768][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000
>>>>> DR3: 00000000
>>>>> [   32.260526][    T1] DR6: fffe0ff0 DR7: 00000400
>>>>> [   32.261021][    T1] Call Trace:
>>>>> [ 32.261376][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479
>>>>> arch/x86/kernel/dumpstack.c:465)
>>>>> [ 32.261835][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500
>>>>> kernel/bpf/memalloc.c:579)
>>>>> [ 32.262395][ T1] ? __warn (kernel/panic.c:673)
>>>>> [ 32.262840][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219)
>>>>> [ 32.263327][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500
>>>>> kernel/bpf/memalloc.c:579)
>>>>> [ 32.263884][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250)
>>>>> [ 32.264368][ T1] ? handle_bug (arch/x86/kernel/traps.c:237)
>>>>> [ 32.264833][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258
>>>>> (discriminator 1))
>>>>> [ 32.265333][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1056)
>>>>> [ 32.265903][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250)
>>>>> [ 32.266392][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500
>>>>> kernel/bpf/memalloc.c:579)
>>>>> [ 32.266982][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250)
>>>>> [ 32.267476][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500
>>>>> kernel/bpf/memalloc.c:579)
>>>>> [ 32.268050][ T1] ? irq_work_init_threads (kernel/bpf/core.c:2919)
>>>>> [ 32.268610][ T1] bpf_global_ma_init (kernel/bpf/core.c:2923)
>>>>> [ 32.269142][ T1] do_one_initcall (init/main.c:1232)
>>>>> [ 32.269657][ T1] ? debug_smp_processor_id (lib/smp_processor_id.c:61)
>>>>> [ 32.270243][ T1] ? rcu_is_watching
>>>>> (include/linux/context_tracking.h:122 kernel/rcu/tree.c:699)
>>>>> [ 32.270770][ T1] do_initcalls (init/main.c:1293 init/main.c:1310)
>>>>> [ 32.271275][ T1] kernel_init_freeable (init/main.c:1549)
>>>>> [ 32.271841][ T1] ? rest_init (init/main.c:1429)
>>>>> [ 32.272324][ T1] kernel_init (init/main.c:1439)
>>>>> [ 32.272785][ T1] ret_from_fork (arch/x86/kernel/process.c:153)
>>>>> [ 32.273272][ T1] ? rest_init (init/main.c:1429)
>>>>> [ 32.273752][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741)
>>>>> [ 32.274272][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947)
>>>>> [   32.274803][    T1] irq event stamp: 16968005
>>>>> [ 32.275293][ T1] hardirqs last enabled at (16968013):
>>>>> console_unlock (arch/x86/include/asm/irqflags.h:26
>>>>> arch/x86/include/asm/irqflags.h:67
>>>>> arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:347
>>>>> kernel/printk/printk.c:2720 kernel/printk/printk.c:3039)
>>>>> [ 32.276277][ T1] hardirqs last disabled at (16968022):
>>>>> console_unlock (kernel/printk/printk.c:345
>>>>> kernel/printk/printk.c:2720 kernel/printk/printk.c:3039)
>>>>> [ 32.277242][ T1] softirqs last enabled at (16967866): __do_softirq
>>>>> (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400
>>>>> kernel/softirq.c:582)
>>>>> [ 32.278202][ T1] softirqs last disabled at (16967861):
>>>>> do_softirq_own_stack (arch/x86/kernel/irq_32.c:57
>>>>> arch/x86/kernel/irq_32.c:147)
>>>>> [   32.279228][    T1] ---[ end trace 0000000000000000 ]---
>>>>> [   32.280294][    T1] kmemleak: Kernel memory leak detector
>>>>> initialized (mem pool available: 15783)
>>>>> [   32.281276][    T1] debug_vm_pgtable: [debug_vm_pgtable
>>>>> ]: Validating architecture page table helpers
>>>>> [   32.285847][   T74] kmemleak: Automatic memory scanning thread
>>>>> started
>>>>> [   32.290289][    T1] UBI error: cannot create "ubi" debugfs
>>>>> directory, error -2
>>>>> [   32.291558][    T1] UBI error: cannot initialize UBI, error -2
>>>>>
>>>>>
>>>>>
>>>>> The kernel config and materials to reproduce are available at:
>>>>> https://download.01.org/0day-ci/archive/20231030/202310302113.9f8fe705-oliver.sang@intel.com
>>>>>
>>>>>
>>>>>
>>>>>

