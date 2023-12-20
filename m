Return-Path: <bpf+bounces-18369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCAA819B3F
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CBBB22292
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901291DA40;
	Wed, 20 Dec 2023 09:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D41DA27;
	Wed, 20 Dec 2023 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sw7Lc5VRzz4f3kFl;
	Wed, 20 Dec 2023 17:19:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8302F1A053D;
	Wed, 20 Dec 2023 17:19:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3hgy1sYJl61qXEA--.53222S2;
	Wed, 20 Dec 2023 17:19:53 +0800 (CST)
Subject: Re: BUG: unable to handle kernel paging request in
 bpf_probe_read_compat_str
To: xingwei lee <xrivendell7@gmail.com>, song@kernel.org
Cc: ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cde2ebc4-7e7d-56be-5f08-6d261142189e@huaweicloud.com>
Date: Wed, 20 Dec 2023 17:19:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3hgy1sYJl61qXEA--.53222S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW8Aw1xKr1UWr43KF4Durg_yoWfuFWDpr
	y5JFWfWr4rtr4xW3ZrAw1xArnrC39rCFn8G3yUWr1rAF4UXry5Gw47Jay8CF1kCr4qyF13
	tayDX3y7t3Wkuw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi,

On 12/14/2023 11:40 AM, xingwei lee wrote:
> Hello I found a bug in net/bpf in the lastest upstream linux and
> comfired in the lastest net tree and lastest net bpf titled BUG:
> unable to handle kernel paging request in bpf_probe_read_compat_str
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
>
> kernel: net 9702817384aa4a3700643d0b26e71deac0172cfd / bpf
> 2f2fee2bf74a7e31d06fc6cb7ba2bd4dd7753c99
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=b50bd31249191be8
>
> in the lastest bpf tree, the crash like:
>
> TITLE: BUG: unable to handle kernel paging request in bpf_probe_read_compat_str
> CORRUPTED: false ()
> MAINTAINERS (TO): [akpm@linux-foundation.org linux-mm@kvack.org]
> MAINTAINERS (CC): [linux-kernel@vger.kernel.org]
>
> BUG: unable to handle page fault for address: ff0

