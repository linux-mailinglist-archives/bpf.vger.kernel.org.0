Return-Path: <bpf+bounces-40228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B077983AE6
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 03:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3071C2227A
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 01:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3649627;
	Tue, 24 Sep 2024 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uBfxXXPu"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6010940;
	Tue, 24 Sep 2024 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141540; cv=none; b=crdU6vdmIx1qKMFT3+2EFuctsganie6BB300fX+sVAyPvoBFWD0Ha9uJmVB6lKCHYte7RfoE7pc7X+M8IEG2uvwSPEubowbKpdJ1ALL0ADSIwoGNe9I7UTZm3Mllb4r7LYxsrahWxkeJMKac5fYmFoPzd1mhe2h49dsf3rRQma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141540; c=relaxed/simple;
	bh=ukIonbgvo1NU05jAHmHLCurbDZV+cZZAhcwZa71WTUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kt07geEcofCkEl6bWh40jO5NUPMzSaIBl1JaAjGgajawW1WiWRzbpi1s/R8+19NeZTjdn+U2sUqKc5Dwui1apsVn1XywES6olmNzrDDjDhURfveBo8vDy57hNgziuLBNSYeT/WjAbUegjf84t7ftapGWYYVao9VPJ05gqgPvAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uBfxXXPu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727141529; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GFhzlnBOtR2UDiCS0yiynOTqyh1mXiI74ZbURlMsUcg=;
	b=uBfxXXPu/o0z9LGbK1re/5rd2wgqTclWiTMM/PczLhOHDvjP/eNRava6lG3SpiO8vFUP/me+VlBoExPZKhDSaoE1mqswkLCkxdUnURhtyHM7bIkBWMQNaRJXS5qGfwygH5nZOLmZPIUsPMkrIm+t9rd4PmPuDyjONeB0ekW4/d4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFe1Fh._1727141528)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:32:09 +0800
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
Subject: [RFC net-next v1 04/12] virtio_ring: perform premapped operations based on per-buffer
Date: Tue, 24 Sep 2024 09:31:56 +0800
Message-Id: <20240924013204.13763-5-xuanzhuo@linux.alibaba.com>
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

The current configuration sets the virtqueue (vq) to premapped mode,
implying that all buffers submitted to this queue must be mapped ahead
of time. This presents a challenge for the virtnet send queue (sq): the
virtnet driver would be required to keep track of dma information for vq
size * 17, which can be substantial. However, if the premapped mode were
applied on a per-buffer basis, the complexity would be greatly reduced.
With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
skb buffers could remain unmapped.

We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
indicates that the driver has performed DMA mapping in advance, allowing
the Virtio core to directly utilize sg_dma_address(sg) without
conducting any internal DMA mapping. Additionally, DMA unmap operations
for this buffer will be bypassed.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 67 +++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7d5fed4ff4f8..b570acb35d97 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -243,6 +243,7 @@ static void vring_free(struct virtqueue *_vq);
  */
 
 #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
+#define sg_is_premapped(sg) (!sg_page(sg))
 
 static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
 				   unsigned int total_sg)
@@ -300,9 +301,10 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
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
@@ -374,7 +376,7 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
 {
-	if (vq->premapped) {
+	if (sg_is_premapped(sg)) {
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
@@ -518,7 +520,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    dma_addr_t addr,
 						    unsigned int len,
 						    u16 flags,
-						    bool indirect)
+						    bool indirect, bool premapped)
 {
 	u16 next;
 
@@ -526,7 +528,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
 	desc[i].len = cpu_to_virtio32(vq->vdev, len);
 
-	extra[i].addr = addr;
+	extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
 	extra[i].len = len;
 	extra[i].flags = flags;
 
@@ -619,7 +621,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			 */
 			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, sg->length,
 						     VRING_DESC_F_NEXT,
-						     indirect);
+						     indirect, sg_is_premapped(sg));
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -637,12 +639,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
-						     indirect);
+						     indirect, sg_is_premapped(sg));
 		}
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vring_need_unmap_buffer(vq))
+	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
@@ -651,19 +653,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
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
 					 VRING_DESC_F_INDIRECT,
-					 false);
+					 false, false);
 	}
 
 	/* We're using some buffers from the free list. */
@@ -720,7 +718,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		i = vring_unmap_one_split(vq, &extra[i]);
 	}
 
-free_indirect:
 	if (indirect)
 		kfree(desc);
 
@@ -802,7 +799,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		if (vring_need_unmap_buffer(vq)) {
+		if (vq->use_dma_api) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
 				vring_unmap_one_split(vq, &extra[j]);
 		}
@@ -1236,7 +1233,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vring_need_unmap_buffer(vq))
+		if (!vring_need_unmap_buffer(vq, extra))
 			return;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -1318,7 +1315,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].len = cpu_to_le32(sg->length);
 
 			if (unlikely(vq->use_dma_api)) {
-				extra[i].addr = addr;
+				extra[i].addr = sg_is_premapped(sg) ? DMA_MAPPING_ERROR : addr;
 				extra[i].len = sg->length;
 				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
 			}
@@ -1331,12 +1328,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
@@ -1394,7 +1387,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (i = 0; i < err_idx; i++)
 		vring_unmap_extra_packed(vq, &extra[i]);
 
-free_desc:
 	kfree(desc);
 
 	END_USE(vq);
@@ -1485,7 +1477,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].id = cpu_to_le16(id);
 
 			if (unlikely(vq->use_dma_api)) {
-				vq->packed.desc_extra[curr].addr = addr;
+				vq->packed.desc_extra[curr].addr = sg_is_premapped(sg) ?
+					DMA_MAPPING_ERROR : addr;
 				vq->packed.desc_extra[curr].len = sg->length;
 				vq->packed.desc_extra[curr].flags =
 					le16_to_cpu(flags);
@@ -1635,7 +1628,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!extra)
 			return;
 
-		if (vring_need_unmap_buffer(vq)) {
+		if (vq->use_dma_api) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2222,6 +2215,11 @@ static inline int virtqueue_add(struct virtqueue *_vq,
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
+ * When sg_page(sg) is NULL, this indicates that the driver has performed DMA
+ * mapping in advance, allowing the virtio core to directly utilize
+ * sg_dma_address(sg) without conducting any internal DMA mapping. Additionally,
+ * DMA unmap operations for this buffer will be bypassed.
+ *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
@@ -2256,6 +2254,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
+ * When sg_page(sg) is NULL, this indicates that the driver has performed DMA
+ * mapping in advance, allowing the virtio core to directly utilize
+ * sg_dma_address(sg) without conducting any internal DMA mapping. Additionally,
+ * DMA unmap operations for this buffer will be bypassed.
+ *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
@@ -2278,6 +2281,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
+ * When sg_page(sg) is NULL, this indicates that the driver has performed DMA
+ * mapping in advance, allowing the virtio core to directly utilize
+ * sg_dma_address(sg) without conducting any internal DMA mapping. Additionally,
+ * DMA unmap operations for this buffer will be bypassed.
+ *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
@@ -2301,6 +2309,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
  * @ctx: extra context for the token
  * @gfp: how to do memory allocations (if necessary).
  *
+ * When sg_page(sg) is NULL, this indicates that the driver has performed DMA
+ * mapping in advance, allowing the virtio core to directly utilize
+ * sg_dma_address(sg) without conducting any internal DMA mapping. Additionally,
+ * DMA unmap operations for this buffer will be bypassed.
+ *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
-- 
2.32.0.3.g01195cf9f


