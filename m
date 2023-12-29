Return-Path: <bpf+bounces-18727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031C81FDAE
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 08:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB7F285068
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD8125C2;
	Fri, 29 Dec 2023 07:31:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766111CB3;
	Fri, 29 Dec 2023 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQsY0C_1703835094;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQsY0C_1703835094)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 22/27] virtio_net: xsk: rx: support fill with xsk buffer
Date: Fri, 29 Dec 2023 15:31:03 +0800
Message-Id: <20231229073108.57778-23-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

Implement the logic of filling rq with XSK buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  9 +++++-
 drivers/net/virtio/virtio_net.h |  2 ++
 drivers/net/virtio/xsk.c        | 51 ++++++++++++++++++++++++++++++++-
 drivers/net/virtio/xsk.h        |  2 ++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 325d39c39792..264ab8aa5da5 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -1790,6 +1790,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 	int err;
 	bool oom;
 
+	if (rq->xsk.pool) {
+		err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
+		goto kick;
+	}
+
 	do {
 		if (vi->mergeable_rx_bufs)
 			err = add_recvbuf_mergeable(vi, rq, gfp);
@@ -1798,10 +1803,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 		else
 			err = add_recvbuf_small(vi, rq, gfp);
 
-		oom = err == -ENOMEM;
 		if (err)
 			break;
 	} while (rq->vq->num_free);
+
+kick:
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
 		unsigned long flags;
 
@@ -1810,6 +1816,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}
 
+	oom = err == -ENOMEM;
 	return !oom;
 }
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index f8b8f4f5b8b3..eaa5da0b0b3c 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -129,6 +129,8 @@ struct virtnet_rq {
 
 		/* xdp rxq used by xsk */
 		struct xdp_rxq_info xdp_rxq;
+
+		struct xdp_buff **xsk_buffs;
 	} xsk;
 };
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 0c6a8f92ae38..c54cd08e9c77 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -14,6 +14,47 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
+			    struct xsk_buff_pool *pool, gfp_t gfp)
+{
+	struct xdp_buff **xsk_buffs;
+	dma_addr_t addr;
+	u32 len, i;
+	int err = 0;
+	int num;
+
+	xsk_buffs = rq->xsk.xsk_buffs;
+
+	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
+	if (!num)
+		return -ENOMEM;
+
+	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+
+	for (i = 0; i < num; ++i) {
+		/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
+		addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
+
+		sg_init_table(rq->sg, 1);
+		sg_fill_dma(rq->sg, addr, len);
+
+		err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
+		if (err)
+			goto err;
+	}
+
+	return num;
+
+err:
+	if (i)
+		err = i;
+
+	for (; i < num; ++i)
+		xsk_buff_free(xsk_buffs[i]);
+
+	return err;
+}
+
 static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
 				struct xsk_buff_pool *pool,
 				struct xdp_desc *desc)
@@ -210,7 +251,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct virtnet_sq *sq;
 	struct device *dma_dev;
 	dma_addr_t hdr_dma;
-	int err;
+	int err, size;
 
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
@@ -246,6 +287,12 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EPERM;
 
+	size = virtqueue_get_vring_size(rq->vq);
+
+	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
+	if (!rq->xsk.xsk_buffs)
+		return -ENOMEM;
+
 	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, hdr_dma))
 		return -ENOMEM;
@@ -304,6 +351,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
 
+	kfree(rq->xsk.xsk_buffs);
+
 	return err1 | err2;
 }
 
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 7ebc9bda7aee..bef41a3f954e 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
+int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
+			    struct xsk_buff_pool *pool, gfp_t gfp);
 #endif
-- 
2.32.0.3.g01195cf9f


