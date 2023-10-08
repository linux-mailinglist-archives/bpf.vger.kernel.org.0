Return-Path: <bpf+bounces-11660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6C7BCCB6
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 08:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5125F281D05
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CEA6129;
	Sun,  8 Oct 2023 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BE53AA
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 06:28:49 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F3CA
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 23:28:45 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1dce198f501so5288242fac.2
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 23:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696746525; x=1697351325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcgMww75S99xFdktqW21CfFoKt5XQ5CmscxpCVAwsKM=;
        b=ubtJ64qKul9apuGyJBjsLKzF0bO8j3CQk3WHwKNn0oIuVMvD69z181/XV7f9VoyWxE
         6DCFMF2OJqOIq6nxxU5JW75ea6cnJrE5ErX2xYvwZNNDbCD+iJnXxb7tHogvXR8ZFcSc
         zXjijoNSbULVb1WjPGAeMgQawOxdnGluNsH7PKQLkTypiaGCd9+M+UouBLAVNvrJVC+Y
         s2etDoTFCKqfPIDuWq8zEQi8A0czHf62aRbyiU4tqj4DvH5Qs2AXaK3qVMcdkNbVzAVg
         Kwygh5hcSjG0cDLUeHpXQ7JSTLoXI+oriuCJvCnQQtnprzEj/tHW92ZFo04vi0vNnyFu
         IWtg==
X-Gm-Message-State: AOJu0YwjJr58hzI+Ije6EnIi02TPLpfu7CiLh3oJKUF79Chjd5yCQX/6
	gPeb+YPTKPJzxriz22SmGePn3pcX7q5C+seKDZq++bEL0uS/MkASqg==
X-Google-Smtp-Source: AGHT+IHgFDcwxNgZODyXBeDii6FSvMv0C8cUoJi9cFJcXiVOj9RpAyUc/DlNyq5wEdP9u+H9LLIUI8G7fm/ll2tekORVDP3k5lal
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7688:b0:1dc:6d26:9ff with SMTP id
 dx8-20020a056870768800b001dc6d2609ffmr4642150oab.6.1696746525126; Sat, 07 Oct
 2023 23:28:45 -0700 (PDT)
Date: Sat, 07 Oct 2023 23:28:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7765006072e9591@google.com>
Subject: [syzbot] [kernel?] possible deadlock in task_fork_fair
From: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1150d0de680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com

EEVDF scheduling fail, picking leftmost
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc4-next-20231005-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/5092 is trying to acquire lock:
ffffffff8cab8560 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1963 [inline]
ffffffff8cab8560 (console_owner){....}-{0:0}, at: vprintk_emit+0x313/0x5f0 kernel/printk/printk.c:2303

