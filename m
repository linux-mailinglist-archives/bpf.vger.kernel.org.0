Return-Path: <bpf+bounces-13700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F57E7DC7D2
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8569EB20EE9
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C310A3B;
	Tue, 31 Oct 2023 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00E10FD
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:01:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA89DB;
	Tue, 31 Oct 2023 01:01:25 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SKMyy6J5pz4f3jrm;
	Tue, 31 Oct 2023 16:01:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 01ECD1A0171;
	Tue, 31 Oct 2023 16:01:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBH0M9JtEBlu0O_EQ--.40065S2;
	Tue, 31 Oct 2023 16:01:16 +0800 (CST)
Subject: Re: [linus:master] [bpf] c930472552:
 WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <202310302113.9f8fe705-oliver.sang@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7506b682-3be3-fcd0-4bb4-c1db48f609a2@huaweicloud.com>
Date: Tue, 31 Oct 2023 16:01:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202310302113.9f8fe705-oliver.sang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBH0M9JtEBlu0O_EQ--.40065S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1DXr18tF1UZw4xZw1xGrg_yoW3Ww1xpa
	y3JFyxGr4kZFWUJ3WUJF1Fyr15XwnYy3W7tF9rKr1rZr1jkryDZrZ7XrWSqr9IkrWDCr13
	JF1DtF48tryUXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/30/2023 10:11 PM, kernel test robot wrote:
