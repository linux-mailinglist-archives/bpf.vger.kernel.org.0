Return-Path: <bpf+bounces-71412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421FBF2641
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C37402DB8
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658A72877FA;
	Mon, 20 Oct 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FjzqBvr/"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298F26981E;
	Mon, 20 Oct 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977458; cv=none; b=IDXzeEpcqxMnzWSzaBrtiRQAE7+70YM+QodhRlHuQJvgEt0zhN2+Bd/e4mlBzUtwNxsA+NSX1KMGiOg0zR5P27fIWM2bR2dySLr8vZvJdMhvLcBdoPrnyGBrGMLlgcwH5hRpGOco2zia3pvwjaff6zVaMgHzaizpz8nsuVvWoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977458; c=relaxed/simple;
	bh=+aSnQ+qL/21A3UFmluMZtNKHZdjquBZS8mD7CaO6R+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeE6VOYLn6BuY+5x4Rv85eBsYxN+ik877gpLBMFZrMS4XeYTNew43sEK6QJywAJOAu55KzQBH74jM9IAbXdOMUANNQtD2OLV6aFO4QR0YJwmQFrXrsO3oSB+FBmpEW1EfyFa5ssHNLeFmZ28AgVEYbCWrNeZk4/gsvARbjsMsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FjzqBvr/; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=t4mVQNUxX3XF7kj1e+NjG3QMpj4bsQ8Tq3WyY6vMIak=; b=FjzqBvr/4SHX1KpL4lfvoZFh/g
	JkF2xUzEJPaP+aAX1mhh2NfiJhkzSayjRqNdyypLZbXpWmplIY+CfIWv/4dmws0P1Eor8gjQ5hBsm
	IreBbJMpVgRbVOOx9LdkRveSi6w3UP+g1mffG5jW9WfRaohDlIOWqmYIsVziKA6LS0jRqFf7dsFm5
	KPz+dU6Sw5WiJkPfubIF8K8RaMVjnvbOYq8MGw1OYaMK1Kct5anW3RD8WFJUpofdrHwgodiVltSSX
	15K+/xbxv+OqunwIH6JYv6FuKz9crx2JHsXUacFL9bryq0ePiuqdSXrSFNX8yO6XHZzz/ND+vmWa1
	VVKIEhOA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsfv-000Jic-0O;
	Mon, 20 Oct 2025 18:23:59 +0200
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
Subject: [PATCH net-next v3 02/15] net: Implement netdev_nl_bind_queue_doit
Date: Mon, 20 Oct 2025 18:23:42 +0200
Message-ID: <20251020162355.136118-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020162355.136118-1-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

From: David Wei <dw@davidwei.uk>

Implement netdev_nl_bind_queue_doit() that creates an rx queue in a
virtual netdev and then binds it to an rxq in a real netdev to create
a queue pair.

Example with ynl client:

  # ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do bind-queue \
      --json '{"src-ifindex": 4, "src-queue-id": 15, "dst-ifindex": 8, "queue-type": "rx"}'
  {'dst-queue-id': 1}

Note that the netdevice locking order is always from the virtual to
the physical device.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/netdev_queues.h   |   5 ++
 include/net/netdev_rx_queue.h |  36 ++++++++-
 net/core/netdev-genl.c        | 141 +++++++++++++++++++++++++++++++++-
 net/core/netdev_rx_queue.c    |  61 +++++++++++++++
 4 files changed, 240 insertions(+), 3 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..286d5edce07d 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -130,6 +130,10 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
  *			   for this queue. Return NULL on error.
  *
+ * @ndo_queue_create: Create a new RX queue which can be bound to another queue.
+ *		      Ops on this queue are redirected to the peer queue e.g.
+ *		      when opening a memory provider.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -149,6 +153,7 @@ struct netdev_queue_mgmt_ops {
 						  int idx);
 	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
 							 int idx);
