Return-Path: <bpf+bounces-26952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802618A6D3E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E0A1F2230C
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8B12CD90;
	Tue, 16 Apr 2024 14:04:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6D12C534
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276271; cv=none; b=IEiZg9laoP6u1K1jK6fJBOvgMjDCbs0tV6vD7hih1NGTWBeFoAWBIyYZ6X5Ut65J21zBGZrZDUn1eRm8O2npJHdhslIMUdthRk9LmpFdrNuemJjpLII2x7l1nIbmKnMDRL6lid7zyJo8tTtFQQTMIKW05+WqtgaDuDJcLsJtKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276271; c=relaxed/simple;
	bh=6WM//QNMCzwnoO96xiEBkF6WsMgp7MAfoIEyTsr/5Wg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tSsUdtwLH9Ke4DD2Szouog8x5ojDHGZyynBtLn4AOdEhJGQ2yxLjHFUcJs8f4xcEf8CCLYfSwGkL/5QDywpznSA0yCg06Yp1VCK3aDV6QajnbMxUA4KwzQHlBblS2JOeEGpTRFBCmwxKwH41frzKazLVuzQ1jReExuaIazJAmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso473301839f.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276267; x=1713881067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0ME+uulvq6b0JKRFkPY3cBPhkIqJAb9pfgVeaHfc7I=;
        b=CUfZMt5eoLmgojXwoSDxl2Ippqk1plYt6iXVHVqngi7v3ZOtdFc+AUhgfSGecgig8L
         16J0GVKUf3G27geYNU5j+6eKL74Ommc+EaLbg9hYxglF4925xdeaI8uN76AfO8u7+C+A
         aItdzcJst8oaWbkAkhKF1DiDh2i+IY7sXjs7vp4tyhKrvaGKQsJ7r60x6cCf9kBgAQrO
         AcvY98TzckLpIJpJD7htNyAz3vkdvbQOCMOkbm91gRxcu2nxJQQGDR+U9x1T9cweFsJO
         z7FnyVj2LSZjxt4Fofso4pxBUFsaZE/AB7u+QamLXyzL6JxukLUtZNlIGdga6YE74d0i
         XztA==
X-Forwarded-Encrypted: i=1; AJvYcCXA2gyj+sszrYtmol72AGaaM1wNlEO+h+btJ6wcAz5bTk/tu72NIhxO6nVFdExo/WDEAVaYH+6EhcKqvt1gGrlQFLUn
X-Gm-Message-State: AOJu0Yz/+ONX39l0EV0gdnjWH3fhDoB/DMbsP/gp11bJhZLFbOPVAEx7
	AAR/3XOtsu7x05rveUNy9uOR13wrsLvxR123qA3B3Fo2akEbtQSrOeGCl3bzssKw+B2V7Ls1EtJ
	8C29+QpFAQn0HzbV4FOD+hvpPhbskt/yKpM5kgJuq3pPeiO6TSm9M72c=
X-Google-Smtp-Source: AGHT+IEsp36VkCvkFrIwrgAtTJUcAD2IL+94hoq1UWHOvDwh2JDnLhoPbLQeu/2+3ad+WgNPMmqjuxVBrpbSoOczCbn9DnkyVTFL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:36a:3f29:e953 with SMTP id
 y8-20020a056e02174800b0036a3f29e953mr1052518ill.0.1713276267537; Tue, 16 Apr
 2024 07:04:27 -0700 (PDT)
Date: Tue, 16 Apr 2024 07:04:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000543b530616373773@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in rcu_exp_handler
From: syzbot <syzbot+bd6fc91e2bdea0a7c04e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1055dbcb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=bd6fc91e2bdea0a7c04e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c8aaf5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be4961180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd6fc91e2bdea0a7c04e@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
-----------------------------------------------------
rcu_exp_gp_kthr/18 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88807d045200 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88807d045200 (&stab->lock){+...}-{2:2}, at: __sock_map_delete net/core/sock_map.c:414 [inline]
ffff88807d045200 (&stab->lock){+...}-{2:2}, at: sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446

and this task is already holding:
ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
which would create a new lock dependency:
 (rcu_node_0){-.-.}-{2:2} -> (&stab->lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (rcu_node_0){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  rcu_exp_handler+0xb7/0x350 kernel/rcu/tree_exp.h:725
  csd_do_func kernel/smp.c:133 [inline]
  __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
  __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
  instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
  sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
  __text_poke+0xa51/0xd30
  text_poke arch/x86/kernel/alternative.c:1985 [inline]
  text_poke_bp_batch+0x59c/0xb30 arch/x86/kernel/alternative.c:2318
  text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
  text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2494
  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
  static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
  toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&stab->lock){+...}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  __sock_map_delete net/core/sock_map.c:414 [inline]
  sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
  0xffffffffa0001fca
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
  trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
  __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
  futex_cleanup_begin kernel/futex/core.c:1091 [inline]
  futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
  exit_mm_release+0x1a/0x30 kernel/fork.c:1652
  exit_mm+0xb0/0x310 kernel/exit.c:542
  do_exit+0x99e/0x27e0 kernel/exit.c:865
  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
  __do_sys_exit_group kernel/exit.c:1038 [inline]
  __se_sys_exit_group kernel/exit.c:1036 [inline]
  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
  do_syscall_64+0xfb/0x240
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&stab->lock);
                               local_irq_disable();
                               lock(rcu_node_0);
                               lock(&stab->lock);
  <Interrupt>
    lock(rcu_node_0);

 *** DEADLOCK ***

