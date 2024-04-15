Return-Path: <bpf+bounces-26875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F78A5CD5
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4528B21804
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764D156C55;
	Mon, 15 Apr 2024 21:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF725601
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216023; cv=none; b=Tynp8DYiV1WKzwR+vsL5oq479n0Ts0lYsrGmP/zijxKqAl6mgqf7cm/cRU6nw7WNSOy5dwNNatFaBWsdWhRPbJj5uckAJ94LZgVAEQgkhpWeyrf83AjGy5WiJ4BGxvvQtHXRPzN7fTFA9fgj3sP+qwahHTID/N9326/Z+MWv42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216023; c=relaxed/simple;
	bh=iq12rZ7Kqkas5B3bX2diMVWjH4npPy7iNQbcxGS7ulk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=to8IRNFctrw5Zrq7LTallQK/v/oyN6X/FFZRLPbCk+sUTrNcJyoe96SsKyyxCkACpdJPrydRpK2m0DKA7PHbo/EelO/tUQkQXpB4wHUvWG8q9DWL8T3aXcM54PD+6U+YHFZHu3NDve8R9xbhvqsoJfNcUQE3BMJcNLF+nMhDehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso497459239f.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 14:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216020; x=1713820820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9fC8sMVBzWfsoqQnGxlfBwcb9vKWVeTN2TZHasQJnQ=;
        b=WRNzMWbciYVEvnfTy5XJtWN2eQHpF9f7EIwi/DK0bVouk2eRg1ozCH5lU66wZgAZpQ
         oRUSuo8ib1HARZQNEEdj/qEt0CvdyA8KTvxLCy2zj9AlL/gwXSYy6i50iunvvFLlWyPP
         5xxdOarmh0s8JEXvh7+XigAcuyXDAt7cZIK6mJKYmB+9wgI55qWJzfB2w9H9BA6DzBFp
         lkWuIEHI4AWupm99V3OW/4Xb70w0L6Iyao4+OLYdIJsRsSulbgr9rTebd6UYZjJLFjFA
         gy/3JxV1pUqa3sSKz0rr0BnVez3+Z0TWQNiS38QoSYGMJCqoTVqDV+T0C8a2IGct4jj/
         UoEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSzibxvPwy+/Aw9fjwKc7xlxUkiv503bE/kluxFwnkBISF9ub1YHsA0R8NoCTurcYSd+wTFNFi8P6JVgfB2nngX1yg
X-Gm-Message-State: AOJu0YwR6kElqScjwHPKfRktt/eS8tqTAUmEfudNuZubCDihty8T/EfT
	T59ZS4aAD97xmJTwu6/DAc2RnjI14MwjViFrPvh/pP9mSTggef72b3lOCWXZPo2CTHMgbrrdNMS
	U9tXq9IP6i32SQr1+FzzKRal7mdj5gPdOhLGcKQLhYhkNAM2ABC2a4QA=
X-Google-Smtp-Source: AGHT+IGs4KbY2ovcC82mPCsirTZer4Zb/Be+sRtQ9uf4L4eYKFR5tfNxAPu3ZJj1c2nxukX/sIqElP1zLSgNg7u7HysxXQf2ibhD
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2110:b0:482:cfdd:daeb with SMTP id
 n16-20020a056638211000b00482cfdddaebmr675534jaj.5.1713216020285; Mon, 15 Apr
 2024 14:20:20 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:20:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000501d2906162930ae@google.com>
Subject: [syzbot] [net?] [bpf?] possible deadlock in posix_timer_fn (2)
From: syzbot <syzbot+8502ad1d389eef66d297@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1445ef13180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=8502ad1d389eef66d297
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8502ad1d389eef66d297@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
-----------------------------------------------------
syz-executor.1/6034 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff8880798ca200 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880798ca200 (&stab->lock){+.-.}-{2:2}, at: __sock_map_delete net/core/sock_map.c:414 [inline]
ffff8880798ca200 (&stab->lock){+.-.}-{2:2}, at: sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446

