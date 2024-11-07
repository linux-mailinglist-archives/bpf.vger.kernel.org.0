Return-Path: <bpf+bounces-44216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBD9C00BD
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 10:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A2F1C21E85
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF121E103C;
	Thu,  7 Nov 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m35W4CC2"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F731DFE33;
	Thu,  7 Nov 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970029; cv=none; b=BEno49Gk10fY/frU0h+n8Tyf5ZpIktOU7rzp1S4RpPB3lBI7tm8RFtABsewoTdhaMXaPJjVM8E+hxqsGQ94tOjJtEgrV7sRc2rCdKOiT6EGZr1TlRn69UNBfSjzM652bnSE9KF2f8DQfMm3S6cpmj6p6tpxgJgTBo3rLie9gtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970029; c=relaxed/simple;
	bh=2wrVsnJkmIFjBWYbByhcEgEpjPaTXUOPsoNSKAsOXPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKS6YdXDhDjFgeFpdWoIcuodShyv2mNWqwSVJJKVdTsB1rkntKUee3JqkdqfgY6YpSXln/HVEwU8L1UV/vXqRb+vHjKYBXzqc03uuhaJWUvZtY/tZ22NX83xGkV4E1UWrK8Ed68tVlZM18jIAK7+Qq2WFO5LKOsPP1PktUwHQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m35W4CC2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730970025; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LHfNUJKLWIQvJsxY7ytRb+qS1OX+a03H1JK3ekZWhSk=;
	b=m35W4CC2anklLslnzzgbV58LwkD7QGGU2xUKxKr6mf5+l98JOf2OOgQbsbAUaVP1zuOSVtdGeXUGX1ObigDNsxUX+hCXO31jmLFyKcSs0Q3Vq44o7HD6dMi+tONYC58KpHlpZbYxLuNDjQC0ja/7WF6FVgiAD2Jslqioei4Q4Ck=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIv0ukX_1730969711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:12 +0800
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
Subject: [PATCH net-next v3 07/13] virtio_ring: remove API virtqueue_set_dma_premapped
Date: Thu,  7 Nov 2024 16:54:58 +0800
Message-Id: <20241107085504.63131-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2634baada01d
Content-Transfer-Encoding: 8bit

Now, this API is useless. remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c     | 13 ----------
 drivers/virtio/virtio_ring.c | 48 ------------------------------------
 include/linux/virtio.h       |  2 --
 3 files changed, 63 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 862beacef5d7..e4ebf3ffbf02 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6107,15 +6107,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	return -ENOMEM;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
-{
-	int i;
-
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
-}
-
 static int init_vqs(struct virtnet_info *vi)
 {
 	int ret;
@@ -6129,10 +6120,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	/* disable for big mode */
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
-		virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 26d218f6235d..38bea08f0469 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -180,9 +180,6 @@ struct vring_virtqueue {
 	/* Host publishes avail event idx */
 	bool event;
 
-	/* Do DMA mapping by driver */
-	bool premapped;
-
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -2098,7 +2095,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2689,7 +2685,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 #endif
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2816,49 +2811,6 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
-/**
- * virtqueue_set_dma_premapped - set the vring premapped mode
- * @_vq: the struct virtqueue we're talking about.
- *
- * Enable the premapped mode of the vq.
- *
- * The vring in premapped mode does not do dma internally, so the driver must
- * do dma mapping in advance. The driver must pass the dma_address through
- * dma_address of scatterlist. When the driver got a used buffer from
- * the vring, it has to unmap the dma address.
- *
- * This function must be called immediately after creating the vq, or after vq
- * reset, and before adding any buffers to it.
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error.
- * 0: success.
- * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
- */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	u32 num;
-
-	START_USE(vq);
-
-	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
-
-	if (num != vq->vq.num_free) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
-	vq->premapped = true;
-
-	END_USE(vq);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
-
 /**
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 13b3f55abca3..338e0f5efb4b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -93,8 +93,6 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
-
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f


