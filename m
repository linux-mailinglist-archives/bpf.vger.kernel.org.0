Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD25927665E
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 04:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIXC0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 22:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIXC0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 22:26:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E60C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 19:26:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d15so2067103lfq.11
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 19:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MZDrOBUy8Nm2tqgqEjirPNSqElVkZuLZOrUq2vhcwdY=;
        b=o4E+Wuf3Kj9ZkaV9N1feIiwZBisLYjd38ZASPoOJcSwZ6loiprmYn0qCt5WRv2S5XA
         avQOTEPXF5ECzYg1ZPtHbli1K0nYDSFcWAk5WJOAyRGdze3V0U3HGQ3Eok3v+Q1uDgXX
         +qHUnCLaAQzIvgENqh1IioitSq3Hu2vQ7TikdzbtwV0NIz5MEyOUB9GhP+/mNSMSn+09
         6SFcQ+uLD+XcGhiTPXXHYZ3ZoNzQmwhN0Fg2MSCpaoHjS639cnt46Kavh4+5qsne/EMG
         XLncI7Ls15CfbVKG5j4pTP9Imp7BgrODIyIxWbrq/p1xDOKiG18Y2kF0iT+yNl/0/soC
         5CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MZDrOBUy8Nm2tqgqEjirPNSqElVkZuLZOrUq2vhcwdY=;
        b=Cf1HBsrakEtpZz0T+/RnhJ3+s8zG/C5IGvk64SAetIeTurJRGy7rcgHKCLQqrKCuEV
         a5ziImE1xtJJD2f4XGuJ+UsZjUyV4L5JKicz9OYN5RKaiKYIU5YmBYDx+99Ai5ZXhIlM
         WS2D772mU918sgOZLSo3Tc2ZeLRnSQE16gxeFoiwzfYx+NoVA5PMFswrNxF1cpNc+9zL
         fYirkgbT0PJ+FtN11xXC6XW54Eet6A1lHsjKFB0L0r2O2sHBaQRJ1jUFekkwRz159CSh
         JReD1lTB18EBtobUn7SeQWWmISBaCEOnKk83+4/7cpv5iembVvc9BhrqwDBZLRSfPK9m
         E0Ew==
X-Gm-Message-State: AOAM5329P45hIpNQnjqddMvOP0upApx2+4XmGjbc7XIT9PC0tYHC81Ho
        5pFM2sonQQUFCmo+Mbj3opVJqc1zTcVypn6iDYQ=
X-Google-Smtp-Source: ABdhPJzl/oVwSdg77rkt+4B5peLoAFfD/jtXRv1h1v9f5gjF+7yG6mHQgR+tNttAPZWYBIrtONpL1s3hbTn0OK1C4L0=
X-Received: by 2002:a19:8703:: with SMTP id j3mr871552lfd.477.1600914372590;
 Wed, 23 Sep 2020 19:26:12 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Sep 2020 19:26:01 -0700
Message-ID: <CAADnVQKyRVtFd9OnFpcc4_4qpeT1j0yNt4mB8D1E7gc14F8mRQ@mail.gmail.com>
Subject: splat in stacktrace_build_id_nmi
To:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

