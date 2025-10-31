Return-Path: <bpf+bounces-73193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0775C27019
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55CB7351BF0
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A696329C68;
	Fri, 31 Oct 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lhYmRIEV"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89030F818;
	Fri, 31 Oct 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945694; cv=none; b=euI9EJzmE6e4ZNakPwY8kPIaKRjKRd5aRcpONLM+w7i/zbsJRfoar1AcPmwxF9czg/J1bLMiBMwEx0cnoLtk3kfMgDjI9Aq59kXj/sZ1uMEvPxsYtD2m9kR0t6zynGyra1wCar4+uLwJbM9oHbFqQhFwuuuPS+s0MD8WCllPsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945694; c=relaxed/simple;
	bh=snQ0neZMq/SrCCtySQYfezkAXeMFeR8qnBAZCKTrUWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxPKthm5z+HpCgf9eVj4OwLcEXRCgak56FblvzINj5V1sH7U8wiEk21zKPgu/uP3PlF01NJChIKsyBfMj1Fdc2qOrtADkvx8d0Yo2idYlr8Mt9ky1Snxze68xjpv+rPd2P6LhngQghVX+8v2WLn6nve76y4is+mzYwiiFQBDvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lhYmRIEV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PXKETdnd9ka6Kgd7Df8Y20jvIe3AAmvb30pim1es7Bo=; b=lhYmRIEV0PppyHSv90WnGWjI8E
	YwCgaknWY000E/BIn6cnvpJe+ybeFBHblYYummr/+jllmn+8fc1PDyJmR+ExNOPXmhN1nRvxaclTC
	49P6HkLS4w3uz3Wh9cyPnSypaoZV7TiD0PiqgI169Vp8RaMq8Rn+I3M/wv1RimeIEICWM/UacO5r3
	n9ybe3Zs1emAxXsIWVd/MB4JHh5pkFR8h4t/ml44XAguSWuWTq3G2EhDDB7RFJlhhYS6aMGRuYXkZ
	xM9nMRka2bf2aq4P3Bsz+1rYYaa6rgPIMSMyE50BM9ENq9S0sdCllRsWBRCUY+Yi3MIxtFzIW7z3G
	3p8ya53A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vEwYZ-0005cW-0O;
	Fri, 31 Oct 2025 22:21:11 +0100
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
Subject: [PATCH net-next v4 05/14] net: Proxy net_mp_{open,close}_rxq for mapped queues
Date: Fri, 31 Oct 2025 22:20:54 +0100
Message-ID: <20251031212103.310683-6-daniel@iogearbox.net>
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

When a process in a container wants to setup a memory provider, it will
use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
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
 include/net/page_pool/memory_provider.h |  4 +-
 net/core/netdev_rx_queue.c              | 55 +++++++++++++++++--------
 2 files changed, 39 insertions(+), 20 deletions(-)

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
index 889b7382cdb6..0e43254b64cd 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -174,49 +174,63 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
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
+	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx);
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
+	netif_put_rx_queue_peer_locked(orig_dev, dev);
 	return ret;
 }
 
@@ -231,38 +245,43 @@ int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
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
+	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx);
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
+	netif_put_rx_queue_peer_locked(orig_dev, dev);
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


