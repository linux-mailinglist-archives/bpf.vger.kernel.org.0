Return-Path: <bpf+bounces-43712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5309B8E11
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C568D1F22E5A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434A158DD1;
	Fri,  1 Nov 2024 09:44:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76E1B95B;
	Fri,  1 Nov 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454261; cv=none; b=eVvDr0q7XH94FbDOTckLn5ULP+WHY0UjC9wDhcTTpXlh5+uYZJMWyjxEjx+rpHHGemfL1E9Ef8ILQ2+ZLp7sT31UtQCkU/kxseOKznyjO7pwsCN5U8r4A2DaH95bPCc6Mm4q68Q0qP9yqOTRPO3jfFeIUOgpshJKFIoEok8OV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454261; c=relaxed/simple;
	bh=mz1jbQWDiMreV0N0TkzSazP2OQeq7k1ZFkEAIdr5fhc=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K9BgRI9BOJg0j5ab8DNyC9UGBpLSri36BnLZOKFBSGXpUput0P80TZ2tbuE1fKLTovLtSIAf0ZiCG2irvwFsPo0QmBX7IGl0SEuHWHKY7xC+gMMqHKvKqpGvUT5ySAycw1qSyZR0ECQIz7MXjChCUMHa8D4taIYvQ+Ut2d/oeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xfwt24TDCz4f3jXp;
	Fri,  1 Nov 2024 17:43:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6614F1A0194;
	Fri,  1 Nov 2024 17:44:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCHMbPooiRn2jUdAg--.24730S2;
	Fri, 01 Nov 2024 17:44:11 +0800 (CST)
Subject: [RESEND] Re: [syzbot] [bpf?] WARNING: locking bug in trie_delete_elem
To: syzbot <syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>
References: <6723db4a.050a0220.35b515.0168.GAE@google.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e14d8882-4760-7c9c-0cfc-db04eda494ee@huaweicloud.com>
Date: Fri, 1 Nov 2024 17:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6723db4a.050a0220.35b515.0168.GAE@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCHMbPooiRn2jUdAg--.24730S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJFyfAry7ZFyrWr1xXw4xWFg_yoWDuFWfpr
	WYkrZrAr48ta48Za409w1UAayUZ3s0kay7J397Wr18uF129r17Jrn2yr1fXrZ8Cr92yF9x
	tFn8ZrZ5K3WkZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxU4NB_UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/1/2024 3:32 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1387c6f7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b506de56cbbb63148c33
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387655f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac5540580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
>
> =============================
> [ BUG: Invalid wait context ]
> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
> -----------------------------
> swapper/0/0 is trying to lock:
> ffff8880261e7a00 (&trie->lock){....}-{3:3}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

Sorry for the resend. The previous mail was rejected by the mail list
due to HTML content.

The warning is due to the lock for lpm_trie is a spinlock_t lock. It may
sleep under PREEMPT_RT kernel, but the bpf program has already taken a
raw_spinlock in queue_work() and the bpf program is also running inside
an interrupt handler, so lockdep warns about it. The lock should be
changed to raw_spinlock_t. Will fix it.

There have been multiple lpm trie related syzbot reports, includes:

(1) possible deadlock in get_page_from_freelist [1]
The deadlock is due to the locking of lock(&zone->lock) and
lock(&trie->lock). zone->lock comes from lpm_trie_node_alloc()

(2) possible deadlock in trie_delete_elem [2]
The deadlock is due to the recursive locking lock(&trie->lock). The
recursion comes from lpm_trie_node_alloc()

(3) possible deadlock in trie_update_elem [3]
(4) possible deadlock in stack_depot_save_flags [4]
(5) possible deadlock in get_partial_node [5]
(6) possible deadlock in deactivate_slab[6]
(7) possible deadlock in __put_partials [7]
(8) possible deadlock in debug_check_no_obj_freed [8]
issue (3)-(8) are similar with the first issue.

[1] https://syzkaller.appspot.com/bug?extid=a7f061d2d16154538c58
[2] https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
[3] https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf
[4] https://syzkaller.appspot.com/bug?extid=c065d8dfbb5ad8cbdceb
[5] https://syzkaller.appspot.com/bug?extid=9045c0a3d5a7f1b119f7
[6] https://syzkaller.appspot.com/bug?extid=a4acbb99845d381e5e2f
[7] https://syzkaller.appspot.com/bug?extid=5a878c984150fad34185
[8] https://syzkaller.appspot.com/bug?extid=b12149f7ab5a8751740f