the latest bpf-next has 100% reproducible splat:
test_progs -t stacktrace_build_id_nmi
[   18.984806]
[   18.984807] ================================
[   18.984807] WARNING: inconsistent lock state
[   18.984808] 5.9.0-rc6-01771-g1466de1330e1 #2967 Not tainted
[   18.984809] --------------------------------
[   18.984809] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[   18.984810] test_progs/1990 [HC2[2]:SC0[0]:HE0:SE1] takes:
[   18.984810] ffffe8ffffc219c0 (&head->lock){....}-{2:2}, at:
__pcpu_freelist_pop+0xe3/0x180
[   18.984813] {INITIAL USE} state was registered at:
[   18.984814]   lock_acquire+0x175/0x7c0
[   18.984814]   _raw_spin_lock+0x2c/0x40
[   18.984815]   __pcpu_freelist_pop+0xe3/0x180
[   18.984815]   pcpu_freelist_pop+0x31/0x40
[   18.984816]   htab_map_alloc+0xbbf/0xf40
[   18.984816]   __do_sys_bpf+0x5aa/0x3ed0
[   18.984817]   do_syscall_64+0x2d/0x40
[   18.984818]   entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   18.984818] irq event stamp: 12
[   18.984819] hardirqs last  enabled at (11): [<ffffffff816953d4>]
get_page_from_freelist+0x1314/0x6190
[   18.984820] hardirqs last disabled at (12): [<ffffffff837e527d>]
irqentry_enter+0x1d/0x50
[   18.984821] softirqs last  enabled at (0): [<ffffffff8111011c>]
copy_process+0x147c/0x5c10
[   18.984821] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   18.984822]
[   18.984822] other info that might help us debug this:
[   18.984823]  Possible unsafe locking scenario:
[   18.984823]
[   18.984824]        CPU0
[   18.984824]        ----
[   18.984824]   lock(&head->lock);
[   18.984826]   <Interrupt>
[   18.984826]     lock(&head->lock);
[   18.984827]
[   18.984828]  *** DEADLOCK ***
[   18.984828]
[   18.984829] 2 locks held by test_progs/1990:
[   18.984829]  #0: ffff8881f52958e8 (&mm->mmap_lock#2){++++}-{3:3},
at: do_user_addr_fault+0x1cd/0x821
[   18.984832]  #1: ffff8881f6e39e20 (&cpuctx_lock){-...}-{2:2}, at:
perf_event_task_tick+0x12b/0xc90
[   18.984835]
[   18.984835] stack backtrace:
[   18.984836] CPU: 0 PID: 1990 Comm: test_progs Not tainted
5.9.0-rc6-01771-g1466de1330e1 #2967
[   18.984837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.11.0-2.el7 04/01/2014
[   18.984837] Call Trace:
[   18.984838]  <NMI>
[   18.984838]  dump_stack+0x9a/0xd0
[   18.984839]  lock_acquire+0x5c9/0x7c0
[   18.984839]  ? lock_release+0x6f0/0x6f0
[   18.984840]  ? __pcpu_freelist_pop+0xe3/0x180
[   18.984840]  _raw_spin_lock+0x2c/0x40
[   18.984841]  ? __pcpu_freelist_pop+0xe3/0x180
[   18.984841]  __pcpu_freelist_pop+0xe3/0x180
[   18.984842]  pcpu_freelist_pop+0x17/0x40
[   18.984842]  ? lock_release+0x6f0/0x6f0
[   18.984843]  __bpf_get_stackid+0x534/0xaf0
[   18.984843]  bpf_prog_1fd9e30e1438d3c5_oncpu+0x73/0x350
[   18.984844]  bpf_overflow_handler+0x12f/0x3f0
[   18.984844]  ? perf_event_text_poke_output+0x7b0/0x7b0
[   18.984845]  __perf_event_overflow+0x11b/0x320
[   18.984846]  handle_pmi_common+0x3d4/0x5f0
[   18.984846]  ? intel_pmu_save_and_restart+0xe0/0xe0
[   18.984847]  intel_pmu_handle_irq+0x174/0x360
[   18.984847]  perf_event_nmi_handler+0x3a/0x60
[   18.984848]  nmi_handle+0x160/0x410
[   18.984848]  default_do_nmi+0x40/0xf0
[   18.984849]  exc_nmi+0xfc/0x120
[   18.984849]  end_repeat_nmi+0x16/0x55
[   18.984850] RIP: 0010:__intel_pmu_enable_all.constprop.0+0x82/0x170
[   18.984851] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 d3 00 00 00 48
8b 83 b8 0c 00 00 b9 8f 03 00 00 48 f7 d0 48 21 e8 48 89 c2 48 c1 ea
20 0f 30 <0f> 1f 44 00 00 48 8d ab 00 02 00 00 be 08 00 00 00 48 89 ef
e8 a5
[   18.984852] RSP: 0000:ffff8881f6e09d18 EFLAGS: 00000002
[   18.984853] RAX: 000000070000000f RBX: ffff8881f6e195e0 RCX: 000000000000038f
[   18.984853] RDX: 0000000000000007 RSI: ffffffff84b2c120 RDI: ffff8881f6e1a298
[   18.984854] RBP: 000000070000000f R08: 0000000000000000 R09: ffff8881ec435600
[   18.984855] R10: ffffffff84a389e0 R11: fffffbfff0a26294 R12: ffffffff84a389e0
[   18.984855] R13: ffff8881f6e39c64 R14: dffffc0000000000 R15: ffff8881f6e39f08
[   18.984856]  ? __intel_pmu_enable_all.constprop.0+0x82/0x170
[   18.984857]  ? __intel_pmu_enable_all.constprop.0+0x82/0x170
[   18.984857]  </NMI>
[   18.984857]  <IRQ>
[   18.984858]  perf_event_task_tick+0x743/0xc90
[   18.984859]  scheduler_tick+0x1d6/0x4d0
[   18.984859]  ? tick_sched_do_timer+0x150/0x150
[   18.984860]  update_process_times+0x37/0x90
[   18.984860]  tick_sched_handle.isra.0+0x6a/0x130
[   18.984861]  tick_sched_timer+0xca/0x100
[   18.984861]  __hrtimer_run_queues+0x48d/0xaa0
[   18.984862]  ? enqueue_hrtimer+0x2e0/0x2e0
[   18.984862]  hrtimer_interrupt+0x2c6/0x730
[   18.984863]  ? rcu_read_lock_bh_held+0x90/0x90
[   18.984863]  __sysvec_apic_timer_interrupt+0xf5/0x4a0
[   18.984864]  asm_call_on_stack+0xf/0x20
[   18.984864]  </IRQ>
[   18.984865]  sysvec_apic_timer_interrupt+0x89/0xa0
[   18.984866]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   18.984866] RIP: 0010:filter_irq_stacks+0x3c/0x50
[   18.984867] Code: f9 60 01 80 83 72 0d 48 81 f9 f0 0d 80 83 73 04
83 c0 01 c3 48 81 f9 00 00 a0 83 72 09 48 81 f9 93 08 a0 83 72 ea 48
8d 42 01 <4c> 39 c2 74 05 48 89 c2 eb c4 89 f0 c3 31 c0 c3 0f 1f 40 00
8b 15
[   18.984868] RSP: 0000:ffff8881e6357ae8 EFLAGS: 00000283
[   18.984869] RAX: 0000000000000001 RBX: ffff8881e70dc6a0 RCX: ffffffff816f9ecb
[   18.984870] RDX: 0000000000000000 RSI: 0000000000000009 RDI: ffff8881e6357af0
[   18.984870] RBP: 0000000000000cc0 R08: 0000000000000008 R09: ffff8881ec435600
[   18.984871] R10: ffffffff851314a7 R11: fffffbfff0a26294 R12: 0000000000000cc0
[   18.984872] R13: 0000000000000000 R14: ffff8881f5c4d400 R15: 0000000000000040
[   18.984872]  ? kasan_save_stack+0x1b/0x40
[   18.984873]  kasan_save_stack+0x25/0x40
[   18.984873]  ? kasan_save_stack+0x1b/0x40
[   18.984874]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[   18.984874]  ? kmem_cache_alloc+0x1e7/0x880
[   18.984875]  ? ptlock_alloc+0x1e/0x60
[   18.984875]  ? pte_alloc_one+0x24/0xc0
[   18.984876]  ? handle_mm_fault+0x2b0f/0x3710
[   18.984876]  ? do_user_addr_fault+0x35a/0x821
[   18.984877]  ? exc_page_fault+0x58/0xc0
[   18.984878]  ? asm_exc_page_fault+0x1e/0x30
[   18.984878]  ? lockdep_hardirqs_on_prepare+0x4f0/0x4f0
[   18.984879]  ? rcu_read_lock_sched_held+0x81/0xb0
[   18.984879]  ? fs_reclaim_release+0xf/0x30
[   18.984880]  ? rcu_read_lock_sched_held+0x81/0xb0
[   18.984880]  ? find_held_lock+0x2d/0x110
[   18.984881]  ? fs_reclaim_release+0xf/0x30
[   18.984881]  ? lock_downgrade+0x6b0/0x6b0
[   18.984882]  ? kasan_unpoison_shadow+0x33/0x40
[   18.984882]  __kasan_kmalloc.constprop.0+0xc2/0xd0
[   18.984883]  ? ptlock_alloc+0x1e/0x60
[   18.984883]  kmem_cache_alloc+0x1e7/0x880
[   18.984884]  ptlock_alloc+0x1e/0x60
[   18.984884]  pte_alloc_one+0x24/0xc0
[   18.984885]  handle_mm_fault+0x2b0f/0x3710
[   18.984886]  ? copy_page_range+0x1790/0x1790
[   18.984886]  do_user_addr_fault+0x35a/0x821
[   18.984887]  exc_page_fault+0x58/0xc0
[   18.984887]  ? asm_exc_page_fault+0x8/0x30
[   18.984888]  asm_exc_page_fault+0x1e/0x30
[   18.984888] RIP: 0033:0x7fb017f881aa
[   18.984889] Code: Bad RIP value.
[   18.984889] RSP: 002b:00007ffc867c5fe0 EFLAGS: 00010246
[   18.984890] RAX: 0000000000000000 RBX: 0000000000ea9c98 RCX: 00007fb017f881aa
[   18.984891] RDX: 00007ffc867c5fec RSI: 0000000000000000 RDI: 0000000000100011
[   18.984892] RBP: 0000000000000001 R08: 00007fb0182e64a0 R09: 0000000000000000
[   18.984892] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc867c6030
[   18.984893] R13: 0000000000eb2092 R14: 00007fb018f55690 R15: 0000000004572280

Not sure what changed. Pls take a look.
