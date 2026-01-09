Return-Path: <bpf+bounces-78393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C5D0C4D2
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 122E4301D333
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237E33F369;
	Fri,  9 Jan 2026 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bPv3GCkZ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CA33D4FE;
	Fri,  9 Jan 2026 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994024; cv=none; b=jma4mp3N5rZhC6spuCqOQSnhAZiGIDikNMdJ3efIEvbYYrICiwo3IjFJLFAu8p/0iemiaEp2oFZppUZauw+QjcD18lJtH1UfeV7GnLWMVyld1vyPUwRWzsMpHfmjWwiazcOuzyzWFOd2ZzOdjOflwvGioQQT70TwauLf/cGXAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994024; c=relaxed/simple;
	bh=6AqnwgESmuZWzQuL9VadtW6Ig/bHu4+Zf8hGnfqCmFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndjoh2L8/EFGmmexsrx6B+k4aFH9yv+NUJBjiY/PRg019qWIcODQHl0QjgZ/0qRxKoKlZ4pMW9U8LaPzWSmsdnc7zbPyBJyAlFKoFcqL9vq4gnSUBAx03F8kiVoitkY2p0LnMDFDH9iwnhcLIZ6OUeoX5OdqopiN035DoHOub7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bPv3GCkZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xfr5zKpQYn33okOryLGky3ansD/ozk3kM3Fppbz8fgI=; b=bPv3GCkZSH4lwyS+oglTkkxX4Y
	H01Hj1X1bxL7n/PNQ0t6NBj+eRofAMfBGJZQZAANaqDpsX2/KYWkJX1t1qQtge9kT42IbtiUqYrj/
	tzzfCHKmw7DC6LXNs2EfQJgBUFp2NHnYJZCCbDaM1/tNGOPrVqOV86stslh5vh1eK92PUEBUhfymi
	xAlTffA08T/qtbcVw+31hmFqZg166dpr50qAYxJWMR/0kS03c3j4X1oRjP5KfbQIctzwgpMPIGoBT
	5Aa15It4h9xMVzOH55QehhqsBL7Mr1bZ69BVgqsfvrB5c8TIVj97/vltt3fv1bJ2J1p7kELlwj/7H
	hQ1VDclg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0G-00053X-0L;
	Fri, 09 Jan 2026 22:26:40 +0100
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
Subject: [PATCH net-next v5 05/16] net: Proxy net_mp_{open,close}_rxq for leased queues
Date: Fri,  9 Jan 2026 22:26:21 +0100
Message-ID: <20260109212632.146920-6-daniel@iogearbox.net>
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

From: David Wei <dw@davidwei.uk>

When a process in a container wants to setup a memory provider, it will
use the virtual netdev and a leased rxq, and call net_mp_{open,close}_rxq
to try and restart the queue. At this point, proxy the queue restart on
the real rxq in the physical netdev.

For memory providers (io_uring zero-copy rx and devmem), it causes the
real rxq in the physical netdev to be filled from a memory provider that
has DMA mapped memory from a process within a container.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/netdev_rx_queue.h           |  4 ++
 include/net/page_pool/memory_provider.h |  4 +-
 net/core/netdev_rx_queue.c              | 78 +++++++++++++++++++------
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index de04fdfdad72..508d11afaecb 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -73,4 +73,8 @@ enum netif_lease_dir {
 struct netdev_rx_queue *
 __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
 			   enum netif_lease_dir dir);
+struct netdev_rx_queue *
+netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq);
+void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
+				     struct net_device *dev);
 #endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index ada4f968960a..b6f811c3416b 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -23,12 +23,12 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
 
-int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		    struct pp_memory_provider_params *p);
 int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack);
-void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      struct pp_memory_provider_params *old_p);
 void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 			const struct pp_memory_provider_params *old_p);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 3da628088a3c..2e4eeda4fcfe 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -71,6 +71,29 @@ __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
 	return rxq;
 }
 
+struct netdev_rx_queue *
+netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq_idx)
+{
+	struct net_device *orig_dev = *dev;
+	struct netdev_rx_queue *rxq;
+
+	/* Locking order is always from the virtual to the physical device
+	 * see netdev_nl_queue_create_doit().
+	 */
+	netdev_ops_assert_locked(orig_dev);
+	rxq = __netif_get_rx_queue_lease(dev, rxq_idx, NETIF_VIRT_TO_PHYS);
+	if (rxq && orig_dev != *dev)
+		netdev_lock(*dev);
+	return rxq;
+}
+
+void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
+				     struct net_device *dev)
+{
+	if (orig_dev != dev)
+		netdev_unlock(dev);
+}
+
 bool netif_rx_queue_lease_get_owner(struct net_device **dev,
 				    unsigned int *rxq_idx)
 {
@@ -187,49 +210,63 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack)
 {
+	struct net_device *orig_dev = dev;
 	struct netdev_rx_queue *rxq;
 	int ret;
 
 	if (!netdev_need_ops_lock(dev))
 		return -EOPNOTSUPP;
-
 	if (rxq_idx >= dev->real_num_rx_queues) {
 		NL_SET_ERR_MSG(extack, "rx queue index out of range");
 		return -ERANGE;
 	}
-	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
 
+	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
+	rxq = netif_get_rx_queue_lease_locked(&dev, &rxq_idx);
+	if (!rxq) {
+		NL_SET_ERR_MSG(extack, "rx queue peered to a virtual netdev");
+		return -EBUSY;
+	}
+	if (!dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");
+		ret = -EBUSY;
+		goto out;
+	}
 	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 	if (dev->cfg->hds_thresh) {
 		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 	if (dev_xdp_prog_count(dev)) {
 		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out;
 	}
-
-	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out;
 	}
 #ifdef CONFIG_XDP_SOCKETS
 	if (rxq->pool) {
 		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 #endif
-
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
 	}
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
 	return ret;
 }
 
@@ -244,38 +281,43 @@ int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
+	struct net_device *orig_dev = dev;
 	struct netdev_rx_queue *rxq;
 	int err;
 
-	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
 		return;
 
-	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	rxq = netif_get_rx_queue_lease_locked(&dev, &rxq_idx);
+	if (WARN_ON_ONCE(!rxq))
+		return;
 
 	/* Callers holding a netdev ref may get here after we already
 	 * went thru shutdown via dev_memory_provider_uninstall().
 	 */
 	if (dev->reg_state > NETREG_REGISTERED &&
 	    !rxq->mp_params.mp_ops)
-		return;
+		goto out;
 
 	if (WARN_ON_ONCE(rxq->mp_params.mp_ops != old_p->mp_ops ||
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
-		return;
+		goto out;
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	err = netdev_rx_queue_restart(dev, rxq_idx);
 	WARN_ON(err && err != -ENETDOWN);
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
 }
 
-void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      struct pp_memory_provider_params *old_p)
 {
 	netdev_lock(dev);
-	__net_mp_close_rxq(dev, ifq_idx, old_p);
+	__net_mp_close_rxq(dev, rxq_idx, old_p);
 	netdev_unlock(dev);
 }
-- 
2.43.0


