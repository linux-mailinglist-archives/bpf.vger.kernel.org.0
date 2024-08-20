Return-Path: <bpf+bounces-37596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02A957FC2
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894F01F21C46
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED21189BA4;
	Tue, 20 Aug 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q5ZBR4O+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE01E86E;
	Tue, 20 Aug 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139220; cv=none; b=Duc4Btspd4WIhEa0P8M6YQ8wfx2W0wYVvQy0sPSv11px4PxBzGGnFbKjMFvnKlxlwP9maX40H22YinorbGvCj8xh4Uefoqw9Vr8OboUorb4iCY2qmWFyITYH6G4VYqEdfgwr6gyhy2Gg/VXQ6Iq1vGFQYdG3vJ3hi+w2j9NDeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139220; c=relaxed/simple;
	bh=eNq10XOUkPrU1cWjaGFmWBS55p7/FU+jy0qOzCuc5Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BTGN4/LD2yUoBgYxxVelq6uIYG10GWZ7Rj3eAl3otxbedaOhNqdQ5tEfOGMMn1nPvvawl7gYfWtSHKi/W/nSozUIwT2f0Zii4fcdBQNosorH7P8RpSDeOFjMZ7dBIVVXY5T3WWCk2CCRzRUmrDMNG8He8q7ONxXaJLnd0TTQkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q5ZBR4O+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724139214; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dDp6UHTUtn8GrPXeyEv7FKbQOweQVhNwniauUlTrrYo=;
	b=Q5ZBR4O+MEb28KaxiOCT39p9P7t3BRsm9mO1wQPg3WlC7gdSXaCFcRVpsyqGDSOxzMgiXL/M51xZDNCA0JUwBBsxOKu6dROGNhaEbiCTPJRI4vYOxDXEuJpcPE2/rDyZ/qV8FRovuAea+XV2veXrPbqlIQL5EfYk1W9MZ+7KAUs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHlEP2_1724139213)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:33:34 +0800
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
Subject: [PATCH net-next 03/13] virtio_ring: packed: harden dma unmap for indirect
Date: Tue, 20 Aug 2024 15:33:20 +0800
Message-Id: <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
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
 drivers/virtio/virtio_ring.c | 57 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 582d2c05498a..b43eca93015c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -81,7 +81,7 @@ struct vring_desc_state_split {
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	struct vring_desc_extra *indir; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -1238,27 +1238,13 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
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
@@ -1267,7 +1253,14 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
+	extra = kmalloc_array(total_sg, sizeof(*desc) + sizeof(*extra), gfp);
+
+	desc = (struct vring_packed_desc *)&extra[total_sg];
+
+	for (i = 0; i < total_sg; i++)
+		extra[i].next = i + 1;
+
+	*pextra = extra;
 
 	return desc;
 }
@@ -1280,6 +1273,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1287,7 +1281,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
+	desc = alloc_indirect_packed(total_sg, &extra, gfp);
 	if (!desc)
 		return -ENOMEM;
 
@@ -1313,6 +1307,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
+
+			if (unlikely(vq->use_dma_api)) {
+				extra[i].addr = addr;
+				extra[i].len = sg->length;
+				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
+			}
 		}
 	}
 
@@ -1367,7 +1367,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].indir = extra;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1381,7 +1381,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	err_idx = i;
 
 	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+		vring_unmap_extra_packed(vq, &extra[i]);
 
 free_desc:
 	kfree(desc);
@@ -1504,7 +1504,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	/* Store token. */
 	vq->packed.desc_state[id].num = descs_used;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
+	vq->packed.desc_state[id].indir = ctx;
 	vq->packed.desc_state[id].last = prev;
 
 	/*
@@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
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
 		kfree(desc);
-		state->indir_desc = NULL;
+		state->indir = NULL;
 	} else if (ctx) {
-		*ctx = state->indir_desc;
+		*ctx = state->indir;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


