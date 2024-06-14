Return-Path: <bpf+bounces-32166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7C9083D2
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB26B23248
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224B149DEE;
	Fri, 14 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lsfEo7KU"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD21487DA;
	Fri, 14 Jun 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347187; cv=none; b=ECRUcBDTdYgVvONtRcyY/5emwugUSsx++9o6aKJsaDeP9hWAjEDh3sNiQVsqCsExTdPHgpXNl4Vf+UXjhsL1/Qnq8ByvJr9x+svh/C3K9OPmrVv3MH0ce/7VZOX+pyW4EqmeyGtCowtytRM0bQ61MAG7+a7b5La20NnmGAuMOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347187; c=relaxed/simple;
	bh=azwKvLrDj+U1MX9tcdt5NVQKEQx9FFum6cYUX0Ap8Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSYPihPdkDZ31Ww/8LFMCWVGSuwpY+2/+HmCxHqB45LFHJ88lfEMiuYqgx96XW3og06AkcAaxi2GnKYrEgb5V+Pjaq9cH+cHdydQoZnk7YBagb9CDVD60kpD21oRFgssz6SLFMRSe2dyairDB2Xd1lFw1n6W/2TaxEzH4T2zXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lsfEo7KU; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347176; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wz/gNoMpTBu5PmKOqW/HPAECwFWfSfMba3ie/30qSS4=;
	b=lsfEo7KU1zKNA1s7f1PFna5iYsbWxI8EUcUpK+TWE8i/oOf+6abz6WwStF+2payFkyu2PAPA127UuyCzBwDrsDSVsnwN5AYPFxBfR8xRBKw21yeg16cK/RTY4LZrcrb/8q4RghswuImFDM9KramgcM7htLFb8+AAh+YK7D+VT7c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QEk8Y_1718347175;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QEk8Y_1718347175)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:36 +0800
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
Subject: [PATCH net-next v5 02/15] virtio_ring: introduce vring_need_unmap_buffer
Date: Fri, 14 Jun 2024 14:39:20 +0800
Message-Id: <20240614063933.108811-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e008fb4a0943
Content-Transfer-Encoding: 8bit

To make the code readable, introduce vring_need_unmap_buffer() to
replace do_unmap.

   use_dma_api premapped -> vring_need_unmap_buffer()
1. false       false        false
2. true        false        true
3. true        true         false

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e8caa6f24704..d0d3004a408a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -175,11 +175,6 @@ struct vring_virtqueue {
 	/* Do DMA mapping by driver */
 	bool premapped;
 
-	/* Do unmap or not for desc. Just when premapped is False and
-	 * use_dma_api is true, this is true.
-	 */
-	bool do_unmap;
-
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -297,6 +292,11 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 	return false;
 }
 
+static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
+{
+	return vring->use_dma_api && !vring->premapped;
+}
+
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
@@ -445,7 +445,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vring_need_unmap_buffer(vq))
 		return;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
@@ -475,7 +475,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vq->do_unmap)
+		if (!vring_need_unmap_buffer(vq))
 			goto out;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -643,7 +643,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vq->do_unmap)
+	if (!indirect && vring_need_unmap_buffer(vq))
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
@@ -802,7 +802,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		if (vq->do_unmap) {
+		if (vring_need_unmap_buffer(vq)) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
 				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
 		}
@@ -1236,7 +1236,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vq->do_unmap)
+		if (!vring_need_unmap_buffer(vq))
 			return;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -1251,7 +1251,7 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vring_need_unmap_buffer(vq))
 		return;
 
 	flags = le16_to_cpu(desc->flags);
@@ -1632,7 +1632,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->do_unmap) {
+		if (vring_need_unmap_buffer(vq)) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2091,7 +2091,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2636,7 +2635,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2799,7 +2797,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 	}
 
 	vq->premapped = true;
-	vq->do_unmap = false;
 
 	END_USE(vq);
 
-- 
2.32.0.3.g01195cf9f


