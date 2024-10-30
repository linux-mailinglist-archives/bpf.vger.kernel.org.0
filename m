Return-Path: <bpf+bounces-43523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF569B5DAB
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CBF1C2127F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CE1E1C06;
	Wed, 30 Oct 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LlLX9oGu"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB01E0E05;
	Wed, 30 Oct 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276708; cv=none; b=nMonVwK9tR5jv0f7HDWIWEg+sDLcCE6IQA2+7wYGX+DJ3d/kspDASqZk4vkHH2xMcYUTChbAfs65To3Kheai55U1RsMAHIjIbXs+MEngauHFVPGmwb4MrqgcN4kKoUg5pRE37Z68uEfY8o8bOIbciG4yISmNT7Yc7N1JwVb5V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276708; c=relaxed/simple;
	bh=CbHMBqw850ia131N9WDdBA8spBlsXrmrZnvsEWh1O2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QB6xPtKzqYlyaaslW2NzGGkToyQZblONrDIk5DgZI5BHoVRmeesqElBOlv3P0KS6eTYYiOyoFRLz18ePA+BUMwuFRRXsUr47B1bUjHvyraHNdB+PQll6q4vwruJ2Z5a9EEIxoTG0ROg0KduOXjcl6lkHcRrTFKcgrodSAPAZPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LlLX9oGu; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276696; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Kx/CkeS1T6c8wEvUV86zioF6oFiy8uBlfoeRpgD/EfA=;
	b=LlLX9oGuksB+17IqWmpce6FF0Vvg8rKndRLa0bFTVFFQs+/IErEqO5VP2WL8r55Tss25xED7uOkE48f2Hv3KPzsknGw3dqj/NguOB3UMGBDsPVsMuR4xdtSDrrF8ZED7Sq8dLXks2+82dJQ7dzzQ5dNRy/waGNuC1bMhydYE+kI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDOTi1_1730276695 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:24:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v2 02/13] virtio_ring: split: record extras for indirect buffers
Date: Wed, 30 Oct 2024 16:24:42 +0800
Message-Id: <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 87bfcb32ef14
Content-Transfer-Encoding: 8bit

The subsequent commit needs to know whether every indirect buffer is
premapped or not. So we need to introduce an extra struct for every
indirect buffer to record this info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 112 ++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 97590c201aa2..dca093744fe1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -69,7 +69,11 @@
 
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
-	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+
+	/* Indirect extra table and desc table, if any. These two will be
+	 * allocated together. So we won't stress more to the memory allocator.
+	 */
+	struct vring_desc *indir_desc;
 };
 
 struct vring_desc_state_packed {
@@ -440,38 +444,20 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
-					   const struct vring_desc *desc)
-{
-	u16 flags;
-
-	if (!vring_need_unmap_buffer(vq))
-		return;
-
-	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
-
-	dma_unmap_page(vring_dma_dev(vq),
-		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
-		       virtio32_to_cpu(vq->vq.vdev, desc->len),
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-}
-
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  struct vring_desc_extra *extra)
 {
-	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
 
-	flags = extra[i].flags;
+	flags = extra->flags;
 
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_dma_api)
 			goto out;
 
 		dma_unmap_single(vring_dma_dev(vq),
-				 extra[i].addr,
-				 extra[i].len,
+				 extra->addr,
+				 extra->len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
@@ -479,22 +465,23 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 			goto out;
 
 		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
+			       extra->addr,
+			       extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
 
 out:
-	return extra[i].next;
+	return extra->next;
 }
 
 static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 					       unsigned int total_sg,
 					       gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_desc *desc;
-	unsigned int i;
+	unsigned int i, size;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -503,40 +490,41 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
+	size = sizeof(*desc) * total_sg + sizeof(*extra) * total_sg;
+
+	desc = kmalloc(size, gfp);
 	if (!desc)
 		return NULL;
 
+	extra = (struct vring_desc_extra *)&desc[total_sg];
+
 	for (i = 0; i < total_sg; i++)
-		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
+		extra[i].next = i + 1;
+
 	return desc;
 }
 
 static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    struct vring_desc *desc,
+						    struct vring_desc_extra *extra,
 						    unsigned int i,
 						    dma_addr_t addr,
 						    unsigned int len,
-						    u16 flags,
-						    bool indirect)
+						    u16 flags)
 {
-	struct vring_virtqueue *vring = to_vvq(vq);
-	struct vring_desc_extra *extra = vring->split.desc_extra;
 	u16 next;
 
 	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
 	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
 	desc[i].len = cpu_to_virtio32(vq->vdev, len);
 
-	if (!indirect) {
-		next = extra[i].next;
-		desc[i].next = cpu_to_virtio16(vq->vdev, next);
+	extra[i].addr = addr;
+	extra[i].len = len;
+	extra[i].flags = flags;
+
+	next = extra[i].next;
 
-		extra[i].addr = addr;
-		extra[i].len = len;
-		extra[i].flags = flags;
-	} else
-		next = virtio16_to_cpu(vq->vdev, desc[i].next);
+	desc[i].next = cpu_to_virtio16(vq->vdev, next);
 
 	return next;
 }
@@ -551,6 +539,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev, err_idx;
@@ -586,9 +575,11 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		/* Set up rest to use this indirect table. */
 		i = 0;
 		descs_used = 1;
+		extra = (struct vring_desc_extra *)&desc[total_sg];
 	} else {
 		indirect = false;
 		desc = vq->split.vring.desc;
+		extra = vq->split.desc_extra;
 		i = head;
 		descs_used = total_sg;
 	}
@@ -618,9 +609,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr, sg->length,
-						     VRING_DESC_F_NEXT,
-						     indirect);
+			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, sg->length,
+						     VRING_DESC_F_NEXT);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -634,11 +624,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr,
+			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE,
-						     indirect);
+						     VRING_DESC_F_WRITE);
 		}
 	}
 	/* Last one doesn't continue. */
@@ -660,10 +649,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		}
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
+					 vq->split.desc_extra,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT,
-					 false);
+					 VRING_DESC_F_INDIRECT);
 	}
 
 	/* We're using some buffers from the free list. */
@@ -716,11 +705,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		if (indirect) {
-			vring_unmap_one_split_indirect(vq, &desc[i]);
-			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
-		} else
-			i = vring_unmap_one_split(vq, i);
+
+		i = vring_unmap_one_split(vq, &extra[i]);
 	}
 
 free_indirect:
@@ -765,22 +751,25 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 			     void **ctx)
 {
+	struct vring_desc_extra *extra;
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
 
+	extra = vq->split.desc_extra;
+
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, &extra[i]);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, &extra[i]);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -790,21 +779,24 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	if (vq->indirect) {
 		struct vring_desc *indir_desc =
 				vq->split.desc_state[head].indir_desc;
-		u32 len;
+		u32 len, num;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		if (!indir_desc)
 			return;
-
 		len = vq->split.desc_extra[head].len;
 
 		BUG_ON(!(vq->split.desc_extra[head].flags &
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
+		num = len / sizeof(struct vring_desc);
+
+		extra = (struct vring_desc_extra *)&indir_desc[num];
+
 		if (vring_need_unmap_buffer(vq)) {
-			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+			for (j = 0; j < num; j++)
+				vring_unmap_one_split(vq, &extra[j]);
 		}
 
 		kfree(indir_desc);
-- 
2.32.0.3.g01195cf9f


