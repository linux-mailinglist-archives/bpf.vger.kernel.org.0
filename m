Return-Path: <bpf+bounces-37602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E53957FD4
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AA41F23623
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10018A95D;
	Tue, 20 Aug 2024 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GOu+wvj5"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA918A924;
	Tue, 20 Aug 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139227; cv=none; b=IdHUIx32SqpG8p27KpU0WuXOYkyn2Cnf560jhKUdjJCN5mbbtFUebG2tLKLDXJU9H64/tjJuqCasYOU89B62DdIa89HFz9Nsw9lYt1dZnQ3R7Z4lK7CwWCBCtxdg96eWbK28qJ7hqSSJUymUJf2DyR7aYDQVeByd1m+tU6zpQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139227; c=relaxed/simple;
	bh=FHc90LXuUwpoIibIPR/9FZfzgpMXr6XscacH3E8HLj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKI8P80pC3/+1Iv1IRby0Qd1q/u4OamtcNubP2ZmKG12og/yAcfVneSpkaVxrZzsECDSIyMP4vRpxd0LjxqmZ2D654Cxq3WpYG8hVc6OofXGVaSP+mp7PIsgLJ0KpgttIyxNhCTFClAYwbcTduPO85dKhCe1tfAPPZiE6sfkZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GOu+wvj5; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724139221; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5KVgWGKAXOUbHlgbUwRsPa5QxWriMykyUxgR9rV/hwI=;
	b=GOu+wvj5LGK5pYaCgTakdnJmv4S+QFV3vA8uXzcz2i8cC2lS1lagItznaVYeuNPo3Zt6TzV7DrbX/yLdNz5bA6bRyc0ZfjOUFtn1vdAmhuk4UUtjHo1SszmBmNQFKM/AxtLerMcOT7jqwNovdJQ/5PoBLOEwTGPUQtXrSNDlGXI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHeY2e_1724139218)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:33:38 +0800
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
Subject: [PATCH net-next 08/13] virtio_net: xsk: bind/unbind xsk for tx
Date: Tue, 20 Aug 2024 15:33:25 +0800
Message-Id: <20240820073330.9161-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b206d29d23af
Content-Transfer-Encoding: 8bit

This patch implement the logic of bind/unbind xsk pool to sq and rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 96abee36738b..6a36a204e967 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -295,6 +295,10 @@ struct send_queue {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	struct xsk_buff_pool *xsk_pool;
+
+	dma_addr_t xsk_hdr_dma_addr;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -494,6 +498,8 @@ struct virtio_net_common_hdr {
 	};
 };
 
+static struct virtio_net_common_hdr xsk_hdr;
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
@@ -5476,6 +5482,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 	return err;
 }
 
+static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
+				    struct send_queue *sq,
+				    struct xsk_buff_pool *pool)
+{
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	if (err) {
+		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
+		pool = NULL;
+	}
+
+	sq->xsk_pool = pool;
+
+	virtnet_tx_resume(vi, sq);
+
+	return err;
+}
+
 static int virtnet_xsk_pool_enable(struct net_device *dev,
 				   struct xsk_buff_pool *pool,
 				   u16 qid)
@@ -5484,6 +5513,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct receive_queue *rq;
 	struct device *dma_dev;
 	struct send_queue *sq;
+	dma_addr_t hdr_dma;
 	int err, size;
 
 	if (vi->hdr_len > xsk_pool_get_headroom(pool))
@@ -5521,6 +5551,10 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!rq->xsk_buffs)
 		return -ENOMEM;
 
+	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, hdr_dma))
+		return -ENOMEM;
+
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
 		goto err_xsk_map;
@@ -5529,11 +5563,23 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (err)
 		goto err_rq;
 
+	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
+	if (err)
+		goto err_sq;
+
+	/* Now, we do not support tx offset, so all the tx virtnet hdr is zero.
+	 * So all the tx packets can share a single hdr.
+	 */
+	sq->xsk_hdr_dma_addr = hdr_dma;
+
 	return 0;
 
+err_sq:
+	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
+	dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
 	return err;
 }
 
@@ -5542,19 +5588,27 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct xsk_buff_pool *pool;
 	struct receive_queue *rq;
+	struct device *dma_dev;
+	struct send_queue *sq;
 	int err;
 
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
+	sq = &vi->sq[qid];
 	rq = &vi->rq[qid];
 
 	pool = rq->xsk_pool;
 
 	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+	err |= virtnet_sq_bind_xsk_pool(vi, sq, NULL);
 
 	xsk_pool_dma_unmap(pool, 0);
 
+	dma_dev = virtqueue_dma_dev(sq->vq);
+
+	dma_unmap_single(dma_dev, sq->xsk_hdr_dma_addr, vi->hdr_len, DMA_TO_DEVICE);
+
 	kvfree(rq->xsk_buffs);
 
 	return err;
-- 
2.32.0.3.g01195cf9f