and this task is already holding:
ffff88801ef96038 (&new_timer->it_lock){-.-.}-{2:2}, at: __lock_timer+0x211/0x4c0 kernel/time/posix-timers.c:595
which would create a new lock dependency:
 (&new_timer->it_lock){-.-.}-{2:2} -> (&stab->lock){+.-.}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&new_timer->it_lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  posix_timer_fn+0x2d/0x3e0 kernel/time/posix-timers.c:318
  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
  __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  check_kcov_mode kernel/kcov.c:175 [inline]
  __sanitizer_cov_trace_pc+0x33/0x60 kernel/kcov.c:207
  __orc_find+0x70/0x130 arch/x86/kernel/unwind_orc.c:99
  orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
  unwind_next_frame+0x335/0x23a0 arch/x86/kernel/unwind_orc.c:494
  arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
  stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
  poison_slab_object mm/kasan/common.c:240 [inline]
  __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
  kasan_slab_free include/linux/kasan.h:184 [inline]
  slab_free_hook mm/slub.c:2106 [inline]
  slab_free mm/slub.c:4280 [inline]
  kfree+0x129/0x370 mm/slub.c:4390
  kvfree+0x47/0x50 mm/util.c:680
  translate_table+0xc10/0x17b0 net/ipv6/netfilter/ip6_tables.c:728
  do_replace net/ipv6/netfilter/ip6_tables.c:1150 [inline]
  do_ip6t_set_ctl+0x5a8/0xbf0 net/ipv6/netfilter/ip6_tables.c:1636
  nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
  ipv6_setsockopt+0x133/0x1a0 net/ipv6/ipv6_sockglue.c:999
  tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3735
  do_sock_setsockopt+0x222/0x480 net/socket.c:2311
  __sys_setsockopt+0x1a4/0x270 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2340
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

