Return-Path: <bpf+bounces-15166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A67EDE9E
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 11:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E46B1C20A0A
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4918E05;
	Thu, 16 Nov 2023 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983ABD4F
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 02:35:28 -0800 (PST)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-5c19a0a2fbfso740970a12.2
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 02:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130928; x=1700735728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXzT3KtJrR9niQ4wJppGmVI9MRL4CBi7fbwfgbtDDS8=;
        b=QEv6Aj8IFhhzd0TQlLU8ZBEBB64yHxVZh3x6WEhbGcsR6Y0+fONcrAhHHG6mQuUXuK
         5Q7y/BN1XQUPI3b9FhVsHAR+wSck9Z+RCEnhl1rV6R5vUH9+5pE06q2TmSrzGUQUbjHL
         CevGnf6Tc4Akbhkc5C8AbR1qNe8URmQwndI8jJvukHyKGw9pivUd3Y5/qrGC08YWMszm
         9YSmP9cwJv7xXiVCbV7T4OCYeNDLrsT+CuTHfD93d8ik97CP/YtymTNjisft+tOzzVOm
         Yb6NnPsLW4Q5GQ8BQ4Q8BYT4+OP4dID8hhz56L+oY/hp6Y7H14/hLkGevFqjSijlcxPC
         0IRg==
X-Gm-Message-State: AOJu0YylR+ZyckvK3MyRzL4KTcSXOjXrMueAxF1aUBle1z68jGCCpNvE
	vnm920gJsBEN5/Vs7upMvylxQ8vJz6lavpxSip8HCgHPIp6Q
X-Google-Smtp-Source: AGHT+IF+6PEgjJymxRb2Ft2cUZpVSzpHDfHIErm88NyyjjAFDTX7nhHY+TlJsLhsgwgNacVMNPDvUE7mjsyRTwJzFcrkBk9oxV/B
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:594:b0:5be:14f4:ad97 with SMTP id
 by20-20020a056a02059400b005be14f4ad97mr335696pgb.12.1700130928065; Thu, 16
 Nov 2023 02:35:28 -0800 (PST)
Date: Thu, 16 Nov 2023 02:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a04f8060a429427@google.com>
Subject: [syzbot] [bpf?] [trace?] possible deadlock in sctp_err_lookup
From: syzbot <syzbot+422ecd5adb35122711b7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, mhiramat@kernel.org, 
	rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a32f97680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=422ecd5adb35122711b7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987488cb251e/disk-f31817cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d4a82d8bd4b/vmlinux-f31817cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc43dee9cb86/bzImage-f31817cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+422ecd5adb35122711b7@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.7.0-rc1-next-20231116-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.2/5088 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888025d21bd8 (&sighand->siglock){+.+.}-{2:2}, at: __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422

