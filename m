Return-Path: <bpf+bounces-64234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A07B0FFB0
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 06:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD84564147
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754101F8937;
	Thu, 24 Jul 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kQSiuVN8"
X-Original-To: bpf@vger.kernel.org
Received: from sonic310-21.consmr.mail.sg3.yahoo.com (sonic310-21.consmr.mail.sg3.yahoo.com [106.10.244.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DB1E5B82
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332037; cv=none; b=Kfk2PMu0PQHgsa/cZcfjr8hHp8XmWRdReS+XSU/6e9m3e1rhcv0bnbZfHLsSGm+Kyjs29CgWSvLLt4ZRJ+4qOUT0h1TnQSJbsn9BV2h3CJKc6qvpNZTDvoIUsTs704lI9UI0X0/gPRLbHxXxPGrzOsZotlHzNBf5lhQ8aenfmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332037; c=relaxed/simple;
	bh=ePmOVTarAt2rf82NusGQFjF8cZ5wgIGz43QXgnV2NcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=WfRVlIeNmSC2hZUHCLNi9IY9+RhoWaovj7K3ciqY1bnOKAzYjrL09P0+oixGzPYu37ErH2vyWAfvS4BYNbLRl3ftzRIAO3FWyThHRJJSAJdUvDXi+/XhTitwZeytVMND3vx0M0ZLepAexdeuH025rk38sqUeVIi4EH3yBswC+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kQSiuVN8; arc=none smtp.client-ip=106.10.244.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753332027; bh=GVGjwZCKFTawD0RDHIHwLY8BD4tWlYu9ievwd0Nqm2k=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=kQSiuVN8c2k7aHvo7vys9RmfrY88ftfyY+4n5DG3vabxwfNfSDbxcNKCTs6wpphpv4vDOt75vagJRCUO5JIwmDHsQSMyYACnEYr3B6vOQscd9bk809oVUZuyJCHTtD3J1NCt8U+I9vLwJumM9wdQ1XFF9OrIFqeUSozgAL6GjuLCuENVxT3B1kYqIKEXuZtVkgG1+9QIVzXdsRaHR+twkCDXGY+VK9W8VgtKNeVO7fGIRoPLlsAxmF5CWNHQAOdqw6kw3d6BsHxHD0Okg1jTc3xijO8ff9hlKid5p2jfblF1a2X0WieOtYuCrgTmlwJKKvpFLz6Ou1zcjXxJ/BDOCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753332027; bh=3EygnJGT4oEOps2xHpWe1LKdCl/Lk5oR4a0R6qwqnrm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PhH/pD++lkIAoAYx2B11OpSFNuFNqj5bRaBYx+FQh5AE+acwp6Dq0cnWrvOOyFN9J0CJzVrz5K0nUti7l3K1lIgzYP6zl/T43jp1GwTO4fqnPm+HP1cgSRcDGEyymYPRm99XK6YMJF14CxHEqdzh2H25/UPKHpgHhhuiAgvdig2ZQmFE0oP+0eUIE9XPPE1OO6c+4NAA3H5nmuCcbMLNznwT1u0PXaAM4PLdNauO7PgsObJxj/VncAVmRz7wOiFnQtaZwB3hdCI2IpG5bbH4he1TjD+9YoG9ciklzSM5PMcxd8BYU6E8bb1LBWrx/P22IQhGWs1lDABhB+HKVW6vTw==
X-YMail-OSG: b2EaZZQVM1kLVENHUMZDtC40xMXIh.jcAxHlVmjOgPqShlcjLyzqNVqEVd_ekL5
 uxrklzmy2JCtpK6tPO105AKuQrmCu646W18pRDLN.pVRFnLupW8tmaagOgcOtgoE69XYzjYc1LwQ
 WuEcdd3x22UEXUMuuN0BaVv24wpgzISC3pRWk4LlbefEBGk5G.npPDMSmBBrceZJsz.wgWtjS5iT
 HKLz3YfPcAI8jP5Bp7h3cWI6WFPRicOQUs1xmCYTnDJGzhVSzkr_Z_wSeR_LpV.8Bh.RZrDCSlmX
 ZCqmVlEL9GTl4CMMGV.DR_UJt0r9_LRgUOjJiDuTGrVPFLieZDKH19nBLGYeajrCKn886SyhYSO1
 Cefp3fEx.p_Ce4VsukVRvbANwI3Pgs77T9okwhMJu30_4zJsrt.kIYyAo28ly4a9DSwi6XbG01SJ
 L_NlmaTHSLApjG2Y_s3i6j8agw5C0qRKLKH1bcW83FQbbMteCFsjqmmxHyyPIU918N71rSlhWZhK
 2dQBkC4fvqyczNiRT2JVbDG0qIaH.JwSEkWlJGVY3SXLL_GXCX5fSQ2UUKML_SsO7OhNaobme4yV
 SXM2Go5MjVWegFNkYGxKLFHynfHKyqPipJV374POJZrJqRKSRmDWTuQDjNImLMAtwOACDSbcTgUO
 NKrUBgcNL4iFTZF7Xewf6BnGv8CHQV8ogvJoR7QH1Nx6inzup0wm_W1csjaApMbGuh1zLTbjLrjg
 a9_jX8QyuUzscvEmjEOoP8L96QAsGPZ7.zUcZ48Otdw3WLtwU54CkIyftGEfBphXy10G8tgqLaIA
 .d0S6IoCm8PQGOL6CDhPVEt4qu9_ggUq2RIRi3ZOoKnig5QNmD8fQ78VCVHcUpozdAVaIT9Wt7lU
 JHp5DnwHKSQZ3Ucq5daHxE4Z577e2FkOg6RoY14FyAvjTnucEmDRh_0O3wieicj9grn1.3Fwl5gW
 mvyhP2RGrHYrGVywHyRzKAyQFvYlsQqNk5yOc.vi91nvxPT_LFCngJvdF9g9FG_wB_rOBRREIYyJ
 dcpGqKrq6BJW1nJkfYOVNciPIhT5WAiKkiJqhFLyGOS3nTee3QRJHK_7crn__Oz9om8d4Qm7v07l
 WT62eGJ2ogSz7bM.GuwG6SI5P1rUQm_bptyjAkfrgyMYpIv_TiAgHJouZNnjjJIncqDZt7jj2_5G
 rc7glqdh7l66lEV4VP3K3VNxsZKko0Fn2R3wef6_7ymHJCmxF5HGtWiv2ESrpFIx0dkgW.ffX5qJ
 W1IP7ZZXzx1Sh4ObjRcb2tWMgqTs4hZpWJ4hj3BwokxflafBWUNL_t5tBaeoCg_DLeVpnl7J0yLX
 LA.3lKET7HF.dhGKdeY1JywZv6zWQbDPiZ.r3fS16M5KYl3Zwc4S_t.inBisCcOHVffI7Ar93rLQ
 e8v5jiJIQirFGtmxzQwTvCZ2mk8K6oTJEjDWL6eQyVnJ5PW.Xqtb5YxjRt4Uy7uYSah3oojDWQ7d
 0InDB0KI5EmGNepTr81fHfwwMSb7ZSCuTCl0mZnanI7HLK_OWTLtNs06ReGeMOaDhswqI__smvcX
 Az5RBYUOS8ePTJ9SFZo7qD9mA23z73YzIg_Qd3EV8IHsp0GZGWzhVRHcy0qP.CaUeTDY7j9rklQN
 J5adOsyVsV06VQoPpfsRVDzO116YmDfHkIUAFQtXZcyhOaUn62NR2txM69Tc0zhsiLBdzIUYldMZ
 EAOm_0MvF7QMn88_AGbba2lf33vTYqzK1_01eei2mAPo32QmRv0o167Xtp.RiIFdcoGqeTkGXuU7
 jo0.0A7a.bwNC8.1Tooymz1d74nnDItoH1YRPPLD0i80cY5IcWvGOic8H5dL0VrbndawKuGDxFaC
 1vlv2c8G0yk4KXbX2iqtPzpkJfOuvbOHsrA3CVMW7p_N8uytif_qTGV_8koQcQOTLG4UjtCGuN94
 qId8L8OpAP94jZVyLpiBC30U4kEuJ8wfmvSEl5wRdd46djAST4SYpsegCT4i59gSq2VP2HUxGmqH
 VD9lXzOid4Thqc8UxCE5gU_RktOK4FDLxL0OQHrRIQbLoMcfa7SDKNz6fZh.fW5FnVka99irIhFf
 8Vc02Qt6Burn2xNKhmDAOBagygLh2vdie.FKimlGUBV7dYHPy3tdTKXV7lnWN4oaeGegN.oTBH6Q
 zhacKO.TZQ2ATtMfwFrA3fOSDw486VImvj.hGuvXEmiV16DxndSBg0bJS5Qn_aUG4KHTaLn7ofNe
 j1vYUVBEH5SDfS7DPzoKE4hWfCIXJKJyA05P2ij8_m1pdVnVyiCv9Uo9TzTvVG_G8v9c9zkFiHH0
 foqDJbAy..7LQdJmy_A--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 31e90993-cd1f-4d60-8d98-cf92647c1ad9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Thu, 24 Jul 2025 04:40:27 +0000
Received: by hermes--production-ne1-9495dc4d7-vm8nz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79c8f99e40d0951275ebfec5ff32d5cd;
          Thu, 24 Jul 2025 04:30:15 +0000 (UTC)
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
	john.fastabend@gmail.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH 6.1] net: add netdev_lockdep_set_classes() to virtual drivers
Date: Wed, 23 Jul 2025 23:30:09 -0500
Message-ID: <20250724043010.129297-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250724043010.129297-1-sumanth.gavini.ref@yahoo.com>

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
 drivers/net/dummy.c            | 1 +
 drivers/net/geneve.c           | 2 ++
 drivers/net/loopback.c         | 2 ++
 drivers/net/veth.c             | 1 +
 drivers/net/vxlan/vxlan_core.c | 1 +
 net/ipv4/ip_tunnel.c           | 1 +
 net/ipv6/ip6_gre.c             | 2 ++
 net/ipv6/ip6_tunnel.c          | 1 +
 net/ipv6/ip6_vti.c             | 1 +
 net/ipv6/sit.c                 | 1 +
 10 files changed, 13 insertions(+)

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
index f393e454f45c..d2fbd1cd0ce3 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -335,6 +335,8 @@ static int geneve_init(struct net_device *dev)
 		gro_cells_destroy(&geneve->gro_cells);
 		return err;
 	}
