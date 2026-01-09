Return-Path: <bpf+bounces-78396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B648DD0C529
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3736930B7371
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458033D4EC;
	Fri,  9 Jan 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gE1z8iMm"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87933DED1;
	Fri,  9 Jan 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994026; cv=none; b=trreHlK1xOGmZOZbykhMjGiqX1pey8dP4RB9Aj62UFLx5z+yT9h3rOK0jb4UFuzNXO2Taoy78l4vs6hlEs05oRc0agw5hAXdJnTInG8P5ldATk9g1lcOytZ9vu9ml3q1DAJG8yi2xFuVow/Vt2AYTiG049WBzizsDYs+3AN0m7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994026; c=relaxed/simple;
	bh=SJf7cNU0fZW0CK/eUCI2N9AJV6VJzpE/DK7/k6ercgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFet3sWLf31pjC29nghoLTzz/slSunwla8HGrtWHRi6XBBV7UN8RES6u8TXIgWlHEjqPrefDWlqqijwsFr+q3wemSjavTNSTS09fYv67C5dnQmRj2lVuIBdVyG/gqYxzrGf/NOiqgxcS8/WycuJOql3JpLq/Q6c43PVH1mrRJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gE1z8iMm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EVT6/7blxzKStpR/Bx0PFLo7sHdk8xrC7TaYykRI2Io=; b=gE1z8iMmsTh2wpvimkXwn3EBCP
	xGJaS7E899ALXnQr4KfSL9VpeVuuBocd2i4dy7qwqeMBhgwI7OlnJBXjV6aa5PjfMWAMpoCRMjzaG
	2S+VGamGI9UH7t8qE1O4p5qnKVB7PDa9JlLChoDnIfjzLbGGlc1JC/YxU03H13xBOxycIYkfo9qpn
	t07C3dH+x4ldECBdEgbH8iDEALdH7eYHnA8dDZadc//r2dKn7kwVL8HugZ05tQ14MfqHVP1ueF8uh
	eJFegdXas3NYlFIna4V7CzC/3Y76hRLStQaAmRynIjt3q4S0ces1zxpfGKmkwXG9MFIaRhjIS/g4B
	6r3iTHbg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0J-000540-1R;
	Fri, 09 Jan 2026 22:26:43 +0100
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
Subject: [PATCH net-next v5 08/16] xsk: Proxy pool management for leased queues
Date: Fri,  9 Jan 2026 22:26:24 +0100
Message-ID: <20260109212632.146920-9-daniel@iogearbox.net>
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


