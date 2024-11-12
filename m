Return-Path: <bpf+bounces-44574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A168E9C4BDD
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628EC2853B9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228B20ADF7;
	Tue, 12 Nov 2024 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VJ1py6k+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0216820ADE5;
	Tue, 12 Nov 2024 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374992; cv=none; b=TbdnJJL+V4EnpXPetzM1kzE+va48MS4WIHlQe3cGg597kGB/prCKgoPdF3TLiR9zxqia3fsDUyonkRLPqFf+lmE7wHvY7wcPnN6/nM9ZOsyd7eNqefAyRzRM61Y8L8iCpkAF/3wP9Bkjlpca8+M4lFWKGFSoxWqJPX0tSk2cAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374992; c=relaxed/simple;
	bh=nsRnayahamcVc7qCaSPryyCvf15emOHP4AAqBb8/9PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxKc7o8T7UsQ0T3n7CWgp/LQtpE7+h/rAbFXVBlzrabuPvBuTC0pJBH75UYTfsdX+yuF26/B252oMnBewWSdPKZfX1UWKwM3wOfcRQeAuD36BPne9cRsCo5JtRazGaI7CmJ4Dgj+VxtyqPU8+Au7xfp31Mq/IFxAlTZIM1YmfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VJ1py6k+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731374982; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JWft6HfMcuGu89D6wPnlIr7IK28NxAcs/7saARORgwY=;
	b=VJ1py6k+Q8JKeF/rYsql6q0xyGSG/9WmU9ceodgtKK6C8PL3PpHqBK6zrSudmPOws2c5kKmqoznX+XNpX5mibFCWseVKAlMBd4X+2ssIdSbBxdXHKpk/zzaRmly07hzQda76yWCjUJH7yUMC411NGUQJW9EQzHVw47Ztg5s44E0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJF2Wv8_1731374980 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:29:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v4 11/13] virtio_net: xsk: tx: support xmit xsk buffer
Date: Tue, 12 Nov 2024 09:29:26 +0800
Message-Id: <20241112012928.102478-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
References: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ee9bd377a389
Content-Transfer-Encoding: 8bit

The driver's tx napi is very important for XSK. It is responsible for
obtaining data from the XSK queue and sending it out.

At the beginning, we need to trigger tx napi.

virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 179 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 168 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d5b8567f77d0..57642bd83b7b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -83,6 +83,7 @@ struct virtnet_sq_free_stats {
 	u64 bytes;
 	u64 napi_packets;
 	u64 napi_bytes;
+	u64 xsk;
 };
 
 struct virtnet_sq_stats {
@@ -512,11 +513,13 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
+static void virtnet_xsk_completed(struct send_queue *sq, int num);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
 	VIRTNET_XMIT_TYPE_SKB_ORPHAN,
 	VIRTNET_XMIT_TYPE_XDP,
+	VIRTNET_XMIT_TYPE_XSK,
 };
 
 static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
@@ -541,6 +544,8 @@ static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
 /* We use the last two bits of the pointer to distinguish the xmit type. */
 #define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
 
+#define VIRTIO_XSK_FLAG_OFFSET 2
+
 static enum virtnet_xmit_type virtnet_xmit_ptr_unpack(void **ptr)
 {
 	unsigned long p = (unsigned long)*ptr;
@@ -563,6 +568,11 @@ static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
 				    GFP_ATOMIC);
 }
 
