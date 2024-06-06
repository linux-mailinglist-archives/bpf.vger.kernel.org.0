Return-Path: <bpf+bounces-31493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920F8FE3B0
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DE01F22F3B
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488618629B;
	Thu,  6 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="LaluFulX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FC18410E
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668030; cv=none; b=WsntC9lXRANvZPd0qnaRt3ZyNotB0zqoL4jEMlaA2Is+yikidwa4ZnKx/lMwV2XFmDa0LrIctKzIWfQsjyFu1duPdbkzNII/UoOZ4tDdk2F77JJEc970P9oN8jGcg0Qrgn9V6qDMaB8BF5x3nyE/ed06emwr/+FGMcEgbyB6Im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668030; c=relaxed/simple;
	bh=uu72mbZo/mD5N2hgue2zAZYcmcf1AeHEhPN8x1RoY08=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VLSZ0+o/hHX5rZ8l8fd58TfnCvWMObRQsVuFclFN/QUoDt1OJPn6esU3g5c6wk340d6QZBQqxFeLD0t45hR28o08xdW00pnlFDqsVCeUMWZo612RI/QkPzp3d12E0o6OKPe26SecHcZ9QimA9hMvxKTGzXMI9hCtw/ociPusF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=LaluFulX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso959301a12.0
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1717668026; x=1718272826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+THcccX4e9HXwEir3FXE5r3iaJfy2C0QInhtcFI88Wo=;
        b=LaluFulXLUk3q2Sut6N99b7XnOLkPtedQG2BldIryYMj9ixUxeMVhfMXyc/gOl3shm
         uZONGRrK/2rVC4K6NNNjNWJhNmgph7YoQ62nwcMxy5rgvIwb9+O/XTljdR3kPNKs/ZH1
         /VXyCuc8o4WRCIvUL0D5+DWDiZJoeQWGt40/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668026; x=1718272826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+THcccX4e9HXwEir3FXE5r3iaJfy2C0QInhtcFI88Wo=;
        b=us/3F1ZuLKUAwaeW71P+VR/AUKMRYmIy3ONTBYAYG5pRdhL8pTZSX53SE9JG2hxb/c
         NXBy5d6FInTczGuy2tTcGOQ7ksyI39X1TxAaUjn05+j/1Nmr7TIJSo75VyPp8M48PYWl
         0b848XOQ570nwkuj3opiYDZP2wlTFhSTMqeDRQH3Y/EuqFV0mw9MZhqQLeqhsYQ2rWJu
         1wrscFuRYa0Ti5tbX51ZX2h0cqHCxS/rf6yUO47iYiE+J+u4pE76FPJUXEqnv+rR8GE5
         I1zAOZMRKAM9S37QrpXPp+sqW0Ly6NAzwH4DYi/i7w5Dahuh8yuSY3BbWNVTliCi9pQI
         svmg==
X-Forwarded-Encrypted: i=1; AJvYcCVGvkYDwYmNJ49FLeEmpCZ3X6pQD1YQ4iUExrJvfpgAzOjEvaqSG98nElKj1OXAUKWIl2tPjFjsNLv3NClQkdnhHClH
X-Gm-Message-State: AOJu0YwQtiFOXpWzAw10BAHEjU4xPBlSoBA42SMr//2yiVVSdMoTHrdF
	cDdZjmMULh3UbeLCrsVJMGSL476NpnxNR4AoTEY94QwLRXTgLskN+GKsgPFDtaDGZdq+GR1jHdB
	csMDboayOUCNNAw9jfhVDUr4Z5ST2fyxaCoOWhw==
X-Google-Smtp-Source: AGHT+IHwfwb+ZBuAUu+6heqOzbyfWJdp5KyVnabVPPbU2yFLsgDf36wr0eKKEDITOoEyaZuKmZOWvkqG6mQU8Kx/1xw=
X-Received: by 2002:a50:bb02:0:b0:56a:ae8a:acc0 with SMTP id
 4fb4d7f45d1cf-57a8b6fc2e4mr3151517a12.21.1717668026011; Thu, 06 Jun 2024
 03:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Date: Thu, 6 Jun 2024 12:00:14 +0200
Message-ID: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
Subject: Recursive locking in sockmap
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jason Xing <kernelxing@tencent.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000088f9f3061a35c0be"

--00000000000088f9f3061a35c0be
Content-Type: text/plain; charset="UTF-8"

With a socket in the sockmap, if there's a parser callback installed
and the verdict callback returns SK_PASS, the kernel deadlocks
immediately after the verdict callback is run. This started at commit
6648e613226e18897231ab5e42ffc29e63fa3365 ("bpf, skmsg: Fix NULL
pointer dereference in sk_psock_skb_ingress_enqueue").

It can be reproduced by running ./test_sockmap -t ping
--txmsg_pass_skb.  The --txmsg_pass_skb command to test_sockmap is
available in this series:
https://lore.kernel.org/netdev/20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com/.

Lockdep splat below (also attached in case it gets damaged). This is
from an unmodified 6.10.0-rc2, but the problem also exists on latest
mainline and net-next.

 ============================================
 WARNING: possible recursive locking detected
 6.10.0-rc2 #59 Not tainted
 --------------------------------------------
 test_sockmap/342 is trying to acquire lock:
 ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
net/core/skmsg.c:555)

 but task is already holding lock:
 ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
sk_psock_strp_data_ready (net/core/skmsg.c:1120)

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(clock-AF_INET);
   lock(clock-AF_INET);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 9 locks held by test_sockmap/342:
 #0: ffff888007a85818 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg
(net/ipv4/tcp.c:1348)
 #1: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit
(./include/linux/rcupdate.h:329 ./include/linux/rcupdate.h:781
net/ipv4/ip_output.c:470)
 #2: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
ip_finish_output2 (./include/linux/rcupdate.h:329
./include/linux/rcupdate.h:781 net/ipv4/ip_output.c:228)
 #3: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at: process_backlog
(./include/linux/rcupdate.h:329 ./include/linux/rcupdate.h:781
net/core/dev.c:6066)
 #4: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
