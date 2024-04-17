Return-Path: <bpf+bounces-27033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF88A8014
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03548282B12
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136D13AA2C;
	Wed, 17 Apr 2024 09:47:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908413440B
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347242; cv=none; b=ovuC82DeJk6ltu/p8lI4wHVTNRj6oP0ViMv2L2gpXsu3AQDFzMr2IiJlWQrQ0SRf1Q6bjryms4rDCTw7CLGEz1FmaIoOCMiM7tsSqmp82/i7AMQgtht3fc1BIpDquBaQ44kV1W12n1QDW+lgGuvzE60Os3RjGMJ+NpXpItFmkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347242; c=relaxed/simple;
	bh=H1kSTITm9Nr16eIMTgiZuze+axHDcvVmad0OKfmCM90=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ah9WV2UDavJGqmYrMwRsc4xchmJwpranNe/2To+txlLMU9AGqVWaZgvFlsLk9wvheI3qMILuMlks6psE1ts5D5Fumx3zI9dqEcDKPSk3GrSx1hwIjcbFHOxq6qgGNXJEzSCSpNaYUjPbwKTD3EA8G4tFBG/nC5kPfW9/2RPyFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso164160939f.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 02:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713347240; x=1713952040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiDd+kXH+Cj51BIsV6pHfTEfpKsHr45XJoqpvB13TaE=;
        b=FifQqZdwRPMcX448XVKWLwSf8Q5ezvXLBUJb/WHN2lxlEc4m0Ns0Iu63cxcPMNwcGy
         lCy355eW3SDX0IuBOwrhpGn/oNHUv3tigxuFS28SUN719vbXTQMBXtgd0HKMFe66/UhL
         R9k5jkvCOtjtsxnyRoDC05fzmqkuOq+OjwdussNA6s9zIOe24EZSFMVxYZKwYMHf4nJ8
         BkH3pl/+h53PCsFjAJszn/ki2NP+tGuAYaLW+y2TZzR4RH/ghYuI6UqL32Z5r5fnKpW7
         1L90MSWKwsQDlGm39kXijMwmaK3acV6GEHRLmHJpckP5F0LpyO2v0fW7Qe+hPGI/WWn5
         HRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaZmJKGlOjLrONaqGX+FFsNCU/MWCduWn3ggswp1JhkKNt1RqRPgvPAVyYMBH2b2t+fn1k0Ixa/kO+6/RiwdH8G5Bt
X-Gm-Message-State: AOJu0YytQANkhHt7CbV4YiT+F61BTT8Fi+zRipSPlibnL2o0/jL7LsdT
	tk5cT2fmHDDXuFDEsMCgSmNvcSFdX4i1rGHSqAgnYDNg6jGh1U/KbBlX/lZfTipaVXcGX4ekVa4
	7vDaNjUoB4DiD9U+iMEUbwl+KU4yC5LrmVzaomAOG/8SNSWXTiVBAmdw=
X-Google-Smtp-Source: AGHT+IFQqTZn2ihU3vI9xi2nIagZdslebwhIF5ml68kmnD4sfN6aAguFLX5w9t/Qi9pFNmR8FImkh9XC+byV+RqOCIa95mlKtzy7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8929:b0:482:c7c8:5019 with SMTP id
 jc41-20020a056638892900b00482c7c85019mr927316jab.0.1713347240339; Wed, 17 Apr
 2024 02:47:20 -0700 (PDT)
Date: Wed, 17 Apr 2024 02:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a33584061647bdef@google.com>
Subject: [syzbot] [bpf?] [trace?] possible deadlock in __send_signal_locked
From: syzbot <syzbot+6e3b6eab5bd4ed584a38@syzkaller.appspotmail.com>
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

HEAD commit:    96fca68c4fbf Merge tag 'nfsd-6.9-3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13967bb3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=6e3b6eab5bd4ed584a38
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-96fca68c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6d7a71ca443/vmlinux-96fca68c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/accb76ce6c9c/bzImage-96fca68c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e3b6eab5bd4ed584a38@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-syzkaller-00031-g96fca68c4fbf #0 Not tainted
------------------------------------------------------
syz-executor.0/7699 is trying to acquire lock:
ffff88806b53d998 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x23a/0x1020 kernel/workqueue.c:2346

