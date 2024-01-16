Return-Path: <bpf+bounces-19585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A382EBD5
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91F1B23954
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3813ADF;
	Tue, 16 Jan 2024 09:43:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8512E7F;
	Tue, 16 Jan 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lk6Sm_1705398196;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lk6Sm_1705398196)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Subject: [PATCH net-next 03/17] virtio_net: xsk: bind/unbind xsk
Date: Tue, 16 Jan 2024 17:42:59 +0800
Message-Id: <20240116094313.119939-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1913ebd4ae28
Content-Transfer-Encoding: 8bit

This patch implement the logic of bind/unbind xsk pool to sq and rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/Makefile     |   2 +-
 drivers/net/virtio/main.c       |  12 +-
 drivers/net/virtio/virtio_net.h |  18 +++
 drivers/net/virtio/xsk.c        | 188 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   7 ++
 5 files changed, 219 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
index 15ed7c97fd4f..8c2a884d2dba 100644
--- a/drivers/net/virtio/Makefile
+++ b/drivers/net/virtio/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 
-virtio_net-y := main.o
+virtio_net-y := main.o xsk.o
diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 49c2c1c985f3..3856006ac1c7 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -8,7 +8,6 @@
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
-#include <linux/virtio_net.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/scatterlist.h>
@@ -17,13 +16,13 @@
 #include <linux/cpu.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
-#include <linux/dim.h>
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 
 #include "virtio_net.h"
+#include "xsk.h"
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -150,9 +149,6 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static void virtnet_rq_free_unused_bufs(struct virtqueue *vq);
-static void virtnet_sq_free_unused_bufs(struct virtqueue *vq);
-
 static bool is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -3941,6 +3937,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
+	case XDP_SETUP_XSK_POOL:
+		return virtnet_xsk_pool_setup(dev, xdp);
 	default:
 		return -EINVAL;
 	}
@@ -4124,7 +4122,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 		}
 }
 
-static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
+void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct virtio_dma_head *dma;
@@ -4152,7 +4150,7 @@ static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
 	}
 }
 
-static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
+void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct virtnet_rq *rq;
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index db86338e0dd0..02dc7650a65c 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -5,6 +5,9 @@
 
 #include <linux/ethtool.h>
 #include <linux/average.h>
+#include <linux/virtio_net.h>
+#include <linux/dim.h>
+#include <net/xdp_sock_drv.h>
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
@@ -75,6 +78,12 @@ struct virtnet_sq {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	struct {
+		struct xsk_buff_pool *pool;
+
+		dma_addr_t hdr_dma_address;
+	} xsk;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -123,6 +132,13 @@ struct virtnet_rq {
 
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
 
 struct virtnet_info {
@@ -214,4 +230,6 @@ void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
+void virtnet_sq_free_unused_bufs(struct virtqueue *vq);
+void virtnet_rq_free_unused_bufs(struct virtqueue *vq);
 #endif
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
new file mode 100644
index 000000000000..613a6c63d47c
--- /dev/null
+++ b/drivers/net/virtio/xsk.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio-net xsk
+ */
+
+#include "virtio_net.h"
+#include "xsk.h"
+
+static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
+
+static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
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
+	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_bufs);
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
+				    struct virtnet_sq *sq,
+				    struct xsk_buff_pool *pool)
+{
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_bufs);
+	if (err) {
+		pool = NULL;
+		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
+	}
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
+	struct virtnet_rq *rq;
+	struct virtnet_sq *sq;
+	struct device *dma_dev;
+	dma_addr_t hdr_dma;
+	int err;
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
+	/* xsk tx zerocopy depend on the tx napi.
+	 *
+	 * All xsk packets are actually consumed and sent out from the xsk tx
+	 * queue under the tx napi mechanism.
+	 */
+	if (!sq->napi.weight)
+		return -EPERM;
+
+	if (!virtqueue_get_dma_premapped(rq->vq) || !virtqueue_get_dma_premapped(sq->vq))
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
+	struct virtnet_rq *rq;
+	struct virtnet_sq *sq;
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
+int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	if (xdp->xsk.pool)
+		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
+					       xdp->xsk.queue_id);
+	else
+		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
+}
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
new file mode 100644
index 000000000000..1918285c310c
--- /dev/null
+++ b/drivers/net/virtio/xsk.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __XSK_H__
+#define __XSK_H__
+
+int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
+#endif
-- 
2.32.0.3.g01195cf9f


