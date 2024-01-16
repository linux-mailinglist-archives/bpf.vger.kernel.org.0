Return-Path: <bpf+bounces-19580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12382EA92
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB20C1F241AD
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 08:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE41171C;
	Tue, 16 Jan 2024 07:59:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627812B80;
	Tue, 16 Jan 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lNYPz_1705391970;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lNYPz_1705391970)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 15:59:31 +0800
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
Subject: [PATCH net-next 5/5] virtio_net: sq support premapped mode
Date: Tue, 16 Jan 2024 15:59:24 +0800
Message-Id: <20240116075924.42798-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e56718642c76
Content-Transfer-Encoding: 8bit

If the xsk is enabling, the xsk tx will share the send queue.
But the xsk requires that the send queue use the premapped mode.
So the send queue must support premapped mode.

command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -m 00:16:3e:12:e1:3e -n 0 -p 100
machine:  ecs.ebmg6e.26xlarge of Aliyun
cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
iommu mode: intel_iommu=on iommu.strict=1 iommu=nopt

                      |        iommu off           |        iommu on
----------------------|-----------------------------------------------------
                      | 16         |  1400         | 16         | 1400
----------------------|-----------------------------------------------------
Before:               |1716796.00  |  1581829.00   | 390756.00  | 374493.00
After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 378128.00
After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 373584.00

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++++++----
 drivers/net/virtio/virtio_net.h |  10 ++-
 2 files changed, 116 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 4fbf612da235..53143f95a3a0 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dma_head *dma)
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
 static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 			    u64 *bytes, u64 *packets)
 {
+	struct virtio_dma_head *dma;
 	unsigned int len;
 	void *ptr;
 
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
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
 		if (!is_xdp_frame(ptr)) {
 			struct sk_buff *skb = ptr;
 
@@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
+static void virtnet_set_premapped(struct virtnet_info *vi)
 {
 	int i;
 
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		virtqueue_set_dma_premapped(vi->sq[i].vq);
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		virtqueue_set_dma_premapped(vi->rq[i].vq);
+		/* TODO for big mode */
+		if (vi->mergeable_rx_bufs || !vi->big_packets)
+			virtqueue_set_dma_premapped(vi->rq[i].vq);
+	}
+}
+
+static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
+{
+	struct scatterlist *sg;
+	u32 i;
+
+	for (i = 0; i < num; ++i) {
+		sg = &sq->sg[i];
+
+		virtqueue_dma_unmap_single_attrs(sq->vq,
+						 sg->dma_address,
+						 sg->length,
+						 DMA_TO_DEVICE, 0);
+	}
+}
+
+static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
+{
+	struct scatterlist *sg;
+	u32 i;
+
+	for (i = 0; i < num; ++i) {
+		sg = &sq->sg[i];
+		sg->dma_address = virtqueue_dma_map_single_attrs(sq->vq, sg_virt(sg),
+								 sg->length,
+								 DMA_TO_DEVICE, 0);
+		if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	virtnet_sq_unmap_sg(sq, i);
+	return -ENOMEM;
+}
+
+static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data)
+{
+	int ret;
+
+	if (virtqueue_get_dma_premapped(sq->vq)) {
+		ret = virtnet_sq_map_sg(sq, num);
+		if (ret)
+			return -ENOMEM;
+	}
+
+	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
+	if (ret && virtqueue_get_dma_premapped(sq->vq))
+		virtnet_sq_unmap_sg(sq, num);
+
+	return ret;
 }
 
 static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
@@ -687,8 +767,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -2154,7 +2233,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	return virtnet_add_outbuf(sq, num_sg, skb);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -4011,9 +4090,25 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct virtio_dma_head *dma;
+	struct virtnet_sq *sq;
+	int i = vq2txq(vq);
 	void *buf;
 
-	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
+	sq = &vi->sq[i];
+
+	if (virtqueue_get_dma_premapped(sq->vq)) {
+		dma = &sq->dma.head;
+		dma->num = ARRAY_SIZE(sq->dma.items);
+		dma->next = 0;
+	} else {
+		dma = NULL;
+	}
+
+	while ((buf = virtqueue_detach_unused_buf_dma(vq, dma)) != NULL) {
+		virtnet_sq_unmap_buf(sq, dma);
+
 		if (!is_xdp_frame(buf))
 			dev_kfree_skb(buf);
 		else
@@ -4228,7 +4323,7 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
+	virtnet_set_premapped(vi);
 
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 066a2b9d2b3c..dda144cc91c7 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -48,13 +48,21 @@ struct virtnet_rq_dma {
 	u16 need_sync;
 };
 
+struct virtnet_sq_dma {
+	struct virtio_dma_head head;
+	struct virtio_dma_item items[MAX_SKB_FRAGS + 2];
+};
+
 /* Internal representation of a send virtqueue */
 struct virtnet_sq {
 	/* Virtqueue associated with this virtnet_sq */
 	struct virtqueue *vq;
 
 	/* TX: fragments + linear part + virtio header */
-	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+	union {
+		struct scatterlist sg[MAX_SKB_FRAGS + 2];
+		struct virtnet_sq_dma dma;
+	};
 
 	/* Name of the send queue: output.$index */
 	char name[16];
-- 
2.32.0.3.g01195cf9f