> hi, Hou Tao,
>
> we noticed a WARN_ONCE added in this commit was hit in our tests. FYI.
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init" on:
>
> commit: c930472552022bd09aab3cd946ba3f243070d5c7 ("bpf: Ensure unit_size is matched with slab cache object size")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master ffc253263a1375a65fa6c9f62a893e9767fbebfa]
> [test failed on linux-next/master c503e3eec382ac708ee7adf874add37b77c5d312]
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +-------------------------------------------------------------+------------+------------+
> |                                                             | b1d53958b6 | c930472552 |
> +-------------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/bpf/memalloc.c:#bpf_mem_alloc_init        | 0          | 14         |
> | EIP:bpf_mem_alloc_init                                      | 0          | 14         |
> +-------------------------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310302113.9f8fe705-oliver.sang@intel.com
>
>
> [   32.249545][    T1] ------------[ cut here ]------------
> [   32.250152][    T1] bpf_mem_cache[0]: unexpected object size 128, expect 96
> [ 32.250953][ T1] WARNING: CPU: 1 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
> [   32.252065][    T1] Modules linked in:
> [   32.252548][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-12679-gc93047255202 #1
> [ 32.253767][ T1] EIP: bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
> [ 32.254439][ T1] Code: 30 e8 7e 22 04 00 8b 56 20 39 d0 74 24 80 3d 18 c0 cc c2 00 75 3b c6 05 18 c0 cc c2 01 52 50 53 68 df 53 57 c2 e8 47 70 ef ff <0f> 0b 83 c4 10 eb 20 43 83 c6 74 83 fb 0b 0f 85 6a ff ff ff 8b 45

Thanks for the report. I also could reproduce the warning in v6.6 by
following the reproducing steps in the link below.

According the reproduce job, it seems that the kernel is built for i386
(make HOSTCC=gcc-12 CC=gcc-12 ARCH=i386 olddefconfig prepare
modules_prepare bzImage) and in .config CONFIG_SLAB instead of
CONFIG_SLUB is enabled, I will check whether or not these two setups
make any thing being different.

Regards,
Tao
> All code
> ========
>    0:	30 e8                	xor    %ch,%al
>    2:	7e 22                	jle    0x26
>    4:	04 00                	add    $0x0,%al
>    6:	8b 56 20             	mov    0x20(%rsi),%edx
>    9:	39 d0                	cmp    %edx,%eax
>    b:	74 24                	je     0x31
>    d:	80 3d 18 c0 cc c2 00 	cmpb   $0x0,-0x3d333fe8(%rip)        # 0xffffffffc2ccc02c
>   14:	75 3b                	jne    0x51
>   16:	c6 05 18 c0 cc c2 01 	movb   $0x1,-0x3d333fe8(%rip)        # 0xffffffffc2ccc035
>   1d:	52                   	push   %rdx
>   1e:	50                   	push   %rax
>   1f:	53                   	push   %rbx
>   20:	68 df 53 57 c2       	push   $0xffffffffc25753df
>   25:	e8 47 70 ef ff       	call   0xffffffffffef7071
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	83 c4 10             	add    $0x10,%esp
>   2f:	eb 20                	jmp    0x51
>   31:	43 83 c6 74          	rex.XB add $0x74,%r14d
>   35:	83 fb 0b             	cmp    $0xb,%ebx
>   38:	0f 85 6a ff ff ff    	jne    0xffffffffffffffa8
>   3e:	8b                   	.byte 0x8b
>   3f:	45                   	rex.RB
>
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	83 c4 10             	add    $0x10,%esp
>    5:	eb 20                	jmp    0x27
>    7:	43 83 c6 74          	rex.XB add $0x74,%r14d
>    b:	83 fb 0b             	cmp    $0xb,%ebx
>    e:	0f 85 6a ff ff ff    	jne    0xffffffffffffff7e
>   14:	8b                   	.byte 0x8b
>   15:	45                   	rex.RB
> [   32.256641][    T1] EAX: 00000037 EBX: 00000000 ECX: 00000002 EDX: 80000002
> [   32.257402][    T1] ESI: fefbda30 EDI: da953a30 EBP: c3d49ef0 ESP: c3d49ec0
> [   32.258176][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
> [   32.259000][    T1] CR0: 80050033 CR2: 00000000 CR3: 02dd5000 CR4: 000406d0
> [   32.259768][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   32.260526][    T1] DR6: fffe0ff0 DR7: 00000400
> [   32.261021][    T1] Call Trace:
> [ 32.261376][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
> [ 32.261835][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
> [ 32.262395][ T1] ? __warn (kernel/panic.c:673) 
> [ 32.262840][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
> [ 32.263327][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
> [ 32.263884][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 32.264368][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
> [ 32.264833][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
> [ 32.265333][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
> [ 32.265903][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 32.266392][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
> [ 32.266982][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 32.267476][ T1] ? bpf_mem_alloc_init (kernel/bpf/memalloc.c:500 kernel/bpf/memalloc.c:579) 
> [ 32.268050][ T1] ? irq_work_init_threads (kernel/bpf/core.c:2919) 
> [ 32.268610][ T1] bpf_global_ma_init (kernel/bpf/core.c:2923) 
> [ 32.269142][ T1] do_one_initcall (init/main.c:1232) 
> [ 32.269657][ T1] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
> [ 32.270243][ T1] ? rcu_is_watching (include/linux/context_tracking.h:122 kernel/rcu/tree.c:699) 
> [ 32.270770][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
> [ 32.271275][ T1] kernel_init_freeable (init/main.c:1549) 
> [ 32.271841][ T1] ? rest_init (init/main.c:1429) 
> [ 32.272324][ T1] kernel_init (init/main.c:1439) 
> [ 32.272785][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 32.273272][ T1] ? rest_init (init/main.c:1429) 
> [ 32.273752][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
> [ 32.274272][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
> [   32.274803][    T1] irq event stamp: 16968005
> [ 32.275293][ T1] hardirqs last enabled at (16968013): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:347 kernel/printk/printk.c:2720 kernel/printk/printk.c:3039) 
> [ 32.276277][ T1] hardirqs last disabled at (16968022): console_unlock (kernel/printk/printk.c:345 kernel/printk/printk.c:2720 kernel/printk/printk.c:3039) 
> [ 32.277242][ T1] softirqs last enabled at (16967866): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
> [ 32.278202][ T1] softirqs last disabled at (16967861): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
> [   32.279228][    T1] ---[ end trace 0000000000000000 ]---
> [   32.280294][    T1] kmemleak: Kernel memory leak detector initialized (mem pool available: 15783)
> [   32.281276][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [   32.285847][   T74] kmemleak: Automatic memory scanning thread started
> [   32.290289][    T1] UBI error: cannot create "ubi" debugfs directory, error -2
> [   32.291558][    T1] UBI error: cannot initialize UBI, error -2
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231030/202310302113.9f8fe705-oliver.sang@intel.com
>
>
>