Using the bpf memory allocator for the allocation of both new node and
intermediate node will fix these reports. However, I was hesitant about
supporting the recursive lock prevention on the same CPU for lpm trie.
About fix months ago, Siddharth posted a patch set [9] to support the
recursive lock prevention for queue/stack map, so maybe I could continue
the work and also add the support for lpm trie in the same patch set.

[9]
https://lore.kernel.org/bpf/20240514124052.1240266-2-sidchintamaneni@gmail.com/
> other info that might help us debug this:
> context-{3:3}
> 5 locks held by swapper/0/0:
>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3}, at: vp_vring_interrupt drivers/virtio/virtio_pci_common.c:80 [inline]
>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3}, at: vp_interrupt+0x142/0x200 drivers/virtio/virtio_pci_common.c:113
>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3}, at: stats_request+0x6f/0x230 drivers/virtio/virtio_balloon.c:438
>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __queue_work+0x199/0xf50 kernel/workqueue.c:2259
>  #3: ffff8880b863dd18 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x759/0xf50
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run1+0x1d6/0x520 kernel/trace/bpf_trace.c:2380
> stack backtrace:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>  trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
>  bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
>  trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue.h:59
>  __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
>  queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
>  queue_work include/linux/workqueue.h:662 [inline]
>  stats_request+0x1a3/0x230 drivers/virtio/virtio_balloon.c:441
>  vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
>  vp_vring_interrupt drivers/virtio/virtio_pci_common.c:82 [inline]
>  vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:113
>  __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
>  handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq arch/x86/kernel/irq.c:247 [inline]
>  call_irq_handler arch/x86/kernel/irq.c:259 [inline]
>  __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
>  common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
>  </IRQ>
>  <TASK>
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
> RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5201
> Code: c9 50 e8 29 05 0c 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 0f 1f 44 00 00 4c 89 f7 e8 a0 45 69 0a e8 4b 9e 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
> RSP: 0018:ffffffff8e607ae8 EFLAGS: 00000282
> RAX: 467bb178e56b5700 RBX: ffffffff8e6945c0 RCX: ffffffff9a3d4903
> RDX: dffffc0000000000 RSI: ffffffff8c0ad3a0 RDI: ffffffff8c604dc0
> RBP: ffffffff8e607b30 R08: ffffffff901d03b7 R09: 1ffffffff203a076
> R10: dffffc0000000000 R11: fffffbfff203a077 R12: 1ffff110170c7e74
> R13: dffffc0000000000 R14: ffff8880b863e580 R15: ffff8880b863f3a0
>  context_switch kernel/sched/core.c:5330 [inline]
>  __schedule+0x1857/0x4c30 kernel/sched/core.c:6707
>  schedule_idle+0x56/0x90 kernel/sched/core.c:6825
>  do_idle+0x567/0x5c0 kernel/sched/idle.c:353
>  cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:423
>  rest_init+0x2dc/0x300 init/main.c:747
>  start_kernel+0x47f/0x500 init/main.c:1102
>  x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
>  x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
>  common_startup_64+0x13e/0x147
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	c9                   	leave
>    1:	50                   	push   %rax
>    2:	e8 29 05 0c 00       	call   0xc0530
>    7:	48 83 c4 08          	add    $0x8,%rsp
>    b:	4c 89 f7             	mov    %r14,%rdi
>    e:	e8 4d 39 00 00       	call   0x3960
>   13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   18:	4c 89 f7             	mov    %r14,%rdi
>   1b:	e8 a0 45 69 0a       	call   0xa6945c0
>   20:	e8 4b 9e 38 00       	call   0x389e70
>   25:	fb                   	sti
>   26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
> * 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
>   31:	48 89 f8             	mov    %rdi,%rax
>   34:	48 c1 e8 03          	shr    $0x3,%rax
>   38:	49                   	rex.WB
>   39:	be 00 00 00 00       	mov    $0x0,%esi
>   3e:	00 fc                	add    %bh,%ah
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
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> .


