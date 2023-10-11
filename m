Return-Path: <bpf+bounces-11891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC97C4EC9
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CD41C20F0E
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E21DA23;
	Wed, 11 Oct 2023 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1641DDCC;
	Wed, 11 Oct 2023 09:27:47 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454BEB6;
	Wed, 11 Oct 2023 02:27:44 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtwGXde_1697016461;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VtwGXde_1697016461)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 17:27:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 11/22] virtio_net: sq support premapped mode
Date: Wed, 11 Oct 2023 17:27:17 +0800
Message-Id: <20231011092728.105904-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the xsk is enabling, the xsk tx will share the send queue.
But the xsk requires that the send queue use the premapped mode.
So the send queue must support premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 98 ++++++++++++++++++++++++++++++++-
 drivers/net/virtio/virtio_net.h | 55 +++++++++++++++++-
 2 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index fb4a9cd98e0c..ad47ab2d74a2 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -514,6 +514,46 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
+int virtnet_sq_set_premapped(struct virtnet_sq *sq)
+{
+	struct virtnet_sq_dma *d;
+	int err, size, i;
+
+	size = virtqueue_get_vring_size(sq->vq);
+
+	size += MAX_SKB_FRAGS + 2;
+
+	sq->dmainfo.head = kcalloc(size, sizeof(*sq->dmainfo.head), GFP_KERNEL);
+	if (!sq->dmainfo.head)
+		return -ENOMEM;
+
+	err = virtqueue_set_dma_premapped(sq->vq, true);
+	if (err) {
+		kfree(sq->dmainfo.head);
+		return err;
+	}
+
+	sq->dmainfo.free = NULL;
+
+	sq->do_dma = true;
+
+	for (i = 0; i < size; ++i) {
+		d = &sq->dmainfo.head[i];
+
+		d->next = sq->dmainfo.free;
+		sq->dmainfo.free = d;
+	}
+
+	return 0;
+}
+
+void virtnet_sq_unset_premapped(struct virtnet_sq *sq)
+{
+	sq->do_dma = false;
+	kfree(sq->dmainfo.head);
+	virtqueue_set_dma_premapped(sq->vq, false);
+}
+
 static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
 	int i;
@@ -530,6 +570,56 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	}
 }
 
+static struct virtnet_sq_dma *virtnet_sq_map_sg(struct virtnet_sq *sq, int nents, void *data)
+{
+	struct virtnet_sq_dma *d, *head;
+	struct scatterlist *sg;
+	int i;
+
+	head = NULL;
+
+	for_each_sg(sq->sg, sg, nents, i) {
+		sg->dma_address = virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg),
+							       sg->offset, sg->length,
+							       DMA_TO_DEVICE, 0);
+		if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
+			goto err;
+
+		d = sq->dmainfo.free;
+		sq->dmainfo.free = d->next;
+
+		d->addr = sg->dma_address;
+		d->len = sg->length;
+
+		d->next = head;
+		head = d;
+	}
+
+	head->data = data;
+
+	return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
+err:
+	virtnet_sq_unmap(sq, head);
+	return NULL;
+}
+
+static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data)
+{
+	int ret;
+
+	if (sq->do_dma) {
+		data = virtnet_sq_map_sg(sq, num, data);
+		if (!data)
+			return -ENOMEM;
+	}
+
+	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
+	if (ret && sq->do_dma)
+		virtnet_sq_unmap(sq, data);
+
+	return ret;
+}
+
 static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 {
 	struct virtnet_sq_stats stats = {};
@@ -623,8 +713,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -2066,7 +2155,8 @@ static int xmit_skb(struct virtnet_sq *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+
+	return virtnet_add_outbuf(sq, num_sg, skb);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -3723,6 +3813,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		__netif_napi_del(&vi->rq[i].napi);
 		__netif_napi_del(&vi->sq[i].napi);
+
+		kfree(vi->sq[i].dmainfo.head);
 	}
 
 	/* We called __netif_napi_del(),
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 2f930af35364..9cb9b16bb0d3 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -7,6 +7,7 @@
 #include <linux/average.h>
 
 #define VIRTIO_XDP_FLAG	BIT(0)
+#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
@@ -58,6 +59,18 @@ struct virtnet_rq_dma {
 	u16 need_sync;
 };
 
+struct virtnet_sq_dma {
+	struct virtnet_sq_dma *next;
+	dma_addr_t addr;
+	u32 len;
+	void *data;
+};
+
+struct virtnet_sq_dma_head {
+	struct virtnet_sq_dma *free;
+	struct virtnet_sq_dma *head;
+};
+
 /* Internal representation of a send virtqueue */
 struct virtnet_sq {
 	/* Virtqueue associated with this virtnet_sq */
@@ -77,6 +90,10 @@ struct virtnet_sq {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	bool do_dma;
+
+	struct virtnet_sq_dma_head dmainfo;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -211,6 +228,28 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
+{
+	struct virtnet_sq_dma *next, *head;
+
+	head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
+
+	data = head->data;
+
+	while (head) {
+		virtqueue_dma_unmap_page_attrs(sq->vq, head->addr, head->len, DMA_TO_DEVICE, 0);
+
+		next = head->next;
+
+		head->next = sq->dmainfo.free;
+		sq->dmainfo.free = head;
+
+		head = next;
+	}
+
+	return data;
+}
+
 static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 					 struct virtnet_sq_stats *stats)
 {
@@ -219,14 +258,24 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		if (!virtnet_is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr;
+			struct sk_buff *skb;
+
+			if (sq->do_dma)
+				ptr = virtnet_sq_unmap(sq, ptr);
+
+			skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
 
 			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
 		} else {
-			struct xdp_frame *frame = virtnet_ptr_to_xdp(ptr);
+			struct xdp_frame *frame;
+
+			if (sq->do_dma)
+				ptr = virtnet_sq_unmap(sq, ptr);
+
+			frame = virtnet_ptr_to_xdp(ptr);
 
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
@@ -258,4 +307,6 @@ void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
+int virtnet_sq_set_premapped(struct virtnet_sq *sq);
+void virtnet_sq_unset_premapped(struct virtnet_sq *sq);
 #endif
-- 
2.32.0.3.g01195cf9f


