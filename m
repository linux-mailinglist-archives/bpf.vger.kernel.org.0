Return-Path: <bpf+bounces-26721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ACF8A4204
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B9A1C20D16
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C85364A1;
	Sun, 14 Apr 2024 11:10:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382033E462
	for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713093029; cv=none; b=hAltIDeV8brOd7zVGL/3iheiZWvXKbqbeesqSlj7P0qeAgLzAe5l6bpLR0j94yWgSbhEPpzktj3DV32qd6b9YsfWvDxhgDZrR6/TuiZUBQ/DsxTWwF4uNwdppmMdokMWqE8K+X/yufy2ulwkNhSIGZksYq1NwKje6t/SPAnqF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713093029; c=relaxed/simple;
	bh=qvd50bIW2K89HrkwWcYADWefd+FwjjTWI9n6PEMNUlY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r8NyW7XB0ehkPIl3pzFdlgH9Q5TI9EbHZU/3N4JvR4RG25kJJ6+pWHwKM7TZuMP+tUaWP5EP26x9HX0Zr4x3kqbQ9b8CkXFddALCBTJNW+CHCCKYelW+z+Ie5qVM1gOCBjh7udDzvdGGFOhkUdFYgkfPqCJlaF3Z8Hfp/GFK4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso329832339f.0
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 04:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713093026; x=1713697826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78bFKjy6MAU/rC/KItiXm1aephiJ350tFC9EFuIL4DQ=;
        b=p6bqV/vnLZkGLyviDM5B/JwaC0w7y71nNRlP5i4bJ2rVxbSVpGBSleIlyWV0P0LJG7
         lQ5kwzd69Rv9KiEWt+8h47DMYQYvA32r/pt4Qsd3asAeEOIBkPu9OiysoQj/6SSt9pnq
         VB+vyTvKelO6SSR0g5YiAbxCj4ywA9c6suGwACl/F9DVlYkZk//NqAnIvYcfkLhGHMdK
         UkHs+wLKGoTACV4FKqnOXuX4ZR+dOxhgery3O1DS1rplBDI2grnz30n46xC01vXUxPwV
         acQbRUv0+icJqE9+HO+VrzghVbWXwrhs2Rm4JyPTZUn2FiImvp+hbhY8fkgH4uDYGWh3
         8mgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Uf0O4ag1bAnpx4joH1cErI+9Yt83Q5LombkWkcjBOnIfv49eDorM/pzJt24Mqo7skaP2eSuTPMG+Kx9kKR77Z5H1
X-Gm-Message-State: AOJu0YxyrBhQSUmb/FWm2KTVYIx+QPwsBMbtGY0TbcvcgCfsoXSUYBVa
	mqFR9uvTWuBqA2nCdp5XxzWA6LBffLLHfsn18+DusT+xtq3aorLKCFXsALq1jecYw9WxW1R4Yy0
	fS6LIHwuwP+QtfYGcTq2qzDomdgVfOQK4lMbxoZzi+GAGoiztqphoEpI=
X-Google-Smtp-Source: AGHT+IFBWKLs+rhqH09lDjJIEqciCdDj6ibDR/ucCXpul1EFXFnVbM9zeYerPt681Klks4It4lGaLcQq3wRZOB7g/G70J5oK+7bh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a2:b0:47e:c0f8:75b3 with SMTP id
 t34-20020a05663834a200b0047ec0f875b3mr417085jal.2.1713093026592; Sun, 14 Apr
 2024 04:10:26 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:10:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005143c806160c8d98@google.com>
Subject: [syzbot] [trace?] [bpf?] possible deadlock in pwq_dec_nr_in_flight
From: syzbot <syzbot+92438ab91cb6348b16fa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d25599180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=92438ab91cb6348b16fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92438ab91cb6348b16fa@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
kworker/u8:5/987 is trying to acquire lock:
ffffffff8e126300 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1997 [inline]
ffffffff8e126300 (console_owner){....}-{0:0}, at: vprintk_emit+0x3d6/0x770 kernel/printk/printk.c:2341

