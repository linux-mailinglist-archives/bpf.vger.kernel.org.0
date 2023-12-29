Return-Path: <bpf+bounces-18715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB2381FD79
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 08:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD41F23AAC
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72850BE64;
	Fri, 29 Dec 2023 07:31:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441CC2C3;
	Fri, 29 Dec 2023 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQtf35_1703835077;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQtf35_1703835077)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
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
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 07/27] virtio_ring: virtqueue_disable_and_recycle let the callback detach bufs
Date: Fri, 29 Dec 2023 15:30:48 +0800
Message-Id: <20231229073108.57778-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

Now, inside virtqueue_disable_and_recycle, the recycle() just has two
parameters(vq, buf) after detach operate.

But if we are in premapped mode, we may need to get some dma info when
detach buf like virtqueue_get_buf_ctx_dma().

So we call recycle directly, this callback detaches bufs self. It should
complete the work of detaching all the unused buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c    | 60 +++++++++++++++++++-----------------
 drivers/virtio/virtio_ring.c | 10 +++---
 include/linux/virtio.h       |  4 +--
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 541c18c93e80..b95a59884687 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -149,7 +149,8 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_rq_free_unused_bufs(struct virtqueue *vq);
+static void virtnet_sq_free_unused_bufs(struct virtqueue *vq);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -582,20 +583,6 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	}
 }
 
-static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
-{
-	struct virtnet_info *vi = vq->vdev->priv;
-	struct virtnet_rq *rq;
-	int i = vq2rxq(vq);
-
-	rq = &vi->rq[i];
-
-	if (rq->do_dma)
-		virtnet_rq_unmap(rq, buf, 0);
-
-	virtnet_rq_free_buf(vi, rq, buf);
-}
-
 static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 {
 	u64 bytes = 0, packets = 0;
@@ -2210,7 +2197,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (running)
 		napi_disable(&rq->napi);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_bufs);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -2249,7 +2236,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	__netif_tx_unlock_bh(txq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_bufs);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -3841,31 +3828,48 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 		}
 }
 
-static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
+static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
 {
-	if (!is_xdp_frame(buf))
-		dev_kfree_skb(buf);
-	else
-		xdp_return_frame(ptr_to_xdp(buf));
+	void *buf;
+
+	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
+		if (!is_xdp_frame(buf))
+			dev_kfree_skb(buf);
+		else
+			xdp_return_frame(ptr_to_xdp(buf));
+	}
 }
 
-static void free_unused_bufs(struct virtnet_info *vi)
+static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct virtnet_rq *rq;
+	int i = vq2rxq(vq);
 	void *buf;
+
+	rq = &vi->rq[i];
+
+	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
+
+		virtnet_rq_free_buf(vi, rq, buf);
+	}
+}
+
+static void free_unused_bufs(struct virtnet_info *vi)
+{
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
-			virtnet_sq_free_unused_buf(vq, buf);
+		virtnet_sq_free_unused_bufs(vq);
 		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
-
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
-			virtnet_rq_unmap_free_buf(vq, buf);
+		virtnet_rq_free_unused_bufs(vq);
 		cond_resched();
 	}
 }
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1374b3fd447c..b700d4e6e7dd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2198,11 +2198,10 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 }
 
 static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
-					 void (*recycle)(struct virtqueue *vq, void *buf))
+					 void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct virtio_device *vdev = vq->vq.vdev;
-	void *buf;
 	int err;
 
 	if (!vq->we_own_ring)
@@ -2218,8 +2217,7 @@ static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 	if (err)
 		return err;
 
-	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
-		recycle(_vq, buf);
+	recycle(_vq);
 
 	return 0;
 }
@@ -2814,7 +2812,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2905,7 +2903,7 @@ EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 572aecec205b..7a5e9ea7d420 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,9 +115,9 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf));
+		     void (*recycle)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq));
 
 /**
  * struct virtio_device - representation of a device using virtio
-- 
2.32.0.3.g01195cf9f


