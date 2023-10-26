Return-Path: <bpf+bounces-13339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9E7D870E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE94B211AC
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4105374FB;
	Thu, 26 Oct 2023 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B492D78B
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:54:25 +0000 (UTC)
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B5187
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:54:22 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6ccf7049ed4so1389484a34.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698339262; x=1698944062;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOKnqFAzVWVPbYMOCy9aXSqsX9SjyqMl1ArWycZEEXA=;
        b=bV38CRN7ZIlw8Nk7yQXh4nSYoAJQ9pAIJyoiCk+mHATKs4q3fHK9KshkhW94nX2kNc
         KrS7X7uzRCu+nivhjjruTKfDzSOBMWrHyV1/YWZ/meos4HsjjF/B26Ddu0ojTAINQ03i
         Flxj7uuYI3lzgXPWJApw15hdczCb/4qcL5722sC41/2KLhCTAtWDzEQ9gfdrGRmkYW49
         dTab2M9jOg3tDW5O83PlIYt0RSWE0LSrdUkIRW5AMRWtYIT1s7fvx3B6JVhkVxxJdIRM
         +cbdxv9TE9omc0Hrumz8eBpdRrNkWrNhvU9jQ9Y6ql+b0UiQI/d6HBzWr5fDGRMKbShE
         NbTg==
X-Gm-Message-State: AOJu0YwohnnV1MEpHF8PEy2pUeCR0qgJpaeYOiDoHrziX97zW5peb6O+
	56ORxopoIf7CB8syW5o2msO+fNlyFMvP1I1g9fEv5lsuHYtRh9nD2w==
X-Google-Smtp-Source: AGHT+IHNiEyjuZJjMhuRzH5GFRSKLECxtDFKN5QoHnCCNQqTbvwr9q60AosDjNc3RnZNQj0C91vH7GgvzXD64zp/LnAOfYuwxat9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:6a88:0:b0:6c4:aa6a:c4db with SMTP id
 l8-20020a9d6a88000000b006c4aa6ac4dbmr2528otq.0.1698339262220; Thu, 26 Oct
 2023 09:54:22 -0700 (PDT)
Date: Thu, 26 Oct 2023 09:54:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f01f00608a16cea@google.com>
Subject: [syzbot] [kernel?] possible deadlock in console_lock_spinning_enable (3)
From: syzbot <syzbot+eb3e11a15d6b5e663c64@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a27383680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c7a3e91cde52da
dashboard link: https://syzkaller.appspot.com/bug?extid=eb3e11a15d6b5e663c64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3ee1b279e6c2/disk-78124b0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f927e3a1d2b/vmlinux-78124b0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b7abda45082/Image-78124b0c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb3e11a15d6b5e663c64@syzkaller.appspotmail.com

EEVDF scheduling fail, picking leftmost
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc6-syzkaller-g78124b0c1d10 #0 Not tainted
------------------------------------------------------
ksoftirqd/0/16 is trying to acquire lock:
ffff80008e509100 (console_owner){....}-{0:0}, at: console_lock_spinning_enable+0x38/0x78 kernel/printk/printk.c:1855

but task is already holding lock:
ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1681 [inline]
ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x2d8/0x23b4 kernel/sched/core.c:6612

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x6c kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2c/0x44 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
       rq_lock kernel/sched/sched.h:1681 [inline]
       task_fork_fair+0x74/0x128 kernel/sched/fair.c:12416
       sched_cgroup_fork+0x38c/0x464 kernel/sched/core.c:4816
       copy_process+0x24bc/0x34b8 kernel/fork.c:2609
       kernel_clone+0x1d8/0x80c kernel/fork.c:2909
       user_mode_thread+0x110/0x178 kernel/fork.c:2987
       rest_init+0x2c/0x2f4 init/main.c:691
       start_kernel+0x0/0x4e8 init/main.c:823
       start_kernel+0x3e8/0x4e8 init/main.c:1068
       __primary_switched+0xb8/0xc0 arch/arm64/kernel/head.S:523

