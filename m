Return-Path: <bpf+bounces-73201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88838C2705E
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7785189AA32
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E0340D9E;
	Fri, 31 Oct 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="d6Sr+xr1"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DB319843;
	Fri, 31 Oct 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945696; cv=none; b=CLEHERXgaG9zlHJTwhZEwjghW+UJY08NetdkNApniFKmONKOoPpzBvQxxd1JtuxZ8pp2nJUNt/EW+T3UlrCDAZznpdD7WutTHomlzCzNiXmEiDhMpCwlXqHufPrIqY9d67jRuWXeTuDWClHhq3sG42JUzKuRjIkPDH97sm+PxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945696; c=relaxed/simple;
	bh=lBXtTGBNTlgyW4jcuRvcPKTbacxwrtKGMNBmojUkUUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9yZArascI+X2l+d3lztL2IVl4WypPq5b0pZfW1iqgRWI0Cz1qikytfMQnA79xeWeEC6gnaBu5abFMHclqmrLzQUQJTm5yls/SmL8svRmO8Ldy5YxbaWojtj6X0tWU54ztV8blD5DmoQ3432tWaK0DY80HpkanMJJdgod3VHV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=d6Sr+xr1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PCprn0wwTysc4nb9gIsdCfCjJFhZ2RMgC1kCW/Dk2oY=; b=d6Sr+xr1V7OrdApsX/mPEimg5a
	prJurQhGNQ5EabFLuKgI1PIrORxbqsr2g9A75csQVeRStvjUTp8egkoUdF+a5okjG8OdaBwy2s/kj
	/OM+LdOgyvRKfRjsLxLgh4i4QvBVNFQUsLMsoZWmyFirU8/J3OJUvLItNPb8T3XqNjQKe8rFfuCWf
	Td6zWxuI08jfYnaqEvbFenqYBx8C3Fj7WJXS7yWdiSaAy4iFjwAq/X1hfO6fUWeT0YIR+Mi8I691Q
	DJmVLmf+bRaWK0U2ybX1zc4OpqWljhhuXzKsoHFZBR2WdvFI4mePQaI5Qm91zz/QsyY8Qvy+OVskf
	GYEQmRew==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYf-0005eF-21;
	Fri, 31 Oct 2025 22:21:17 +0100
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
Subject: [PATCH net-next v4 11/14] netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
Date: Fri, 31 Oct 2025 22:21:00 +0100
Message-ID: <20251031212103.310683-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27809/Fri Oct 31 10:42:21 2025)

From: David Wei <dw@davidwei.uk>

Implement rtnl_link_ops->alloc that allows the number of rx queues to be
set when netkit is created. By default, netkit has only a single rxq (and
single txq). The number of queues is deliberately not allowed to be changed
via ethtool -L and is fixed for the lifetime of a netkit instance.

For netkit device creation, numrxqueues with larger than one rxq can be
specified. These rxqs are then mappable to real rxqs in physical netdevs:

  ip link add type netkit peer numrxqueues 64      # for device pair
  ip link add numrxqueues 64 type netkit single    # for single device

The limit of numrxqueues for netkit is currently set to 256, which allows
binding multiple real rxqs from physical netdevs.

The implementation of ndo_queue_create() adds a new rxq during the bind
queue operation. We allow to create queues either in single device mode or
for the case of dual device mode for the netkit peer device which gets
placed into the target network namespace. For dual device mode the bind
against the primary device does not make sense for the targeted use cases,
and therefore gets rejected.

