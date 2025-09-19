Return-Path: <bpf+bounces-68996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17FB8B692
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850701C84D40
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05CD2D46B5;
	Fri, 19 Sep 2025 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kBCbtzIe"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208329BDAD;
	Fri, 19 Sep 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318721; cv=none; b=lENWIUZMYaT99Tqzf0w8/WfAtByJii6S8klzOjitn3GZNoE5jfmo+YwGh7MxGzPD0JQXb3KPQNhzPmCWTYUrRxAcFsAvATOW9dSwQjnSZjw7RS4rHdfzV1DvZ9kvIXCfR1IR7UYm6Q7RX/o8ed0GXF9k2xv/nR4zD4BxAXISoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318721; c=relaxed/simple;
	bh=2EVjPPsETt4vCu1U1tGB5XWVqwzHUIMbtBxOsfDMSR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrU3k/O//MNYgxZsjndyDvqxB0rt3RY5hXno46qOJqqYv8lfKR+Ux3XvgsYF3QWe+SjK26ixvwcCzofZfz0s+G29wrS1LgobqU1UAzWAG3Qn+w9w8ZOMcPLSkJJWS6P+lZ2NZhW1Yl8PQ9Rrbi7FS95PwotH356rW+BMJRVx1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=kBCbtzIe; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lyRqrEMsHvOhn4r28CCS8pXo1b8QifmmgOJDo10lStY=; b=kBCbtzIePp07sWdFPU39tuJNz5
	ZkoLH6fAkvgPl3oERGYn1d2jB7L2gYT2FiYaL5YFHntDSU4e1F4hZdMkDcXpKWuPJtwjO0gNqkuII
	5NDbUU4+NQyhj3GNB1nK7SqUo3alLPas7oMLh+RWV9h+J4lCjUjH0Bj4FIoe6RZm2QM5JTfW+spmq
	BJkvny+wSl27G5t3nqJTPYxS6lrHjUJoJL/vl97lRKFz1uHD0KW5OehPFgeiGeOKIMmyE+GsIztgN
	GYlrFtOzxDmVmH6PYIBJZrgzOLqbfYH15QbIRXgESntnG/WzAtbBn28SeKCRwAb210gEAAc765SJc
	Xm6f5rRw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii7-000NsM-0j;
	Fri, 19 Sep 2025 23:32:07 +0200
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
Subject: [PATCH net-next 13/20] xsk: Proxy pool management for mapped queues
Date: Fri, 19 Sep 2025 23:31:46 +0200
Message-ID: <20250919213153.103606-14-daniel@iogearbox.net>
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
 net/xdp/xsk.c              | 16 +++++++++++-----
 net/xdp/xsk.h              |  5 ++---
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 47120666d8d6..709af292cba7 100644
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
@@ -286,7 +286,7 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
 }
 
 static inline struct xsk_buff_pool *
-xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
+xsk_get_pool_from_qid(struct net_device *dev, unsigned int queue_id)
 {
 	return NULL;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cf40c70ee59f..b9efa6d8a112 100644
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
@@ -111,19 +113,20 @@ bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
 EXPORT_SYMBOL(xsk_uses_need_wakeup);
 
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
-					    u16 queue_id)
+					    unsigned int queue_id)
 {
 	if (queue_id < dev->real_num_rx_queues)
 		return dev->_rx[queue_id].pool;
 	if (queue_id < dev->real_num_tx_queues)
 		return dev->_tx[queue_id].pool;
-
 	return NULL;
 }
 EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
-void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
+void xsk_clear_pool_at_qid(struct net_device *dev, unsigned int queue_id)
 {
+	if (queue_id < dev->real_num_rx_queues)
+		__netif_get_rx_queue_peer(&dev, &queue_id);
 	if (queue_id < dev->num_rx_queues)
 		dev->_rx[queue_id].pool = NULL;
 	if (queue_id < dev->num_tx_queues)
@@ -135,7 +138,7 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
  * This might also change during run time.
  */
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
-			u16 queue_id)
+			unsigned int queue_id)
 {
 	if (queue_id >= max_t(unsigned int,
 			      dev->real_num_rx_queues,
@@ -143,6 +146,10 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 		return -EINVAL;
 	if (xsk_get_pool_from_qid(dev, queue_id))
 		return -EBUSY;
+	if (queue_id < dev->real_num_rx_queues)
+		__netif_get_rx_queue_peer(&dev, &queue_id);
+	if (xsk_get_pool_from_qid(dev, queue_id))
+		return -EBUSY;
 
 	pool->netdev = dev;
 	pool->queue_id = queue_id;
@@ -151,7 +158,6 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 		dev->_rx[queue_id].pool = pool;
 	if (queue_id < dev->real_num_tx_queues)
 		dev->_tx[queue_id].pool = pool;
-
 	return 0;
 }
 
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