2 locks held by rcu_exp_gp_kthr/18:
 #0: ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (rcu_node_0){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    rcu_exp_handler+0xb7/0x350 kernel/rcu/tree_exp.h:725
                    csd_do_func kernel/smp.c:133 [inline]
                    __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
                    __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
                    instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
                    sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
                    asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
                    __text_poke+0xa51/0xd30
                    text_poke arch/x86/kernel/alternative.c:1985 [inline]
                    text_poke_bp_batch+0x59c/0xb30 arch/x86/kernel/alternative.c:2318
                    text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
                    text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2494
                    arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
                    static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
                    static_key_enable+0x1a/0x20 kernel/jump_label.c:218
                    toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    rcu_report_qs_rdp kernel/rcu/tree.c:2018 [inline]
                    rcu_check_quiescent_state kernel/rcu/tree.c:2100 [inline]
                    rcu_core+0x3ae/0x1830 kernel/rcu/tree.c:2455
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __sanitizer_cov_trace_cmp8+0x8/0x90 kernel/kcov.c:284
                    on_stack arch/x86/include/asm/stacktrace.h:60 [inline]
                    unwind_next_frame+0x1df5/0x2a00 arch/x86/kernel/unwind_orc.c:665
                    arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                    poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
                    __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
                    kasan_kmalloc include/linux/kasan.h:211 [inline]
                    kmalloc_trace+0x1d9/0x360 mm/slub.c:4012
                    kmalloc include/linux/slab.h:590 [inline]
                    kzalloc include/linux/slab.h:711 [inline]
                    ddebug_add_module+0x88/0x800 lib/dynamic_debug.c:1240
                    dynamic_debug_init+0x205/0x5a0 lib/dynamic_debug.c:1446
                    do_one_initcall+0x238/0x830 init/main.c:1241
                    do_pre_smp_initcalls+0x57/0xa0 init/main.c:1347
                    kernel_init_freeable+0x40d/0x5d0 init/main.c:1546
                    kernel_init+0x1d/0x2a0 init/main.c:1446
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   rcutree_prepare_cpu+0x71/0x640 kernel/rcu/tree.c:4484
                   rcu_init+0x9b/0x140 kernel/rcu/tree.c:5224
                   start_kernel+0x1f7/0x500 init/main.c:969
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff945012e0>] rcu_init_one.rcu_node_class+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&stab->lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    __sock_map_delete net/core/sock_map.c:414 [inline]
                    sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
                    0xffffffffa0001fca
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                    trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                    __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                    __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                    futex_cleanup_begin kernel/futex/core.c:1091 [inline]
                    futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
                    exit_mm_release+0x1a/0x30 kernel/fork.c:1652
                    exit_mm+0xb0/0x310 kernel/exit.c:542
                    do_exit+0x99e/0x27e0 kernel/exit.c:865
                    do_group_exit+0x207/0x2c0 kernel/exit.c:1027
                    __do_sys_exit_group kernel/exit.c:1038 [inline]
                    __se_sys_exit_group kernel/exit.c:1036 [inline]
                    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   __sock_map_delete net/core/sock_map.c:414 [inline]
                   sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
                   0xffffffffa0001fca
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                   futex_cleanup_begin kernel/futex/core.c:1091 [inline]
                   futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
                   exit_mm_release+0x1a/0x30 kernel/fork.c:1652
                   exit_mm+0xb0/0x310 kernel/exit.c:542
                   do_exit+0x99e/0x27e0 kernel/exit.c:865
                   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
                   __do_sys_exit_group kernel/exit.c:1038 [inline]
                   __se_sys_exit_group kernel/exit.c:1036 [inline]
                   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff948822e0>] sock_map_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   __sock_map_delete net/core/sock_map.c:414 [inline]
   sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
   bpf_prog_2c29ac5cdc6b1842+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
   trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
   __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
   pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
   queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
   do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
   _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
   sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
   synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
   synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
   rcu_exp_wait_wake kernel/rcu/tree_exp.h:641 [inline]
   rcu_exp_sel_wait_wake+0x628/0x1df0 kernel/rcu/tree_exp.h:675
   kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 18 Comm: rcu_exp_gp_kthr Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage kernel/locking/lockdep.c:2865 [inline]
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x4dc7/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete net/core/sock_map.c:414 [inline]
 sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
 rcu_exp_wait_wake kernel/rcu/tree_exp.h:641 [inline]
 rcu_exp_sel_wait_wake+0x628/0x1df0 kernel/rcu/tree_exp.h:675
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 18 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 18 Comm: rcu_exp_gp_kthr Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d de 69 01 04 00 74 06 90 c3 cc cc cc cc c6 05 cf 69 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 e5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000177bb8 EFLAGS: 00010246
RAX: e87b85538c54f900 RBX: 1ffff9200002ef7c RCX: ffff8880172c1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000177c48 R08: ffffffff8157cc12 R09: 1ffff9200002eecc
R10: dffffc0000000000 R11: fffff5200002eecd R12: dffffc0000000000
R13: 1ffff9200002ef78 R14: ffffc90000177be0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555662d0ca8 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
 sync_rcu_exp_done_unlocked+0xdb/0x140 kernel/rcu/tree_exp.h:171
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
 rcu_exp_wait_wake kernel/rcu/tree_exp.h:641 [inline]
 rcu_exp_sel_wait_wake+0x628/0x1df0 kernel/rcu/tree_exp.h:675
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
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

