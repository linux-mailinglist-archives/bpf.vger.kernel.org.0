Return-Path: <bpf+bounces-32395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9F90C6BE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D751F22930
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816819F463;
	Tue, 18 Jun 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aH8tQgyq"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436D19E823;
	Tue, 18 Jun 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697421; cv=none; b=E1yur0yl7xvo8R9mRWAHMLDaJ+w8TYIiBvkxKxykv1mNZSyIyj8pZpRh5XDDYPOUjJpn4PYb32Jldcqyjsh5gz4J/ULGQxMiKXLyo8TxVERuCUiInjA5dWlGPGEL/qwA08pYr8/jpDJJcc7lGOGUyFcddrmuI5Rn/TbhO9rFNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697421; c=relaxed/simple;
	bh=TyA8CHQDmtVG5eRysWpeVW7NsJCu/g0ZIP0C750o9eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZmiZwRiH4cTqFLnxiSTP2+txSz5kF6GOLZxP6HdNDqsluY9qhWqMVeWmwyOUThdyp8IcjlSkgk8BzcV08QJGe0E5TIXgOVrJfx/PbfBuT/230MyBi5UQj7UBlyL26uMazCg4+xMWTxDbpDPxXDURCTstTdUB+uI2x1I8+8y+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aH8tQgyq; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697412; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=94KgcG7GKlEUjoYMTVEV4xVqh45PoOx57ZKvwpWl2EQ=;
	b=aH8tQgyqB6DXhVnlaqBvosAdMglWIeS/zvqildaerwV9O6k0m5dC6MI0ThtqmB3ZxbTztkA0TquiS68tOJhzOsDH4Rw0T+K12HsRs9e9ftlI1VUg4rSFuYGANk5fdD7+zoa46uCyArGgH82DYXbljW5CjPDslKFh2GoBKMLUYHw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jR7pa_1718697410;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jR7pa_1718697410)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:51 +0800
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
Subject: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with xsk buffer
Date: Tue, 18 Jun 2024 15:56:40 +0800
Message-Id: <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 8baa0af3684b
Content-Transfer-Encoding: 8bit

Implement the logic of filling rq with XSK buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 68 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2bbc715f22c6..2ac5668a94ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -355,6 +355,8 @@ struct receive_queue {
 
 		/* xdp rxq used by xsk */
 		struct xdp_rxq_info xdp_rxq;
+
+		struct xdp_buff **xsk_buffs;
 	} xsk;
 };
 
@@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
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
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2206,6 +2255,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
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
@@ -2214,10 +2268,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
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
 
@@ -2226,6 +2281,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}
 
+	oom = err == -ENOMEM;
 	return !oom;
 }
 
@@ -5050,7 +5106,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct receive_queue *rq;
 	struct device *dma_dev;
 	struct send_queue *sq;
-	int err;
+	int err, size;
 
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
@@ -5078,6 +5134,12 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EPERM;
 
+	size = virtqueue_get_vring_size(rq->vq);
+
+	rq->xsk.xsk_buffs = kvcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
+	if (!rq->xsk.xsk_buffs)
+		return -ENOMEM;
+
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
 		goto err_xsk_map;
@@ -5112,6 +5174,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	xsk_pool_dma_unmap(pool, 0);
 
+	kvfree(rq->xsk.xsk_buffs);
+
 	return err;
 }
 
-- 
2.32.0.3.g01195cf9f


