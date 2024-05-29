Return-Path: <bpf+bounces-30857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0E8D3D1F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22D81C219A0
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4299218733D;
	Wed, 29 May 2024 16:52:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0D1836E3
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001550; cv=none; b=mOBun0zEiRoVcmjxlQ0VVM2YsRqazXEf6SmnGN0ZI6jJ/PODUgJ67mW6/nyMPYIhFcnQ7zKL+q4576u8sF5AA1mjoXjo4UCp+KfW94BDxTDoDtpSg/PFcEqOURqfXqlL6Hh0D/z/rInwmYCo3FYW9vANg9VAboXkfo7gU+wSkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001550; c=relaxed/simple;
	bh=Slhcrvv302EnCSIhqJfoPNA7hpktgf8zQEUdvKzSNcI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iV2KoizRJfBVbfFLTGWxZJ4VlYFONXTv2Z8435ZSdJ1h9Fv/4K/IYJ0SMxdOXpxEBIVkbHNbd+Bh2RLSmwXcfUsZeD4JpArP34Q+8tYX2jPoQmtgfRaheNT1bbdkh7wlT8O1dHhUpm5Mgg+pku9OI6kCKD1G3/1ApJQPh3U+iL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e8e558d366so276805039f.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 09:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717001547; x=1717606347;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sZTA5pQPWMEXkgbdcJ37UQpB/o8YbjkC8POOYah4lU=;
        b=cm1smAzvLGEMLub7zof9A/4cINgVM8Zg4XoDZq6gMFoBSTa7MhUBrKEGKg83OCGWRY
         HSU3ZfFLCd2XucmgQylYpHk7UFL+47OJV9Lt6idPIojhLURbPlNFfkb3Y9rkq0zGhQVY
         FKBRLyup5rR8cq/wwgKcscSEfK9q1Us8vrb6r7nXD7Jnh4DgP+MhT5IqZ09Ei8W575qH
         Jum/Rh0EQ3ikwWpgXmFHyMPh6CcaDOs287jPkumWTSTZNJgNyg3KDfC58/Irdroc+oLI
         RDf7bryGuwEnBa/CDQrpAncDBEZ7RCzbD/UhNqj29JlkASbyP18TJKg/yMzsQ5xk3jV/
         gqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWY1FngLmvBx3CV0E/ZZaLw7Y26IPlhebUuslzMtdxp7AxXKNXEBKjGzFc1z/mpot4NX9Rk1rBJw6tHI08QAgnDI4IT
X-Gm-Message-State: AOJu0YzufPYzyMpHAc9bQFSR4zIFYAfGFCTTwefR5W2bDuOhG3Ixw9uD
	Gu6VHhboQLwCfhYLaLLp9vHi8vyTlzRKqDLK6XwHffUv5uk6p0fj0ryKmYTGEdwbNi+UoV/pfTf
	W/3gNfkatINXGhXD7UHYFy5MWlCk9eTIYDZcvJ+1qmwMWc7So9Id+P0k=
X-Google-Smtp-Source: AGHT+IH3XwZS15k45nnmsowxNeIkYj7USUbdOSEIJt3hAuM8IubBzg1dlestczF+3CZe2IL2stayfWFH4vJDI04WFU6beEaQuPHJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:b89a:0:b0:48a:40e5:3ba5 with SMTP id
 8926c6da1cb9f-4b03fba9c19mr558930173.5.1717001546276; Wed, 29 May 2024
 09:52:26 -0700 (PDT)
Date: Wed, 29 May 2024 09:52:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003eb50e06199a9324@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sk_psock_skb_ingress_enqueue
From: syzbot <syzbot+53cf0afa7b308038a6db@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    44382b3ed6b2 bpf: Fix potential integer overflow in resolv..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1556297c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=53cf0afa7b308038a6db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2dad9cbbe0c/disk-44382b3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f67186323c24/vmlinux-44382b3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02d46501b164/bzImage-44382b3e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53cf0afa7b308038a6db@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08559-g44382b3ed6b2 #0 Not tainted
------------------------------------------------------
syz-executor.3/7164 is trying to acquire lock:
ffff88804a4d7858 (&ei->socket.wq.wait){..-.}-{2:2}, at: __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105