ip_local_deliver_finish (./include/linux/rcupdate.h:329
./include/linux/rcupdate.h:781 net/ipv4/ip_input.c:232)
 #5: ffff888007a87018 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv
(./include/linux/skbuff.h:1640 ./include/net/tcp.h:2510
net/ipv4/tcp_ipv4.c:2342)
 #6: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
sk_psock_strp_data_ready (./include/linux/rcupdate.h:329
./include/linux/rcupdate.h:781 net/core/skmsg.c:1113)
 #7: ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
sk_psock_strp_data_ready (net/core/skmsg.c:1120)
 #8: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
sk_psock_strp_read (./include/linux/rcupdate.h:329
./include/linux/rcupdate.h:781 net/core/skmsg.c:1062)

 stack backtrace:
 CPU: 0 PID: 342 Comm: test_sockmap Not tainted 6.10.0-rc2 #59
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 Call Trace:
   <IRQ>
  dump_stack_lvl (lib/dump_stack.c:118)
  __lock_acquire (kernel/locking/lockdep.c:3858 kernel/locking/lockdep.c:5137)
  ? __pfx___lock_acquire (kernel/locking/lockdep.c:4993)
  ? tcp_rcv_established (./include/linux/skbuff.h:2097
./include/net/tcp.h:2026 ./include/net/tcp.h:2099
net/ipv4/tcp_input.c:5660 net/ipv4/tcp_input.c:6179)
  ? tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2345)
  ? ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 8))
  ? ip_local_deliver_finish (./include/linux/rcupdate.h:810
net/ipv4/ip_input.c:234)
  ? __pfx_mark_lock (kernel/locking/lockdep.c:4639)
  lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
  ? sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
net/core/skmsg.c:555)
  ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
  ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
  ? mark_held_locks (kernel/locking/lockdep.c:4274)
  ? sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:466
net/core/skmsg.c:555)
  _raw_read_lock_bh (./include/linux/rwlock_api_smp.h:177
kernel/locking/spinlock.c:252)
  ? sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
net/core/skmsg.c:555)
  sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
