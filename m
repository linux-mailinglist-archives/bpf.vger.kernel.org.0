Return-Path: <bpf+bounces-43531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007119B5DC6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF51C20AFC
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F581E3DF5;
	Wed, 30 Oct 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lEIzBAlB"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2C1E3DD3;
	Wed, 30 Oct 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276718; cv=none; b=hOPiLxsYPOlyaasdU3moZ4woaBQGTW3wyInRK3Uf3SS6vNcvQIxuOF2+Dg7vzX4Mh6IpKZ4cQzP2owYCENaLA3moHMXykl6TvVdZ2ZQCgPGDWRnAWIKizOs+18EV6zTxT8U9fyHchq7G3T+p9a9U6juzSeFyR7I9M8idqEvdilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276718; c=relaxed/simple;
	bh=YNB2Wg1k8ETynbWubiv1/qoUxn4obdmHyI+cqFab6Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWtkV7hFBdZR4DGEXzx7p8dpCH7/hS4WdA3M6o2Lgis5eTdUXbiaoAzxsveOkK5kmTqETxrT6m32/DqJp5Rfbf3DqB5P+b9XmaVEiSz+dxyEakgEL59O9tfsMtC61nLc3qyyn2hMV55n/woJ5YEnnVGfsE+LmpFTeqGyPdTdTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lEIzBAlB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276705; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XxpFhJA/aT8WUBHjPzbfxiKoBijru66W3Lbmk6zjXQ4=;
	b=lEIzBAlBud620hUaEpJs186V586WnWOJZwCr/4ARuKK9hnvqqRlAftQqYiRC0MazHVFoamsShCFjPO6V4N2IjlqW6jQjjkQXWd8NfW38o9P+45aIHy5L0VY8Uvcs5Ce4+iGjXlDIm4XLVszXKvxL38fOoCz/h1I+IMQr5LyxeUE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDFbXZ_1730276704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:25:05 +0800
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
Subject: [PATCH net-next v2 11/13] virtio_net: xsk: tx: support xmit xsk buffer
Date: Wed, 30 Oct 2024 16:24:51 +0800
Message-Id: <20241030082453.97310-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 87bfcb32ef14
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
index a5bad8a5f642..4d00d73d8088 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -83,6 +83,7 @@ struct virtnet_sq_free_stats {
 	u64 bytes;
 	u64 napi_packets;
 	u64 napi_bytes;
+	u64 xsk;
 };
 
 struct virtnet_sq_stats {
@@ -514,16 +515,20 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
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
 
 /* We use the last two bits of the pointer to distinguish the xmit type. */
 #define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
 
+#define VIRTIO_XSK_FLAG_OFFSET 2
+
 static enum virtnet_xmit_type virtnet_xmit_ptr_unpack(void **ptr)
 {
 	unsigned long p = (unsigned long)*ptr;
@@ -546,6 +551,11 @@ static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
 				    GFP_ATOMIC);
 }
 
+static u32 virtnet_ptr_to_xsk_buff_len(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 {
 	sg->dma_address = addr;
@@ -586,11 +596,27 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
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
@@ -1018,7 +1044,7 @@ static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, txq, in_napi, &stats);
+	virtnet_free_old_xmit(sq, txq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -1380,6 +1406,113 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
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
+					      true, GFP_ATOMIC);
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
@@ -1393,14 +1526,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 
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
@@ -1516,8 +1654,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
-			false, &stats);
+	virtnet_free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
+			      false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -2969,7 +3107,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
-	int opaque;
+	int opaque, xsk_done = 0;
 	bool done;
 
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
@@ -2981,7 +3119,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
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
@@ -2992,6 +3134,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		netif_tx_wake_queue(txq);
 	}
 
+	if (xsk_done >= budget) {
+		__netif_tx_unlock(txq);
+		return budget;
+	}
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -5993,6 +6140,12 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
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
@@ -6002,6 +6155,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
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


