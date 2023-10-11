Return-Path: <bpf+bounces-11897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F57C4ED8
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222382826BE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22AD1DA4F;
	Wed, 11 Oct 2023 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1211EA91;
	Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C699C;
	Wed, 11 Oct 2023 02:27:52 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtwO-Eg_1697016469;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VtwO-Eg_1697016469)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 17:27:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 18/22] virtio_net: xsk: rx: introduce add_recvbuf_xsk()
Date: Wed, 11 Oct 2023 17:27:24 +0800
Message-Id: <20231011092728.105904-19-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the logic of filling vq with XSK buffer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 13 +++++++
 drivers/net/virtio/virtio_net.h |  5 +++
 drivers/net/virtio/xsk.c        | 66 ++++++++++++++++++++++++++++++++-
 drivers/net/virtio/xsk.h        |  2 +
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 8c9d8c4e6960..55a643a1f129 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -1793,9 +1793,20 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 			  gfp_t gfp)
 {
+	struct xsk_buff_pool *pool;
 	int err;
 	bool oom;
 
+	rcu_read_lock();
+	pool = rcu_dereference(rq->xsk.pool);
+	if (pool) {
+		err = virtnet_add_recvbuf_xsk(vi, rq, pool, gfp);
+		oom = err == -ENOMEM;
+		rcu_read_unlock();
+		goto kick;
+	}
+	rcu_read_unlock();
+
 	do {
 		if (vi->mergeable_rx_bufs)
 			err = add_recvbuf_mergeable(vi, rq, gfp);
@@ -1808,6 +1819,8 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 		if (err)
 			break;
 	} while (rq->vq->num_free);
+
+kick:
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
 		unsigned long flags;
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 54f954ea62fb..532df71a4c08 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -156,6 +156,11 @@ struct virtnet_rq {
 
 		/* xdp rxq used by xsk */
 		struct xdp_rxq_info xdp_rxq;
+
+		struct xdp_buff **xsk_buffs;
+		u32 nxt_idx;
+		u32 num;
+		u32 size;
 	} xsk;
 };
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index cce746301758..d7f0a81e8635 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -37,6 +37,58 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
 		netif_stop_subqueue(dev, qnum);
 }
 
+static int virtnet_add_recvbuf_batch(struct virtnet_info *vi, struct virtnet_rq *rq,
+				     struct xsk_buff_pool *pool, gfp_t gfp)
+{
+	struct xdp_buff **xsk_buffs;
+	dma_addr_t addr;
+	u32 len, i;
+	int err = 0;
+
+	xsk_buffs = rq->xsk.xsk_buffs;
+
+	if (rq->xsk.nxt_idx >= rq->xsk.num) {
+		rq->xsk.num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->xsk.size);
+		if (!rq->xsk.num)
+			return -ENOMEM;
+		rq->xsk.nxt_idx = 0;
+	}
+
+	while (rq->xsk.nxt_idx < rq->xsk.num) {
+		i = rq->xsk.nxt_idx;
+
+		/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
+		addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
+		len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
+
+		sg_init_table(rq->sg, 1);
+		sg_fill_dma(rq->sg, addr, len);
+
+		err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
+		if (err)
+			return err;
+
+		rq->xsk.nxt_idx++;
+	}
+
+	return 0;
+}
+
+int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
+			    struct xsk_buff_pool *pool, gfp_t gfp)
+{
+	int err;
+
+	do {
+		err = virtnet_add_recvbuf_batch(vi, rq, pool, gfp);
+		if (err)
+			return err;
+
+	} while (rq->vq->num_free);
+
+	return 0;
+}
+
 static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
 				struct xsk_buff_pool *pool,
 				struct xdp_desc *desc)
@@ -248,7 +300,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct virtnet_sq *sq;
 	struct device *dma_dev;
 	dma_addr_t hdr_dma;
-	int err;
+	int err, size;
 
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
@@ -280,6 +332,16 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EPERM;
 
+	size = virtqueue_get_vring_size(rq->vq);
+
+	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
+	if (!rq->xsk.xsk_buffs)
+		return -ENOMEM;
+
+	rq->xsk.size = size;
+	rq->xsk.nxt_idx = 0;
+	rq->xsk.num = 0;
+
 	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, hdr_dma))
 		return -ENOMEM;
@@ -338,6 +400,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	err1 = virtnet_sq_bind_xsk_pool(vi, sq, NULL);
 	err2 = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 
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


