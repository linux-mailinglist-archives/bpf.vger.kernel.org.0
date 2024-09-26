Return-Path: <bpf+bounces-40333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28285986BDC
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 06:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4C41F24164
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3455A17839E;
	Thu, 26 Sep 2024 04:53:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEF16FF26;
	Thu, 26 Sep 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727326409; cv=none; b=oWuZ8+By2D+XRqM/irNTHyhwTGzcDJF606OvGmRkgKZxY2ZyBnWH514M4CSIjeJLdUNr2SSxII3UhR7OPaDuEvRa1XJnO+9yIdEl7fMUv1/Z3mr89I/I5wesu70gyYs1+S4Hr/C0psqlfUX4/VVQ/S5V00sfHjmpm+hyF7qLwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727326409; c=relaxed/simple;
	bh=OXxaLigpzcXUhiiR7d9AIUjnWRdx8zAwA2BsWL8q4mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1wgOJ4ztodEU0OGbOODBCf504BlyqOqwWIwGCS9hJ/5mpjk2WT0gxnV/Wq/TUDrJvDV0X2VsdEcGzywHo1znnO7TyOZ0NHfl5bkviuAw8bnhVsJ9IwnBUYEl4soJdbo99jHRTC1WfLk+4VER+g3K0aSoNzkCAcYiDNruKP6I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E083C4CEC5;
	Thu, 26 Sep 2024 04:53:24 +0000 (UTC)
Date: Thu, 26 Sep 2024 00:53:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+83a876aef81c9a485ae8@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@linux.dev, mathieu.desnoyers@efficios.com,
 mattbobrowski@google.com, mhiramat@kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Subject: Re: [syzbot] [trace?] [bpf?] possible deadlock in __mod_timer (4)
Message-ID: <20240926005321.7c9d7efd@rorschach.local.home>
In-Reply-To: <66efbb95.050a0220.3195df.008d.GAE@google.com>
References: <66efbb95.050a0220.3195df.008d.GAE@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Sep 2024 23:39:17 -0700
syzbot <syzbot+83a876aef81c9a485ae8@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d1c69f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
> dashboard link: https://syzkaller.appspot.com/bug?extid=83a876aef81c9a485ae8
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11597677980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cd7500580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e9929bfe422c/vmlinux-a940d9a4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a6c74ee261ed/bzImage-a940d9a4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+83a876aef81c9a485ae8@syzkaller.appspotmail.com
> 
> FAULT_INJECTION: forcing a failure.
> name fail_usercopy, interval 1, probability 0, space 0, times 1
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.11.0-syzkaller-03917-ga940d9a43e62 #0 Not tainted
> ------------------------------------------------------
> syz-executor291/5332 is trying to acquire lock:
> ffffffff8dda88d8 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x12/0x70 kernel/locking/semaphore.c:139

I'm assuming that lockdep splats like this will no longer be an issue come 6.12?

-- Steve


