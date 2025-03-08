Return-Path: <bpf+bounces-53654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5523A57E2E
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 21:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F4188DA9D
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 20:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D120B81E;
	Sat,  8 Mar 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lN23Cr83"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CD1EB5C4;
	Sat,  8 Mar 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741466353; cv=none; b=c2+7Nlr3D24ZurU1fnD+442SyOLn7ucMCiZ+NI6KJSUegpoWNBGmBWH4QfArglMIa9tu5ZaDXTyE/v0SnPODmdEYUHejk96l1HS/+RhBuS8C0BvkXM+hJ2rZHRNFpZQo9AlYVjIX6KZflaIiOFrcOeDgWM5C8FXulG7o1YtBlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741466353; c=relaxed/simple;
	bh=0PR9nF+vt0o4MGnSXXDSr7z94UtxEtNKsN15XkrL1ww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELyNhX0nxFM42t+3WOGFoPqDHQWdHiBvR2r89w0wa67tOtSwaJJntxYbvTKgZlyhkQ4VT+EG+yHtfDR2R7SyXMQ/grcbJ/cpPbxtTDjMRoVtzaienZ2UIwiLaS5cHeQLFB5j2mGin51i6HhzNAwAt8g6LFLcwgZOmJ9fR3YWvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lN23Cr83; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741466351; x=1773002351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d7gx36eQiaK7vs+XYLXAASNt7tVtWp28JZgcwLTeK3E=;
  b=lN23Cr83cB4LUloopY7jRT/RRqGLjSiZBsYXpx5pNsLjBuBRn3wnOIo+
   kInFWxtHSQqAVt/IHNcdLmAFDdGgcb3IgJ37IUPxLJJeTqhnU/XBRiT8u
   QWXhExN7oYK4fcRNjqRjAwOU+iap3/21pw/0E4LHe8VEgRCnoXAyvCfFe
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,233,1736812800"; 
   d="scan'208";a="179967314"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 20:39:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:15916]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id 78b1b71d-e0c3-4858-a357-e82b4ff84096; Sat, 8 Mar 2025 20:39:09 +0000 (UTC)
X-Farcaster-Flow-ID: 78b1b71d-e0c3-4858-a357-e82b4ff84096
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 8 Mar 2025 20:39:09 +0000
Received: from b0be8375a521.amazon.com (10.119.7.10) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 8 Mar 2025 20:39:04 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Ahmed Zaki" <ahmed.zaki@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"Alexander Lobakin" <aleksander.lobakin@intel.com>, Kohei Enju
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH net-next v1] dev: remove netdev_lock() and netdev_lock_ops() in register_netdevice().
Date: Sun, 9 Mar 2025 05:37:18 +0900
Message-ID: <20250308203835.60633-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

ieee80211_register_hw() takes the wiphy lock, and then
register_netdevice() calls netdev_lock(), since commit 5fda3f35349b ("net:
make netdev_lock() protect netdev->reg_state").
On the other hand, do_setlink() calls netdev_lock() and then
ieee80211_change_mac() takes the wiphy lock, after commit df43d8bf1031
("net: replace dev_addr_sem with netdev instance lock").
This causes the circular locking dependency.

Like netdev_lock(), netdev_lock_ops() introduced in commit 97246d6d21c2
("net: hold netdev instance lock during ndo_bpf") would also cause the
same type of issue.

Both netdev_lock() and netdev_lock_ops() are called before
list_netdevice() in register_netdevice().
No other context can access the struct net_device, so we don't need these
locks in this context.
Remove them.

WARNING: possible circular locking dependency detected
6.14.0-rc5-next-20250307 #44 Not tainted

NetworkManager/8289 is trying to acquire lock:
ffff88810fb30768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_change_mac+0x110/0x1450

but task is already holding lock:
ffff88810fb48d30 (&dev->lock){+.+.}-{4:4}, at: do_setlink.isra.0+0x326c/0x3f40

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&dev->lock){+.+.}-{4:4}:
       lock_acquire+0x1b2/0x550
       __mutex_lock+0x1a2/0x14b0
       register_netdevice+0x12dc/0x2000
       cfg80211_register_netdevice+0x149/0x330
       ieee80211_if_add+0xcfe/0x1880
       ieee80211_register_hw+0x3655/0x3f60
       mac80211_hwsim_new_radio+0x2760/0x53a0
       init_mac80211_hwsim+0x6c6/0x7d0
       do_one_initcall+0x11a/0x6d0
       kernel_init_freeable+0x6dd/0x770
       kernel_init+0x1f/0x1e0
       ret_from_fork+0x45/0x80
       ret_from_fork_asm+0x1a/0x30

-> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       check_prev_add+0x1af/0x23e0
       __lock_acquire+0x2d55/0x49a0
       lock_acquire+0x1b2/0x550
       __mutex_lock+0x1a2/0x14b0
       ieee80211_change_mac+0x110/0x1450
       netif_set_mac_address+0x30a/0x4a0
       do_setlink.isra.0+0x77a/0x3f40
       rtnl_newlink+0x11ef/0x2370
       rtnetlink_rcv_msg+0x95b/0xe90
       netlink_rcv_skb+0x16b/0x440
       netlink_unicast+0x532/0x7f0
       netlink_sendmsg+0x8ca/0xda0
       ____sys_sendmsg+0x9cf/0xb60
       ___sys_sendmsg+0x11a/0x1a0
       __sys_sendmsg+0x136/0x1e0
       do_syscall_64+0x74/0x190
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dev->lock);
                               lock(&rdev->wiphy.mtx);
                               lock(&dev->lock);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

Fixes: df43d8bf1031 ("net: replace dev_addr_sem with netdev instance lock")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c4cc33f73629..df9661961558 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11003,17 +11003,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_ifindex_release;
 
 	ret = netdev_register_kobject(dev);
-
-	netdev_lock(dev);
 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
-	netdev_unlock(dev);
-
 	if (ret)
 		goto err_uninit_notify;
 
-	netdev_lock_ops(dev);
 	__netdev_update_features(dev);
-	netdev_unlock_ops(dev);
 
 	/*
 	 *	Default initial state at registry is that the
-- 
2.48.1


