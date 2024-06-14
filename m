Return-Path: <bpf+bounces-32174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C19083E9
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FB6285EE1
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB11836C7;
	Fri, 14 Jun 2024 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HgyH5+d3"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372A1836FE;
	Fri, 14 Jun 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347191; cv=none; b=elgPZPYDLSKfVDzQ2MnskhfszdToYX/qR7yR/+yZZFTuC3lW+faLNWAe+3eE1pHNPmwVV/LBhM8bocqcKr2ldxTWKsZZXVEVt5JgozKd7u0SgOM6hlrh1PYdvMQoxyzctYKxqFaEqwgV53QDMpFNf3cjEV8Mv4htqHcgNEVOt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347191; c=relaxed/simple;
	bh=9I01Lwl2TpiEZN5qEofkAVWb/D3UjnwYft8EofcPXv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNdFAb2RDmvq3Q9yPR1D1GLKiVS2OfTFxBDxRBmCuLGGf8ICqxeXx1u5ECIUXIUJHL/GWiGp6+f3vptHNgpL4dmGX5wvfFUL9PHccGqyQP6gFJ8zb33bXzAxiTBRRaaO2NIoqkpRZ61BOKMIaDQkBv9GjgR/V0PUeGq1yrZEEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HgyH5+d3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347187; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9Umv27qjMXQboC0xgAvDAY4yYsoXM/5r3TmBkvb6Qbg=;
	b=HgyH5+d3LSeUCaYnQx3mj2u+/utgti6CbdsJveJYj3wdWLF/qbUpAYn4RYRslJclCr7Hz8juokbWk9AZZYp+cRsU6OVSpnta0ptmYDDpueNOvQDKOdza9n/PlZh8YIcGRTwl8+hnFDhJUz5wdGJz+DcJHVCJ6HLSeTT8gAC9+yY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QKgWR_1718347185;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QKgWR_1718347185)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:46 +0800
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
Subject: [PATCH net-next v5 14/15] virtio_net: xsk: rx: support fill with xsk buffer
Date: Fri, 14 Jun 2024 14:39:32 +0800
Message-Id: <20240614063933.108811-15-xuanzhuo@linux.alibaba.com>
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

Implement the logic of filling rq with XSK buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d6be569bd849..4e5645d8bb7d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -388,6 +388,8 @@ struct receive_queue {
 
 		/* xdp rxq used by xsk */
 		struct xdp_rxq_info xdp_rxq;
+
+		struct xdp_buff **xsk_buffs;
 	} xsk;
 };
 
@@ -532,6 +534,8 @@ struct virtio_net_common_hdr {
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
+				   struct xsk_buff_pool *pool, gfp_t gfp);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -1304,6 +1308,47 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
+				   struct xsk_buff_pool *pool, gfp_t gfp)
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
 static int virtnet_xsk_xmit_one(struct send_queue *sq,
 				struct xsk_buff_pool *pool,
 				struct xdp_desc *desc)
@@ -2560,6 +2605,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
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
@@ -2568,10 +2618,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
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
 
@@ -2580,6 +2631,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}
 
+	oom = err == -ENOMEM;
 	return !oom;
 }
 
@@ -5449,7 +5501,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct send_queue *sq;
 	struct device *dma_dev;
 	dma_addr_t hdr_dma;
-	int err;
+	int err, size;
 
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
@@ -5484,6 +5536,12 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EPERM;
 
+	size = virtqueue_get_vring_size(rq->vq);
+
+	rq->xsk.xsk_buffs = kvcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
+	if (!rq->xsk.xsk_buffs)
+		return -ENOMEM;
+
 	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, hdr_dma))
 		return -ENOMEM;
@@ -5542,6 +5600,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
 
+	kvfree(rq->xsk.xsk_buffs);
+
 	return err1 | err2;
 }
 
-- 
2.32.0.3.g01195cf9f