+static u32 virtnet_ptr_to_xsk_buff_len(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 {
 	sg_dma_address(sg) = addr;
@@ -603,11 +613,27 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 			break;
+
+		case VIRTNET_XMIT_TYPE_XSK:
+			stats->bytes += virtnet_ptr_to_xsk_buff_len(ptr);
+			stats->xsk++;
+			break;
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
@@ -1037,7 +1063,7 @@ static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, txq, in_napi, &stats);
+	virtnet_free_old_xmit(sq, txq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -1399,6 +1425,113 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 	return err;
 }
 
+static void *virtnet_xsk_to_ptr(u32 len)
+{
+	unsigned long p;
+
+	p = len << VIRTIO_XSK_FLAG_OFFSET;
+
+	return virtnet_xmit_ptr_pack((void *)p, VIRTNET_XMIT_TYPE_XSK);
+}
+
+static int virtnet_xsk_xmit_one(struct send_queue *sq,
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
+	sg_fill_dma(sq->sg, sq->xsk_hdr_dma_addr, vi->hdr_len);
+	sg_fill_dma(sq->sg + 1, addr, desc->len);
+
+	return virtqueue_add_outbuf_premapped(sq->vq, sq->sg, 2,
+					      virtnet_xsk_to_ptr(desc->len),
+					      GFP_ATOMIC);
+}
+
+static int virtnet_xsk_xmit_batch(struct send_queue *sq,
+				  struct xsk_buff_pool *pool,
+				  unsigned int budget,
+				  u64 *kicks)
+{
+	struct xdp_desc *descs = pool->tx_descs;
+	bool kick = false;
+	u32 nb_pkts, i;
+	int err;
+
+	budget = min_t(u32, budget, sq->vq->num_free);
+
+	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!nb_pkts)
+		return 0;
+
+	for (i = 0; i < nb_pkts; i++) {
+		err = virtnet_xsk_xmit_one(sq, pool, &descs[i]);
+		if (unlikely(err)) {
+			xsk_tx_completed(sq->xsk_pool, nb_pkts - i);
+			break;
+		}
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
+static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
+			     int budget)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct virtnet_sq_free_stats stats = {};
+	struct net_device *dev = vi->dev;
+	u64 kicks = 0;
+	int sent;
+
+	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
+	 * free_old_xmit().
+	 */
+	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true, &stats);
+
+	if (stats.xsk)
+		xsk_tx_completed(sq->xsk_pool, stats.xsk);
+
+	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
+
+	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
+		check_sq_full_and_disable(vi, vi->dev, sq);
+
+	u64_stats_update_begin(&sq->stats.syncp);
+	u64_stats_add(&sq->stats.packets, stats.packets);
+	u64_stats_add(&sq->stats.bytes,   stats.bytes);
+	u64_stats_add(&sq->stats.kicks,   kicks);
+	u64_stats_add(&sq->stats.xdp_tx,  sent);
+	u64_stats_update_end(&sq->stats.syncp);
+
+	if (xsk_uses_need_wakeup(pool))
+		xsk_set_tx_need_wakeup(pool);
+
+	return sent;
+}
+
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
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -1412,14 +1545,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 
 	sq = &vi->sq[qid];
 
-	if (napi_if_scheduled_mark_missed(&sq->napi))
-		return 0;
+	xsk_wakeup(sq);
+	return 0;
+}
 
-	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
-	local_bh_enable();
+static void virtnet_xsk_completed(struct send_queue *sq, int num)
+{
+	xsk_tx_completed(sq->xsk_pool, num);
 
-	return 0;
+	/* If this is called by rx poll, start_xmit and xdp xmit we should
+	 * wakeup the tx napi to consume the xsk tx queue, because the tx
+	 * interrupt may not be triggered.
+	 */
+	xsk_wakeup(sq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
@@ -1535,8 +1673,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
-			false, &stats);
+	virtnet_free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
+			      false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -2993,7 +3131,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
-	int opaque;
+	int opaque, xsk_done = 0;
 	bool done;
 
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
@@ -3005,7 +3143,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, txq, !!budget);
+
+	if (sq->xsk_pool)
+		xsk_done = virtnet_xsk_xmit(sq, sq->xsk_pool, budget);
+	else
+		free_old_xmit(sq, txq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
@@ -3016,6 +3158,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		netif_tx_wake_queue(txq);
 	}
 
+	if (xsk_done >= budget) {
+		__netif_tx_unlock(txq);
+		return budget;
+	}
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -6058,6 +6205,12 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct send_queue *sq;
+	int i = vq2rxq(vq);
+
+	sq = &vi->sq[i];
+
 	switch (virtnet_xmit_ptr_unpack(&buf)) {
 	case VIRTNET_XMIT_TYPE_SKB:
 	case VIRTNET_XMIT_TYPE_SKB_ORPHAN:
@@ -6067,6 +6220,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	case VIRTNET_XMIT_TYPE_XDP:
 		xdp_return_frame(buf);
 		break;
+
+	case VIRTNET_XMIT_TYPE_XSK:
+		xsk_tx_completed(sq->xsk_pool, 1);
+		break;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


