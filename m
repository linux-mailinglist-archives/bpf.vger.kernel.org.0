Return-Path: <bpf+bounces-26883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DEF8A61AD
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 05:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C49F1F23E63
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31DB1B5A4;
	Tue, 16 Apr 2024 03:25:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81591862C
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237920; cv=none; b=pTOd2dxPnrYFB3znxRWL1Lfr8oaZzcL3NzHtJMvii630/LCOarT2bycR46fCGtUb+MpsgCa5hssH4S8PF7OLzJkfSOAcZ6QDICKCgql/MDUqcwDB8Bxa2Tt0WN33HcQPSiTo3dwQT73JrKXQOKzApwxDEKpPxcAO2S/cu/vJ4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237920; c=relaxed/simple;
	bh=e0fPl3xJcqFbn2lpuBPHmo9pzWZXCNNwfplIn+h1K88=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ca7zzW9ZLtynE8dXTJ4i/gJUuRVH028Y81H8q3IPq8w/lJqyJCgcWoPkZ7gOmZ6XZO/z4DukuzOYy2Rk92la31OjZ706+4PTjcR/IvB/jg83lFDivS+dd7yNHlrzfEJ5CFmRwj+n70bssAkVEfY8PTGlo9SJdIEaCaeChzJnCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d80e95d4d4so332747039f.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 20:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237918; x=1713842718;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ+3RifsU1alib3+R6DZgejq+BBQ63vMuRK4Rkdz2Yk=;
        b=aB1DbmLjBUZ09xKMWNayTnTc8hCeTA7uUAjA7VyGvCwAB/8cVckC9qyB2wDQv1xWme
         lRUuENUOlPmWNZasNEQwkJM3gkLoYCVvRf3bjmAjj7tPONWrY+9pRqjzwAWVvrsOVZVW
         vH4qnhGqkSVvJtkAcrC0KmLyNXumwCNRYkg4YVmGI61WF6NCIogZUR1AZTmrvj/MHWEi
         A6O33I+TbSMo1JD3Mcj0sSquBrwGRZbZi08AF3C/5HHLyaG32iGqbZOe6qSeUw0FzK4V
         qZTQ0z9D70Zi6MHd23+VB0tKMKu6VV4zqQ2iJYD5COHoxriyzQSSGh6xyUUIk2pXFbMV
         R+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUiA4+20qfLGjcm3on4SINHSjGwCYVssAtcCAkEm+37rwoaYE2ltXXwJz0NnDN/0qnITXE8xmRRih+x2Z9ToVpou+r
X-Gm-Message-State: AOJu0YyvB2te9EZ7lYQw1epqstDpWfTSeMjWLH4XRb/HOtzFNiXIoSp+
	piwBOPi8Kx3SzAtT9KpinVri9Hy5pv+/zIZa00N/bgLwocbrckf51k8yAx5xAX065Jv+3nG4MVz
	GVmAz640rUCJ9aJde8txp19s7UUD8aLr2baibnFz63Tl6dQRNKUG9nzo=
X-Google-Smtp-Source: AGHT+IFbl+/lw1mKQFAufaEdejutT+cHS0iZG2mcIW7bbCEDWAirDuoSTJ2NjPuATr01r1BAK65iSOptY6onhGTjQJTKgu1ZY19K
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c567:0:b0:369:ecb6:8d65 with SMTP id
 b7-20020a92c567000000b00369ecb68d65mr567859ilj.6.1713237917843; Mon, 15 Apr
 2024 20:25:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 20:25:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082553906162e498a@google.com>
Subject: [syzbot] [bpf?] [trace?] possible deadlock in put_pwq_unlocked
From: syzbot <syzbot+fdf23a9c5eeb473d9c87@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16fbaf7b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=fdf23a9c5eeb473d9c87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fdf23a9c5eeb473d9c87@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.0/5198 is trying to acquire lock:
ffffffff8e126300 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1997 [inline]
ffffffff8e126300 (console_owner){....}-{0:0}, at: vprintk_emit+0x3d6/0x770 kernel/printk/printk.c:2341

