Return-Path: <bpf+bounces-17475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4DE80E0A0
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED601C2169B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558FEA8;
	Tue, 12 Dec 2023 01:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02787CD
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 17:01:32 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb0a385ab8so10802429fac.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 17:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342891; x=1702947691;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y+IyuudeUdWEkGWtHnVfhHs+Gy/ff+4wjVS1hBzJOY=;
        b=Z1FE7tR73l6jcJWcMIhs8B8PDB0TIDwZtlsnAJQNo4aV9zK2WVGPX8vG4ky9bvnnqj
         PifLTmgH4hoBdxgtolsvNA68xkTro1hEW51GvMpARhgxbV2J/ezpMXdLhtCs2/OJc1U9
         Nudw6vEirhD9X6UVHAqdKQZasBZ7hWeHmuKqG9nsU+M0P3hIFpPFi1uHfRH3+cPJkQDU
         73wOCQGyuK8KhaxAZ+dLjhaYNswOrX1AdyTIRSraHzPL1wazKtzzL+JtvFr4GEVbahDS
         1N4d1WZWlV1ygAcb2BplmPV8zZ6b3ZrEI/TF+gE70sK50MOgDUYB9BGNQnaaZ0kKuOta
         GM6g==
X-Gm-Message-State: AOJu0YxeHQpsshprWwVepKcbEPqi0E1bKvIPVw7uOLqTzupBhpLVpRKo
	yGVo+cH8KHlt18+/fhUPNmW9hKSIBRzZXfheAZz8TAjcXVgR
X-Google-Smtp-Source: AGHT+IHs0ypLgrc6PpfCj9y3vldUwemZsczbLp5pAZ0lq4t+6eKxR2ty8SNiXpC3OI6BiIl4sjTuoXLYfBLWUcWAtA1Pn6iDboBP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:648f:b0:1fb:44:aef1 with SMTP id
 cz15-20020a056870648f00b001fb0044aef1mr5625247oab.7.1702342891316; Mon, 11
 Dec 2023 17:01:31 -0800 (PST)
Date: Mon, 11 Dec 2023 17:01:31 -0800
In-Reply-To: <000000000000e7765006072e9591@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052ab03060c459780@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
From: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2ebe81c81435 net, xdp: Allow metadata > 32
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16687bdee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b2632e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aae88ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/972e21c08639/disk-2ebe81c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c55f0d0739c1/vmlinux-2ebe81c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4aa04cd001b3/bzImage-2ebe81c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 1
======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc3-syzkaller-00778-g2ebe81c81435 #0 Not tainted
------------------------------------------------------
syz-executor229/5088 is trying to acquire lock:
ffffffff8ceb8da0 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1962 [inline]
ffffffff8ceb8da0 (console_owner){....}-{0:0}, at: vprintk_emit+0x313/0x5f0 kernel/printk/printk.c:2302

but task is already holding lock:
ffff8880b983c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1349 [inline]
       rq_lock kernel/sched/sched.h:1663 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12586
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4812
       copy_process+0x4c86/0x73f0 kernel/fork.c:2609
       kernel_clone+0xfd/0x930 kernel/fork.c:2907
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2985
       rest_init+0x27/0x2b0 init/main.c:695
       arch_call_rest_init+0x13/0x30 init/main.c:827
       start_kernel+0x39f/0x480 init/main.c:1072
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
       secondary_startup_64_no_verify+0x166/0x16b

