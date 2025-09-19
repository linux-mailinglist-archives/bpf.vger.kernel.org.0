Return-Path: <bpf+bounces-68990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9670B8B674
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405A47BECFA
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00712D1F42;
	Fri, 19 Sep 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ght8gI2i"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755A209F43;
	Fri, 19 Sep 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318655; cv=none; b=khglURhBNLS0PhqbcfV5IpwSGyWUAACXfu/vMxRpprlBD4GB8LDBCocbJYm+ePnfOYm+clv+FfE668CCkFmxXUTYO0nRMGK4tTknoNIoq46AocBrjZmHajzROlHgG7w/WlUnXd47uBeJLD9rQtomp4eAZQEaeJb6o5/yP6NvBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318655; c=relaxed/simple;
	bh=dZaREEiN45TVcf/7CJcrCwksa4Jex/hjTHviO/s/qeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7PRGJMah+J2vLrbgHARM7azPxtHSyV/OIoqPnveSsdC6PfSwRyf9pv/gBRA/f2mnIy0fO2vnbwWtyOba0APpQENWxePcrJ4Qg5JteLegLQfFiVPk75hpaiKedgxUpM1wAhSNXCizcKjpedfwXM59TUbdsoYi+kpCP/Xz7ZoKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Ght8gI2i; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WFQaCUhXIuMujc2/4KgC6CUQsqyLsqvGUCfksCOxc3I=; b=Ght8gI2iJ4ypjVByn8pZ0N7hhC
	agbCvxvhExNrRNuMXpYO3PbQVEMzyoMzDJgNAE37FnkLgh2vcKto7ippmU2X+T5N7Ox6Mv64GGESc
	CUUX2XVKUx9pzwYwrNEvIB8lZhuY/UZU3BfYen6E7GFmuCIC9nI32Wrt3X8NQ9lPMYp2NdkZzmO2n
	r4d7/DEwcGcYseYiajYB5/0EqTCamqJ3xEgYOgMAbiQSgMFzTah4mosMxvHjR0H+pyDZDKf1b+dkB
	wZlA8Q1OKOCsHJYRnkXrlU5Z7SKg1LaJjkQYmjvwKrBPO1fnW6pCszoJFvDldugX2+X7slfy7Dgzl
	gTFZ9Rxg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii9-000Nsw-30;
	Fri, 19 Sep 2025 23:32:09 +0200
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
Subject: [PATCH net-next 16/20] netkit: Implement rtnl_link_ops->alloc
Date: Fri, 19 Sep 2025 23:31:49 +0200
Message-ID: <20250919213153.103606-17-daniel@iogearbox.net>
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

From: David Wei <dw@davidwei.uk>

Implement rtnl_link_ops->alloc that allows the number of rx queues to be
set when netkit is created. By default, netkit has only a single rxq (and
single txq). The number of queues is deliberately not allowed to be changed
via ethtool -L and is fixed for the lifetime of a netkit instance.

For netkit device creation, numrxqueues with larger than one rxq can be
specified. These rxqs are then mappable to real rxqs in physical netdevs:

  ip link add numrxqueues 2 type netkit

As a starting point, the limit of numrxqueues for netkit is currently set
to 2, but future work is going to allow mapping multiple real rxqs from
physical netdevs, potentially at some point even from different physical
netdevs.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/netkit.c | 78 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 8f1285513d82..e5dfbf7ea351 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -9,11 +9,19 @@
 #include <linux/bpf_mprog.h>
 #include <linux/indirect_call_wrapper.h>
 
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/netkit.h>
 #include <net/dst.h>
 #include <net/tcx.h>
 
-#define DRV_NAME "netkit"
+#define NETKIT_DRV_NAME	"netkit"
+
+#define NETKIT_NUM_TX_QUEUES_MAX  1
+#define NETKIT_NUM_RX_QUEUES_MAX  2
+
+#define NETKIT_NUM_TX_QUEUES_REAL 1
+#define NETKIT_NUM_RX_QUEUES_REAL 1
 
 struct netkit {
 	__cacheline_group_begin(netkit_fastpath);
@@ -37,6 +45,8 @@ struct netkit_link {
 	struct net_device *dev;
 };
 
+static struct rtnl_link_ops netkit_link_ops;
+
 static __always_inline int
 netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	   enum netkit_action ret)
