Return-Path: <bpf+bounces-32165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92179083D0
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5366C1F22E7C
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D81494A1;
	Fri, 14 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="skjVAGvk"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A51148319;
	Fri, 14 Jun 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347186; cv=none; b=Fipr5AnndxqUprnIGbAzpes9qqMfQSa/pW5sStcneMlYs7ikjDZYzORz8NgoyxnKnkRztSYURYswwMNx6KO7mQKhjkKVKumDdG3XVp9mOTS0wf7+tozL4aVdxE04YD1bMNbUsDVtbZkwjynp1t17fECjPkHhrZrEQm0Rwj8aCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347186; c=relaxed/simple;
	bh=nwexYCz1T+L2DdYqGjJCPzMa7rW6o5J+jtI8VMg43jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um1bvSGwxxcLnmwFzkuvSQjASu/Ztc9ScNLJbon7ZX2klYHOzBEM8wO7qvG1aCHVqu+ztS6bw7rbGCfXPK31aOY02JK4+zvJFjJC7+SaYMajveAc2viHzQmD+T4wZhAr29vqbOxN+maYq8mYya3hWA3y8RjiMG+YBfzdkGXPcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=skjVAGvk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347182; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A4g4giwFwkBAmjzmCqfn9xxtnXuPwka8EB6NUbkE/50=;
	b=skjVAGvkpWudBXG00Nw5JwLIRCvaC9qJ9mAyhptFCwth4X8Pej4vQg3DZ2c1i31prnsYMcap0Cdo+niPHKhjWJMkZ0F6FG4L11zm4qehE+JfSck9X8g0pdfl3HyY4KPMSgQa7goxqmX/Hfu39FlsSierSasu2HXTPy5EAsOU+gg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8Q9u9c_1718347180;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8Q9u9c_1718347180)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:41 +0800
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
Subject: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
Date: Fri, 14 Jun 2024 14:39:26 +0800
Message-Id: <20240614063933.108811-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e008fb4a0943
Content-Transfer-Encoding: 8bit

If the xsk is enabling, the xsk tx will share the send queue.
But the xsk requires that the send queue use the premapped mode.
So the send queue must support premapped mode when it is bound to
af-xdp.

* virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.

    In this mode, the driver will record the dma info when skb or xdp
    frame is sent.

    Currently, the SQ premapped mode is operational only with af-xdp. In
    this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
    the same SQ. Af-xdp independently manages its DMA. The kernel stack
    and xdp tx/redirect utilize this DMA metadata to manage the DMA
    info.

    If the indirect descriptor feature be supported, the volume of DMA
    details we need to maintain becomes quite substantial. Here, we have
    a cap on the amount of DMA info we manage.

    If the kernel stack and xdp tx/redirect attempt to use more
    descriptors, virtnet_add_outbuf() will return an -ENOMEM error. But
    the af-xdp can work continually.

* virtnet_sq_set_premapped(sq, false) is used to disable premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 228 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e84a4624549b..88ab9ea1646f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -25,6 +25,7 @@
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
+#include <uapi/linux/virtio_ring.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -276,6 +277,26 @@ struct virtnet_rq_dma {
 	u16 need_sync;
 };
 
+struct virtnet_sq_dma {
+	union {
+		struct llist_node node;
+		struct llist_head head;
+		void *data;
+	};
+	dma_addr_t addr;
+	u32 len;
+	u8 num;
+};
+
+struct virtnet_sq_dma_info {
+	/* record for kfree */
+	void *p;
+
+	u32 free_num;
+
+	struct llist_head free;
+};
+
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -295,6 +316,11 @@ struct send_queue {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	/* SQ is premapped mode or not. */
+	bool premapped;
+
+	struct virtnet_sq_dma_info dmainfo;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -492,9 +518,11 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
 	VIRTNET_XMIT_TYPE_XDP,
+	VIRTNET_XMIT_TYPE_DMA,
 };
 
-#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)
+#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP \
+				| VIRTNET_XMIT_TYPE_DMA)
 
 static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
 {
@@ -510,12 +538,180 @@ static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
 	return (void *)((unsigned long)ptr | type);
 }
 
