Return-Path: <bpf+bounces-30629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990768CF7F7
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 05:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8FD1C2017E
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 03:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158279F2;
	Mon, 27 May 2024 03:07:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BC26ADE
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779251; cv=none; b=MvFx/AYJOwaq5mywg0qPi9t4BfUgnqsIEDqHZ+2n1UY/tF19fNHrwufBSrvA3KUsBkBHmnV8iOoUcB67lH6yLAdm2Nw9Wm9ZaMkmYLe3gzy38ISJ0B6u1L+z7HKZlrvZnZMnskf+ie8nGfSgfyR7Agdidp8EyZotST3ttBjDVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779251; c=relaxed/simple;
	bh=XOiJQaZ7C/ojaoQTEsTt7vFztz17UFMDe83FBnpctxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N9X2nqxoF4Z+xt+H0XBhdO/iu2xfqunaKSofvuHAmXpV2Q2hyhoH9hhLWqyuA2gBhLsf/1Cgc95nxRwJMiYBk9bDb4m/VIi3EGJ3k6F4kzZl35CMuSggYVvhqveasY9CK7THLwhsj64QQirmeCougdNAlB4r9xZW3PT9eDV7fho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-374519f6ebcso9805475ab.1
        for <bpf@vger.kernel.org>; Sun, 26 May 2024 20:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716779249; x=1717384049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H04jhFbGqy6CBcAVlJdIvS+14dWMN9WrqK+QMf8amVw=;
        b=CxpIcDc5QT5lUaMCDE17HXUT+KpDzBNh90v+zwuM1ethD+0cdiDC/AmeJjRJA5+f1H
         ARVjPOvEocTDF/TKsfduFMmhuF0p0aPAkXrWs37WRJPEkbXZDoSlkXVbjA8pcu33pwkt
         zBCaD6D7WoklClq7f6Y9/n4UFI5enGDXChMYETTbDmcNqaOPhz602ur+osJkOgqKN6tH
         zsds/2C4FI7gn2O6KDSqpV9UCJdEVVsfEMQd9eCjefo+8FhOQj5ZXf2y/kq2OSTNbXWv
         Hu/tjCqnIr3dcH78VLfT7z0MBaBe9LXxW3hzLur6ZefvUgW1gclWzm2q0mRpNiFHngO7
         4RrA==
X-Forwarded-Encrypted: i=1; AJvYcCWa38WkTpkVFITHKiyUp9jIlUupoG40bYm3CfIwre2xdVUOzZ7Zujqe1IG1pIjvpCpNV70i6QbsmeVW8tWJNdkn/FZf
X-Gm-Message-State: AOJu0YwF43kwO1l+3heWMdHbR/+Dk7c7pMqLBZLB13ztWvYov+FwHxSq
	u3ZrgfIn+j17zAx+TUIWbFft2iJoUyq2KX1DK6Einpt2jnPE0r0RLEEWqQQtCQfqx2nu1MIJRJV
	l7xBvRX0y5CEIFrHgo6aKXds3jS796xpAWvQlmdi0wtpFiwkXLSC4sng=
X-Google-Smtp-Source: AGHT+IE/qY/ugbiX5roIC7paNS4B7Z2no2b/3xLM7LzLYU9VhBIcLLR1/hj/4nyEhuWxQTzDTcpN71lAZI9CeeorbRSWVQEtZgSb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a42:b0:374:5315:95de with SMTP id
 e9e14a558f8ab-3745315971bmr2239185ab.6.1716779249275; Sun, 26 May 2024
 20:07:29 -0700 (PDT)
Date: Sun, 26 May 2024 20:07:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fa7ab061966d1b3@google.com>
Subject: [syzbot] [bpf?] possible deadlock in __lock_task_sighand (3)
From: syzbot <syzbot+f2ed7d5888894fedf676@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30a92c9e3d6b openvswitch: Set the skbuff pkt_type for prop..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166c4e42980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=f2ed7d5888894fedf676
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c203f0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12046634980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/613ea2adf735/disk-30a92c9e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d370db074ef/vmlinux-30a92c9e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e9ed7a24991/bzImage-30a92c9e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2ed7d5888894fedf676@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08557-g30a92c9e3d6b #0 Not tainted
------------------------------------------------------
strace-static-x/5086 is trying to acquire lock:
ffff8880183f9bd8 (&sighand->siglock){-...}-{2:2}, at: __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1414

