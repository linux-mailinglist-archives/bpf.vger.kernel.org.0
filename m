Return-Path: <bpf+bounces-7674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C877A584
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 10:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2017C280F36
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FE1FAD;
	Sun, 13 Aug 2023 08:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50617C5
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 08:07:06 +0000 (UTC)
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D6D170C
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 01:07:03 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-55c79a55650so6277254a12.0
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 01:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691914023; x=1692518823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7H9zGl7PZWJpK0O2E41NLnxQC0WReIVhUSiz1uDMDU=;
        b=PiBy/NkDtazAXP65a3fsvrV5/shU+c0v7jdEWl9AKwdkSVoGT5mr3hjhKvAcMIgl/P
         Ef7Rgjh77nzl4BVTF13PPDc97ZebcBteAPtWy+mHdvT34QjV6y7tat7i6WkLOhWE2seV
         ODeoSQiTkkxYzkoYF0a78P4fAVm2MRDmH785xFPvSs4dT/L0KQsxeFjFnzgHF9WBpAn+
         HuFkz5Ek/bwZyN+i3CvRNUnboR0KGsTqKmbLQ81W2vlc3CrL+dmzfVncu5YcXZnrhpwE
         mXJwFev0B327j3N9GiXeXuMw6tyO4KeTXmYRboXugyzN9z1nK4ISA9Q0TthJG9c1Sr43
         4XBg==
X-Gm-Message-State: AOJu0Yxznz1donUHJb23CGoHppsy1CQxWTs6LGt1jdp6iDdYZ0B4GyjG
	wQb8/EUzEau1sZ05irNLnzhzNzf01CyGHxn+5MEMu2PRKqyv
X-Google-Smtp-Source: AGHT+IFXexOk6F8zRZzPN43rAYKs9p+VkMr06h4y6tfyae5hzFAGt8xIdK5+z8aicwBawFFwLTOekC18GsD6D8OejN0Dwp4sPwBh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:344b:0:b0:563:adcb:8c46 with SMTP id
 b72-20020a63344b000000b00563adcb8c46mr1314981pga.10.1691914023301; Sun, 13
 Aug 2023 01:07:03 -0700 (PDT)
Date: Sun, 13 Aug 2023 01:07:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000597a320602c96ea0@google.com>
Subject: [syzbot] [net?] possible deadlock in br_forward_delay_timer_expired
From: syzbot <syzbot+9e1986cb61510a8ada32@syzkaller.appspotmail.com>
To: andy@greyhouse.net, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, j.vosburgh@gmail.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    d14eea09edf4 net: core: remove unnecessary frame_sz check ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15321525a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=9e1986cb61510a8ada32
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dd4e64d718cc/disk-d14eea09.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d81468167b0/vmlinux-d14eea09.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a59df207999/bzImage-d14eea09.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e1986cb61510a8ada32@syzkaller.appspotmail.com

bond0: left promiscuous mode
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.5.0-rc4-syzkaller-00186-gd14eea09edf4 #0 Not tainted
-----------------------------------------------------
syz-executor.5/29194 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
ffff888028b2cd18 (&bond->stats_lock/1){+.+.}-{2:2}, at: bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427

