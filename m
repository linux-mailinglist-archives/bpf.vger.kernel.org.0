Return-Path: <bpf+bounces-32167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDF9083D3
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3755B23ACA
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A8181D00;
	Fri, 14 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gq0Y2+my"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7614882E;
	Fri, 14 Jun 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347187; cv=none; b=RmCz2yRq5pPvGf868d3rtHosTAGfLQXNlF5+nLpTyHkkPggfuQcp9J0zyu9lTtPnVxfQ8FFRrfNyDxR+uxYBU7v72b/03Bu+XO7tIMGQrsQoidPTcEUsy+ICDeakfef5z9FEMFnh/5L4z/rmjwfCiWBQSEtdlZlKU1aepPSyzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347187; c=relaxed/simple;
	bh=Np/C09W9yZYjHwosSlj0aFHMRzQvkZx0IAaAl8Zi+aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FH21cMeDuHNQjpOiV3mUHADz8MBOzi4d42zuQ5ZwEMv8bscbbx1tjTFcLEH5eboAOFCLCFcUcKKxG18QIjFOgLO1Zs9qnKbVqXNZ59zLVGPZ3g1bdTv19d/zhMXbISWjkLhNNkXuRf9/bKHJXNPHbqBNJgd0ah4IMl+xyq9GzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gq0Y2+my; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347182; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KG/bd50OMKJaDIdNSTSVLUrSecHFGb0oLXPCZ9UUqtc=;
	b=gq0Y2+myYJy4qKppPCmgimozZJQMEbu6luvOP3iVSydu6HYBvf3hMurJw9nvCGp1nv+QvIEzA6jOAY8JpkkzUWvaG/sXKE25mRLAH65zvfHHH9F0FKWvfgT20EnkwD9wJyqtTYU03e2ga9oZsMXLV16NEwsDVTT3EI7Wh6FcZRQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QKgUj_1718347181;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QKgUj_1718347181)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:42 +0800
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
Subject: [PATCH net-next v5 09/15] virtio_net: xsk: bind/unbind xsk
Date: Fri, 14 Jun 2024 14:39:27 +0800
Message-Id: <20240614063933.108811-10-xuanzhuo@linux.alibaba.com>
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

This patch implement the logic of bind/unbind xsk pool to sq and rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 201 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 88ab9ea1646f..35fd8bca7fcf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <uapi/linux/virtio_ring.h>
+#include <net/xdp_sock_drv.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
 
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
+static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
+
 static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
@@ -321,6 +324,12 @@ struct send_queue {
 	bool premapped;
 
 	struct virtnet_sq_dma_info dmainfo;
+
+	struct {
+		struct xsk_buff_pool *pool;
+
+		dma_addr_t hdr_dma_address;
+	} xsk;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -372,6 +381,13 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
+
+	struct {
+		struct xsk_buff_pool *pool;
+
+		/* xdp rxq used by xsk */
+		struct xdp_rxq_info xdp_rxq;
+	} xsk;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -695,7 +711,7 @@ static void virtnet_sq_free_dma_meta(struct send_queue *sq)
 /* This function must be called immediately after creating the vq, or after vq
  * reset, and before adding any buffers to it.
  */
-static __maybe_unused int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
+static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
 {
 	if (premapped) {
 		int r;
@@ -5177,6 +5193,187 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
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
+		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qindex, rq->napi.napi_id);
+		if (err < 0)
+			return err;
+
+		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
+						 MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (err < 0) {
+			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
+			return err;
+		}
+
+		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
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
+	if (!pool)
+		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
+
+	rq->xsk.pool = pool;
+
+	virtnet_rx_resume(vi, rq);
+
+	return err;
+}
+
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
+	if (err)
+		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
+	else
+		err = virtnet_sq_set_premapped(sq, !!pool);
+
+	if (err)
+		pool = NULL;
+
+	sq->xsk.pool = pool;
+
+	virtnet_tx_resume(vi, sq);
+
+	return err;
+}
+
+static int virtnet_xsk_pool_enable(struct net_device *dev,
+				   struct xsk_buff_pool *pool,
+				   u16 qid)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct receive_queue *rq;
+	struct send_queue *sq;
+	struct device *dma_dev;
+	dma_addr_t hdr_dma;
+	int err;
+
+	/* In big_packets mode, xdp cannot work, so there is no need to
+	 * initialize xsk of rq.
+	 *
+	 * Support for small mode firstly.
+	 */
+	if (vi->big_packets)
+		return -ENOENT;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+	rq = &vi->rq[qid];
+
+	/* xsk tx zerocopy depend on the tx napi.
+	 *
+	 * All xsk packets are actually consumed and sent out from the xsk tx
+	 * queue under the tx napi mechanism.
+	 */
+	if (!sq->napi.weight)
+		return -EPERM;
+
+	/* For the xsk, the tx and rx should have the same device. But
+	 * vq->dma_dev allows every vq has the respective dma dev. So I check
+	 * the dma dev of vq and sq is the same dev.
+	 */
+	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
+		return -EPERM;
+
+	dma_dev = virtqueue_dma_dev(rq->vq);
+	if (!dma_dev)
+		return -EPERM;
+
+	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, hdr_dma))
+		return -ENOMEM;
+
+	err = xsk_pool_dma_map(pool, dma_dev, 0);
+	if (err)
+		goto err_xsk_map;
+
+	err = virtnet_rq_bind_xsk_pool(vi, rq, pool);
+	if (err)
+		goto err_rq;
+
+	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
+	if (err)
+		goto err_sq;
+
+	/* Now, we do not support tx offset, so all the tx virtnet hdr is zero.
+	 * So all the tx packets can share a single hdr.
+	 */
+	sq->xsk.hdr_dma_address = hdr_dma;
+
+	return 0;
+
+err_sq:
+	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+err_rq:
+	xsk_pool_dma_unmap(pool, 0);
+err_xsk_map:
+	dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
+	return err;
+}
+
+static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct xsk_buff_pool *pool;
+	struct device *dma_dev;
+	struct receive_queue *rq;
+	struct send_queue *sq;
+	int err1, err2;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+	rq = &vi->rq[qid];
+
+	pool = sq->xsk.pool;
+
+	err1 = virtnet_sq_bind_xsk_pool(vi, sq, NULL);
+	err2 = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+
+	xsk_pool_dma_unmap(pool, 0);
+
+	dma_dev = virtqueue_dma_dev(rq->vq);
+
+	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
+
+	return err1 | err2;
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
@@ -5302,6 +5499,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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