Thanks for the report and reproducer. The output is incomplete. It
should be: "BUG: unable to handle page fault for address:
ffffffffff600000". The address is a vsyscall address, so
handle_page_fault() considers that the fault address is in userspace
instead of kernel space, and there will be no fix-up for the exception
and oops happened. Will post a fix and a selftest for it.
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD cf7a067 P4D cf7a067 PUD cf7c067 PMD cf9f067 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8219 Comm: 9de Not tainted 6.7.0-rc41
> Hardware name: QEMU Standard PC (i440FX + PIIX, 4
> RIP: 0010:strncpy_from_kernel_nofault+0xc4/0x270 mm/maccess.c:91
> Code: 83 85 6c 17 00 00 01 48 8b 2c 24 eb 18 e8 0
> RSP: 0018:ffffc900114e7ac0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc900114e7b30 RCX:2
> RDX: ffff8880183abcc0 RSI: ffffffff81b8c9c4 RDI:c
> RBP: ffffffffff600000 R08: 0000000000000001 R09:0
> R10: 0000000000000001 R11: 0000000000000001 R12:8
> R13: ffffffffff600000 R14: 0000000000000008 R15:0
> FS:  0000000000000000(0000) GS:ffff88823bc00000(0
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600000 CR3: 000000000cf77000 CR4:0
> PKRU: 55555554
> Call Trace:
> <TASK>
> bpf_probe_read_kernel_str_common kernel/trace/bpf_trace.c:262 [inline]
> ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:310 [inline]
> bpf_probe_read_compat_str+0x12f/0x170 kernel/trace/bpf_trace.c:303
> bpf_prog_f17ebaf3f5f7baf8+0x42/0x44
> bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
> __bpf_prog_run include/linux/filter.h:651 [inline]
> bpf_prog_run include/linux/filter.h:658 [inline]
> __bpf_trace_run kernel/trace/bpf_trace.c:2307 [inline]
> bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2346
> trace_kfree include/trace/events/kmem.h:94 [inline]
> kfree+0xec/0x150 mm/slab_common.c:1043
> vma_numab_state_free include/linux/mm.h:638 [inline]
> __vm_area_free+0x3e/0x140 kernel/fork.c:525
> remove_vma+0x128/0x170 mm/mmap.c:146
> exit_mmap+0x453/0xa70 mm/mmap.c:3332
> __mmput+0x12a/0x4d0 kernel/fork.c:1349
> mmput+0x62/0x70 kernel/fork.c:1371
> exit_mm kernel/exit.c:567 [inline]
> do_exit+0x9aa/0x2ac0 kernel/exit.c:858
> do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
> __do_sys_exit_group kernel/exit.c:1032 [inline]
> __se_sys_exit_group kernel/exit.c:1030 [inline]
> __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x41/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>
> =* repro.c =*
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
>
> #define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
> #define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)     \
>  *(type*)(addr) =                                                   \
>      htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
>            (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))
>
> uint64_t r[1] = {0xffffffffffffffff};
>
> int main(void) {
>  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  intptr_t res = 0;
>  *(uint32_t*)0x200000c0 = 0x11;
>  *(uint32_t*)0x200000c4 = 0xb;
>  *(uint64_t*)0x200000c8 = 0x20000180;
>  *(uint8_t*)0x20000180 = 0x18;
>  STORE_BY_BITMASK(uint8_t, , 0x20000181, 0, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x20000181, 0, 4, 4);
>  *(uint16_t*)0x20000182 = 0;
>  *(uint32_t*)0x20000184 = 0;
>  *(uint8_t*)0x20000188 = 0;
>  *(uint8_t*)0x20000189 = 0;
>  *(uint16_t*)0x2000018a = 0;
>  *(uint32_t*)0x2000018c = 0;
>  *(uint8_t*)0x20000190 = 0x18;
>  STORE_BY_BITMASK(uint8_t, , 0x20000191, 1, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x20000191, 0, 4, 4);
>  *(uint16_t*)0x20000192 = 0;
>  *(uint32_t*)0x20000194 = 0x25702020;
>  *(uint8_t*)0x20000198 = 0;
>  *(uint8_t*)0x20000199 = 0;
>  *(uint16_t*)0x2000019a = 0;
>  *(uint32_t*)0x2000019c = 0x20202000;
>  STORE_BY_BITMASK(uint8_t, , 0x200001a0, 3, 0, 3);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a0, 3, 3, 2);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a0, 3, 5, 3);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a1, 0xa, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a1, 1, 4, 4);
>  *(uint16_t*)0x200001a2 = 0xfff8;
>  *(uint32_t*)0x200001a4 = 0;
>  STORE_BY_BITMASK(uint8_t, , 0x200001a8, 7, 0, 3);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a8, 1, 3, 1);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a8, 0xb, 4, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a9, 1, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001a9, 0xa, 4, 4);
>  *(uint16_t*)0x200001aa = 0;
>  *(uint32_t*)0x200001ac = 0;
>  STORE_BY_BITMASK(uint8_t, , 0x200001b0, 7, 0, 3);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b0, 0, 3, 1);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b0, 0, 4, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b1, 1, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b1, 0, 4, 4);
>  *(uint16_t*)0x200001b2 = 0;
>  *(uint32_t*)0x200001b4 = 0xfffffff8;
>  STORE_BY_BITMASK(uint8_t, , 0x200001b8, 7, 0, 3);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b8, 0, 3, 1);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b8, 0xb, 4, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b9, 2, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001b9, 0, 4, 4);
>  *(uint16_t*)0x200001ba = 0;
>  *(uint32_t*)0x200001bc = 8;
>  STORE_BY_BITMASK(uint8_t, , 0x200001c0, 7, 0, 3);
>  STORE_BY_BITMASK(uint8_t, , 0x200001c0, 0, 3, 1);
>  STORE_BY_BITMASK(uint8_t, , 0x200001c0, 0xb, 4, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001c1, 3, 0, 4);
>  STORE_BY_BITMASK(uint8_t, , 0x200001c1, 0, 4, 4);
>  *(uint16_t*)0x200001c2 = 0;
>  *(uint32_t*)0x200001c4 = 0xff600000;
>  *(uint8_t*)0x200001c8 = 0x85;
>  *(uint8_t*)0x200001c9 = 0;
>  *(uint16_t*)0x200001ca = 0;
>  *(uint32_t*)0x200001cc = 0x2d;
>  *(uint8_t*)0x200001d0 = 0x95;
>  *(uint8_t*)0x200001d1 = 0;
>  *(uint16_t*)0x200001d2 = 0;
>  *(uint32_t*)0x200001d4 = 0;
>  *(uint64_t*)0x200000d0 = 0x20000200;
>  memcpy((void*)0x20000200, "GPL\000", 4);
>  *(uint32_t*)0x200000d8 = 0;
>  *(uint32_t*)0x200000dc = 0;
>  *(uint64_t*)0x200000e0 = 0;
>  *(uint32_t*)0x200000e8 = 0;
>  *(uint32_t*)0x200000ec = 0;
>  memset((void*)0x200000f0, 0, 16);
>  *(uint32_t*)0x20000100 = 0;
>  *(uint32_t*)0x20000104 = 0;
>  *(uint32_t*)0x20000108 = 0;
>  *(uint32_t*)0x2000010c = 0;
>  *(uint64_t*)0x20000110 = 0;
>  *(uint32_t*)0x20000118 = 0;
>  *(uint32_t*)0x2000011c = 0;
>  *(uint64_t*)0x20000120 = 0;
>  *(uint32_t*)0x20000128 = 0;
>  *(uint32_t*)0x2000012c = 0;
>  *(uint32_t*)0x20000130 = 0;
>  *(uint32_t*)0x20000134 = 0;
>  *(uint64_t*)0x20000138 = 0;
>  *(uint64_t*)0x20000140 = 0;
>  *(uint32_t*)0x20000148 = 0;
>  *(uint32_t*)0x2000014c = 0;
>  res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200000c0ul, /*size=*/0x90ul);
>  if (res != -1) r[0] = res;
>  *(uint64_t*)0x20000540 = 0x20000000;
>  memcpy((void*)0x20000000, "kfree\000", 6);
>  *(uint32_t*)0x20000548 = r[0];
>  syscall(__NR_bpf, /*cmd=*/0x11ul, /*arg=*/0x20000540ul, /*size=*/0x10ul);
>  return 0;
> }
>
> =* repro.txt =*
> r0 = bpf$PROG_LOAD(0x5, &(0x7f00000000c0)={0x11, 0xb,
> &(0x7f0000000180)=@framed={{}, [@printk={@p, {}, {}, {}, {}, {0x7,
> 0x0, 0xb, 0x3, 0x0, 0x0, 0xff600000}, {0x85, 0x0, 0x0, 0x2d}}]},
> &(0x7f0000000200)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
> 0x90)
> bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
> &(0x7f0000000540)={&(0x7f0000000000)='kfree\x00', r0}, 0x10)
>
>
>
> See aslo https://gist.github.com/xrivendell7/7bb1f0a30ccc2899fe7ea34bef882067
> I hope it helps.
>
> Best regards.
> xingwei Lee
>
> .