+
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 2e9742952c4e..ab5264ddd765 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -144,6 +144,8 @@ static int loopback_dev_init(struct net_device *dev)
 	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
 	if (!dev->lstats)
 		return -ENOMEM;
+
+    netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 09682ea3354e..00ad39dc297e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1391,6 +1391,7 @@ static void veth_free_queues(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 
+	netdev_lockdep_set_classes(dev);
 	kfree(priv->rq);
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6ab669dcd1c6..a233ae4bf61f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2926,6 +2926,7 @@ static int vxlan_init(struct net_device *dev)
 		return err;
 	}
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 019f3b0839c5..20e35fdb373d 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1253,6 +1253,7 @@ int ip_tunnel_init(struct net_device *dev)
 
 	if (tunnel->collect_md)
 		netif_keep_dst(dev);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_init);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index c035a96fba3a..419e94e9bd62 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1530,6 +1530,7 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	ip6gre_tnl_init_features(dev);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
@@ -1922,6 +1923,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 2fb4c6ad7243..96030f29df9b 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1885,6 +1885,7 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 destroy_dst:
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 151337d7f67b..f6a2c55a4dcb 100644
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
index 5703d3cbea9b..c2bf8eb81a58 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1458,6 +1458,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
 		return err;
 	}
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
-- 
2.43.0