> 
> but task is already holding lock:
> ffff88806a92a858 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x6c1/0xdc0 kernel/time/timer.c:1164
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (&base->lock){-.-.}-{2:2}:  
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        lock_timer_base+0x5d/0x220 kernel/time/timer.c:1051
>        __mod_timer+0x426/0xdc0 kernel/time/timer.c:1132
>        add_timer_global+0x8a/0xc0 kernel/time/timer.c:1330
>        __queue_delayed_work+0x1ba/0x2e0 kernel/workqueue.c:2525
>        queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2554
>        psi_task_change+0x1b4/0x2e0 kernel/sched/psi.c:913
>        psi_enqueue kernel/sched/stats.h:143 [inline]
>        enqueue_task+0x1a5/0x350 kernel/sched/core.c:1975
>        activate_task kernel/sched/core.c:2009 [inline]
>        wake_up_new_task+0x5ba/0xd30 kernel/sched/core.c:4689
>        kernel_clone+0x236/0x960 kernel/fork.c:2812
>        user_mode_thread+0xb4/0xf0 kernel/fork.c:2859
>        rest_init+0x23/0x2b0 init/main.c:712
>        start_kernel+0x3e4/0x4d0 init/main.c:1105
>        x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
>        x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
>        common_startup_64+0x13e/0x148
> 
> -> #2 (&rq->__lock){-.-.}-{2:2}:  
>        _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
>        raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:560
>        raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
>        rq_lock kernel/sched/sched.h:1714 [inline]
>        task_fork_fair+0x73/0x250 kernel/sched/fair.c:12710
>        sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4633
>        copy_process+0x439b/0x8dd0 kernel/fork.c:2483
>        kernel_clone+0xfd/0x960 kernel/fork.c:2781
>        user_mode_thread+0xb4/0xf0 kernel/fork.c:2859
>        rest_init+0x23/0x2b0 init/main.c:712
>        start_kernel+0x3e4/0x4d0 init/main.c:1105
>        x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
>        x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
>        common_startup_64+0x13e/0x148
> 
> -> #1 (&p->pi_lock){-.-.}-{2:2}:  
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
>        try_to_wake_up+0x9a/0x13e0 kernel/sched/core.c:4051
>        up+0x79/0xb0 kernel/locking/semaphore.c:191
>        __up_console_sem+0x85/0xe0 kernel/printk/printk.c:343
>        __console_unlock kernel/printk/printk.c:2844 [inline]
>        __console_flush_and_unlock kernel/printk/printk.c:3241 [inline]
>        console_unlock+0x1dc/0x210 kernel/printk/printk.c:3279
>        vga_remove_vgacon drivers/pci/vgaarb.c:186 [inline]
>        vga_remove_vgacon+0x90/0xd0 drivers/pci/vgaarb.c:167
>        __aperture_remove_legacy_vga_devices drivers/video/aperture.c:331 [inline]
>        aperture_remove_conflicting_pci_devices+0x16a/0x1e0 drivers/video/aperture.c:369
>        virtio_gpu_pci_quirk drivers/gpu/drm/virtio/virtgpu_drv.c:61 [inline]
>        virtio_gpu_probe+0x408/0x4e0 drivers/gpu/drm/virtio/virtgpu_drv.c:92
>        virtio_dev_probe+0x586/0x8a0 drivers/virtio/virtio.c:341
>        call_driver_probe drivers/base/dd.c:578 [inline]
>        really_probe+0x23e/0xa90 drivers/base/dd.c:657
>        __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
>        driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
>        __driver_attach+0x283/0x580 drivers/base/dd.c:1215
>        bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
>        bus_add_driver+0x2e9/0x690 drivers/base/bus.c:673
>        driver_register+0x15c/0x4b0 drivers/base/driver.c:246
>        do_one_initcall+0x128/0x700 init/main.c:1269
>        do_initcall_level init/main.c:1331 [inline]
>        do_initcalls init/main.c:1347 [inline]
>        do_basic_setup init/main.c:1366 [inline]
>        kernel_init_freeable+0x69d/0xca0 init/main.c:1580
>        kernel_init+0x1c/0x2b0 init/main.c:1469
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #0 ((console_sem).lock){-...}-{2:2}:  
>        check_prev_add kernel/locking/lockdep.c:3158 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3277 [inline]
>        validate_chain kernel/locking/lockdep.c:3901 [inline]
>        __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5199
>        lock_acquire kernel/locking/lockdep.c:5822 [inline]
>        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5787
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
>        __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:326
>        console_trylock kernel/printk/printk.c:2827 [inline]
>        console_trylock_spinning kernel/printk/printk.c:1990 [inline]
>        vprintk_emit+0x3ec/0x6f0 kernel/printk/printk.c:2406
>        vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
>        _printk+0xc8/0x100 kernel/printk/printk.c:2432
>        fail_dump lib/fault-inject.c:45 [inline]
>        should_fail_ex+0x46c/0x5b0 lib/fault-inject.c:153
>        strncpy_from_user+0x38/0x320 lib/strncpy_from_user.c:118
>        strncpy_from_user_nofault+0x7f/0x180 mm/maccess.c:186
>        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
>        ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
>        bpf_probe_read_compat_str+0xf1/0x170 kernel/trace/bpf_trace.c:307
>        bpf_prog_d0e9ac47b081aec3+0x48/0x4a
>        bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>        __bpf_prog_run include/linux/filter.h:691 [inline]
>        bpf_prog_run include/linux/filter.h:698 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
>        bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
>        __bpf_trace_timer_start+0xc7/0x100 include/trace/events/timer.h:52
>        trace_timer_start include/trace/events/timer.h:52 [inline]
>        enqueue_timer+0x2b4/0x550 kernel/time/timer.c:663
>        internal_add_timer kernel/time/timer.c:688 [inline]
>        __mod_timer+0x8d7/0xdc0 kernel/time/timer.c:1183
>        add_timer_global+0x8a/0xc0 kernel/time/timer.c:1330
>        __queue_delayed_work+0x1ba/0x2e0 kernel/workqueue.c:2525
>        queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2554
>        queue_delayed_work include/linux/workqueue.h:636 [inline]
>        fbcon_add_cursor_work drivers/video/fbdev/core/fbcon.c:392 [inline]
>        fbcon_cursor+0x4a0/0x520 drivers/video/fbdev/core/fbcon.c:1316
>        hide_cursor+0x84/0x220 drivers/tty/vt/vt.c:846
>        do_con_write+0x21e6/0x7bb0 drivers/tty/vt/vt.c:3068
>        con_write+0x23/0xb0 drivers/tty/vt/vt.c:3434
>        process_output_block drivers/tty/n_tty.c:574 [inline]
>        n_tty_write+0x419/0x1140 drivers/tty/n_tty.c:2389
>        iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
>        file_tty_write.constprop.0+0x506/0x9a0 drivers/tty/tty_io.c:1096
>        new_sync_write fs/read_write.c:590 [inline]
>        vfs_write+0x6b5/0x1140 fs/read_write.c:683
>        ksys_write+0x12f/0x260 fs/read_write.c:736
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   (console_sem).lock --> &rq->__lock --> &base->lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&base->lock);
>                                lock(&rq->__lock);
>                                lock(&base->lock);
>   lock((console_sem).lock);
> 
>  *** DEADLOCK ***
> 
> 7 locks held by syz-executor291/5332:
>  #0: ffff8880353610a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffff888035361130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: tty_write_lock drivers/tty/tty_io.c:954 [inline]
>  #1: ffff888035361130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: iterate_tty_write drivers/tty/tty_io.c:973 [inline]
>  #1: ffff888035361130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: file_tty_write.constprop.0+0x281/0x9a0 drivers/tty/tty_io.c:1096
>  #2: ffff8880353612e8 (&tty->termios_rwsem){++++}-{3:3}, at: n_tty_write+0x1bd/0x1140 drivers/tty/n_tty.c:2372
>  #3: ffffc9000324e380 (&ldata->output_lock){+.+.}-{3:3}, at: process_output_block drivers/tty/n_tty.c:529 [inline]
>  #3: ffffc9000324e380 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_write+0x533/0x1140 drivers/tty/n_tty.c:2389
>  #4: ffffffff8dda8460 (console_lock){+.+.}-{0:0}, at: do_con_write+0x154/0x7bb0 drivers/tty/vt/vt.c:3056
>  #5: ffff88806a92a858 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x6c1/0xdc0 kernel/time/timer.c:1164
>  #6: ffffffff8ddbaea0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
>  #6: ffffffff8ddbaea0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
>  #6: ffffffff8ddbaea0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2405 [inline]
>  #6: ffffffff8ddbaea0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1c2/0x590 kernel/trace/bpf_trace.c:2447
> 
> stack backtrace:
> CPU: 3 UID: 0 PID: 5332 Comm: syz-executor291 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2203
>  check_prev_add kernel/locking/lockdep.c:3158 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3277 [inline]
>  validate_chain kernel/locking/lockdep.c:3901 [inline]
>  __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5199
>  lock_acquire kernel/locking/lockdep.c:5822 [inline]
>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5787
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>  down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
>  __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:326
>  console_trylock kernel/printk/printk.c:2827 [inline]
>  console_trylock_spinning kernel/printk/printk.c:1990 [inline]
>  vprintk_emit+0x3ec/0x6f0 kernel/printk/printk.c:2406
>  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
>  _printk+0xc8/0x100 kernel/printk/printk.c:2432
>  fail_dump lib/fault-inject.c:45 [inline]
>  should_fail_ex+0x46c/0x5b0 lib/fault-inject.c:153
>  strncpy_from_user+0x38/0x320 lib/strncpy_from_user.c:118
>  strncpy_from_user_nofault+0x7f/0x180 mm/maccess.c:186
>  bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
>  ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
>  bpf_probe_read_compat_str+0xf1/0x170 kernel/trace/bpf_trace.c:307
>  bpf_prog_d0e9ac47b081aec3+0x48/0x4a
>  bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>  __bpf_prog_run include/linux/filter.h:691 [inline]
>  bpf_prog_run include/linux/filter.h:698 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
>  bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
>  __bpf_trace_timer_start+0xc7/0x100 include/trace/events/timer.h:52
>  trace_timer_start include/trace/events/timer.h:52 [inline]
>  enqueue_timer+0x2b4/0x550 kernel/time/timer.c:663
>  internal_add_timer kernel/time/timer.c:688 [inline]
>  __mod_timer+0x8d7/0xdc0 kernel/time/timer.c:1183
>  add_timer_global+0x8a/0xc0 kernel/time/timer.c:1330
>  __queue_delayed_work+0x1ba/0x2e0 kernel/workqueue.c:2525
>  queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2554
>  queue_delayed_work include/linux/workqueue.h:636 [inline]
>  fbcon_add_cursor_work drivers/video/fbdev/core/fbcon.c:392 [inline]
>  fbcon_cursor+0x4a0/0x520 drivers/video/fbdev/core/fbcon.c:1316
>  hide_cursor+0x84/0x220 drivers/tty/vt/vt.c:846
>  do_con_write+0x21e6/0x7bb0 drivers/tty/vt/vt.c:3068
>  con_write+0x23/0xb0 drivers/tty/vt/vt.c:3434
>  process_output_block drivers/tty/n_tty.c:574 [inline]
>  n_tty_write+0x419/0x1140 drivers/tty/n_tty.c:2389
>  iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
>  file_tty_write.constprop.0+0x506/0x9a0 drivers/tty/tty_io.c:1096
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0x6b5/0x1140 fs/read_write.c:683
>  ksys_write+0x12f/0x260 fs/read_write.c:736
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f36b5809869
> Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeb8b42888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffeb8b42890 RCX: 00007f36b5809869
> RDX: 0000000000001006 RSI: 0000000020001040 RDI: 0000000000000006
> RBP: 0000000000000001 R08: 00007ffeb8b42627 R09: 00007f36b5870033
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffeb8b42a68 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> CPU: 3 UID: 0 PID: 5332 Comm: syz-executor291 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  fail_dump lib/fault-inject.c:52 [inline]
>  should_fail_ex+0x497/0x5b0 lib/fault-inject.c:153
>  strncpy_from_user+0x38/0x320 lib/strncpy_from_user.c:118
>  strncpy_from_user_nofault+0x7f/0x180 mm/maccess.c:186
>  bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
>  ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
>  bpf_probe_read_compat_str+0xf1/0x170 kernel/trace/bpf_trace.c:307
>  bpf_prog_d0e9ac47b081aec3+0x48/0x4a
>  bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>  __bpf_prog_run include/linux/filter.h:691 [inline]
>  bpf_prog_run include/linux/filter.h:698 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
>  bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
>  __bpf_trace_timer_start+0xc7/0x100 include/trace/events/timer.h:52
>  trace_timer_start include/trace/events/timer.h:52 [inline]
>  enqueue_timer+0x2b4/0x550 kernel/time/timer.c:663
>  internal_add_timer kernel/time/timer.c:688 [inline]
>  __mod_timer+0x8d7/0xdc0 kernel/time/timer.c:1183
>  add_timer_global+0x8a/0xc0 kernel/time/timer.c:1330
>  __queue_delayed_work+0x1ba/0x2e0 kernel/workqueue.c:2525
>  queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2554
>  queue_delayed_work include/linux/workqueue.h:636 [inline]
>  fbcon_add_cursor_work drivers/video/fbdev/core/fbcon.c:392 [inline]
>  fbcon_cursor+0x4a0/0x520 drivers/video/fbdev/core/fbcon.c:1316
>  hide_cursor+0x84/0x220 drivers/tty/vt/vt.c:846
>  do_con_write+0x21e6/0x7bb0 drivers/tty/vt/vt.c:3068
>  con_write+0x23/0xb0 drivers/tty/vt/vt.c:3434
>  process_output_block drivers/tty/n_tty.c:574 [inline]
>  n_tty_write+0x419/0x1140 drivers/tty/n_tty.c:2389
>  iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
>  file_tty_write.constprop.0+0x506/0x9a0 drivers/tty/tty_io.c:1096
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0x6b5/0x1140 fs/read_write.c:683
>  ksys_write+0x12f/0x260 fs/read_write.c:736
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f36b5809869
> Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeb8b42888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffeb8b42890 RCX: 00007f36b5809869
> RDX: 0000000000001006 RSI: 0000000020001040 RDI: 0000000000000006
> RBP: 0000000000000001 R08: 00007ffeb8b42627 R09: 00007f36b5870033
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffeb8b42a68 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
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


