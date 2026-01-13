Return-Path: <bpf+bounces-78770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B30D1BB5F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E71B33080F4A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CBC36CDF6;
	Tue, 13 Jan 2026 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UWNbKIeg"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF736B079;
	Tue, 13 Jan 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346605; cv=none; b=hxnihJoaOVFOBCn7JsOIZP9gv4Nl4lC2yQgCqGhzgUz3GbzY0GnIMJpdyS5r9ndC/m8ZHJVk1/qJf3MzFMkLpM1THkCEuoT1D9a9uNLv3jcUYoVTEKFOcrAUAchnUQ5OwyWPkHAQWRPbyatAFP+gfPgGSolvtrxbNz5p+u3oE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346605; c=relaxed/simple;
	bh=a18/0jp8e8ogqB6CvPJBCK4WpNY2qL16uabIGXZNGq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2OTRJ4vv94fXR9zXwBW8EIrJg6VL/skAk305z3q1CkpjcsB0WIDDPcWG0xfyjHDn1jk2CvxFPJERn4vU/eIS00AUzVK1L20ciqMZQWAJwG4L5zPOxO08pelB0xLP9Wlw/BzlP8TjmKHCP9qRPB74WQSNBKWoEFtme+kXHXOEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UWNbKIeg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=R+ReXvorrsdU/FpCwIGCKtSajX9iP4/UZeuVxaq9250=; b=UWNbKIegwkVKSe2FktUbRarB2R
	tk9VAtzF6TyIEIi/PULngRlaqY/cl8ZhQV4v390pnMFRBQQ2hAkOHApPLrl2y18+yKEZkfwPBd/Bz
	JGvvxFex66m8Bo2egmmGXo4LVcuv9RHXfL5Kip67jd59Qvupmu/ESrfs65nIr32l7yqDG0rZWCSre
	0ACGZDu1rgulgK858We0OR7S0hT6bStD4kH3ffEqehIsDKGMUUPxLfJ9IUQYZG4qWepcNj09y1Rg7
	9GFJhBgjz9o8ojL64SO1uNnTyM53faxBWM/QWU34+yoJC3h/aoLkAi1WtzZErMoVMul3y2ggmoCd7
	7GSUkZ2w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnjD-0003Xt-09;
	Wed, 14 Jan 2026 00:23:11 +0100
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
Subject: [PATCH net-next v6 10/16] netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
Date: Wed, 14 Jan 2026 00:22:51 +0100
Message-ID: <20260113232257.200036-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113232257.200036-1-daniel@iogearbox.net>
References: <20260113232257.200036-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

From: David Wei <dw@davidwei.uk>

Implement rtnl_link_ops->alloc that allows the number of rx queues to be
set when netkit is created. By default, netkit has only a single rxq (and
single txq). The number of queues is deliberately not allowed to be changed
via ethtool -L and is fixed for the lifetime of a netkit instance.

For netkit device creation, numrxqueues with larger than one rxq can be
specified. These rxqs are leasable to real rxqs in physical netdevs:

  ip link add type netkit peer numrxqueues 64      # for device pair
  ip link add numrxqueues 64 type netkit single    # for single device

The limit of numrxqueues for netkit is currently set to 1024, which allows
leasing multiple real rxqs from physical netdevs.

The implementation of ndo_queue_create() adds a new rxq during the queue
lease operation. We allow to create queues either in single device mode
or for the case of dual device mode for the netkit peer device which gets
placed into the target network namespace. For dual device mode the lease
against the primary device does not make sense for the targeted use cases,
and therefore gets rejected.