but task is already holding lock:
ffff888016ee8120 ((worker)->lock){....}-{2:2}, at: kthread_queue_work+0x27/0x180 kernel/kthread.c:1019

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 ((worker)->lock){....}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
       put_pwq kernel/workqueue.c:1642 [inline]
       put_pwq_unlocked+0x12a/0x190 kernel/workqueue.c:1659
       apply_wqattrs_cleanup kernel/workqueue.c:5098 [inline]
       apply_workqueue_attrs_locked+0x132/0x210 kernel/workqueue.c:5219
       apply_workqueue_attrs+0x30/0x50 kernel/workqueue.c:5249
       padata_setup_cpumasks kernel/padata.c:435 [inline]
       padata_alloc+0x22b/0x370 kernel/padata.c:1014
       pcrypt_init_padata+0x27/0x100 crypto/pcrypt.c:327
       pcrypt_init+0x65/0xe0 crypto/pcrypt.c:352
       do_one_initcall+0x23a/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1550
       kernel_init+0x1d/0x2a0 init/main.c:1439
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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
       pnp_device_probe+0x2bc/0x460 drivers/pnp/driver.c:111
       really_probe+0x2a0/0xc50 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x23b/0x2b0 drivers/base/bus.c:368
       bus_add_driver+0x347/0x620 drivers/base/bus.c:673
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       serial8250_init+0x9e/0x170 drivers/tty/serial/8250/8250_core.c:1239
       do_one_initcall+0x23a/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1550
       kernel_init+0x1d/0x2a0 init/main.c:1439
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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
       n_tty_write+0xd6c/0x1230 drivers/tty/n_tty.c:2379
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x551/0x9b0 drivers/tty/tty_io.c:1096
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa86/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfd/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&port_lock_key){-...}-{2:2}:
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
       bpf_prog_d247abf228e51871+0x69/0x71
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x206/0x420 kernel/trace/bpf_trace.c:2420
       trace_sched_kthread_work_queue_work include/trace/events/sched.h:64 [inline]
       kthread_insert_work+0x3f4/0x460 kernel/kthread.c:993
       kthread_queue_work+0xff/0x180 kernel/kthread.c:1021
       synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:469 [inline]
       synchronize_rcu_expedited+0x593/0x820 kernel/rcu/tree_exp.h:949
       packet_release+0x9ef/0xcc0 net/packet/af_packet.c:3169
       __sock_release net/socket.c:659 [inline]
       sock_close+0xbe/0x240 net/socket.c:1421
       __fput+0x42b/0x8a0 fs/file_table.c:422
       __do_sys_close fs/open.c:1556 [inline]
       __se_sys_close fs/open.c:1541 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1541
       do_syscall_64+0xfd/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  console_owner --> &pool->lock --> (worker)->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((worker)->lock);
                               lock(&pool->lock);
                               lock((worker)->lock);
  lock(console_owner);

 *** DEADLOCK ***

4 locks held by syz-executor.0/5198:
 #0: ffff88805d645610 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #0: ffff88805d645610 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:658 [inline]
 #0: ffff88805d645610 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x90/0x240 net/socket.c:1421
 #1: ffffffff8e1373b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #1: ffffffff8e1373b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x39a/0x820 kernel/rcu/tree_exp.h:939
 #2: ffff888016ee8120 ((worker)->lock){....}-{2:2}, at: kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 1 PID: 5198 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b3 da 25 0a 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 9c 6d 87 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90004c9f820 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000993f08 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff896400ba
RBP: ffffc90004c9f8e0 R08: ffff888079a849eb R09: 1ffff1100f35093d
R10: dffffc0000000000 R11: ffffed100f35093e R12: dffffc0000000000
R13: ffff88802acd8000 R14: ffffc90004c9f860 R15: 0000000000000201
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
 bpf_prog_d247abf228e51871+0x69/0x71
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x206/0x420 kernel/trace/bpf_trace.c:2420
 trace_sched_kthread_work_queue_work include/trace/events/sched.h:64 [inline]
 kthread_insert_work+0x3f4/0x460 kernel/kthread.c:993
 kthread_queue_work+0xff/0x180 kernel/kthread.c:1021
 synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:469 [inline]
 synchronize_rcu_expedited+0x593/0x820 kernel/rcu/tree_exp.h:949
 packet_release+0x9ef/0xcc0 net/packet/af_packet.c:3169
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbe/0x240 net/socket.c:1421
 __fput+0x42b/0x8a0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f28fea7cd5a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe26978220 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f28fea7cd5a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000032 R08: 0000001b31020000 R09: 0000000000000018
R10: 000000008136099b R11: 0000000000000293 R12: 00007f28fe6046d0
R13: ffffffffffffffff R14: 00007f28fe600000 R15: 0000000000014e95
 </TASK>
WARNING: CPU: 1 PID: 5198 at kernel/softirq.c:362 __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Modules linked in:
CPU: 1 PID: 5198 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b3 da 25 0a 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 9c 6d 87 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90004c9f820 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000993f08 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff896400ba
RBP: ffffc90004c9f8e0 R08: ffff888079a849eb R09: 1ffff1100f35093d
R10: dffffc0000000000 R11: ffffed100f35093e R12: dffffc0000000000
R13: ffff88802acd8000 R14: ffffc90004c9f860 R15: 0000000000000201
FS:  000055556c542480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000004 CR3: 000000007d7a8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
 bpf_prog_d247abf228e51871+0x69/0x71
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x206/0x420 kernel/trace/bpf_trace.c:2420
 trace_sched_kthread_work_queue_work include/trace/events/sched.h:64 [inline]
 kthread_insert_work+0x3f4/0x460 kernel/kthread.c:993
 kthread_queue_work+0xff/0x180 kernel/kthread.c:1021
 synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:469 [inline]
 synchronize_rcu_expedited+0x593/0x820 kernel/rcu/tree_exp.h:949
 packet_release+0x9ef/0xcc0 net/packet/af_packet.c:3169
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbe/0x240 net/socket.c:1421
 __fput+0x42b/0x8a0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f28fea7cd5a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe26978220 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f28fea7cd5a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000032 R08: 0000001b31020000 R09: 0000000000000018
R10: 000000008136099b R11: 0000000000000293 R12: 00007f28fe6046d0
R13: ffffffffffffffff R14: 00007f28fe600000 R15: 0000000000014e95
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