and this task is already holding:
ffff88802d3b0c98 (&br->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802d3b0c98 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink net/bridge/br_netlink.c:1199 [inline]
ffff88802d3b0c98 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink+0x3e/0x190 net/bridge/br_netlink.c:1187
which would create a new lock dependency:
 (&br->lock){+.-.}-{2:2} -> (&bond->stats_lock/1){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&br->lock){+.-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5761 [inline]
  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  br_forward_delay_timer_expired+0x4f/0x560 net/bridge/br_stp_timer.c:86
  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
  expire_timers kernel/time/timer.c:1751 [inline]
  __run_timers+0x764/0xb10 kernel/time/timer.c:2022
  run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
  __do_softirq+0x218/0x965 kernel/softirq.c:553
  invoke_softirq kernel/softirq.c:427 [inline]
  __irq_exit_rcu kernel/softirq.c:632 [inline]
  irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
  lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5729
  rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
  rcu_read_lock include/linux/rcupdate.h:749 [inline]
  is_bpf_text_address+0x38/0x1a0 kernel/bpf/core.c:719
  kernel_text_address kernel/extable.c:125 [inline]
  kernel_text_address+0x85/0xf0 kernel/extable.c:94
  __kernel_text_address+0xd/0x30 kernel/extable.c:79
  unwind_get_return_address+0x55/0xa0 arch/x86/kernel/unwind_orc.c:369
  arch_stack_walk+0x9d/0xf0 arch/x86/kernel/stacktrace.c:26
  stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
  __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
  task_work_add+0x88/0x2a0 kernel/task_work.c:48
  fput fs/file_table.c:440 [inline]
  fput+0xed/0x1a0 fs/file_table.c:433
  filp_close+0x130/0x1b0 fs/open.c:1523
  close_fd+0x76/0xa0 fs/file.c:665
  __do_sys_close fs/open.c:1536 [inline]
  __se_sys_close fs/open.c:1534 [inline]
  __x64_sys_close+0x31/0x90 fs/open.c:1534
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

to a SOFTIRQ-irq-unsafe lock:
 (&bond->stats_lock/1){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5761 [inline]
  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427
  dev_get_stats+0xb5/0x470 net/core/dev.c:10424
  rtnl_fill_stats+0x48/0xa80 net/core/rtnetlink.c:1261
  rtnl_fill_ifinfo+0x18b5/0x47b0 net/core/rtnetlink.c:1868
  rtmsg_ifinfo_build_skb+0x14d/0x270 net/core/rtnetlink.c:4024
  rtmsg_ifinfo_event net/core/rtnetlink.c:4058 [inline]
  rtmsg_ifinfo_event net/core/rtnetlink.c:4048 [inline]
  rtnetlink_event+0xef/0x1f0 net/core/rtnetlink.c:6479
  notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
  call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
  call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
  call_netdevice_notifiers net/core/dev.c:2014 [inline]
  netdev_features_change net/core/dev.c:1325 [inline]
  netdev_change_features+0x82/0xb0 net/core/dev.c:9805
  bond_compute_features+0x4ec/0x810 drivers/net/bonding/bond_main.c:1496
  bond_enslave+0x3116/0x5d00 drivers/net/bonding/bond_main.c:2219
  do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2661
  do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2860
  __rtnl_newlink+0xc04/0x18c0 net/core/rtnetlink.c:3655
  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
  rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
  netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
  netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
  netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
  sock_sendmsg_nosec net/socket.c:725 [inline]
  sock_sendmsg+0xd9/0x180 net/socket.c:748
  __sys_sendto+0x255/0x340 net/socket.c:2134
  __do_sys_sendto net/socket.c:2146 [inline]
  __se_sys_sendto net/socket.c:2142 [inline]
  __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bond->stats_lock/1);
                               local_irq_disable();
                               lock(&br->lock);
                               lock(&bond->stats_lock/1);
  <Interrupt>
    lock(&br->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.5/29194:
 #0: ffffffff8e3dfca8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:78 [inline]
 #0: ffffffff8e3dfca8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e2/0xd30 net/core/rtnetlink.c:6425
 #1: ffff88802d3b0c98 (&br->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88802d3b0c98 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink net/bridge/br_netlink.c:1199 [inline]
 #1: ffff88802d3b0c98 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink+0x3e/0x190 net/bridge/br_netlink.c:1187
 #2: ffffffff8c9a6580 (rcu_read_lock){....}-{1:2}, at: bond_get_stats+0x4/0x560 drivers/net/bonding/bond_main.c:4414

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&br->lock){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    br_add_if+0x1039/0x1bb0 net/bridge/br_if.c:682
                    do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2661
                    do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2860
                    __rtnl_newlink+0xc04/0x18c0 net/core/rtnetlink.c:3655
                    rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
                    rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
                    netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
                    netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                    netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
                    netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
                    sock_sendmsg_nosec net/socket.c:725 [inline]
                    sock_sendmsg+0xd9/0x180 net/socket.c:748
                    __sys_sendto+0x255/0x340 net/socket.c:2134
                    __do_sys_sendto net/socket.c:2146 [inline]
                    __se_sys_sendto net/socket.c:2142 [inline]
                    __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    br_forward_delay_timer_expired+0x4f/0x560 net/bridge/br_stp_timer.c:86
                    call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
                    expire_timers kernel/time/timer.c:1751 [inline]
                    __run_timers+0x764/0xb10 kernel/time/timer.c:2022
                    run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
                    __do_softirq+0x218/0x965 kernel/softirq.c:553
                    invoke_softirq kernel/softirq.c:427 [inline]
                    __irq_exit_rcu kernel/softirq.c:632 [inline]
                    irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                    lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5729
                    rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
                    rcu_read_lock include/linux/rcupdate.h:749 [inline]
                    is_bpf_text_address+0x38/0x1a0 kernel/bpf/core.c:719
                    kernel_text_address kernel/extable.c:125 [inline]
                    kernel_text_address+0x85/0xf0 kernel/extable.c:94
                    __kernel_text_address+0xd/0x30 kernel/extable.c:79
                    unwind_get_return_address+0x55/0xa0 arch/x86/kernel/unwind_orc.c:369
                    arch_stack_walk+0x9d/0xf0 arch/x86/kernel/stacktrace.c:26
                    stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
                    kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
                    __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
                    task_work_add+0x88/0x2a0 kernel/task_work.c:48
                    fput fs/file_table.c:440 [inline]
                    fput+0xed/0x1a0 fs/file_table.c:433
                    filp_close+0x130/0x1b0 fs/open.c:1523
                    close_fd+0x76/0xa0 fs/file.c:665
                    __do_sys_close fs/open.c:1536 [inline]
                    __se_sys_close fs/open.c:1534 [inline]
                    __x64_sys_close+0x31/0x90 fs/open.c:1534
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5761 [inline]
                   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   br_add_if+0x1039/0x1bb0 net/bridge/br_if.c:682
                   do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2661
                   do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2860
                   __rtnl_newlink+0xc04/0x18c0 net/core/rtnetlink.c:3655
                   rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
                   rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
                   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
                   netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                   netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
                   netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
                   sock_sendmsg_nosec net/socket.c:725 [inline]
                   sock_sendmsg+0xd9/0x180 net/socket.c:748
                   __sys_sendto+0x255/0x340 net/socket.c:2134
                   __do_sys_sendto net/socket.c:2146 [inline]
                   __se_sys_sendto net/socket.c:2142 [inline]
                   __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x63/0xcd
 }
 ... key      at: [<ffffffff924eb040>] __key.5+0x0/0x40

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&bond->stats_lock/1){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427
                    dev_get_stats+0xb5/0x470 net/core/dev.c:10424
                    rtnl_fill_stats+0x48/0xa80 net/core/rtnetlink.c:1261
                    rtnl_fill_ifinfo+0x18b5/0x47b0 net/core/rtnetlink.c:1868
                    rtmsg_ifinfo_build_skb+0x14d/0x270 net/core/rtnetlink.c:4024
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4058 [inline]
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4048 [inline]
                    rtnetlink_event+0xef/0x1f0 net/core/rtnetlink.c:6479
                    notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
                    call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
                    call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
                    call_netdevice_notifiers net/core/dev.c:2014 [inline]
                    netdev_features_change net/core/dev.c:1325 [inline]
                    netdev_change_features+0x82/0xb0 net/core/dev.c:9805
                    bond_compute_features+0x4ec/0x810 drivers/net/bonding/bond_main.c:1496
                    bond_enslave+0x3116/0x5d00 drivers/net/bonding/bond_main.c:2219
                    do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2661
                    do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2860
                    __rtnl_newlink+0xc04/0x18c0 net/core/rtnetlink.c:3655
                    rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
                    rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
                    netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
                    netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                    netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
                    netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
                    sock_sendmsg_nosec net/socket.c:725 [inline]
                    sock_sendmsg+0xd9/0x180 net/socket.c:748
                    __sys_sendto+0x255/0x340 net/socket.c:2134
                    __do_sys_sendto net/socket.c:2146 [inline]
                    __se_sys_sendto net/socket.c:2142 [inline]
                    __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427
                    dev_get_stats+0xb5/0x470 net/core/dev.c:10424
                    rtnl_fill_stats+0x48/0xa80 net/core/rtnetlink.c:1261
                    rtnl_fill_ifinfo+0x18b5/0x47b0 net/core/rtnetlink.c:1868
                    rtmsg_ifinfo_build_skb+0x14d/0x270 net/core/rtnetlink.c:4024
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4058 [inline]
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4048 [inline]
                    rtnetlink_event+0xef/0x1f0 net/core/rtnetlink.c:6479
                    notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
                    call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
                    call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
                    call_netdevice_notifiers net/core/dev.c:2014 [inline]
                    netdev_features_change net/core/dev.c:1325 [inline]
                    netdev_change_features+0x82/0xb0 net/core/dev.c:9805
                    bond_compute_features+0x4ec/0x810 drivers/net/bonding/bond_main.c:1496
                    bond_enslave+0x3116/0x5d00 drivers/net/bonding/bond_main.c:2219
                    do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2661
                    do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2860
                    __rtnl_newlink+0xc04/0x18c0 net/core/rtnetlink.c:3655
                    rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
                    rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
                    netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
                    netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                    netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
                    netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
                    sock_sendmsg_nosec net/socket.c:725 [inline]
                    sock_sendmsg+0xd9/0x180 net/socket.c:748
                    __sys_sendto+0x255/0x340 net/socket.c:2134
                    __do_sys_sendto net/socket.c:2146 [inline]
                    __se_sys_sendto net/socket.c:2142 [inline]
                    __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5761 [inline]
                   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                   bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427
                   dev_get_stats+0xb5/0x470 net/core/dev.c:10424
                   rtnl_fill_stats+0x48/0xa80 net/core/rtnetlink.c:1261
                   rtnl_fill_ifinfo+0x18b5/0x47b0 net/core/rtnetlink.c:1868
                   rtmsg_ifinfo_build_skb+0x14d/0x270 net/core/rtnetlink.c:4024
                   rtmsg_ifinfo_event net/core/rtnetlink.c:4058 [inline]
                   rtmsg_ifinfo_event net/core/rtnetlink.c:4048 [inline]
                   rtnetlink_event+0xef/0x1f0 net/core/rtnetlink.c:6479
                   notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
                   call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
                   call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
                   call_netdevice_notifiers net/core/dev.c:2014 [inline]
                   netdev_features_change net/core/dev.c:1325 [inline]
                   netdev_change_features+0x82/0xb0 net/core/dev.c:9805
                   bond_compute_features+0x4ec/0x810 drivers/net/bonding/bond_main.c:1496
                   bond_enslave+0x3116/0x5d00 drivers/net/bonding/bond_main.c:2219
                   do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2661
                   do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2860
                   __rtnl_newlink+0xc04/0x18c0 net/core/rtnetlink.c:3655
                   rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
                   rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
                   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
                   netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                   netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
                   netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
                   sock_sendmsg_nosec net/socket.c:725 [inline]
                   sock_sendmsg+0xd9/0x180 net/socket.c:748
                   __sys_sendto+0x255/0x340 net/socket.c:2134
                   __do_sys_sendto net/socket.c:2146 [inline]
                   __se_sys_sendto net/socket.c:2142 [inline]
                   __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x63/0xcd
 }
 ... key      at: [<ffffffff92432741>] __key.8+0x1/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5761 [inline]
   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
   bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427
   dev_get_stats+0xb5/0x470 net/core/dev.c:10424
   rtnl_fill_stats+0x48/0xa80 net/core/rtnetlink.c:1261
   rtnl_fill_ifinfo+0x18b5/0x47b0 net/core/rtnetlink.c:1868
   rtmsg_ifinfo_build_skb+0x14d/0x270 net/core/rtnetlink.c:4024
   rtmsg_ifinfo_event net/core/rtnetlink.c:4058 [inline]
   rtmsg_ifinfo_event net/core/rtnetlink.c:4048 [inline]
   rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4067
   __dev_notify_flags+0x24a/0x2e0 net/core/dev.c:8565
   __dev_set_promiscuity+0x269/0x580 net/core/dev.c:8339
   dev_set_promiscuity+0x52/0x150 net/core/dev.c:8359
   br_port_clear_promisc net/bridge/br_if.c:135 [inline]
   br_manage_promisc+0x3f2/0x510 net/bridge/br_if.c:172
   nbp_update_port_count net/bridge/br_if.c:242 [inline]
   br_port_flags_change+0x185/0x1e0 net/bridge/br_if.c:761
   br_setport+0xb7e/0x16f0 net/bridge/br_netlink.c:993
   br_port_slave_changelink net/bridge/br_netlink.c:1200 [inline]
   br_port_slave_changelink+0xdd/0x190 net/bridge/br_netlink.c:1187
   __rtnl_newlink+0xbc6/0x18c0 net/core/rtnetlink.c:3648
   rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
   rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
   netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
   netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
   netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
   netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
   sock_sendmsg_nosec net/socket.c:725 [inline]
   sock_sendmsg+0xd9/0x180 net/socket.c:748
   ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
   ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
   __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd


stack backtrace:
CPU: 0 PID: 29194 Comm: syz-executor.5 Not tainted 6.5.0-rc4-syzkaller-00186-gd14eea09edf4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2634 [inline]
 check_irq_usage+0x10b8/0x1c70 kernel/locking/lockdep.c:2873
 check_prev_add kernel/locking/lockdep.c:3146 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e53/0x5de0 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 bond_get_stats+0x118/0x560 drivers/net/bonding/bond_main.c:4427
 dev_get_stats+0xb5/0x470 net/core/dev.c:10424
 rtnl_fill_stats+0x48/0xa80 net/core/rtnetlink.c:1261
 rtnl_fill_ifinfo+0x18b5/0x47b0 net/core/rtnetlink.c:1868
 rtmsg_ifinfo_build_skb+0x14d/0x270 net/core/rtnetlink.c:4024
 rtmsg_ifinfo_event net/core/rtnetlink.c:4058 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4048 [inline]
 rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4067
 __dev_notify_flags+0x24a/0x2e0 net/core/dev.c:8565
 __dev_set_promiscuity+0x269/0x580 net/core/dev.c:8339
 dev_set_promiscuity+0x52/0x150 net/core/dev.c:8359
 br_port_clear_promisc net/bridge/br_if.c:135 [inline]
 br_manage_promisc+0x3f2/0x510 net/bridge/br_if.c:172
 nbp_update_port_count net/bridge/br_if.c:242 [inline]
 br_port_flags_change+0x185/0x1e0 net/bridge/br_if.c:761
 br_setport+0xb7e/0x16f0 net/bridge/br_netlink.c:993
 br_port_slave_changelink net/bridge/br_netlink.c:1200 [inline]
 br_port_slave_changelink+0xdd/0x190 net/bridge/br_netlink.c:1187
 __rtnl_newlink+0xbc6/0x18c0 net/core/rtnetlink.c:3648
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8f9aa7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8f9b7360c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8f9ab9bf80 RCX: 00007f8f9aa7cae9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 000000000000000b
RBP: 00007f8f9aac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8f9ab9bf80 R15: 00007fff1934f968
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

