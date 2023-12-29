Return-Path: <bpf+bounces-18718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D281FD94
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 08:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C961F23B2A
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46410A29;
	Fri, 29 Dec 2023 07:31:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A48F502;
	Fri, 29 Dec 2023 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQtf4H_1703835079;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQtf4H_1703835079)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:20 +0800
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
Subject: [PATCH net-next v3 09/27] virtio_ring: introduce virtqueue_get_dma_premapped()
Date: Fri, 29 Dec 2023 15:30:50 +0800
Message-Id: <20231229073108.57778-10-xuanzhuo@linux.alibaba.com>
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

Introduce helper virtqueue_get_dma_premapped(), then the driver
can know whether dma unmap is needed.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 22 +++++++++-------------
 drivers/net/virtio/virtio_net.h |  3 ---
 drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
 include/linux/virtio.h          |  1 +
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index b95a59884687..70d2a4e7b43f 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -478,7 +478,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf && virtqueue_get_dma_premapped(rq->vq))
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -491,7 +491,7 @@ static void virtnet_rq_init_one_sg(struct virtnet_rq *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
+	if (!virtqueue_get_dma_premapped(rq->vq)) {
 		sg_init_one(rq->sg, buf, len);
 		return;
 	}
@@ -521,7 +521,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	if (rq->do_dma) {
+	if (virtqueue_get_dma_premapped(rq->vq)) {
 		dma = head;
 
 		/* new pages */
@@ -575,12 +575,8 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (!vi->mergeable_rx_bufs && vi->big_packets)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
-
-		vi->rq[i].do_dma = true;
-	}
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		virtqueue_set_dma_premapped(vi->rq[i].vq);
 }
 
 static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
@@ -1638,7 +1634,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct virtnet_rq *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
+		if (virtqueue_get_dma_premapped(rq->vq))
 			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
@@ -1753,7 +1749,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
+		if (virtqueue_get_dma_premapped(rq->vq))
 			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
@@ -3822,7 +3818,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+			if (virtqueue_get_dma_premapped(vi->rq[i].vq) && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
@@ -3850,7 +3846,7 @@ static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
 	rq = &vi->rq[i];
 
 	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-		if (rq->do_dma)
+		if (virtqueue_get_dma_premapped(rq->vq))
 			virtnet_rq_unmap(rq, buf, 0);
 
 		virtnet_rq_free_buf(vi, rq, buf);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index ebf9f344648a..2ca968db6153 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -104,9 +104,6 @@ struct virtnet_rq {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
-
-	/* Do dma by self */
-	bool do_dma;
 };
 
 struct virtnet_info {
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a2d6aea551a7..e4a4b9323a37 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
 
+/**
+ * virtqueue_get_dma_premapped - get the vring premapped mode
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Get the premapped mode of the vq.
+ *
+ * Returns bool for the vq premapped mode.
+ */
+bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	bool premapped;
+
+	START_USE(vq);
+	premapped = vq->premapped;
+	END_USE(vq);
+
+	return premapped;
+
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_dma_premapped);
+
 /**
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2596f0e7e395..3e9a2bb75af6 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -98,6 +98,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
 int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+bool virtqueue_get_dma_premapped(struct virtqueue *_vq);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f


