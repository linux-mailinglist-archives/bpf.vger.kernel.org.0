Return-Path: <bpf+bounces-34746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922369307F2
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 00:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6431B224AD
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561FF15B107;
	Sat, 13 Jul 2024 22:54:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB7176AAB
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911266; cv=none; b=tsCV3wEUy/5IdRrWIJhv5NqnnlW2VtmiamNV3nrg0NiuBniKU6QAROD8XQiE7Mm8nUbf0Wvi7t8vlm9omfiK3QXm4+yY9q1t64dpZUKrJQv0hs18Ctr3t8RM2JXMePMS6h9FAQfYISHVlj1k7xlQ769BYllEDEET8JPRQy35NwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911266; c=relaxed/simple;
	bh=BzUfjN29KRXwjYjajd8UoSeOxmvo1MVsOxftSxGhVrI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uvdrc65LxMO2gqXcgeRUIQn8BFYTwLWTqMw7gcgSicChNJIlKMyQq2HU2Gq5vSNVU5gOIm6nkPCPc0XWAHkBxDlBaT01l9G3Pbjp5xcpSbnwogGCL2u0RDlLqG7gHcnCqECTjMTlR164Q31SjK3CcSw5dENH+RhrgNuRuCjRLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8048edd8993so327903439f.0
        for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 15:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720911263; x=1721516063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XguMzQQuZOL2+qopmj/CNe/qw/ctDqCt8JeyLm6oRU=;
        b=SN5ExmX6HhjNYQAUG3MaKLbqmn94oo7NPwlVGcGq18ACu13mkurOD/rQgxEnZ77UTa
         m+QVqfLpdAr0ktTFzirWgPxT/yrObfma57spb4C9wWGvkvyW9K/COE3d6sAomxdIyzHV
         3D38DQWZEjfC15TlRwRFrH1poUf5YDZ0vClOqGl1cnKPSWX9HoFTXBwLT0tbua+KDucv
         fIOLWmikilrq52ZCk2I65LTXbYHNUPxUyN5btk4TxOQ1Tu2WmQ5FDbAvsi8l4c1XGLlJ
         BbENOAbpcicXlZtc1r4fqvtRtSreOfhJpKvH9Ys/KyBToSwCOow/bMoXzH3Tdt7j5heT
         LSzg==
X-Forwarded-Encrypted: i=1; AJvYcCV9+WJbXvDufMd1LfJbC5gffWXHZTfwo+Wqzq6p7iyFil8pUe+8+Ml5DkdnMsT0Zmkh+vSMDrMkOBrvGbnBh4YKCUqq
X-Gm-Message-State: AOJu0YzngXlCbPONNe/ALmb9U/wOAwglrvvMGaWGoLl6iLyLSlhjrt0v
	x7PcL+MDu7rjxqeEo0ZjNwu+BCE9u1pzp9wk8aKdrczpSJImOfEzyu6Y0EMkaZiKLt0CdOqfjmS
	CjBsndWDcs0MdqeEILWDi1y7cn6IxFG/djAEP7tMgdElqNbZc5My+t78=
X-Google-Smtp-Source: AGHT+IEVJqCY+g6yuYZF4J2IvmeENBZJzH0KUKGofR0vhfiXSrVCcThkRh36OBkfoGZR2NxA6qWtupFjj5gDq4H3jTCxfD5EMfrr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3793:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4c0b2b448b4mr1386726173.4.1720911263198; Sat, 13 Jul 2024
 15:54:23 -0700 (PDT)