but task is already holding lock:
ffff8881483629a0 (&nna->lock){..-.}-{2:2}, at: node_activate_pending_pwq kernel/workqueue.c:1882 [inline]
ffff8881483629a0 (&nna->lock){..-.}-{2:2}, at: pwq_dec_nr_active kernel/workqueue.c:1993 [inline]
ffff8881483629a0 (&nna->lock){..-.}-{2:2}, at: pwq_dec_nr_in_flight+0x32a/0xd60 kernel/workqueue.c:2017

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&nna->lock){..-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       pwq_tryinc_nr_active+0x2ef/0x720 kernel/workqueue.c:1774
       __queue_work+0xa9d/0xec0 kernel/workqueue.c:2395
       queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
       queue_work include/linux/workqueue.h:605 [inline]
       call_usermodehelper_exec+0x286/0x4a0 kernel/umh.c:434
       kobject_uevent_env+0x6b5/0x8f0 lib/kobject_uevent.c:618
       driver_register+0x2d6/0x320 drivers/base/driver.c:254
       pcie_init_services+0xa/0x20 drivers/pci/pcie/portdrv.c:828
       pcie_portdrv_init+0x38/0x60 drivers/pci/pcie/portdrv.c:839
       do_one_initcall+0x238/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1550
       kernel_init+0x1d/0x2a0 init/main.c:1439
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #3 (&pool->lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x6ec/0xec0
       queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
       queue_work include/linux/workqueue.h:605 [inline]
       rpm_suspend+0xe99/0x1780 drivers/base/power/runtime.c:662
       __pm_runtime_idle+0x131/0x1a0 drivers/base/power/runtime.c:1104
       pm_runtime_put include/linux/pm_runtime.h:448 [inline]
       __device_attach+0x3e5/0x520 drivers/base/dd.c:1048
       bus_probe_device+0x189/0x260 drivers/base/bus.c:532
       device_add+0x8ff/0xca0 drivers/base/core.c:3639
       serial_base_port_add+0x2b6/0x3f0 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3353 [inline]
       serial_core_register_port+0x393/0x1e30 drivers/tty/serial/serial_core.c:3394
       serial8250_register_8250_port+0x1433/0x1cd0 drivers/tty/serial/8250/8250_core.c:1138
       serial_pnp_probe+0x7d5/0xa20 drivers/tty/serial/8250/8250_pnp.c:478
       pnp_device_probe+0x2ba/0x460 drivers/pnp/driver.c:111
       really_probe+0x29e/0xc50 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
       bus_add_driver+0x347/0x620 drivers/base/bus.c:673
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       serial8250_init+0x9e/0x170 drivers/tty/serial/8250/8250_core.c:1239
       do_one_initcall+0x238/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1550
       kernel_init+0x1d/0x2a0 init/main.c:1439
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #2 (&dev->power.lock){-...}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0x112/0x180 drivers/base/power/runtime.c:1171
       pm_runtime_get include/linux/pm_runtime.h:396 [inline]
       __uart_start+0x17a/0x3c0 drivers/tty/serial/serial_core.c:148
       uart_write+0x427/0x5c0 drivers/tty/serial/serial_core.c:615
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xd6a/0x1230 drivers/tty/n_tty.c:2379
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x54f/0x9b0 drivers/tty/tty_io.c:1096
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&port_lock_key){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
       serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
       console_emit_next_record kernel/printk/printk.c:2907 [inline]
       console_flush_all+0x867/0xfd0 kernel/printk/printk.c:2973
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
       vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
       _printk+0xd5/0x120 kernel/printk/printk.c:2367
       register_console+0x70a/0xcd0 kernel/printk/printk.c:3548
       univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0x198/0x680 kernel/printk/printk.c:3694
       start_kernel+0x2d3/0x500 init/main.c:1012
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
       common_startup_64+0x13e/0x147

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       console_trylock_spinning kernel/printk/printk.c:1997 [inline]
       vprintk_emit+0x3f3/0x770 kernel/printk/printk.c:2341
       _printk+0xd5/0x120 kernel/printk/printk.c:2367
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
       spin_unlock_bh include/linux/spinlock.h:396 [inline]
       __sock_map_delete net/core/sock_map.c:424 [inline]
       sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
       bpf_prog_f4780399ec52412a+0x45/0x49
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:650 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run1+0x336/0x3f0 kernel/trace/bpf_trace.c:2419
       trace_workqueue_activate_work+0x161/0x1d0 include/trace/events/workqueue.h:59
       __pwq_activate_work+0x61/0x340 kernel/workqueue.c:1675
       node_activate_pending_pwq kernel/workqueue.c:1926 [inline]
       pwq_dec_nr_active kernel/workqueue.c:1993 [inline]
       pwq_dec_nr_in_flight+0x679/0xd60 kernel/workqueue.c:2017
       process_one_work kernel/workqueue.c:3309 [inline]
       process_scheduled_works+0xec5/0x1770 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

Chain exists of:
  console_owner --> &pool->lock --> &nna->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nna->lock);
                               lock(&pool->lock);
                               lock(&nna->lock);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by kworker/u8:5/987:
 #0: ffff888014ca0018 (&pool->lock){-.-.}-{2:2}, at: process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff888014ca0018 (&pool->lock){-.-.}-{2:2}, at: process_scheduled_works+0xc90/0x1770 kernel/workqueue.c:3335
 #1: ffff8881483629a0 (&nna->lock){..-.}-{2:2}, at: node_activate_pending_pwq kernel/workqueue.c:1882 [inline]
 #1: ffff8881483629a0 (&nna->lock){..-.}-{2:2}, at: pwq_dec_nr_active kernel/workqueue.c:1993 [inline]
 #1: ffff8881483629a0 (&nna->lock){..-.}-{2:2}, at: pwq_dec_nr_in_flight+0x32a/0xd60 kernel/workqueue.c:2017
 #2: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #2: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #2: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #2: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run1+0xf0/0x3f0 kernel/trace/bpf_trace.c:2419

