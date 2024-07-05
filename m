Return-Path: <bpf+bounces-33941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA99282DB
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6585F1F24D0F
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620A145FED;
	Fri,  5 Jul 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HsuQY2Ty"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3A14037D;
	Fri,  5 Jul 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165066; cv=none; b=f4y5NXCFGhdC0z2MN3RqUXeFEfUOKBm/sY1totAFkHKLFThHbq5GD1CQxrDEQL81tXQSJm4qvsNNnIBzn7U7mC9rl4R18b3LTRJchtqeZPdGtWNa8zft4abkuKEIYXSuQ878+sXoZ7lu62eVl98bPkdRL5nNGgQQabPVVxUmt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165066; c=relaxed/simple;
	bh=JV2LkjIACGfOBIRgTYt5UVoaVJ8FhSrBLEmueGeXgkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaBW7gekxomSafjujHr3JDoDMUpWPyDfthVv0yKj4xVefmiN5MYHOJzu24aNngFy8sH33JdmEb1sQ7NJy+7ZygsFvPnUtp2asq9ib4r993G+rEf5ZwpLhoLKpYmgF0/NpAgstjtko/BgeBt/WP6qUS5UREppkSNHwD06q6UdlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HsuQY2Ty; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165062; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fL97hArjFxmQ1nwK4dedZW2HfLSmHSBbA74KNJSpIKE=;
	b=HsuQY2TyoiuZbrf9vUEbSKXMA9UPiPa9XQnjVIFUlbtsHnr7DI1LjuOjWAYI+3QVDwEPMhLhVfqXD8r8tCyxq1C6v8t7Z8bFtmxtj3ZhRu9b5kmej8J2F993mst+c4yB8iO65bP/5zbphWGH0TXS7euw6rCso6sognsdIj3X4VU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9uE.fF_1720165060;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9uE.fF_1720165060)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:41 +0800
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
Subject: [PATCH net-next v7 06/10] virtio_net: xsk: bind/unbind xsk for rx
Date: Fri,  5 Jul 2024 15:37:30 +0800
Message-Id: <20240705073734.93905-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
Content-Transfer-Encoding: 8bit

This patch implement the logic of bind/unbind xsk pool to rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

v7:
    1. remove a container struct for xsk
    2. update comments
    3. add check between hdr_len and xsk headroom

 drivers/net/virtio_net.c | 134 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3c828cdd438b..cd87b39600d4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -25,6 +25,7 @@
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
+#include <net/xdp_sock_drv.h>

 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -348,6 +349,11 @@ struct receive_queue {

 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
+
+	struct xsk_buff_pool *xsk_pool;
+
+	/* xdp rxq used by xsk */
+	struct xdp_rxq_info xsk_rxq_info;
 };

 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -5026,6 +5032,132 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 	return virtnet_set_guest_offloads(vi, offloads);
 }

+static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
+				    struct xsk_buff_pool *pool)
+{
+	int err, qindex;
+
+	qindex = rq - vi->rq;
+
+	if (pool) {
+		err = xdp_rxq_info_reg(&rq->xsk_rxq_info, vi->dev, qindex, rq->napi.napi_id);
+		if (err < 0)
+			return err;
+
+		err = xdp_rxq_info_reg_mem_model(&rq->xsk_rxq_info,
+						 MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (err < 0)
+			goto unreg;
+
+		xsk_pool_set_rxq_info(pool, &rq->xsk_rxq_info);
+	}
+
+	virtnet_rx_pause(vi, rq);
+
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	if (err) {
+		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+		pool = NULL;
+	}
+
+	rq->xsk_pool = pool;
+
+	virtnet_rx_resume(vi, rq);
+
+	if (pool)
+		return 0;
+
+unreg:
+	xdp_rxq_info_unreg(&rq->xsk_rxq_info);
+	return err;
+}
+
+static int virtnet_xsk_pool_enable(struct net_device *dev,
+				   struct xsk_buff_pool *pool,
+				   u16 qid)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct receive_queue *rq;
+	struct device *dma_dev;
+	struct send_queue *sq;
+	int err;
+
+	if (vi->hdr_len > xsk_pool_get_headroom(pool))
+		return -EINVAL;
+
+	/* In big_packets mode, xdp cannot work, so there is no need to
+	 * initialize xsk of rq.
+	 */
+	if (vi->big_packets && !vi->mergeable_rx_bufs)
+		return -ENOENT;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+	rq = &vi->rq[qid];
+
+	/* xsk assumes that tx and rx must have the same dma device. The af-xdp
+	 * may use one buffer to receive from the rx and reuse this buffer to
+	 * send by the tx. So the dma dev of sq and rq must be the same one.
+	 *
+	 * But vq->dma_dev allows every vq has the respective dma dev. So I
+	 * check the dma dev of vq and sq is the same dev.
+	 */
+	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
+		return -EPERM;
+
+	dma_dev = virtqueue_dma_dev(rq->vq);
+	if (!dma_dev)
+		return -EPERM;
+
+	err = xsk_pool_dma_map(pool, dma_dev, 0);
+	if (err)
+		goto err_xsk_map;
+
+	err = virtnet_rq_bind_xsk_pool(vi, rq, pool);
+	if (err)
+		goto err_rq;
+
+	return 0;
+
+err_rq:
+	xsk_pool_dma_unmap(pool, 0);
+err_xsk_map:
+	return err;
+}
+
+static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct xsk_buff_pool *pool;
+	struct receive_queue *rq;
+	int err;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	rq = &vi->rq[qid];
+
+	pool = rq->xsk_pool;
+
+	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+
+	xsk_pool_dma_unmap(pool, 0);
+
+	return err;
+}
+
+static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	if (xdp->xsk.pool)
+		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
+					       xdp->xsk.queue_id);
+	else
+		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
+}
+
 static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			   struct netlink_ext_ack *extack)
 {
@@ -5151,6 +5283,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
+	case XDP_SETUP_XSK_POOL:
+		return virtnet_xsk_pool_setup(dev, xdp);
 	default:
 		return -EINVAL;
 	}
--
2.32.0.3.g01195cf9f


