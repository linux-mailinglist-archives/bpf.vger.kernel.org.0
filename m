Return-Path: <bpf+bounces-59281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5666AC7BAD
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E494A3E33
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 10:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA07A22068A;
	Thu, 29 May 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GBcKC/4A"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5301F1527;
	Thu, 29 May 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513915; cv=none; b=sLMSstEwDQdCYIKLRKyYZ1A8joLkpA73uKEe7TAkX3K63ukgO47g6im9DkAIP5Dyxi73HfK8qdZwnVD0nFNQWmV2CK1T8MSa843/Txjbrdv5UBRyRssvu49DUnzMjJaW2QvuwwU1zKqUew7KLV9sX5eDSA63v1hu/SlXixEenlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513915; c=relaxed/simple;
	bh=5i/hDAQBSkwYVpOy1/ZC5ugPq70Hq06cHWW43vLth00=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UHjHod6qxaQOXN5ze9mT3KrVzCDxmz/gIdC4xl8q1tfCMhH7Zu9uvEO50WWSS3uSYUywBULld6hfH9kzA3saE7+GCOLaUaWq2hV8JzI2RTIOeEsiNyfyLg/rE5GpIHRV9AkRvnBh0OsXYXUJFnJjS+1RM45JVO/RP5FOevMrK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GBcKC/4A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2D5F5203EE15; Thu, 29 May 2025 03:18:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D5F5203EE15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748513913;
	bh=3O+r7rjK0Z7UCd5rC/P3E0rsfGqbO+aPvR8Qk26+QUU=;
	h=From:To:Cc:Subject:Date:From;
	b=GBcKC/4AzpGsK248NlSiWI82KViX/AHEk9rigBc6HF17A3Q59wNP1ftlJb6RkegXr
	 n5YUu8SzNBuSBpIt4GxR5JwrzOlscEvU0Z3WbR1rTpeI9vmPQvD+1n5J5O3ujcnjxl
	 VScqEuM3b7tiTTm4VjykXBgs2Lm0R93H9en+I+zc=
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
Subject: [PATCH net,v3] hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()
Date: Thu, 29 May 2025 03:18:30 -0700
Message-Id: <1748513910-23963-1-git-send-email-ssengar@linux.microsoft.com>
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

This deadlock was not observed so far because net_shaper_ops was never set,
and thus the lock was effectively a no-op in this case. Fix this by using
netif_xdp_propagate() instead of dev_xdp_propagate() to avoid recursive
locking in this path.

And, since no deadlock is observed on the other path which is via
netvsc_probe, add the lock exclusivly for that path.

Also, clean up the unregistration path by removing the unnecessary call to
netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
performs this cleanup via dev_xdp_uninstall().

Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
[V3]
- Add the lock for netvsc probe path

[V2]
 - Modified commit message

 drivers/net/hyperv/netvsc_bpf.c | 2 +-
 drivers/net/hyperv/netvsc_drv.c | 4 ++--
 net/core/dev.c                  | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

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
index 14a0d04e21ae..c41a025c66f0 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2462,8 +2462,6 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF unregistering: %s\n", vf_netdev->name);
 
-	netvsc_vf_setxdp(vf_netdev, NULL);
-
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
 	netdev_upper_dev_unlink(vf_netdev, ndev);
@@ -2631,7 +2629,9 @@ static int netvsc_probe(struct hv_device *dev,
 			continue;
 
 		netvsc_prepare_bonding(vf_netdev);
+		netdev_lock_ops(vf_netdev);
 		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
+		netdev_unlock_ops(vf_netdev);
 		__netvsc_vf_setup(net, vf_netdev);
 		break;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 2b514d95c528..a388f459a366 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9968,6 +9968,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
+EXPORT_SYMBOL_GPL(netif_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
-- 
2.43.0