but task is already holding lock:
ffff888023446620 (&sighand->signalfd_wqh){....}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:105 [inline]
ffff888023446620 (&sighand->signalfd_wqh){....}-{2:2}, at: __wake_up+0x1c/0x60 kernel/sched/wait.c:127

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sighand->signalfd_wqh){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:105 [inline]
       __wake_up+0x1c/0x60 kernel/sched/wait.c:127
       signalfd_notify include/linux/signalfd.h:22 [inline]
       __send_signal_locked+0x951/0x11c0 kernel/signal.c:1168
       do_notify_parent+0xeb4/0x1040 kernel/signal.c:2143
       exit_notify kernel/exit.c:754 [inline]
       do_exit+0x1369/0x2c10 kernel/exit.c:898
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
       __do_sys_exit_group kernel/exit.c:1038 [inline]
       __se_sys_exit_group kernel/exit.c:1036 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sighand->siglock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __lock_task_sighand+0xc2/0x340 kernel/signal.c:1414
       lock_task_sighand include/linux/sched/signal.h:746 [inline]
       do_send_sig_info kernel/signal.c:1300 [inline]
       group_send_sig_info+0x290/0x300 kernel/signal.c:1453
       bpf_send_signal_common+0x2e8/0x3a0 kernel/trace/bpf_trace.c:881
       ____bpf_send_signal_thread kernel/trace/bpf_trace.c:898 [inline]
       bpf_send_signal_thread+0x16/0x20 kernel/trace/bpf_trace.c:896
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
       __bpf_trace_mmap_lock_acquire_returned+0x134/0x180 include/trace/events/mmap_lock.h:52
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x456/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_write_lock include/linux/mmap_lock.h:109 [inline]
       __do_sys_set_mempolicy_home_node+0x574/0x860 mm/mempolicy.c:1568
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (lock#11){+.+.}-{2:2}:
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0x97/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x5df/0x7d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x6bf/0x700 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
       bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1975
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
       __bpf_trace_workqueue_queue_work+0x101/0x140 include/trace/events/workqueue.h:23
       trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline]
       __queue_work+0x627/0x1020 kernel/workqueue.c:2382
       queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
       bpf_prog_load+0x19bb/0x2660 kernel/bpf/syscall.c:2944
       __sys_bpf+0x9b4/0x4b40 kernel/bpf/syscall.c:5660
       __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
       __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x23a/0x1020 kernel/workqueue.c:2346
       queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
       queue_work include/linux/workqueue.h:605 [inline]
       schedule_work include/linux/workqueue.h:666 [inline]
       p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
       __wake_up_common+0x131/0x1e0 kernel/sched/wait.c:89
       __wake_up_common_lock kernel/sched/wait.c:106 [inline]
       __wake_up+0x31/0x60 kernel/sched/wait.c:127
       signalfd_notify include/linux/signalfd.h:22 [inline]
       __send_signal_locked+0x951/0x11c0 kernel/signal.c:1168
       force_sig_info_to_task+0x31d/0x660 kernel/signal.c:1352
       force_sig_fault_to_task kernel/signal.c:1733 [inline]
       force_sig_fault+0xc5/0x110 kernel/signal.c:1738
       __bad_area_nosemaphore+0x30d/0x6b0 arch/x86/mm/fault.c:854
       bad_area_access_error+0xc1/0x260 arch/x86/mm/fault.c:931
       do_user_addr_fault+0xa2a/0x1080 arch/x86/mm/fault.c:1396
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &sighand->siglock --> &sighand->signalfd_wqh

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->signalfd_wqh);
                               lock(&sighand->siglock);
                               lock(&sighand->signalfd_wqh);
  lock(&pool->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.0/7699:
 #0: ffff8880234465d8 (&sighand->siglock){-...}-{2:2}, at: force_sig_info_to_task+0x7a/0x660 kernel/signal.c:1334
 #1: ffff888023446620 (&sighand->signalfd_wqh){....}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:105 [inline]
 #1: ffff888023446620 (&sighand->signalfd_wqh){....}-{2:2}, at: __wake_up+0x1c/0x60 kernel/sched/wait.c:127
 #2: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf2/0x1020 kernel/workqueue.c:2324

stack backtrace:
CPU: 2 PID: 7699 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00031-g96fca68c4fbf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x23a/0x1020 kernel/workqueue.c:2346
 queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
 queue_work include/linux/workqueue.h:605 [inline]
 schedule_work include/linux/workqueue.h:666 [inline]
 p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
 __wake_up_common+0x131/0x1e0 kernel/sched/wait.c:89
 __wake_up_common_lock kernel/sched/wait.c:106 [inline]
 __wake_up+0x31/0x60 kernel/sched/wait.c:127
 signalfd_notify include/linux/signalfd.h:22 [inline]
 __send_signal_locked+0x951/0x11c0 kernel/signal.c:1168
 force_sig_info_to_task+0x31d/0x660 kernel/signal.c:1352
 force_sig_fault_to_task kernel/signal.c:1733 [inline]
 force_sig_fault+0xc5/0x110 kernel/signal.c:1738
 __bad_area_nosemaphore+0x30d/0x6b0 arch/x86/mm/fault.c:854
 bad_area_access_error+0xc1/0x260 arch/x86/mm/fault.c:931
 do_user_addr_fault+0xa2a/0x1080 arch/x86/mm/fault.c:1396
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f809a860675
Code: fe 28 6f 06 48 83 fa 40 0f 87 a7 00 00 00 62 e1 fe 28 6f 4c 16 ff 62 e1 fe 28 7f 07 62 e1 fe 28 7f 4c 17 ff c3 8b 0e 8b 34 16 <89> 0f 89 34 17 c3 0f 1f 44 00 00 83 fa 10 73 21 83 fa 08 73 36 48
RSP: 002b:00007fff068363a8 EFLAGS: 00010202
RAX: 0000000020000080 RBX: 0000000000000004 RCX: 0000000034747865
RDX: 0000000000000001 RSI: 0000000000347478 RDI: 0000000020000080
RBP: 00007f809a9ad980 R08: 00007f809a800000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 0000000000018980
R13: 000000000001894e R14: 00007fff06836550 R15: 00007f809a834cb0
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

