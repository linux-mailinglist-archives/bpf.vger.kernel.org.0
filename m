Return-Path: <bpf+bounces-68976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0AB8B568
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575864E2152
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917DB2D3745;
	Fri, 19 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ek/Y8prY"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAA288525;
	Fri, 19 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317530; cv=none; b=a1eCMaU0a7LItUCbBRQAEpSj0szNE0aLhhOet2WfqEnxL65AyrWV+mTdwZWn/xjX2CZ6J6Q64Ix3JWD6bonP0i3OpFInD+KjvLyh5IxPAjNfCRzTvgWi5ZcZCskLiGEmgx1mdhkxea+OG5hRKGr4OCxhi47Yqc8AgW8SholzA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317530; c=relaxed/simple;
	bh=04PjWsM9xVFQ+8mFF/FN930PxBbHqlKVOZKvo98dUXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZWySSiazoY0y3ulRsL2V7mD/jydCzJ8D1TH5Mvv3T5IjndMR2uJj8kstl1PGhkaIhtva1pWhaWZnkEzCzYSob6P98qXfJ5x2E4TBe0eE68P9OmNDEAm21SYybl9R7413lsvUUmArsluwoaGUmmtGC7IN9GttcxfJ9e0CU6Hdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Ek/Y8prY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mVNRrDwlpBI4bafduOTI2HAkidI2/BfTtJ0ikGFWTnY=; b=Ek/Y8prYKqImt2fClPDlxbkLO/
	8s02vIE0QHPz7O/j1Helj0lZqWD/JJul+xAWXs+QiuyJH6lkEkpWK4lNeA3OS+gLwJ+d2r6V+5u/q
	1q+V4Lkn5LZctyfaj4/3Oz9uxWjHSEHSf3edJZHWwJqovi0+lHPuuICafGf3mxtElPZ7bUK5pHwg9
	KILuarZijTs6E54HT93WBSVRu5QJ/w7SZjPuoY4rGrYddkPpLxZpK8+rCOH7s+lPOo4J0yl/C9nPB
	XpR2ioGbn4XRnzg7kkL4Y8StKOUeA1fvUAgIipy214gaEfLhSZvyuMSONhDvuiW9xnh5jOdW1aa1R
	WGvYVR3Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzihw-000Npe-2F;
	Fri, 19 Sep 2025 23:31:56 +0200
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
Subject: [PATCH net-next 02/20] net: Add peer to netdev_rx_queue
Date: Fri, 19 Sep 2025 23:31:35 +0200
Message-ID: <20250919213153.103606-3-daniel@iogearbox.net>
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

Add a peer pointer to netdev_rx_queue that points from the real rxq to the
mapped rxq in a virtual netdev, and vice versa.

Add related helpers that set, unset, get and check the peer pointer.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/netdev_rx_queue.h | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..47126ccaf854 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -28,6 +28,7 @@ struct netdev_rx_queue {
 #endif
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
+	struct netdev_rx_queue		*peer;
 } ____cacheline_aligned_in_smp;
 
 /*
@@ -58,4 +59,54 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
 
+static inline void __netdev_rx_queue_peer(struct netdev_rx_queue *src_rxq,
+					  struct netdev_rx_queue *dst_rxq)
+{
+	src_rxq->peer = dst_rxq;
+	dst_rxq->peer = src_rxq;
+}
+
+static inline void netdev_rx_queue_peer(struct net_device *src_dev,
+					struct netdev_rx_queue *src_rxq,
+					struct netdev_rx_queue *dst_rxq)
+{
+	dev_hold(src_dev);
+	__netdev_rx_queue_peer(src_rxq, dst_rxq);
+}
+
+static inline void __netdev_rx_queue_unpeer(struct netdev_rx_queue *src_rxq,
+					    struct netdev_rx_queue *dst_rxq)
+{
+	src_rxq->peer = NULL;
+	dst_rxq->peer = NULL;
+}
+
+static inline void netdev_rx_queue_unpeer(struct net_device *src_dev,
+					  struct netdev_rx_queue *src_rxq,
+					  struct netdev_rx_queue *dst_rxq)
+{
+	__netdev_rx_queue_unpeer(src_rxq, dst_rxq);
+	dev_put(src_dev);
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
+static inline struct netdev_rx_queue *
+__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx)
+{
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(*dev, *rxq_idx);
+
+	if (rxq->peer) {
+		rxq = rxq->peer;
+		*rxq_idx = get_netdev_rx_queue_index(rxq);
+		*dev = rxq->dev;
+	}
+	return rxq;
+}
 #endif
-- 
2.43.0


