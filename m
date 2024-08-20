Return-Path: <bpf+bounces-37601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD07957FD3
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22801F23502
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EF18A955;
	Tue, 20 Aug 2024 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="it2uLDGy"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6018A92D;
	Tue, 20 Aug 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139227; cv=none; b=i1W3Dc37FOVsrQTEZxVwoOFA1n9NvSDtu4R4nuGZQ84Zp9zbB5GUQF+CKQGIiObzG+zhTIZ1ujVBtRs7wRgwxnj4PqFjAiP3lPVctW2ULcewPK++fmcPoLuZLp91MD/S/VyPuTrZEEsfreBYaVJSxPnRSYHKuIlNZOX/W0/7VeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139227; c=relaxed/simple;
	bh=5NmTO56zwyPK38rGeMtL31CXdae0UczXtbGF2Gdq4mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMAwWqv3BQvZHAoS7xCGdNsKTzhgFtOKB6PNENMWRyQZssCl5qtMJTOlCANI5bjeERmli8F+Kg90E8UOEI0VxMVVolLKzCBo9AZ/sID3MceE/rAXnShd6v3No+D4yFKGKVcDJC5JmBmqaFPDOFF/urVB2jCfroiTgX+Ys8tpO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=it2uLDGy; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724139215; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZmG+YXSPAiGPrOx5A2sKSeVWoEKQHTwAtIQQ+JP/08w=;
	b=it2uLDGyk6FPo8JMaPVz2R6gFOj9RFtJf2aWI9N3ZtfwXfgYchkcAfyy8M0g3MzQn7VjK9GeTHdoMdfveSiPadnU0JMXYjH2jQBO7vmRq1VNzlY0p5r9zLS8l6sMwJhLF/fS9sEXgwS7MFCvjN34/NGyJC5Pa6klabS8kqAG1uE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHeY.D_1724139212)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:33:33 +0800
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
Subject: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for indirect
Date: Tue, 20 Aug 2024 15:33:19 +0800
Message-Id: <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b206d29d23af
Content-Transfer-Encoding: 8bit

1. this commit hardens dma unmap for indirect
2. the subsequent commit uses the struct extra to record whether the
   buffers need to be unmapped or not. So we need a struct extra for
   every desc, whatever it is indirect or not.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 122 ++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 65 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 228e9fbcba3f..582d2c05498a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -67,9 +67,16 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+struct vring_desc_extra {
+	dma_addr_t addr;		/* Descriptor DMA addr. */
+	u32 len;			/* Descriptor length. */
+	u16 flags;			/* Descriptor flags. */
+	u16 next;			/* The next desc state in a list. */
+};
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
-	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	struct vring_desc_extra *indir;	/* Indirect descriptor, if any. */
 };
 
 struct vring_desc_state_packed {
@@ -79,13 +86,6 @@ struct vring_desc_state_packed {
 	u16 last;			/* The last desc state in a list. */
 };
 
-struct vring_desc_extra {
-	dma_addr_t addr;		/* Descriptor DMA addr. */
-	u32 len;			/* Descriptor length. */
-	u16 flags;			/* Descriptor flags. */
-	u16 next;			/* The next desc state in a list. */
-};
-
 struct vring_virtqueue_split {
 	/* Actual memory layout for this queue. */
 	struct vring vring;
@@ -440,38 +440,20 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
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
@@ -479,20 +461,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
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
+					       struct vring_desc_extra **pextra,
 					       gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_desc *desc;
 	unsigned int i;
 
@@ -503,40 +487,45 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
-	if (!desc)
+	extra = kmalloc_array(total_sg, sizeof(*desc) + sizeof(*extra), gfp);
+	if (!extra)
 		return NULL;
 
-	for (i = 0; i < total_sg; i++)
+	desc = (struct vring_desc *)&extra[total_sg];
+
+	for (i = 0; i < total_sg; i++) {
 		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
+		extra[i].next = i + 1;
+	}
+
+	*pextra = extra;
+
 	return desc;
 }
 
 static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    struct vring_desc *desc,
+						    struct vring_desc_extra *extra,
 						    unsigned int i,
 						    dma_addr_t addr,
 						    unsigned int len,
 						    u16 flags,
 						    bool indirect)
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
 
-		extra[i].addr = addr;
-		extra[i].len = len;
-		extra[i].flags = flags;
-	} else
-		next = virtio16_to_cpu(vq->vdev, desc[i].next);
+	next = extra[i].next;
+
+	if (!indirect)
+		desc[i].next = cpu_to_virtio16(vq->vdev, next);
 
 	return next;
 }
@@ -551,6 +540,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev, err_idx;
@@ -574,7 +564,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	head = vq->free_head;
 
 	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(_vq, total_sg, &extra, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
@@ -589,6 +579,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	} else {
 		indirect = false;
 		desc = vq->split.vring.desc;
+		extra = vq->split.desc_extra;
 		i = head;
 		descs_used = total_sg;
 	}
@@ -618,7 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr, sg->length,
+			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, sg->length,
 						     VRING_DESC_F_NEXT,
 						     indirect);
 		}
@@ -634,7 +625,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			/* Note that we trust indirect descriptor
 			 * table since it use stream DMA mapping.
 			 */
-			i = virtqueue_add_desc_split(_vq, desc, i, addr,
+			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
@@ -660,6 +651,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		}
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
+					 vq->split.desc_extra,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
 					 VRING_DESC_F_INDIRECT,
@@ -678,9 +670,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
 	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
+		vq->split.desc_state[head].indir = extra;
 	else
-		vq->split.desc_state[head].indir_desc = ctx;
+		vq->split.desc_state[head].indir = ctx;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -716,11 +708,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
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
@@ -765,22 +754,25 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
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
 
@@ -788,12 +780,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	vq->vq.num_free++;
 
 	if (vq->indirect) {
-		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
 		u32 len;
 
+		extra = vq->split.desc_state[head].indir;
+
 		/* Free the indirect table, if any, now that it's unmapped. */
-		if (!indir_desc)
+		if (!extra)
 			return;
 
 		len = vq->split.desc_extra[head].len;
@@ -804,13 +796,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		if (vring_need_unmap_buffer(vq)) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+				vring_unmap_one_split(vq, &extra[j]);
 		}
 
-		kfree(indir_desc);
-		vq->split.desc_state[head].indir_desc = NULL;
+		kfree(extra);
+		vq->split.desc_state[head].indir = NULL;
 	} else if (ctx) {
-		*ctx = vq->split.desc_state[head].indir_desc;
+		*ctx = vq->split.desc_state[head].indir;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


