Return-Path: <bpf+bounces-29587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D98C2FB0
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 07:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F01DB2280D
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A147A6A;
	Sat, 11 May 2024 05:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36A47773
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405964; cv=none; b=rObXSagJ8YP4ifNxbl6U2KkarHj2ti06aQmvJ8vao299obujYOfUo1/3BoJbr7CxOA75cpJNB2Sdph3y8KZp9bCXAdBS12UISFVhUueKkPjX4PMHn7DskKEGiyZcVJuQeV9ReY5nA5Y+oM3OZlYjf3Mmjj9/6cyHR7uwzBnCr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405964; c=relaxed/simple;
	bh=k7g437RaKUYs0l4Hi3AJMlbEKOlasC1gwWnAB/YyP9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dSCO0gpmww3qhLmaT6eTkIekU1csc6CODCD6p+cGvvyUaR9LNfuYLCVVhBCSb2PVvV49E0FjZDpsmwbps61jXAsaCN7KdFlRahtqLGFiJABhEdPI9b9NKkhYupgIk8aviuUwx8ggAXM7A28YN4OXM+pwld/pBFhKgMwvyoBznMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1bdfff102so118788339f.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715405961; x=1716010761;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0BYhRJoVlgkd3FdLLOyw2QsBkEnYIWR2rM5UJU3woM=;
        b=vnsNsIMt2iHHLj/IkvPrJ0Gx4N4bAFCVfhV86NpLqZTGzMYOn/8AGwEMzh/mmH9tia
         qQaKZyFjE9MUh0BHd7Eb3Fmy+JDHYBy1VO7J65uD18x6tt6MCsSX7/wM3kcSzkaVi+5M
         BmiClrb1Nvxx1v0mpR60bomcXUBX7M4z0XpUBJzwg2svKUVOE+3yaI+ncR+2uESPsfRA
         olB9vqryrGvwXNGs9YjwGE6cRE7ePnut3sjbAlUM8xW+ObOUR4Itr5RJbEe2nVTYM33U
         3omaPEMhIC6YexM1adUmVKBVr4uh2R5WzYLXy93wdnboitDmGC4z6PjAxBLBTIEWFJPL
         zJFA==
X-Forwarded-Encrypted: i=1; AJvYcCUwXOYNcHqthJH3nfdFtYsAhITsqvdOhFGxqEn7LRe/0aPFdkieHs73rAmN24yGIFVFQHXBnlLIUzLR1dPffnx5Z1c9
X-Gm-Message-State: AOJu0YwtpL98HZooF6t4L9aTu3rWUE2fNxIpvJgz7QeytGjoestEkv/3
	9XiHZptuzI5Q1+qP1W7R1rHj3xDTvOabvcgzJDYXRiuuX8Ny7MVD9I+rfnIv2VhLG6DgHFYstE8
	DzHGfhs4uaqe5piAN8bIE+sxClU3cLXy3SLb7wFWpoD4myc8wfyRnyZk=
X-Google-Smtp-Source: AGHT+IH6ZJXCIuaI3cVd6NEIKhw9yqYUCfg7sVWV/N0UFQgLn6VPXn2mO+Gz5XtjFAqYQFRKPWTHV8TQ0dwT0YK0Zchlzm6EpI06
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b08:b0:7de:8cc5:fd1 with SMTP id
 ca18e2360f4ac-7e1b521bcacmr16879939f.3.1715405961489; Fri, 10 May 2024
 22:39:21 -0700 (PDT)
Date: Fri, 10 May 2024 22:39:21 -0700
In-Reply-To: <0000000000007b33c00613f64d03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fafd5b06182712ca@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in __lock_task_sighand (2)
From: syzbot <syzbot+34267210261c2cbba2da@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, jakub@cloudflare.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3e9bc0472b91 Merge branch 'bpf: Add BPF_PROG_TYPE_CGROUP_S..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1372d16c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=34267210261c2cbba2da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116aa704980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be0fb8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4d98ec9bb7b/disk-3e9bc047.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df7961b4e331/vmlinux-3e9bc047.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be4e509c6f1b/bzImage-3e9bc047.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34267210261c2cbba2da@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00185-g3e9bc0472b91 #0 Not tainted
------------------------------------------------------
syz-executor188/5087 is trying to acquire lock:
ffff8880278b1298 (&sighand->siglock){-...}-{2:2}, at: __lock_task_sighand+0x149/0x2e0 kernel/signal.c:1414

but task is already holding lock:
ffff8880b95387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b95387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

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
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1975
       0xffffffffa0001ff6
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x7cb/0xae0
       context_switch kernel/sched/core.c:5393 [inline]
       __schedule+0x1066/0x4a50 kernel/sched/core.c:6746
       __schedule_loop kernel/sched/core.c:6823 [inline]
       schedule+0x14b/0x320 kernel/sched/core.c:6838
       do_wait+0x2a5/0x560 kernel/exit.c:1636
       kernel_wait4+0x2a7/0x3e0 kernel/exit.c:1790
       __do_sys_wait4 kernel/exit.c:1818 [inline]
       __se_sys_wait4 kernel/exit.c:1814 [inline]
       __x64_sys_wait4+0x134/0x1e0 kernel/exit.c:1814
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1387 [inline]
       rq_lock kernel/sched/sched.h:1701 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12635
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4845
       copy_process+0x2217/0x3df0 kernel/fork.c:2499
       kernel_clone+0x226/0x8f0 kernel/fork.c:2797
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

