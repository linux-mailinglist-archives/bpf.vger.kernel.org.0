Return-Path: <bpf+bounces-44111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255739BDF30
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 08:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9822284D81
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F881991CE;
	Wed,  6 Nov 2024 07:14:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A918FDD0
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877262; cv=none; b=W4yW/ZuH7BETvq0apOKPZPeoiTkQ/POUapD+NxZnlghaRicyqZlNfBsUqtl7roMsXLAdD+T7cFEhBwtjrPhrHON7KoUwS6lWab3xlINpFjZqjiqN9nta0FbEu6zn+rSuVxRP0QpvngPxFVLDspFuQnU5zPUsxlUUttCkg1DsJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877262; c=relaxed/simple;
	bh=HoPLCEtJ7iRS3AyzIkDN2qiB7qx/sArujfn/v7d2Gdw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L/eN2cdV2SaEP84JNPjUUcEXBmDGyff8YJvLOn3KBwxHVp1m2pdnR55EWHs8/IOEgExMSgwGLcp4HzahzBgsbkUj55HZeilJ7Jb5zfMuM9WO73ohKjWMQs4tciRtjP+8vNdW5ifx5IVxY5JTmY0A2+1nk4l0ORlYsjD063uDQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so67952685ab.3
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 23:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730877260; x=1731482060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/B+cWPxBeOxRe1pYJh/a6kS5ROuWiwCsQ/OVpWEc4w=;
        b=lnlBU6wwZR/pOHMMFl8cwN5g5MGPjNM+HfmllyixCphtgM985F2jX4A9a6rPKJVqcv
         ekpkhJMcgkIOhceOn+qDc/F9ONRHgWXXms7pQBEk242BPvQpdv/KMS2SVPBxYu2Ja8PC
         EH6RLqxVq1Gd6mzOE3y5pMzJGrB/t4QQnVTW+au1Y4M9RqYRmhCB4NYqN+BcDjtiOYcL
         fBdx6JXwHazeoGGW189dp5HwgSDv1kpggtAIJzmhIBHxm3Cljof0dzXm68uzDAzIZPh4
         whlnq6PJZvsKwnVbpsZ9qxzqGg2BpRQkMIwOgoIa6i69bQSxr2F3+1vDjS/zmF5/CN0D
         s2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXaj/6wWSlx3nfnStmWAfs6Bp2KWKZl2Y2DWsC7huoNxDOIn5Qbt8MHxrGo99pQ5prmnzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnlaldp4if1oFt0VCVzG63LtW2YV+xAWuwXvtRDxDvmeQIByO
	LUGYjZm7zv9Bkah0TSOQTRHFUPcJok0/l9Js6fR50HvEjz1y0vht3j38VYZZDgDfpNhyQ05veMY
	fbGVG+/aIHzrenZ9uTaBu11aQmspywLU+JEPqWvUrbewKp8NhjV9o1cY=
X-Google-Smtp-Source: AGHT+IHI/AwK0O43azk2fddVpU0qbathXZO2wb4Gyw8n+wtQ9uBOMSUf+vVj9s5b7OyH8uWej9Py8BejLrhaypEr+7AwuGe9Fwxu
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a6:c1ef:f320 with SMTP id
 e9e14a558f8ab-3a6c1eff451mr140908855ab.18.1730877259726; Tue, 05 Nov 2024
 23:14:19 -0800 (PST)
Date: Tue, 05 Nov 2024 23:14:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b174b.050a0220.2edce.151f.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in work_grab_pending (2)
From: syzbot <syzbot+ae3633ca70dce1eee4e1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbb9a7ef3478 net: fjes: use ethtool string helpers
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1733c987980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=ae3633ca70dce1eee4e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df61ec56738e/disk-dbb9a7ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ad9020b8df8/vmlinux-dbb9a7ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1b9e903e0c9/bzImage-dbb9a7ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae3633ca70dce1eee4e1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-syzkaller-01053-gdbb9a7ef3478 #0 Not tainted
------------------------------------------------------
syz.4.2526/15232 is trying to acquire lock:
ffff88801aca0018 (&pool->lock){-.-.}-{2:2}, at: try_to_grab_pending kernel/workqueue.c:2081 [inline]
ffff88801aca0018 (&pool->lock){-.-.}-{2:2}, at: work_grab_pending+0x294/0xae0 kernel/workqueue.c:2157

