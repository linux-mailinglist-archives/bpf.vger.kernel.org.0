Return-Path: <bpf+bounces-14951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C47E929D
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 21:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095E7B20A15
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F761A284;
	Sun, 12 Nov 2023 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nmhnuGk9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42C1A599;
	Sun, 12 Nov 2023 20:30:39 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EF8211F;
	Sun, 12 Nov 2023 12:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=O5+uyaKqcScDSoHc0zSzzd9FyPjz6rmLlrExyTLz/l0=; b=nmhnuGk9h58G94lN0L2e93yZvp
	I5xPYSE6xMvop+ai2DhKmjtgZyPrgRa9uI1Zm+SX+hMWqr68LGkHztEYCMKHSRmlIbNOXfT/dZg+e
	rJCiKTMeh1zC7MsNd+9b0SxK3+3OX/nT7L6RpLWD7cCv8R8rFI+lVLDTIyP8XYAQ65PcIKFZOwx1x
	XyTg1j5/liUJs6kIXvlGdqy0Wv3a8D20s3ChBdBWArASQ/BvCmmLTtZxwcBXQCZfz61+SY2zpmrO/
	O3jxAXMBk+B6c/0fVrxkab22qgP+XzJYS+9IGp8JQoOJ20WA2TC+pTvcMen+W7OjP3qLGkVh+DH0c
	K4p0qHbQ==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2H6K-0002UJ-0V; Sun, 12 Nov 2023 21:30:36 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and convert veth & vrf
Date: Sun, 12 Nov 2023 21:30:03 +0100
Message-Id: <20231112203009.26073-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231112203009.26073-1-daniel@iogearbox.net>
References: <20231112203009.26073-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27091/Sun Nov 12 09:38:11 2023)

Move {l,t,d}stats allocation to the core and let netdevs pick the stats
type they need. That way the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc) - all happening in the core.

Co-developed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@kernel.org>
---
 drivers/net/veth.c        | 16 ++-----------
 drivers/net/vrf.c         | 14 +++---------
 include/linux/netdevice.h |  8 +++++++
 net/core/dev.c            | 47 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9980517ed8b0..ac030c241d1a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1506,25 +1506,12 @@ static void veth_free_queues(struct net_device *dev)
 
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
@@ -1796,6 +1783,7 @@ static void veth_setup(struct net_device *dev)
 			       NETIF_F_HW_VLAN_STAG_RX);
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3e6e0fdc3ba7..bb95ce43cd97 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1164,22 +1164,15 @@ static void vrf_dev_uninit(struct net_device *dev)
 
 	vrf_rtable_release(dev, vrf);
 	vrf_rt6_release(dev, vrf);
-
-	free_percpu(dev->dstats);
-	dev->dstats = NULL;
 }
 
 static int vrf_dev_init(struct net_device *dev)
 {
 	struct net_vrf *vrf = netdev_priv(dev);
 
-	dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
-	if (!dev->dstats)
-		goto out_nomem;
-
 	/* create the default dst which points back to us */
 	if (vrf_rtable_create(dev) != 0)
-		goto out_stats;
+		goto out_nomem;
 
 	if (vrf_rt6_create(dev) != 0)
 		goto out_rth;
@@ -1193,9 +1186,6 @@ static int vrf_dev_init(struct net_device *dev)
 
 out_rth:
 	vrf_rtable_release(dev, vrf);
-out_stats:
-	free_percpu(dev->dstats);
-	dev->dstats = NULL;
 out_nomem:
 	return -ENOMEM;
 }
@@ -1694,6 +1684,8 @@ static void vrf_setup(struct net_device *dev)
 	dev->min_mtu = IPV6_MIN_MTU;
 	dev->max_mtu = IP6_MAX_MTU;
 	dev->mtu = dev->max_mtu;
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 }
 
 static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 98082113156e..eccb00a4572f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1797,6 +1797,13 @@ enum netdev_ml_priv_type {
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
@@ -2354,6 +2361,7 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
+	enum netdev_stat_type		pcpu_stat_type:8;
 	union {
 		struct pcpu_lstats __percpu		*lstats;
 		struct pcpu_sw_netstats __percpu	*tstats;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..75db81496db5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10049,6 +10049,44 @@ void netif_tx_stop_all_queues(struct net_device *dev)
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
@@ -10109,9 +10147,13 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	ret = netdev_do_alloc_pcpu_stats(dev);
+	if (ret)
+		goto err_uninit;
+
 	ret = dev_index_reserve(net, dev->ifindex);
 	if (ret < 0)
-		goto err_uninit;
+		goto err_free_pcpu;
 	dev->ifindex = ret;
 
 	/* Transfer changeable features to wanted_features and enable
@@ -10217,6 +10259,8 @@ int register_netdevice(struct net_device *dev)
 	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 err_ifindex_release:
 	dev_index_release(net, dev->ifindex);
+err_free_pcpu:
+	netdev_do_free_pcpu_stats(dev);
 err_uninit:
 	if (dev->netdev_ops->ndo_uninit)
 		dev->netdev_ops->ndo_uninit(dev);
@@ -10469,6 +10513,7 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
 		if (dev->needs_free_netdev)
-- 
2.34.1