@@ -243,13 +253,69 @@ static const struct net_device_ops netkit_netdev_ops = {
 static void netkit_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
-	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->driver, NETKIT_DRV_NAME, sizeof(info->driver));
+}
+
+static void netkit_get_channels(struct net_device *dev,
+				struct ethtool_channels *channels)
+{
+	channels->max_rx = dev->num_rx_queues;
+	channels->max_tx = dev->num_tx_queues;
+	channels->max_other = 0;
+	channels->max_combined = 1;
+	channels->rx_count = dev->real_num_rx_queues;
+	channels->tx_count = dev->real_num_tx_queues;
+	channels->other_count = 0;
+	channels->combined_count = 0;
 }
 
 static const struct ethtool_ops netkit_ethtool_ops = {
 	.get_drvinfo		= netkit_get_drvinfo,
+	.get_channels		= netkit_get_channels,
 };
 
+static struct net_device *netkit_alloc(struct nlattr *tb[],
+				       const char *ifname,
+				       unsigned char name_assign_type,
+				       unsigned int num_tx_queues,
+				       unsigned int num_rx_queues)
+{
+	const struct rtnl_link_ops *ops = &netkit_link_ops;
+	struct net_device *dev;
+
+	if (num_tx_queues > NETKIT_NUM_TX_QUEUES_MAX ||
+	    num_rx_queues > NETKIT_NUM_RX_QUEUES_MAX)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	dev = alloc_netdev_mqs(ops->priv_size, ifname,
+			       name_assign_type, ops->setup,
+			       num_tx_queues, num_rx_queues);
+	if (dev) {
+		dev->real_num_tx_queues = NETKIT_NUM_TX_QUEUES_REAL;
+		dev->real_num_rx_queues = NETKIT_NUM_RX_QUEUES_REAL;
+	}
+	return dev;
+}
+
+static void netkit_queue_unpeer(struct net_device *dev)
+{
+	struct netdev_rx_queue *src_rxq, *dst_rxq;
+	struct net_device *src_dev;
+	int i;
+
+	if (dev->real_num_rx_queues == 1)
+		return;
+	for (i = 1; i < dev->real_num_rx_queues; i++) {
+		dst_rxq = __netif_get_rx_queue(dev, i);
+		src_rxq = dst_rxq->peer;
+		src_dev = src_rxq->dev;
+
+		netdev_lock(src_dev);
+		netdev_rx_queue_unpeer(src_dev, src_rxq, dst_rxq);
+		netdev_unlock(src_dev);
+	}
+}
+
 static void netkit_setup(struct net_device *dev)
 {
 	static const netdev_features_t netkit_features_hw_vlan =
@@ -330,8 +396,6 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static struct rtnl_link_ops netkit_link_ops;
-
 static int netkit_new_link(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
@@ -865,6 +929,7 @@ static void netkit_release_all(struct net_device *dev)
 static void netkit_uninit(struct net_device *dev)
 {
 	netkit_release_all(dev);
+	netkit_queue_unpeer(dev);
 }
 
 static void netkit_del_link(struct net_device *dev, struct list_head *head)
@@ -1005,8 +1070,9 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 };
 
 static struct rtnl_link_ops netkit_link_ops = {
-	.kind		= DRV_NAME,
+	.kind		= NETKIT_DRV_NAME,
 	.priv_size	= sizeof(struct netkit),
+	.alloc		= netkit_alloc,
 	.setup		= netkit_setup,
 	.newlink	= netkit_new_link,
 	.dellink	= netkit_del_link,
@@ -1042,4 +1108,4 @@ MODULE_DESCRIPTION("BPF-programmable network device");
 MODULE_AUTHOR("Daniel Borkmann <daniel@iogearbox.net>");
 MODULE_AUTHOR("Nikolay Aleksandrov <razor@blackwall.org>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_RTNL_LINK(DRV_NAME);
+MODULE_ALIAS_RTNL_LINK(NETKIT_DRV_NAME);
-- 
2.43.0


