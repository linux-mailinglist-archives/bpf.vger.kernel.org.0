Return-Path: <bpf+bounces-78401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52DD0C4FF
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E724305FE1D
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7233D50C;
	Fri,  9 Jan 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g5qt+2Gq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF433DED6;
	Fri,  9 Jan 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994046; cv=none; b=c9YdUkXIpR2QNM4tL+OFPajEO1ncPML1aObwL3MWzk7HurVOmsM9g5uqvQ8Gqf7c+bQe3P6kZ8zjhVQ8AbAAIBT826U5DYliM7Uh26wPmE8E35YorZo942SEAEgS2uI+uerKJJjKNiOgDtDrNToFgzxN8dD2HEfP33pIviuu7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994046; c=relaxed/simple;
	bh=sVIyyQnFb6R7yWAF9dKDKtZTuHMC9VOrTi3yld4G+e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFIkpxlkYjUj+P9Xwj3a/M9o7vEHJ/FuQBt9QD6uXaB52Z2Akk127IjkBhdmCwuVIC+NZWOdqPQ38W8Kb0+0F9nr4bds3VYisVwFggGTKyI55xkYk4Kxu95/RQWoOikpUzlDaS2gDmSzvNCexW/vVuxuntqzvBzVbm+2d5PMs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g5qt+2Gq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=m2v/GrEXUQjI4eFgz8+yzWcdtLjxu3uFM03T9uOBHAc=; b=g5qt+2Gq/y8WkCmk4yHQ+8aj13
	B0Eq0+et6jdkVh99FzRziqIgiHKJgeFhlc2sxImsxwg1UJXnaUlBU1UrcuvgS0QOPnEVdbdt6rQNv
	tkVQL5ML3TLukhCK6378Db4+zlYeH6XXpht7Y/pXFzQCK+IYFWvksjmiFJeytR+wxg2Ls1vMM9bL8
	EPCtEpNgubOoOaOz8X+Rc7Ys8e7kc18ORiUUrKJuOOM7U4iXtlzOH2yx88TkM9N3ODCZ6YwlLnWGN
	zQSBWdgF07JeQHHjq/gESqQd3BJ8YbU4s1ou5ot7dZ5T58eu8OdPaLWMnZjRRHDBsNNN31HyOnGIn
	ckyNtIVw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0N-00054s-2F;
	Fri, 09 Jan 2026 22:26:47 +0100
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
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v5 12/16] netkit: Add xsk support for af_xdp applications
Date: Fri,  9 Jan 2026 22:26:28 +0100
Message-ID: <20260109212632.146920-13-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109212632.146920-1-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27875/Fri Jan  9 08:26:02 2026)

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
  [ ... setup BPF/XDP prog on eth0 to steer into shared xsk map ... ]
  # ip netns add foo
  # ip link add numrxqueues 2 nk type netkit single
  # ./pyynl/cli.py --spec ~/netlink/specs/netdev.yaml \
                   --do queue-create \
                   --json "{"ifindex": $(ifindex nk), "type": "rx", \
                            "lease": { "ifindex": $(ifindex eth0), \
                                       "queue": { "type": "rx", "id": 15 } } }"
  {'id': 1}
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
iteration of this work was presented at LSF/MM/BPF [0] and more
recently at LPC [1].

For getting to a first starting point to connect all things with
KubeVirt, bind mounting the xsk map from Cilium into the VM launcher
Pod which acts as a regular Kubernetes Pod while not perfect, is not
a big problem given its out of reach from the application sitting
inside the VM (and some of the control plane aspects are baked in
the launcher Pod already), so the isolation barrier is still the VM.
Eventually the goal is to have a XDP/XSK redirect extension where
there is no need to have the xsk map, and the BPF program can just
derive the target xsk through the queue where traffic was received
on.

The exposure through netkit is because Cilium should not act as a
proxy handing out xsk sockets. Existing applications expect a netdev
from kernel side and should not need to rewrite just to implement
against a CNI's protocol. Also, all the memory should not be accounted
against Cilium but rather the application Pod itself which is consuming
AF_XDP. Further, on up/downgrades we expect the data plane to being
completely decoupled from the control plane; if Cilium would own the
sockets that would be disruptive. Another use-case which opens up and
is regularly asked from users would be to have DPDK applications on
top of AF_XDP in regular Kubernetes Pods.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
Link: https://lpc.events/event/19/contributions/2275/ [1]
---
 drivers/net/netkit.c | 76 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index d4426c30e0fd..2eac57362d3c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -12,6 +12,7 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
 #include <net/netkit.h>
 #include <net/dst.h>
 #include <net/tcx.h>
@@ -235,6 +236,76 @@ static void netkit_get_stats(struct net_device *dev,
 	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
 }
 
+static bool netkit_xsk_supported_at_phys(const struct net_device *dev)
+{
+	if (!dev->netdev_ops->ndo_bpf ||
+	    !dev->netdev_ops->ndo_xdp_xmit ||
+	    !dev->netdev_ops->ndo_xsk_wakeup)
+		return false;
+	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK)
+		return false;
+	return true;
+}
+
+static int netkit_xsk(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct netkit *nk = netkit_priv(dev);
+	struct netdev_bpf xdp_lower;
+	struct netdev_rx_queue *rxq;
+	struct net_device *phys;
+	int ret = -EBUSY;
+
+	switch (xdp->command) {
+	case XDP_SETUP_XSK_POOL:
+		if (nk->pair == NETKIT_DEVICE_PAIR)
+			return -EOPNOTSUPP;
+		if (xdp->xsk.queue_id >= dev->real_num_rx_queues)
+			return -EINVAL;
+
+		rxq = __netif_get_rx_queue(dev, xdp->xsk.queue_id);
+		if (!rxq->lease)
+			return -EOPNOTSUPP;
+
+		phys = rxq->lease->dev;
+		if (!netkit_xsk_supported_at_phys(phys))
+			return -EOPNOTSUPP;
+
+		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
+		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->lease);
+		break;
+	case XDP_SETUP_PROG:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+
+	netdev_lock(phys);
+	if (!dev_get_min_mp_channel_count(phys))
+		ret = phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
+	netdev_unlock(phys);
+	return ret;
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
+	if (!rxq->lease)
+		return -EOPNOTSUPP;
+
+	phys = rxq->lease->dev;
+	if (!netkit_xsk_supported_at_phys(phys))
+		return -EOPNOTSUPP;
+
+	return phys->netdev_ops->ndo_xsk_wakeup(phys,
+			get_netdev_rx_queue_index(rxq->lease), flags);
+}
+
 static int netkit_init(struct net_device *dev)
 {
 	netdev_lockdep_set_classes(dev);
@@ -255,6 +326,8 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
 	.ndo_uninit		= netkit_uninit,
+	.ndo_bpf		= netkit_xsk,
+	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 };
 
@@ -381,10 +454,11 @@ static void netkit_setup(struct net_device *dev)
 	dev->hw_enc_features = netkit_features;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
 	dev->vlan_features = dev->features & ~netkit_features_hw_vlan;
-
 	dev->needs_free_netdev = true;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
+	xdp_set_features_flag(dev, NETDEV_XDP_ACT_XSK);
 }
 
 static struct net *netkit_get_link_net(const struct net_device *dev)
-- 
2.43.0


