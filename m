Return-Path: <bpf+bounces-34066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E992A111
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F4C1C21066
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BB811E7;
	Mon,  8 Jul 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d7tt1yPo"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483980020;
	Mon,  8 Jul 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437951; cv=none; b=tF1OqZsuH8f5G6OFu4D2UJ9YeZEvfJDsqpBGd4hDk0jZH5Qwjn+/D+vfJ7Bf39ZjdbYIPXgyB5ltL4owF0I7u1vCrPQKyQUuamqpIBwcEjHA09FQgWKfrCL4jxM0Lgbo4V3xsdcS1If3TxWjIatIc4g38OUqqiFa9/x9/XBr3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437951; c=relaxed/simple;
	bh=4T8dos/gIQoSl2CjxclHXoUUkzFvs5X2dAbEuUCHIPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n85doQ6FoZwmpE1o/Kwq/FEJROuRQAwDUwKsrqyY6Op/eIBoz5GwoapHr769beAu5G/bFzmtUpA3XAbi8TzMY+urmebNiAayShLYXGbNCfSv7jruYy9W+aHMO0c1wRIlGL5QxpLgIP7qD5lMOB353QHsgB+ZSVDxU9HWodov3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d7tt1yPo; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720437947; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QNzbPlypE5M7FPDpfRuNaSBJDlB6Re8mzaIDOtd1vAw=;
	b=d7tt1yPot84/u7uRsnSkOfnM3bFe3fKGOrcGAo2mTQrCzaVOEPilHG+rZ+KKoMmjHKBmkTvcS40pzvA4vhLFBH8hxpRDDxdDvAnvBOxtnbq65HShEA/p2cj4BiDylOdm3dUXDu1QhkJkKUpkYqYeNjeNwzGd0DrghAc8CCqsL3U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA4mZfr_1720437946;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA4mZfr_1720437946)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 19:25:46 +0800
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
Subject: [PATCH net-next v8 08/10] virtio_net: xsk: rx: support fill with xsk buffer
Date: Mon,  8 Jul 2024 19:25:35 +0800
Message-Id: <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 74fbc055cff2
Content-Transfer-Encoding: 8bit

Implement the logic of filling rq with XSK buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

v8:
   1. update comment
   2. return err from virtnet_add_recvbuf_xsk() when encounters error

 drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 665b4925e545..a908f5e72677 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -354,6 +354,8 @@ struct receive_queue {

 	/* xdp rxq used by xsk */
 	struct xdp_rxq_info xsk_rxq_info;
+
+	struct xdp_buff **xsk_buffs;
 };

 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -1054,6 +1056,53 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
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
+	int err = 0;
+	u32 len, i;
+	int num;
+
+	xsk_buffs = rq->xsk_buffs;
+
+	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
+	if (!num)
+		return -ENOMEM;
+
+	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+
+	for (i = 0; i < num; ++i) {
+		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
+		 * We assume XDP_PACKET_HEADROOM is larger than hdr->len.
+		 * (see function virtnet_xsk_pool_enable)
+		 */
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
+	for (; i < num; ++i)
+		xsk_buff_free(xsk_buffs[i]);
+
+	return err;
+}
+
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2245,7 +2294,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 			  gfp_t gfp)
 {
 	int err;
-	bool oom;
+
+	if (rq->xsk_pool) {
+		err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk_pool, gfp);
+		goto kick;
+	}

 	do {
 		if (vi->mergeable_rx_bufs)
@@ -2255,10 +2308,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
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

@@ -2267,7 +2321,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}

-	return !oom;
+	return err != -ENOMEM;
 }

 static void skb_recv_done(struct virtqueue *rvq)
@@ -5104,7 +5158,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct receive_queue *rq;
 	struct device *dma_dev;
 	struct send_queue *sq;
-	int err;
+	int err, size;

 	if (vi->hdr_len > xsk_pool_get_headroom(pool))
 		return -EINVAL;
@@ -5135,6 +5189,12 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EINVAL;

+	size = virtqueue_get_vring_size(rq->vq);
+
+	rq->xsk_buffs = kvcalloc(size, sizeof(*rq->xsk_buffs), GFP_KERNEL);
+	if (!rq->xsk_buffs)
+		return -ENOMEM;
+
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
 		goto err_xsk_map;
@@ -5169,6 +5229,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)

 	xsk_pool_dma_unmap(pool, 0);

+	kvfree(rq->xsk_buffs);
+
 	return err;
 }

--
2.32.0.3.g01195cf9f


