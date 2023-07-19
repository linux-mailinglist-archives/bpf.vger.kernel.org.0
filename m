Return-Path: <bpf+bounces-5249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF5758C5B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 06:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C313428190D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0AC15E;
	Wed, 19 Jul 2023 04:04:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F2BE65;
	Wed, 19 Jul 2023 04:04:34 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0CA119;
	Tue, 18 Jul 2023 21:04:32 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vnk0JAa_1689739467;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vnk0JAa_1689739467)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 12:04:28 +0800
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
Subject: [PATCH vhost v12 04/10] virtio_ring: support add premapped buf
Date: Wed, 19 Jul 2023 12:04:16 +0800
Message-Id: <20230719040422.126357-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230719040422.126357-1-xuanzhuo@linux.alibaba.com>
References: <20230719040422.126357-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: fc7afa711e97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the vq is the premapped mode, use the sg_dma_address() directly.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8e81b01e0735..f9f772e85a38 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
 {
+	if (vq->premapped) {
+		*addr = sg_dma_address(sg);
+		return 0;
+	}
+
 	if (!vq->use_dma_api) {
 		/*
 		 * If DMA is not used, KMSAN doesn't know that the scatterlist
@@ -639,8 +644,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		dma_addr_t addr = vring_map_single(
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
-		if (vring_mapping_error(vq, addr))
+		if (vring_mapping_error(vq, addr)) {
+			if (vq->premapped)
+				goto free_indirect;
+
 			goto unmap_release;
+		}
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
 					 head, addr,
@@ -706,6 +715,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			i = vring_unmap_one_split(vq, i);
 	}
 
+free_indirect:
 	if (indirect)
 		kfree(desc);
 
@@ -1307,8 +1317,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	addr = vring_map_single(vq, desc,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
-	if (vring_mapping_error(vq, addr))
+	if (vring_mapping_error(vq, addr)) {
+		if (vq->premapped)
+			goto free_desc;
+
 		goto unmap_release;
+	}
 
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
@@ -1366,6 +1380,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (i = 0; i < err_idx; i++)
 		vring_unmap_desc_packed(vq, &desc[i]);
 
+free_desc:
 	kfree(desc);
 
 	END_USE(vq);
-- 
2.32.0.3.g01195cf9f