-> #4 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xb0/0xe80 kernel/sched/core.c:4230
       wake_up_process+0x18/0x24 kernel/sched/core.c:4478
       kick_pool+0x29c/0x36c kernel/workqueue.c:1142
       create_worker+0x518/0x6ec kernel/workqueue.c:2217
       workqueue_init+0x338/0x63c kernel/workqueue.c:6694
       kernel_init_freeable+0x2f8/0x474 init/main.c:1532
       kernel_init+0x24/0x29c init/main.c:1437
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
       __queue_work+0x878/0x1338
       queue_work_on+0x9c/0x128 kernel/workqueue.c:1834
       queue_work include/linux/workqueue.h:554 [inline]
       rpm_suspend+0xea8/0x1aac drivers/base/power/runtime.c:660
       rpm_idle+0x1f8/0xd90 drivers/base/power/runtime.c:534
       __pm_runtime_idle+0x1a4/0x498 drivers/base/power/runtime.c:1102
       pm_runtime_put include/linux/pm_runtime.h:460 [inline]
       __device_attach+0x34c/0x434 drivers/base/dd.c:1048
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1079
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x768/0xaac drivers/base/core.c:3624
       serial_base_port_add+0x25c/0x370 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3315 [inline]
       serial_core_register_port+0x308/0x1a5c drivers/tty/serial/serial_core.c:3356
       serial_ctrl_register_port+0x28/0x38 drivers/tty/serial/serial_ctrl.c:41
       uart_add_one_port+0x28/0x38 drivers/tty/serial/serial_port.c:75
       pl011_register_port+0x1a0/0x434 drivers/tty/serial/amba-pl011.c:2780
       sbsa_uart_probe+0x474/0x5dc drivers/tty/serial/amba-pl011.c:2939
       platform_probe+0x148/0x1c0 drivers/base/platform.c:1404
       really_probe+0x394/0xa7c drivers/base/dd.c:658
       __driver_probe_device+0x194/0x3b4 drivers/base/dd.c:800
       driver_probe_device+0x78/0x330 drivers/base/dd.c:830
       __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:958
       bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
       __device_attach+0x2b4/0x434 drivers/base/dd.c:1030
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1079
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x768/0xaac drivers/base/core.c:3624
       platform_device_add+0x3f8/0x708 drivers/base/platform.c:717
       platform_device_register_full+0x4e4/0x5fc drivers/base/platform.c:844
       acpi_create_platform_device+0x5bc/0x744 drivers/acpi/acpi_platform.c:177
       acpi_default_enumeration+0x6c/0xdc drivers/acpi/scan.c:2116
       acpi_bus_attach+0x8bc/0xaac drivers/acpi/scan.c:2225
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1100
       device_for_each_child+0xec/0x174 drivers/base/core.c:3953
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1112
       acpi_bus_attach+0x358/0xaac drivers/acpi/scan.c:2230
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1100
       device_for_each_child+0xec/0x174 drivers/base/core.c:3953
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1112
       acpi_bus_attach+0x358/0xaac drivers/acpi/scan.c:2230
       acpi_bus_scan+0xfc/0x4cc drivers/acpi/scan.c:2496
       acpi_scan_init+0x218/0x6b4 drivers/acpi/scan.c:2655
       acpi_init+0x190/0x254 drivers/acpi/bus.c:1417
       do_one_initcall+0x23c/0x98c init/main.c:1232
       do_initcall_level+0x154/0x214 init/main.c:1294
       do_initcalls+0x58/0xac init/main.c:1310
       do_basic_setup+0x8c/0xa0 init/main.c:1329
       kernel_init_freeable+0x320/0x474 init/main.c:1547
       kernel_init+0x24/0x29c init/main.c:1437
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #2 (&dev->power.lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       __pm_runtime_resume+0xf0/0x180 drivers/base/power/runtime.c:1169
       pm_runtime_get include/linux/pm_runtime.h:408 [inline]
       __uart_start+0x158/0x380 drivers/tty/serial/serial_core.c:148
       uart_write+0x3a8/0x594 drivers/tty/serial/serial_core.c:618
       process_output_block drivers/tty/n_tty.c:579 [inline]
       n_tty_write+0xaec/0xed0 drivers/tty/n_tty.c:2384
       iterate_tty_write drivers/tty/tty_io.c:1017 [inline]
       file_tty_write+0x40c/0x77c drivers/tty/tty_io.c:1088
       tty_write drivers/tty/tty_io.c:1109 [inline]
       redirected_tty_write+0xc0/0xfc drivers/tty/tty_io.c:1132
       call_write_iter include/linux/fs.h:1956 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x628/0x93c fs/read_write.c:584
       ksys_write+0x15c/0x26c fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       __se_sys_write fs/read_write.c:646 [inline]
       __arm64_sys_write+0x7c/0x90 fs/read_write.c:646
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #1 (&port_lock_key){....}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       pl011_console_write+0x180/0x708 drivers/tty/serial/amba-pl011.c:2341
       console_emit_next_record kernel/printk/printk.c:2910 [inline]
       console_flush_all+0x5d0/0xb78 kernel/printk/printk.c:2966
       console_unlock+0xec/0x3d4 kernel/printk/printk.c:3035
       vprintk_emit+0x150/0x2e8 kernel/printk/printk.c:2307
       vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2322
       vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
       _printk+0xdc/0x128 kernel/printk/printk.c:2332
       register_console+0x938/0xcf8 kernel/printk/printk.c:3524
       uart_configure_port drivers/tty/serial/serial_core.c:2605 [inline]
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3132 [inline]
       serial_core_register_port+0x1330/0x1a5c drivers/tty/serial/serial_core.c:3360
       serial_ctrl_register_port+0x28/0x38 drivers/tty/serial/serial_ctrl.c:41
       uart_add_one_port+0x28/0x38 drivers/tty/serial/serial_port.c:75
       pl011_register_port+0x1a0/0x434 drivers/tty/serial/amba-pl011.c:2780
       sbsa_uart_probe+0x474/0x5dc drivers/tty/serial/amba-pl011.c:2939
       platform_probe+0x148/0x1c0 drivers/base/platform.c:1404
       really_probe+0x394/0xa7c drivers/base/dd.c:658
       __driver_probe_device+0x194/0x3b4 drivers/base/dd.c:800
       driver_probe_device+0x78/0x330 drivers/base/dd.c:830
       __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:958
       bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
       __device_attach+0x2b4/0x434 drivers/base/dd.c:1030
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1079
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x768/0xaac drivers/base/core.c:3624
       platform_device_add+0x3f8/0x708 drivers/base/platform.c:717
       platform_device_register_full+0x4e4/0x5fc drivers/base/platform.c:844
       acpi_create_platform_device+0x5bc/0x744 drivers/acpi/acpi_platform.c:177
       acpi_default_enumeration+0x6c/0xdc drivers/acpi/scan.c:2116
       acpi_bus_attach+0x8bc/0xaac drivers/acpi/scan.c:2225
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1100
       device_for_each_child+0xec/0x174 drivers/base/core.c:3953
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1112
       acpi_bus_attach+0x358/0xaac drivers/acpi/scan.c:2230
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1100
       device_for_each_child+0xec/0x174 drivers/base/core.c:3953
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1112
       acpi_bus_attach+0x358/0xaac drivers/acpi/scan.c:2230
       acpi_bus_scan+0xfc/0x4cc drivers/acpi/scan.c:2496
       acpi_scan_init+0x218/0x6b4 drivers/acpi/scan.c:2655
       acpi_init+0x190/0x254 drivers/acpi/bus.c:1417
       do_one_initcall+0x23c/0x98c init/main.c:1232
       do_initcall_level+0x154/0x214 init/main.c:1294
       do_initcalls+0x58/0xac init/main.c:1310
       do_basic_setup+0x8c/0xa0 init/main.c:1329
       kernel_init_freeable+0x320/0x474 init/main.c:1547
       kernel_init+0x24/0x29c init/main.c:1437
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
       console_lock_spinning_enable+0x68/0x78 kernel/printk/printk.c:1858
       console_emit_next_record kernel/printk/printk.c:2904 [inline]
       console_flush_all+0x590/0xb78 kernel/printk/printk.c:2966
       console_unlock+0xec/0x3d4 kernel/printk/printk.c:3035
       vprintk_emit+0x150/0x2e8 kernel/printk/printk.c:2307
       vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2322
       vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
       _printk+0xdc/0x128 kernel/printk/printk.c:2332
       pick_eevdf+0x610/0x618 kernel/sched/fair.c:976
       pick_next_entity kernel/sched/fair.c:5278 [inline]
       pick_next_task_fair+0x104/0x930 kernel/sched/fair.c:8222
       __pick_next_task kernel/sched/core.c:6004 [inline]
       pick_next_task kernel/sched/core.c:6514 [inline]
       __schedule+0x638/0x23b4 kernel/sched/core.c:6659
       schedule+0xc4/0x170 kernel/sched/core.c:6771
       smpboot_thread_fn+0x51c/0x90c kernel/smpboot.c:160
       kthread+0x288/0x310 kernel/kthread.c:388
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

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

