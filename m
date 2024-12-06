Return-Path: <bpf+bounces-46278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B461E9E7482
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8E7166B05
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C814C20E037;
	Fri,  6 Dec 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Gev/swZd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10320E003;
	Fri,  6 Dec 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499283; cv=none; b=FgksSSOaJV+wbmh7EF0DplVCfbpHgTg8m3BICWJQak5sC7kAJslV/ntwvhd1gpDbC+fsO1ML2aQeQ4yAa5sNbH1knhldI5AMAhxU+oaysSLs5C7gD0flqVGB6HN7B8TE6YCD+qP8K2pLCBxj5wJ5L92GhUPe7Uju8Zc4tL5FBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499283; c=relaxed/simple;
	bh=bmPoN0dz5Erv+oTPTYgXxJqjTEvypkK40KNFeBvHyg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CK3/vTC2X2slxCP8e3utMCWtpF2UKU5D8GXEyshiA5rwUo7G1IztZ7COI44TZKy9wSAzsf4qXsyd8cDTYm2vagDmwza1TFysbrXgDcTtVyWNdn8QTGJKioa6avbV3B0pA/s30evsNNAOEFa+FCOyqlYTyRPDS+zJ+E3Q61PanUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Gev/swZd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=jJUCC0+zAfm/qgdYfQUvLg3e720QEXlqqaYJAFyzHLE=; b=Gev/swZdu/HBwPXh5jeWxwy8T8
	WbNtuah/1OnbbvcV9RgSMhch7KxfTDfuql51lq9CVw2QtmQSSBb0GFZ3fJuNl4zCVuGNRsXxJ+AMg
	8eNNYCh53UAi+YC3Vk3QSDjTq8O6PkyfP635AcAaaZoAQAANEwyWxl4iBTafM9AnGsmGasY43fBBQ
	KUW0CDaJfFk1Jf6jhe5yvVOoI3t/jlUjBli1FzysbqXvvU5hyd8bnC855WsI/rEU9bHmzdfzyxruy
	BFEFlyHW6AlRu/UoV0ito1Ut+rLUucAVjfbZCuXpbwO6VOQ33XqmGml9l3fVYnzGHUbXE+gTfM9mM
	+ToDvi0Q==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tJaLS-000EQw-3H; Fri, 06 Dec 2024 16:34:18 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	leitao@debian.org,
	martin.lau@linux.dev,
	peilin.ye@bytedance.com,
	kuba@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.1 1/3] net: Move {l,t,d}stats allocation to core and convert veth & vrf
Date: Fri,  6 Dec 2024 16:34:01 +0100
Message-ID: <20241206153403.273068-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27479/Fri Dec  6 10:40:14 2024)

[ Upstream commit 34d21de99cea9cb17967874313e5b0262527833c ]
[ Note: Simplified vrf bits to reduce patch given unrelated to the fix ]

Move {l,t,d}stats allocation to the core and let netdevs pick the stats
type they need. That way the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc) - all happening in the core.

Co-developed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20231114004220.6495-3-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: 024ee930cb3c ("bpf: Fix dev's rx stats for bpf_redirect_peer traffic")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/veth.c        | 16 ++----------
 drivers/net/vrf.c         | 24 ++++++------------
 include/linux/netdevice.h | 30 +++++++++++++++++++---
 net/core/dev.c            | 53 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 38 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 8dcd3b6e143b..0a8154611d7f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1381,25 +1381,12 @@ static void veth_free_queues(struct net_device *dev)
 
 static int veth_dev_init(struct net_device *dev)
 {
-	int err;
-
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
-
-	err = veth_alloc_queues(dev);
-	if (err) {
-		free_percpu(dev->lstats);
-		return err;
-	}
-
-	return 0;
+	return veth_alloc_queues(dev);
 }
 
 static void veth_dev_free(struct net_device *dev)
 {
 	veth_free_queues(dev);
-	free_percpu(dev->lstats);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -1625,6 +1612,7 @@ static void veth_setup(struct net_device *dev)
 			       NETIF_F_HW_VLAN_STAG_RX);
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 208df4d41939..c8a1009d659e 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -121,22 +121,12 @@ struct net_vrf {
 	int			ifindex;
 };
 
-struct pcpu_dstats {
-	u64			tx_pkts;
-	u64			tx_bytes;
-	u64			tx_drps;
-	u64			rx_pkts;
-	u64			rx_bytes;
-	u64			rx_drps;
-	struct u64_stats_sync	syncp;
-};
-
 static void vrf_rx_stats(struct net_device *dev, int len)
 {
 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 	u64_stats_update_begin(&dstats->syncp);
-	dstats->rx_pkts++;
+	dstats->rx_packets++;
 	dstats->rx_bytes += len;
 	u64_stats_update_end(&dstats->syncp);
 }
