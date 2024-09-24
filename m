Return-Path: <bpf+bounces-40225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4AF983ADF
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 03:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047AD1F23150
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C738DD2;
	Tue, 24 Sep 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nm4SKfj8"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E001B85F6;
	Tue, 24 Sep 2024 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141538; cv=none; b=GteifsE7dcb+++uWUzwL8d9T2gUf7c41qmTCy6TF7gDrVTJ0UMR5xUZOp7iW6pcUcWbdejXhUEBtCRrhPJUhfBWTix5Z2MS2DOBWuusjQ8+0i1TLxnzJKAeNIzfkPAFnG9vpU2IbRSgQuybmi6hpmYXGvsXnmVAjX3+am26FXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141538; c=relaxed/simple;
	bh=6uUsypmmZeow9fesI41yhOA32pV9RZ2aLczNva0hKao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmpLJkG90ybNdHlzPHlhYlJ68dSf7iRxLm1pX4mb/iHwBVODbjgQfozjEZLvKKejM6YjxE3O29qqPe99VIGoO3NAd2GW2p4SwEecCF5Hs4Ls9GU+9VCFGcRdRQznu9+pUEgC6F/7Sim2VhCG7Q+aP9dF0zeR4surLTsfX+05Q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nm4SKfj8; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727141528; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lRNeoN9ASozdK/uesOq83PNEpvO+7btT+iZPLJrwyyo=;
	b=Nm4SKfj8h6oekZoU2CJQ1SR4Qz7IcERyh7dIrmT9FrzUziq/JrlpHz74zRAOuwTuJM8FRJ2I252X5g41bncZeNMwaNsDNUroPyywmo05dm5QcVVYZ+f3HH2xVE2A1l786l2REP0mmFtVtvpVVjr65w8z1pvg9dzobbGulDnAfeQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFdsUke_1727141527)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:32:08 +0800
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
Subject: [RFC net-next v1 03/12] virtio_ring: packed: record extras for indirect buffers
Date: Tue, 24 Sep 2024 09:31:55 +0800
Message-Id: <20240924013204.13763-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 83bb687d4b73
Content-Transfer-Encoding: 8bit

The subsequent commit needs to know whether every indirect buffer is
premapped or not. So we need to introduce an extra struct for every
indirect buffer to record this info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 67 ++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 62901bee97c0..7d5fed4ff4f8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,7 +85,11 @@ struct vring_desc_state_split {
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+
+	/* Indirect extra table and desc table, if any. These two will be
+	 * allocated together. So we won't stress more to the memory allocator.
+	 */
+	struct vring_desc_extra *indir;
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -1242,27 +1246,13 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	}
 }
 
-static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
-				    const struct vring_packed_desc *desc)
-{
-	u16 flags;
-
-	if (!vring_need_unmap_buffer(vq))
-		return;
-
-	flags = le16_to_cpu(desc->flags);
-
-	dma_unmap_page(vring_dma_dev(vq),
-		       le64_to_cpu(desc->addr),
-		       le32_to_cpu(desc->len),
-		       (flags & VRING_DESC_F_WRITE) ?
-		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-}
-
 static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
+						       struct vring_desc_extra **pextra,
 						       gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
+	int i;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1271,7 +1261,16 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
+	extra = kmalloc_array(total_sg, sizeof(*desc) + sizeof(*extra), gfp);
+	if (!extra)
+		return NULL;
+
+	desc = (struct vring_packed_desc *)&extra[total_sg];
+
+	for (i = 0; i < total_sg; i++)
+		extra[i].next = i + 1;
+
+	*pextra = extra;
 
 	return desc;
 }
@@ -1284,6 +1283,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1291,7 +1291,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
+	desc = alloc_indirect_packed(total_sg, &extra, gfp);
 	if (!desc)
 		return -ENOMEM;
 
@@ -1316,6 +1316,13 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 						0 : VRING_DESC_F_WRITE);
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
+
+			if (unlikely(vq->use_dma_api)) {
+				extra[i].addr = addr;
+				extra[i].len = sg->length;
+				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
+			}
+
 			i++;
 		}
 	}
@@ -1371,7 +1378,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].indir = extra;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1385,7 +1392,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_extra_packed(vq, &extra[i]);
 
 free_desc:
 	kfree(desc);
@@ -1508,7 +1515,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	/* Store token. */
 	vq->packed.desc_state[id].num = descs_used;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
+	vq->packed.desc_state[id].indir = ctx;
 	vq->packed.desc_state[id].last = prev;
 
 	/*
@@ -1599,7 +1606,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			      unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
-	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 
 	state = &vq->packed.desc_state[id];
@@ -1621,23 +1627,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	}
 
 	if (vq->indirect) {
+		struct vring_desc_extra *extra;
 		u32 len;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
-		desc = state->indir_desc;
-		if (!desc)
+		extra = state->indir;
+		if (!extra)
 			return;
 
 		if (vring_need_unmap_buffer(vq)) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+				vring_unmap_extra_packed(vq, &extra[i]);
 		}
-		kfree(desc);
-		state->indir_desc = NULL;
+		kfree(extra);
+		state->indir = NULL;
 	} else if (ctx) {
-		*ctx = state->indir_desc;
+		*ctx = state->indir;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