net/core/skmsg.c:555)
  sk_psock_skb_ingress_self (net/core/skmsg.c:607)
  sk_psock_verdict_apply (net/core/skmsg.c:1008)
  sk_psock_strp_read (./include/linux/rcupdate.h:810 net/core/skmsg.c:1081)
  ? sk_psock_strp_parse (net/core/skmsg.c:1104)
  __strp_recv (net/strparser/strparser.c:301 (discriminator 3))
  tcp_read_sock (net/ipv4/tcp.c:1583)
  ? __pfx_strp_recv (net/strparser/strparser.c:332)
  ? __pfx_tcp_read_sock (net/ipv4/tcp.c:1560)
  ? lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
  strp_read_sock (net/strparser/strparser.c:358)
  ? __pfx_strp_read_sock (net/strparser/strparser.c:346)
  ? __pfx_do_raw_write_lock (kernel/locking/spinlock_debug.c:209)
  ? lock_is_held_type (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5826)
  strp_data_ready (net/strparser/strparser.c:388 net/strparser/strparser.c:366)
  sk_psock_strp_data_ready (net/core/skmsg.c:1121)
  tcp_data_queue (net/ipv4/tcp_input.c:5234)
  ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5776)
  ? __pfx_tcp_data_queue (net/ipv4/tcp_input.c:5148)
  ? __pfx_tcp_urg (net/ipv4/tcp_input.c:5820)
  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
  ? kvm_clock_get_cycles (./arch/x86/include/asm/preempt.h:94
arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
  ? ktime_get (kernel/time/timekeeping.c:195 (discriminator 4)
kernel/time/timekeeping.c:395 (discriminator 4)
kernel/time/timekeeping.c:403 (discriminator 4)
kernel/time/timekeeping.c:850 (discriminator 4))
  tcp_rcv_established (./include/linux/skbuff.h:2097
./include/net/tcp.h:2026 ./include/net/tcp.h:2099
net/ipv4/tcp_input.c:5660 net/ipv4/tcp_input.c:6179)
  ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
  ? __pfx_tcp_inbound_hash.constprop.0 (./include/net/tcp.h:2800)
  ? __pfx_tcp_rcv_established (net/ipv4/tcp_input.c:6006)
  ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:107
./include/linux/atomic/atomic-arch-fallback.h:2170
./include/linux/atomic/atomic-instrumented.h:1302
./include/asm-generic/qspinlock.h:111
kernel/locking/spinlock_debug.c:116)
  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1956)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2345)
  ? __pfx_tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2172)
  ? __pfx_raw_local_deliver (net/ipv4/raw.c:201)
  ? __pfx_mark_lock (kernel/locking/lockdep.c:4639)
  ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
  ? lock_is_held_type (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5826)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 8))
  ip_local_deliver_finish (./include/linux/rcupdate.h:810
net/ipv4/ip_input.c:234)
  ip_local_deliver (./include/linux/netfilter.h:314
./include/linux/netfilter.h:308 net/ipv4/ip_input.c:254)
  ? __pfx_ip_local_deliver (net/ipv4/ip_input.c:243)
  ? lock_is_held_type (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5826)
  ? ip_rcv_finish_core.constprop.0 (./include/net/net_namespace.h:383
./include/linux/netdevice.h:2577 net/ipv4/ip_input.c:372)
  ip_rcv (./include/net/dst.h:460 net/ipv4/ip_input.c:449
./include/linux/netfilter.h:314 ./include/linux/netfilter.h:308
net/ipv4/ip_input.c:569)
  ? __pfx_ip_rcv (net/ipv4/ip_input.c:562)
  ? lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
  ? lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
  ? __pfx_ip_rcv (net/ipv4/ip_input.c:562)
  __netif_receive_skb_one_core (net/core/dev.c:5624 (discriminator 4))
  ? __pfx___netif_receive_skb_one_core (net/core/dev.c:5617)
  ? mark_held_locks (kernel/locking/lockdep.c:4274)
  process_backlog (./include/linux/rcupdate.h:810 net/core/dev.c:6068)
  __napi_poll.constprop.0 (net/core/dev.c:6721)
  net_rx_action (net/core/dev.c:6792 net/core/dev.c:6906)
  ? __pfx_net_rx_action (net/core/dev.c:6870)
  ? __pfx_rcu_core (kernel/rcu/tree.c:2756)
  ? mark_held_locks (kernel/locking/lockdep.c:4274)
  ? __dev_queue_xmit (./include/linux/rcupdate.h:339
./include/linux/rcupdate.h:849 net/core/dev.c:4420)
  handle_softirqs (kernel/softirq.c:554)
  ? __dev_queue_xmit (./include/linux/rcupdate.h:339
./include/linux/rcupdate.h:849 net/core/dev.c:4420)
  do_softirq (kernel/softirq.c:455 kernel/softirq.c:442)
   </IRQ>
   <TASK>
  __local_bh_enable_ip (kernel/softirq.c:382)
  ? __dev_queue_xmit (./include/linux/rcupdate.h:339
./include/linux/rcupdate.h:849 net/core/dev.c:4420)
  __dev_queue_xmit (net/core/dev.c:4421)
  ? __pfx___lock_acquire (kernel/locking/lockdep.c:4993)
  ? __pfx_mark_lock (kernel/locking/lockdep.c:4639)
  ? __pfx___dev_queue_xmit (net/core/dev.c:4302)
  ? find_held_lock (kernel/locking/lockdep.c:5244)
  ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5776)
  ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
  ? __pfx___lock_acquire (kernel/locking/lockdep.c:4993)
  ? mark_held_locks (kernel/locking/lockdep.c:4274)
  ip_finish_output2 (./include/linux/netdevice.h:3095
./include/net/neighbour.h:526 ./include/net/neighbour.h:540
net/ipv4/ip_output.c:235)
  ? __pfx_nf_hook (./include/linux/netfilter.h:227)
  ? lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
  ? __pfx_ip_finish_output2 (net/ipv4/ip_output.c:199)
  ? ip_skb_dst_mtu (./include/net/net_namespace.h:383
./include/linux/netdevice.h:2577 ./include/net/ip.h:465
./include/net/ip.h:502)
  ? __ip_queue_xmit (net/ipv4/ip_output.c:535 (discriminator 4))
  __ip_queue_xmit (net/ipv4/ip_output.c:535 (discriminator 4))
  ? __skb_clone (./arch/x86/include/asm/atomic.h:53 (discriminator 4)
./include/linux/atomic/atomic-arch-fallback.h:992 (discriminator 4)
./include/linux/atomic/atomic-instrumented.h:436 (discriminator 4)
net/core/skbuff.c:1576 (discriminator 4))
  __tcp_transmit_skb (net/ipv4/tcp_output.c:1466 (discriminator 4))
  ? __pfx___tcp_transmit_skb (net/ipv4/tcp_output.c:1287)
  ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5776)
  ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
  ? ktime_get (./arch/x86/include/asm/irqflags.h:42
./arch/x86/include/asm/irqflags.h:77
./arch/x86/include/asm/irqflags.h:135 ./include/linux/seqlock.h:74
kernel/time/timekeeping.c:848)
  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
  tcp_write_xmit (net/ipv4/tcp_output.c:2829)
  ? __pfx_mem_cgroup_charge_skmem (mm/memcontrol.c:7886)
  ? skb_page_frag_refill (net/core/sock.c:2920 net/core/sock.c:2904)
  __tcp_push_pending_frames (net/ipv4/tcp_output.c:3014)
  tcp_sendmsg_locked (net/ipv4/tcp.c:1316)
  ? print_usage_bug.part.0 (kernel/locking/lockdep.c:3980)
  ? __pfx_tcp_sendmsg_locked (net/ipv4/tcp.c:1046)
  ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5776)
  ? __local_bh_enable_ip (./arch/x86/include/asm/irqflags.h:42
./arch/x86/include/asm/irqflags.h:77 kernel/softirq.c:387)
  tcp_sendmsg (net/ipv4/tcp.c:1349)
  __sys_sendto (net/socket.c:730 net/socket.c:745 net/socket.c:2192)
  ? __pfx___sys_sendto (net/socket.c:2162)
  ? lock_is_held_type (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5826)
  ? fd_install (./arch/x86/include/asm/preempt.h:103
./include/linux/rcupdate.h:896 fs/file.c:631)
  ? __sys_accept4 (./include/linux/file.h:47 net/socket.c:2002)
  ? __pfx___sys_accept4 (net/socket.c:1994)
  ? handle_mm_fault (./include/linux/memcontrol.h:1078
./include/linux/memcontrol.h:1066 mm/memory.c:5557 mm/memory.c:5704)
  __x64_sys_sendto (net/socket.c:2200)
  ? do_syscall_64 (./arch/x86/include/asm/irqflags.h:42
./arch/x86/include/asm/irqflags.h:77
./include/linux/entry-common.h:197 arch/x86/entry/common.c:79)
  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