@@ -161,10 +151,10 @@ static void vrf_get_stats64(struct net_device *dev,
 		do {
 			start = u64_stats_fetch_begin_irq(&dstats->syncp);
 			tbytes = dstats->tx_bytes;
-			tpkts = dstats->tx_pkts;
-			tdrops = dstats->tx_drps;
+			tpkts = dstats->tx_packets;
+			tdrops = dstats->tx_drops;
 			rbytes = dstats->rx_bytes;
-			rpkts = dstats->rx_pkts;
+			rpkts = dstats->rx_packets;
 		} while (u64_stats_fetch_retry_irq(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
@@ -421,7 +411,7 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
 		vrf_rx_stats(dev, len);
 	else
-		this_cpu_inc(dev->dstats->rx_drps);
+		this_cpu_inc(dev->dstats->rx_drops);
 
 	return NETDEV_TX_OK;
 }
@@ -616,11 +606,11 @@ static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 		u64_stats_update_begin(&dstats->syncp);
-		dstats->tx_pkts++;
+		dstats->tx_packets++;
 		dstats->tx_bytes += len;
 		u64_stats_update_end(&dstats->syncp);
 	} else {
-		this_cpu_inc(dev->dstats->tx_drps);
+		this_cpu_inc(dev->dstats->tx_drops);
 	}
 
 	return ret;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fbbd0df1106b..662183994e88 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1747,6 +1747,13 @@ enum netdev_ml_priv_type {
 	ML_PRIV_CAN,
 };
 
+enum netdev_stat_type {
+	NETDEV_PCPU_STAT_NONE,
+	NETDEV_PCPU_STAT_LSTATS, /* struct pcpu_lstats */
+	NETDEV_PCPU_STAT_TSTATS, /* struct pcpu_sw_netstats */
+	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -1941,10 +1948,14 @@ enum netdev_ml_priv_type {
  *
  * 	@ml_priv:	Mid-layer private
  *	@ml_priv_type:  Mid-layer private type
- * 	@lstats:	Loopback statistics
- * 	@tstats:	Tunnel statistics
- * 	@dstats:	Dummy statistics
- * 	@vstats:	Virtual ethernet statistics
+ *
+ *	@pcpu_stat_type:	Type of device statistics which the core should
+ *				allocate/free: none, lstats, tstats, dstats. none
+ *				means the driver is handling statistics allocation/
+ *				freeing internally.
+ *	@lstats:		Loopback statistics: packets, bytes
+ *	@tstats:		Tunnel statistics: RX/TX packets, RX/TX bytes
+ *	@dstats:		Dummy statistics: RX/TX/drop packets, RX/TX bytes
  *
  *	@garp_port:	GARP
  *	@mrp_port:	MRP
@@ -2287,6 +2298,7 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
+	enum netdev_stat_type		pcpu_stat_type:8;
 	union {
 		struct pcpu_lstats __percpu		*lstats;
 		struct pcpu_sw_netstats __percpu	*tstats;
@@ -2670,6 +2682,16 @@ struct pcpu_sw_netstats {
 	struct u64_stats_sync   syncp;
 } __aligned(4 * sizeof(u64));
 
+struct pcpu_dstats {
+	u64			rx_packets;
+	u64			rx_bytes;
+	u64			rx_drops;
+	u64			tx_packets;
+	u64			tx_bytes;
+	u64			tx_drops;
+	struct u64_stats_sync	syncp;
+} __aligned(8 * sizeof(u64));
+
 struct pcpu_lstats {
 	u64_stats_t packets;
 	u64_stats_t bytes;
diff --git a/net/core/dev.c b/net/core/dev.c
index 42c16b3e86b9..5151f69dd724 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9991,6 +9991,46 @@ void netif_tx_stop_all_queues(struct net_device *dev)
 }
 EXPORT_SYMBOL(netif_tx_stop_all_queues);
 
+static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
+{
+	void __percpu *v;
+
+	switch (dev->pcpu_stat_type) {
+	case NETDEV_PCPU_STAT_NONE:
+		return 0;
+	case NETDEV_PCPU_STAT_LSTATS:
+		v = dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
+		break;
+	case NETDEV_PCPU_STAT_TSTATS:
+		v = dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+		break;
+	case NETDEV_PCPU_STAT_DSTATS:
+		v = dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return v ? 0 : -ENOMEM;
+}
+
+static void netdev_do_free_pcpu_stats(struct net_device *dev)
+{
+	switch (dev->pcpu_stat_type) {
+	case NETDEV_PCPU_STAT_NONE:
+		return;
+	case NETDEV_PCPU_STAT_LSTATS:
+		free_percpu(dev->lstats);
+		break;
+	case NETDEV_PCPU_STAT_TSTATS:
+		free_percpu(dev->tstats);
+		break;
+	case NETDEV_PCPU_STAT_DSTATS:
+		free_percpu(dev->dstats);
+		break;
+	}
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10051,11 +10091,15 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	ret = netdev_do_alloc_pcpu_stats(dev);
+	if (ret)
+		goto err_uninit;
+
 	ret = -EBUSY;
 	if (!dev->ifindex)
 		dev->ifindex = dev_new_index(net);
 	else if (__dev_get_by_index(net, dev->ifindex))
-		goto err_uninit;
+		goto err_free_pcpu;
 
 	/* Transfer changeable features to wanted_features and enable
 	 * software offloads (GSO and GRO).
@@ -10102,14 +10146,14 @@ int register_netdevice(struct net_device *dev)
 	ret = call_netdevice_notifiers(NETDEV_POST_INIT, dev);
 	ret = notifier_to_errno(ret);
 	if (ret)
-		goto err_uninit;
+		goto err_free_pcpu;
 
 	ret = netdev_register_kobject(dev);
 	write_lock(&dev_base_lock);
 	dev->reg_state = ret ? NETREG_UNREGISTERED : NETREG_REGISTERED;
 	write_unlock(&dev_base_lock);
 	if (ret)
-		goto err_uninit;
+		goto err_free_pcpu;
 
 	__netdev_update_features(dev);
 
@@ -10156,6 +10200,8 @@ int register_netdevice(struct net_device *dev)
 out:
 	return ret;
 
+err_free_pcpu:
+	netdev_do_free_pcpu_stats(dev);
 err_uninit:
 	if (dev->netdev_ops->ndo_uninit)
 		dev->netdev_ops->ndo_uninit(dev);
@@ -10409,6 +10455,7 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
 		if (dev->needs_free_netdev)
-- 
2.43.0


