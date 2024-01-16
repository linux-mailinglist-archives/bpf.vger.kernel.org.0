Return-Path: <bpf+bounces-19579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4182EA91
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E41C23193
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B961171A;
	Tue, 16 Jan 2024 07:59:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAC125BC;
	Tue, 16 Jan 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lQYvn_1705391965;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lQYvn_1705391965)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 15:59:26 +0800
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
Subject: [PATCH net-next 1/5] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Tue, 16 Jan 2024 15:59:20 +0800
Message-Id: <20240116075924.42798-2-xuanzhuo@linux.alibaba.com>
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

introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
get buf from virtio core for premapped mode.

If the virtio queue is premapped mode, the virtio-net send buf may
have many desc. Every desc dma address need to be unmap. So here we
introduce a new helper to collect the dma address of the buffer from
the virtio core.

Because the BAD_RING is called (that may set vq->broken), so
the relative "const" of vq is removed.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----------
 include/linux/virtio.h       |  16 ++++
 2 files changed, 142 insertions(+), 48 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9ec7..82f72428605b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->dma_dev;
 }
 
+/*
+ *     use_dma_api premapped -> do_unmap
+ *  1. false       false        false
+ *  2. true        false        true
+ *  3. true        true         false
+ *
+ * Only #3, we should return the DMA info to the driver.
+ *
+ * Return:
+ * true: the virtio core must unmap the desc
+ * false: the virtio core skip the desc unmap
+ */
+static bool vring_need_unmap(struct vring_virtqueue *vq,
+			     struct virtio_dma_head *dma,
+			     dma_addr_t addr, unsigned int length)
+{
+	if (vq->do_unmap)
+		return true;
+
+	if (!vq->premapped)
+		return false;
+
+	if (!dma)
+		return false;
+
+	if (unlikely(dma->next >= dma->num)) {
+		BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u\n",
+			 &addr, length);
+		return false;
+	}
+
+	dma->items[dma->next].addr = addr;
+	dma->items[dma->next].length = length;
+
+	++dma->next;
+
+	return false;
+}
+
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
@@ -440,12 +479,14 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   const struct vring_desc *desc)
+static void vring_unmap_one_split_indirect(struct vring_virtqueue *vq,
+					   const struct vring_desc *desc,
+					   struct virtio_dma_head *dma)
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vring_need_unmap(vq, dma, virtio64_to_cpu(vq->vq.vdev, desc->addr),
+			  virtio32_to_cpu(vq->vq.vdev, desc->len)))
 		return;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
@@ -457,8 +498,8 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+static unsigned int vring_unmap_one_split(struct vring_virtqueue *vq,
+					  unsigned int i, struct virtio_dma_head *dma)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
@@ -474,17 +515,16 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 extra[i].len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vq->do_unmap)
-			goto out;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		goto out;
 	}
 
+	if (!vring_need_unmap(vq, dma, extra[i].addr, extra[i].len))
+		goto out;
+
+	dma_unmap_page(vring_dma_dev(vq), extra[i].addr, extra[i].len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+
 out:
 	return extra[i].next;
 }
@@ -717,10 +757,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (i == err_idx)
 			break;
 		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
+			vring_unmap_one_split_indirect(vq, &desc[i], NULL);
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
-			i = vring_unmap_one_split(vq, i);
+			i = vring_unmap_one_split(vq, i, NULL);
 	}
 
 free_indirect:
@@ -763,7 +803,7 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 }
 
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+			     struct virtio_dma_head *dma, void **ctx)
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
@@ -775,12 +815,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, dma);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, dma);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -802,9 +842,9 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		if (vq->do_unmap) {
+		if (vq->do_unmap || dma) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+				vring_unmap_one_split_indirect(vq, &indir_desc[j], dma);
 		}
 
 		kfree(indir_desc);
@@ -822,6 +862,7 @@ static bool more_used_split(const struct vring_virtqueue *vq)
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 					 unsigned int *len,
+					 struct virtio_dma_head *dma,
 					 void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -862,7 +903,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
-	detach_buf_split(vq, i, ctx);
+	detach_buf_split(vq, i, dma, ctx);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -984,7 +1025,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
-		detach_buf_split(vq, i, NULL);
+		detach_buf_split(vq, i, NULL, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 				vq->split.avail_idx_shadow);
@@ -1220,8 +1261,9 @@ static u16 packed_last_used(u16 last_used_idx)
 	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
 
