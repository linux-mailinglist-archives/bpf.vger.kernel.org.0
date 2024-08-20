Return-Path: <bpf+bounces-37604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A47957FD9
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E58DB20F8A
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8518A924;
	Tue, 20 Aug 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H2bT8Nfh"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACE156F33;
	Tue, 20 Aug 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139228; cv=none; b=DZaeyIj0Susg5RtpL5kndG6a3hnpAhAw/9A1nl0ei3cfpju8brq7j6NSqko7q4EZYiAAw1ZOlZPq+lEbK1HlAfBWEGmEBbaiUEpsKplwcmIFxxaZG9JgRFA5eDjZ+UgsIxoH3yP/F8l5hKjjlzOx8XjLAojOgJEeCY3gW3UJFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139228; c=relaxed/simple;
	bh=M6kwsTHS+uQgxs/uqaSkev6WFceikCrJOKKiloKcWwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEgoDSot5EdWkd2WCV5AycuCOg5O8WM9S8WfPRp6YM4ZRcZGlPwOhOdyJvLcqfqjq2b6FaqcXjEAKl44KqRZJbWYTOAscMkyZv6EUUGZRlk1SrB+0Hwz+9cg7hR5/Ii3F2b9GyN/mJC4/dXXsHBPXo3msdXrA+AwjIcWcn+9Gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H2bT8Nfh; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724139222; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZExTvOhqCq3J24b8httOlAb0YX94uLV/skP9PfTF4qw=;
	b=H2bT8NfhfjBgL8kG/NDJklDz6KbidNh+i2dBzlYf7Gp3tqeuQ7YeAs4ztA4IsRnnLsBUiH79XbT423M/DhYGypnVKX9S4YLAhd/i+okEcGBRI/U3tHimbj9kxitFy9rEhgJ4S64W5blHlMcFHIC+qxe8Y6Nt9LwxyMUoYCJOtyY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHmKrR_1724139221)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:33:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 11/13] virtio_net: xsk: tx: handle the transmitted xsk buffer
Date: Tue, 20 Aug 2024 15:33:28 +0800
Message-Id: <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b206d29d23af
Content-Transfer-Encoding: 8bit

virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 85 ++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3743694d3c3b..a898568bed5c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -83,6 +83,7 @@ struct virtnet_sq_free_stats {
 	u64 bytes;
 	u64 napi_packets;
 	u64 napi_bytes;
+	u64 xsk;
 };
 
 struct virtnet_sq_stats {
@@ -511,6 +512,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
+static void virtnet_xsk_completed(struct send_queue *sq, int num);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -595,12 +597,24 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 
 		case VIRTNET_XMIT_TYPE_XSK:
 			stats->bytes += virtnet_ptr_to_xsk(ptr);
+			stats->xsk++;
 			break;
 		}
 	}
 	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
 }
 
+static void virtnet_free_old_xmit(struct send_queue *sq,
+				  struct netdev_queue *txq,
+				  bool in_napi,
+				  struct virtnet_sq_free_stats *stats)
+{
+	__free_old_xmit(sq, txq, in_napi, stats);
+
+	if (stats->xsk)
+		virtnet_xsk_completed(sq, stats->xsk);
+}
+
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -1021,7 +1035,7 @@ static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, txq, in_napi, &stats);
+	virtnet_free_old_xmit(sq, txq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -1382,29 +1396,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 	return err;
 }
 
-static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
-{
-	struct virtnet_info *vi = netdev_priv(dev);
-	struct send_queue *sq;
-
-	if (!netif_running(dev))
-		return -ENETDOWN;
-
-	if (qid >= vi->curr_queue_pairs)
-		return -EINVAL;
-
-	sq = &vi->sq[qid];
-
-	if (napi_if_scheduled_mark_missed(&sq->napi))
-		return 0;
-
-	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
-	local_bh_enable();
-
-	return 0;
-}
-
 static void *virtnet_xsk_to_ptr(u32 len)
 {
 	unsigned long p;
@@ -1476,8 +1467,12 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64 kicks = 0;
 	int sent;
 
+	/* Avoid to wakeup napi meanless, so call __free_old_xmit. */
 	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true, &stats);
 
+	if (stats.xsk)
+		xsk_tx_completed(sq->xsk_pool, stats.xsk);
+
 	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
 
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
@@ -1496,6 +1491,44 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+static void xsk_wakeup(struct send_queue *sq)
+{
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return;
+
+	local_bh_disable();
+	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	local_bh_enable();
+}
+
+static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct send_queue *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	xsk_wakeup(sq);
+	return 0;
+}
+
+static void virtnet_xsk_completed(struct send_queue *sq, int num)
+{
+	xsk_tx_completed(sq->xsk_pool, num);
+
+	/* If this is called by rx poll, start_xmit and xdp xmit we should
+	 * wakeup the tx napi to consume the xsk tx queue, because the tx
+	 * interrupt may not be triggered.
+	 */
+	xsk_wakeup(sq);
+}
+
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 				   struct send_queue *sq,
 				   struct xdp_frame *xdpf)
@@ -1609,8 +1642,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
-			false, &stats);
+	virtnet_free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
+			      false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
-- 
2.32.0.3.g01195cf9f