stack backtrace:
CPU: 0 PID: 987 Comm: kworker/u8:5 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue:  0x0 (bat_events)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 console_trylock_spinning kernel/printk/printk.c:1997 [inline]
 vprintk_emit+0x3f3/0x770 kernel/printk/printk.c:2341
 _printk+0xd5/0x120 kernel/printk/printk.c:2367
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x346/0x500 lib/bug.c:219
 handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:__local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 0c 41 86 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc9000404f8c0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000809f1c RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff895b48fa
RBP: ffffc9000404f980 R08: ffff88805c7049eb R09: 1ffff1100b8e093d
R10: dffffc0000000000 R11: ffffed100b8e093e R12: dffffc0000000000
R13: ffff88807ca940c0 R14: ffffc9000404f900 R15: 0000000000000201
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
 bpf_prog_f4780399ec52412a+0x45/0x49
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:650 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run1+0x336/0x3f0 kernel/trace/bpf_trace.c:2419
 trace_workqueue_activate_work+0x161/0x1d0 include/trace/events/workqueue.h:59
 __pwq_activate_work+0x61/0x340 kernel/workqueue.c:1675
 node_activate_pending_pwq kernel/workqueue.c:1926 [inline]
 pwq_dec_nr_active kernel/workqueue.c:1993 [inline]
 pwq_dec_nr_in_flight+0x679/0xd60 kernel/workqueue.c:2017
 process_one_work kernel/workqueue.c:3309 [inline]
 process_scheduled_works+0xec5/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
WARNING: CPU: 0 PID: 987 at kernel/softirq.c:362 __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Modules linked in:
CPU: 0 PID: 987 Comm: kworker/u8:5 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue:  0x0 (bat_events)
RIP: 0010:__local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 0c 41 86 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc9000404f8c0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000809f1c RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff895b48fa
RBP: ffffc9000404f980 R08: ffff88805c7049eb R09: 1ffff1100b8e093d
R10: dffffc0000000000 R11: ffffed100b8e093e R12: dffffc0000000000
R13: ffff88807ca940c0 R14: ffffc9000404f900 R15: 0000000000000201
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8ff1abf84 CR3: 0000000062f64000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
 bpf_prog_f4780399ec52412a+0x45/0x49
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:650 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run1+0x336/0x3f0 kernel/trace/bpf_trace.c:2419
 trace_workqueue_activate_work+0x161/0x1d0 include/trace/events/workqueue.h:59
 __pwq_activate_work+0x61/0x340 kernel/workqueue.c:1675
 node_activate_pending_pwq kernel/workqueue.c:1926 [inline]
 pwq_dec_nr_active kernel/workqueue.c:1993 [inline]
 pwq_dec_nr_in_flight+0x679/0xd60 kernel/workqueue.c:2017
 process_one_work kernel/workqueue.c:3309 [inline]
 process_scheduled_works+0xec5/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