+	int			(*ndo_queue_create)(struct net_device *dev);
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..db3ef94c0744 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -28,6 +28,7 @@ struct netdev_rx_queue {
 #endif
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
+	struct netdev_rx_queue		*peer;
 } ____cacheline_aligned_in_smp;
 
 /*
@@ -56,6 +57,37 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+static inline void __netdev_rx_queue_peer(struct netdev_rx_queue *src_rxq,
+					  struct netdev_rx_queue *dst_rxq)
+{
+	src_rxq->peer = dst_rxq;
+	dst_rxq->peer = src_rxq;
+}
 
-#endif
+static inline void __netdev_rx_queue_unpeer(struct netdev_rx_queue *src_rxq,
+					    struct netdev_rx_queue *dst_rxq)
+{
+	src_rxq->peer = NULL;
+	dst_rxq->peer = NULL;
+}
+
+static inline bool netdev_rx_queue_peered(struct net_device *dev,
+					  u16 queue_id)
+{
+	if (queue_id < dev->real_num_rx_queues)
+		return dev->_rx[queue_id].peer;
+	return false;
+}
+
+void netdev_rx_queue_peer(struct net_device *src_dev,
+			  struct netdev_rx_queue *src_rxq,
+			  struct netdev_rx_queue *dst_rxq);
+void netdev_rx_queue_unpeer(struct net_device *src_dev,
+			    struct netdev_rx_queue *src_rxq,
+			    struct netdev_rx_queue *dst_rxq);
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+struct netdev_rx_queue *
+netif_get_rx_queue_peer_locked(struct net_device **dev,
+			       unsigned int *rxq_idx,
+			       bool *needs_unlock);
+#endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index ce1018ea390f..579469abac8c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1122,7 +1122,146 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	u32 src_ifidx, src_qid, dst_ifidx, dst_qid, q_type;
+	struct netdev_rx_queue *src_rxq, *dst_rxq, *tmp_rxq;
+	struct net_device *src_dev, *dst_dev;
+	struct sk_buff *rsp;
+	int err = 0;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_DST_IFINDEX))
+		return -EINVAL;
+
+	src_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX]);
+	src_qid = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID]);
+	dst_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_DST_IFINDEX]);
+	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_QUEUE_TYPE]);
+
+	if (q_type != NETDEV_QUEUE_TYPE_RX) {
+		NL_SET_ERR_MSG(info->extack, "Only binding of RX queue supported");
+		return -EOPNOTSUPP;
+	}
+	if (dst_ifidx == src_ifidx) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination driver cannot be same as source driver");
+		return -EOPNOTSUPP;
+	}
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
+	dst_dev = netdev_get_by_index_lock(genl_info_net(info), dst_ifidx);
+	if (!dst_dev) {
+		err = -ENODEV;
+		goto err_genlmsg_free;
+	}
+	if (dst_dev->dev.parent) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination device is not a virtual device");
+		goto err_unlock_dst_dev;
+	}
+	if (!dst_dev->queue_mgmt_ops ||
+	    !dst_dev->queue_mgmt_ops->ndo_queue_create) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination driver does not support queue management operations");
+		goto err_unlock_dst_dev;
+	}
+	if (dst_dev->real_num_rx_queues < 1) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination device must have at least one real RX queue");
+		goto err_unlock_dst_dev;
+	}
+
+	src_dev = netdev_get_by_index_lock(genl_info_net(info), src_ifidx);
+	if (!src_dev) {
+		err = -ENODEV;
+		goto err_unlock_dst_dev;
+	}
+	if (!src_dev->dev.parent) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source device is a virtual device");
+		goto err_unlock_src_dev;
+	}
+	if (!netif_device_present(src_dev)) {
+		err = -ENODEV;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source device has been removed from the system");
+		goto err_unlock_src_dev;
+	}
+	if (!src_dev->queue_mgmt_ops) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source driver does not support queue management operations");
+		goto err_unlock_src_dev;
+	}
+	if (src_qid >= src_dev->num_rx_queues) {
+		err = -ERANGE;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source device queue is out of range");
+		goto err_unlock_src_dev;
+	}
+
+	src_rxq = __netif_get_rx_queue(src_dev, src_qid);
+	if (src_rxq->peer) {
+		err = -EBUSY;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source device queue is already bound");
+		goto err_unlock_src_dev;
+	}
+
+	tmp_rxq = __netif_get_rx_queue(dst_dev, dst_dev->real_num_rx_queues - 1);
+	if (tmp_rxq->peer && tmp_rxq->peer->dev != src_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Binding multiple queues from difference source devices not supported");
+		goto err_unlock_src_dev;
+	}
+
+	err = dst_dev->queue_mgmt_ops->ndo_queue_create(dst_dev);
+	if (err <= 0) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination device is unable to create a new queue");
+		goto err_unlock_src_dev;
+	}
+
+	dst_qid = err - 1;
+	dst_rxq = __netif_get_rx_queue(dst_dev, dst_qid);
+
+	netdev_rx_queue_peer(src_dev, src_rxq, dst_rxq);
+
+	nla_put_u32(rsp, NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID, dst_qid);
+	genlmsg_end(rsp, hdr);
+
+	netdev_unlock(src_dev);
+	netdev_unlock(dst_dev);
+
+	return genlmsg_reply(rsp, info);
+
+err_unlock_src_dev:
+	netdev_unlock(src_dev);
+err_unlock_dst_dev:
+	netdev_unlock(dst_dev);
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
 }
 
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..916ca8d7ae7c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -18,6 +18,67 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
+void netdev_rx_queue_peer(struct net_device *src_dev,
+			  struct netdev_rx_queue *src_rxq,
+			  struct netdev_rx_queue *dst_rxq)
+{
+	netdev_assert_locked(src_dev);
+	netdev_assert_locked(dst_rxq->dev);
+
+	netdev_hold(src_dev, &src_rxq->dev_tracker, GFP_KERNEL);
+	__netdev_rx_queue_peer(src_rxq, dst_rxq);
+}
+
+void netdev_rx_queue_unpeer(struct net_device *src_dev,
+			    struct netdev_rx_queue *src_rxq,
+			    struct netdev_rx_queue *dst_rxq)
+{
+	WARN_ON_ONCE(READ_ONCE(dst_rxq->dev->reg_state) != NETREG_UNREGISTERING);
+
+	netdev_assert_locked(dst_rxq->dev);
+	netdev_assert_locked(src_dev);
+
+	__netdev_rx_queue_unpeer(src_rxq, dst_rxq);
+	netdev_put(src_dev, &src_rxq->dev_tracker);
+}
+
+static struct netdev_rx_queue *
+__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx,
+			  bool virt_to_phys_only)
+{
+	struct net_device *req_dev = *dev;
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(req_dev, *rxq_idx);
+
+	if (rxq->peer) {
+		if (virt_to_phys_only &&
+		    req_dev->dev.parent)
+			return NULL;
+		rxq = rxq->peer;
+		*rxq_idx = get_netdev_rx_queue_index(rxq);
+		*dev = rxq->dev;
+	}
+	return rxq;
+}
+
+struct netdev_rx_queue *
+netif_get_rx_queue_peer_locked(struct net_device **dev, unsigned int *rxq_idx,
+			       bool *needs_unlock)
+{
+	struct net_device *req_dev = *dev;
+	struct netdev_rx_queue *rxq;
+
+	/* Locking order is always from the virtual to the physical device
+	 * see netdev_nl_bind_queue_doit().
+	 */
+	netdev_ops_assert_locked(req_dev);
+	rxq = __netif_get_rx_queue_peer(dev, rxq_idx, true);
+	if (rxq && req_dev != *dev) {
+		*needs_unlock = true;
+		netdev_lock(*dev);
+	}
+	return rxq;
+}
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
-- 
2.43.0