-> #4 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xb0/0x13d0 kernel/sched/core.c:4226
       kick_pool+0x253/0x470 kernel/workqueue.c:1142
       create_worker+0x46f/0x730 kernel/workqueue.c:2217
       workqueue_init+0x319/0x830 kernel/workqueue.c:6698
       kernel_init_freeable+0x332/0xc10 init/main.c:1536
       kernel_init+0x1c/0x2a0 init/main.c:1441
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x399/0x11f0 kernel/workqueue.c:1763
       queue_work_on+0xed/0x110 kernel/workqueue.c:1834
       queue_work include/linux/workqueue.h:562 [inline]
       rpm_suspend+0x121b/0x16f0 drivers/base/power/runtime.c:660
       rpm_idle+0x578/0x6e0 drivers/base/power/runtime.c:534
       __pm_runtime_idle+0xbe/0x160 drivers/base/power/runtime.c:1102
       pm_runtime_put include/linux/pm_runtime.h:460 [inline]
       __device_attach+0x382/0x4b0 drivers/base/dd.c:1048
       bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
       device_add+0x117e/0x1aa0 drivers/base/core.c:3625
       serial_base_port_add+0x353/0x4b0 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3316 [inline]
       serial_core_register_port+0x137/0x1af0 drivers/tty/serial/serial_core.c:3357
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
       do_one_initcall+0x11c/0x650 init/main.c:1236
       do_initcall_level init/main.c:1298 [inline]
       do_initcalls init/main.c:1314 [inline]
       do_basic_setup init/main.c:1333 [inline]
       kernel_init_freeable+0x687/0xc10 init/main.c:1551
       kernel_init+0x1c/0x2a0 init/main.c:1441
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #2 (&dev->power.lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0xab/0x170 drivers/base/power/runtime.c:1169
       pm_runtime_get include/linux/pm_runtime.h:408 [inline]
       __uart_start+0x1b2/0x470 drivers/tty/serial/serial_core.c:148
       uart_write+0x2ff/0x5b0 drivers/tty/serial/serial_core.c:616
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0x422/0x1130 drivers/tty/n_tty.c:2379
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write.constprop.0+0x519/0x9b0 drivers/tty/tty_io.c:1092
       tty_write drivers/tty/tty_io.c:1113 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1136 [inline]
       redirected_tty_write+0xa6/0xc0 drivers/tty/tty_io.c:1116
       call_write_iter include/linux/fs.h:2020 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x64f/0xdf0 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (&port_lock_key){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
       serial8250_console_write+0xa7c/0x1060 drivers/tty/serial/8250/8250_port.c:3403
       console_emit_next_record kernel/printk/printk.c:2901 [inline]
       console_flush_all+0x4d5/0xd60 kernel/printk/printk.c:2967
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2328
       register_console+0xa74/0x1060 kernel/printk/printk.c:3542
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0xba/0x5d0 kernel/printk/printk.c:3688
       start_kernel+0x25a/0x480 init/main.c:1008
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
       secondary_startup_64_no_verify+0x166/0x16b

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2433/0x3b20 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
       console_trylock_spinning kernel/printk/printk.c:1962 [inline]
       vprintk_emit+0x328/0x5f0 kernel/printk/printk.c:2302
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2328
       fail_dump lib/fault-inject.c:45 [inline]
       should_fail_ex+0x46b/0x5b0 lib/fault-inject.c:153
       strncpy_from_user+0x38/0x300 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x80/0x180 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:213 [inline]
       ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:222 [inline]
       bpf_probe_read_user_str+0x26/0x70 kernel/trace/bpf_trace.c:219
       bpf_prog_6fb7ada547f278f2+0x3d/0x3f
       bpf_dispatcher_nop_func include/linux/bpf.h:1219 [inline]
       __bpf_prog_run include/linux/filter.h:651 [inline]
       bpf_prog_run include/linux/filter.h:658 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2378 [inline]
       bpf_trace_run4+0x173/0x450 kernel/trace/bpf_trace.c:2419
       __bpf_trace_sched_switch+0x13e/0x180 include/trace/events/sched.h:222
       __traceiter_sched_switch+0x6c/0xc0 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x21f3/0x5af0 kernel/sched/core.c:6685
       __schedule_loop kernel/sched/core.c:6763 [inline]
       schedule+0xe9/0x270 kernel/sched/core.c:6778
       ptrace_stop.part.0+0x44d/0x7a0 kernel/signal.c:2353
       ptrace_stop kernel/signal.c:2255 [inline]
       ptrace_do_notify+0x22f/0x2e0 kernel/signal.c:2390
       ptrace_notify+0xc8/0x130 kernel/signal.c:2402
       ptrace_report_syscall include/linux/ptrace.h:411 [inline]
       ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
       syscall_exit_work kernel/entry/common.c:251 [inline]
       syscall_exit_to_user_mode_prepare+0x126/0x230 kernel/entry/common.c:278
       __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
       syscall_exit_to_user_mode+0xe/0x60 kernel/entry/common.c:296
       do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:88
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

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

2 locks held by syz-executor229/5088:
 #0: ffff8880b983c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #1: ffffffff8cfabbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #1: ffffffff8cfabbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #1: ffffffff8cfabbe0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2377 [inline]
 #1: ffffffff8cfabbe0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x107/0x450 kernel/trace/bpf_trace.c:2419

stack backtrace:
CPU: 0 PID: 5088 Comm: syz-executor229 Not tainted 6.7.0-rc3-syzkaller-00778-g2ebe81c81435 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x317/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2433/0x3b20 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 console_trylock_spinning kernel/printk/printk.c:1962 [inline]
 vprintk_emit+0x328/0x5f0 kernel/printk/printk.c:2302
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail_ex+0x46b/0x5b0 lib/fault-inject.c:153
 strncpy_from_user+0x38/0x300 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x80/0x180 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:213 [inline]
 ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:222 [inline]
 bpf_probe_read_user_str+0x26/0x70 kernel/trace/bpf_trace.c:219
 bpf_prog_6fb7ada547f278f2+0x3d/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1219 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2378 [inline]
 bpf_trace_run4+0x173/0x450 kernel/trace/bpf_trace.c:2419
 __bpf_trace_sched_switch+0x13e/0x180 include/trace/events/sched.h:222
 __traceiter_sched_switch+0x6c/0xc0 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x21f3/0x5af0 kernel/sched/core.c:6685
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 ptrace_stop.part.0+0x44d/0x7a0 kernel/signal.c:2353
 ptrace_stop kernel/signal.c:2255 [inline]
 ptrace_do_notify+0x22f/0x2e0 kernel/signal.c:2390
 ptrace_notify+0xc8/0x130 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x126/0x230 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xe/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fc3b1ed34f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdaa3d0328 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 00000000000000d8 RBX: 0000000000000000 RCX: 00007fc3b1ed34f9
RDX: 0000000000000000 RSI: 0000000020000940 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdaa3d00c6 R09: 00000000557624c0
R10: 0000000000000002 R11: 0000000000000246 R12: 00000000200000d8
R13: 00007ffdaa3d0334 R14: 0000000000000000 R15: 00007ffdaa3d0350
 </TASK>
CPU: 0 PID: 5088 Comm: syz-executor229 Not tainted 6.7.0-rc3-syzkaller-00778-g2ebe81c81435 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x496/0x5b0 lib/fault-inject.c:153
 strncpy_from_user+0x38/0x300 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x80/0x180 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:213 [inline]
 ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:222 [inline]
 bpf_probe_read_user_str+0x26/0x70 kernel/trace/bpf_trace.c:219
 bpf_prog_6fb7ada547f278f2+0x3d/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1219 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2378 [inline]
 bpf_trace_run4+0x173/0x450 kernel/trace/bpf_trace.c:2419
 __bpf_trace_sched_switch+0x13e/0x180 include/trace/events/sched.h:222
 __traceiter_sched_switch+0x6c/0xc0 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x21f3/0x5af0 kernel/sched/core.c:6685
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 ptrace_stop.part.0+0x44d/0x7a0 kernel/signal.c:2353
 ptrace_stop kernel/signal.c:2255 [inline]
 ptrace_do_notify+0x22f/0x2e0 kernel/signal.c:2390
 ptrace_notify+0xc8/0x130 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x126/0x230 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xe/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fc3b1ed34f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdaa3d0328 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 00000000000000d8 RBX: 0000000000000000 RCX: 00007fc3b1ed34f9
RDX: 0000000000000000 RSI: 0000000020000940 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdaa3d00c6 R09: 00000000557624c0
R10: 0000000000000002 R11: 0000000000000246 R12: 00000000200000d8
R13: 00007ffdaa3d0334 R14: 0000000000000000 R15: 00007ffdaa3d0350
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

