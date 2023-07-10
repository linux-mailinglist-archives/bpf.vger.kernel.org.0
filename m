Return-Path: <bpf+bounces-4554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7CD74CAC0
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 05:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F30280EE0
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 03:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2A23B7;
	Mon, 10 Jul 2023 03:42:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96940210C;
	Mon, 10 Jul 2023 03:42:47 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A3C2;
	Sun,  9 Jul 2023 20:42:45 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VmxH3ag_1688960560;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VmxH3ag_1688960560)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 11:42:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH vhost v11 02/10] virtio_ring: put mapping error check in vring_map_one_sg
Date: Mon, 10 Jul 2023 11:42:29 +0800
Message-Id: <20230710034237.12391-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 39991abed41c
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch put the dma addr error check in vring_map_one_sg().

The benefits of doing this:

1. reduce one judgment of vq->use_dma_api.
2. make vring_map_one_sg more simple, without calling
   vring_mapping_error to check the return value. simplifies subsequent
   code

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 37 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f8754f1d64d3..87d7ceeecdbd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -355,9 +355,8 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 }
 
 /* Map one sg entry. */
-static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
-				   struct scatterlist *sg,
-				   enum dma_data_direction direction)
+static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
+			    enum dma_data_direction direction, dma_addr_t *addr)
 {
 	if (!vq->use_dma_api) {
 		/*
@@ -366,7 +365,8 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 		 * depending on the direction.
 		 */
 		kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, direction);
-		return (dma_addr_t)sg_phys(sg);
+		*addr = (dma_addr_t)sg_phys(sg);
+		return 0;
 	}
 
 	/*
@@ -374,9 +374,14 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 	 * the way it expects (we don't guarantee that the scatterlist
 	 * will exist for the lifetime of the mapping).
 	 */
-	return dma_map_page(vring_dma_dev(vq),
+	*addr = dma_map_page(vring_dma_dev(vq),
 			    sg_page(sg), sg->offset, sg->length,
 			    direction);
+
+	if (dma_mapping_error(vring_dma_dev(vq), *addr))
+		return -ENOMEM;
+
+	return 0;
 }
 
 static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
@@ -588,8 +593,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
-			if (vring_mapping_error(vq, addr))
+			dma_addr_t addr;
+
+			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr))
 				goto unmap_release;
 
 			prev = i;
@@ -603,8 +609,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
+			dma_addr_t addr;
+
+			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr))
 				goto unmap_release;
 
 			prev = i;
@@ -1281,9 +1288,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
+			if (vring_map_one_sg(vq, sg, n < out_sgs ?
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE, &addr))
 				goto unmap_release;
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
@@ -1428,9 +1434,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	c = 0;
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
+			dma_addr_t addr;
+
+			if (vring_map_one_sg(vq, sg, n < out_sgs ?
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE, &addr))
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
-- 
2.32.0.3.g01195cf9f