and this task is already holding:
ffff88802dd927b0 (slock-AF_INET6){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88802dd927b0 (slock-AF_INET6){+.-.}-{2:2}, at: __tcp_close+0x4e6/0xfd0 net/ipv4/tcp.c:2843
which would create a new lock dependency:
 (slock-AF_INET6){+.-.}-{2:2} -> (&sighand->siglock){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (slock-AF_INET6){+.-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  sctp_err_lookup+0x488/0xb50 net/sctp/input.c:523
  sctp_v6_err+0x201/0x540 net/sctp/ipv6.c:175
  icmpv6_notify+0x337/0x750 net/ipv6/icmp.c:867
  icmpv6_rcv+0x882/0x19c0 net/ipv6/icmp.c:1013
  ip6_protocol_deliver_rcu+0x170/0x13e0 net/ipv6/ip6_input.c:438
  ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
  NF_HOOK include/linux/netfilter.h:314 [inline]
  NF_HOOK include/linux/netfilter.h:308 [inline]
  ip6_input+0xa1/0xc0 net/ipv6/ip6_input.c:492
  dst_input include/net/dst.h:461 [inline]
  ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  NF_HOOK include/linux/netfilter.h:308 [inline]
  ipv6_rcv+0x24e/0x380 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5529
  __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5643
  process_backlog+0x101/0x6b0 net/core/dev.c:5971
  __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6533
  napi_poll net/core/dev.c:6602 [inline]
  net_rx_action+0x956/0xe90 net/core/dev.c:6735
  __do_softirq+0x216/0x8d5 kernel/softirq.c:553
  do_softirq kernel/softirq.c:454 [inline]
  do_softirq+0xaa/0xe0 kernel/softirq.c:441
  __local_bh_enable_ip+0xfc/0x120 kernel/softirq.c:381
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  icmp6_send+0x7d5/0x2b10 net/ipv6/icmp.c:633
  __icmpv6_send include/linux/icmpv6.h:28 [inline]
  icmpv6_send include/linux/icmpv6.h:49 [inline]
  ip6_pkt_drop+0x1f3/0x860 net/ipv6/route.c:4515
  dst_output include/net/dst.h:451 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  NF_HOOK include/linux/netfilter.h:308 [inline]
  ip6_xmit+0x1234/0x1cc0 net/ipv6/ip6_output.c:358
  sctp_v6_xmit+0xc1b/0x1110 net/sctp/ipv6.c:248
  sctp_packet_transmit+0x22e1/0x3020 net/sctp/output.c:653
  sctp_packet_singleton+0x19f/0x370 net/sctp/outqueue.c:783
  sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
  sctp_outq_flush+0x54d/0x3340 net/sctp/outqueue.c:1212
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1818 [inline]
  sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
  sctp_do_sm+0x178f/0x5c50 net/sctp/sm_sideeffect.c:1169
  sctp_primitive_ASSOCIATE+0x9c/0xc0 net/sctp/primitive.c:73
  __sctp_connect+0x9e9/0xc30 net/sctp/socket.c:1233
  sctp_connect net/sctp/socket.c:4811 [inline]
  sctp_inet_connect+0x15f/0x1f0 net/sctp/socket.c:4826
  __sys_connect_file+0x15b/0x1a0 net/socket.c:2046
  __sys_connect+0x145/0x170 net/socket.c:2063
  __do_sys_connect net/socket.c:2073 [inline]
  __se_sys_connect net/socket.c:2070 [inline]
  __x64_sys_connect+0x72/0xb0 net/socket.c:2070
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a

to a SOFTIRQ-irq-unsafe lock:
 (&sighand->siglock){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  class_spinlock_constructor include/linux/spinlock.h:530 [inline]
  ptrace_set_stopped kernel/ptrace.c:391 [inline]
  ptrace_attach+0x401/0x650 kernel/ptrace.c:478
  __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               local_irq_disable();
                               lock(slock-AF_INET6);
                               lock(&sighand->siglock);
  <Interrupt>
    lock(slock-AF_INET6);

 *** DEADLOCK ***

5 locks held by syz-executor.2/5088:
 #0: ffff888078a5dc10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #0: ffff888078a5dc10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x260 net/socket.c:658
 #1: ffff88802dd92830 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1720 [inline]
 #1: ffff88802dd92830 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x1d/0xc0 net/ipv4/tcp.c:2920
 #2: ffff88802dd927b0 (slock-AF_INET6){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff88802dd927b0 (slock-AF_INET6){+.-.}-{2:2}, at: __tcp_close+0x4e6/0xfd0 net/ipv4/tcp.c:2843
 #3: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #3: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #3: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2310 [inline]
 #3: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0xe4/0x410 kernel/trace/bpf_trace.c:2350
 #4: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #4: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #4: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: __lock_task_sighand+0x3f/0x340 kernel/signal.c:1405

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (slock-AF_INET6){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    lock_sock_nested+0x5f/0xf0 net/core/sock.c:3522
                    lock_sock include/net/sock.h:1720 [inline]
                    udpv6_destroy_sock+0x1c/0x240 net/ipv6/udp.c:1663
                    sk_common_release+0x68/0x3a0 net/core/sock.c:3718
                    inet_release+0x132/0x270 net/ipv4/af_inet.c:433
                    inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
                    __sock_release+0xae/0x260 net/socket.c:659
                    sock_close+0x1c/0x20 net/socket.c:1419
                    __fput+0x270/0xbb0 fs/file_table.c:394
                    __fput_sync+0x47/0x50 fs/file_table.c:475
                    __do_sys_close fs/open.c:1590 [inline]
                    __se_sys_close fs/open.c:1575 [inline]
                    __x64_sys_close+0x86/0xf0 fs/open.c:1575
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    sctp_err_lookup+0x488/0xb50 net/sctp/input.c:523
                    sctp_v6_err+0x201/0x540 net/sctp/ipv6.c:175
                    icmpv6_notify+0x337/0x750 net/ipv6/icmp.c:867
                    icmpv6_rcv+0x882/0x19c0 net/ipv6/icmp.c:1013
                    ip6_protocol_deliver_rcu+0x170/0x13e0 net/ipv6/ip6_input.c:438
                    ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
                    NF_HOOK include/linux/netfilter.h:314 [inline]
                    NF_HOOK include/linux/netfilter.h:308 [inline]
                    ip6_input+0xa1/0xc0 net/ipv6/ip6_input.c:492
                    dst_input include/net/dst.h:461 [inline]
                    ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
                    NF_HOOK include/linux/netfilter.h:314 [inline]
                    NF_HOOK include/linux/netfilter.h:308 [inline]
                    ipv6_rcv+0x24e/0x380 net/ipv6/ip6_input.c:310
                    __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5529
                    __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5643
                    process_backlog+0x101/0x6b0 net/core/dev.c:5971
                    __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6533
                    napi_poll net/core/dev.c:6602 [inline]
                    net_rx_action+0x956/0xe90 net/core/dev.c:6735
                    __do_softirq+0x216/0x8d5 kernel/softirq.c:553
                    do_softirq kernel/softirq.c:454 [inline]
                    do_softirq+0xaa/0xe0 kernel/softirq.c:441
                    __local_bh_enable_ip+0xfc/0x120 kernel/softirq.c:381
                    local_bh_enable include/linux/bottom_half.h:33 [inline]
                    icmp6_send+0x7d5/0x2b10 net/ipv6/icmp.c:633
                    __icmpv6_send include/linux/icmpv6.h:28 [inline]
                    icmpv6_send include/linux/icmpv6.h:49 [inline]
                    ip6_pkt_drop+0x1f3/0x860 net/ipv6/route.c:4515
                    dst_output include/net/dst.h:451 [inline]
                    NF_HOOK include/linux/netfilter.h:314 [inline]
                    NF_HOOK include/linux/netfilter.h:308 [inline]
                    ip6_xmit+0x1234/0x1cc0 net/ipv6/ip6_output.c:358
                    sctp_v6_xmit+0xc1b/0x1110 net/sctp/ipv6.c:248
                    sctp_packet_transmit+0x22e1/0x3020 net/sctp/output.c:653
                    sctp_packet_singleton+0x19f/0x370 net/sctp/outqueue.c:783
                    sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
                    sctp_outq_flush+0x54d/0x3340 net/sctp/outqueue.c:1212
                    sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1818 [inline]
                    sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
                    sctp_do_sm+0x178f/0x5c50 net/sctp/sm_sideeffect.c:1169
                    sctp_primitive_ASSOCIATE+0x9c/0xc0 net/sctp/primitive.c:73
                    __sctp_connect+0x9e9/0xc30 net/sctp/socket.c:1233
                    sctp_connect net/sctp/socket.c:4811 [inline]
                    sctp_inet_connect+0x15f/0x1f0 net/sctp/socket.c:4826
                    __sys_connect_file+0x15b/0x1a0 net/socket.c:2046
                    __sys_connect+0x145/0x170 net/socket.c:2063
                    __do_sys_connect net/socket.c:2073 [inline]
                    __se_sys_connect net/socket.c:2070 [inline]
                    __x64_sys_connect+0x72/0xb0 net/socket.c:2070
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   lock_sock_nested+0x5f/0xf0 net/core/sock.c:3522
                   lock_sock include/net/sock.h:1720 [inline]
                   udpv6_destroy_sock+0x1c/0x240 net/ipv6/udp.c:1663
                   sk_common_release+0x68/0x3a0 net/core/sock.c:3718
                   inet_release+0x132/0x270 net/ipv4/af_inet.c:433
                   inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
                   __sock_release+0xae/0x260 net/socket.c:659
                   sock_close+0x1c/0x20 net/socket.c:1419
                   __fput+0x270/0xbb0 fs/file_table.c:394
                   __fput_sync+0x47/0x50 fs/file_table.c:475
                   __do_sys_close fs/open.c:1590 [inline]
                   __se_sys_close fs/open.c:1575 [inline]
                   __x64_sys_close+0x86/0xf0 fs/open.c:1575
                   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                   entry_SYSCALL_64_after_hwframe+0x62/0x6a
 }
 ... key      at: [<ffffffff92b36fc0>] af_family_slock_keys+0xa0/0x300

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&sighand->siglock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   calculate_sigpending+0x44/0xa0 kernel/signal.c:197
                   ret_from_fork+0x23/0x80 arch/x86/kernel/process.c:143
                   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 }
 ... key      at: [<ffffffff90b49f80>] __key.341+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5753 [inline]
   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
   __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
   lock_task_sighand include/linux/sched/signal.h:748 [inline]
   do_send_sig_info kernel/signal.c:1309 [inline]
   group_send_sig_info+0x288/0x300 kernel/signal.c:1460
   bpf_send_signal_common+0x2e4/0x3a0 kernel/trace/bpf_trace.c:877
   ____bpf_send_signal kernel/trace/bpf_trace.c:882 [inline]
   bpf_send_signal+0x19/0x20 kernel/trace/bpf_trace.c:880
   bpf_prog_9fbc3d1d47c9b36c+0x22/0x29
   bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
   __bpf_prog_run include/linux/filter.h:651 [inline]
   bpf_prog_run include/linux/filter.h:658 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2311 [inline]
   bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2350
   trace_kfree include/trace/events/kmem.h:94 [inline]
   kfree+0xf6/0x150 mm/slab_common.c:1043
   tcp_saved_syn_free include/linux/tcp.h:568 [inline]
   tcp_v4_destroy_sock+0x256/0x560 net/ipv4/tcp_ipv4.c:2538
   inet_csk_destroy_sock+0x19a/0x450 net/ipv4/inet_connection_sock.c:1198
   __tcp_close+0xbf0/0xfd0 net/ipv4/tcp.c:2909
   tcp_close+0x2d/0xc0 net/ipv4/tcp.c:2921
   inet_release+0x132/0x270 net/ipv4/af_inet.c:433
   inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
   __sock_release+0xae/0x260 net/socket.c:659
   sock_close+0x1c/0x20 net/socket.c:1419
   __fput+0x270/0xbb0 fs/file_table.c:394
   __fput_sync+0x47/0x50 fs/file_table.c:475
   __do_sys_close fs/open.c:1590 [inline]
   __se_sys_close fs/open.c:1575 [inline]
   __x64_sys_close+0x86/0xf0 fs/open.c:1575
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a


stack backtrace:
CPU: 1 PID: 5088 Comm: syz-executor.2 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe18/0x1470 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x247c/0x3b10 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
 lock_task_sighand include/linux/sched/signal.h:748 [inline]
 do_send_sig_info kernel/signal.c:1309 [inline]
 group_send_sig_info+0x288/0x300 kernel/signal.c:1460
 bpf_send_signal_common+0x2e4/0x3a0 kernel/trace/bpf_trace.c:877
 ____bpf_send_signal kernel/trace/bpf_trace.c:882 [inline]
 bpf_send_signal+0x19/0x20 kernel/trace/bpf_trace.c:880
 bpf_prog_9fbc3d1d47c9b36c+0x22/0x29
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2311 [inline]
 bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2350
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0xf6/0x150 mm/slab_common.c:1043
 tcp_saved_syn_free include/linux/tcp.h:568 [inline]
 tcp_v4_destroy_sock+0x256/0x560 net/ipv4/tcp_ipv4.c:2538
 inet_csk_destroy_sock+0x19a/0x450 net/ipv4/inet_connection_sock.c:1198
 __tcp_close+0xbf0/0xfd0 net/ipv4/tcp.c:2909
 tcp_close+0x2d/0xc0 net/ipv4/tcp.c:2921
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close fs/open.c:1575 [inline]
 __x64_sys_close+0x86/0xf0 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f4f6907b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe444ef290 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4f6907b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffe444ef30c R08: 00000000000003b8 R09: 0079746972756365
R10: 00007f4f691786a0 R11: 0000000000000293 R12: 0000000000000032
R13: 00000000000aa51e R14: 00000000000aa4b4 R15: 0000000000000002
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

