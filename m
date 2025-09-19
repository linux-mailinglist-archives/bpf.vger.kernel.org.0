Return-Path: <bpf+bounces-68977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE8B8B56E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B821C254EA
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1D2D3ED0;
	Fri, 19 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="l1JRNjCt"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10429E110;
	Fri, 19 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317530; cv=none; b=VVLt5X4FFXwhQq805avTOWrTZn5kd0qHfFPDwKuVXN/YrZ6jcY7BPCJqB6ezm5y0ZZEoI35yJw5kK5OfY063tG5l1T6yXfi+/t06o7A+X1Hl/xVRvusPkunSdhzSTaD3kT0TXOx8Zwlks6Uq6nEi7dSS3K9tXZFKTvMgksLH4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317530; c=relaxed/simple;
	bh=fSq2A7auBR6nNvcdjiSyqlg+2fu7c5pumneArQpOw3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0gb9Uko+TFopHUbkiZb4c//LMHs4wb16xiA/xkMPgt+Jqq86h6db5WRipD/7uBEosygfNmlHyc0nWx7/xlTFdrWLLPOsZUaQjuycyinHgqoCFwW/3cHLCd0zDXeWnaMXex7LZ0Q6vqR0gLamPe0L+t9SE3yiJZHrUBcf5Ma31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=l1JRNjCt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+35JIJRdVCndiazFop2sbrA5SHjzRxGDT2tKbZS1t9s=; b=l1JRNjCtXgXTX1KdmLCfnM1d+d
	PrymSeNqTFgFraDb3ZVq7hGCTv0psZ/N9N6LUqLAsBpdsKgCxw/3XCA0hJHzxXSeKlxA9s8XBkL/a
	26XTRyNaCMN0l8DDhhoI4zi6DlOhBZKOutnKyGHirsxv0eZh5eazjruR/WpPYhX53CtOM4kktffOs
	MWIYG4fWxF9PRx2A9cFtql1Ac4zdCHEDwK52swExoKTlMQCpDGTxRf/qlx+/KI+IzeyP5n8PgCAAe
	zhtgrcm6aWTIZ7iVjouF2VA+kEv9UKuwJMk+1ZQzzenZzBBf/SLzhPBMM9XLy3NkaWXBwuZQ2Ntuc
	9RHZgKFA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzihy-000Nq0-2h;
	Fri, 19 Sep 2025 23:31:58 +0200
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
Subject: [PATCH net-next 04/20] net: Add ndo_{peer,unpeer}_queues callback
Date: Fri, 19 Sep 2025 23:31:37 +0200
Message-ID: <20250919213153.103606-5-daniel@iogearbox.net>
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

Add ndo_{peer,unpeer}_queues() callback which can be used by virtual drivers
that implement rxq mapping to a real rxq to update their internal state or
exposed capability flags from the set of rxq mappings.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/linux/netdevice.h     | 15 ++++++++++++++-
 include/net/netdev_rx_queue.h |  4 ++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c54d44805fa..43b3c4e3593e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -65,6 +65,7 @@ struct macsec_context;
 struct macsec_ops;
 struct netdev_config;
 struct netdev_name_node;
+struct netdev_rx_queue;
 struct sd_flow_limit;
 struct sfp_bus;
 /* 802.11 specific */
@@ -1404,6 +1405,15 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ *
+ * void (*ndo_peer_queues)(struct net_device *dev, struct netdev_rx_queue *rxq);
+ *	Custom callback for drivers when a physical queue gets peered with
+ *	a virtual one, so that device drivers can update exposed device flags.
+ *
+ * void (*ndo_unpeer_queues)(struct net_device *dev, struct netdev_rx_queue *rxq);
+ *	Custom callback for drivers when a physical queue gets unpeered with
+ *	a virtual one, so that device drivers can update exposed device flags.
+ *	Reverse operation of ndo_peer_queues.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1651,7 +1661,10 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
-
+	void			(*ndo_peer_queues)(struct net_device *dev,
+						   struct netdev_rx_queue *rxq);
+	void			(*ndo_unpeer_queues)(struct net_device *dev,
+						     struct netdev_rx_queue *rxq);
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	/**
 	 * @net_shaper_ops: Device shaping offload operations
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 47126ccaf854..fdfacd28c2ae 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -72,6 +72,8 @@ static inline void netdev_rx_queue_peer(struct net_device *src_dev,
 {
 	dev_hold(src_dev);
 	__netdev_rx_queue_peer(src_rxq, dst_rxq);
+	if (dst_rxq->dev->netdev_ops->ndo_peer_queues)
+		dst_rxq->dev->netdev_ops->ndo_peer_queues(dst_rxq->dev, dst_rxq);
 }
 
 static inline void __netdev_rx_queue_unpeer(struct netdev_rx_queue *src_rxq,
@@ -85,6 +87,8 @@ static inline void netdev_rx_queue_unpeer(struct net_device *src_dev,
 					  struct netdev_rx_queue *src_rxq,
 					  struct netdev_rx_queue *dst_rxq)
 {
+	if (dst_rxq->dev->netdev_ops->ndo_unpeer_queues)
+		dst_rxq->dev->netdev_ops->ndo_unpeer_queues(dst_rxq->dev, dst_rxq);
 	__netdev_rx_queue_unpeer(src_rxq, dst_rxq);
 	dev_put(src_dev);
 }
-- 
2.43.0


