Return-Path: <bpf+bounces-70992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802ABDEE8F
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262DE484455
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70326FA50;
	Wed, 15 Oct 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RLAfnU3E"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224B268C55;
	Wed, 15 Oct 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536934; cv=none; b=cx4ZjXq41is93+RbF2yVLXCcT4vVz3CBBm43TG+R4vE5I9PkglRF4kLpVYB9UQA4uxjTrYJODVI63mR19Hq5+c5eRHv1oDJeP63qG98SLfSfN1Qa6cKjfJQ06aR4OdMpijkpvQmHwqfie1diPjqdpYJh8vs6zqy0Iamap0FegGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536934; c=relaxed/simple;
	bh=4KlQgj+DLiOQIwLN5XTRdpWwMGdGKfB0pUZWbzQeYUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH8LhJtiaXEQHtNaDse4SknaEXxl4QX+wgKd/6jQGCFKhsQIDlmlWTexxB5SYMUChhUMdAfoXjyBNioRuJNW8zV8po//2iwYUJmicOtKCdDlw3raRik9lFXdim9NtKDj2MxK2+UENKmGgQy+chKnnHq6ejzNEJYBzMOBVbCwm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RLAfnU3E; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XiGP8f3g9vVj9cBrvrA+o8ajrH9d7uAxQXSyy9tGfYg=; b=RLAfnU3Efqvz5RmMTHHgxaeMxY
	1Cgff+ffO/WluHPkGtDwF2mG0nWsFttUCMgCXxJnpUi2iAabyYt/PfpNVO5zqYBCN3ZvUTJJccbu/
	GKZPbFpb/z+FKY9oCf3REcFj/gi44N7qFm5BMTIhg5/f2XQIlLhIO0N0cwy1+JryFaDyj26eCeqHm
	BUkfTkWb4G/bk4h5yYp5ydLnqLqHYblr+6/dOKSH/dRF4cKFIfZyYEFAOb5trYfUMkYPzM+YGEiNs
	KchAvUZFje3AXD/AZZAmb7tNpPCi9CBzz5W3T6GNj+GkpxiBg1HaNiB4WUtLQ8EzNILxAQF/mbRAD
	tgKBlmYw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924f-000H8B-1m;
	Wed, 15 Oct 2025 16:01:53 +0200
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
Subject: [PATCH net-next v2 10/15] xsk: Proxy pool management for mapped queues
Date: Wed, 15 Oct 2025 16:01:35 +0200
Message-ID: <20251015140140.62273-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015140140.62273-1-daniel@iogearbox.net>
References: <20251015140140.62273-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27793/Wed Oct 15 11:29:40 2025)

Similarly what we do for net_mp_{open,close}_rxq for mapped queues,
proxy also the xsk_{reg,clear}_pool_at_qid via __netif_get_rx_queue_peer
such that when a virtual netdev picked a mapped rxq, the request gets
through to the real rxq in the physical netdev.

Change the function signatures for queue_id to unsigned int in order
to pass the queue_id parameter into __netif_get_rx_queue_peer. The
proxying is only relevant for queue_id < dev->real_num_rx_queues since
right now its only supported for rxqs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/xdp_sock_drv.h |  4 ++--
 net/xdp/xsk.c              | 33 ++++++++++++++++++++++++++++-----
 net/xdp/xsk.h              |  5 ++---
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 242e34f771cc..25c37fab00bc 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -29,7 +29,7 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
-					    u16 queue_id);
+					    unsigned int queue_id);
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
@@ -296,7 +296,7 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
 }
 
 static inline struct xsk_buff_pool *
-xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
+xsk_get_pool_from_qid(struct net_device *dev, unsigned int queue_id)
 {
 	return NULL;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 985e0cac965d..9e55ea0f5fde 100644
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
@@ -111,7 +113,7 @@ bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
 EXPORT_SYMBOL(xsk_uses_need_wakeup);
 
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
-					    u16 queue_id)
+					    unsigned int queue_id)
 {
 	if (queue_id < dev->real_num_rx_queues)
 		return dev->_rx[queue_id].pool;
@@ -122,12 +124,19 @@ struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
 }
 EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
-void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
+void xsk_clear_pool_at_qid(struct net_device *dev, unsigned int queue_id)
 {
+	bool needs_unlock = false;
+
+	if (queue_id < dev->real_num_rx_queues)
+		WARN_ON_ONCE(!netif_get_rx_queue_peer_locked(&dev, &queue_id,
+							     &needs_unlock));
 	if (queue_id < dev->num_rx_queues)
 		dev->_rx[queue_id].pool = NULL;
 	if (queue_id < dev->num_tx_queues)
 		dev->_tx[queue_id].pool = NULL;
+	if (needs_unlock)
+		netdev_unlock(dev);
 }
 
 /* The buffer pool is stored both in the _rx struct and the _tx struct as we do
@@ -135,14 +144,26 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
  * This might also change during run time.
  */
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
-			u16 queue_id)
+			unsigned int queue_id)
 {
+	bool needs_unlock = false;
+	int ret = 0;
+
 	if (queue_id >= max_t(unsigned int,
 			      dev->real_num_rx_queues,
 			      dev->real_num_tx_queues))
 		return -EINVAL;
 	if (xsk_get_pool_from_qid(dev, queue_id))
 		return -EBUSY;
+	if (queue_id < dev->real_num_rx_queues) {
+		if (!netif_get_rx_queue_peer_locked(&dev, &queue_id,
+						    &needs_unlock))
+			return -EBUSY;
+	}
+	if (xsk_get_pool_from_qid(dev, queue_id)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	pool->netdev = dev;
 	pool->queue_id = queue_id;
@@ -151,8 +172,10 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 		dev->_rx[queue_id].pool = pool;
 	if (queue_id < dev->real_num_tx_queues)
 		dev->_tx[queue_id].pool = pool;
-
-	return 0;
+out:
+	if (needs_unlock)
+		netdev_unlock(dev);
+	return ret;
 }
 
 static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index a4bc4749faac..54d9a7736fd2 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -41,8 +41,7 @@ static inline struct xdp_sock *xdp_sk(struct sock *sk)
 
 void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
 			     struct xdp_sock __rcu **map_entry);
-void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
+void xsk_clear_pool_at_qid(struct net_device *dev, unsigned int queue_id);
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
-			u16 queue_id);
-
+			unsigned int queue_id);
 #endif /* XSK_H_ */
-- 
2.43.0