-> #0 (&sighand->siglock){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __lock_task_sighand+0x149/0x2e0 kernel/signal.c:1414
       lock_task_sighand include/linux/sched/signal.h:746 [inline]
       do_send_sig_info kernel/signal.c:1300 [inline]
       group_send_sig_info+0x274/0x310 kernel/signal.c:1453
       bpf_send_signal_common+0x2dd/0x430 kernel/trace/bpf_trace.c:881
       ____bpf_send_signal kernel/trace/bpf_trace.c:886 [inline]
       bpf_send_signal+0x19/0x30 kernel/trace/bpf_trace.c:884
       bpf_prog_da8cbe553dc44a71+0x22/0x29
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x5c8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x9b2/0x9d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1975
       bpf_prog_ec3b2eefa702d8d3+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
       native_flush_tlb_multi+0x78/0xd0
       __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
       flush_tlb_multi arch/x86/mm/tlb.c:941 [inline]
       flush_tlb_mm_range+0x330/0x5c0 arch/x86/mm/tlb.c:1027
       flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
       ptep_clear_flush+0x11a/0x170 mm/pgtable-generic.c:101
       wp_page_copy mm/memory.c:3329 [inline]
       do_wp_page+0x1c2e/0x4fd0 mm/memory.c:3660
       handle_pte_fault mm/memory.c:5316 [inline]
       __handle_mm_fault+0x264a/0x7240 mm/memory.c:5441
       handle_mm_fault+0x3c2/0x8a0 mm/memory.c:5606
       do_user_addr_fault arch/x86/mm/fault.c:1362 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x446/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

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

9 locks held by syz-executor188/5087:
 #0: ffff88805fd07ec8 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:677 [inline]
 #0: ffff88805fd07ec8 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x730 mm/memory.c:5762
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __pte_offset_map+0x82/0x380 mm/pgtable-generic.c:285
 #2: ffff888021a43738 (ptlock_ptr(ptdesc)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff888021a43738 (ptlock_ptr(ptdesc)#2){+.+.}-{2:2}, at: __pte_offset_map_lock+0x1ba/0x300 mm/pgtable-generic.c:373
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
 #4: ffff888025328b20 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:165 [inline]
 #4: ffff888025328b20 (&mm->mmap_lock){++++}-{3:3}, at: stack_map_get_build_id_offset+0x237/0x9d0 kernel/bpf/stackmap.c:141
 #5: ffff8880b95387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #5: ffff8880b95387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237
 #6: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #6: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #6: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: get_memcg_path_buf mm/mmap_lock.c:139 [inline]
 #6: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: get_mm_memcg_path+0xb1/0x600 mm/mmap_lock.c:209
 #7: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #7: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #7: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #7: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x490 kernel/trace/bpf_trace.c:2422
 #8: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #8: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #8: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __lock_task_sighand+0x29/0x2e0 kernel/signal.c:1397

stack backtrace:
CPU: 1 PID: 5087 Comm: syz-executor188 Not tainted 6.9.0-rc5-syzkaller-00185-g3e9bc0472b91 #0
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
 __lock_task_sighand+0x149/0x2e0 kernel/signal.c:1414
 lock_task_sighand include/linux/sched/signal.h:746 [inline]
 do_send_sig_info kernel/signal.c:1300 [inline]
 group_send_sig_info+0x274/0x310 kernel/signal.c:1453
 bpf_send_signal_common+0x2dd/0x430 kernel/trace/bpf_trace.c:881
 ____bpf_send_signal kernel/trace/bpf_trace.c:886 [inline]
 bpf_send_signal+0x19/0x30 kernel/trace/bpf_trace.c:884
 bpf_prog_da8cbe553dc44a71+0x22/0x29
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
 __mmap_lock_do_trace_acquire_returned+0x5c8/0x630 mm/mmap_lock.c:237
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
 stack_map_get_build_id_offset+0x9b2/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
 bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1975
 bpf_prog_ec3b2eefa702d8d3+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
 native_flush_tlb_multi+0x78/0xd0
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:941 [inline]
 flush_tlb_mm_range+0x330/0x5c0 arch/x86/mm/tlb.c:1027
 flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
 ptep_clear_flush+0x11a/0x170 mm/pgtable-generic.c:101
 wp_page_copy mm/memory.c:3329 [inline]
 do_wp_page+0x1c2e/0x4fd0 mm/memory.c:3660
 handle_pte_fault mm/memory.c:5316 [inline]
 __handle_mm_fault+0x264a/0x7240 mm/memory.c:5441
 handle_mm_fault+0x3c2/0x8a0 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1362 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x446/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f6a162a6260
Code: 41 54 55 48 89 f5 53 89 fb 48 83 ec 18 48 83 3d 8d 0d 0a 00 00 89 54 24 0c 74 08 84 c9 0f 85 09 02 00 00 31 c0 ba 01 00 00 00 <f0> 0f b1 15 80 3a 0a 00 0f 85 0f 02 00 00 4c 8d 25 73 3a 0a 00 4c
RSP: 002b:00007ffd4827c420 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 00007f6a16347120 RDI: 0000000000000000
RBP: 00007f6a16347120 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

