Return-Path: <bpf+bounces-29010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B028BF47B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100A21F254CF
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1CF9C3;
	Wed,  8 May 2024 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a3WTRRMN"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD19FC1C;
	Wed,  8 May 2024 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135026; cv=none; b=jnOvZP098Xd/TYWn55IGlNbQ+zxz0/W7HekXN40cQRE/QsnNpUz7+o0vfEJYqNvtBmKUgx4xH/h+FWlA7Hp43MiLAXuo549dCTww8+7cQ8PNvdp8TcB+gOrJ6VxIHdOSk2dtG5kU0JsbL5sxiC1J8iIfF0UUTXN9buOgOtdIDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135026; c=relaxed/simple;
	bh=UF+TAPOrGWJnhbGhBoW8JR4hZpOu6/pKeUA7xX+lqGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O55Z50e4ehocu+giE6eZ/RpegfhKeG8wTdVkZx0dt8fUnWb/DFnou3BONbTgkC+HloqDSS1l3a3/1UOOzVGhm9J7I/K1hEOzC4goWG7DkkM7sr/z/QoMt2M0qT2UaqSeoULmj8+S5zCQorZKhRAY2QCqzcQ8v5ZucEkogtTVOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a3WTRRMN; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715135021; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+16xHV+E+hZsSbFAcLStp0O+Mu92bYJGwyc/2BUXSR0=;
	b=a3WTRRMNhbbTp6p+hwq397f4zXDWivn/I4qKA4Lh/5o79zKg8PCl2mKAdqEYv7DR2bPPNNRfroWmBGq2OlZ3xkkA99Ax2eCJkGskVAVXgubN/Y9tugCwPFHvtFhpmlVnP8P1YAhxjMPQsXXF9pHLCTuHJPN55MMMAik1HM0jn1w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W61t.VX_1715135019;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W61t.VX_1715135019)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:23:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 5/5] virtio_net: sq support premapped mode
Date: Wed,  8 May 2024 10:23:31 +0800
Message-Id: <20240508022331.63751-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
References: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a0fef46c457b
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
 drivers/net/virtio_net.c | 210 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a28a84101d5b..7274daed4993 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -24,6 +24,7 @@
 #include <net/xdp.h>
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
+#include <uapi/linux/virtio_ring.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -47,6 +48,7 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_REDIR	BIT(1)
 
 #define VIRTIO_XDP_FLAG	BIT(0)
+#define VIRTIO_DMA_FLAG	BIT(1)
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
@@ -146,6 +148,25 @@ struct virtnet_rq_dma {
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
@@ -165,6 +186,11 @@ struct send_queue {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	/* SQ is premapped mode or not. */
+	bool premapped;
+
+	struct virtnet_sq_dma_info dmainfo;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -374,6 +400,173 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static void virtnet_sq_unmap(struct send_queue *sq, void **data)
+{
+	struct virtnet_sq_dma *head, *tail, *p;
+	unsigned long ptr;
+	int i;
+
+	ptr = (unsigned long)*data;
+
+	if (!(ptr & VIRTIO_DMA_FLAG))
+		return;
+
+	head = (void *)(ptr & ~VIRTIO_DMA_FLAG);
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
+	return (void *)((unsigned long)head | VIRTIO_DMA_FLAG);
+}
+
+static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, int num, void *data)
+{
+	struct virtnet_sq_dma *head, *tail, *p;
+	struct scatterlist *sg;
+	int i;
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
+		if (virtqueue_dma_map_sg_attrs(sq->vq, &sq->sg[i], DMA_TO_DEVICE, 0))
+			goto err;
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
+		data = virtnet_dma_chain_update(sq, head, tail, i, data);
+		virtnet_sq_unmap(sq, &data);
+	}
+
+	return NULL;
+}
+
+static int virtnet_add_outbuf(struct send_queue *sq, u8 num, void *data)
+{
+	int ret;
+
+	if (sq->premapped) {
+		data = virtnet_sq_map_sg(sq, num, data);
+		if (!data)
+			return -ENOMEM;
+	}
+
+	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
+	if (ret && sq->premapped)
+		virtnet_sq_unmap(sq, &data);
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
+int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped);
+
+/* This function must be called immediately after creating the vq, or after vq
+ * reset, and before adding any buffers to it.
+ */
+int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
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
+}
+
 static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			    struct virtnet_sq_free_stats *stats)
 {
@@ -383,6 +576,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
+		virtnet_sq_unmap(sq, &ptr);
+
 		if (!is_xdp_frame(ptr)) {
 			struct sk_buff *skb = ptr;
 
@@ -915,8 +1110,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -2380,7 +2574,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	return virtnet_add_outbuf(sq, num_sg, skb);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -4215,6 +4409,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		__netif_napi_del(&vi->rq[i].napi);
 		__netif_napi_del(&vi->sq[i].napi);
+
+		virtnet_sq_free_dma_meta(&vi->sq[i]);
 	}
 
 	/* We called __netif_napi_del(),
@@ -4263,6 +4459,14 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct send_queue *sq;
+	int i = vq2rxq(vq);
+
+	sq = &vi->sq[i];
+
+	virtnet_sq_unmap(sq, &buf);
+
 	if (!is_xdp_frame(buf))
 		dev_kfree_skb(buf);
 	else
-- 
2.32.0.3.g01195cf9f


