Return-Path: <bpf+bounces-44563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B19C4BCF
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3338EB221B7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B5207A06;
	Tue, 12 Nov 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fe3om4kE"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A529205E1E;
	Tue, 12 Nov 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374983; cv=none; b=Ecg7hzBBqm+XdEDiNfZgcYdc59c4M6ATpM/hkDwkc4o00b5QfnWLbrnprP0rLjwUKE3L4BOQ/Sqf8GYTICjt1d4JBBZ6NPTjcFcZXW8chMY6IeBZDEDgH70/8AgcA3GnsmBEVjysDrdU0IlTTOLGmAaA6lY15znjnikekPvzJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374983; c=relaxed/simple;
	bh=jO7iqAJh4ndoeDhawlBaImW2dKTZ8pU4BbfVp+IlBFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgdTNxedT791dou9XAEtkL3Mn7EqYqJsz4uczKJViERQzrccx6MTtTN60btpfwCA6HLu5McxQpJ1J6TsMKjJ/hzz/Oj6dVN6Pf1o8oBPwtYaApTA2ajQW6NPqHSJWT/PaEX+yPHb199YrM7/qzjSEHF5I6jtdm51por27eRBYfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fe3om4kE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731374973; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5zf8bWEk7EYITdYi8lxycQ7RMhl2qgJuoi488tokFuQ=;
	b=Fe3om4kEtuZb7NxEadHJe+mc6XAkfX1RJHQ5JaICPYINNbUSoEpK1AKRnuSdYsOrONrxBb6/l77swPR0mBuEGJ9QkMRIurpiPeQ5qlmhEQ7OYpxXe0wCAvx/mqSjZyBpFYRrCbGHVkUFToePRD+vCJhGnLrsBmvsiwlqFcjCa/g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJF5pzt_1731374971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:29:32 +0800
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
Subject: [PATCH net-next v4 03/13] virtio_ring: packed: record extras for indirect buffers
Date: Tue, 12 Nov 2024 09:29:18 +0800
Message-Id: <20241112012928.102478-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
References: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ee9bd377a389
Content-Transfer-Encoding: 8bit

The subsequent commit needs to know whether every indirect buffer is
premapped or not. So we need to introduce an extra struct for every
indirect buffer to record this info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 60 +++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 405d5a348795..cfe70c40f630 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,7 +78,11 @@ struct vring_desc_state_split {
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+
+	/* Indirect desc table and extra table, if any. These two will be
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


