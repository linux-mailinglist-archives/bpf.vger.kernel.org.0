Return-Path: <bpf+bounces-68993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F37B8B686
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E583B16FCCD
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E182D322C;
	Fri, 19 Sep 2025 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bHI4P52c"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD735942;
	Fri, 19 Sep 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318690; cv=none; b=n5oSzVWrinQKDk46YLz8yQTNaNfddB4+ONRZKl6NxvSGBUbzG5JH0+Pc1tq1J5M8iGCUyJRLTwuxI3j0pBzQmPvbX+TGFw8riBTu4kqtnend5+4XD9uz/TQocK8d8guXzDDUZ97cbp9Qbxv4EHqqT24VxGTy6HzzNbgYb9L0Lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318690; c=relaxed/simple;
	bh=0uKirxg26BcUoPBUL/8aOY8x4VEtiYjNWmw/yJl0MW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXwA/TJHFRGEerZ6acFaekKBTp0QBPUs2DXgIpg/KPCPQTiTrnUTcllfoVMidkBU3M/DfG8rURd/y8cBwrPZD73t54IUEzSrznPPeV0+YF4Uz532LNVyIALzOdrOlFOuFo6+SbOH0K4uaChVZWbbknK2l/yY6pY3+nMBi1MsusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bHI4P52c; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=j8Qiebc8TTpIEfUEVRjLq8mJZUMH7i9lOqYU0inlXZ8=; b=bHI4P52c8xo9CsvdJ1ZhPUk0rZ
	DAdL4VfTy9DgWAnxfYKXJeqGhLwjBqaidtWHzILknR0Xq73dNrIxIA+sUiYVMJIljx5cAsWBY99x7
	02DmcrPtdtfL7q8tzWr2PGRpDwJV2M1/hbuYz5xYXQuyAhCSe6nBoXxOBW2Cas2XCttW6J6bOxfZq
	O/p0RpVItU1Q1GByHUZOXWP1eew+EYN6h9ZG3qZvUCm+MrGgImz+CBi086W2xE+d4jBqchQpD/gQ7
	i7V1imRSF/Ta1B3R+pNJ2Uhac+LMFi2nYWvpBLn6FJTkJxEBZ6kCBmFE8spMtfG/AW7/F9XA30fLR
	x6JFhGOw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uziiC-000NtQ-2B;
	Fri, 19 Sep 2025 23:32:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 19/20] netkit: Add xsk support for af_xdp applications
Date: Fri, 19 Sep 2025 23:31:52 +0200
Message-ID: <20250919213153.103606-20-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

Enable support for AF_XDP applications to operate on a netkit device.
The goal is that AF_XDP applications can natively consume AF_XDP
from network namespaces. The use-case from Cilium side is to support
Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
virtual machine management add-on for Kubernetes which aims to provide
a common ground for virtualization. KubeVirt spawns the VMs inside
Kubernetes Pods which reside in their own network namespace just like
regular Pods.

Raw QEMU AF_XDP backend example with eth0 being a physical device with
16 queues where netkit is bound to the last queue (for multi-queue RSS
context can be used if supported by the driver):

  # ethtool -X eth0 start 0 equal 15
  # ethtool -X eth0 start 15 equal 1 context new
  # ethtool --config-ntuple eth0 flow-type ether \
            src 00:00:00:00:00:00 \
            src-mask ff:ff:ff:ff:ff:ff \
            dst $mac dst-mask 00:00:00:00:00:00 \
            proto 0 proto-mask 0xffff action 15
  # ip netns add foo
  # ip link add numrxqueues 2 nk type netkit single
  # ynl-bind eth0 15 nk
  # ip link set nk netns foo
  # ip netns exec foo ip link set lo up
  # ip netns exec foo ip link set nk up
  # ip netns exec foo qemu-system-x86_64 \
          -kernel $kernel \
          -drive file=${image_name},index=0,media=disk,format=raw \
          -append "root=/dev/sda rw console=ttyS0" \
          -cpu host \
          -m $memory \
          -enable-kvm \
          -device virtio-net-pci,netdev=net0,mac=$mac \
          -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
          -nographic

We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
100G NIC with successful network connectivity out of QEMU. An earlier
iteration of this work was presented at LSF/MM/BPF [0].

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
---
 drivers/net/netkit.c | 121 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5129b27a7c3c..a1d8a78bab0b 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -11,6 +11,7 @@
 
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
 #include <net/netkit.h>
 #include <net/dst.h>
 #include <net/tcx.h>
@@ -234,6 +235,122 @@ static void netkit_get_stats(struct net_device *dev,
 	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
 }
 
