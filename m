Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DAA57E328
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGVOlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 10:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGVOlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 10:41:46 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616CF40BFC;
        Fri, 22 Jul 2022 07:41:44 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oEtqT-0007NA-7Z; Fri, 22 Jul 2022 16:41:37 +0200
Received: from [194.230.146.161] (helo=localhost.localdomain)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oEtqS-000Dq3-BM; Fri, 22 Jul 2022 16:41:36 +0200
Subject: Re: [syzbot] riscv/fixes boot error: WARNING in __apply_to_page_range
To:     syzbot <syzbot+36ce1b73a1f7a4e0894b@syzkaller.appspotmail.com>,
        andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org,
        bjorn@kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, luke.r.nels@gmail.com,
        netdev@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, xi.wang@gmail.com, yhs@fb.com
References: <00000000000018cbe205e465173b@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <967e62b6-78fe-9763-b2f8-cd56cc765af0@iogearbox.net>
Date:   Fri, 22 Jul 2022 16:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <00000000000018cbe205e465173b@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26609/Fri Jul 22 09:56:47 2022)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 3:48 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c1f6eff304e4 riscv: add as-options for modules with assemb..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e9576e080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=491348d73710a809
> dashboard link: https://syzkaller.appspot.com/bug?extid=36ce1b73a1f7a4e0894b
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+36ce1b73a1f7a4e0894b@syzkaller.appspotmail.com

