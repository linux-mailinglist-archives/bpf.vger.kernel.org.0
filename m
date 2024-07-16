Return-Path: <bpf+bounces-34886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA19320A2
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F8B1C217B5
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 06:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9684D8CE;
	Tue, 16 Jul 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P4Fjb691"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10C2B9D5;
	Tue, 16 Jul 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112404; cv=none; b=K+fx5tuMQi20hM8u6S5u356S7ldmpPhF82eWV0Nc4lsfLLdBmn7IYiep588rzim4fJ1yTwYg4iLwxW5BHbJrT5YvZaQlzlR8wZAB+DX91zPRElT9ixIv4GrYUZoL8K6uLpQ2L+X9t1BZSvK+6KPxl4sHgPs+RICsJaq9B1FKZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112404; c=relaxed/simple;
	bh=LxKuw0uCH49bAqxSfx4VzJGtE241kl3zNRWIf+bKVoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTj/dXRLTQJgYYIj+UTvYXwoOExA7SYMtIgE7QHE6o72H0qC13YP+0sj85US6ypc8XWjh9Rayq+tLxm55MwlVPhrgRUTMGefmv8crvmvs3rcaAC0z/8Z4R5crxWuZ61yvBvJLs9dphuDSVZa5/RE/NmWzMa//84PpkTmphPfDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P4Fjb691; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112398; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XJ1kQ9AtwPR4PEpH0rQY+1wHnE8KtT4cn7MzYqVKQ2Q=;
	b=P4Fjb691ve2ZiZNt1FvfmeJjQu2eaUAV8auWhAPyq11UvBqk6B+PSO1LAPt5aXGkoYHRV3SuCjdFcHzW+aZPi6bzyzyblDPULkfuOe7llPzqcTSAx3RunLDYm3ks+FsxBx/zsrHF11cxvAvdSlE5GuoRuiYc9OQBZVl2RGpL3jQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WAgTJhp_1721112397;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAgTJhp_1721112397)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:38 +0800
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
Subject: [RFC net-next 10/13] virtio_net: xsk: tx: support xmit xsk buffer
Date: Tue, 16 Jul 2024 14:46:25 +0800
Message-Id: <20240716064628.1950-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: d3e48bf059c8
Content-Transfer-Encoding: 8bit

The driver's tx napi is very important for XSK. It is responsible for
obtaining data from the XSK queue and sending it out.

At the beginning, we need to trigger tx napi.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 127 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b02fc118b0b8..ce8ac9239158 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -516,10 +516,13 @@ enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
 	VIRTNET_XMIT_TYPE_ORPHAN,
 	VIRTNET_XMIT_TYPE_XDP,
+	VIRTNET_XMIT_TYPE_XSK,
 };
 
 #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_ORPHAN \
-				| VIRTNET_XMIT_TYPE_XDP)
+				| VIRTNET_XMIT_TYPE_XDP | VIRTNET_XMIT_TYPE_XSK)
+
+#define VIRTIO_XSK_FLAG_OFFSET 4
 
 static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
 {
@@ -543,6 +546,11 @@ static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
 				    GFP_ATOMIC);
 }
 
+static u32 virtnet_ptr_to_xsk(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 {
 	sg_assign_page(sg, NULL);
@@ -584,6 +592,10 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 			break;
+
+		case VIRTNET_XMIT_TYPE_XSK:
+			stats->bytes += virtnet_ptr_to_xsk(ptr);
+			break;
 		}
 	}
 	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
@@ -1393,6 +1405,97 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	return 0;
 }
 
+static void *virtnet_xsk_to_ptr(u32 len)
+{
+	unsigned long p;
+
+	p = len << VIRTIO_XSK_FLAG_OFFSET;
+
+	return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XSK);
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
+
+	sg_fill_dma(sq->sg, sq->xsk_hdr_dma_addr, vi->hdr_len);
+	sg_fill_dma(sq->sg + 1, addr, desc->len);
+
+	return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
+				    virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
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
+	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true, &stats);
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
+	return sent == budget;
+}
+
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 				   struct send_queue *sq,
 				   struct xdp_frame *xdpf)
@@ -2921,6 +3024,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	bool xsk_busy = false;
 	int opaque;
 	bool done;
 
@@ -2933,7 +3037,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, txq, !!budget);
+
+	if (sq->xsk_pool)
+		xsk_busy = virtnet_xsk_xmit(sq, sq->xsk_pool, budget);
+	else
+		free_old_xmit(sq, txq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
@@ -2944,6 +3052,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		netif_tx_wake_queue(txq);
 	}
 
+	if (xsk_busy) {
+		__netif_tx_unlock(txq);
+		return budget;
+	}
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -5945,6 +6058,12 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct send_queue *sq;
+	int i = vq2rxq(vq);
+
+	sq = &vi->sq[i];
+
 	switch (virtnet_xmit_ptr_strip(&buf)) {
 	case VIRTNET_XMIT_TYPE_SKB:
 	case VIRTNET_XMIT_TYPE_ORPHAN:
@@ -5954,6 +6073,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
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


