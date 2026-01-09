Return-Path: <bpf+bounces-78398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C3D0C538
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20674304F8AF
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC533D6C7;
	Fri,  9 Jan 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DYp3DwP5"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94D33DED4;
	Fri,  9 Jan 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994028; cv=none; b=tKyf8svz2JWbV0jVwuBf8237l/8Q8WXMnJpegQzvS18KJivwjI6w1k1PRBXR1bZRix4vLfQS8cmKO6tscvowXmBJ20tXZDieeoFXLfxOoFZQILF2cjzpaa02iHtyMcWxzXKMRnFYGrYzkXLWO3v4iMGLe7vGyI+/MBLZ8uXmJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994028; c=relaxed/simple;
	bh=/1tS6nqyxlYUrkSE6I3CefLsz2R0ZM3mqUEoaUHy+go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ8dyKxq86qnEZawKySY0eSTLQP7vCT8NjEjN7ZaAE9Mhe4YaKwCBjyyQjnjl734Eg0dkKLeW+dMFsIvTiVqXfnF1Szn1J+mj839boVoaeNUchLF2zJfyWnf3Uthv4UMgrxPmn3kQ9RdG8EoHu4GYgo3rDamVFuMCqL0gNR75ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DYp3DwP5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4FuZdpVqgxGE1CYH2lJqotNAE8Xc3XEKmVtUVlN2QN4=; b=DYp3DwP5uzEoAasTgVw8nTNFcz
	KFhxvHeWhYgjgW57sqXKPVLRRqqOyZBoiuInUXFSw5+JBq392NYkBvAKFV4hx0zYqjnqCtXaV+WZe
	mBbsPwFzs4kODiPLfePnnZnZXLYEzbcdpv/aev30aDY0WTrScy+EGvB553cnnxmqdDTCFbeOui9ym
	7UQ9wupgZgUEZPxm6dGJTR6iVtGQT3kTrewcSMWZjPmkrPL3XVJhvdYiBt+bphj6c3Quf9+wT5oyv
	i69qXNrvtwGmFLX6N+bRpXbn8QfRMt5uePJzGvzl/rbTtvcad64lN/TvifGE4qzZpg0xckySBy+71
	W/JjYheA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0C-00053B-20;
	Fri, 09 Jan 2026 22:26:36 +0100
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
Subject: [PATCH net-next v5 02/16] net: Implement netdev_nl_queue_create_doit
Date: Fri,  9 Jan 2026 22:26:18 +0100
Message-ID: <20260109212632.146920-3-daniel@iogearbox.net>
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

Implement netdev_nl_queue_create_doit which creates a new rx queue in a
virtual netdev and then leases it to a rx queue in a physical netdev.

Example with ynl client:

  # ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-create \
      --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
  {'id': 1}

Note that the netdevice locking order is always from the virtual to
the physical device.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/netdev_queues.h   |  19 ++++-
 include/net/netdev_rx_queue.h |   9 ++-
 include/net/xdp_sock_drv.h    |   2 +-
 net/core/dev.c                |   7 ++
 net/core/dev.h                |   2 +
 net/core/netdev-genl.c        | 146 +++++++++++++++++++++++++++++++++-
 net/core/netdev_queues.c      |  57 +++++++++++++
 net/core/netdev_rx_queue.c    |  50 +++++++++++-
 net/xdp/xsk.c                 |   2 +-
 9 files changed, 282 insertions(+), 12 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..f65319a6fb87 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -130,6 +130,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
  *			   for this queue. Return NULL on error.
  *
+ * @ndo_queue_create: Create a new RX queue which can be leased to another queue.
+ *		      Ops on this queue are redirected to the leased queue e.g.
+ *		      when opening a memory provider. Return the new queue id on
+ *		      success. Return negative error code on failure.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -149,9 +154,12 @@ struct netdev_queue_mgmt_ops {
 						  int idx);
 	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
 							 int idx);
+	int			(*ndo_queue_create)(struct net_device *dev);
 };
 
-bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
+bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx);
+bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
+bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
 
 /**
  * DOC: Lockless queue stopping / waking helpers.
@@ -329,5 +337,10 @@ static inline void netif_subqueue_sent(const struct net_device *dev,
 	})
 
 struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
-
-#endif
+bool netdev_can_create_queue(const struct net_device *dev,
+			     struct netlink_ext_ack *extack);
+bool netdev_can_lease_queue(const struct net_device *dev,
+			    struct netlink_ext_ack *extack);
+bool netdev_queue_busy(struct net_device *dev, int idx,
+		       struct netlink_ext_ack *extack);
+#endif /* _LINUX_NET_QUEUES_H */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..1cacc2451516 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -28,6 +28,8 @@ struct netdev_rx_queue {
 #endif
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
+	struct netdev_rx_queue		*lease;
+	netdevice_tracker		lease_tracker;
 } ____cacheline_aligned_in_smp;
 
 /*
@@ -57,5 +59,8 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 }
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
-
-#endif
+void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
+			   struct netdev_rx_queue *rxq_src);
+void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
+			     struct netdev_rx_queue *rxq_src);
+#endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 242e34f771cc..c07cfb431eac 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -28,7 +28,7 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
-struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
+struct xsk_buff_pool *xsk_get_pool_from_qid(const struct net_device *dev,
 					    u16 queue_id);
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037e..c2b64ffeb9e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1102,6 +1102,13 @@ netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
 	return __netdev_put_lock_ops_compat(dev, net);
 }
 
+struct net_device *
+netdev_put_lock(struct net_device *dev, netdevice_tracker *tracker)
+{
+	netdev_tracker_free(dev, tracker);
+	return __netdev_put_lock(dev, dev_net(dev));
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
diff --git a/net/core/dev.h b/net/core/dev.h
index da18536cbd35..9bcb76b325d0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -30,6 +30,8 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
 struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
+struct net_device *netdev_put_lock(struct net_device *dev,
+				   netdevice_tracker *tracker);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index aae75431858d..cd4dc4eef029 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1122,7 +1122,151 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	const int qmaxtype = ARRAY_SIZE(netdev_queue_id_nl_policy) - 1;
+	const int lmaxtype = ARRAY_SIZE(netdev_lease_nl_policy) - 1;
+	int err, ifindex, ifindex_lease, queue_id, queue_id_lease;
+	struct nlattr *qtb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
+	struct nlattr *ltb[ARRAY_SIZE(netdev_lease_nl_policy)];
+	struct netdev_rx_queue *rxq, *rxq_lease;
+	struct net_device *dev, *dev_lease;
+	netdevice_tracker dev_tracker;
+	struct nlattr *nest;
+	struct sk_buff *rsp;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_LEASE))
+		return -EINVAL;
+	if (nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]) !=
+	    NETDEV_QUEUE_TYPE_RX) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_QUEUE_TYPE]);
+		return -EINVAL;
+	}
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
+
+	nest = info->attrs[NETDEV_A_QUEUE_LEASE];
+	err = nla_parse_nested(ltb, lmaxtype, nest,
+			       netdev_lease_nl_policy, info->extack);
+	if (err < 0)
+		return err;
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_IFINDEX) ||
+	    NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_QUEUE))
+		return -EINVAL;
+	if (ltb[NETDEV_A_LEASE_NETNS_ID]) {
+		NL_SET_BAD_ATTR(info->extack, ltb[NETDEV_A_LEASE_NETNS_ID]);
+		return -EINVAL;
+	}
+
+	ifindex_lease = nla_get_u32(ltb[NETDEV_A_LEASE_IFINDEX]);
+
+	nest = ltb[NETDEV_A_LEASE_QUEUE];
+	err = nla_parse_nested(qtb, qmaxtype, nest,
+			       netdev_queue_id_nl_policy, info->extack);
+	if (err < 0)
+		return err;
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_TYPE))
+		return -EINVAL;
+	if (nla_get_u32(qtb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
+		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_TYPE]);
+		return -EINVAL;
+	}
+	if (ifindex == ifindex_lease) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Lease ifindex cannot be the same as queue creation ifindex");
+		return -EINVAL;
+	}
+
+	queue_id_lease = nla_get_u32(qtb[NETDEV_A_QUEUE_ID]);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	/* Locking order is always from the virtual to the physical device
+	 * since this is also the same order when applications open the
+	 * memory provider later on.
+	 */
+	dev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	if (!dev) {
+		err = -ENODEV;
+		goto err_genlmsg_free;
+	}
+	if (!netdev_can_create_queue(dev, info->extack)) {
+		err = -EINVAL;
+		goto err_unlock_dev;
+	}
+
+	dev_lease = netdev_get_by_index(genl_info_net(info), ifindex_lease,
+					&dev_tracker, GFP_KERNEL);
+	if (!dev_lease) {
+		err = -ENODEV;
+		goto err_unlock_dev;
+	}
+	if (!netdev_can_lease_queue(dev_lease, info->extack)) {
+		netdev_put(dev_lease, &dev_tracker);
+		err = -EINVAL;
+		goto err_unlock_dev;
+	}
+
+	dev_lease = netdev_put_lock(dev_lease, &dev_tracker);
+	if (!dev_lease) {
+		err = -ENODEV;
+		goto err_unlock_dev;
+	}
+	if (queue_id_lease >= dev_lease->real_num_rx_queues) {
+		err = -ERANGE;
+		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_ID]);
+		goto err_unlock_dev_lease;
+	}
+	if (netdev_queue_busy(dev_lease, queue_id_lease, info->extack)) {
+		err = -EBUSY;
+		goto err_unlock_dev_lease;
+	}
+
+	rxq_lease = __netif_get_rx_queue(dev_lease, queue_id_lease);
+	rxq = __netif_get_rx_queue(dev, dev->real_num_rx_queues - 1);
+
+	if (rxq->lease && rxq->lease->dev != dev_lease) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Leasing multiple queues from different devices not supported");
+		goto err_unlock_dev_lease;
+	}
+
+	err = queue_id = dev->queue_mgmt_ops->ndo_queue_create(dev);
+	if (err < 0) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Device is unable to create a new queue");
+		goto err_unlock_dev_lease;
+	}
+
+	rxq = __netif_get_rx_queue(dev, queue_id);
+	netdev_rx_queue_lease(rxq, rxq_lease);
+
+	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
+	genlmsg_end(rsp, hdr);
+
+	netdev_unlock(dev_lease);
+	netdev_unlock(dev);
+
+	return genlmsg_reply(rsp, info);
+
+err_unlock_dev_lease:
+	netdev_unlock(dev_lease);
+err_unlock_dev:
+	netdev_unlock(dev);
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
 }
 
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 251f27a8307f..fae92ee090c4 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
 
 /**
  * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
@@ -25,3 +27,58 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
 	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
 }
 
+bool netdev_can_create_queue(const struct net_device *dev,
+			     struct netlink_ext_ack *extack)
+{
+	if (dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "Device is not a virtual device");
+		return false;
+	}
+	if (!dev->queue_mgmt_ops ||
+	    !dev->queue_mgmt_ops->ndo_queue_create) {
+		NL_SET_ERR_MSG(extack, "Device does not support queue creation");
+		return false;
+	}
+	if (dev->real_num_rx_queues < 1 ||
+	    dev->real_num_tx_queues < 1) {
+		NL_SET_ERR_MSG(extack, "Device must have at least one real queue");
+		return false;
+	}
+	return true;
+}
+
+bool netdev_can_lease_queue(const struct net_device *dev,
+			    struct netlink_ext_ack *extack)
+{
+	if (!dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "Lease device is a virtual device");
+		return false;
+	}
+	if (!netif_device_present(dev)) {
+		NL_SET_ERR_MSG(extack, "Lease device has been removed from the system");
+		return false;
+	}
+	if (!dev->queue_mgmt_ops) {
+		NL_SET_ERR_MSG(extack, "Lease device does not support queue management operations");
+		return false;
+	}
+	return true;
+}
+
+bool netdev_queue_busy(struct net_device *dev, int idx,
+		       struct netlink_ext_ack *extack)
+{
+	if (netif_rxq_is_leased(dev, idx)) {
+		NL_SET_ERR_MSG(extack, "Lease device queue is already leased");
+		return true;
+	}
+	if (xsk_get_pool_from_qid(dev, idx)) {
+		NL_SET_ERR_MSG(extack, "Lease device queue in use by AF_XDP");
+		return true;
+	}
+	if (netif_rxq_has_mp(dev, idx)) {
+		NL_SET_ERR_MSG(extack, "Lease device queue in use by memory provider");
+		return true;
+	}
+	return false;
+}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..ed85dfb434a0 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -9,15 +9,57 @@
 
 #include "page_pool_priv.h"
 
-/* See also page_pool_is_unreadable() */
-bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
+void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
+			   struct netdev_rx_queue *rxq_src)
+{
+	netdev_assert_locked(rxq_src->dev);
+	netdev_assert_locked(rxq_dst->dev);
+
+	WARN_ON_ONCE(READ_ONCE(rxq_src->dev->reg_state) == NETREG_UNREGISTERING);
+
+	netdev_hold(rxq_src->dev, &rxq_src->lease_tracker, GFP_KERNEL);
+
+	WRITE_ONCE(rxq_src->lease, rxq_dst);
+	WRITE_ONCE(rxq_dst->lease, rxq_src);
+}
+
+void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
+			     struct netdev_rx_queue *rxq_src)
 {
-	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
+	netdev_assert_locked(rxq_dst->dev);
+	netdev_assert_locked(rxq_src->dev);
+
+	WARN_ON_ONCE(READ_ONCE(rxq_dst->dev->reg_state) != NETREG_UNREGISTERING);
 
-	return !!rxq->mp_params.mp_ops;
+	WRITE_ONCE(rxq_src->lease, NULL);
+	WRITE_ONCE(rxq_dst->lease, NULL);
+
+	netdev_put(rxq_src->dev, &rxq_src->lease_tracker);
+}
+
+bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx)
+{
+	if (rxq_idx < dev->real_num_rx_queues)
+		return READ_ONCE(__netif_get_rx_queue(dev, rxq_idx)->lease);
+	return false;
+}
+
+/* See also page_pool_is_unreadable() */
+bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
+{
+	if (rxq_idx < dev->real_num_rx_queues)
+		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
+	return false;
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
+bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx)
+{
+	if (rxq_idx < dev->real_num_rx_queues)
+		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_priv;
+	return false;
+}
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..410297b4ab48 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -103,7 +103,7 @@ bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
 }
 EXPORT_SYMBOL(xsk_uses_need_wakeup);
 
-struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
+struct xsk_buff_pool *xsk_get_pool_from_qid(const struct net_device *dev,
 					    u16 queue_id)
 {
 	if (queue_id < dev->real_num_rx_queues)
-- 
2.43.0