but task is already holding lock:
ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1357 [inline]
       rq_lock kernel/sched/sched.h:1671 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12399
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4799
       copy_process+0x4580/0x74b0 kernel/fork.c:2609
       kernel_clone+0xfd/0x920 kernel/fork.c:2907
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2985
       rest_init+0x27/0x2b0 init/main.c:691
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #4 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xb0/0x15d0 kernel/sched/core.c:4213
       kick_pool+0x253/0x460 kernel/workqueue.c:1142
       create_worker+0x45e/0x710 kernel/workqueue.c:2217
       workqueue_init+0x319/0x830 kernel/workqueue.c:6686
       kernel_init_freeable+0x332/0x900 init/main.c:1532
       kernel_init+0x1c/0x2a0 init/main.c:1437
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x399/0x1050 kernel/workqueue.c:1763
       queue_work_on+0xed/0x110 kernel/workqueue.c:1834
       queue_work include/linux/workqueue.h:554 [inline]
       rpm_suspend+0x1219/0x16f0 drivers/base/power/runtime.c:660
       rpm_idle+0x574/0x6e0 drivers/base/power/runtime.c:534
       __pm_runtime_idle+0xbe/0x160 drivers/base/power/runtime.c:1102
       pm_runtime_put include/linux/pm_runtime.h:460 [inline]
       __device_attach+0x382/0x4b0 drivers/base/dd.c:1048
       bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
       device_add+0x117e/0x1aa0 drivers/base/core.c:3624
       serial_base_port_add+0x353/0x4b0 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3315 [inline]
       serial_core_register_port+0x137/0x1af0 drivers/tty/serial/serial_core.c:3356
       serial8250_register_8250_port+0x140d/0x2080 drivers/tty/serial/8250/8250_core.c:1139
       serial_pnp_probe+0x47d/0x880 drivers/tty/serial/8250/8250_pnp.c:478
       pnp_device_probe+0x2a3/0x4c0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x234/0xc90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
       __driver_attach+0x274/0x570 drivers/base/dd.c:1216
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2e9/0x630 drivers/base/bus.c:673
       driver_register+0x15c/0x4a0 drivers/base/driver.c:246
       serial8250_init+0xba/0x4b0 drivers/tty/serial/8250/8250_core.c:1240
       do_one_initcall+0x11c/0x640 init/main.c:1232
       do_initcall_level init/main.c:1294 [inline]
       do_initcalls init/main.c:1310 [inline]
       do_basic_setup init/main.c:1329 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1547
       kernel_init+0x1c/0x2a0 init/main.c:1437
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #2 (&dev->power.lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0xab/0x170 drivers/base/power/runtime.c:1169
       pm_runtime_get include/linux/pm_runtime.h:408 [inline]
       __uart_start+0x1b0/0x420 drivers/tty/serial/serial_core.c:148
       uart_write+0x2ff/0x5b0 drivers/tty/serial/serial_core.c:618
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0x422/0x1130 drivers/tty/n_tty.c:2379
       iterate_tty_write drivers/tty/tty_io.c:1017 [inline]
       file_tty_write.constprop.0+0x519/0x9b0 drivers/tty/tty_io.c:1088
       tty_write drivers/tty/tty_io.c:1109 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1132 [inline]
       redirected_tty_write+0xa6/0xc0 drivers/tty/tty_io.c:1112
       call_write_iter include/linux/fs.h:1966 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x64f/0xe40 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
       serial8250_console_write+0xa7c/0x1060 drivers/tty/serial/8250/8250_port.c:3410
       console_emit_next_record kernel/printk/printk.c:2894 [inline]
       console_flush_all+0x4d5/0xd50 kernel/printk/printk.c:2960
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3029
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2304
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2329
       register_console+0xb30/0x1210 kernel/printk/printk.c:3535
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0xba/0x5c0 kernel/printk/printk.c:3681
       start_kernel+0x25a/0x480 init/main.c:1004
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       console_trylock_spinning kernel/printk/printk.c:1963 [inline]
       vprintk_emit+0x328/0x5f0 kernel/printk/printk.c:2303
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2329
       pick_eevdf kernel/sched/fair.c:963 [inline]
       pick_next_entity kernel/sched/fair.c:5247 [inline]
       pick_next_task_fair+0x1c5/0x1280 kernel/sched/fair.c:8205
       __pick_next_task kernel/sched/core.c:5986 [inline]
       pick_next_task kernel/sched/core.c:6061 [inline]
       __schedule+0x493/0x5a00 kernel/sched/core.c:6640
       __schedule_loop kernel/sched/core.c:6753 [inline]
       schedule+0xe7/0x270 kernel/sched/core.c:6768
       schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6825
       __mutex_lock_common kernel/locking/mutex.c:679 [inline]
       __mutex_lock+0x969/0x1340 kernel/locking/mutex.c:747
       ieee80211_register_hw+0x26d0/0x4260 net/mac80211/main.c:1408
       mac80211_hwsim_new_radio+0x24cf/0x4cb0 drivers/net/wireless/virtual/mac80211_hwsim.c:5304
       hwsim_new_radio_nl+0xaf8/0x1240 drivers/net/wireless/virtual/mac80211_hwsim.c:5985
       genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:971
       genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
       genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1066
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
       netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
       netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
       netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0xd5/0x180 net/socket.c:745
       __sys_sendto+0x255/0x340 net/socket.c:2194
       __do_sys_sendto net/socket.c:2206 [inline]
       __se_sys_sendto net/socket.c:2202 [inline]
       __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2202
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

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

4 locks held by syz-executor.4/5092:
 #0: ffffffff8e6a8450 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1074
 #1: ffffffff8e6a8508 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8e6a8508 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:58 [inline]
 #1: ffffffff8e6a8508 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:55 [inline]
 #1: ffffffff8e6a8508 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x577/0x800 net/netlink/genetlink.c:1065
 #2: ffffffff8e60db28 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_register_hw+0x26d0/0x4260 net/mac80211/main.c:1408
 #3: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558

stack backtrace:
CPU: 1 PID: 5092 Comm: syz-executor.4 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 console_trylock_spinning kernel/printk/printk.c:1963 [inline]
 vprintk_emit+0x328/0x5f0 kernel/printk/printk.c:2303
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2329
 pick_eevdf kernel/sched/fair.c:963 [inline]
 pick_next_entity kernel/sched/fair.c:5247 [inline]
 pick_next_task_fair+0x1c5/0x1280 kernel/sched/fair.c:8205
 __pick_next_task kernel/sched/core.c:5986 [inline]
 pick_next_task kernel/sched/core.c:6061 [inline]
 __schedule+0x493/0x5a00 kernel/sched/core.c:6640
 __schedule_loop kernel/sched/core.c:6753 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6768
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6825
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x969/0x1340 kernel/locking/mutex.c:747
 ieee80211_register_hw+0x26d0/0x4260 net/mac80211/main.c:1408
 mac80211_hwsim_new_radio+0x24cf/0x4cb0 drivers/net/wireless/virtual/mac80211_hwsim.c:5304
 hwsim_new_radio_nl+0xaf8/0x1240 drivers/net/wireless/virtual/mac80211_hwsim.c:5985
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:971
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x255/0x340 net/socket.c:2194
 __do_sys_sendto net/socket.c:2206 [inline]
 __se_sys_sendto net/socket.c:2202 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2202
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6ec907e7dc
Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
RSP: 002b:00007fff330e2f40 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f6ec9cc4620 RCX: 00007f6ec907e7dc
RDX: 0000000000000024 RSI: 00007f6ec9cc4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff330e2f94 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f6ec9cc4670 R15: 0000000000000000
 </TASK>
ieee80211 phy14: Selected rate control algorithm 'minstrel_ht'


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

