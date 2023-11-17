Return-Path: <bpf+bounces-15234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2067EF42F
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 15:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C92228138F
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8B358AE;
	Fri, 17 Nov 2023 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDBC5
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 06:12:30 -0800 (PST)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-282d66095a4so2619541a91.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 06:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230350; x=1700835150;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//Yy3/bjAbGpFpJhy22Xq+eGwzAPjK10QjdSK/FY2As=;
        b=fV0hNpjxdncnJbU+B0o11u2w3WPpauRLhp0wkxqMxTtOKvBmNa8bmAbcTDavkPYwvA
         AsGFHZNrPiCZSCsWh0qpjQL9uHlgECUJNZWA8Z4i5YZnkqg4ycr0Bh0jW5cEddGohcoh
         QLODtqHxne6wlRUUiPnsVRoixwGVsQxXY0eTonmHEqaNARRr+OVeOwvXMC/XK5lUpbUU
         KS2SeNvoieHxFIiRHepDt3bijH9AQqgGsAtKv+EgB7ZlrPcDAWvePgxCHCrr0iW10L0L
         XAolYjS9OtqlX8p7RWg8rNHt7fy+PMomXMw8Z/f64qX5TZzZ/XoX6wdMXYm5f1lBW154
         pMQg==
X-Gm-Message-State: AOJu0YxdzGlD6M3wPAxjwIwOQE4BlTtuTPRyesBUAtviUG7etMAB1/yE
	qVP4PsbR773KqQkC/OSWQesmiQGI+kqKANGfTNPpuQY6ROl3
X-Google-Smtp-Source: AGHT+IGNlgbY8W5XfBZASh7uY6QzdnqkDvARGyUCMnfXh/HVQQ+cWadf1l/1eVpEAP129eqqUuN7yTmY0VecaTTazxLdyHHlUJRS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:515:b0:27d:15e2:b248 with SMTP id
 r21-20020a17090b051500b0027d15e2b248mr4506920pjz.8.1700230349947; Fri, 17 Nov
 2023 06:12:29 -0800 (PST)
Date: Fri, 17 Nov 2023 06:12:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b8884060a59ba9b@google.com>
Subject: [syzbot] [bpf?] [trace?] possible deadlock in dev_watchdog
From: syzbot <syzbot+db9ad150a8969744d703@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, mhiramat@kernel.org, 
	rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eff99d8edbed Add linux-next specific files for 20231117
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1155289f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61991b2630c19677
dashboard link: https://syzkaller.appspot.com/bug?extid=db9ad150a8969744d703
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/727bd99b8512/disk-eff99d8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a535e264e50/vmlinux-eff99d8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23c31e53f4d8/bzImage-eff99d8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db9ad150a8969744d703@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.7.0-rc1-next-20231117-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.3/8448 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888031a44a18 (&sighand->siglock){+.+.}-{2:2}, at: __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422