+static void virtnet_sq_unmap(struct send_queue *sq, void **data)
+{
+	struct virtnet_sq_dma *head, *tail, *p;
+	int i;
+
+	head = *data;
+
+	p = head;
+
+	for (i = 0; i < head->num; ++i) {
+		virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->len,
+					       DMA_TO_DEVICE, 0);
+		tail = p;
+		p = llist_entry(llist_next(&p->node), struct virtnet_sq_dma, node);
+	}
+
+	*data = tail->data;
+
+	__llist_add_batch(&head->node, &tail->node,  &sq->dmainfo.free);
+
+	sq->dmainfo.free_num += head->num;
+}
+
+static void *virtnet_dma_chain_update(struct send_queue *sq,
+				      struct virtnet_sq_dma *head,
+				      struct virtnet_sq_dma *tail,
+				      u8 num, void *data)
+{
+	sq->dmainfo.free_num -= num;
+	head->num = num;
+
+	tail->data = data;
+
+	return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
+}
+
+static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, int num, void *data)
+{
+	struct virtnet_sq_dma *head = NULL, *p = NULL;
+	struct scatterlist *sg;
+	dma_addr_t addr;
+	int i, err;
+
+	if (num > sq->dmainfo.free_num)
+		return NULL;
+
+	for (i = 0; i < num; ++i) {
+		sg = &sq->sg[i];
+
+		addr = virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg),
+						    sg->offset,
+						    sg->length, DMA_TO_DEVICE,
+						    0);
+		err = virtqueue_dma_mapping_error(sq->vq, addr);
+		if (err)
+			goto err;
+
+		sg->dma_address = addr;
+
+		p = llist_entry(llist_del_first(&sq->dmainfo.free),
+				struct virtnet_sq_dma, node);
+
+		p->addr = sg->dma_address;
+		p->len = sg->length;
+
+		if (head)
+			__llist_add(&p->node, &head->head);
+		else
+			head = p;
+	}
+
+	return virtnet_dma_chain_update(sq, head, p, num, data);
+
+err:
+	if (i) {
+		virtnet_dma_chain_update(sq, head, p, i, data);
+		virtnet_sq_unmap(sq, (void **)&head);
+	}
+
+	return NULL;
+}
+
 static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
 			      enum virtnet_xmit_type type)
 {
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
-				    virtnet_xmit_ptr_mix(data, type),
-				    GFP_ATOMIC);
+	int ret;
+
+	data = virtnet_xmit_ptr_mix(data, type);
+
+	if (sq->premapped) {
+		data = virtnet_sq_map_sg(sq, num, data);
+		if (!data)
+			return -ENOMEM;
+	}
+
+	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
+	if (ret && sq->premapped) {
+		virtnet_xmit_ptr_strip(&data);
+		virtnet_sq_unmap(sq, &data);
+	}
+
+	return ret;
+}
+
+static int virtnet_sq_alloc_dma_meta(struct send_queue *sq)
+{
+	struct virtnet_sq_dma *d;
+	int num, i;
+
+	num = virtqueue_get_vring_size(sq->vq);
+
+	/* Currently, the SQ premapped mode is operational only with af-xdp. In
+	 * this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
+	 * the same SQ. Af-xdp independently manages its DMA. The kernel stack
+	 * and xdp tx/redirect utilize this DMA metadata to manage the DMA info.
+	 *
+	 * If the indirect descriptor feature be supported, the volume of DMA
+	 * details we need to maintain becomes quite substantial. Here, we have
+	 * a cap on the amount of DMA info we manage, effectively limiting it to
+	 * twice the size of the ring buffer.
+	 *
+	 * If the kernel stack and xdp tx/redirect attempt to use more
+	 * descriptors than allowed by this double ring buffer size,
+	 * virtnet_add_outbuf() will return an -ENOMEM error. But the af-xdp can
+	 * work continually.
+	 */
+	if (virtio_has_feature(sq->vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))
+		num = num * 2;
+
+	sq->dmainfo.p = kvcalloc(num, sizeof(struct virtnet_sq_dma), GFP_KERNEL);
+	if (!sq->dmainfo.p)
+		return -ENOMEM;
+
+	init_llist_head(&sq->dmainfo.free);
+
+	sq->dmainfo.free_num = num;
+
+	for (i = 0; i < num; ++i) {
+		d = sq->dmainfo.p + sizeof(struct virtnet_sq_dma) * i;
+
+		__llist_add(&d->node, &sq->dmainfo.free);
+	}
+
+	return 0;
+}
+
+static void virtnet_sq_free_dma_meta(struct send_queue *sq)
+{
+	kvfree(sq->dmainfo.p);
+
+	sq->dmainfo.p = NULL;
+	sq->dmainfo.free_num = 0;
+}
+
+/* This function must be called immediately after creating the vq, or after vq
+ * reset, and before adding any buffers to it.
+ */
+static __maybe_unused int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
+{
+	if (premapped) {
+		int r;
+
+		r = virtnet_sq_alloc_dma_meta(sq);
+
+		if (r)
+			return r;
+	} else {
+		virtnet_sq_free_dma_meta(sq);
+	}
+
+	BUG_ON(virtqueue_set_dma_premapped(sq->vq, premapped));
+
+	sq->premapped = premapped;
+	return 0;
 }
 
 static void __free_old_xmit(struct send_queue *sq, bool in_napi,
@@ -529,6 +725,7 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
+retry:
 		switch (virtnet_xmit_ptr_strip(&ptr)) {
 		case VIRTNET_XMIT_TYPE_SKB:
 			skb = ptr;
@@ -545,6 +742,16 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 			break;
+
+		case VIRTNET_XMIT_TYPE_DMA:
+			virtnet_sq_unmap(sq, &ptr);
+
+			/* For TYPE_DMA, the ptr pointed to the virtnet_sq_dma
+			 * struct. After the virtnet_sq_unmap, the ptr points to
+			 * the skb or xdp pointer | TYPE. So we call the strip
+			 * func again.
+			 */
+			goto retry;
 		}
 	}
 }
@@ -5232,6 +5439,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		__netif_napi_del(&vi->rq[i].napi);
 		__netif_napi_del(&vi->sq[i].napi);
+
+		virtnet_sq_free_dma_meta(&vi->sq[i]);
 	}
 
 	/* We called __netif_napi_del(),
@@ -5280,6 +5489,13 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct send_queue *sq;
+	int i = vq2rxq(vq);
+
+	sq = &vi->sq[i];
+
+retry:
 	switch (virtnet_xmit_ptr_strip(&buf)) {
 	case VIRTNET_XMIT_TYPE_SKB:
 		dev_kfree_skb(buf);
@@ -5288,6 +5504,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	case VIRTNET_XMIT_TYPE_XDP:
 		xdp_return_frame(buf);
 		break;
+
+	case VIRTNET_XMIT_TYPE_DMA:
+		virtnet_sq_unmap(sq, &buf);
+		goto retry;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