-static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+static void vring_unmap_extra_packed(struct vring_virtqueue *vq,
+				     const struct vring_desc_extra *extra,
+				     struct virtio_dma_head *dma)
 {
 	u16 flags;
 
@@ -1235,23 +1277,24 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 extra->addr, extra->len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vq->do_unmap)
-			return;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		return;
 	}
+
+	if (!vring_need_unmap(vq, dma, extra->addr, extra->len))
+		return;
+
+	dma_unmap_page(vring_dma_dev(vq), extra->addr, extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				    const struct vring_packed_desc *desc)
+static void vring_unmap_desc_packed(struct vring_virtqueue *vq,
+				    const struct vring_packed_desc *desc,
+				    struct virtio_dma_head *dma)
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vring_need_unmap(vq, dma, le64_to_cpu(desc->addr), le32_to_cpu(desc->len)))
 		return;
 
 	flags = le16_to_cpu(desc->flags);
@@ -1389,7 +1432,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_desc_packed(vq, &desc[i], NULL);
 
 free_desc:
 	kfree(desc);
@@ -1539,7 +1582,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], NULL);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1600,7 +1643,9 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 }
 
 static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+			      unsigned int id,
+			      struct virtio_dma_head *dma,
+			      void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
@@ -1615,11 +1660,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->do_unmap)) {
+	if (vq->do_unmap || dma) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
+			vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr], dma);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
@@ -1632,11 +1676,11 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->do_unmap) {
+		if (vq->do_unmap || dma) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_desc_packed(vq, &desc[i], dma);
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
@@ -1672,6 +1716,7 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
 
 static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 					  unsigned int *len,
+					  struct virtio_dma_head *dma,
 					  void **ctx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1712,7 +1757,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
-	detach_buf_packed(vq, id, ctx);
+	detach_buf_packed(vq, id, dma, ctx);
 
 	last_used += vq->packed.desc_state[id].num;
 	if (unlikely(last_used >= vq->packed.vring.num)) {
@@ -1877,7 +1922,7 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
-		detach_buf_packed(vq, i, NULL);
+		detach_buf_packed(vq, i, NULL, NULL);
 		END_USE(vq);
 		return buf;
 	}
@@ -2417,11 +2462,44 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
-				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, NULL, ctx) :
+				 virtqueue_get_buf_ctx_split(_vq, len, NULL, ctx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
 
+/**
+ * virtqueue_get_buf_ctx_dma - get the next used buffer with the dma info
+ * @_vq: the struct virtqueue we're talking about.
+ * @len: the length written into the buffer
+ * @dma: the head of the array to store the dma info
+ * @ctx: extra context for the token
+ *
+ * If the device wrote data into the buffer, @len will be set to the
+ * amount written.  This means you don't need to clear the buffer
+ * beforehand to ensure there's no data leakage in the case of short
+ * writes.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * We store the dma info of every descriptor of this buf to the dma->items
+ * array. If the array size is too small, some dma info may be missed, so
+ * the caller must ensure the array is large enough. The dma->next is the out
+ * value to the caller, indicates the num of the used items.
+ *
+ * Returns NULL if there are no used buffers, or the "data" token
+ * handed to virtqueue_add_*().
+ */
+void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len,
+				struct virtio_dma_head *dma, void **ctx)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, dma, ctx) :
+				 virtqueue_get_buf_ctx_split(_vq, len, dma, ctx);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx_dma);
+
 void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 {
 	return virtqueue_get_buf_ctx(_vq, len, NULL);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4cc614a38376..572aecec205b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -75,6 +75,22 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
 			    void **ctx);
 
+struct virtio_dma_item {
+	dma_addr_t addr;
+	unsigned int length;
+};
+
+struct virtio_dma_head {
+	/* total num of items. */
+	u16 num;
+	/* point to the next item to store dma info. */
+	u16 next;
+	struct virtio_dma_item items[];
+};
+
+void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len,
+				struct virtio_dma_head *dma, void **ctx);
+
 void virtqueue_disable_cb(struct virtqueue *vq);
 
 bool virtqueue_enable_cb(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f