+static int netkit_xsk(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct netkit *nk = netkit_priv(dev);
+	struct netdev_bpf xdp_lower;
+	struct netdev_rx_queue *rxq;
+	struct net_device *phys;
+
+	switch (xdp->command) {
+	case XDP_SETUP_XSK_POOL:
+		if (nk->pair == NETKIT_DEVICE_PAIR)
+			return -EOPNOTSUPP;
+		if (xdp->xsk.queue_id >= dev->real_num_rx_queues)
+			return -EINVAL;
+
+		rxq = __netif_get_rx_queue(dev, xdp->xsk.queue_id);
+		if (!rxq->peer)
+			return -EOPNOTSUPP;
+
+		phys = rxq->peer->dev;
+		if (!phys->netdev_ops->ndo_bpf ||
+		    !phys->netdev_ops->ndo_xdp_xmit ||
+		    !phys->netdev_ops->ndo_xsk_wakeup)
+			return -EOPNOTSUPP;
+
+		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
+		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->peer);
+		break;
+	case XDP_SETUP_PROG:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+
+	return phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
+}
+
+static int netkit_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
+{
+	struct netdev_rx_queue *rxq;
+	struct net_device *phys;
+
+	if (queue_id >= dev->real_num_rx_queues)
+		return -EINVAL;
+
+	rxq = __netif_get_rx_queue(dev, queue_id);
+	if (!rxq->peer)
+		return -EOPNOTSUPP;
+
+	phys = rxq->peer->dev;
+	if (!phys->netdev_ops->ndo_xsk_wakeup)
+		return -EOPNOTSUPP;
+
+	return phys->netdev_ops->ndo_xsk_wakeup(phys,
+			get_netdev_rx_queue_index(rxq->peer), flags);
+}
+
+static bool netkit_xdp_supported(const struct net_device *dev)
+{
+	bool xdp_ok = IS_ENABLED(CONFIG_XDP_SOCKETS);
+
+	if (!dev->netdev_ops->ndo_bpf ||
+	    !dev->netdev_ops->ndo_xdp_xmit ||
+	    !dev->netdev_ops->ndo_xsk_wakeup)
+		xdp_ok = false;
+	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK)
+		xdp_ok = false;
+	return xdp_ok;
+}
+
+static void netkit_expose_xdp(struct net_device *dev, bool xdp_ok,
+			      u32 xdp_zc_max_segs)
+{
+	if (xdp_ok) {
+		dev->xdp_zc_max_segs = xdp_zc_max_segs;
+		xdp_set_features_flag_locked(dev, NETDEV_XDP_ACT_XSK);
+	} else {
+		dev->xdp_zc_max_segs = 1;
+		xdp_set_features_flag_locked(dev, 0);
+	}
+}
+
+static void netkit_calculate_xdp(struct net_device *dev,
+				 struct netdev_rx_queue *rxq, bool skip_rxq)
+{
+	struct netdev_rx_queue *src_rxq, *dst_rxq;
+	struct net_device *src_dev;
+	u32 xdp_zc_max_segs = ~0;
+	bool xdp_ok = false;
+	int i;
+
+	for (i = 1; i < dev->real_num_rx_queues; i++) {
+		dst_rxq = __netif_get_rx_queue(dev, i);
+		if (dst_rxq == rxq && skip_rxq)
+			continue;
+		src_rxq = dst_rxq->peer;
+		src_dev = src_rxq->dev;
+		xdp_zc_max_segs = min(xdp_zc_max_segs, src_dev->xdp_zc_max_segs);
+		xdp_ok = netkit_xdp_supported(src_dev) &&
+			 (i == 1 ? true : xdp_ok);
+	}
+
+	netkit_expose_xdp(dev, xdp_ok, xdp_zc_max_segs);
+}
+
+static void netkit_peer_queues(struct net_device *dev,
+			       struct netdev_rx_queue *rxq)
+{
+	netkit_calculate_xdp(dev, rxq, false);
+}
+
+static void netkit_unpeer_queues(struct net_device *dev,
+				 struct netdev_rx_queue *rxq)
+{
+	netkit_calculate_xdp(dev, rxq, true);
+}
+
 static void netkit_uninit(struct net_device *dev);
 
 static const struct net_device_ops netkit_netdev_ops = {
@@ -247,6 +364,10 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
 	.ndo_uninit		= netkit_uninit,
+	.ndo_peer_queues	= netkit_peer_queues,
+	.ndo_unpeer_queues	= netkit_unpeer_queues,
+	.ndo_bpf		= netkit_xsk,
+	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 };
 
-- 
2.43.0