but task is already holding lock:
ffff88801e9623f0 (clock-AF_UNIX){++..}-{2:2}, at: sk_psock_data_ready include/linux/skmsg.h:468 [inline]
ffff88801e9623f0 (clock-AF_UNIX){++..}-{2:2}, at: sk_psock_skb_ingress_enqueue+0x328/0x450 net/core/skmsg.c:555

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (clock-AF_UNIX){++..}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
       _raw_write_lock_bh+0x35/0x50 kernel/locking/spinlock.c:334
       sk_psock_drop+0x34/0x500 net/core/skmsg.c:837
       __sock_map_delete net/core/sock_map.c:435 [inline]
       sock_map_delete_elem+0x1a2/0x250 net/core/sock_map.c:461
       0xffffffffa00017f2
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:682 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run8+0x564/0x630 kernel/trace/bpf_trace.c:2450
       __bpf_trace_jbd2_handle_stats+0x47/0x60 include/trace/events/jbd2.h:210
       trace_jbd2_handle_stats include/trace/events/jbd2.h:210 [inline]
       jbd2_journal_stop+0xd0a/0xd80 fs/jbd2/transaction.c:1869
       __ext4_journal_stop+0xfd/0x1a0 fs/ext4/ext4_jbd2.c:134
       ext4_create+0x2f9/0x550 fs/ext4/namei.c:2843
       lookup_open fs/namei.c:3505 [inline]
       open_last_lookups fs/namei.c:3574 [inline]
       path_openat+0x1425/0x3240 fs/namei.c:3804
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&stab->lock){+...}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       __sock_map_delete net/core/sock_map.c:429 [inline]
       sock_map_delete_elem+0x175/0x250 net/core/sock_map.c:461
       bpf_prog_10a0f827fc0335db+0x3/0x21
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2446
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x5c8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       get_mmap_lock_carefully mm/memory.c:5628 [inline]
       lock_mm_and_find_vma+0x213/0x2f0 mm/memory.c:5688
       do_user_addr_fault arch/x86/mm/fault.c:1355 [inline]
       handle_page_fault arch/x86/mm/fault.c:1475 [inline]
       exc_page_fault+0x1a9/0x8a0 arch/x86/mm/fault.c:1533
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:65
       copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
       raw_copy_to_user arch/x86/include/asm/uaccess_64.h:131 [inline]
       copy_to_user_iter lib/iov_iter.c:25 [inline]
       iterate_ubuf include/linux/iov_iter.h:29 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
       iterate_and_advance include/linux/iov_iter.h:271 [inline]
       _copy_to_iter+0x26b/0x1960 lib/iov_iter.c:185
       copy_page_to_iter+0xb1/0x160 lib/iov_iter.c:362
       pipe_read+0x59c/0x13e0 fs/pipe.c:327
       call_read_iter include/linux/fs.h:2114 [inline]
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x97b/0xb70 fs/read_write.c:476
       ksys_read+0x1a0/0x2c0 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (lock#10){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0xa8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x9b2/0x9d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1994 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1984
       bpf_prog_9dc0996bccb7470f+0x16/0x6c
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
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
       futex_wake+0x516/0x5c0 kernel/futex/waitwake.c:198
       do_futex+0x392/0x560 kernel/futex/syscalls.c:107
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
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
       autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
       __wake_up_common kernel/sched/wait.c:89 [inline]
       __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
       sock_def_readable+0x20f/0x5b0 net/core/sock.c:3353
       unix_dgram_sendmsg+0x148e/0x1f80 net/unix/af_unix.c:2113
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
       __do_sys_sendto net/socket.c:2203 [inline]
       __se_sys_sendto net/socket.c:2199 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2199
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->socket.wq.wait){..-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
       sock_def_readable+0x20f/0x5b0 net/core/sock.c:3353
       sk_psock_skb_ingress_enqueue+0x388/0x450 net/core/skmsg.c:555
       sk_psock_skb_ingress_self+0x292/0x340 net/core/skmsg.c:606
       sk_psock_verdict_apply+0x3bd/0x460 net/core/skmsg.c:1008
       sk_psock_verdict_recv+0x335/0x590 net/core/skmsg.c:1202
       unix_read_skb+0xd9/0x180 net/unix/af_unix.c:2502
       sk_psock_verdict_data_ready+0xab/0x390 net/core/skmsg.c:1223
       unix_dgram_sendmsg+0x148e/0x1f80 net/unix/af_unix.c:2113
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
       ___sys_sendmsg net/socket.c:2638 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->socket.wq.wait --> &stab->lock --> clock-AF_UNIX

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(clock-AF_UNIX);
                               lock(&stab->lock);
                               lock(clock-AF_UNIX);
  lock(&ei->socket.wq.wait);

 *** DEADLOCK ***

3 locks held by syz-executor.3/7164:
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: sk_psock_verdict_recv+0x4d/0x590 net/core/skmsg.c:1185
 #1: ffff88801e9623f0 (clock-AF_UNIX){++..}-{2:2}, at: sk_psock_data_ready include/linux/skmsg.h:468 [inline]
 #1: ffff88801e9623f0 (clock-AF_UNIX){++..}-{2:2}, at: sk_psock_skb_ingress_enqueue+0x328/0x450 net/core/skmsg.c:555
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: sock_def_readable+0xd7/0x5b0 net/core/sock.c:3350

stack backtrace:
CPU: 0 PID: 7164 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-08559-g44382b3ed6b2 #0
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
 __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
 sock_def_readable+0x20f/0x5b0 net/core/sock.c:3353
 sk_psock_skb_ingress_enqueue+0x388/0x450 net/core/skmsg.c:555
 sk_psock_skb_ingress_self+0x292/0x340 net/core/skmsg.c:606
 sk_psock_verdict_apply+0x3bd/0x460 net/core/skmsg.c:1008
 sk_psock_verdict_recv+0x335/0x590 net/core/skmsg.c:1202
 unix_read_skb+0xd9/0x180 net/unix/af_unix.c:2502
 sk_psock_verdict_data_ready+0xab/0x390 net/core/skmsg.c:1223
 unix_dgram_sendmsg+0x148e/0x1f80 net/unix/af_unix.c:2113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8f8967cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8f891de0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8f897ac050 RCX: 00007f8f8967cee9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000004
RBP: 00007f8f896c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f8f897ac050 R15: 00007ffc340af978
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

