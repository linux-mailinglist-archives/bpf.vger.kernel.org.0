Return-Path: <bpf+bounces-313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CFD6FE70C
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 00:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DBB1C20E33
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E61E510;
	Wed, 10 May 2023 22:11:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53F1E50C
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 22:11:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7A9009
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:11:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33117143894so53008695ab.3
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683756650; x=1686348650;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mkr2bOPc9nVI1WAeOY6kJv8RHdnlSYhXsBD5uOHimu0=;
        b=dZCn9nHY5KejTx7NpkaZIkE1SxABm8TKmUrlTBMcbXoiZJ9LTw6Xr+TRBhwkaMwGTk
         3w5jMYqo4M1sq+cRCKbgJg5Ej/4/I+xVthFW59Zdj7TEBa1lg68ek7FjMVyJq/BJBYqK
         Mml3z6cLjjiTVemsNxpS7OApZk8LoN5+Tk+BknBsVIjEHJKbhJcClY4npmybrmJ9vuxC
         B6WSN819Wc4fTGpKy3oFC+pudZhCjC7VpcS2Ei+gMm/I/uEAKTYrssephzQ375ammdsu
         NkAcChhKWyYsTkTHUqUlP1nTgOvcyM7TMeOhEd2/lm5+rnykrStiQzXHDvgh/gzuAGTK
         Yh1Q==
X-Gm-Message-State: AC+VfDzLbNqf0TcwOGybosMDSvkpS6DIl3vUeGEdO70SMiXBRObNgOtj
	+mNkyx3DFFBW4/gycFWGgOTP5Bmdbq9emfHjQgznWry73lgzwu0=
X-Google-Smtp-Source: ACHHUZ4D6SjM0BH7i5jx39mJwAh6Xyy3oug6udn/rZYrVX5IuNCD8V6amvZNJORWGpe3CJCQ9dMaLpQycKyJ6tTyB6LB4HwWurBx
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d4ce:0:b0:335:de72:23d7 with SMTP id
 o14-20020a92d4ce000000b00335de7223d7mr1040978ilm.3.1683756649842; Wed, 10 May
 2023 15:10:49 -0700 (PDT)
Date: Wed, 10 May 2023 15:10:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000008ddb05fb5e2576@google.com>
Subject: [syzbot] [kernel?] possible deadlock in __mod_timer (2)
From: syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    1dc3731daf1f Merge tag 'for-6.4-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153dd834280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=fe0c72f0ccbb93786380
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1dc3731d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ac41c523f85/vmlinux-1dc3731d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40b82936b92f/bzImage-1dc3731d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc1-syzkaller-00011-g1dc3731daf1f #0 Not tainted
------------------------------------------------------
kworker/u16:0/11 is trying to acquire lock:
ffff88807ffdaba0 (&pgdat->kswapd_wait){....}-{2:2}, at: __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137