and this task is already holding:
ffff88802462ccd8 (_xmit_NONE#2){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88802462ccd8 (_xmit_NONE#2){+...}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4381 [inline]
ffff88802462ccd8 (_xmit_NONE#2){+...}-{2:2}, at: __dev_direct_xmit+0x431/0x730 net/core/dev.c:4400
which would create a new lock dependency:
 (_xmit_NONE#2){+...}-{2:2} -> (&sighand->siglock){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&dev->tx_global_lock){+.-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  dev_watchdog+0x7f/0x8b0 net/sched/sch_generic.c:500
  call_timer_fn+0x1a0/0x5a0 kernel/time/timer.c:1700
  expire_timers kernel/time/timer.c:1751 [inline]
  __run_timers+0x769/0xb20 kernel/time/timer.c:2022
  run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
  __do_softirq+0x216/0x8d5 kernel/softirq.c:553
  invoke_softirq kernel/softirq.c:427 [inline]
  __irq_exit_rcu kernel/softirq.c:632 [inline]
  irq_exit_rcu+0xb5/0x120 kernel/softirq.c:644
  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
  acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
  acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
  cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
  cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
  cpuidle_idle_call kernel/sched/idle.c:215 [inline]
  do_idle+0x314/0x3f0 kernel/sched/idle.c:312
  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:410
  rest_init+0x16f/0x2b0 init/main.c:730
  arch_call_rest_init+0x13/0x30 init/main.c:827
  start_kernel+0x39e/0x480 init/main.c:1072
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
  secondary_startup_64_no_verify+0x166/0x16b

to a SOFTIRQ-irq-unsafe lock:
 (&sighand->siglock){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  class_spinlock_constructor include/linux/spinlock.h:530 [inline]
  ptrace_set_stopped kernel/ptrace.c:391 [inline]
  ptrace_attach+0x401/0x650 kernel/ptrace.c:478
  __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a

other info that might help us debug this:

Chain exists of:
  &dev->tx_global_lock --> _xmit_NONE#2 --> &sighand->siglock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               local_irq_disable();
                               lock(&dev->tx_global_lock);
                               lock(_xmit_NONE#2);
  <Interrupt>
    lock(&dev->tx_global_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.3/8448:
 #0: ffff88802462ccd8 (_xmit_NONE#2){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #0: ffff88802462ccd8 (_xmit_NONE#2){+...}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4381 [inline]
 #0: ffff88802462ccd8 (_xmit_NONE#2){+...}-{2:2}, at: __dev_direct_xmit+0x431/0x730 net/core/dev.c:4400
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2310 [inline]
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0xe4/0x410 kernel/trace/bpf_trace.c:2350
 #2: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #2: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #2: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: __lock_task_sighand+0x3f/0x340 kernel/signal.c:1405

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&dev->tx_global_lock){+.-.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire kernel/locking/lockdep.c:5753 [inline]
                      lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                      __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                      _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                      spin_lock include/linux/spinlock.h:351 [inline]
                      netif_tx_lock net/sched/sch_generic.c:467 [inline]
                      netif_tx_lock_bh include/linux/netdevice.h:4465 [inline]
                      dev_watchdog_down net/sched/sch_generic.c:564 [inline]
                      dev_deactivate_many+0x1c6/0xb30 net/sched/sch_generic.c:1350
                      dev_deactivate+0xed/0x1b0 net/sched/sch_generic.c:1384
                      linkwatch_do_dev+0x115/0x150 net/core/link_watch.c:180
                      __linkwatch_run_queue+0x233/0x680 net/core/link_watch.c:235
                      linkwatch_event+0x8f/0xc0 net/core/link_watch.c:278
                      process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2636
                      process_scheduled_works kernel/workqueue.c:2709 [inline]
                      worker_thread+0x8b6/0x1290 kernel/workqueue.c:2790
                      kthread+0x2c1/0x3a0 kernel/kthread.c:388
                      ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                      ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
    IN-SOFTIRQ-W at:
                      lock_acquire kernel/locking/lockdep.c:5753 [inline]
                      lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                      __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                      _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                      spin_lock include/linux/spinlock.h:351 [inline]
                      dev_watchdog+0x7f/0x8b0 net/sched/sch_generic.c:500
                      call_timer_fn+0x1a0/0x5a0 kernel/time/timer.c:1700
                      expire_timers kernel/time/timer.c:1751 [inline]
                      __run_timers+0x769/0xb20 kernel/time/timer.c:2022
                      run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
                      __do_softirq+0x216/0x8d5 kernel/softirq.c:553
                      invoke_softirq kernel/softirq.c:427 [inline]
                      __irq_exit_rcu kernel/softirq.c:632 [inline]
                      irq_exit_rcu+0xb5/0x120 kernel/softirq.c:644
                      sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                      native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                      arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                      acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
                      acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
                      cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
                      cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                      cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                      do_idle+0x314/0x3f0 kernel/sched/idle.c:312
                      cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:410
                      rest_init+0x16f/0x2b0 init/main.c:730
                      arch_call_rest_init+0x13/0x30 init/main.c:827
                      start_kernel+0x39e/0x480 init/main.c:1072
                      x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
                      x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
                      secondary_startup_64_no_verify+0x166/0x16b
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5753 [inline]
                     lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                     __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                     _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                     spin_lock include/linux/spinlock.h:351 [inline]
                     netif_tx_lock net/sched/sch_generic.c:467 [inline]
                     netif_tx_lock_bh include/linux/netdevice.h:4465 [inline]
                     dev_watchdog_down net/sched/sch_generic.c:564 [inline]
                     dev_deactivate_many+0x1c6/0xb30 net/sched/sch_generic.c:1350
                     dev_deactivate+0xed/0x1b0 net/sched/sch_generic.c:1384
                     linkwatch_do_dev+0x115/0x150 net/core/link_watch.c:180
                     __linkwatch_run_queue+0x233/0x680 net/core/link_watch.c:235
                     linkwatch_event+0x8f/0xc0 net/core/link_watch.c:278
                     process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2636
                     process_scheduled_works kernel/workqueue.c:2709 [inline]
                     worker_thread+0x8b6/0x1290 kernel/workqueue.c:2790
                     kthread+0x2c1/0x3a0 kernel/kthread.c:388
                     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
  }
  ... key      at: [<ffffffff92b3a960>] __key.7+0x0/0x40
-> (_xmit_NONE#2){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    __netif_tx_lock include/linux/netdevice.h:4381 [inline]
                    netif_freeze_queues+0xdd/0x1e0 net/sched/sch_generic.c:459
                    netif_tx_lock net/sched/sch_generic.c:468 [inline]
                    netif_tx_lock_bh include/linux/netdevice.h:4465 [inline]
                    dev_watchdog_down net/sched/sch_generic.c:564 [inline]
                    dev_deactivate_many+0x1ce/0xb30 net/sched/sch_generic.c:1350
                    __dev_close_many+0x133/0x2f0 net/core/dev.c:1518
                    __dev_close net/core/dev.c:1543 [inline]
                    __dev_change_flags+0x4e5/0x730 net/core/dev.c:8603
                    dev_change_flags+0x9a/0x170 net/core/dev.c:8677
                    do_setlink+0x1a2f/0x3fa0 net/core/rtnetlink.c:2916
                    rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
                    __rtnl_newlink+0xded/0x1930 net/core/rtnetlink.c:3717
                    rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
                    rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
                    netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
                    netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
                    netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
                    netlink_sendmsg+0x939/0xe40 net/netlink/af_netlink.c:1910
                    sock_sendmsg_nosec net/socket.c:730 [inline]
                    __sock_sendmsg+0xd5/0x180 net/socket.c:745
                    ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
                    ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
                    __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                   spin_lock include/linux/spinlock.h:351 [inline]
                   __netif_tx_lock include/linux/netdevice.h:4381 [inline]
                   netif_freeze_queues+0xdd/0x1e0 net/sched/sch_generic.c:459
                   netif_tx_lock net/sched/sch_generic.c:468 [inline]
                   netif_tx_lock_bh include/linux/netdevice.h:4465 [inline]
                   dev_watchdog_down net/sched/sch_generic.c:564 [inline]
                   dev_deactivate_many+0x1ce/0xb30 net/sched/sch_generic.c:1350
                   __dev_close_many+0x133/0x2f0 net/core/dev.c:1518
                   __dev_close net/core/dev.c:1543 [inline]
                   __dev_change_flags+0x4e5/0x730 net/core/dev.c:8603
                   dev_change_flags+0x9a/0x170 net/core/dev.c:8677
                   do_setlink+0x1a2f/0x3fa0 net/core/rtnetlink.c:2916
                   rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
                   __rtnl_newlink+0xded/0x1930 net/core/rtnetlink.c:3717
                   rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
                   rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
                   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
                   netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
                   netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
                   netlink_sendmsg+0x939/0xe40 net/netlink/af_netlink.c:1910
                   sock_sendmsg_nosec net/socket.c:730 [inline]
                   __sock_sendmsg+0xd5/0x180 net/socket.c:745
                   ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
                   ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
                   __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
                   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                   entry_SYSCALL_64_after_hwframe+0x62/0x6a
 }
 ... key      at: [<ffffffff92b3b360>] netdev_xmit_lock_key+0x380/0x3c0
 ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   __netif_tx_lock include/linux/netdevice.h:4381 [inline]
   netif_freeze_queues+0xdd/0x1e0 net/sched/sch_generic.c:459
   netif_tx_lock net/sched/sch_generic.c:468 [inline]
   netif_tx_lock_bh include/linux/netdevice.h:4465 [inline]
   dev_watchdog_down net/sched/sch_generic.c:564 [inline]
   dev_deactivate_many+0x1ce/0xb30 net/sched/sch_generic.c:1350
   __dev_close_many+0x133/0x2f0 net/core/dev.c:1518
   __dev_close net/core/dev.c:1543 [inline]
   __dev_change_flags+0x4e5/0x730 net/core/dev.c:8603
   dev_change_flags+0x9a/0x170 net/core/dev.c:8677
   do_setlink+0x1a2f/0x3fa0 net/core/rtnetlink.c:2916
   rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
   __rtnl_newlink+0xded/0x1930 net/core/rtnetlink.c:3717
   rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
   rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
   netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
   netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
   netlink_sendmsg+0x939/0xe40 net/netlink/af_netlink.c:1910
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0xd5/0x180 net/socket.c:745
   ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
   ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
   __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&sighand->siglock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   calculate_sigpending+0x44/0xa0 kernel/signal.c:197
                   ret_from_fork+0x23/0x80 arch/x86/kernel/process.c:143
                   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 }
 ... key      at: [<ffffffff90b4af80>] __key.341+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5753 [inline]
   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
   __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
   lock_task_sighand include/linux/sched/signal.h:748 [inline]
   do_send_sig_info kernel/signal.c:1309 [inline]
   group_send_sig_info+0x288/0x300 kernel/signal.c:1460
   bpf_send_signal_common+0x2e4/0x3a0 kernel/trace/bpf_trace.c:877
   ____bpf_send_signal kernel/trace/bpf_trace.c:882 [inline]
   bpf_send_signal+0x19/0x20 kernel/trace/bpf_trace.c:880
   bpf_prog_a7bf4e27797d188e+0x22/0x24
   bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
   __bpf_prog_run include/linux/filter.h:651 [inline]
   bpf_prog_run include/linux/filter.h:658 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2311 [inline]
   bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2350
   trace_kfree include/trace/events/kmem.h:94 [inline]
   kfree+0xf6/0x150 mm/slab_common.c:1043
   skb_kfree_head net/core/skbuff.c:950 [inline]
   skb_free_head+0x110/0x1b0 net/core/skbuff.c:962
   skb_release_data+0x5ba/0x870 net/core/skbuff.c:992
   skb_release_all net/core/skbuff.c:1058 [inline]
   __kfree_skb net/core/skbuff.c:1072 [inline]
   kfree_skb_reason+0x12d/0x210 net/core/skbuff.c:1108
   kfree_skb include/linux/skbuff.h:1234 [inline]
   can_dropped_invalid_skb+0x9e/0x7c0 drivers/net/can/dev/skb.c:370
   vcan_tx+0x77/0xa90 drivers/net/can/vcan.c:92
   __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
   netdev_start_xmit include/linux/netdevice.h:4932 [inline]
   __dev_direct_xmit+0x59a/0x730 net/core/dev.c:4402
   dev_direct_xmit include/linux/netdevice.h:3125 [inline]
   packet_xmit+0x201/0x380 net/packet/af_packet.c:285
   packet_snd net/packet/af_packet.c:3087 [inline]
   packet_sendmsg+0x24ca/0x5240 net/packet/af_packet.c:3119
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0xd5/0x180 net/socket.c:745
   __sys_sendto+0x255/0x340 net/socket.c:2190
   __do_sys_sendto net/socket.c:2202 [inline]
   __se_sys_sendto net/socket.c:2198 [inline]
   __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a


stack backtrace:
CPU: 1 PID: 8448 Comm: syz-executor.3 Not tainted 6.7.0-rc1-next-20231117-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe18/0x1470 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x247c/0x3b10 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
 lock_task_sighand include/linux/sched/signal.h:748 [inline]
 do_send_sig_info kernel/signal.c:1309 [inline]
 group_send_sig_info+0x288/0x300 kernel/signal.c:1460
 bpf_send_signal_common+0x2e4/0x3a0 kernel/trace/bpf_trace.c:877
 ____bpf_send_signal kernel/trace/bpf_trace.c:882 [inline]
 bpf_send_signal+0x19/0x20 kernel/trace/bpf_trace.c:880
 bpf_prog_a7bf4e27797d188e+0x22/0x24
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2311 [inline]
 bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2350
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0xf6/0x150 mm/slab_common.c:1043
 skb_kfree_head net/core/skbuff.c:950 [inline]
 skb_free_head+0x110/0x1b0 net/core/skbuff.c:962
 skb_release_data+0x5ba/0x870 net/core/skbuff.c:992
 skb_release_all net/core/skbuff.c:1058 [inline]
 __kfree_skb net/core/skbuff.c:1072 [inline]
 kfree_skb_reason+0x12d/0x210 net/core/skbuff.c:1108
 kfree_skb include/linux/skbuff.h:1234 [inline]
 can_dropped_invalid_skb+0x9e/0x7c0 drivers/net/can/dev/skb.c:370
 vcan_tx+0x77/0xa90 drivers/net/can/vcan.c:92
 __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
 netdev_start_xmit include/linux/netdevice.h:4932 [inline]
 __dev_direct_xmit+0x59a/0x730 net/core/dev.c:4402
 dev_direct_xmit include/linux/netdevice.h:3125 [inline]
 packet_xmit+0x201/0x380 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x24ca/0x5240 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x255/0x340 net/socket.c:2190
 __do_sys_sendto net/socket.c:2202 [inline]
 __se_sys_sendto net/socket.c:2198 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f36a647cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f36a71eb0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f36a659bf80 RCX: 00007f36a647cae9
RDX: 000000000000fc13 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f36a64c847a R08: 0000000000000000 R09: 000000000000002f
R10: 0000000000000800 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f36a659bf80 R15: 00007fff7fb05d78
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