[ Song, ptal, thanks! ]

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1949 at mm/memory.c:2662 apply_to_pmd_range mm/memory.c:2662 [inline]
> WARNING: CPU: 1 PID: 1949 at mm/memory.c:2662 apply_to_pud_range mm/memory.c:2705 [inline]
> WARNING: CPU: 1 PID: 1949 at mm/memory.c:2662 apply_to_p4d_range mm/memory.c:2741 [inline]
> WARNING: CPU: 1 PID: 1949 at mm/memory.c:2662 __apply_to_page_range+0x898/0x10ac mm/memory.c:2775
> Modules linked in:
> CPU: 1 PID: 1949 Comm: dhcpcd Not tainted 5.19.0-rc1-syzkaller-00004-gc1f6eff304e4 #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : apply_to_pmd_range mm/memory.c:2662 [inline]
> epc : apply_to_pud_range mm/memory.c:2705 [inline]
> epc : apply_to_p4d_range mm/memory.c:2741 [inline]
> epc : __apply_to_page_range+0x898/0x10ac mm/memory.c:2775
>   ra : apply_to_pmd_range mm/memory.c:2662 [inline]
>   ra : apply_to_pud_range mm/memory.c:2705 [inline]
>   ra : apply_to_p4d_range mm/memory.c:2741 [inline]
>   ra : __apply_to_page_range+0x898/0x10ac mm/memory.c:2775
> epc : ffffffff803fe6da ra : ffffffff803fe6da sp : ff20000013687380
>   gp : ffffffff85a89060 tp : ff60000010d96300 t0 : ff60000012046820
>   t1 : 00000000000f0000 t2 : ffffffff80437ed4 s0 : ff20000013687470
>   s1 : 0000000000000006 a0 : 0000000000000007 a1 : 00000000000f0000
>   a2 : ffffffff803fe6da a3 : 0000000000000002 a4 : ff60000010d97300
>   a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000000000000
>   s2 : fffffffeef001000 s3 : 00000000371000e7 s4 : ff6000007a660bc0
>   s5 : fffffffeef001000 s6 : 0000000000001000 s7 : 0000000000000001
>   s8 : ffffffff804a840e s9 : 0000000000000000 s10: fffffffeef000000
>   s11: 0000000000000000 t3 : fffffffff3f3f300 t4 : fffffffef09c69dc
>   t5 : fffffffef09c69dd t6 : ff6000000f3902e8
> status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [<ffffffff803fef22>] apply_to_page_range+0x34/0x46 mm/memory.c:2794
> [<ffffffff804a86b4>] kasan_populate_vmalloc+0x52/0x5e mm/kasan/shadow.c:302
> [<ffffffff80430d5e>] alloc_vmap_area+0x950/0x1340 mm/vmalloc.c:1594
> [<ffffffff804319a4>] __get_vm_area_node.constprop.0+0x256/0x378 mm/vmalloc.c:2453
> [<ffffffff80437ed4>] __vmalloc_node_range+0x130/0xbc2 mm/vmalloc.c:3125
> [<ffffffff80017cb2>] bpf_jit_alloc_exec+0x46/0x52 arch/riscv/net/bpf_jit_core.c:184
> [<ffffffff8026ffd4>] bpf_jit_binary_alloc+0x96/0x144 kernel/bpf/core.c:1056
> [<ffffffff80017a3a>] bpf_int_jit_compile+0x78e/0x9a4 arch/riscv/net/bpf_jit_core.c:111
> [<ffffffff802719b6>] bpf_prog_select_runtime+0x1a2/0x22e kernel/bpf/core.c:2219
> [<ffffffff82837d74>] bpf_migrate_filter+0x258/0x2be net/core/filter.c:1295
> [<ffffffff8283b0c0>] bpf_prepare_filter net/core/filter.c:1343 [inline]
> [<ffffffff8283b0c0>] __get_filter+0x1d6/0x2d0 net/core/filter.c:1512
> [<ffffffff82841618>] sk_attach_filter+0x22/0x11a net/core/filter.c:1527
> [<ffffffff827839b6>] sock_setsockopt+0x13ea/0x20b2 net/core/sock.c:1253
> [<ffffffff82772160>] __sys_setsockopt+0x422/0x480 net/socket.c:2255
> [<ffffffff827721f8>] __do_sys_setsockopt net/socket.c:2270 [inline]
> [<ffffffff827721f8>] sys_setsockopt+0x3a/0x4c net/socket.c:2267
> [<ffffffff80005bfa>] ret_from_syscall+0x0/0x2
> irq event stamp: 908
> hardirqs last  enabled at (907): [<ffffffff8328f0e4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (907): [<ffffffff8328f0e4>] _raw_spin_unlock_irqrestore+0x68/0x98 kernel/locking/spinlock.c:194
> hardirqs last disabled at (908): [<ffffffff80010070>] __trace_hardirqs_off+0x18/0x20 arch/riscv/kernel/trace_irq.c:25
> softirqs last  enabled at (896): [<ffffffff8328ff60>] softirq_handle_end kernel/softirq.c:414 [inline]
> softirqs last  enabled at (896): [<ffffffff8328ff60>] __do_softirq+0x618/0x8fc kernel/softirq.c:600
> softirqs last disabled at (877): [<ffffffff80066cec>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (877): [<ffffffff80066cec>] invoke_softirq kernel/softirq.c:452 [inline]
> softirqs last disabled at (877): [<ffffffff80066cec>] __irq_exit_rcu+0x142/0x1f8 kernel/softirq.c:650
> ---[ end trace 0000000000000000 ]---
> dhcpcd: vmalloc error: size 4096, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> CPU: 1 PID: 1949 Comm: dhcpcd Tainted: G        W         5.19.0-rc1-syzkaller-00004-gc1f6eff304e4 #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff8000b40e>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:111
> [<ffffffff83241e0c>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:117
> [<ffffffff83250e66>] __dump_stack lib/dump_stack.c:88 [inline]
> [<ffffffff83250e66>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
> [<ffffffff83250eee>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
> [<ffffffff80443bba>] warn_alloc+0x170/0x212 mm/page_alloc.c:4271
> [<ffffffff80437f12>] __vmalloc_node_range+0x16e/0xbc2 mm/vmalloc.c:3130
> [<ffffffff80017cb2>] bpf_jit_alloc_exec+0x46/0x52 arch/riscv/net/bpf_jit_core.c:184
> [<ffffffff8026ffd4>] bpf_jit_binary_alloc+0x96/0x144 kernel/bpf/core.c:1056
> [<ffffffff80017a3a>] bpf_int_jit_compile+0x78e/0x9a4 arch/riscv/net/bpf_jit_core.c:111
> [<ffffffff802719b6>] bpf_prog_select_runtime+0x1a2/0x22e kernel/bpf/core.c:2219
> [<ffffffff82837d74>] bpf_migrate_filter+0x258/0x2be net/core/filter.c:1295
> [<ffffffff8283b0c0>] bpf_prepare_filter net/core/filter.c:1343 [inline]
> [<ffffffff8283b0c0>] __get_filter+0x1d6/0x2d0 net/core/filter.c:1512
> [<ffffffff82841618>] sk_attach_filter+0x22/0x11a net/core/filter.c:1527
> [<ffffffff827839b6>] sock_setsockopt+0x13ea/0x20b2 net/core/sock.c:1253
> [<ffffffff82772160>] __sys_setsockopt+0x422/0x480 net/socket.c:2255
> [<ffffffff827721f8>] __do_sys_setsockopt net/socket.c:2270 [inline]
> [<ffffffff827721f8>] sys_setsockopt+0x3a/0x4c net/socket.c:2267
> [<ffffffff80005bfa>] ret_from_syscall+0x0/0x2
> Mem-Info:
> active_anon:27 inactive_anon:479 isolated_anon:0
>   active_file:632 inactive_file:81 isolated_file:0
>   unevictable:768 dirty:9 writeback:0
>   slab_reclaimable:4694 slab_unreclaimable:17966
>   mapped:420 shmem:795 pagetables:93 bounce:0
>   kernel_misc_reclaimable:0
>   free:288376 free_pcp:778 free_cma:4096
> Node 0 active_anon:108kB inactive_anon:1916kB active_file:2528kB inactive_file:324kB unevictable:3072kB isolated(anon):0kB isolated(file):0kB mapped:1680kB dirty:36kB writeback:0kB shmem:3180kB writeback_tmp:0kB kernel_stack:4472kB pagetables:372kB all_unreclaimable? no
> Node 0 DMA32 free:1153504kB boost:0kB min:4656kB low:6012kB high:7368kB reserved_highatomic:0KB active_anon:108kB inactive_anon:1916kB active_file:2528kB inactive_file:324kB unevictable:3072kB writepending:36kB present:2095104kB managed:1359072kB mlocked:0kB bounce:0kB free_pcp:3112kB local_pcp:1876kB free_cma:16384kB
> lowmem_reserve[]: 0 0 0
> Node 0 DMA32: 76*4kB (UME) 70*8kB (UME) 42*16kB (UME) 15*32kB (UME) 4*64kB (UME) 6*128kB (UME) 2*256kB (UE) 2*512kB (UM) 2*1024kB (UM) 2*2048kB (C) 279*4096kB (MC) = 1153504kB
> Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
> Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
> 1509 total pagecache pages
> 0 pages in swap cache
> Swap cache stats: add 0, delete 0, find 0/0
> Free swap  = 0kB
> Total swap = 0kB
> 523776 pages RAM
> 0 pages HighMem/MovableOnly
> 184008 pages reserved
> 4096 pages cma reserved
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