3 locks held by ksoftirqd/0/16:
 #0: ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
 #0: ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
 #0: ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1681 [inline]
 #0: ffff0001b4189d58 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x2d8/0x23b4 kernel/sched/core.c:6612
 #1: ffff80008e3f0a20 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x134/0x2e8 kernel/printk/printk.c:2306
 #2: ffff80008e3f0650 (console_srcu){....}-{0:0}, at: rcu_lock_acquire+0x18/0x54 include/linux/rcupdate.h:302

stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.6.0-rc6-syzkaller-g78124b0c1d10 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 console_lock_spinning_enable+0x68/0x78 kernel/printk/printk.c:1858
 console_emit_next_record kernel/printk/printk.c:2904 [inline]
 console_flush_all+0x590/0xb78 kernel/printk/printk.c:2966
 console_unlock+0xec/0x3d4 kernel/printk/printk.c:3035
 vprintk_emit+0x150/0x2e8 kernel/printk/printk.c:2307
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2322
 vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
 _printk+0xdc/0x128 kernel/printk/printk.c:2332
 pick_eevdf+0x610/0x618 kernel/sched/fair.c:976
 pick_next_entity kernel/sched/fair.c:5278 [inline]
 pick_next_task_fair+0x104/0x930 kernel/sched/fair.c:8222
 __pick_next_task kernel/sched/core.c:6004 [inline]
 pick_next_task kernel/sched/core.c:6514 [inline]
 __schedule+0x638/0x23b4 kernel/sched/core.c:6659
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 smpboot_thread_fn+0x51c/0x90c kernel/smpboot.c:160
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857


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

