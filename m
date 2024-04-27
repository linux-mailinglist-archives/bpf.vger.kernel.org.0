Return-Path: <bpf+bounces-28030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080D8B47C0
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 22:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F11C20AFA
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB512836B;
	Sat, 27 Apr 2024 20:00:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46A17C96
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714248044; cv=none; b=SfBA3+3/zwUXdZ1NkVnB6QNULP/4mMR34HTSQVAvlb3Qol93TYFwdrRIRhCg2KkKDA9mg0inPQyrAmcCT1cQxB+TcRayfVhOoLl9Y8iJLRoEGYgkQb1po1EQOToQE+gK93z84uPk4LmMJPIjdP7b652R8Qo6Wq1dTczpAsiGWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714248044; c=relaxed/simple;
	bh=NGNBiBn8Yur6874SE7mZrdz48McARbZtjMU2XK8SS4s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQ7Lrs4dNV8gtiU68i4Ss6uJWXGaN3B8+JKrRpkPuAMAW0ggVWQFwozuEATNzy41F2l1RcFv6JwiLJYouRj7By7EALYk9Hv3Mf0qjqPl6sFP7K+jMJ3WKPpFBN1pXmoYpU++a9Y0d+TxHLsU2BALFsrCzpOtkeCIH8sqOHQF4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ddf0219685so354701439f.3
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 13:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714248042; x=1714852842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCv5BYGT858JneckZq57iIp92LyXINnvkdVpq9e/wXs=;
        b=ghJuQmxYYKHgpq22YK+TI+9Ms4CQu39CYqpwHChJHmSh3Z2JuzF7c57vKpvMCMQLo2
         b+FJiW4zSKcz01LHxOBfCdfS9kZZkv+djgIR93PCp+i5LHD5kYcPL0I3pmn3a86NCmCU
         Uy4wvWiWyBfLQl4439bFSYxVfQ4dug4vA/14aAv33eTKWYFXCewigNYXx+Vwi8kOFrvI
         BpIXgnovjsdbn6RapBkU93Kdm9krsF4+6xZFyolzH1M0XdrTDDCc3PmrHVtQ0j75EmfS
         gocXW5g1G5ar2sX9SIPRLlDUO04R/j5kMOCJbBhu1FPsuAiw0QBhSoDuR8njhsDsjQj5
         nHag==
X-Forwarded-Encrypted: i=1; AJvYcCVZoddiwlvI6m14dq6JeBS6MlnNx3fxTuDr3NYfw0w0bCIlHfJ2KUtNFRo91N+CGRG3iy6Ro56YQ8Dx4rufgGxUZqbX
X-Gm-Message-State: AOJu0YySh4+49ESP5lzPLofJUCRxp/ZM9XvOEgvp4gfDePiVoFC+NP1c
	EJQfOT7Oc8c/idYPr6LvAE5ZRV2BuvkZSZ0YKZyPReexRp8yPm4bkbIdye1s1Yf8JSbHdcpHfvj
	cr2nLOLWq+tqLlP9z5ucBS5/DqbqEePK3lHSRAwSATawBrEbCDJEHc60=
X-Google-Smtp-Source: AGHT+IEFJuVusGzzLEkRhku9FoIt4CRfWI0f8OBRIa3+tFGZqD0+eMpB6cxeKAMHeOCPROhjRe8gxx1BZylhfrDgVjRl6rUi7lpt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:67c8:b0:485:907:ffa with SMTP id
 gx8-20020a05663867c800b0048509070ffamr230287jab.1.1714248042276; Sat, 27 Apr
 2024 13:00:42 -0700 (PDT)
Date: Sat, 27 Apr 2024 13:00:42 -0700
In-Reply-To: <000000000000d5f4fc0616e816d4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dfa6d0617197994@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
From: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	olsajiri@gmail.com, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5eb4573ea63d Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17b2b240980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=83e7f982ca045ab4405c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120f79ef180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a1cd27180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d647177a878d/disk-5eb4573e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/977f32ca169c/vmlinux-5eb4573e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67f3b92c1012/bzImage-5eb4573e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00296-g5eb4573ea63d #0 Not tainted
------------------------------------------------------
syz-executor324/5151 is trying to acquire lock:
ffff88802a6c8018 (&sighand->siglock){....}-{2:2}, at: force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334

