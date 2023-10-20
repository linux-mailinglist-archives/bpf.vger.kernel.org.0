Return-Path: <bpf+bounces-12814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28AF7D0E62
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CFDB21436
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64018E1E;
	Fri, 20 Oct 2023 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5F18E03
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 11:28:54 +0000 (UTC)
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4241A8
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 04:28:51 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6ce29652abaso875402a34.3
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 04:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697801330; x=1698406130;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKmQsTiSHDiANfS/WlRW00VQzH4fK7YNw/iaQWI2jPo=;
        b=phkjTGOiex/lqKmnBQ4urhYuY5N/edHbI/cuWF/f3Yju5WI+SuuC3cWWm7NY/VEspI
         C/eFPerGrC43ZzlQu327QUjS3a5Fdn3aTZ6bWxN0t6VpMOJO83un4vjMb8ubRYjOiNuk
         QmhiB70XQk15yB0qtor/dq8PhSacddwx3N2TUO11hcuAoW6P1nn70Edqi/B9Gyb6HR9q
         DFW5lfuUp+1Fi06GPUMduR+VxtBYcntBNJUld1/xgpiwLYjoqE3oryj+5SM52xhtsWrM
         yglsa+pWlnkDJSfJ7luesXTyJdEQ95jPKOcFicz55AjD9khvT04NlGYyUR/6TFdD53z1
         vxPg==
X-Gm-Message-State: AOJu0YwKRJktl1cdMqJDcYOs8bueUzMu62YznkhKNc2I0qPgUpnmuopp
	ReRKGat/QJgAOVcIR0NOadJT0OZsI5c3cDll3jyqWEjfAMs1BTiehA==
X-Google-Smtp-Source: AGHT+IEuN+FfSvMxNgSEVBehxXRj2dAACRCToBJi7M0aYSJQCwYoMLLCNX3Orng1AlCj+JSipWUS8fo8d5X3uJdSMZaNznzl8NAo
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:7f86:0:b0:6bf:192d:31dc with SMTP id
 t6-20020a9d7f86000000b006bf192d31dcmr417772otp.2.1697801330538; Fri, 20 Oct
 2023 04:28:50 -0700 (PDT)
Date: Fri, 20 Oct 2023 04:28:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034c0520608242de6@google.com>
Subject: [syzbot] [kernel?] possible deadlock in __schedule (2)
From: syzbot <syzbot+39a85bc0224f82336405@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06dc10eae55b Merge tag 'fbdev-for-6.6-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13200f55680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d236817624b4822c
dashboard link: https://syzkaller.appspot.com/bug?extid=39a85bc0224f82336405
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-06dc10ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/84fbcc80ef2d/vmlinux-06dc10ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a061d48adac0/Image-06dc10ea.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39a85bc0224f82336405@syzkaller.appspotmail.com

EEVDF scheduling fail, picking leftmost
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc6-syzkaller-00039-g06dc10eae55b #0 Not tainted
------------------------------------------------------
syz-executor.1/3112 is trying to acquire lock:
ffff8000865271b8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x18/0x80 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1681 [inline]
ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x268/0x2ae4 kernel/sched/core.c:6612

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x6c kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2c/0x44 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
       rq_lock kernel/sched/sched.h:1681 [inline]
       task_fork_fair+0x70/0x13c kernel/sched/fair.c:12416
       sched_cgroup_fork+0x35c/0x520 kernel/sched/core.c:4816
       copy_process+0x2fb0/0x5520 kernel/fork.c:2609
       kernel_clone+0x140/0x7e8 kernel/fork.c:2909
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2987
       rest_init+0x2c/0x210 init/main.c:691
       arch_post_acpi_subsys_init+0x0/0x8 init/main.c:823
       start_kernel+0x328/0x3a0 init/main.c:1068
       __primary_switched+0xb8/0xc0 arch/arm64/kernel/head.S:523

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x58/0x80 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xac/0x1924 kernel/sched/core.c:4230
       wake_up_process+0x18/0x24 kernel/sched/core.c:4478
       __up.isra.0+0x124/0x18c kernel/locking/semaphore.c:278
       up+0x94/0xd4 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:346 [inline]
       __console_unlock kernel/printk/printk.c:2718 [inline]
       console_unlock+0x1b8/0x1d8 kernel/printk/printk.c:3037
       fb_flashcursor drivers/video/fbdev/core/fbcon.c:382 [inline]
       fb_flashcursor+0x220/0x340 drivers/video/fbdev/core/fbcon.c:348
       process_one_work+0x670/0x143c kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x5a8/0xfb0 kernel/workqueue.c:2784
       kthread+0x27c/0x300 kernel/kthread.c:388
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2cac/0x6b70 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x480/0x7c8 kernel/locking/lockdep.c:5718
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x58/0x80 kernel/locking/spinlock.c:162
       down_trylock+0x18/0x80 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x38/0xd8 kernel/printk/printk.c:329
       console_trylock kernel/printk/printk.c:2671 [inline]
       console_trylock_spinning kernel/printk/printk.c:1927 [inline]
       vprintk_emit+0x334/0x4e4 kernel/printk/printk.c:2306
       vprintk_default+0x38/0x44 kernel/printk/printk.c:2322
       vprintk+0x17c/0x1bc kernel/printk/printk_safe.c:45
       _printk+0xa8/0xe0 kernel/printk/printk.c:2332
       pick_eevdf kernel/sched/fair.c:976 [inline]
       pick_next_entity kernel/sched/fair.c:5278 [inline]
       pick_next_task_fair+0x1a4/0xd3c kernel/sched/fair.c:8222
       __pick_next_task kernel/sched/core.c:6004 [inline]
       pick_next_task kernel/sched/core.c:6514 [inline]
       __schedule+0x3b8/0x2ae4 kernel/sched/core.c:6659
       preempt_schedule_common kernel/sched/core.c:6864 [inline]
       preempt_schedule+0xf4/0x254 kernel/sched/core.c:6888
       __mutex_lock_common kernel/locking/mutex.c:613 [inline]
       __mutex_lock+0x2b0/0x840 kernel/locking/mutex.c:747
       mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:799
       xt_find_table_lock+0x68/0x418 net/netfilter/x_tables.c:1242
       get_entries net/ipv6/netfilter/ip6_tables.c:1035 [inline]
       do_ip6t_get_ctl+0x340/0x980 net/ipv6/netfilter/ip6_tables.c:1669
       nf_getsockopt+0x78/0xec net/netfilter/nf_sockopt.c:116
       ipv6_getsockopt+0x210/0x34c net/ipv6/ipv6_sockglue.c:1500
       tcp_getsockopt+0x7c/0x248 net/ipv4/tcp.c:4278
       sock_common_getsockopt+0x70/0xc8 net/core/sock.c:3672
       __sys_getsockopt+0x190/0x478 net/socket.c:2371
       __do_sys_getsockopt net/socket.c:2386 [inline]
       __se_sys_getsockopt net/socket.c:2383 [inline]
       __arm64_sys_getsockopt+0xa4/0x100 net/socket.c:2383
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
       el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

