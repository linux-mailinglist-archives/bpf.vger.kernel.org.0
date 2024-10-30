Return-Path: <bpf+bounces-43520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9622E9B5DA0
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B1B1C210CF
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD481E1C07;
	Wed, 30 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BsL3Jhwk"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943A1E0DF9;
	Wed, 30 Oct 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276705; cv=none; b=eDf8hpRsqp0eigFsjTbFRtrdDciTi4PM5IqNouceQ2GTTE7quF0GLMGqTh3TXIl6bi7WUUDG20yu4YelKYAXbLQJ5qx95cpx+RP7sM+8F/0ut20tCglcLNuxmlqTYcPJ9ApzrSRR/Lg3aiR42amm5cv8fuqlHW6+ggAQwJH7d5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276705; c=relaxed/simple;
	bh=w3BjLqUCElG+9dqCfeLTahOVkU65kyd1y2uVgU12qjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgm931afnsTwf3kWSxLT2zng4V2Pf8ErHvaJPv0NhKyVsWpN07fF8R0Y7ibCQMFuAOUjoF/BLz1X4UJIOG8yBsB/s3nA6rh5smWAnfwLvFwDWIdWQmpWMh2hLsjVj2dFNiI73jf4hDMTpOtqxOaZlKc48auvnZdWsPFg74rCbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BsL3Jhwk; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276698; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6zy2mKpVJhuN2RI1VIOiGC8xRxOQlWcy6/t2+Wv2Fv4=;
	b=BsL3JhwkpDKi/Z0YIZqTeYpAscXJBYoWXqih849VWEysLohphtUbAwhKckLsdEJIpmIVuPbvsf0CSGxE3P5Ppfd4wiPQkxyEKt1tecMJe1w/+u9l8eCkW/jVnxdA9pg8HT1TCuGYwLo4cDd0+cJA0h7MSMyrPT8hrSQCq+UnkMI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDHQNT_1730276697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:24:58 +0800
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
Subject: [PATCH net-next v2 04/13] virtio_ring: perform premapped operations based on per-buffer
Date: Wed, 30 Oct 2024 16:24:44 +0800
Message-Id: <20241030082453.97310-5-xuanzhuo@linux.alibaba.com>
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

The current configuration sets the virtqueue (vq) to premapped mode,
implying that all buffers submitted to this queue must be mapped ahead
of time. This presents a challenge for the virtnet send queue (sq): the
virtnet driver would be required to keep track of dma information for vq
size * 17, which can be substantial. However, if the premapped mode were
applied on a per-buffer basis, the complexity would be greatly reduced.
With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
skb buffers could remain unmapped.

And consider that some sgs are not generated by the virtio driver,
that may be passed from the block stack. So we can not change the
sgs, new APIs are the better way.

So we pass the new argument 'premapped' to indicate the buffers
submitted to virtio are premapped in advance. Additionally,
DMA unmap operations for these buffers will be bypassed.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 79 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 628e01af1c9a..a89295b79e66 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -300,9 +300,10 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 	return false;
 }
 
-static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
+static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring,
+				    const struct vring_desc_extra *extra)
 {
-	return vring->use_dma_api && !vring->premapped;
+	return vring->use_dma_api && (extra->addr != DMA_MAPPING_ERROR);
 }
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
@@ -372,9 +373,10 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
-			    enum dma_data_direction direction, dma_addr_t *addr)
+			    enum dma_data_direction direction, dma_addr_t *addr,
+			    bool premapped)
 {
-	if (vq->premapped) {
+	if (premapped) {
 		*addr = sg_dma_address(sg);
 		return 0;
 	}
@@ -465,7 +467,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vring_need_unmap_buffer(vq))
+		if (!vring_need_unmap_buffer(vq, extra))
 			goto out;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -514,7 +516,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    unsigned int i,
 						    dma_addr_t addr,
 						    unsigned int len,
-						    u16 flags)
+						    u16 flags, bool premapped)
 {
 	u16 next;
 
@@ -522,7 +524,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
 	desc[i].len = cpu_to_virtio32(vq->vdev, len);
 
-	extra[i].addr = addr;
+	extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
 	extra[i].len = len;
 	extra[i].flags = flags;
 
@@ -540,6 +542,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      unsigned int in_sgs,
 				      void *data,
 				      void *ctx,
+				      bool premapped,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -606,7 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 
-			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr))
+			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, premapped))
 				goto unmap_release;
 
 			prev = i;
