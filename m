Return-Path: <bpf+bounces-43519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD89B5D9C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F4A282847
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137C1E131A;
	Wed, 30 Oct 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lBTkRdiB"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7C1E0E05;
	Wed, 30 Oct 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276703; cv=none; b=phnIZ8bJZdNSaRfN5iD3yqT46AQEDH7e1gVmIUFYdjtxelunezJRYrp5M+uNzKImEf3i04mb64Cnnb16x1spiUQvOkuPABQbetZERmepDMRjNMcPOPEw8a6CiJ2UOtj7WkqMLr8jbNaK2n6Umm/a8WxldQBEm0l5STklSVKwl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276703; c=relaxed/simple;
	bh=yiWFLPRChRXd7Q4pJpOR5MrAcXzX12eN9ejG+nlNCDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHbVYMJaGXzGQDD06Jm1l4pzQBGqVN21G2pX9My0OZWFWU0x4FvL8BdJYngMmoO/AWfV0Ss9rA1lp2hKWO50w5ep71X+7kTtofnL5OfoeSmvhKB6mnYRezfhkaFXR1BrzNzJHwi9jc6oPTI0uYcMIWrD/b58I5co9vNsBy5x9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lBTkRdiB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276697; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Kqz02xNRzPU1fvdYAqyV4YADTRoBkR+/+Bq7D9Gc2h4=;
	b=lBTkRdiB3pwuyVqu/B7U/uAvLXkLAxa2nmTiiTj+EaYcQZV24imd9lx/4xmHcnczFNFpyp8x3DSkhgD4nMn6mVIFu/DN0bJOYwU54wytBRGM0Er2YcK22kx7dYUd54M1pWxpvCsiCJhQQTa/ptfAFFESvcyHKOO7n3p1cugxzu0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDQiyk_1730276696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:24:57 +0800
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
Subject: [PATCH net-next v2 03/13] virtio_ring: packed: record extras for indirect buffers
Date: Wed, 30 Oct 2024 16:24:43 +0800
Message-Id: <20241030082453.97310-4-xuanzhuo@linux.alibaba.com>
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
 drivers/virtio/virtio_ring.c | 60 +++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dca093744fe1..628e01af1c9a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,7 +78,11 @@ struct vring_desc_state_split {
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+
+	/* Indirect extra table and desc table, if any. These two will be
+	 * allocated together. So we won't stress more to the memory allocator.
+	 */
+	struct vring_packed_desc *indir_desc;
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -1238,27 +1242,12 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
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
 						       gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
+	int i, size;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1267,7 +1256,16 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
+	size = (sizeof(*desc) + sizeof(*extra)) * total_sg;
+
+	desc = kmalloc(size, gfp);
+	if (!desc)
+		return NULL;
+
+	extra = (struct vring_desc_extra *)&desc[total_sg];
+
+	for (i = 0; i < total_sg; i++)
+		extra[i].next = i + 1;
 
 	return desc;
 }
@@ -1280,6 +1278,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1291,6 +1290,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	if (!desc)
 		return -ENOMEM;
 
+	extra = (struct vring_desc_extra *)&desc[total_sg];
+
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
 		kfree(desc);
@@ -1312,6 +1313,13 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
@@ -1381,7 +1389,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_extra_packed(vq, &extra[i]);
 
 free_desc:
 	kfree(desc);
@@ -1617,7 +1625,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	}
 
 	if (vq->indirect) {
-		u32 len;
+		struct vring_desc_extra *extra;
+		u32 len, num;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		desc = state->indir_desc;
@@ -1626,9 +1635,12 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 
 		if (vring_need_unmap_buffer(vq)) {
 			len = vq->packed.desc_extra[id].len;
-			for (i = 0; i < len / sizeof(struct vring_packed_desc);
-					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+			num = len / sizeof(struct vring_packed_desc);
+
+			extra = (struct vring_desc_extra *)&desc[num];
+
+			for (i = 0; i < num; i++)
+				vring_unmap_extra_packed(vq, &extra[i]);
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
-- 
2.32.0.3.g01195cf9f