but task is already holding lock:
ffff88802c7296d8 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x69c/0xe80 kernel/time/timer.c:1112

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
       __mod_timer+0x3f9/0xe80 kernel/time/timer.c:1080
       add_timer+0x62/0x90 kernel/time/timer.c:1244
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1685
       queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
       psi_task_change+0x1bf/0x300 kernel/sched/psi.c:920
       psi_enqueue kernel/sched/stats.h:139 [inline]
       enqueue_task kernel/sched/core.c:2078 [inline]
       activate_task kernel/sched/core.c:2112 [inline]
       wake_up_new_task+0xc13/0x1000 kernel/sched/core.c:4833
       kernel_clone+0x219/0x890 kernel/fork.c:2949
       user_mode_thread+0xb1/0xf0 kernel/fork.c:2996
       rest_init+0x27/0x2b0 init/main.c:700
       arch_call_rest_init+0x13/0x30 init/main.c:834
       start_kernel+0x3b6/0x490 init/main.c:1088
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb3/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0xf4/0xfb

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x34/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x74/0x4f0 kernel/sched/fair.c:12095
       sched_cgroup_fork+0x3d1/0x540 kernel/sched/core.c:4777
       copy_process+0x4b8a/0x7600 kernel/fork.c:2618
       kernel_clone+0xeb/0x890 kernel/fork.c:2918
       user_mode_thread+0xb1/0xf0 kernel/fork.c:2996
       rest_init+0x27/0x2b0 init/main.c:700
       arch_call_rest_init+0x13/0x30 init/main.c:834
       start_kernel+0x3b6/0x490 init/main.c:1088
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb3/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0xf4/0xfb

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       try_to_wake_up+0xab/0x1c40 kernel/sched/core.c:4191
       autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:419
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
       wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
       rmqueue mm/page_alloc.c:3057 [inline]
       get_page_from_freelist+0x6c5/0x2c00 mm/page_alloc.c:3499
       __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
       __folio_alloc+0x16/0x40 mm/page_alloc.c:4800
       vma_alloc_folio+0x155/0x890 mm/mempolicy.c:2240
       wp_page_copy mm/memory.c:3070 [inline]
       do_wp_page+0x173d/0x33c0 mm/memory.c:3432
       handle_pte_fault mm/memory.c:4964 [inline]
       __handle_mm_fault+0x1635/0x41c0 mm/memory.c:5089
       handle_mm_fault+0x2af/0x9f0 mm/memory.c:5243
       do_user_addr_fault+0x2ca/0x1210 arch/x86/mm/fault.c:1349
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&pgdat->kswapd_wait){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
       lock_acquire kernel/locking/lockdep.c:5691 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
       wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
       wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4028
       __alloc_pages_slowpath.constprop.0+0x1724/0x2170 mm/page_alloc.c:4296
       __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4781
       alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
       alloc_slab_page mm/slub.c:1851 [inline]
       allocate_slab+0x25f/0x390 mm/slub.c:1998
       new_slab mm/slub.c:2051 [inline]
       ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
       __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
       __slab_alloc_node mm/slub.c:3344 [inline]
       slab_alloc_node mm/slub.c:3441 [inline]
       slab_alloc mm/slub.c:3459 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
       kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3475
       kmem_cache_zalloc include/linux/slab.h:670 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       debug_objects_fill_pool lib/debugobjects.c:597 [inline]
       debug_object_activate+0xfd/0x400 lib/debugobjects.c:693
       debug_timer_activate kernel/time/timer.c:782 [inline]
       __mod_timer+0x80d/0xe80 kernel/time/timer.c:1119
       add_timer+0x62/0x90 kernel/time/timer.c:1244
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1685
       queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
       process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
       worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &pgdat->kswapd_wait --> &rq->__lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&rq->__lock);
                               lock(&base->lock);
  lock(&pgdat->kswapd_wait);

 *** DEADLOCK ***

3 locks held by kworker/u16:0/11:
 #0: ffff8880444ff138 ((wq_completion)bat_events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880444ff138 ((wq_completion)bat_events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880444ff138 ((wq_completion)bat_events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff8880444ff138 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff8880444ff138 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff8880444ff138 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc900003d7db0 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffff88802c7296d8 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x69c/0xe80 kernel/time/timer.c:1112

stack backtrace:
CPU: 1 PID: 11 Comm: kworker/u16:0 Not tainted 6.4.0-rc1-syzkaller-00011-g1dc3731daf1f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
 wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
 wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4028
 __alloc_pages_slowpath.constprop.0+0x1724/0x2170 mm/page_alloc.c:4296
 __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4781
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3475
 kmem_cache_zalloc include/linux/slab.h:670 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:168
 debug_objects_fill_pool lib/debugobjects.c:597 [inline]
 debug_object_activate+0xfd/0x400 lib/debugobjects.c:693
 debug_timer_activate kernel/time/timer.c:782 [inline]
 __mod_timer+0x80d/0xe80 kernel/time/timer.c:1119
 add_timer+0x62/0x90 kernel/time/timer.c:1244
 __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1685
 queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

