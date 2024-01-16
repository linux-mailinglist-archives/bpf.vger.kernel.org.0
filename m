Return-Path: <bpf+bounces-19589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE982EBE4
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505222847A3
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1591AAAD;
	Tue, 16 Jan 2024 09:43:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCB175B3;
	Tue, 16 Jan 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lk6W-_1705398202;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lk6W-_1705398202)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:23 +0800
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
Subject: [PATCH net-next 08/17] virtio_net: xsk: tx: handle the transmitted xsk buffer
Date: Tue, 16 Jan 2024 17:43:04 +0800
Message-Id: <20240116094313.119939-9-xuanzhuo@linux.alibaba.com>
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

virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtio_net.h | 30 ++++++++++++++++++++++++++----
 drivers/net/virtio/xsk.c        | 33 ++++++++++++++++++++++++++-------
 drivers/net/virtio/xsk.h        |  5 +++++
 3 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index c30fb152ecd0..480b533bd61e 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -229,6 +229,11 @@ struct virtnet_info {
 	struct failover *failover;
 };
 
+static inline bool virtnet_is_skb_ptr(void *ptr)
+{
+	return !((unsigned long)ptr & (VIRTIO_XDP_FLAG | VIRTIO_XSK_FLAG));
+}
+
 static inline bool virtnet_is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -239,6 +244,9 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static inline u32 virtnet_ptr_to_xsk(void *ptr);
+void virtnet_xsk_completed(struct virtnet_sq *sq, int num);
+
 static inline void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dma_head *dma)
 {
 	int i;
@@ -254,8 +262,8 @@ static inline void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dma
 	dma->next = 0;
 }
 
-static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
-					 u64 *bytes, u64 *packets)
+static inline void __virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
+					   u64 *bytes, u64 *packets, u64 *xsk)
 {
 	struct virtio_dma_head *dma;
 	unsigned int len;
@@ -272,23 +280,37 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 	while ((ptr = virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NULL)) != NULL) {
 		virtnet_sq_unmap_buf(sq, dma);
 
-		if (!virtnet_is_xdp_frame(ptr)) {
+		if (virtnet_is_skb_ptr(ptr)) {
 			struct sk_buff *skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
 
 			*bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
+		} else if (virtnet_is_xdp_frame(ptr)) {
 			struct xdp_frame *frame = virtnet_ptr_to_xdp(ptr);
 
 			*bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+		} else {
+			*bytes += virtnet_ptr_to_xsk(ptr);
+			(*xsk)++;
 		}
 		(*packets)++;
 	}
 }
 
+static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
+					 u64 *bytes, u64 *packets)
+{
+	u64 xsknum = 0;
+
+	__virtnet_free_old_xmit(sq, in_napi, bytes, packets, &xsknum);
+
+	if (xsknum)
+		virtnet_xsk_completed(sq, xsknum);
+}
+
 static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 {
 	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 9e5523ff5707..0c6a8f92ae38 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -73,9 +73,13 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	u64 bytes = 0, packets = 0, kicks = 0;
+	u64 xsknum = 0;
 	int sent;
 
-	virtnet_free_old_xmit(sq, true, &bytes, &packets);
+	/* Avoid to wakeup napi meanless, so call __virtnet_free_old_xmit. */
+	__virtnet_free_old_xmit(sq, true, &bytes, &packets, &xsknum);
+	if (xsknum)
+		xsk_tx_completed(sq->xsk.pool, xsknum);
 
 	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
 
@@ -95,6 +99,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+static void xsk_wakeup(struct virtnet_sq *sq)
+{
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return;
+
+	local_bh_disable();
+	virtnet_vq_napi_schedule(&sq->napi, sq->vq);
+	local_bh_enable();
+}
+
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -108,14 +122,19 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 
 	sq = &vi->sq[qid];
 
-	if (napi_if_scheduled_mark_missed(&sq->napi))
-		return 0;
+	xsk_wakeup(sq);
+	return 0;
+}
 
-	local_bh_disable();
-	virtnet_vq_napi_schedule(&sq->napi, sq->vq);
-	local_bh_enable();
+void virtnet_xsk_completed(struct virtnet_sq *sq, int num)
+{
+	xsk_tx_completed(sq->xsk.pool, num);
 
-	return 0;
+	/* If this is called by rx poll, start_xmit and xdp xmit we should
+	 * wakeup the tx napi to consume the xsk tx queue, because the tx
+	 * interrupt may not be triggered.
+	 */
+	xsk_wakeup(sq);
 }
 
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 1bd19dcda649..7ebc9bda7aee 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
 	return (void *)(p | VIRTIO_XSK_FLAG);
 }
 
+static inline u32 virtnet_ptr_to_xsk(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
-- 
2.32.0.3.g01195cf9f


