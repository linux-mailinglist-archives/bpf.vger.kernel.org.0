Return-Path: <bpf+bounces-44207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBB49C008E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5751C21201
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565D1DF24B;
	Thu,  7 Nov 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BDB+ld0k"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F351DD54C;
	Thu,  7 Nov 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969719; cv=none; b=H+8YNLg7cWZ4+M3baNsxUGfSCORaeE8mAzq4Tz0KYbWIgyWtQaM7cu1/hactFoq6yDvlDDardnx+6BWfJuwwONhiFaHPX5IzHuCa5szoKgsHUZxp+txJM/p4MmKLvU+3bX6gbzUdKtVcrvt5yKWn0ohIOS7ptgG/7Qqc0fWgb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969719; c=relaxed/simple;
	bh=KlTbukt3fkyxSb99ywpUR0qvCtowzp+de6dz9UWSCmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxiTe232xwh5rlAQsPMB0hJHo/5tmKp+pv7C4S/S6YJJafr6837INznY7nAwm/O4eHg9q001Aq5wkURASGKI3bCkIRFQTOEyVArkkE6DYygLloG6/SbS34jrp11HqQtejapbNZLlC5KkAq8rZcBEQyeFsJiwo00bP9bHSOQWYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BDB+ld0k; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730969715; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DLx++f+BlhFnRaFqf1qDlvFJj7iIFp8VrpU47qLJPD8=;
	b=BDB+ld0k0iS42tLLaEzhisp8XM59DiTr9q3I4DL01zUzvnFhU4RrnIk11G2UaGekOso1Qpggarj3MzZVeSvIvkXgU8YWwaf/dTfzZtyhaVGuuJtnGcQ1dTD6IAciN1O23OomUd3lfRW5E7EwB8JnGe+2UW/lBzyhrjh6A5vOWFo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIv0ukz_1730969713 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:14 +0800
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
Subject: [PATCH net-next v3 09/13] virtio_net: xsk: bind/unbind xsk for tx
Date: Thu,  7 Nov 2024 16:55:00 +0800
Message-Id: <20241107085504.63131-10-xuanzhuo@linux.alibaba.com>
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

This patch implement the logic of bind/unbind xsk pool to sq and rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 079d4a213fda..a6becdc762cd 100644
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
@@ -5500,6 +5506,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
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
@@ -5508,6 +5537,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct receive_queue *rq;
 	struct device *dma_dev;
 	struct send_queue *sq;
+	dma_addr_t hdr_dma;
 	int err, size;
 
 	if (vi->hdr_len > xsk_pool_get_headroom(pool))
@@ -5545,6 +5575,11 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!rq->xsk_buffs)
 		return -ENOMEM;
 
+	hdr_dma = virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
+						 DMA_TO_DEVICE, 0);
+	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
+		return -ENOMEM;
+
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
 		goto err_xsk_map;
@@ -5553,11 +5588,24 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (err)
 		goto err_rq;
 
+	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
+	if (err)
+		goto err_sq;
+
+	/* Now, we do not support tx offload(such as tx csum), so all the tx
+	 * virtnet hdr is zero. So all the tx packets can share a single hdr.
+	 */
+	sq->xsk_hdr_dma_addr = hdr_dma;
+
 	return 0;
 
+err_sq:
+	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
+	virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+					 DMA_TO_DEVICE, 0);
 	return err;
 }
 
@@ -5566,19 +5614,24 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct xsk_buff_pool *pool;
 	struct receive_queue *rq;
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
 
+	virtqueue_dma_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
+					 vi->hdr_len, DMA_TO_DEVICE, 0);
 	kvfree(rq->xsk_buffs);
 
 	return err;
-- 
2.32.0.3.g01195cf9f