but task is already holding lock:
ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1387 [inline]
       rq_lock kernel/sched/sched.h:1701 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12635
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4845
       copy_process+0x2217/0x3df0 kernel/fork.c:2499
       kernel_clone+0x223/0x870 kernel/fork.c:2797
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2875
       rest_init+0x23/0x300 init/main.c:704
       start_kernel+0x47a/0x500 init/main.c:1081
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
       signal_wake_up_state+0xb4/0x120 kernel/signal.c:773
       signal_wake_up include/linux/sched/signal.h:448 [inline]
       complete_signal+0x94a/0xcf0 kernel/signal.c:1065
       __send_signal_locked+0xb1b/0xdc0 kernel/signal.c:1185
       do_notify_parent+0xd96/0x10a0 kernel/signal.c:2143
       exit_notify kernel/exit.c:757 [inline]
       do_exit+0x1811/0x27e0 kernel/exit.c:898
       do_group_exit+0x207/0x2c0 kernel/exit.c:1027
       __do_sys_exit_group kernel/exit.c:1038 [inline]
       __se_sys_exit_group kernel/exit.c:1036 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sighand->siglock){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
       force_sig_fault_to_task kernel/signal.c:1733 [inline]
       force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
       __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:48
       copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
       raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
       __copy_from_user_inatomic include/linux/uaccess.h:87 [inline]
       copy_from_user_nofault+0xbc/0x150 mm/maccess.c:125
       bpf_probe_read_user_common kernel/trace/bpf_trace.c:179 [inline]
       ____bpf_probe_read_compat kernel/trace/bpf_trace.c:292 [inline]
       bpf_probe_read_compat+0xe9/0x180 kernel/trace/bpf_trace.c:288
       bpf_prog_1878750df62aa1fb+0x48/0x4a
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
       __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2535/0x4a00 kernel/sched/core.c:6743
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6925
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6949
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       force_sig_info_to_task+0x41c/0x580 kernel/signal.c:1356
       force_sig_fault_to_task kernel/signal.c:1733 [inline]
       force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
       __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       __put_user_handle_exception+0x0/0x10
       __do_sys_gettimeofday kernel/time/time.c:147 [inline]
       __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140
       emulate_vsyscall+0xe23/0x1290 arch/x86/entry/vsyscall/vsyscall_64.c:247
       do_user_addr_fault arch/x86/mm/fault.c:1346 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x160/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       _end+0x6a9da000/0x0

other info that might help us debug this:

Chain exists of:
  &sighand->siglock --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(&sighand->siglock);

 *** DEADLOCK ***

2 locks held by syz-executor324/5151:
 #0: ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x490 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 5151 Comm: syz-executor324 Not tainted 6.9.0-rc5-syzkaller-00296-g5eb4573ea63d #0
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
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
 force_sig_fault_to_task kernel/signal.c:1733 [inline]
 force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
 __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:50
Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 83 f9 40 73 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 <c3> cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 48 89 07 48 83
RSP: 0000:ffffc90004137468 EFLAGS: 00050002
RAX: ffffffff8205ce4e RBX: dffffc0000000000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000900 RDI: ffffc900041374e8
RBP: ffff88802d039784 R08: 0000000000000005 R09: ffffffff8205ce37
R10: 0000000000000003 R11: ffff88802d038000 R12: 1ffff11005a072f0
R13: 0000000000000900 R14: 0000000000000002 R15: ffffc900041374e8
 copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
 __copy_from_user_inatomic include/linux/uaccess.h:87 [inline]
 copy_from_user_nofault+0xbc/0x150 mm/maccess.c:125
 bpf_probe_read_user_common kernel/trace/bpf_trace.c:179 [inline]
 ____bpf_probe_read_compat kernel/trace/bpf_trace.c:292 [inline]
 bpf_probe_read_compat+0xe9/0x180 kernel/trace/bpf_trace.c:288
 bpf_prog_1878750df62aa1fb+0x48/0x4a
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
 __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2535/0x4a00 kernel/sched/core.c:6743
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6925
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6949
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 force_sig_info_to_task+0x41c/0x580 kernel/signal.c:1356
 force_sig_fault_to_task kernel/signal.c:1733 [inline]
 force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
 __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_handle_exception+0x0/0x10 arch/x86/lib/putuser.S:125
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 01 cb 48 89 01 31 c9 0f 01 ca c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 <0f> 01 ca b9 f2 ff ff ff c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90
RSP: 0000:ffffc90004137d98 EFLAGS: 00050202
RAX: 00000000662d5943 RBX: 0000000000000000 RCX: 0000000000000019
RDX: 0000000000000000 RSI: ffffffff8bcaca20 RDI: ffffffff8c1eaba0
RBP: ffffc90004137e50 R08: ffffffff8fa7cd6f R09: 1ffffffff1f4f9ad
R10: dffffc0000000000 R11: fffffbfff1f4f9ae R12: ffffc90004137de0
R13: dffffc0000000000 R14: 1ffff92000826fb8 R15: 0000000000000019
 __do_sys_gettimeofday kernel/time/time.c:147 [inline]
 __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140
 emulate_vsyscall+0xe23/0x1290 arch/x86/entry/vsyscall/vsyscall_64.c:247
 do_user_addr_fault arch/x86/mm/fault.c:1346 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x160/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:_end+0x6a9da000/0x0
Code: Unable to access opcode bytes at 0xffffffffff5fffd6.
RSP: 002b:00007fbb40c81c78 EFLAGS: 00010246
RAX: ffffffffffffffda RBX: 00007fbb40d73418 RCX: 00007fbb40ce97d9
RDX: 00007fbb40c81c80 RSI: 00007fbb40c81db0 RDI: 0000000000000019
RBP: 00007fbb40d73410 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007fbb40d402b0
R13: 77735f6465686373 R14: 66aa589070d556b8 R15: 0400000000000004
 </TASK>
syz-executor324[5151] vsyscall fault (exploit attempt?) ip:ffffffffff600000 cs:33 sp:7fbb40c81c78 ax:ffffffffffffffda si:7fbb40c81db0 di:19
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	f3 0f 1e fa          	endbr64
   c:	48 83 f9 40          	cmp    $0x40,%rcx
  10:	73 40                	jae    0x52
  12:	83 f9 08             	cmp    $0x8,%ecx
  15:	73 21                	jae    0x38
  17:	85 c9                	test   %ecx,%ecx
  19:	74 0f                	je     0x2a
  1b:	8a 06                	mov    (%rsi),%al
  1d:	88 07                	mov    %al,(%rdi)
  1f:	48 ff c7             	inc    %rdi
  22:	48 ff c6             	inc    %rsi
  25:	48 ff c9             	dec    %rcx
  28:	75 f1                	jne    0x1b
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  36:	00 00
  38:	48 8b 06             	mov    (%rsi),%rax
  3b:	48 89 07             	mov    %rax,(%rdi)
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