but task is already holding lock:
ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (lock#9){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0xa8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x9b2/0x9d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1994 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1984
       bpf_prog_ec3b2eefa702d8d3+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
       __traceiter_tlb_flush+0x77/0xd0 include/trace/events/tlb.h:38
       trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x7cb/0xae0
       context_switch kernel/sched/core.c:5392 [inline]
       __schedule+0x1066/0x4a50 kernel/sched/core.c:6745
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6924
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6948
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
       _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
       spin_unlock include/linux/spinlock.h:391 [inline]
       __text_poke+0xa6b/0xd30 arch/x86/kernel/alternative.c:1944
       text_poke arch/x86/kernel/alternative.c:1968 [inline]
       text_poke_bp_batch+0x265/0xb30 arch/x86/kernel/alternative.c:2276
       text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
       text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2477
       arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
       static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
       static_key_enable+0x1a/0x20 kernel/jump_label.c:218
       tracepoint_add_func+0x953/0x9e0 kernel/tracepoint.c:361
       tracepoint_probe_register_prio_may_exist+0x122/0x190 kernel/tracepoint.c:482
       bpf_raw_tp_link_attach+0x48b/0x6e0 kernel/bpf/syscall.c:3874
       bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3905
       __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5729
       __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
       rq_lock kernel/sched/sched.h:1702 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12709
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4844
       copy_process+0x2217/0x3dc0 kernel/fork.c:2499
       kernel_clone+0x226/0x8f0 kernel/fork.c:2797
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2875
       rest_init+0x23/0x300 init/main.c:707
       start_kernel+0x47a/0x500 init/main.c:1084
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
       exit_notify kernel/exit.c:756 [inline]
       do_exit+0x1811/0x27e0 kernel/exit.c:897
       do_group_exit+0x207/0x2c0 kernel/exit.c:1026
       __do_sys_exit_group kernel/exit.c:1037 [inline]
       __se_sys_exit_group kernel/exit.c:1035 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sighand->siglock){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1414
       lock_task_sighand include/linux/sched/signal.h:746 [inline]
       do_send_sig_info kernel/signal.c:1300 [inline]
       group_send_sig_info+0x274/0x310 kernel/signal.c:1453
       bpf_send_signal_common+0x2dd/0x430 kernel/trace/bpf_trace.c:881
       ____bpf_send_signal_thread kernel/trace/bpf_trace.c:898 [inline]
       bpf_send_signal_thread+0x16/0x20 kernel/trace/bpf_trace.c:896
       bpf_prog_16ecb682114cf56a+0x22/0x2a
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2446
       __traceiter_mmap_lock_acquire_returned+0x93/0xf0 include/trace/events/mmap_lock.h:52
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x5c8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_lock include/linux/mmap_lock.h:147 [inline]
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core mm/process_vm_access.c:216 [inline]
       process_vm_rw+0xa46/0xcf0 mm/process_vm_access.c:284
       __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
       __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
       __x64_sys_process_vm_readv+0xe0/0x100 mm/process_vm_access.c:292
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sighand->siglock --> &rq->__lock --> lock#9

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#9);
                               lock(&rq->__lock);
                               lock(lock#9);
  lock(&sighand->siglock);

 *** DEADLOCK ***

5 locks held by strace-static-x/5086:
 #0: ffff88802f77cda0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:146 [inline]
 #0: ffff88802f77cda0 (&mm->mmap_lock){++++}-{3:3}, at: process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
 #0: ffff88802f77cda0 (&mm->mmap_lock){++++}-{3:3}, at: process_vm_rw_core mm/process_vm_access.c:216 [inline]
 #0: ffff88802f77cda0 (&mm->mmap_lock){++++}-{3:3}, at: process_vm_rw+0x6e9/0xcf0 mm/process_vm_access.c:284
 #1: ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #1: ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: get_memcg_path_buf mm/mmap_lock.c:139 [inline]
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: get_mm_memcg_path+0xb1/0x600 mm/mmap_lock.c:209
 #3: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2402 [inline]
 #3: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x244/0x590 kernel/trace/bpf_trace.c:2446
 #4: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: __lock_task_sighand+0x29/0x2d0 kernel/signal.c:1397

stack backtrace:
CPU: 1 PID: 5086 Comm: strace-static-x Not tainted 6.9.0-syzkaller-08557-g30a92c9e3d6b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1414
 lock_task_sighand include/linux/sched/signal.h:746 [inline]
 do_send_sig_info kernel/signal.c:1300 [inline]
 group_send_sig_info+0x274/0x310 kernel/signal.c:1453
 bpf_send_signal_common+0x2dd/0x430 kernel/trace/bpf_trace.c:881
 ____bpf_send_signal_thread kernel/trace/bpf_trace.c:898 [inline]
 bpf_send_signal_thread+0x16/0x20 kernel/trace/bpf_trace.c:896
 bpf_prog_16ecb682114cf56a+0x22/0x2a
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2446
 __traceiter_mmap_lock_acquire_returned+0x93/0xf0 include/trace/events/mmap_lock.h:52
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
 __mmap_lock_do_trace_acquire_returned+0x5c8/0x630 mm/mmap_lock.c:237
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_lock include/linux/mmap_lock.h:147 [inline]
 process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
 process_vm_rw_core mm/process_vm_access.c:216 [inline]
 process_vm_rw+0xa46/0xcf0 mm/process_vm_access.c:284
 __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
 __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
 __x64_sys_process_vm_readv+0xe0/0x100 mm/process_vm_access.c:292
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x4eacda
Code: 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 38 12 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 36 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 a8 ff ff ff f7
RSP: 002b:00007ffe656d7be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000136
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 00000000004eacda
RDX: 0000000000000001 RSI: 00007ffe656d7c10 RDI: 00000000000013eb
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 00007ffe656d7c20 R11: 0000000000000246 R12: 0000000020000080
R13: 0000000012d21a30 R14: 0000000000001000 R15: 0000000000000010
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