Date: Sat, 13 Jul 2024 15:54:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008881c5061d28e041@google.com>
Subject: [syzbot] [bpf?] [trace?] possible deadlock in console_flush_all (3)
From: syzbot <syzbot+18cfb7f63482af8641df@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40ab9e0dc865 netxen_nic: Use {low,upp}er_32_bits() helpers
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a186a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bf8535980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1412869e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82323446a05a/disk-40ab9e0d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ef73ffa3427/vmlinux-40ab9e0d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38572b425814/bzImage-40ab9e0d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18cfb7f63482af8641df@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 1
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-01403-g40ab9e0dc865 #0 Not tainted
------------------------------------------------------
syz-executor394/5097 is trying to acquire lock:
ffffffff8e328140 (console_owner){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:334 [inline]
ffffffff8e328140 (console_owner){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
ffffffff8e328140 (console_owner){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
ffffffff8e328140 (console_owner){....}-{0:0}, at: console_flush_all+0x152/0xfd0 kernel/printk/printk.c:2971

but task is already holding lock:
ffff8880b943e858 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
       rq_lock kernel/sched/sched.h:1702 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4844
       copy_process+0x2217/0x3dc0 kernel/fork.c:2499
       kernel_clone+0x226/0x8f0 kernel/fork.c:2797
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2875
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
       __wake_up_common kernel/sched/wait.c:89 [inline]
       __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
       tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x6e2/0x930 drivers/tty/serial/8250/8250_port.c:1821
       serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1929
       serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:247 [inline]
       call_irq_handler arch/x86/kernel/irq.c:259 [inline]
       __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
       common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:278
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       rcu_read_unlock include/linux/rcupdate.h:810 [inline]
       count_memcg_event_mm+0x334/0x420 include/linux/memcontrol.h:1078
       mm_account_fault mm/memory.c:5558 [inline]
       handle_mm_fault+0x16c4/0x1ba0 mm/memory.c:5705
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #2 (&tty->write_wait){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
       tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x6e2/0x930 drivers/tty/serial/8250/8250_port.c:1821
       serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1929
       serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:247 [inline]
       call_irq_handler arch/x86/kernel/irq.c:259 [inline]
       __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
       common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:278
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
       uart_write+0x15d/0x380 drivers/tty/serial/serial_core.c:634
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xd6a/0x1230 drivers/tty/n_tty.c:2389
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x54f/0x9b0 drivers/tty/tty_io.c:1096
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       serial8250_console_write+0x1a8/0x1770 drivers/tty/serial/8250/8250_port.c:3352
       console_emit_next_record kernel/printk/printk.c:2913 [inline]
       console_flush_all+0x867/0xfd0 kernel/printk/printk.c:2979
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3048
       vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2348
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       register_console+0x727/0xcf0 kernel/printk/printk.c:3581
       univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:714
       console_init+0x1b8/0x6f0 kernel/printk/printk.c:3727
       start_kernel+0x2d3/0x500 init/main.c:1038
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
       console_emit_next_record kernel/printk/printk.c:2907 [inline]
       console_flush_all+0x810/0xfd0 kernel/printk/printk.c:2979
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3048
       vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2348
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       fail_dump lib/fault-inject.c:45 [inline]
       should_fail_ex+0x391/0x4e0 lib/fault-inject.c:153
       strncpy_from_user+0x36/0x2f0 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
       ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
       bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
       bpf_prog_f2ce78ec2d45df6f+0x3d/0x3f
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2587/0x4a20 kernel/sched/core.c:6742
       __schedule_loop kernel/sched/core.c:6822 [inline]
       schedule+0x14b/0x320 kernel/sched/core.c:6837
       synchronize_rcu_expedited+0x684/0x830 kernel/rcu/tree_exp.h:954
       synchronize_rcu+0x11b/0x360 kernel/rcu/tree.c:3986
       __nf_tables_abort net/netfilter/nf_tables_api.c:10786 [inline]
       nf_tables_abort+0x6569/0x7a10 net/netfilter/nf_tables_api.c:10805
       nfnetlink_rcv_batch net/netfilter/nfnetlink.c:590 [inline]
       nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:644 [inline]
       nfnetlink_rcv+0x20cf/0x2a90 net/netfilter/nfnetlink.c:662
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
       ___sys_sendmsg net/socket.c:2639 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(console_owner);

 *** DEADLOCK ***

6 locks held by syz-executor394/5097:
 #0: ffff888029a9bcb8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid+0x32/0x100 net/netfilter/nf_tables_api.c:10828
 #1: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #1: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
 #2: ffff8880b943e858 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #3: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2405 [inline]
 #3: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x244/0x590 kernel/trace/bpf_trace.c:2449
 #4: ffffffff8e20fa60 (console_lock){+.+.}-{0:0}, at: _printk+0xd5/0x120 kernel/printk/printk.c:2373
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:334 [inline]
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: console_flush_all+0x152/0xfd0 kernel/printk/printk.c:2971

stack backtrace:
CPU: 0 PID: 5097 Comm: syz-executor394 Not tainted 6.10.0-rc6-syzkaller-01403-g40ab9e0dc865 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
 console_emit_next_record kernel/printk/printk.c:2907 [inline]
 console_flush_all+0x810/0xfd0 kernel/printk/printk.c:2979
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3048
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2348
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail_ex+0x391/0x4e0 lib/fault-inject.c:153
 strncpy_from_user+0x36/0x2f0 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
 bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
 bpf_prog_f2ce78ec2d45df6f+0x3d/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2587/0x4a20 kernel/sched/core.c:6742
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 synchronize_rcu_expedited+0x684/0x830 kernel/rcu/tree_exp.h:954
 synchronize_rcu+0x11b/0x360 kernel/rcu/tree.c:3986
 __nf_tables_abort net/netfilter/nf_tables_api.c:10786 [inline]
 nf_tables_abort+0x6569/0x7a10 net/netfilter/nf_tables_api.c:10805
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:590 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:644 [inline]
 nfnetlink_rcv+0x20cf/0x2a90 net/netfilter/nfnetlink.c:662
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3b968c9e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3e026948 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffd3e026960 RCX: 00007fa3b968c9e9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 0000000000000002 R08: 00007ffd3e0266e6 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
CPU: 0 PID: 5097 Comm: syz-executor394 Not tainted 6.10.0-rc6-syzkaller-01403-g40ab9e0dc865 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:153
 strncpy_from_user+0x36/0x2f0 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
 bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
 bpf_prog_f2ce78ec2d45df6f+0x3d/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2587/0x4a20 kernel/sched/core.c:6742
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 synchronize_rcu_expedited+0x684/0x830 kernel/rcu/tree_exp.h:954
 synchronize_rcu+0x11b/0x360 kernel/rcu/tree.c:3986
 __nf_tables_abort net/netfilter/nf_tables_api.c:10786 [inline]
 nf_tables_abort+0x6569/0x7a10 net/netfilter/nf_tables_api.c:10805
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:590 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:644 [inline]
 nfnetlink_rcv+0x20cf/0x2a90 net/netfilter/nfnetlink.c:662
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3b968c9e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3e026948 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffd3e026960 RCX: 00007fa3b968c9e9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 0000000000000002 R08: 00007ffd3e0266e6 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