@@ -614,14 +617,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			 * table since it use stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, sg->length,
-						     VRING_DESC_F_NEXT);
+						     VRING_DESC_F_NEXT,
+						     premapped);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 
-			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr))
+			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, premapped))
 				goto unmap_release;
 
 			prev = i;
@@ -631,12 +635,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE);
+						     VRING_DESC_F_WRITE,
+						     premapped);
 		}
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vring_need_unmap_buffer(vq))
+	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
@@ -645,18 +650,14 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		dma_addr_t addr = vring_map_single(
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
-		if (vring_mapping_error(vq, addr)) {
-			if (vq->premapped)
-				goto free_indirect;
-
+		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
-		}
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
 					 vq->split.desc_extra,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT);
+					 VRING_DESC_F_INDIRECT, false);
 	}
 
 	/* We're using some buffers from the free list. */
@@ -713,7 +714,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		i = vring_unmap_one_split(vq, &extra[i]);
 	}
 
-free_indirect:
 	if (indirect)
 		kfree(desc);
 
@@ -798,7 +798,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		extra = (struct vring_desc_extra *)&indir_desc[num];
 
-		if (vring_need_unmap_buffer(vq)) {
+		if (vq->use_dma_api) {
 			for (j = 0; j < num; j++)
 				vring_unmap_one_split(vq, &extra[j]);
 		}
@@ -1232,7 +1232,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vring_need_unmap_buffer(vq))
+		if (!vring_need_unmap_buffer(vq, extra))
 			return;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -1276,6 +1276,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
 					 void *data,
+					 bool premapped,
 					 gfp_t gfp)
 {
 	struct vring_desc_extra *extra;
@@ -1306,7 +1307,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
-					     DMA_TO_DEVICE : DMA_FROM_DEVICE, &addr))
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
+					     &addr, premapped))
 				goto unmap_release;
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
@@ -1315,7 +1317,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].len = cpu_to_le32(sg->length);
 
 			if (unlikely(vq->use_dma_api)) {
-				extra[i].addr = addr;
+				extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
 				extra[i].len = sg->length;
 				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
 			}
@@ -1328,12 +1330,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	addr = vring_map_single(vq, desc,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
-	if (vring_mapping_error(vq, addr)) {
-		if (vq->premapped)
-			goto free_desc;
-
+	if (vring_mapping_error(vq, addr))
 		goto unmap_release;
-	}
 
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
@@ -1391,7 +1389,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (i = 0; i < err_idx; i++)
 		vring_unmap_extra_packed(vq, &extra[i]);
 
-free_desc:
 	kfree(desc);
 
 	END_USE(vq);
@@ -1405,6 +1402,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 				       unsigned int in_sgs,
 				       void *data,
 				       void *ctx,
+				       bool premapped,
 				       gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -1431,7 +1429,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, gfp);
+						    in_sgs, data, premapped, gfp);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1466,7 +1464,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			dma_addr_t addr;
 
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
-					     DMA_TO_DEVICE : DMA_FROM_DEVICE, &addr))
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
+					     &addr, premapped))
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
@@ -1482,7 +1481,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].id = cpu_to_le16(id);
 
 			if (unlikely(vq->use_dma_api)) {
-				vq->packed.desc_extra[curr].addr = addr;
+				vq->packed.desc_extra[curr].addr = premapped ?
+					DMA_MAPPING_ERROR : addr;
 				vq->packed.desc_extra[curr].len = sg->length;
 				vq->packed.desc_extra[curr].flags =
 					le16_to_cpu(flags);
@@ -1633,7 +1633,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vring_need_unmap_buffer(vq)) {
+		if (vq->use_dma_api) {
 			len = vq->packed.desc_extra[id].len;
 			num = len / sizeof(struct vring_packed_desc);
 
@@ -2204,14 +2204,15 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				unsigned int in_sgs,
 				void *data,
 				void *ctx,
+				bool premapped,
 				gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp) :
+					out_sgs, in_sgs, data, ctx, premapped, gfp) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp);
+					out_sgs, in_sgs, data, ctx, premapped, gfp);
 }
 
 /**
@@ -2245,7 +2246,7 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 			total_sg++;
 	}
 	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
-			     data, NULL, gfp);
+			     data, NULL, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
@@ -2267,7 +2268,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -2289,7 +2290,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
@@ -2313,7 +2314,7 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			void *ctx,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
-- 
2.32.0.3.g01195cf9f


