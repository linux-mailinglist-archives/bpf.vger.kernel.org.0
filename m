Return-Path: <bpf+bounces-58458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA26ABADB1
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643023B74E0
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 03:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D31BD01D;
	Sun, 18 May 2025 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iOPiA8P8"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102710A1E;
	Sun, 18 May 2025 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747540077; cv=none; b=KJaigDb9lh4RLZmmFG4zW90EXncFNBXezKWgbAA7Y7HasaayIu+FH2zfqeCmm7IYAAwWtFN0URByVabh39HO5vawcfHeYVDPxQqgZ8BLC+zCTgRHYPx3D7qv7kDarJZnSy6C86Y+G4QEe/ODPsFdND1aAEW1kS4C0ISX9OOA4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747540077; c=relaxed/simple;
	bh=aXvJKxmzfESpaedYEM0k3r230KTw/3k6G8+3Tse+Lhs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=O1ssZn2gaWI3R4aF6UGbCjxyUZd8+vr41E2j+Bh5yG5IsXWpU4xnKmYmdGgYL1y42ZMVHzDkDMR7Dd+MKVYDGtNXRSMitOyPpQHal1MtoX0mqWA5Mo+W8NjpzzMGS8AQOzENHSNjf2AuWeYzu5w+MMi76GNm5jiS7vEtei4F4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iOPiA8P8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 84C0D20277FA; Sat, 17 May 2025 20:47:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84C0D20277FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747540075;
	bh=lPGYH1glaOFQwG0Qf4sdwd5qCLAWVCDmPlEySsWR4Kg=;
	h=From:To:Cc:Subject:Date:From;
	b=iOPiA8P85ZLuht2RkG9gqBfxGdBHeS1PaINFVYLt/5Q9Mms2x7auacqvvfbloAlVp
	 zDQEMZO8q6QXyfhuot5555zl1gP+ihmFJCM0iiHyFDC66yEW/8j+JZY2txvxVQoSSa
	 0o9OciEJMKsgntdUYDpMj+4fkOKPTlCMIFaCAE0c=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	kuniyu@amazon.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ssengar@microsoft.com,
	stable@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH net] hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()
Date: Sat, 17 May 2025 20:47:50 -0700
Message-Id: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The MANA driver's probe registers netdevice via the following call chain:

mana_probe()
  register_netdev()
    register_netdevice()

register_netdevice() calls notifier callback for netvsc driver,
holding the netdev mutex via netdev_lock_ops().

Further this netvsc notifier callback end up attempting to acquire the
same lock again in dev_xdp_propagate() leading to deadlock.

netvsc_netdev_event()
  netvsc_vf_setxdp()
    dev_xdp_propagate()

This deadlock was not observed so far because net_shaper_ops was never
set and this lock in noop in this case. Fix this by using
netif_xdp_propagate instead of dev_xdp_propagate to avoid recursive
locking in this path.

This issue has not observed so far because net_shaper_ops was unset,
making the lock path effectively a no-op. To prevent recursive locking
and avoid this deadlock, replace dev_xdp_propagate() with
netif_xdp_propagate(), which does not acquire the lock again.

Also, clean up the unregistration path by removing unnecessary call to
netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
performs this cleanup via dev_xdp_uninstall.

Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc_bpf.c | 2 +-
 drivers/net/hyperv/netvsc_drv.c | 2 --
 net/core/dev.c                  | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index e01c5997a551..1dd3755d9e6d 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 	xdp.command = XDP_SETUP_PROG;
 	xdp.prog = prog;
 
-	ret = dev_xdp_propagate(vf_netdev, &xdp);
+	ret = netif_xdp_propagate(vf_netdev, &xdp);
 
 	if (ret && prog)
 		bpf_prog_put(prog);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d8b169ac0343..ee3aaf9c10e6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2462,8 +2462,6 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF unregistering: %s\n", vf_netdev->name);
 
-	netvsc_vf_setxdp(vf_netdev, NULL);
-
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
 	netdev_upper_dev_unlink(vf_netdev, ndev);
diff --git a/net/core/dev.c b/net/core/dev.c
index fccf2167b235..8c6c9d7fba26 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9953,6 +9953,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
+EXPORT_SYMBOL_GPL(netif_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
-- 
2.43.0