We also need to add a lockdep class for netkit, such that lockdep does
not trip over us, similarly done as in commit 0bef512012b1 ("net: add
netdev_lockdep_set_classes() to virtual drivers").

This is also the last missing bit to netkit for supporting io_uring with
zero-copy mode [0]. Up until this point it was not possible to consume the
latter out of containers or Kubernetes Pods where applications are in their
own network namespace.

io_uring example with eth0 being a physical device with 16 queues where
netkit is bound to the last queue, iou-zcrx.c is binary from selftests.
Flow steering to that queue is based on the service VIP:port of the
server utilizing io_uring:

  # ethtool -X eth0 start 0 equal 15
  # ethtool -X eth0 start 15 equal 1 context new
  # ethtool --config-ntuple eth0 flow-type tcp4 dst-ip 1.2.3.4 dst-port 5000 action 15
  # ip netns add foo
  # ip link add type netkit peer numrxqueues 2
  # ./pyynl/cli.py --spec ~/netlink/specs/netdev.yaml \
                   --do queue-create \
                   --json "{"ifindex": $(ifindex nk0), "type": "rx", \
                            "lease": { "ifindex": $(ifindex eth0), \
                                       "queue": { "type": "rx", "id": 15 } } }"
  {'id': 1}
  # ip link set nk0 netns foo
  # ip link set nk1 up
  # ip netns exec foo ip link set lo up
  # ip netns exec foo ip link set nk0 up
  # ip netns exec foo ip addr add 1.2.3.4/32 dev nk0
  [ ... setup routing etc to get external traffic into the netns ... ]
  # ip netns exec foo ./iou-zcrx -s -p 5000 -i nk0 -q 1

Remote io_uring client:

  # ./iou-zcrx -c -h 1.2.3.4 -p 5000 -l 12840 -z 65536

We have tested the above against a Broadcom BCM957504 (bnxt_en) 100G NIC,
supporting TCP header/data split.

Similarly, this also works for devmem which we tested using ncdevmem:

  # ip netns exec foo ./ncdevmem -s 1.2.3.4 -l -p 5000 -f nk0 -t 1 -q 1

And on the remote client:

  # ./ncdevmem -s 1.2.3.4 -p 5000 -f eth0

For Cilium, the plan is to open up support for the various memory providers
for regular Kubernetes Pods when Cilium is configured with netkit datapath
mode.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://kernel-recipes.org/en/2024/schedule/efficient-zero-copy-networking-using-io_uring [0]
---
 drivers/net/netkit.c | 117 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 96734828bfb8..9d9d74a7e589 100644
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
+#define NETKIT_NUM_RX_QUEUES_MAX  1024
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
@@ -243,13 +261,87 @@ static const struct net_device_ops netkit_netdev_ops = {
 static void netkit_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
-	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->driver, NETKIT_DRV_NAME, sizeof(info->driver));
 }
 
 static const struct ethtool_ops netkit_ethtool_ops = {
 	.get_drvinfo		= netkit_get_drvinfo,
 };
 
+static int netkit_queue_create(struct net_device *dev)
+{
+	struct netkit *nk = netkit_priv(dev);
+	u32 rxq_count_old, rxq_count_new;
+	int err;
+
+	rxq_count_old = dev->real_num_rx_queues;
+	rxq_count_new = rxq_count_old + 1;
+
+	/* Only allow to lease a queue in single device mode or to
+	 * lease against the peer device which then ends up in the
+	 * target netns.
+	 */
+	if (nk->pair == NETKIT_DEVICE_PAIR && nk->primary)
+		return -EOPNOTSUPP;
+
+	if (netif_running(dev))
+		netif_carrier_off(dev);
+	err = netif_set_real_num_rx_queues(dev, rxq_count_new);
+	if (netif_running(dev))
+		netif_carrier_on(dev);
+
+	return err ? : rxq_count_old;
+}
+
+static const struct netdev_queue_mgmt_ops netkit_queue_mgmt_ops = {
+	.ndo_queue_create	= netkit_queue_create,
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
+static void netkit_queue_unlease(struct net_device *dev)
+{
+	struct netdev_rx_queue *rxq, *rxq_lease;
+	struct net_device *dev_lease;
+	int i;
+
+	if (dev->real_num_rx_queues == 1)
+		return;
+
+	netdev_lock(dev);
+	for (i = 1; i < dev->real_num_rx_queues; i++) {
+		rxq = __netif_get_rx_queue(dev, i);
+		rxq_lease = rxq->lease;
+		dev_lease = rxq_lease->dev;
+
+		netdev_lock(dev_lease);
+		netdev_rx_queue_unlease(rxq, rxq_lease);
+		netdev_unlock(dev_lease);
+	}
+	netdev_unlock(dev);
+}
+
 static void netkit_setup(struct net_device *dev)
 {
 	static const netdev_features_t netkit_features_hw_vlan =
@@ -280,8 +372,9 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
 
-	dev->ethtool_ops = &netkit_ethtool_ops;
-	dev->netdev_ops  = &netkit_netdev_ops;
+	dev->netdev_ops     = &netkit_netdev_ops;
+	dev->ethtool_ops    = &netkit_ethtool_ops;
+	dev->queue_mgmt_ops = &netkit_queue_mgmt_ops;
 
 	dev->features |= netkit_features;
 	dev->hw_features = netkit_features;
@@ -330,8 +423,6 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static struct rtnl_link_ops netkit_link_ops;
-
 static int netkit_new_link(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
@@ -865,6 +956,7 @@ static void netkit_release_all(struct net_device *dev)
 static void netkit_uninit(struct net_device *dev)
 {
 	netkit_release_all(dev);
+	netkit_queue_unlease(dev);
 }
 
 static void netkit_del_link(struct net_device *dev, struct list_head *head)
@@ -1005,8 +1097,9 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 };
 
 static struct rtnl_link_ops netkit_link_ops = {
-	.kind		= DRV_NAME,
+	.kind		= NETKIT_DRV_NAME,
 	.priv_size	= sizeof(struct netkit),
+	.alloc		= netkit_alloc,
 	.setup		= netkit_setup,
 	.newlink	= netkit_new_link,
 	.dellink	= netkit_del_link,
@@ -1020,7 +1113,7 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
-static __init int netkit_init(void)
+static __init int netkit_mod_init(void)
 {
 	BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
 		     (int)NETKIT_PASS != (int)TCX_PASS ||
@@ -1030,16 +1123,16 @@ static __init int netkit_init(void)
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


