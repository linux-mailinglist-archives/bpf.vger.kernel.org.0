Return-Path: <bpf+bounces-71414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A085BBF264A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D63C74F8CD8
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13228B3E2;
	Mon, 20 Oct 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TLSmI6x2"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A1285CB6;
	Mon, 20 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977459; cv=none; b=FU8QUpKE0bbjsdk1o9A+INGa1kIQFnI6GBoMvrqG5LA+7POM++6tzoAP9gSpGfUGWEeqkH0rjJ8eBMTDuIZyi91kc+MAt4ydaofzMLMWhWOZLlRK/QzDVRWaKaHNKqRH3qKwqZV08OvlmCPnB4soSey/8hE/QYXCsNYnAa7OgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977459; c=relaxed/simple;
	bh=VnU4gf0K1Brfsh4dmw0Y3+cCfy5VVKHSTfv0Us2U9QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYy44i1zNuFGMJGJ7zplxapGqTFHh9Mia56Pi3i3Hc1W5fj8/eTX3jOtxiFbqftWBwklsgCEWob6BthCCNCbTs+n1+DFhNH8Mq44qijYxdS1Psoj9fF+A4v2h9RuTwyhSTw1K8hilkOE2uRc+TytADyz9XQN6iBKEVhKe5FgPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TLSmI6x2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ec7GpTVT+YIrbNQI7exrHKCHUOBTFhgROm9vhRYLPjE=; b=TLSmI6x2HgSTUIIlpN07jDzwjM
	rcFo8el4rQYyOG+lvpYcPNo0bPDzz3iagvDLpOjo72jD5HyQ6TEAwV4OIOa3irHfHXLvq+5+QrtyW
	4rsS8L7EmerqucqIOCgFDXA7UrsF64djt2XIEQtve7vxMRRtH21CQthXyS5CQ7icd9Lwg6H8sqMbW
	7wMjgiXTYXytoDdXkF87Y582Bgu4sbGkdl4C6V8qY1snusDDvk/cEbUS33ZELZpB7of6HEQHgZhOl
	q0IXsJCj3htMYyjhHiYEO/Yf0CyYMeXh0cvXu7BXkZIEYCa1uypfHVexh7ELBLnSivNUOcpxznMxg
	PY6mFYpg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsfy-000Jjk-1P;
	Mon, 20 Oct 2025 18:24:02 +0200
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
Subject: [PATCH net-next v3 05/15] net: Proxy net_mp_{open,close}_rxq for mapped queues
Date: Mon, 20 Oct 2025 18:23:45 +0200
Message-ID: <20251020162355.136118-6-daniel@iogearbox.net>
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
---
 include/net/page_pool/memory_provider.h |  4 +-
 net/core/netdev_rx_queue.c              | 57 +++++++++++++++++--------
 2 files changed, 41 insertions(+), 20 deletions(-)

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
index 8ee289316c06..b4ff3497e086 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -170,48 +170,63 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq;
+	bool needs_unlock = false;
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
+	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx, &needs_unlock);
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
+	if (needs_unlock)
+		netdev_unlock(dev);
 	return ret;
 }
 
@@ -226,38 +241,44 @@ int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_rx_queue *rxq;
+	bool needs_unlock = false;
 	int err;
 
-	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
 		return;
 
-	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx, &needs_unlock);
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
+	if (needs_unlock)
+		netdev_unlock(dev);
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


