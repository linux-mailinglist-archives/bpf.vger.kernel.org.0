Return-Path: <bpf+bounces-31828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C5C903AE5
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E746B2881C7
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6BA180A78;
	Tue, 11 Jun 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hNCF2CcM"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95F1802A1;
	Tue, 11 Jun 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106124; cv=none; b=Nf1hb2gzTu4r6gvQkaOwZPZ8LXbtNFzJn7vlQZHQUBQ9gWjEpoZkSu5Owr0X+f/rkNpxhLPuGg+/m3rtAGydAgP7Res8ZQDFzZ8ut3UP6xBmLTMIeW9uZ6dYK7bEEyiOa9+hvJT9avq0Z3VeNFUciAm6wplzXGgiWLFJxcoFq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106124; c=relaxed/simple;
	bh=d0C+8sFJdySZN3/rg58bJGJ8xaxONsOIF/0LbCwWDyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JH+eQjCQz3l0cHZToeMGH23i0mdswhO5cCUBJgycOhOicj6f7HNu5hRCvxUCDDZeR55O9BeuZ8BDRCWI2wZrBYdMv4rwyUEROkQVCV23Ime/j8JA7AM/mUoC0z2JxJuvtJ7zTaf8zRrgiphnPt8QzImRu8ldAFonnWztts4J+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hNCF2CcM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106120; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CGO7KoNZ7yppJO+9bMk8619rD2G3NVAn/MKFx4IOnB0=;
	b=hNCF2CcMtsr0jW5cb6/x6LVcmtMmN8IytQ/igR2149y6gdg8DlbJ8kDiMFPAANijUi0u0WNCb3PzRb+g+IYUqRaatDx4/RKpYcn1YXEZ4TzAK0uRqzAQOuKxk5CBixV+H3uALxDhK+qnDGHxLvFNU13qsQYgKCqaMqK6tj98eWE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GFQp-_1718106119;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GFQp-_1718106119)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:59 +0800
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
Subject: [PATCH net-next v4 11/15] virtio_net: xsk: tx: support xmit xsk buffer
Date: Tue, 11 Jun 2024 19:41:43 +0800
Message-Id: <20240611114147.31320-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: c1658a8c15b0
Content-Transfer-Encoding: 8bit

The driver's tx napi is very important for XSK. It is responsible for
obtaining data from the XSK queue and sending it out.

At the beginning, we need to trigger tx napi.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 113 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 17cbb6a94373..4624a9fde89a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -534,10 +534,13 @@ enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
 	VIRTNET_XMIT_TYPE_XDP,
 	VIRTNET_XMIT_TYPE_DMA,
+	VIRTNET_XMIT_TYPE_XSK,
 };
 
 #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP \
-				| VIRTNET_XMIT_TYPE_DMA)
+				| VIRTNET_XMIT_TYPE_DMA | VIRTNET_XMIT_TYPE_XSK)
+
+#define VIRTIO_XSK_FLAG_OFFSET 4
 
 static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
 {
@@ -1256,6 +1259,102 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
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
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
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
+	sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
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
+			xsk_tx_completed(sq->xsk.pool, nb_pkts - i);
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
+	u64 kicks = 0;
+	int sent;
+
+	__free_old_xmit(sq, true, &stats);
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
@@ -2698,6 +2797,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	bool xsk_busy = false;
 	int opaque;
 	bool done;
 
@@ -2710,7 +2810,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, true);
+
+	if (sq->xsk.pool)
+		xsk_busy = virtnet_xsk_xmit(sq, sq->xsk.pool, budget);
+	else
+		free_old_xmit(sq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
@@ -2721,6 +2825,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		netif_tx_wake_queue(txq);
 	}
 
+	if (xsk_busy) {
+		__netif_tx_unlock(txq);
+		return budget;
+	}
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
-- 
2.32.0.3.g01195cf9f


