Return-Path: <bpf+bounces-31833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA087903AF4
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7981C23DE7
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168F18133E;
	Tue, 11 Jun 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pZI3CQox"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E211180A80;
	Tue, 11 Jun 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106127; cv=none; b=VKdy/dJ1bhTIKmsDhI5IZG7Kd8ePAfSizu9+TLaglgAiaGWUqpU1g9Njw6q+6UbjxTOZWssGR8GH8n2eC1dBxXbmKqXbBwD+gc++aKwe1qZ0EzwVwsZB2eC8n/M0cgZQsaOwNRTaXfo9vgt5HM4mYYNqwzXyo86iPhkkFRWRIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106127; c=relaxed/simple;
	bh=RqImoD+xL236y290QPS0Vb4jqIKjfpmraqkUF1nUwOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUb/2yvI4l+3dm5YV2k/TAMbIWeDvtVXTwcR0FD85IwmV6FISK+a/1hBC/0R8xvGHK1EaFYLZ057D4/81qVrIp2api/1PzY5bIIQQxTSiaT1XuZYCf7pTgiAtXv7+6YpJPajlFldVxcaQWZz81/AhMcdF9E1pHCMJLr1lefzYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pZI3CQox; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106118; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LwUP05yp3DNH+jcQr1J24v4wu/2zWqslRs08bo7xQP8=;
	b=pZI3CQox5yUIsDIRb03/9qmlPGPVhgdVJ4THDZD/sl46e12ovtpoOPspcsfs2ak2m/Xr73qy9uPF1pD06N2M77pcjQMLULASmBLVHZuuSF0j4qXc1AT77Dz0CsqGFG0jdFc7jcefjI1v5VtUtdti6wMJd+5m/ydJkjSmiUjooaw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GJ89V_1718106116;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GJ89V_1718106116)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:56 +0800
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
Subject: [PATCH net-next v4 08/15] virtio_net: sq support premapped mode
Date: Tue, 11 Jun 2024 19:41:40 +0800
Message-Id: <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
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
 drivers/net/virtio_net.c | 219 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e84a4624549b..4968ab7eb5a4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -25,6 +25,7 @@
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
+#include <uapi/linux/virtio_ring.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -276,6 +277,25 @@ struct virtnet_rq_dma {
 	u16 need_sync;
 };
 
+struct virtnet_sq_dma {
+	union {
+		struct virtnet_sq_dma *next;
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
+	struct virtnet_sq_dma *free;
+};
+
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -295,6 +315,11 @@ struct send_queue {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	/* SQ is premapped mode or not. */
+	bool premapped;
+
+	struct virtnet_sq_dma_info dmainfo;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -492,9 +517,11 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
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
@@ -510,12 +537,178 @@ static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
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
+		p = p->next;
+	}
+
+	*data = tail->data;
+
+	tail->next = sq->dmainfo.free;
+	sq->dmainfo.free = head;
+	sq->dmainfo.free_num += head->num;
+}
+
+static void *virtnet_dma_chain_update(struct send_queue *sq,
+				      struct virtnet_sq_dma *head,
+				      struct virtnet_sq_dma *tail,
+				      u8 num, void *data)
+{
+	sq->dmainfo.free = tail->next;
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
+	struct virtnet_sq_dma *head, *tail, *p;
+	struct scatterlist *sg;
+	dma_addr_t addr;
+	int i, err;
+
+	if (num > sq->dmainfo.free_num)
+		return NULL;
+
+	head = sq->dmainfo.free;
+	p = head;
+
+	tail = NULL;
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
+		tail = p;
+		tail->addr = sg->dma_address;
+		tail->len = sg->length;
+
+		p = p->next;
+	}
+
+	return virtnet_dma_chain_update(sq, head, tail, num, data);
+
+err:
+	if (tail) {
+		virtnet_dma_chain_update(sq, head, tail, i, data);
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
+	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);
+	if (!sq->dmainfo.free)
+		return -ENOMEM;
+
+	sq->dmainfo.p = sq->dmainfo.free;
+	sq->dmainfo.free_num = num;
+
+	for (i = 0; i < num; ++i) {
+		d = &sq->dmainfo.free[i];
+		d->next = d + 1;
+	}
+
+	d->next = NULL;
+
+	return 0;
+}
+
+static void virtnet_sq_free_dma_meta(struct send_queue *sq)
+{
+	kfree(sq->dmainfo.p);
+
+	sq->dmainfo.p = NULL;
+	sq->dmainfo.free = NULL;
+	sq->dmainfo.free_num = 0;
+}
+
+/* This function must be called immediately after creating the vq, or after vq
+ * reset, and before adding any buffers to it.
+ */
+static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
+{
+	if (premapped) {
+		if (virtnet_sq_alloc_dma_meta(sq))
+			return -ENOMEM;
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
@@ -529,6 +722,7 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
+retry:
 		switch (virtnet_xmit_ptr_strip(&ptr)) {
 		case VIRTNET_XMIT_TYPE_SKB:
 			skb = ptr;
@@ -545,6 +739,10 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 			break;
+
+		case VIRTNET_XMIT_TYPE_DMA:
+			virtnet_sq_unmap(sq, &ptr);
+			goto retry;
 		}
 	}
 }
@@ -5232,6 +5430,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		__netif_napi_del(&vi->rq[i].napi);
 		__netif_napi_del(&vi->sq[i].napi);
+
+		virtnet_sq_free_dma_meta(&vi->sq[i]);
 	}
 
 	/* We called __netif_napi_del(),
@@ -5280,6 +5480,13 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
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
@@ -5288,6 +5495,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
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


