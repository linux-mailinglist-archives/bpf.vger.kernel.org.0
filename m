Return-Path: <bpf+bounces-78763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D64D1BB12
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B63303FCC9
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992836B07E;
	Tue, 13 Jan 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Pv2wETvA"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52C3557E8;
	Tue, 13 Jan 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346602; cv=none; b=Dwbck2h6fo/1ycCfNZQYz4MjGag6oKO5bH+8NokzWnnAJBG1u11KqRVW31q9QhO6x5ZSKkT3hZUTUY3TXSv3xYH5BGzoiQnjuQ1cCE8tWR/yGtJ0LjUdWkk+eBeaB1nh5slGeicDQTXLMi+zbB75jadkYUmRKwbehXEG8c3rELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346602; c=relaxed/simple;
	bh=SJf7cNU0fZW0CK/eUCI2N9AJV6VJzpE/DK7/k6ercgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV45affExzDCILzqRf6zHIpaXz5j8PTF+gUXrKyDsu96NMaXNZDXTojsLL5bXdzUQmbFcV5wQu9TZm+3EpJ57SljSTtR2Bhm+18mx+vrGKBg+x3AgsrxlEUX+o0bJaUvWTU9alr7ws7WBB9d+ZQhSlVMZHMslnFdg5p4kLIk/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Pv2wETvA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EVT6/7blxzKStpR/Bx0PFLo7sHdk8xrC7TaYykRI2Io=; b=Pv2wETvAe2/EgBQvIZ1CXmNRlo
	ffcp5AXeV2JiCc0d2F6hHX9Gj+k3wU8ptmupu8f5LpKseNgU8UIHr/qYHAUhyeZfiZJwJBKzzZPAs
	8pnZWDNNwoo7Sy00Z8N8Bv06TOvcBVu5Vl4eqdBGbhLrvceSfCXnRu8AqO9yw0YbMYNSMP3PKajGI
	5n5wE6hVrZNtCCVuMMOFYpfaxH1UJNG7mb9V61YAjTfxTkCZ20tw6QPgffmWCPMPTRjvWGvFY1HMi
	fYDDjm/QBN5pdBwDwfxcul1hNC13FPzxaQBleqbpWIzfag5e9Uh9ta6GF8DqGCu39mpqstejXepkY
	cS49rHUQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnjA-0003XU-2u;
	Wed, 14 Jan 2026 00:23:08 +0100
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
Subject: [PATCH net-next v6 08/16] xsk: Proxy pool management for leased queues
Date: Wed, 14 Jan 2026 00:22:49 +0100
Message-ID: <20260113232257.200036-9-daniel@iogearbox.net>
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

Similarly to the net_mp_{open,close}_rxq handling for leased queues, proxy
the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_lease_locked such
that in case a virtual netdev picked a leased rxq, the request gets through
to the real rxq in the physical netdev. The proxying is only relevant for
queue_id < dev->real_num_rx_queues since right now its only supported for
rxqs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d95c481338c6..6e396cef1cae 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -23,6 +23,8 @@
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/vmalloc.h>
+
+#include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
 #include <net/netdev_lock.h>
@@ -117,10 +119,18 @@ EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 {
-	if (queue_id < dev->num_rx_queues)
-		dev->_rx[queue_id].pool = NULL;
-	if (queue_id < dev->num_tx_queues)
-		dev->_tx[queue_id].pool = NULL;
+	struct net_device *orig_dev = dev;
+	unsigned int id = queue_id;
+
+	if (id < dev->real_num_rx_queues)
+		WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &id));
+
+	if (id < dev->real_num_rx_queues)
+		dev->_rx[id].pool = NULL;
+	if (id < dev->real_num_tx_queues)
+		dev->_tx[id].pool = NULL;
+
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
 }
 
 /* The buffer pool is stored both in the _rx struct and the _tx struct as we do
@@ -130,17 +140,29 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			u16 queue_id)
 {
-	if (queue_id >= max_t(unsigned int,
-			      dev->real_num_rx_queues,
-			      dev->real_num_tx_queues))
-		return -EINVAL;
+	struct net_device *orig_dev = dev;
+	unsigned int id = queue_id;
+	int ret = 0;
 
-	if (queue_id < dev->real_num_rx_queues)
-		dev->_rx[queue_id].pool = pool;
-	if (queue_id < dev->real_num_tx_queues)
-		dev->_tx[queue_id].pool = pool;
+	if (id >= max(dev->real_num_rx_queues,
+		      dev->real_num_tx_queues))
+		return -EINVAL;
+	if (id < dev->real_num_rx_queues) {
+		if (!netif_get_rx_queue_lease_locked(&dev, &id))
+			return -EBUSY;
+		if (xsk_get_pool_from_qid(dev, id)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
-	return 0;
+	if (id < dev->real_num_rx_queues)
+		dev->_rx[id].pool = pool;
+	if (id < dev->real_num_tx_queues)
+		dev->_tx[id].pool = pool;
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return ret;
 }
 
 static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
-- 
2.43.0


