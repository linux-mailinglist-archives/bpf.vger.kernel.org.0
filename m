Return-Path: <bpf+bounces-19588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A4A82EBDE
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBFB284643
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27518056;
	Tue, 16 Jan 2024 09:43:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1813ADE;
	Tue, 16 Jan 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lmy4e_1705398200;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lmy4e_1705398200)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:20 +0800
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
Subject: [PATCH net-next 06/17] virtio_net: xsk: tx: support xmit xsk buffer
Date: Tue, 16 Jan 2024 17:43:02 +0800
Message-Id: <20240116094313.119939-7-xuanzhuo@linux.alibaba.com>
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

The driver's tx napi is very important for XSK. It is responsible for
obtaining data from the XSK queue and sending it out.

At the beginning, we need to trigger tx napi.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 22 ++++++---
 drivers/net/virtio/virtio_net.h |  4 ++
 drivers/net/virtio/xsk.c        | 87 +++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        | 13 +++++
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 89855495e693..4575c885acb0 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -616,9 +616,9 @@ static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
-static void check_sq_full_and_disable(struct virtnet_info *vi,
-				      struct net_device *dev,
-				      struct virtnet_sq *sq)
+void virtnet_check_sq_full_and_disable(struct virtnet_info *vi,
+				       struct net_device *dev,
+				       struct virtnet_sq *sq)
 {
 	bool use_napi = sq->napi.weight;
 	int qnum;
@@ -776,7 +776,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	ret = nxmit;
 
 	if (!virtnet_is_xdp_raw_buffer_queue(vi, sq - vi->sq))
-		check_sq_full_and_disable(vi, dev, sq);
+		virtnet_check_sq_full_and_disable(vi, dev, sq);
 
 	if (flags & XDP_XMIT_FLUSH) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
@@ -2073,6 +2073,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	bool xsk_busy = false;
 	int opaque;
 	bool done;
 
@@ -2085,11 +2086,20 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, true);
+
+	if (sq->xsk.pool)
+		xsk_busy = virtnet_xsk_xmit(sq, sq->xsk.pool, budget);
+	else
+		free_old_xmit(sq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
 
+	if (xsk_busy) {
+		__netif_tx_unlock(txq);
+		return budget;
+	}
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -2204,7 +2214,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset_ct(skb);
 	}
 
-	check_sq_full_and_disable(vi, dev, sq);
+	virtnet_check_sq_full_and_disable(vi, dev, sq);
 
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 828fef40ba15..cc735a09a3d9 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -10,6 +10,7 @@
 #include <net/xdp_sock_drv.h>
 
 #define VIRTIO_XDP_FLAG	BIT(0)
+#define VIRTIO_XSK_FLAG	BIT(1)
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
@@ -304,4 +305,7 @@ void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_sq_free_unused_bufs(struct virtqueue *vq);
 void virtnet_rq_free_unused_bufs(struct virtqueue *vq);
+void virtnet_check_sq_full_and_disable(struct virtnet_info *vi,
+				       struct net_device *dev,
+				       struct virtnet_sq *sq);
 #endif
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 613a6c63d47c..d2a96424ade9 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -8,6 +8,93 @@
 
 static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
+static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
+				struct xsk_buff_pool *pool,
+				struct xdp_desc *desc)
+{
+	struct virtnet_info *vi;
+	dma_addr_t addr;
+
+	vi = sq->vq->vdev->priv;
+
+	addr = xsk_buff_raw_get_dma(pool, desc->addr);
+	xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
+
+	sg_init_table(sq->sg, 2);
+
+	sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
+	sg_fill_dma(sq->sg + 1, addr, desc->len);
+
+	return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
+				    virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
+}
+
+static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
+				  struct xsk_buff_pool *pool,
+				  unsigned int budget,
+				  u64 *kicks)
+{
+	struct xdp_desc *descs = pool->tx_descs;
+	u32 nb_pkts, max_pkts, i;
+	bool kick = false;
+	int err;
+
+	/* Every xsk tx packet needs two desc(virtnet header and packet). So we
+	 * use sq->vq->num_free / 2 as the limitation.
+	 */
+	max_pkts = min_t(u32, budget, sq->vq->num_free / 2);
+
+	nb_pkts = xsk_tx_peek_release_desc_batch(pool, max_pkts);
+	if (!nb_pkts)
+		return 0;
+
+	for (i = 0; i < nb_pkts; i++) {
+		err = virtnet_xsk_xmit_one(sq, pool, &descs[i]);
+		if (unlikely(err))
+			break;
+
+		kick = true;
+	}
+
+	if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
+		(*kicks)++;
+
+	return i;
+}
+
+bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
+		      int budget)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	u64 bytes = 0, packets = 0, kicks = 0;
+	int sent;
+
+	virtnet_free_old_xmit(sq, true, &bytes, &packets);
+
+	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
+
+	if (!virtnet_is_xdp_raw_buffer_queue(vi, sq - vi->sq))
+		virtnet_check_sq_full_and_disable(vi, vi->dev, sq);
+
+	u64_stats_update_begin(&sq->stats.syncp);
+	u64_stats_add(&sq->stats.packets, packets);
+	u64_stats_add(&sq->stats.bytes,   bytes);
+	u64_stats_add(&sq->stats.kicks,   kicks);
+	u64_stats_add(&sq->stats.xdp_tx,  sent);
+	u64_stats_update_end(&sq->stats.syncp);
+
+	if (xsk_uses_need_wakeup(pool))
+		xsk_set_tx_need_wakeup(pool);
+
+	return sent == budget;
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
 				    struct xsk_buff_pool *pool)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 1918285c310c..73ca8cd5308b 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -3,5 +3,18 @@
 #ifndef __XSK_H__
 #define __XSK_H__
 
+#define VIRTIO_XSK_FLAG_OFFSET	4
+
+static inline void *virtnet_xsk_to_ptr(u32 len)
+{
+	unsigned long p;
+
+	p = len << VIRTIO_XSK_FLAG_OFFSET;
+
+	return (void *)(p | VIRTIO_XSK_FLAG);
+}
+
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
+bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
+		      int budget);
 #endif
-- 
2.32.0.3.g01195cf9f


