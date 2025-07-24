Return-Path: <bpf+bounces-64299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A986B11214
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5B4169F2A
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1167239567;
	Thu, 24 Jul 2025 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m83eFkuk"
X-Original-To: bpf@vger.kernel.org
Received: from sonic307-21.consmr.mail.sg3.yahoo.com (sonic307-21.consmr.mail.sg3.yahoo.com [106.10.241.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32A223DCC
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388152; cv=none; b=Zh8Vulk5LEmy2qNJSAmV4lsGEUahgbpFTOa0vCiTazbm0lF29//dtqeGAuTN/jpRM6j1tLFad0o56GnwR6N58LiUO4QQS6/6k2oHWVPW0wxFEzWUPTFeWPeuo9BFWwKCSetQzwd4WoWF9rDnLVwQ8K+HnH4VJ99kRr3lCHHnM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388152; c=relaxed/simple;
	bh=S6ZDYt5O6xm5jRZ8gLx8OKGczxEr7L+6GVvi+61FWA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF8vesBwIG7xUSE10QZzRF61tcW19WYO0z423Vtksuy7g7I/ozkk7rFJYyCbdBKCpqTDU+QKxSLIkvqmTlraxBjNorxNrt13/A8nZM6WxxtY2TrCsqHo8Zo4bZ+7yolCbNQZ+Scw3tPXyzaGOjeORkKjvZ0PR2/x47XAYFQ9GDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=m83eFkuk; arc=none smtp.client-ip=106.10.241.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753388140; bh=NGurmw6gZodHcnbTMwXOTOH3ALt8HpOyovrDsN5l9yo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=m83eFkuk1jVvzxa1uflmLNVuM/VJ3Ha3JdilAHSYyxbQaHjUIH9U75TemHCWd125je37yymPCAXSIVB8PprqX2/RDeYejzYx6Lfy6D6UyPjZ1f3jf2CkSs1n4zooHugTQYcGL7fWV7uk+XCh9CT/5g/aszS9FU+VPno/CQdFy2iTziuyblNFjGG5FktMnZbpl/HlQEYuPD5mZPIbmhGXzmvW1B89JoyZOUE0e5hAtO6+eFmk6gymtCtBaJbNeu/otzE/ggLTEMbryehkdW8YMhe8OaBSK0/fLkwzBGhlEMyv4EUzFim69mmu+pCfAvq4f0Bn7v3hcVnq6V/eus3uBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753388140; bh=/q5lxUxOrtsrsd43R6KDoxJn3VKwTNk0BDCP3p3LzRU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ce1V5gC1u96cEvov/3Yy6w13+v8j+y7NuKdqyiD6RR7nux4D3a3OLKFDR207iaiDAGPn8HQOOAPpBwxW/JaAjp4kJbZww5NoxZEqDi9mLv7P8kkNCKTfjlg+6ulnMxPRL0xCdmem1I21SJVaD3oxkm9H18A5qScX8Uf22ZwwQdDCdDe0mIVl+GdlN4gIGxDBzNchMf9SuQ3hPDN12vikm1Ljk1KS+uNPvoQYKvff8IJNLV19s+j4KSM2rs1z20gQpMnUBetP5KzDRSPNQYvBfIrx5u5/65ylEv5Xk8jDyOIlvS4BC+DOhZFvd7MVBvcHfMAB4gdI5o6EHg9J7yZZUQ==
X-YMail-OSG: YpIzeaAVM1kIbF2U2g7NWXcgrG1QItkbQ7NbKby3Xl1SNcSjZ4fHa.ybUbCE52X
 2GOFg0lW7Jn_yKsyJi.H.GYx5aZ7mjouvtAJqufH1h7iC3_tFdIlikw8bnLiJPHbsuyLybpxB9jv
 gXKWKFrgQGbtJdA_S2OlPMRIjEIPl6hVDCyu3IYgbhPUrk0BOmBjRuksXwUBr8ogSqOet5LTkH8k
 EGknVYb2Skd39XujJUn.OHuRvVUYQzecN20haVTU78R.QGxUd6oqLWSEyXRYAQsj874d1Dmcso4G
 9qUzpXggKAy4EuQ0wG5GsLFR2gdrigxb8maED8hh.BtSdDZEYLNBZ4B_ELRCm7VaQwakaPWqjqPR
 Vh4tRz0z6HQGDlX_w084BhrAUPn0.lq2_o3kgE.WpoJgtnTa4QbjSkCPndpfa01UWNahZuUxuzg8
 xLEl4RxZuV0_yoEhjbWmmrgJCVhNzhV.GzA1MFJV3H201wws1s8oRDQyK1FlcV7eht.YCE.f4KsA
 UKmH1iFCQXqYWXUgojW9v3ULii7bkEtyNOL0nIu21yEy0sSpM6bpUKbixSabqkIW8enNNSBtSdPI
 wO.dkBJTcnj02KYacr5XV.tZv0LNynDeHoDjcRVubbEjFFPR4i4b2OZafeV9_eGVT1vd2z1PKBru
 t6fVnN3g0v_3g2s9a2zHg_0TCTaceI7uVZuSclMQnvxu5cONs4LhosMVxNBv6sbe153CsJ5v0ftI
 Pvq93rIpn0MTlVOl09.ES4.0MoV5n8dN3NbkemhTM8Pn3beJVPwipmxEweW.YVP_FJzc2XiTiyK3
 kRZO9YKdUsR90RmCJCFPj_FniYSCJ0PvOg4KmAs_vCRWEwAYxqX46z01mvA_Pm4DxGxWgiTh2dXw
 u58n3x2kVatfeQWcpUGy6OGCsi3P5Y7ESAvSznevIbLvN7s9kJCYzKQu2vJZ4U2l6wkCAoWVo2rN
 HkDZdYkuxDRGKnrFcqrhv_c_tHabq0Kz_PeZMstgJnQt_xD80NyAX3uWV8rlZvcKksj1Z7Hbh2T5
 ljitfTCFhpKib2NVkZwqAoJCHuHsiMlc4AMQo3aLVEmEbA1Rl4L2z1aum03yt4naZLNMQLttKdBm
 4tLm5xi25WypVlADPC3P9qaXar9V68MYtR3y_z6Dy1blKWREihRa6.jwdz_o56dOp6J0L7Lh1Ckd
 oXaD.HYWD7DZzLYnFCekZEO2rpfARs57tp8zELqhs.r3bTqQuDBz2gu23Az.ulIM2sQzJG4FFP0R
 SWIUum6bXCZo9MkhLMuAPme29TgIj03vzy0Z8XsRRPwnVGKzVX..5WasnQhdZeZyT3winPkWCxIF
 69iMUQ4rM4lyyzD481CrtvrFhR9mK5SCjLQh1F66LIy4BOs2ViOpkX8P4QoaDKPcC71UptE6WYkI
 6_itXcnjtAPOoHVeXg3T.6How_yKv59jbx_wGta2KN3NSnFNBqKNdC4dBHDFciznjQfC8dXrMF_h
 MxTFuRoWwI0GGDfdzO2k51Ouf74QxS.hAvbFWaAJLu6CdyZPSisUSzneJRgoPwk6zsDTiX1.XHcQ
 zN_tLlQ0XxzPnJeUkUXrfOzAIG9MK1FgQhjIhsEU4K7RGM8eyr1VQKcIKxGfUQljGD4jXuCkcECT
 oHCywpk_uVVzhMfvbFH4.5QE1JYnREGbZaxXfzUgti4N852piGl4RPi1nBfYhZg8St1thK1_7rpn
 NrYwvnHsB03XPU41EH5bXnwxH3HPeguzgskCn19gKzLNhp.7FCLdv7PJRjoz.ToojZJVpMJz3zb9
 7ukX4Kl6LN9_ogLGLM0bicsQiGPT_sM4oE1lKq53qe0nO7mTnLASLs9GI0q5NZqcupyjYNsleGGF
 8kFT634oymWFHTqG7SQsz9P_QMOXQEOYZWbFy0cB7Zaw4CMzdPtWV1whEHTr07ybe9wxQi4i.AL4
 uE8.gyHUYxfgp0kmAThwn2jDpBkF1EmVsfe9U_NxzgaELlwpdU2zgMBDOmE.tmgkETROm9IiB66q
 BuKzdZHgN3Sj4on_IIs3RjAsPpLclYX09HTmJTnBJ0Xxm86ybEtXQgYbYd6P8uvphNB.lZETM3Yb
 mkBn5bFZyqaP4Xwl7k8ZgtzneVXAz2n3TvgOo1ykMGNKfdJJw5kju2Hda_Xas9bezOHUJafe1Z6x
 7TujpWD8IyFyEHTyjX7yvn2XAFpt1ruarwVa2sfpv7j71BQ.uWrg3KTxzYjLyF1fo94WHfO_0_QT
 ZM6MVWmZMbcIv3qAMG05sDS8adVIkuI7LADtVeFczNvLVXB4U4XoTBOg9EUTvORJg1C5e3kiNcm1
 lgHSkgK8Vwsyie8iQ_L31
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: d22fbf55-e853-4b46-a9b7-92f47fb303b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Thu, 24 Jul 2025 20:15:40 +0000
Received: by hermes--production-ne1-9495dc4d7-vm8nz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba5944df1bf98b049dd2dbc2e489772b;
          Thu, 24 Jul 2025 20:05:29 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	kuniyu@amazon.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH v2 6.1] net: add netdev_lockdep_set_classes() to virtual drivers
Date: Thu, 24 Jul 2025 15:05:22 -0500
Message-ID: <20250724200524.172820-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1753367981-e2a8d101@stable.kernel.org>
References: <1753367981-e2a8d101@stable.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59 upstream.

Based on a syzbot report, it appears many virtual
drivers do not yet use netdev_lockdep_set_classes(),
triggerring lockdep false positives.

WARNING: possible recursive locking detected
6.8.0-rc4-next-20240212-syzkaller #0 Not tainted

syz-executor.0/19016 is trying to acquire lock:
 ffff8880162cb298 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 ffff8880162cb298 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4452 [inline]
 ffff8880162cb298 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340

but task is already holding lock:
 ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4452 [inline]
 ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
  lock(_xmit_ETHER#2);
  lock(_xmit_ETHER#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

9 locks held by syz-executor.0/19016:
  #0: ffffffff8f385208 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
  #0: ffffffff8f385208 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6603
  #1: ffffc90000a08c00 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x600 kernel/time/timer.c:1697
  #2: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
  #2: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
  #2: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1360 net/ipv4/ip_output.c:228
  #3: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
  #3: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
  #3: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4284
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:195 [inline]
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3771 [inline]
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x1262/0x3b10 net/core/dev.c:4325
  #5: ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  #5: ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4452 [inline]
  #5: ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340
  #6: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
  #6: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
  #6: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1360 net/ipv4/ip_output.c:228
  #7: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
  #7: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
  #7: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4284
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:195 [inline]
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3771 [inline]
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x1262/0x3b10 net/core/dev.c:4325

stack backtrace:
CPU: 1 PID: 19016 Comm: syz-executor.0 Not tainted 6.8.0-rc4-next-20240212-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  check_deadlock kernel/locking/lockdep.c:3062 [inline]
  validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  __netif_tx_lock include/linux/netdevice.h:4452 [inline]
  sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340
  __dev_xmit_skb net/core/dev.c:3784 [inline]
  __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4325
  neigh_output include/net/neighbour.h:542 [inline]
  ip_finish_output2+0xe66/0x1360 net/ipv4/ip_output.c:235
  iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
  ip_tunnel_xmit+0x20ee/0x2960 net/ipv4/ip_tunnel.c:831
  erspan_xmit+0x9de/0x1460 net/ipv4/ip_gre.c:720
  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
  xmit_one net/core/dev.c:3555 [inline]
  dev_hard_start_xmit+0x242/0x770 net/core/dev.c:3571
  sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:342
  __dev_xmit_skb net/core/dev.c:3784 [inline]
  __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4325
  neigh_output include/net/neighbour.h:542 [inline]
  ip_finish_output2+0xe66/0x1360 net/ipv4/ip_output.c:235
  igmpv3_send_cr net/ipv4/igmp.c:723 [inline]
  igmp_ifc_timer_expire+0xb71/0xd90 net/ipv4/igmp.c:813
  call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
  expire_timers kernel/time/timer.c:1751 [inline]
  __run_timers+0x621/0x830 kernel/time/timer.c:2038
  run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
  __do_softirq+0x2bc/0x943 kernel/softirq.c:554
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1076 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 RIP: 0010:resched_offsets_ok kernel/sched/core.c:10127 [inline]
 RIP: 0010:__might_resched+0x16f/0x780 kernel/sched/core.c:10142
Code: 00 4c 89 e8 48 c1 e8 03 48 ba 00 00 00 00 00 fc ff df 48 89 44 24 38 0f b6 04 10 84 c0 0f 85 87 04 00 00 41 8b 45 00 c1 e0 08 <01> d8 44 39 e0 0f 85 d6 00 00 00 44 89 64 24 1c 48 8d bc 24 a0 00
RSP: 0018:ffffc9000ee069e0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880296a9e00
RDX: dffffc0000000000 RSI: ffff8880296a9e00 RDI: ffffffff8bfe8fa0
RBP: ffffc9000ee06b00 R08: ffffffff82326877 R09: 1ffff11002b5ad1b
R10: dffffc0000000000 R11: ffffed1002b5ad1c R12: 0000000000000000
R13: ffff8880296aa23c R14: 000000000000062a R15: 1ffff92001dc0d44
  down_write+0x19/0x50 kernel/locking/rwsem.c:1578
  kernfs_activate fs/kernfs/dir.c:1403 [inline]
  kernfs_add_one+0x4af/0x8b0 fs/kernfs/dir.c:819
  __kernfs_create_file+0x22e/0x2e0 fs/kernfs/file.c:1056
  sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
  create_files fs/sysfs/group.c:64 [inline]
  internal_create_group+0x4f4/0xf20 fs/sysfs/group.c:152
  internal_create_groups fs/sysfs/group.c:192 [inline]
  sysfs_create_groups+0x56/0x120 fs/sysfs/group.c:218
  create_dir lib/kobject.c:78 [inline]
  kobject_add_internal+0x472/0x8d0 lib/kobject.c:240
  kobject_add_varg lib/kobject.c:374 [inline]
  kobject_init_and_add+0x124/0x190 lib/kobject.c:457
  netdev_queue_add_kobject net/core/net-sysfs.c:1706 [inline]
  netdev_queue_update_kobjects+0x1f3/0x480 net/core/net-sysfs.c:1758
  register_queue_kobjects net/core/net-sysfs.c:1819 [inline]
  netdev_register_kobject+0x265/0x310 net/core/net-sysfs.c:2059
  register_netdevice+0x1191/0x19c0 net/core/dev.c:10298
  bond_newlink+0x3b/0x90 drivers/net/bonding/bond_netlink.c:576
  rtnl_newlink_create net/core/rtnetlink.c:3506 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3726 [inline]
  rtnl_newlink+0x158f/0x20a0 net/core/rtnetlink.c:3739
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6606
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3c/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc3fa87fa9c

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240212140700.2795436-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
Changes in v2:
- With previous patch, Not able to apply on the 6.1 branch. Updated the
  code changes in 6.1 branch. 
- Link to v1:https://lore.kernel.org/all/20250724043010.129297-1-sumanth.gavini@yahoo.com/
---
 drivers/net/dummy.c            | 1 +
 drivers/net/geneve.c           | 1 +
 drivers/net/loopback.c         | 1 +
 drivers/net/veth.c             | 1 +
 drivers/net/vxlan/vxlan_core.c | 1 +
 net/ipv4/ip_tunnel.c           | 1 +
 net/ipv6/ip6_gre.c             | 2 ++
 net/ipv6/ip6_tunnel.c          | 1 +
 net/ipv6/ip6_vti.c             | 1 +
 net/ipv6/sit.c                 | 1 +
 10 files changed, 11 insertions(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index aa0fc00faecb..f05d4194eb09 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -71,6 +71,7 @@ static int dummy_dev_init(struct net_device *dev)
 	if (!dev->lstats)
 		return -ENOMEM;
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 3dd5c69b05cb..b31441fc99fc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -349,6 +349,7 @@ static int geneve_init(struct net_device *dev)
 		gro_cells_destroy(&geneve->gro_cells);
 		return err;
 	}
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index b213397672d2..8dc6a4df93c7 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -144,6 +144,7 @@ static int loopback_dev_init(struct net_device *dev)
 	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
 	if (!dev->lstats)
 		return -ENOMEM;
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e1e7df00e85c..ce90b093bb45 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1373,6 +1373,7 @@ static void veth_free_queues(struct net_device *dev)
 
 static int veth_dev_init(struct net_device *dev)
 {
+	netdev_lockdep_set_classes(dev);
 	return veth_alloc_queues(dev);
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 747ce00dd321..50dacdc1b6a7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2998,6 +2998,7 @@ static int vxlan_init(struct net_device *dev)
 	if (err)
 		goto err_free_percpu;
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 err_free_percpu:
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 73d7372afb43..90e55b9979e6 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1298,6 +1298,7 @@ int ip_tunnel_init(struct net_device *dev)
 
 	if (tunnel->collect_md)
 		netif_keep_dst(dev);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_init);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b3e2d658af80..718fcad69cf1 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1537,6 +1537,7 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	ip6gre_tnl_init_features(dev);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
@@ -1929,6 +1930,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a82d382193e4..2a470c0c38ae 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1902,6 +1902,7 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 destroy_dst:
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index cb71463bbbab..add7276986f1 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -937,6 +937,7 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	if (!dev->tstats)
 		return -ENOMEM;
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c..eb4c8e2a2b12 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1460,6 +1460,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
 		return err;
 	}
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
-- 
2.43.0