2 locks held by syz-executor.1/3112:
 #0: ffff000013bfcd88 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x68/0x418 net/netfilter/x_tables.c:1242
 #1: ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
 #1: ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
 #1: ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1681 [inline]
 #1: ffff00006a8dd758 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x268/0x2ae4 kernel/sched/core.c:6612

stack backtrace:
CPU: 0 PID: 3112 Comm: syz-executor.1 Not tainted 6.6.0-rc6-syzkaller-00039-g06dc10eae55b #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x9c/0x11c arch/arm64/kernel/stacktrace.c:233
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x74/0xd4 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x420/0x6f8 kernel/locking/lockdep.c:2060
 check_noncircular+0x2dc/0x364 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2cac/0x6b70 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x480/0x7c8 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x58/0x80 kernel/locking/spinlock.c:162
 down_trylock+0x18/0x80 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x38/0xd8 kernel/printk/printk.c:329
 console_trylock kernel/printk/printk.c:2671 [inline]
 console_trylock_spinning kernel/printk/printk.c:1927 [inline]
 vprintk_emit+0x334/0x4e4 kernel/printk/printk.c:2306
 vprintk_default+0x38/0x44 kernel/printk/printk.c:2322
 vprintk+0x17c/0x1bc kernel/printk/printk_safe.c:45
 _printk+0xa8/0xe0 kernel/printk/printk.c:2332
 pick_eevdf kernel/sched/fair.c:976 [inline]
 pick_next_entity kernel/sched/fair.c:5278 [inline]
 pick_next_task_fair+0x1a4/0xd3c kernel/sched/fair.c:8222
 __pick_next_task kernel/sched/core.c:6004 [inline]
 pick_next_task kernel/sched/core.c:6514 [inline]
 __schedule+0x3b8/0x2ae4 kernel/sched/core.c:6659
 preempt_schedule_common kernel/sched/core.c:6864 [inline]
 preempt_schedule+0xf4/0x254 kernel/sched/core.c:6888
 __mutex_lock_common kernel/locking/mutex.c:613 [inline]
 __mutex_lock+0x2b0/0x840 kernel/locking/mutex.c:747
 mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:799
 xt_find_table_lock+0x68/0x418 net/netfilter/x_tables.c:1242
 get_entries net/ipv6/netfilter/ip6_tables.c:1035 [inline]
 do_ip6t_get_ctl+0x340/0x980 net/ipv6/netfilter/ip6_tables.c:1669
 nf_getsockopt+0x78/0xec net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x210/0x34c net/ipv6/ipv6_sockglue.c:1500
 tcp_getsockopt+0x7c/0x248 net/ipv4/tcp.c:4278
 sock_common_getsockopt+0x70/0xc8 net/core/sock.c:3672
 __sys_getsockopt+0x190/0x478 net/socket.c:2371
 __do_sys_getsockopt net/socket.c:2386 [inline]
 __se_sys_getsockopt net/socket.c:2383 [inline]
 __arm64_sys_getsockopt+0xa4/0x100 net/socket.c:2383
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