We also need to add a lockdep class for netkit, such that lockdep does
not trip over us, similarly done as in commit 0bef512012b1 ("net: add
netdev_lockdep_set_classes() to virtual drivers").

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 130 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 96734828bfb8..92a65350f389 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -9,11 +9,20 @@
 #include <linux/bpf_mprog.h>
 #include <linux/indirect_call_wrapper.h>
 
+#include <net/netdev_lock.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/netkit.h>
 #include <net/dst.h>
 #include <net/tcx.h>
 
-#define DRV_NAME "netkit"
+#define NETKIT_DRV_NAME	"netkit"
+
+#define NETKIT_NUM_RX_QUEUES_MAX  256
+#define NETKIT_NUM_TX_QUEUES_MAX  1
+
+#define NETKIT_NUM_RX_QUEUES_REAL 1
+#define NETKIT_NUM_TX_QUEUES_REAL 1
 
 struct netkit {
 	__cacheline_group_begin(netkit_fastpath);
@@ -37,6 +46,8 @@ struct netkit_link {
 	struct net_device *dev;
 };
 
+static struct rtnl_link_ops netkit_link_ops;
+
 static __always_inline int
 netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	   enum netkit_action ret)
@@ -224,9 +235,16 @@ static void netkit_get_stats(struct net_device *dev,
 	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
 }
 
+static int netkit_init(struct net_device *dev)
+{
+	netdev_lockdep_set_classes(dev);
+	return 0;
+}
+
 static void netkit_uninit(struct net_device *dev);
 
 static const struct net_device_ops netkit_netdev_ops = {
+	.ndo_init		= netkit_init,
 	.ndo_open		= netkit_open,
 	.ndo_stop		= netkit_close,
 	.ndo_start_xmit		= netkit_xmit,
@@ -243,13 +261,100 @@ static const struct net_device_ops netkit_netdev_ops = {
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
 
+static int netkit_queue_create(struct net_device *dev, int *idx)
+{
+	struct netkit *nk = netkit_priv(dev);
+	u32 rxq_count_old, rxq_count_new;
+	int err;
+
+	rxq_count_old = dev->real_num_rx_queues;
+	rxq_count_new = rxq_count_old + 1;
+
+	/* Only allow to bind in single device mode or to bind against
+	 * the peer device which then ends up in the target netns.
+	 */
+	if (nk->pair == NETKIT_DEVICE_PAIR && nk->primary)
+		return -EOPNOTSUPP;
+
+	if (netif_running(dev))
+		netif_carrier_off(dev);
+	err = netif_set_real_num_rx_queues(dev, rxq_count_new);
+	if (netif_running(dev))
+		netif_carrier_on(dev);
+	if (!err)
+		*idx = rxq_count_old;
+	return err;
+}
+
+static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
+	.ndo_queue_create = netkit_queue_create,
+};
+
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
+	netdev_lock(dev);
+	for (i = 1; i < dev->real_num_rx_queues; i++) {
+		dst_rxq = __netif_get_rx_queue(dev, i);
+		src_rxq = dst_rxq->peer;
+		src_dev = src_rxq->dev;
+
+		netdev_lock(src_dev);
+		netdev_rx_queue_unpeer(src_dev, src_rxq, dst_rxq);
+		netdev_unlock(src_dev);
+	}
+	netdev_unlock(dev);
+}
+
 static void netkit_setup(struct net_device *dev)
 {
 	static const netdev_features_t netkit_features_hw_vlan =
@@ -280,8 +385,9 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
 
-	dev->ethtool_ops = &netkit_ethtool_ops;
-	dev->netdev_ops  = &netkit_netdev_ops;
+	dev->netdev_ops     = &netkit_netdev_ops;
+	dev->ethtool_ops    = &netkit_ethtool_ops;
+	dev->queue_mgmt_ops = &netkit_queue_mgmt_ops;
 
 	dev->features |= netkit_features;
 	dev->hw_features = netkit_features;
@@ -330,8 +436,6 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static struct rtnl_link_ops netkit_link_ops;
-
 static int netkit_new_link(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
@@ -865,6 +969,7 @@ static void netkit_release_all(struct net_device *dev)
 static void netkit_uninit(struct net_device *dev)
 {
 	netkit_release_all(dev);
+	netkit_queue_unpeer(dev);
 }
 
 static void netkit_del_link(struct net_device *dev, struct list_head *head)
@@ -1005,8 +1110,9 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 };
 
 static struct rtnl_link_ops netkit_link_ops = {
-	.kind		= DRV_NAME,
+	.kind		= NETKIT_DRV_NAME,
 	.priv_size	= sizeof(struct netkit),
+	.alloc		= netkit_alloc,
 	.setup		= netkit_setup,
 	.newlink	= netkit_new_link,
 	.dellink	= netkit_del_link,
@@ -1020,7 +1126,7 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
-static __init int netkit_init(void)
+static __init int netkit_mod_init(void)
 {
 	BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
 		     (int)NETKIT_PASS != (int)TCX_PASS ||
@@ -1030,16 +1136,16 @@ static __init int netkit_init(void)
 	return rtnl_link_register(&netkit_link_ops);
 }
 
-static __exit void netkit_exit(void)
+static __exit void netkit_mod_exit(void)
 {
 	rtnl_link_unregister(&netkit_link_ops);
 }
 
-module_init(netkit_init);
-module_exit(netkit_exit);
+module_init(netkit_mod_init);
+module_exit(netkit_mod_exit);
 
 MODULE_DESCRIPTION("BPF-programmable network device");
 MODULE_AUTHOR("Daniel Borkmann <daniel@iogearbox.net>");
 MODULE_AUTHOR("Nikolay Aleksandrov <razor@blackwall.org>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_RTNL_LINK(DRV_NAME);
+MODULE_ALIAS_RTNL_LINK(NETKIT_DRV_NAME);
-- 
2.43.0