--00000000000088f9f3061a35c0be
Content-Type: text/plain; charset="US-ASCII"; name="splat.txt"
Content-Disposition: attachment; filename="splat.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lx330s7c0>
X-Attachment-Id: f_lx330s7c0

ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiBXQVJOSU5HOiBw
b3NzaWJsZSByZWN1cnNpdmUgbG9ja2luZyBkZXRlY3RlZAogNi4xMC4wLXJjMiAjNTkgTm90IHRh
aW50ZWQKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0
X3NvY2ttYXAvMzQyIGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6CiBmZmZmODg4MDA3YTg3MjI4
IChjbG9jay1BRl9JTkVUKXsrKy0tfS17MjoyfSwgYXQ6IHNrX3Bzb2NrX3NrYl9pbmdyZXNzX2Vu
cXVldWUgKC4vaW5jbHVkZS9saW51eC9za21zZy5oOjQ2NyBuZXQvY29yZS9za21zZy5jOjU1NSkg
CgogYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxvY2s6CiBmZmZmODg4MDA3YTg3MjI4IChj
bG9jay1BRl9JTkVUKXsrKy0tfS17MjoyfSwgYXQ6IHNrX3Bzb2NrX3N0cnBfZGF0YV9yZWFkeSAo
bmV0L2NvcmUvc2ttc2cuYzoxMTIwKSAKCiBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBk
ZWJ1ZyB0aGlzOgogIFBvc3NpYmxlIHVuc2FmZSBsb2NraW5nIHNjZW5hcmlvOgoKICAgICAgICBD
UFUwCiAgICAgICAgLS0tLQogICBsb2NrKGNsb2NrLUFGX0lORVQpOwogICBsb2NrKGNsb2NrLUFG
X0lORVQpOwoKICAqKiogREVBRExPQ0sgKioqCgogIE1heSBiZSBkdWUgdG8gbWlzc2luZyBsb2Nr
IG5lc3Rpbmcgbm90YXRpb24KCiA5IGxvY2tzIGhlbGQgYnkgdGVzdF9zb2NrbWFwLzM0MjoKICMw
OiBmZmZmODg4MDA3YTg1ODE4IChza19sb2NrLUFGX0lORVQpeysuKy59LXswOjB9LCBhdDogdGNw
X3NlbmRtc2cgKG5ldC9pcHY0L3RjcC5jOjEzNDgpIAogIzE6IGZmZmZmZmZmYjg4NDljMDAgKHJj
dV9yZWFkX2xvY2spey4uLi59LXsxOjJ9LCBhdDogX19pcF9xdWV1ZV94bWl0ICguL2luY2x1ZGUv
bGludXgvcmN1cGRhdGUuaDozMjkgLi9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6NzgxIG5ldC9p
cHY0L2lwX291dHB1dC5jOjQ3MCkgCiAjMjogZmZmZmZmZmZiODg0OWMwMCAocmN1X3JlYWRfbG9j
ayl7Li4uLn0tezE6Mn0sIGF0OiBpcF9maW5pc2hfb3V0cHV0MiAoLi9pbmNsdWRlL2xpbnV4L3Jj
dXBkYXRlLmg6MzI5IC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjc4MSBuZXQvaXB2NC9pcF9v
dXRwdXQuYzoyMjgpIAogIzM6IGZmZmZmZmZmYjg4NDljMDAgKHJjdV9yZWFkX2xvY2spey4uLi59
LXsxOjJ9LCBhdDogcHJvY2Vzc19iYWNrbG9nICguL2luY2x1ZGUvbGludXgvcmN1cGRhdGUuaDoz
MjkgLi9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6NzgxIG5ldC9jb3JlL2Rldi5jOjYwNjYpIAog
IzQ6IGZmZmZmZmZmYjg4NDljMDAgKHJjdV9yZWFkX2xvY2spey4uLi59LXsxOjJ9LCBhdDogaXBf
bG9jYWxfZGVsaXZlcl9maW5pc2ggKC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjMyOSAuL2lu
Y2x1ZGUvbGludXgvcmN1cGRhdGUuaDo3ODEgbmV0L2lwdjQvaXBfaW5wdXQuYzoyMzIpIAogIzU6
IGZmZmY4ODgwMDdhODcwMTggKHNsb2NrLUFGX0lORVQvMSl7Ky4tLn0tezI6Mn0sIGF0OiB0Y3Bf
djRfcmN2ICguL2luY2x1ZGUvbGludXgvc2tidWZmLmg6MTY0MCAuL2luY2x1ZGUvbmV0L3RjcC5o
OjI1MTAgbmV0L2lwdjQvdGNwX2lwdjQuYzoyMzQyKSAKICM2OiBmZmZmZmZmZmI4ODQ5YzAwIChy
Y3VfcmVhZF9sb2NrKXsuLi4ufS17MToyfSwgYXQ6IHNrX3Bzb2NrX3N0cnBfZGF0YV9yZWFkeSAo
Li9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6MzI5IC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5o
Ojc4MSBuZXQvY29yZS9za21zZy5jOjExMTMpIAogIzc6IGZmZmY4ODgwMDdhODcyMjggKGNsb2Nr
LUFGX0lORVQpeysrLS19LXsyOjJ9LCBhdDogc2tfcHNvY2tfc3RycF9kYXRhX3JlYWR5IChuZXQv
Y29yZS9za21zZy5jOjExMjApIAogIzg6IGZmZmZmZmZmYjg4NDljMDAgKHJjdV9yZWFkX2xvY2sp
ey4uLi59LXsxOjJ9LCBhdDogc2tfcHNvY2tfc3RycF9yZWFkICguL2luY2x1ZGUvbGludXgvcmN1
cGRhdGUuaDozMjkgLi9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6NzgxIG5ldC9jb3JlL3NrbXNn
LmM6MTA2MikgCgogc3RhY2sgYmFja3RyYWNlOgogQ1BVOiAwIFBJRDogMzQyIENvbW06IHRlc3Rf
c29ja21hcCBOb3QgdGFpbnRlZCA2LjEwLjAtcmMyICM1OQogSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAx
NAogQ2FsbCBUcmFjZToKICAgPElSUT4KICBkdW1wX3N0YWNrX2x2bCAobGliL2R1bXBfc3RhY2su
YzoxMTgpIAogIF9fbG9ja19hY3F1aXJlIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6Mzg1OCBr
ZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTEzNykgCiAgPyBfX3BmeF9fX2xvY2tfYWNxdWlyZSAo
a2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ5OTMpIAogID8gdGNwX3Jjdl9lc3RhYmxpc2hlZCAo
Li9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oOjIwOTcgLi9pbmNsdWRlL25ldC90Y3AuaDoyMDI2IC4v
aW5jbHVkZS9uZXQvdGNwLmg6MjA5OSBuZXQvaXB2NC90Y3BfaW5wdXQuYzo1NjYwIG5ldC9pcHY0
L3RjcF9pbnB1dC5jOjYxNzkpIAogID8gdGNwX3Y0X3JjdiAobmV0L2lwdjQvdGNwX2lwdjQuYzoy
MzQ1KSAKICA/IGlwX3Byb3RvY29sX2RlbGl2ZXJfcmN1IChuZXQvaXB2NC9pcF9pbnB1dC5jOjIw
NyAoZGlzY3JpbWluYXRvciA4KSkgCiAgPyBpcF9sb2NhbF9kZWxpdmVyX2ZpbmlzaCAoLi9pbmNs
dWRlL2xpbnV4L3JjdXBkYXRlLmg6ODEwIG5ldC9pcHY0L2lwX2lucHV0LmM6MjM0KSAKICA/IF9f
cGZ4X21hcmtfbG9jayAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ2MzkpIAogIGxvY2tfYWNx
dWlyZSAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ2NyBrZXJuZWwvbG9ja2luZy9sb2NrZGVw
LmM6NTc1NiBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTcxOSkgCiAgPyBza19wc29ja19za2Jf
aW5ncmVzc19lbnF1ZXVlICguL2luY2x1ZGUvbGludXgvc2ttc2cuaDo0NjcgbmV0L2NvcmUvc2tt
c2cuYzo1NTUpIAogID8gX19wZnhfbG9ja19hY3F1aXJlIChrZXJuZWwvbG9ja2luZy9sb2NrZGVw
LmM6NTcyMikgCiAgPyBfX3BmeF9sb2NrX3JlbGVhc2UgKGtlcm5lbC9sb2NraW5nL2xvY2tkZXAu
Yzo1NzYyKSAKICA/IG1hcmtfaGVsZF9sb2NrcyAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQy
NzQpIAogID8gc2tfcHNvY2tfc2tiX2luZ3Jlc3NfZW5xdWV1ZSAoLi9pbmNsdWRlL2xpbnV4L3Nr
bXNnLmg6NDY2IG5ldC9jb3JlL3NrbXNnLmM6NTU1KSAKICBfcmF3X3JlYWRfbG9ja19iaCAoLi9p
bmNsdWRlL2xpbnV4L3J3bG9ja19hcGlfc21wLmg6MTc3IGtlcm5lbC9sb2NraW5nL3NwaW5sb2Nr
LmM6MjUyKSAKICA/IHNrX3Bzb2NrX3NrYl9pbmdyZXNzX2VucXVldWUgKC4vaW5jbHVkZS9saW51
eC9za21zZy5oOjQ2NyBuZXQvY29yZS9za21zZy5jOjU1NSkgCiAgc2tfcHNvY2tfc2tiX2luZ3Jl
c3NfZW5xdWV1ZSAoLi9pbmNsdWRlL2xpbnV4L3NrbXNnLmg6NDY3IG5ldC9jb3JlL3NrbXNnLmM6
NTU1KSAKICBza19wc29ja19za2JfaW5ncmVzc19zZWxmIChuZXQvY29yZS9za21zZy5jOjYwNykg
CiAgc2tfcHNvY2tfdmVyZGljdF9hcHBseSAobmV0L2NvcmUvc2ttc2cuYzoxMDA4KSAKICBza19w
c29ja19zdHJwX3JlYWQgKC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjgxMCBuZXQvY29yZS9z
a21zZy5jOjEwODEpIAogID8gc2tfcHNvY2tfc3RycF9wYXJzZSAobmV0L2NvcmUvc2ttc2cuYzox
MTA0KSAKICBfX3N0cnBfcmVjdiAobmV0L3N0cnBhcnNlci9zdHJwYXJzZXIuYzozMDEgKGRpc2Ny
aW1pbmF0b3IgMykpIAogIHRjcF9yZWFkX3NvY2sgKG5ldC9pcHY0L3RjcC5jOjE1ODMpIAogID8g
X19wZnhfc3RycF9yZWN2IChuZXQvc3RycGFyc2VyL3N0cnBhcnNlci5jOjMzMikgCiAgPyBfX3Bm
eF90Y3BfcmVhZF9zb2NrIChuZXQvaXB2NC90Y3AuYzoxNTYwKSAKICA/IGxvY2tfYWNxdWlyZSAo
a2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ2NyBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTc1
NiBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTcxOSkgCiAgc3RycF9yZWFkX3NvY2sgKG5ldC9z
dHJwYXJzZXIvc3RycGFyc2VyLmM6MzU4KSAKICA/IF9fcGZ4X3N0cnBfcmVhZF9zb2NrIChuZXQv
c3RycGFyc2VyL3N0cnBhcnNlci5jOjM0NikgCiAgPyBfX3BmeF9kb19yYXdfd3JpdGVfbG9jayAo
a2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfZGVidWcuYzoyMDkpIAogID8gbG9ja19pc19oZWxkX3R5
cGUgKGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo0Njcga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5j
OjU4MjYpIAogIHN0cnBfZGF0YV9yZWFkeSAobmV0L3N0cnBhcnNlci9zdHJwYXJzZXIuYzozODgg
bmV0L3N0cnBhcnNlci9zdHJwYXJzZXIuYzozNjYpIAogIHNrX3Bzb2NrX3N0cnBfZGF0YV9yZWFk
eSAobmV0L2NvcmUvc2ttc2cuYzoxMTIxKSAKICB0Y3BfZGF0YV9xdWV1ZSAobmV0L2lwdjQvdGNw
X2lucHV0LmM6NTIzNCkgCiAgPyBsb2NrX3JlbGVhc2UgKGtlcm5lbC9sb2NraW5nL2xvY2tkZXAu
Yzo0Njcga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjU3NzYpIAogID8gX19wZnhfdGNwX2RhdGFf
cXVldWUgKG5ldC9pcHY0L3RjcF9pbnB1dC5jOjUxNDgpIAogID8gX19wZnhfdGNwX3VyZyAobmV0
L2lwdjQvdGNwX2lucHV0LmM6NTgyMCkgCiAgPyBsb2NrZGVwX2hhcmRpcnFzX29uIChrZXJuZWwv
bG9ja2luZy9sb2NrZGVwLmM6NDQyMSkgCiAgPyBrdm1fY2xvY2tfZ2V0X2N5Y2xlcyAoLi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wcmVlbXB0Lmg6OTQgYXJjaC94ODYva2VybmVsL2t2bWNsb2NrLmM6
ODAgYXJjaC94ODYva2VybmVsL2t2bWNsb2NrLmM6ODYpIAogID8ga3RpbWVfZ2V0IChrZXJuZWwv
dGltZS90aW1la2VlcGluZy5jOjE5NSAoZGlzY3JpbWluYXRvciA0KSBrZXJuZWwvdGltZS90aW1l
a2VlcGluZy5jOjM5NSAoZGlzY3JpbWluYXRvciA0KSBrZXJuZWwvdGltZS90aW1la2VlcGluZy5j
OjQwMyAoZGlzY3JpbWluYXRvciA0KSBrZXJuZWwvdGltZS90aW1la2VlcGluZy5jOjg1MCAoZGlz
Y3JpbWluYXRvciA0KSkgCiAgdGNwX3Jjdl9lc3RhYmxpc2hlZCAoLi9pbmNsdWRlL2xpbnV4L3Nr
YnVmZi5oOjIwOTcgLi9pbmNsdWRlL25ldC90Y3AuaDoyMDI2IC4vaW5jbHVkZS9uZXQvdGNwLmg6
MjA5OSBuZXQvaXB2NC90Y3BfaW5wdXQuYzo1NjYwIG5ldC9pcHY0L3RjcF9pbnB1dC5jOjYxNzkp
IAogID8gX19wZnhfbG9ja19hY3F1aXJlIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTcyMikg
CiAgPyBfX3BmeF90Y3BfaW5ib3VuZF9oYXNoLmNvbnN0cHJvcC4wICguL2luY2x1ZGUvbmV0L3Rj
cC5oOjI4MDApIAogID8gX19wZnhfdGNwX3Jjdl9lc3RhYmxpc2hlZCAobmV0L2lwdjQvdGNwX2lu
cHV0LmM6NjAwNikgCiAgPyBkb19yYXdfc3Bpbl9sb2NrICguL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2F0b21pYy5oOjEwNyAuL2luY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1hcmNoLWZhbGxiYWNr
Lmg6MjE3MCAuL2luY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1pbnN0cnVtZW50ZWQuaDoxMzAy
IC4vaW5jbHVkZS9hc20tZ2VuZXJpYy9xc3BpbmxvY2suaDoxMTEga2VybmVsL2xvY2tpbmcvc3Bp
bmxvY2tfZGVidWcuYzoxMTYpIAogIHRjcF92NF9kb19yY3YgKG5ldC9pcHY0L3RjcF9pcHY0LmM6
MTk1NikgCiAgdGNwX3Y0X3JjdiAobmV0L2lwdjQvdGNwX2lwdjQuYzoyMzQ1KSAKICA/IF9fcGZ4
X3RjcF92NF9yY3YgKG5ldC9pcHY0L3RjcF9pcHY0LmM6MjE3MikgCiAgPyBfX3BmeF9yYXdfbG9j
YWxfZGVsaXZlciAobmV0L2lwdjQvcmF3LmM6MjAxKSAKICA/IF9fcGZ4X21hcmtfbG9jayAoa2Vy
bmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ2MzkpIAogID8gX19wZnhfbG9ja19yZWxlYXNlIChrZXJu
ZWwvbG9ja2luZy9sb2NrZGVwLmM6NTc2MikgCiAgPyBsb2NrX2lzX2hlbGRfdHlwZSAoa2VybmVs
L2xvY2tpbmcvbG9ja2RlcC5jOjQ2NyBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTgyNikgCiAg
aXBfcHJvdG9jb2xfZGVsaXZlcl9yY3UgKG5ldC9pcHY0L2lwX2lucHV0LmM6MjA3IChkaXNjcmlt
aW5hdG9yIDgpKSAKICBpcF9sb2NhbF9kZWxpdmVyX2ZpbmlzaCAoLi9pbmNsdWRlL2xpbnV4L3Jj
dXBkYXRlLmg6ODEwIG5ldC9pcHY0L2lwX2lucHV0LmM6MjM0KSAKICBpcF9sb2NhbF9kZWxpdmVy
ICguL2luY2x1ZGUvbGludXgvbmV0ZmlsdGVyLmg6MzE0IC4vaW5jbHVkZS9saW51eC9uZXRmaWx0
ZXIuaDozMDggbmV0L2lwdjQvaXBfaW5wdXQuYzoyNTQpIAogID8gX19wZnhfaXBfbG9jYWxfZGVs
aXZlciAobmV0L2lwdjQvaXBfaW5wdXQuYzoyNDMpIAogID8gbG9ja19pc19oZWxkX3R5cGUgKGtl
cm5lbC9sb2NraW5nL2xvY2tkZXAuYzo0Njcga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjU4MjYp
IAogID8gaXBfcmN2X2ZpbmlzaF9jb3JlLmNvbnN0cHJvcC4wICguL2luY2x1ZGUvbmV0L25ldF9u
YW1lc3BhY2UuaDozODMgLi9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5oOjI1NzcgbmV0L2lwdjQv
aXBfaW5wdXQuYzozNzIpIAogIGlwX3JjdiAoLi9pbmNsdWRlL25ldC9kc3QuaDo0NjAgbmV0L2lw
djQvaXBfaW5wdXQuYzo0NDkgLi9pbmNsdWRlL2xpbnV4L25ldGZpbHRlci5oOjMxNCAuL2luY2x1
ZGUvbGludXgvbmV0ZmlsdGVyLmg6MzA4IG5ldC9pcHY0L2lwX2lucHV0LmM6NTY5KSAKICA/IF9f
cGZ4X2lwX3JjdiAobmV0L2lwdjQvaXBfaW5wdXQuYzo1NjIpIAogID8gbG9ja19hY3F1aXJlIChr
ZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDY3IGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo1NzU2
IGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo1NzE5KSAKICA/IGxvY2tfYWNxdWlyZSAoa2VybmVs
L2xvY2tpbmcvbG9ja2RlcC5jOjQ2NyBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTc1NiBrZXJu
ZWwvbG9ja2luZy9sb2NrZGVwLmM6NTcxOSkgCiAgPyBfX3BmeF9pcF9yY3YgKG5ldC9pcHY0L2lw
X2lucHV0LmM6NTYyKSAKICBfX25ldGlmX3JlY2VpdmVfc2tiX29uZV9jb3JlIChuZXQvY29yZS9k
ZXYuYzo1NjI0IChkaXNjcmltaW5hdG9yIDQpKSAKICA/IF9fcGZ4X19fbmV0aWZfcmVjZWl2ZV9z
a2Jfb25lX2NvcmUgKG5ldC9jb3JlL2Rldi5jOjU2MTcpIAogID8gbWFya19oZWxkX2xvY2tzIChr
ZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDI3NCkgCiAgcHJvY2Vzc19iYWNrbG9nICguL2luY2x1
ZGUvbGludXgvcmN1cGRhdGUuaDo4MTAgbmV0L2NvcmUvZGV2LmM6NjA2OCkgCiAgX19uYXBpX3Bv
bGwuY29uc3Rwcm9wLjAgKG5ldC9jb3JlL2Rldi5jOjY3MjEpIAogIG5ldF9yeF9hY3Rpb24gKG5l
dC9jb3JlL2Rldi5jOjY3OTIgbmV0L2NvcmUvZGV2LmM6NjkwNikgCiAgPyBfX3BmeF9uZXRfcnhf
YWN0aW9uIChuZXQvY29yZS9kZXYuYzo2ODcwKSAKICA/IF9fcGZ4X3JjdV9jb3JlIChrZXJuZWwv
cmN1L3RyZWUuYzoyNzU2KSAKICA/IG1hcmtfaGVsZF9sb2NrcyAoa2VybmVsL2xvY2tpbmcvbG9j
a2RlcC5jOjQyNzQpIAogID8gX19kZXZfcXVldWVfeG1pdCAoLi9pbmNsdWRlL2xpbnV4L3JjdXBk
YXRlLmg6MzM5IC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjg0OSBuZXQvY29yZS9kZXYuYzo0
NDIwKSAKICBoYW5kbGVfc29mdGlycXMgKGtlcm5lbC9zb2Z0aXJxLmM6NTU0KSAKICA/IF9fZGV2
X3F1ZXVlX3htaXQgKC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjMzOSAuL2luY2x1ZGUvbGlu
dXgvcmN1cGRhdGUuaDo4NDkgbmV0L2NvcmUvZGV2LmM6NDQyMCkgCiAgZG9fc29mdGlycSAoa2Vy
bmVsL3NvZnRpcnEuYzo0NTUga2VybmVsL3NvZnRpcnEuYzo0NDIpIAogICA8L0lSUT4KICAgPFRB
U0s+CiAgX19sb2NhbF9iaF9lbmFibGVfaXAgKGtlcm5lbC9zb2Z0aXJxLmM6MzgyKSAKICA/IF9f
ZGV2X3F1ZXVlX3htaXQgKC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjMzOSAuL2luY2x1ZGUv
bGludXgvcmN1cGRhdGUuaDo4NDkgbmV0L2NvcmUvZGV2LmM6NDQyMCkgCiAgX19kZXZfcXVldWVf
eG1pdCAobmV0L2NvcmUvZGV2LmM6NDQyMSkgCiAgPyBfX3BmeF9fX2xvY2tfYWNxdWlyZSAoa2Vy
bmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ5OTMpIAogID8gX19wZnhfbWFya19sb2NrIChrZXJuZWwv
bG9ja2luZy9sb2NrZGVwLmM6NDYzOSkgCiAgPyBfX3BmeF9fX2Rldl9xdWV1ZV94bWl0IChuZXQv
Y29yZS9kZXYuYzo0MzAyKSAKICA/IGZpbmRfaGVsZF9sb2NrIChrZXJuZWwvbG9ja2luZy9sb2Nr
ZGVwLmM6NTI0NCkgCiAgPyBsb2NrX3JlbGVhc2UgKGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo0
Njcga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjU3NzYpIAogID8gX19wZnhfbG9ja19yZWxlYXNl
IChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTc2MikgCiAgPyBfX3BmeF9fX2xvY2tfYWNxdWly
ZSAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ5OTMpIAogID8gbWFya19oZWxkX2xvY2tzIChr
ZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDI3NCkgCiAgaXBfZmluaXNoX291dHB1dDIgKC4vaW5j
bHVkZS9saW51eC9uZXRkZXZpY2UuaDozMDk1IC4vaW5jbHVkZS9uZXQvbmVpZ2hib3VyLmg6NTI2
IC4vaW5jbHVkZS9uZXQvbmVpZ2hib3VyLmg6NTQwIG5ldC9pcHY0L2lwX291dHB1dC5jOjIzNSkg
CiAgPyBfX3BmeF9uZl9ob29rICguL2luY2x1ZGUvbGludXgvbmV0ZmlsdGVyLmg6MjI3KSAKICA/
IGxvY2tfYWNxdWlyZSAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQ2NyBrZXJuZWwvbG9ja2lu
Zy9sb2NrZGVwLmM6NTc1NiBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTcxOSkgCiAgPyBfX3Bm
eF9pcF9maW5pc2hfb3V0cHV0MiAobmV0L2lwdjQvaXBfb3V0cHV0LmM6MTk5KSAKICA/IGlwX3Nr
Yl9kc3RfbXR1ICguL2luY2x1ZGUvbmV0L25ldF9uYW1lc3BhY2UuaDozODMgLi9pbmNsdWRlL2xp
bnV4L25ldGRldmljZS5oOjI1NzcgLi9pbmNsdWRlL25ldC9pcC5oOjQ2NSAuL2luY2x1ZGUvbmV0
L2lwLmg6NTAyKSAKICA/IF9faXBfcXVldWVfeG1pdCAobmV0L2lwdjQvaXBfb3V0cHV0LmM6NTM1
IChkaXNjcmltaW5hdG9yIDQpKSAKICBfX2lwX3F1ZXVlX3htaXQgKG5ldC9pcHY0L2lwX291dHB1
dC5jOjUzNSAoZGlzY3JpbWluYXRvciA0KSkgCiAgPyBfX3NrYl9jbG9uZSAoLi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9hdG9taWMuaDo1MyAoZGlzY3JpbWluYXRvciA0KSAuL2luY2x1ZGUvbGludXgv
YXRvbWljL2F0b21pYy1hcmNoLWZhbGxiYWNrLmg6OTkyIChkaXNjcmltaW5hdG9yIDQpIC4vaW5j
bHVkZS9saW51eC9hdG9taWMvYXRvbWljLWluc3RydW1lbnRlZC5oOjQzNiAoZGlzY3JpbWluYXRv
ciA0KSBuZXQvY29yZS9za2J1ZmYuYzoxNTc2IChkaXNjcmltaW5hdG9yIDQpKSAKICBfX3RjcF90
cmFuc21pdF9za2IgKG5ldC9pcHY0L3RjcF9vdXRwdXQuYzoxNDY2IChkaXNjcmltaW5hdG9yIDQp
KSAKICA/IF9fcGZ4X19fdGNwX3RyYW5zbWl0X3NrYiAobmV0L2lwdjQvdGNwX291dHB1dC5jOjEy
ODcpIAogID8gbG9ja19yZWxlYXNlIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDY3IGtlcm5l
bC9sb2NraW5nL2xvY2tkZXAuYzo1Nzc2KSAKICA/IF9fcGZ4X2xvY2tfcmVsZWFzZSAoa2VybmVs
L2xvY2tpbmcvbG9ja2RlcC5jOjU3NjIpIAogID8ga3RpbWVfZ2V0ICguL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2lycWZsYWdzLmg6NDIgLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnFmbGFncy5oOjc3
IC4vYXJjaC94ODYvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaDoxMzUgLi9pbmNsdWRlL2xpbnV4L3Nl
cWxvY2suaDo3NCBrZXJuZWwvdGltZS90aW1la2VlcGluZy5jOjg0OCkgCiAgPyBsb2NrZGVwX2hh
cmRpcnFzX29uIChrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NDQyMSkgCiAgdGNwX3dyaXRlX3ht
aXQgKG5ldC9pcHY0L3RjcF9vdXRwdXQuYzoyODI5KSAKICA/IF9fcGZ4X21lbV9jZ3JvdXBfY2hh
cmdlX3NrbWVtIChtbS9tZW1jb250cm9sLmM6Nzg4NikgCiAgPyBza2JfcGFnZV9mcmFnX3JlZmls
bCAobmV0L2NvcmUvc29jay5jOjI5MjAgbmV0L2NvcmUvc29jay5jOjI5MDQpIAogIF9fdGNwX3B1
c2hfcGVuZGluZ19mcmFtZXMgKG5ldC9pcHY0L3RjcF9vdXRwdXQuYzozMDE0KSAKICB0Y3Bfc2Vu
ZG1zZ19sb2NrZWQgKG5ldC9pcHY0L3RjcC5jOjEzMTYpIAogID8gcHJpbnRfdXNhZ2VfYnVnLnBh
cnQuMCAoa2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjM5ODApIAogID8gX19wZnhfdGNwX3NlbmRt
c2dfbG9ja2VkIChuZXQvaXB2NC90Y3AuYzoxMDQ2KSAKICA/IGxvY2tfcmVsZWFzZSAoa2VybmVs
L2xvY2tpbmcvbG9ja2RlcC5jOjQ2NyBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTc3NikgCiAg
PyBfX2xvY2FsX2JoX2VuYWJsZV9pcCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnFmbGFncy5o
OjQyIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaDo3NyBrZXJuZWwvc29mdGlycS5j
OjM4NykgCiAgdGNwX3NlbmRtc2cgKG5ldC9pcHY0L3RjcC5jOjEzNDkpIAogIF9fc3lzX3NlbmR0
byAobmV0L3NvY2tldC5jOjczMCBuZXQvc29ja2V0LmM6NzQ1IG5ldC9zb2NrZXQuYzoyMTkyKSAK
ICA/IF9fcGZ4X19fc3lzX3NlbmR0byAobmV0L3NvY2tldC5jOjIxNjIpIAogID8gbG9ja19pc19o
ZWxkX3R5cGUgKGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo0Njcga2VybmVsL2xvY2tpbmcvbG9j
a2RlcC5jOjU4MjYpIAogID8gZmRfaW5zdGFsbCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcmVl
bXB0Lmg6MTAzIC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oOjg5NiBmcy9maWxlLmM6NjMxKSAK
ICA/IF9fc3lzX2FjY2VwdDQgKC4vaW5jbHVkZS9saW51eC9maWxlLmg6NDcgbmV0L3NvY2tldC5j
OjIwMDIpIAogID8gX19wZnhfX19zeXNfYWNjZXB0NCAobmV0L3NvY2tldC5jOjE5OTQpIAogID8g
aGFuZGxlX21tX2ZhdWx0ICguL2luY2x1ZGUvbGludXgvbWVtY29udHJvbC5oOjEwNzggLi9pbmNs
dWRlL2xpbnV4L21lbWNvbnRyb2wuaDoxMDY2IG1tL21lbW9yeS5jOjU1NTcgbW0vbWVtb3J5LmM6
NTcwNCkgCiAgX194NjRfc3lzX3NlbmR0byAobmV0L3NvY2tldC5jOjIyMDApIAogID8gZG9fc3lz
Y2FsbF82NCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnFmbGFncy5oOjQyIC4vYXJjaC94ODYv
aW5jbHVkZS9hc20vaXJxZmxhZ3MuaDo3NyAuL2luY2x1ZGUvbGludXgvZW50cnktY29tbW9uLmg6
MTk3IGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjc5KSAKICA/IGxvY2tkZXBfaGFyZGlycXNfb24g
KGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo0NDIxKSAKICBkb19zeXNjYWxsXzY0IChhcmNoL3g4
Ni9lbnRyeS9jb21tb24uYzo1MiBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo4MykgCiAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjEzMCkg
Cg==
--00000000000088f9f3061a35c0be--