but task is already holding lock:
ffff8880b8729430 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:3312 [inline]
ffff8880b8729430 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3725 [inline]
ffff8880b8729430 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3811

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (krc.lock){..-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       krc_this_cpu_lock kernel/rcu/tree.c:3312 [inline]
       add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3725 [inline]
       kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3811
       trie_delete_elem+0x546/0x6a0 kernel/bpf/lpm_trie.c:540
       0xffffffffa000206f
       bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2316 [inline]
       bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2359
       __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2340/0x4bd0 kernel/sched/core.c:6687
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6869
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6893
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       class_preempt_destructor include/linux/preempt.h:480 [inline]
       try_to_wake_up+0x9f3/0x14b0 kernel/sched/core.c:4288
       wake_up_process kernel/sched/core.c:4414 [inline]
       wake_up_q+0xc8/0x120 kernel/sched/core.c:1067
       futex_wake+0x523/0x5c0 kernel/futex/waitwake.c:199
       do_futex+0x392/0x560 kernel/futex/syscalls.c:107
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
       raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:700
       cgroup_move_task+0x9b/0x5a0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6692
       copy_process+0x39e9/0x3d50 kernel/fork.c:2598
       kernel_clone+0x226/0x8f0 kernel/fork.c:2784
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2862
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47f/0x500 init/main.c:1105
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xbe/0x14b0 kernel/sched/core.c:4165
       create_worker+0x507/0x720 kernel/workqueue.c:2825
       workqueue_init+0x520/0x8a0 kernel/workqueue.c:7902
       kernel_init_freeable+0x3fe/0x5d0 init/main.c:1564
       kernel_init+0x1d/0x2b0 init/main.c:1469
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       try_to_grab_pending kernel/workqueue.c:2081 [inline]
       work_grab_pending+0x294/0xae0 kernel/workqueue.c:2157
       mod_delayed_work_on+0xd4/0x370 kernel/workqueue.c:2585
       kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3839
       trie_update_elem+0x7e5/0xc00 kernel/bpf/lpm_trie.c:441
       bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
       generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1849
       bpf_map_do_batch+0x39a/0x660 kernel/bpf/syscall.c:5162
       __sys_bpf+0x377/0x810
       __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &rq->__lock --> krc.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(krc.lock);
                               lock(&rq->__lock);
                               lock(krc.lock);
  lock(&pool->lock);

 *** DEADLOCK ***

3 locks held by syz.4.2526/15232:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff8880b8729430 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:3312 [inline]
 #1: ffff8880b8729430 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3725 [inline]
 #1: ffff8880b8729430 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3811
 #2: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: try_to_grab_pending kernel/workqueue.c:2072 [inline]
 #2: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: work_grab_pending+0x1d3/0xae0 kernel/workqueue.c:2157

stack backtrace:
CPU: 1 UID: 0 PID: 15232 Comm: syz.4.2526 Not tainted 6.12.0-rc5-syzkaller-01053-gdbb9a7ef3478 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 try_to_grab_pending kernel/workqueue.c:2081 [inline]
 work_grab_pending+0x294/0xae0 kernel/workqueue.c:2157
 mod_delayed_work_on+0xd4/0x370 kernel/workqueue.c:2585
 kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3839
 trie_update_elem+0x7e5/0xc00 kernel/bpf/lpm_trie.c:441
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1849
 bpf_map_do_batch+0x39a/0x660 kernel/bpf/syscall.c:5162
 __sys_bpf+0x377/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdcb177e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdcb2645038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fdcb1935f80 RCX: 00007fdcb177e719
RDX: 0000000000000038 RSI: 0000000020000000 RDI: 000000000000001a
RBP: 00007fdcb17f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdcb1935f80 R15: 00007ffe264ea148
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