to a HARDIRQ-irq-unsafe lock:
 (&stab->lock){+.-.}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_map_update_common+0x197/0x870 net/core/sock_map.c:490
  sock_map_update_elem_sys+0x3bb/0x570 net/core/sock_map.c:579
  bpf_map_update_value+0x36c/0x6c0 kernel/bpf/syscall.c:172
  map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
  __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5619
  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5736
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&stab->lock);
                               local_irq_disable();
                               lock(&new_timer->it_lock);
                               lock(&stab->lock);
  <Interrupt>
    lock(&new_timer->it_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.1/6034:
 #0: ffff88801ef96038 (&new_timer->it_lock){-.-.}-{2:2}, at: __lock_timer+0x211/0x4c0 kernel/time/posix-timers.c:595
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run3+0xf8/0x440 kernel/trace/bpf_trace.c:2421

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&new_timer->it_lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    posix_timer_fn+0x2d/0x3e0 kernel/time/posix-timers.c:318
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    check_kcov_mode kernel/kcov.c:175 [inline]
                    __sanitizer_cov_trace_pc+0x33/0x60 kernel/kcov.c:207
                    __orc_find+0x70/0x130 arch/x86/kernel/unwind_orc.c:99
                    orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
                    unwind_next_frame+0x335/0x23a0 arch/x86/kernel/unwind_orc.c:494
                    arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
                    kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
                    kasan_save_track+0x14/0x30 mm/kasan/common.c:68
                    kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
                    poison_slab_object mm/kasan/common.c:240 [inline]
                    __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
                    kasan_slab_free include/linux/kasan.h:184 [inline]
                    slab_free_hook mm/slub.c:2106 [inline]
                    slab_free mm/slub.c:4280 [inline]
                    kfree+0x129/0x370 mm/slub.c:4390
                    kvfree+0x47/0x50 mm/util.c:680
                    translate_table+0xc10/0x17b0 net/ipv6/netfilter/ip6_tables.c:728
                    do_replace net/ipv6/netfilter/ip6_tables.c:1150 [inline]
                    do_ip6t_set_ctl+0x5a8/0xbf0 net/ipv6/netfilter/ip6_tables.c:1636
                    nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
                    ipv6_setsockopt+0x133/0x1a0 net/ipv6/ipv6_sockglue.c:999
                    tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3735
                    do_sock_setsockopt+0x222/0x480 net/socket.c:2311
                    __sys_setsockopt+0x1a4/0x270 net/socket.c:2334
                    __do_sys_setsockopt net/socket.c:2343 [inline]
                    __se_sys_setsockopt net/socket.c:2340 [inline]
                    __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2340
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    posix_timer_fn+0x2d/0x3e0 kernel/time/posix-timers.c:318
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    check_kcov_mode kernel/kcov.c:173 [inline]
                    __sanitizer_cov_trace_pc+0x1e/0x60 kernel/kcov.c:207
                    u32_get_bits include/linux/bitfield.h:201 [inline]
                    __kfree_skb_reason net/core/skbuff.c:1227 [inline]
                    kfree_skb_reason+0x14a/0x210 net/core/skbuff.c:1251
                    __netif_receive_skb_core.constprop.0+0x57a/0x4030 net/core/dev.c:5512
                    __netif_receive_skb_one_core+0xb1/0x1e0 net/core/dev.c:5536
                    __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5652
                    process_backlog+0x12f/0x6f0 net/core/dev.c:5981
                    __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6632
                    napi_poll net/core/dev.c:6701 [inline]
                    net_rx_action+0x9ad/0xf10 net/core/dev.c:6813
                    __do_softirq+0x218/0x8de kernel/softirq.c:554
                    do_softirq kernel/softirq.c:455 [inline]
                    do_softirq+0xb2/0xf0 kernel/softirq.c:442
                    __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
                    local_bh_enable include/linux/bottom_half.h:33 [inline]
                    rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
                    __dev_queue_xmit+0x879/0x3ef0 net/core/dev.c:4362
                    dev_queue_xmit include/linux/netdevice.h:3091 [inline]
                    batadv_send_skb_packet+0x520/0x6b0 net/batman-adv/send.c:108
                    batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
                    batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
                    batadv_iv_send_outstanding_bat_ogm_packet+0x707/0x8c0 net/batman-adv/bat_iv_ogm.c:1700
                    process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                   __lock_timer+0x211/0x4c0 kernel/time/posix-timers.c:595
                   do_timer_settime+0x197/0x2f0 kernel/time/posix-timers.c:916
                   __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
                   __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
                   __x64_sys_timer_settime+0x26a/0x2c0 kernel/time/posix-timers.c:940
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff94689260>] __key.0+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&stab->lock){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_map_update_common+0x197/0x870 net/core/sock_map.c:490
                    sock_map_update_elem_sys+0x3bb/0x570 net/core/sock_map.c:579
                    bpf_map_update_value+0x36c/0x6c0 kernel/bpf/syscall.c:172
                    map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
                    __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5619
                    __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
                    __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
                    __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5736
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    __sock_map_delete net/core/sock_map.c:414 [inline]
                    sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
                    ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
                    __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
                    __bpf_trace_hrtimer_init+0x101/0x140 include/trace/events/timer.h:193
                    trace_hrtimer_init include/trace/events/timer.h:193 [inline]
                    debug_init kernel/time/hrtimer.c:472 [inline]
                    hrtimer_init+0x17c/0x210 kernel/time/hrtimer.c:1599
                    tcp_init_xmit_timers+0x40/0xc0 net/ipv4/tcp_timer.c:859
                    tcp_create_openreq_child+0x688/0x18e0 net/ipv4/tcp_minisocks.c:561
                    tcp_v6_syn_recv_sock+0x1d7/0x2670 net/ipv6/tcp_ipv6.c:1432
                    tcp_check_req+0x997/0x1fa0 net/ipv4/tcp_minisocks.c:854
                    tcp_v6_rcv+0x2423/0x35b0 net/ipv6/tcp_ipv6.c:1838
                    ip6_protocol_deliver_rcu+0x188/0x1530 net/ipv6/ip6_input.c:438
                    ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
                    NF_HOOK include/linux/netfilter.h:314 [inline]
                    NF_HOOK include/linux/netfilter.h:308 [inline]
                    ip6_input+0xa1/0xd0 net/ipv6/ip6_input.c:492
                    dst_input include/net/dst.h:460 [inline]
                    ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
                    NF_HOOK include/linux/netfilter.h:314 [inline]
                    NF_HOOK include/linux/netfilter.h:308 [inline]
                    ipv6_rcv+0x265/0x680 net/ipv6/ip6_input.c:310
                    __netif_receive_skb_one_core+0x12e/0x1e0 net/core/dev.c:5538
                    __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5652
                    process_backlog+0x12f/0x6f0 net/core/dev.c:5981
                    __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6632
                    napi_poll net/core/dev.c:6701 [inline]
                    net_rx_action+0x9ad/0xf10 net/core/dev.c:6813
                    __do_softirq+0x218/0x8de kernel/softirq.c:554
                    do_softirq kernel/softirq.c:455 [inline]
                    do_softirq+0xb2/0xf0 kernel/softirq.c:442
                    __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
                    local_bh_enable include/linux/bottom_half.h:33 [inline]
                    rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
                    __dev_queue_xmit+0x879/0x3ef0 net/core/dev.c:4362
                    dev_queue_xmit include/linux/netdevice.h:3091 [inline]
                    neigh_hh_output include/net/neighbour.h:526 [inline]
                    neigh_output include/net/neighbour.h:540 [inline]
                    ip6_finish_output2+0x1100/0x18b0 net/ipv6/ip6_output.c:137
                    __ip6_finish_output net/ipv6/ip6_output.c:211 [inline]
                    ip6_finish_output+0x3f9/0x1300 net/ipv6/ip6_output.c:222
                    NF_HOOK_COND include/linux/netfilter.h:303 [inline]
                    ip6_output+0x1eb/0x540 net/ipv6/ip6_output.c:243
                    dst_output include/net/dst.h:450 [inline]
                    NF_HOOK include/linux/netfilter.h:314 [inline]
                    NF_HOOK include/linux/netfilter.h:308 [inline]
                    ip6_xmit+0x125f/0x2030 net/ipv6/ip6_output.c:358
                    inet6_csk_xmit+0x3ce/0x740 net/ipv6/inet6_connection_sock.c:135
                    __tcp_transmit_skb+0x1adb/0x3dc0 net/ipv4/tcp_output.c:1462
                    __tcp_send_ack.part.0+0x390/0x720 net/ipv4/tcp_output.c:4232
                    __tcp_send_ack net/ipv4/tcp_output.c:4238 [inline]
                    tcp_send_ack+0x82/0xa0 net/ipv4/tcp_output.c:4238
                    tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6481 [inline]
                    tcp_rcv_state_process+0x42c4/0x4ec0 net/ipv4/tcp_input.c:6668
                    tcp_v6_do_rcv+0x42f/0x1680 net/ipv6/tcp_ipv6.c:1669
                    sk_backlog_rcv include/net/sock.h:1106 [inline]
                    __release_sock+0x14c/0x400 net/core/sock.c:2984
                    release_sock+0x5a/0x220 net/core/sock.c:3550
                    inet_wait_for_connect net/ipv4/af_inet.c:611 [inline]
                    __inet_stream_connect+0x774/0x1020 net/ipv4/af_inet.c:705
                    inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:750
                    __sys_connect_file+0x15f/0x1a0 net/socket.c:2048
                    __sys_connect+0x149/0x170 net/socket.c:2065
                    __do_sys_connect net/socket.c:2075 [inline]
                    __se_sys_connect net/socket.c:2072 [inline]
                    __x64_sys_connect+0x72/0xb0 net/socket.c:2072
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_map_update_common+0x197/0x870 net/core/sock_map.c:490
                   sock_map_update_elem_sys+0x3bb/0x570 net/core/sock_map.c:579
                   bpf_map_update_value+0x36c/0x6c0 kernel/bpf/syscall.c:172
                   map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
                   __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5619
                   __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
                   __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
                   __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5736
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff949c6800>] __key.1+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   __sock_map_delete net/core/sock_map.c:414 [inline]
   sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
   ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
   __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
   __bpf_trace_hrtimer_init+0x101/0x140 include/trace/events/timer.h:193
   trace_hrtimer_init include/trace/events/timer.h:193 [inline]
   debug_init kernel/time/hrtimer.c:472 [inline]
   hrtimer_init+0x17c/0x210 kernel/time/hrtimer.c:1599
   common_hrtimer_arm+0xd1/0x330 kernel/time/posix-timers.c:802
   common_timer_set+0x375/0x5a0 kernel/time/posix-timers.c:895
   do_timer_settime+0x1e8/0x2f0 kernel/time/posix-timers.c:925
   __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
   __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
   __x64_sys_timer_settime+0x26a/0x2c0 kernel/time/posix-timers.c:940
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 1 PID: 6034 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe3c/0x1490 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x248e/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete net/core/sock_map.c:414 [inline]
 sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
 __bpf_trace_hrtimer_init+0x101/0x140 include/trace/events/timer.h:193
 trace_hrtimer_init include/trace/events/timer.h:193 [inline]
 debug_init kernel/time/hrtimer.c:472 [inline]
 hrtimer_init+0x17c/0x210 kernel/time/hrtimer.c:1599
 common_hrtimer_arm+0xd1/0x330 kernel/time/posix-timers.c:802
 common_timer_set+0x375/0x5a0 kernel/time/posix-timers.c:895
 do_timer_settime+0x1e8/0x2f0 kernel/time/posix-timers.c:925
 __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
 __x64_sys_timer_settime+0x26a/0x2c0 kernel/time/posix-timers.c:940
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f36a507de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f36a5d840c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 00007f36a51abf80 RCX: 00007f36a507de69
RDX: 0000000020000280 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f36a50ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f36a51abf80 R15: 00007ffd2556e708
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 6034 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 6034 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 72 d0 b5 04 00 74 06 90 c3 cc cc cc cc c6 05 63 d0 b5 04 01 90 48 c7 c7 c0 b1 0c 8b e8 78 6b 7d f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000414fd58 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801ef96020 RCX: ffffc9000544b000
RDX: 0000000000040000 RSI: ffffffff814faff6 RDI: 0000000000000001
RBP: 0000000000000287 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 1ffff92000829fb1 R14: ffffffff817c41b0 R15: dffffc0000000000
FS:  00007f36a5d846c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 000000007be48000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x74/0x80 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_timer kernel/time/posix-timers.c:128 [inline]
 do_timer_settime+0x263/0x2f0 kernel/time/posix-timers.c:934
 __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
 __x64_sys_timer_settime+0x26a/0x2c0 kernel/time/posix-timers.c:940
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f36a507de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f36a5d840c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 00007f36a51abf80 RCX: 00007f36a507de69
RDX: 0000000020000280 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f36a50ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f36a51abf80 R15: 00007ffd2556e708
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

