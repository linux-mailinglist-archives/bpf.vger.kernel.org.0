Return-Path: <bpf+bounces-19587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914F82EBDC
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C064B22AF9
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32C17599;
	Tue, 16 Jan 2024 09:43:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E485134DE;
	Tue, 16 Jan 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lmy3p_1705398199;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lmy3p_1705398199)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Subject: [PATCH net-next 05/17] virtio_net: move some api to header
Date: Tue, 16 Jan 2024 17:43:01 +0800
Message-Id: <20240116094313.119939-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1913ebd4ae28
Content-Transfer-Encoding: 8bit

__free_old_xmit
is_xdp_raw_buffer_queue

These two APIs are needed by the xsk part.
So this commit move theses to the header. And add prefix "virtnet_".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 86 +++------------------------------
 drivers/net/virtio/virtio_net.h | 72 +++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 98721c7b3377..89855495e693 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -45,8 +45,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG	BIT(0)
-
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
 static const unsigned long guest_offloads[] = {
@@ -149,71 +147,11 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static bool is_xdp_frame(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
-}
-
 static void *xdp_to_ptr(struct xdp_frame *ptr)
 {
 	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
 }
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
-{
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
-}
-
-static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dma_head *dma)
-{
-	int i;
-
-	if (!dma)
-		return;
-
-	for (i = 0; i < dma->next; ++i)
-		virtqueue_dma_unmap_single_attrs(sq->vq,
-						 dma->items[i].addr,
-						 dma->items[i].length,
-						 DMA_TO_DEVICE, 0);
-	dma->next = 0;
-}
-
-static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
-			    u64 *bytes, u64 *packets)
-{
-	struct virtio_dma_head *dma;
-	unsigned int len;
-	void *ptr;
-
-	if (virtqueue_get_dma_premapped(sq->vq)) {
-		dma = &sq->dma.head;
-		dma->num = ARRAY_SIZE(sq->dma.items);
-		dma->next = 0;
-	} else {
-		dma = NULL;
-	}
-
-	while ((ptr = virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NULL)) != NULL) {
-		virtnet_sq_unmap_buf(sq, dma);
-
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr;
-
-			pr_debug("Sent skb %p\n", skb);
-
-			*bytes += skb->len;
-			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
-
-			*bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		}
-		(*packets)++;
-	}
-}
-
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -664,7 +602,7 @@ static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 {
 	u64 bytes = 0, packets = 0;
 
-	__free_old_xmit(sq, in_napi, &bytes, &packets);
+	virtnet_free_old_xmit(sq, in_napi, &bytes, &packets);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -678,16 +616,6 @@ static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
-static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
-{
-	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
-		return false;
-	else if (q < vi->curr_queue_pairs)
-		return true;
-	else
-		return false;
-}
-
 static void check_sq_full_and_disable(struct virtnet_info *vi,
 				      struct net_device *dev,
 				      struct virtnet_sq *sq)
@@ -836,7 +764,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, false, &bytes, &packets);
+	virtnet_free_old_xmit(sq, false, &bytes, &packets);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -847,7 +775,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 	ret = nxmit;
 
-	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
+	if (!virtnet_is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, dev, sq);
 
 	if (flags & XDP_XMIT_FLUSH) {
@@ -1998,7 +1926,7 @@ static void virtnet_poll_cleantx(struct virtnet_rq *rq)
 	struct virtnet_sq *sq = &vi->sq[index];
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
 
-	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
+	if (!sq->napi.weight || virtnet_is_xdp_raw_buffer_queue(vi, index))
 		return;
 
 	if (__netif_tx_trylock(txq)) {
@@ -2148,7 +2076,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	int opaque;
 	bool done;
 
-	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
+	if (unlikely(virtnet_is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
 		napi_complete_done(napi, 0);
 		return 0;
@@ -4151,10 +4079,10 @@ void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
 	while ((buf = virtqueue_detach_unused_buf_dma(vq, dma)) != NULL) {
 		virtnet_sq_unmap_buf(sq, dma);
 
-		if (!is_xdp_frame(buf))
+		if (!virtnet_is_xdp_frame(buf))
 			dev_kfree_skb(buf);
 		else
-			xdp_return_frame(ptr_to_xdp(buf));
+			xdp_return_frame(virtnet_ptr_to_xdp(buf));
 	}
 }
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 02dc7650a65c..828fef40ba15 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -9,6 +9,8 @@
 #include <linux/dim.h>
 #include <net/xdp_sock_drv.h>
 
+#define VIRTIO_XDP_FLAG	BIT(0)
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -226,6 +228,76 @@ struct virtnet_info {
 	struct failover *failover;
 };
 
+static inline bool virtnet_is_xdp_frame(void *ptr)
+{
+	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
+}
+
+static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
+{
+	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
+}
+
+static inline void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dma_head *dma)
+{
+	int i;
+
+	if (!dma)
+		return;
+
+	for (i = 0; i < dma->next; ++i)
+		virtqueue_dma_unmap_single_attrs(sq->vq,
+						 dma->items[i].addr,
+						 dma->items[i].length,
+						 DMA_TO_DEVICE, 0);
+	dma->next = 0;
+}
+
+static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
+					 u64 *bytes, u64 *packets)
+{
+	struct virtio_dma_head *dma;
+	unsigned int len;
+	void *ptr;
+
+	if (virtqueue_get_dma_premapped(sq->vq)) {
+		dma = &sq->dma.head;
+		dma->num = ARRAY_SIZE(sq->dma.items);
+		dma->next = 0;
+	} else {
+		dma = NULL;
+	}
+
+	while ((ptr = virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NULL)) != NULL) {
+		virtnet_sq_unmap_buf(sq, dma);
+
+		if (!virtnet_is_xdp_frame(ptr)) {
+			struct sk_buff *skb = ptr;
+
+			pr_debug("Sent skb %p\n", skb);
+
+			*bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+		} else {
+			struct xdp_frame *frame = virtnet_ptr_to_xdp(ptr);
+
+			*bytes += xdp_get_frame_len(frame);
+			xdp_return_frame(frame);
+		}
+		(*packets)++;
+	}
+}
+
+static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
+{
+	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
+		return false;
+	else if (q < vi->curr_queue_pairs)
+		return true;
+	else
+		return false;
+}
+
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
-- 
2.32.0.3.g01195cf9f


