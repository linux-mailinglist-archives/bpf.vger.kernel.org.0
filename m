Return-Path: <bpf+bounces-10122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6F7A12C0
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 03:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C8B1C20F48
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF237F5;
	Fri, 15 Sep 2023 01:06:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05936A;
	Fri, 15 Sep 2023 01:06:00 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CB2111;
	Thu, 14 Sep 2023 18:05:59 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RmwrD74PsztRtk;
	Fri, 15 Sep 2023 09:01:48 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 09:05:56 +0800
Message-ID: <22dda933-9c60-e515-733f-97958ab42563@huawei.com>
Date: Fri, 15 Sep 2023 09:05:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v4 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
To: Jakub Sitnicki <jakub@cloudflare.com>
CC: <john.fastabend@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230902100744.2687785-1-liujian56@huawei.com>
 <87il8f9tuo.fsf@cloudflare.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <87il8f9tuo.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected



On 2023/9/13 1:21, Jakub Sitnicki wrote:
> On Sat, Sep 02, 2023 at 06:07 PM +08, Liu Jian wrote:
>> v3->v4: Change the two helpers's description.
>> 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
> 
> I gave it another try. But somethings is still not right.
> 
> sockmap tests run cleanly for me on bpf tree @ 4eb94a779307.
> 
> But with this patch set applied I'm seeing a refcount splat. Please see
> the sample session log at the end. Reproducible every time.
> 
> I've also included the warning itself with the stack trace decoded. Once
> again, this is commit 4eb94a779307 with these patches on top.
> 
> I'm preparing for a talk that is in a few weeks [1], so unfortunately I
> have limited cycles to help debug this.
I'll try and debug this issue. Thank you for taking the time to review it.
> 
> [1] https://www.usenix.org/conference/srecon23emea/presentation/sitnicki
> 
> $ ./scripts/decode_stacktrace.sh ./vmlinux < trace.txt
> [    7.846863] ------------[ cut here ]------------
> [    7.847383] refcount_t: underflow; use-after-free.
> [    7.847919] WARNING: CPU: 3 PID: 36 at lib/refcount.c:28 refcount_warn_saturate (lib/refcount.c:28 (discriminator 1))
> [    7.848719] Modules linked in: bpf_testmod(OE)
> [    7.850364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> [    7.851893] Workqueue: events sk_psock_destroy
> [    7.852617] RIP: 0010:refcount_warn_saturate (lib/refcount.c:28 (discriminator 1))
> [ 7.853383] Code: 01 e8 32 f0 a9 ff 0f 0b 5d c3 cc cc cc cc 80 3d 24 c5 01 02 00 75 81 48 c7 c7 98 cc 77 82 c6 05 14 c5 01 02 01 e8 0e f0 a9 ff <0f> 0b 5d c3 cc cc cc cc 80 3d 01 c5 01 02 00 0f 85 59 ff ff ff 48
> All code
> ========
>     0:   01 e8                   add    %ebp,%eax
>     2:   32 f0                   xor    %al,%dh
>     4:   a9 ff 0f 0b 5d          test   $0x5d0b0fff,%eax
>     9:   c3                      ret
>     a:   cc                      int3
>     b:   cc                      int3
>     c:   cc                      int3
>     d:   cc                      int3
>     e:   80 3d 24 c5 01 02 00    cmpb   $0x0,0x201c524(%rip)        # 0x201c539
>    15:   75 81                   jne    0xffffffffffffff98
>    17:   48 c7 c7 98 cc 77 82    mov    $0xffffffff8277cc98,%rdi
>    1e:   c6 05 14 c5 01 02 01    movb   $0x1,0x201c514(%rip)        # 0x201c539
>    25:   e8 0e f0 a9 ff          call   0xffffffffffa9f038
>    2a:*  0f 0b                   ud2             <-- trapping instruction
>    2c:   5d                      pop    %rbp
>    2d:   c3                      ret
>    2e:   cc                      int3
>    2f:   cc                      int3
>    30:   cc                      int3
>    31:   cc                      int3
>    32:   80 3d 01 c5 01 02 00    cmpb   $0x0,0x201c501(%rip)        # 0x201c53a
>    39:   0f 85 59 ff ff ff       jne    0xffffffffffffff98
>    3f:   48                      rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   0f 0b                   ud2
>     2:   5d                      pop    %rbp
>     3:   c3                      ret
>     4:   cc                      int3
>     5:   cc                      int3
>     6:   cc                      int3
>     7:   cc                      int3
>     8:   80 3d 01 c5 01 02 00    cmpb   $0x0,0x201c501(%rip)        # 0x201c510
>     f:   0f 85 59 ff ff ff       jne    0xffffffffffffff6e
>    15:   48                      rex.W
> [    7.855330] RSP: 0018:ffffc9000014bdd8 EFLAGS: 00010282
> [    7.855891] RAX: 0000000000000000 RBX: ffff888104ea0438 RCX: 0000000000000000
> [    7.856539] RDX: 0000000000000002 RSI: ffffc9000014bc50 RDI: 00000000ffffffff
> [    7.857348] RBP: ffffc9000014bdd8 R08: 0000000000000000 R09: ffffffff82e9bd60
> [    7.858088] R10: ffffc9000014bc48 R11: ffffffff8359bda8 R12: ffff888104ea0268
> [    7.858956] R13: ffff888104ea0268 R14: ffff888104ea0268 R15: dead000000000100
> [    7.859687] FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
> [    7.860349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.861013] CR2: 00007f4e2d2a7f78 CR3: 0000000002e6e002 CR4: 0000000000770ea0
> [    7.862014] PKRU: 55555554
> [    7.862224] Call Trace:
> [    7.862515]  <TASK>
> [    7.862719] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [    7.863159] ? __warn (kernel/panic.c:673)
> [    7.863521] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 1))
> [    7.864073] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [    7.864523] ? handle_bug (arch/x86/kernel/traps.c:237)
> [    7.864954] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1))
> [    7.865379] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
> [    7.866011] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 1))
> [    7.866613] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 1))
> [    7.867159] sk_psock_destroy (./include/linux/refcount.h:283 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 ./include/net/sock.h:1990 net/core/skmsg.c:828)
> [    7.867579] process_one_work (kernel/workqueue.c:2630)
> [    7.868120] worker_thread (kernel/workqueue.c:2697 (discriminator 2) kernel/workqueue.c:2784 (discriminator 2))
> [    7.868363] ? rescuer_thread (kernel/workqueue.c:2730)
> [    7.868589] kthread (kernel/kthread.c:388)
> [    7.869017] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [    7.869716] ret_from_fork (arch/x86/kernel/process.c:147)
> [    7.870273] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [    7.870889] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> [    7.871374]  </TASK>
> [    7.871818] irq event stamp: 2515
> [    7.872285] hardirqs last enabled at (2523): console_unlock (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 ./arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:347 kernel/printk/printk.c:2720 kernel/printk/printk.c:3039)
> [    7.873173] hardirqs last disabled at (2532): console_unlock (kernel/printk/printk.c:345 (discriminator 3) kernel/printk/printk.c:2720 (discriminator 3) kernel/printk/printk.c:3039 (discriminator 3))
> [    7.874103] softirqs last enabled at (2190): __do_softirq (./arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582)
> [    7.875196] softirqs last disabled at (2185): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
> [    7.875811] ---[ end trace 0000000000000000 ]---
> 
> --8<--
> 
> bash-5.2# ./test_progs -t sockmap
> [    7.691453] bpf_testmod: loading out-of-tree module taints kernel.
> [    7.691759] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
> #24      bpf_sockmap_map_iter_fd:OK
> #211/1   sockmap_basic/sockmap create_update_free:OK
> #211/2   sockmap_basic/sockhash create_update_free:OK
> #211/3   sockmap_basic/sockmap sk_msg load helpers:OK
> #211/4   sockmap_basic/sockhash sk_msg load helpers:OK
> #211/5   sockmap_basic/sockmap update:OK
> #211/6   sockmap_basic/sockhash update:OK
> #211/7   sockmap_basic/sockmap update in unsafe context:OK
> #211/8   sockmap_basic/sockmap copy:OK
> #211/9   sockmap_basic/sockhash copy:OK
> #211/10  sockmap_basic/sockmap skb_verdict attach:OK
> #211/11  sockmap_basic/sockmap msg_verdict progs query:OK
> #211/12  sockmap_basic/sockmap stream_parser progs query:OK
> #211/13  sockmap_basic/sockmap stream_verdict progs query:OK
> #211/14  sockmap_basic/sockmap skb_verdict progs query:OK
> #211/15  sockmap_basic/sockmap skb_verdict shutdown:OK
> #211/16  sockmap_basic/sockmap skb_verdict fionread:OK
> #211/17  sockmap_basic/sockmap skb_verdict fionread on drop:OK
> #211/18  sockmap_basic/sockmap msg_verdict:OK
> #211/19  sockmap_basic/sockmap msg_verdict ingress:OK
> #211/20  sockmap_basic/sockmap msg_verdict permanent:OK
> #211/21  sockmap_basic/sockmap msg_verdict ingress permanent:OK
> #211/22  sockmap_basic/sockmap msg_verdict permanent self:OK
> #211/23  sockmap_basic/sockmap msg_verdict ingress permanent self:OK
> #211/24  sockmap_basic/sockmap msg_verdict permanent shutdown:OK
> #211/25  sockmap_basic/sockmap msg_verdict ingress permanent shutdown:OK
> #211/26  sockmap_basic/sockmap msg_verdict shutdown:OK
> #211/27  sockmap_basic/sockmap msg_verdict ingress shutdown:OK
> #211     sockmap_basic:OK
> #212/1   sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> #212/2   sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> #212/3   sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> #212/4   sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> #212/5   sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> #212/6   sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> #212/7   sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> #212/8   sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> #212     sockmap_ktls:OK
> [    7.846863] ------------[ cut here ]------------
> [    7.847383] refcount_t: underflow; use-after-free.
> [    7.847919] WARNING: CPU: 3 PID: 36 at lib/refcount.c:28 refcount_warn_saturate+0xc2/0x110
> [    7.848719] Modules linked in: bpf_testmod(OE)
> [    7.849207] CPU: 3 PID: 36 Comm: kworker/3:0 Tainted: G           OE      6.5.0+ #13
> [    7.850364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> [    7.851893] Workqueue: events sk_psock_destroy
> [    7.852617] RIP: 0010:refcount_warn_saturate+0xc2/0x110
> [    7.853383] Code: 01 e8 32 f0 a9 ff 0f 0b 5d c3 cc cc cc cc 80 3d 24 c5 01 02 00 75 81 48 c7 c7 98 cc 77 82 c6 05 14 c5 01 02 01 e8 0e f0 a9 ff <0f> 0b 5d c3 cc cc cc cc 80 3d 01 c5 01 02 00 0f 85 59 ff ff ff 48
> [    7.855330] RSP: 0018:ffffc9000014bdd8 EFLAGS: 00010282
> [    7.855891] RAX: 0000000000000000 RBX: ffff888104ea0438 RCX: 0000000000000000
> [    7.856539] RDX: 0000000000000002 RSI: ffffc9000014bc50 RDI: 00000000ffffffff
> [    7.857348] RBP: ffffc9000014bdd8 R08: 0000000000000000 R09: ffffffff82e9bd60
> [    7.858088] R10: ffffc9000014bc48 R11: ffffffff8359bda8 R12: ffff888104ea0268
> [    7.858956] R13: ffff888104ea0268 R14: ffff888104ea0268 R15: dead000000000100
> [    7.859687] FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
> [    7.860349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.861013] CR2: 00007f4e2d2a7f78 CR3: 0000000002e6e002 CR4: 0000000000770ea0
> [    7.862014] PKRU: 55555554
> [    7.862224] Call Trace:
> [    7.862515]  <TASK>
> [    7.862719]  ? show_regs+0x60/0x70
> [    7.863159]  ? __warn+0x84/0x180
> [    7.863521]  ? refcount_warn_saturate+0xc2/0x110
> [    7.864073]  ? report_bug+0x192/0x1c0
> [    7.864523]  ? handle_bug+0x42/0x80
> [    7.864954]  ? exc_invalid_op+0x18/0x70
> [    7.865379]  ? asm_exc_invalid_op+0x1b/0x20
> [    7.866011]  ? refcount_warn_saturate+0xc2/0x110
> [    7.866613]  ? refcount_warn_saturate+0xc2/0x110
> [    7.867159]  sk_psock_destroy+0x2c5/0x2e0
> [    7.867579]  process_one_work+0x1fe/0x4f0
> [    7.868120]  worker_thread+0x1d6/0x3d0
> [    7.868363]  ? rescuer_thread+0x380/0x380
> [    7.868589]  kthread+0x106/0x140
> [    7.869017]  ? kthread_complete_and_exit+0x20/0x20
> [    7.869716]  ret_from_fork+0x35/0x60
> [    7.870273]  ? kthread_complete_and_exit+0x20/0x20
> [    7.870889]  ret_from_fork_asm+0x11/0x20
> [    7.871374]  </TASK>
> [    7.871818] irq event stamp: 2515
> [    7.872285] hardirqs last  enabled at (2523): [<ffffffff811ae505>] console_unlock+0x105/0x130
> [    7.873173] hardirqs last disabled at (2532): [<ffffffff811ae4ea>] console_unlock+0xea/0x130
> [    7.874103] softirqs last  enabled at (2190): [<ffffffff81d21495>] __do_softirq+0x2f5/0x3f3
> [    7.875196] softirqs last disabled at (2185): [<ffffffff8112d18f>] irq_exit_rcu+0x8f/0xf0
> [    7.875811] ---[ end trace 0000000000000000 ]---
> #213/1   sockmap_listen/sockmap IPv4 TCP test_insert_invalid:OK
> #213/2   sockmap_listen/sockmap IPv4 TCP test_insert_opened:OK
> #213/3   sockmap_listen/sockmap IPv4 TCP test_insert_bound:OK
> #213/4   sockmap_listen/sockmap IPv4 TCP test_insert:OK
> #213/5   sockmap_listen/sockmap IPv4 TCP test_delete_after_insert:OK
> #213/6   sockmap_listen/sockmap IPv4 TCP test_delete_after_close:OK
> #213/7   sockmap_listen/sockmap IPv4 TCP test_lookup_after_insert:OK
> #213/8   sockmap_listen/sockmap IPv4 TCP test_lookup_after_delete:OK
> #213/9   sockmap_listen/sockmap IPv4 TCP test_lookup_32_bit_value:OK
> #213/10  sockmap_listen/sockmap IPv4 TCP test_update_existing:OK
> #213/11  sockmap_listen/sockmap IPv4 TCP test_destroy_orphan_child:OK
> #213/12  sockmap_listen/sockmap IPv4 TCP test_syn_recv_insert_delete:OK
> #213/13  sockmap_listen/sockmap IPv4 TCP test_race_insert_listen:OK
> #213/14  sockmap_listen/sockmap IPv4 TCP test_clone_after_delete:OK
> #213/15  sockmap_listen/sockmap IPv4 TCP test_accept_after_delete:OK
> #213/16  sockmap_listen/sockmap IPv4 TCP test_accept_before_delete:OK
> #213/17  sockmap_listen/sockmap IPv4 UDP test_insert_invalid:OK
> #213/18  sockmap_listen/sockmap IPv4 UDP test_insert_opened:OK
> #213/19  sockmap_listen/sockmap IPv4 UDP test_insert:OK
> #213/20  sockmap_listen/sockmap IPv4 UDP test_delete_after_insert:OK
> #213/21  sockmap_listen/sockmap IPv4 UDP test_delete_after_close:OK
> #213/22  sockmap_listen/sockmap IPv4 UDP test_lookup_after_insert:OK
> #213/23  sockmap_listen/sockmap IPv4 UDP test_lookup_after_delete:OK
> #213/24  sockmap_listen/sockmap IPv4 UDP test_lookup_32_bit_value:OK
> #213/25  sockmap_listen/sockmap IPv4 UDP test_update_existing:OK
> #213/26  sockmap_listen/sockmap IPv4 test_skb_redir_to_connected:OK
> #213/27  sockmap_listen/sockmap IPv4 test_skb_redir_to_listening:OK
> #213/28  sockmap_listen/sockmap IPv4 test_skb_redir_partial:OK
> #213/29  sockmap_listen/sockmap IPv4 test_msg_redir_to_connected:OK
> #213/30  sockmap_listen/sockmap IPv4 test_msg_redir_to_listening:OK
> #213/31  sockmap_listen/sockmap IPv4 TCP test_reuseport_select_listening:OK
> #213/32  sockmap_listen/sockmap IPv4 TCP test_reuseport_select_connected:OK
> #213/33  sockmap_listen/sockmap IPv4 TCP test_reuseport_mixed_groups:OK
> #213/34  sockmap_listen/sockmap IPv4 UDP test_reuseport_select_listening:OK
> #213/35  sockmap_listen/sockmap IPv4 UDP test_reuseport_select_connected:OK
> #213/36  sockmap_listen/sockmap IPv4 UDP test_reuseport_mixed_groups:OK
> #213/37  sockmap_listen/sockmap IPv4 test_udp_redir:OK
> #213/38  sockmap_listen/sockmap IPv4 test_udp_unix_redir:OK
> #213/39  sockmap_listen/sockmap IPv6 TCP test_insert_invalid:OK
> #213/40  sockmap_listen/sockmap IPv6 TCP test_insert_opened:OK
> #213/41  sockmap_listen/sockmap IPv6 TCP test_insert_bound:OK
> #213/42  sockmap_listen/sockmap IPv6 TCP test_insert:OK
> #213/43  sockmap_listen/sockmap IPv6 TCP test_delete_after_insert:OK
> #213/44  sockmap_listen/sockmap IPv6 TCP test_delete_after_close:OK
> #213/45  sockmap_listen/sockmap IPv6 TCP test_lookup_after_insert:OK
> #213/46  sockmap_listen/sockmap IPv6 TCP test_lookup_after_delete:OK
> #213/47  sockmap_listen/sockmap IPv6 TCP test_lookup_32_bit_value:OK
> #213/48  sockmap_listen/sockmap IPv6 TCP test_update_existing:OK
> #213/49  sockmap_listen/sockmap IPv6 TCP test_destroy_orphan_child:OK
> #213/50  sockmap_listen/sockmap IPv6 TCP test_syn_recv_insert_delete:OK
> #213/51  sockmap_listen/sockmap IPv6 TCP test_race_insert_listen:OK
> #213/52  sockmap_listen/sockmap IPv6 TCP test_clone_after_delete:OK
> #213/53  sockmap_listen/sockmap IPv6 TCP test_accept_after_delete:OK
> #213/54  sockmap_listen/sockmap IPv6 TCP test_accept_before_delete:OK
> #213/55  sockmap_listen/sockmap IPv6 UDP test_insert_invalid:OK
> #213/56  sockmap_listen/sockmap IPv6 UDP test_insert_opened:OK
> #213/57  sockmap_listen/sockmap IPv6 UDP test_insert:OK
> #213/58  sockmap_listen/sockmap IPv6 UDP test_delete_after_insert:OK
> #213/59  sockmap_listen/sockmap IPv6 UDP test_delete_after_close:OK
> #213/60  sockmap_listen/sockmap IPv6 UDP test_lookup_after_insert:OK
> #213/61  sockmap_listen/sockmap IPv6 UDP test_lookup_after_delete:OK
> #213/62  sockmap_listen/sockmap IPv6 UDP test_lookup_32_bit_value:OK
> #213/63  sockmap_listen/sockmap IPv6 UDP test_update_existing:OK
> #213/64  sockmap_listen/sockmap IPv6 test_skb_redir_to_connected:OK
> #213/65  sockmap_listen/sockmap IPv6 test_skb_redir_to_listening:OK
> #213/66  sockmap_listen/sockmap IPv6 test_skb_redir_partial:OK
> #213/67  sockmap_listen/sockmap IPv6 test_msg_redir_to_connected:OK
> #213/68  sockmap_listen/sockmap IPv6 test_msg_redir_to_listening:OK
> #213/69  sockmap_listen/sockmap IPv6 TCP test_reuseport_select_listening:OK
> #213/70  sockmap_listen/sockmap IPv6 TCP test_reuseport_select_connected:OK
> #213/71  sockmap_listen/sockmap IPv6 TCP test_reuseport_mixed_groups:OK
> #213/72  sockmap_listen/sockmap IPv6 UDP test_reuseport_select_listening:OK
> #213/73  sockmap_listen/sockmap IPv6 UDP test_reuseport_select_connected:OK
> #213/74  sockmap_listen/sockmap IPv6 UDP test_reuseport_mixed_groups:OK
> #213/75  sockmap_listen/sockmap IPv6 test_udp_redir:OK
> #213/76  sockmap_listen/sockmap IPv6 test_udp_unix_redir:OK
> #213/77  sockmap_listen/sockmap Unix test_unix_redir:OK
> #213/78  sockmap_listen/sockmap Unix test_unix_redir:OK
> #213/79  sockmap_listen/sockmap VSOCK test_vsock_redir:OK
> #213/80  sockmap_listen/sockhash IPv4 TCP test_insert_invalid:OK
> #213/81  sockmap_listen/sockhash IPv4 TCP test_insert_opened:OK
> #213/82  sockmap_listen/sockhash IPv4 TCP test_insert_bound:OK
> #213/83  sockmap_listen/sockhash IPv4 TCP test_insert:OK
> #213/84  sockmap_listen/sockhash IPv4 TCP test_delete_after_insert:OK
> #213/85  sockmap_listen/sockhash IPv4 TCP test_delete_after_close:OK
> #213/86  sockmap_listen/sockhash IPv4 TCP test_lookup_after_insert:OK
> #213/87  sockmap_listen/sockhash IPv4 TCP test_lookup_after_delete:OK
> #213/88  sockmap_listen/sockhash IPv4 TCP test_lookup_32_bit_value:OK
> #213/89  sockmap_listen/sockhash IPv4 TCP test_update_existing:OK
> #213/90  sockmap_listen/sockhash IPv4 TCP test_destroy_orphan_child:OK
> #213/91  sockmap_listen/sockhash IPv4 TCP test_syn_recv_insert_delete:OK
> #213/92  sockmap_listen/sockhash IPv4 TCP test_race_insert_listen:OK
> #213/93  sockmap_listen/sockhash IPv4 TCP test_clone_after_delete:OK
> #213/94  sockmap_listen/sockhash IPv4 TCP test_accept_after_delete:OK
> #213/95  sockmap_listen/sockhash IPv4 TCP test_accept_before_delete:OK
> #213/96  sockmap_listen/sockhash IPv4 UDP test_insert_invalid:OK
> #213/97  sockmap_listen/sockhash IPv4 UDP test_insert_opened:OK
> #213/98  sockmap_listen/sockhash IPv4 UDP test_insert:OK
> #213/99  sockmap_listen/sockhash IPv4 UDP test_delete_after_insert:OK
> #213/100 sockmap_listen/sockhash IPv4 UDP test_delete_after_close:OK
> #213/101 sockmap_listen/sockhash IPv4 UDP test_lookup_after_insert:OK
> #213/102 sockmap_listen/sockhash IPv4 UDP test_lookup_after_delete:OK
> #213/103 sockmap_listen/sockhash IPv4 UDP test_lookup_32_bit_value:OK
> #213/104 sockmap_listen/sockhash IPv4 UDP test_update_existing:OK
> #213/105 sockmap_listen/sockhash IPv4 test_skb_redir_to_connected:OK
> #213/106 sockmap_listen/sockhash IPv4 test_skb_redir_to_listening:OK
> #213/107 sockmap_listen/sockhash IPv4 test_skb_redir_partial:OK
> #213/108 sockmap_listen/sockhash IPv4 test_msg_redir_to_connected:OK
> #213/109 sockmap_listen/sockhash IPv4 test_msg_redir_to_listening:OK
> #213/110 sockmap_listen/sockhash IPv4 TCP test_reuseport_select_listening:OK
> #213/111 sockmap_listen/sockhash IPv4 TCP test_reuseport_select_connected:OK
> #213/112 sockmap_listen/sockhash IPv4 TCP test_reuseport_mixed_groups:OK
> #213/113 sockmap_listen/sockhash IPv4 UDP test_reuseport_select_listening:OK
> #213/114 sockmap_listen/sockhash IPv4 UDP test_reuseport_select_connected:OK
> #213/115 sockmap_listen/sockhash IPv4 UDP test_reuseport_mixed_groups:OK
> #213/116 sockmap_listen/sockhash IPv4 test_udp_redir:OK
> #213/117 sockmap_listen/sockhash IPv4 test_udp_unix_redir:OK
> #213/118 sockmap_listen/sockhash IPv6 TCP test_insert_invalid:OK
> #213/119 sockmap_listen/sockhash IPv6 TCP test_insert_opened:OK
> #213/120 sockmap_listen/sockhash IPv6 TCP test_insert_bound:OK
> #213/121 sockmap_listen/sockhash IPv6 TCP test_insert:OK
> #213/122 sockmap_listen/sockhash IPv6 TCP test_delete_after_insert:OK
> #213/123 sockmap_listen/sockhash IPv6 TCP test_delete_after_close:OK
> #213/124 sockmap_listen/sockhash IPv6 TCP test_lookup_after_insert:OK
> #213/125 sockmap_listen/sockhash IPv6 TCP test_lookup_after_delete:OK
> #213/126 sockmap_listen/sockhash IPv6 TCP test_lookup_32_bit_value:OK
> #213/127 sockmap_listen/sockhash IPv6 TCP test_update_existing:OK
> #213/128 sockmap_listen/sockhash IPv6 TCP test_destroy_orphan_child:OK
> #213/129 sockmap_listen/sockhash IPv6 TCP test_syn_recv_insert_delete:OK
> #213/130 sockmap_listen/sockhash IPv6 TCP test_race_insert_listen:OK
> #213/131 sockmap_listen/sockhash IPv6 TCP test_clone_after_delete:OK
> #213/132 sockmap_listen/sockhash IPv6 TCP test_accept_after_delete:OK
> #213/133 sockmap_listen/sockhash IPv6 TCP test_accept_before_delete:OK
> #213/134 sockmap_listen/sockhash IPv6 UDP test_insert_invalid:OK
> #213/135 sockmap_listen/sockhash IPv6 UDP test_insert_opened:OK
> #213/136 sockmap_listen/sockhash IPv6 UDP test_insert:OK
> #213/137 sockmap_listen/sockhash IPv6 UDP test_delete_after_insert:OK
> #213/138 sockmap_listen/sockhash IPv6 UDP test_delete_after_close:OK
> #213/139 sockmap_listen/sockhash IPv6 UDP test_lookup_after_insert:OK
> #213/140 sockmap_listen/sockhash IPv6 UDP test_lookup_after_delete:OK
> #213/141 sockmap_listen/sockhash IPv6 UDP test_lookup_32_bit_value:OK
> #213/142 sockmap_listen/sockhash IPv6 UDP test_update_existing:OK
> #213/143 sockmap_listen/sockhash IPv6 test_skb_redir_to_connected:OK
> #213/144 sockmap_listen/sockhash IPv6 test_skb_redir_to_listening:OK
> #213/145 sockmap_listen/sockhash IPv6 test_skb_redir_partial:OK
> #213/146 sockmap_listen/sockhash IPv6 test_msg_redir_to_connected:OK
> #213/147 sockmap_listen/sockhash IPv6 test_msg_redir_to_listening:OK
> #213/148 sockmap_listen/sockhash IPv6 TCP test_reuseport_select_listening:OK
> #213/149 sockmap_listen/sockhash IPv6 TCP test_reuseport_select_connected:OK
> #213/150 sockmap_listen/sockhash IPv6 TCP test_reuseport_mixed_groups:OK
> #213/151 sockmap_listen/sockhash IPv6 UDP test_reuseport_select_listening:OK
> #213/152 sockmap_listen/sockhash IPv6 UDP test_reuseport_select_connected:OK
> #213/153 sockmap_listen/sockhash IPv6 UDP test_reuseport_mixed_groups:OK
> #213/154 sockmap_listen/sockhash IPv6 test_udp_redir:OK
> #213/155 sockmap_listen/sockhash IPv6 test_udp_unix_redir:OK
> #213/156 sockmap_listen/sockhash Unix test_unix_redir:OK
> #213/157 sockmap_listen/sockhash Unix test_unix_redir:OK
> #213/158 sockmap_listen/sockhash VSOCK test_vsock_redir:OK
> #213     sockmap_listen:OK
> Summary: 4/193 PASSED, 0 SKIPPED, 0 FAILED
> bash-5.2#
> 

