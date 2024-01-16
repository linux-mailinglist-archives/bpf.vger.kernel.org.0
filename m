Return-Path: <bpf+bounces-19595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99E82EBFA
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C506C1F24407
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE671BC22;
	Tue, 16 Jan 2024 09:43:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129671B95B;
	Tue, 16 Jan 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lmFUh_1705398207;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lmFUh_1705398207)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:28 +0800
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
Subject: [PATCH net-next 13/17] virtio_net: xsk: rx: support recv merge mode
Date: Tue, 16 Jan 2024 17:43:09 +0800
Message-Id: <20240116094313.119939-14-xuanzhuo@linux.alibaba.com>
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

The virtnet_xdp_handler() is re-used. But

1. We need to copy data to create skb for XDP_PASS.
2. We need to call xsk_buff_free() to release the buffer.
3. The handle for xdp_buff is difference.

If we pushed this logic into existing receive handle(merge and small),
we would have to maintain code scattered inside merge and small (and big).
So I think it is a good choice for us to put the xsk code into an
independent function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  40 ++++--
 drivers/net/virtio/virtio_net.h |   4 +
 drivers/net/virtio/xsk.c        | 216 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   4 +
 4 files changed, 251 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index fb8dbce11e53..35f0daaea7e5 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -801,10 +801,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 	}
 }
 
-static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
-			       struct net_device *dev,
-			       unsigned int *xdp_xmit,
-			       struct virtnet_rq_stats *stats)
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats)
 {
 	struct xdp_frame *xdpf;
 	int err;
@@ -1897,23 +1897,37 @@ static int virtnet_receive(struct virtnet_rq *rq, int budget,
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_stats stats = {};
+	void *buf, *ctx, *pctx = NULL;
 	unsigned int len;
 	int packets = 0;
-	void *buf;
 	int i;
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
-		void *ctx;
+	if (rq->xsk.pool) {
+		struct sk_buff *skb;
+
+		while (packets < budget) {
+			buf = virtqueue_get_buf(rq->vq, &len);
+			if (!buf)
+				break;
+
+			skb = virtnet_receive_xsk_buf(vi, rq, buf, len, xdp_xmit, &stats);
+			if (skb)
+				virtnet_receive_done(vi, rq, skb);
 
-		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
-			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
 			packets++;
 		}
 	} else {
-		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
-			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
+		if (!vi->big_packets || vi->mergeable_rx_bufs)
+			pctx = &ctx;
+		else
+			ctx = NULL;
+
+		while (packets < budget) {
+			buf = virtnet_rq_get_buf(rq, &len, pctx);
+			if (!buf)
+				break;
+
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
 			packets++;
 		}
 	}
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index c07a1e58bf0f..98dcf1825448 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -345,4 +345,8 @@ struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					struct sk_buff *curr_skb,
 					struct page *page, void *buf,
 					int len, int truesize);
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats);
 #endif
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index c54cd08e9c77..6f4fa32b1184 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -14,6 +14,222 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+static void xsk_drop_follow_bufs(struct net_device *dev,
+				 struct virtnet_rq *rq,
+				 u32 num_buf,
+				 struct virtnet_rq_stats *stats)
+{
+	struct xdp_buff *xdp;
+	u32 len;
+
+	while (num_buf-- > 1) {
+		xdp = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!xdp)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 dev->name, num_buf);
+			DEV_STATS_INC(dev, rx_length_errors);
+			break;
+		}
+		u64_stats_add(&stats->bytes, len);
+		xsk_buff_free(xdp);
+	}
+}
+
+static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
+				   struct virtnet_rq *rq, void *buf, u32 len)
+{
+	struct xdp_buff *xdp;
+	u32 bufsize;
+
+	xdp = (struct xdp_buff *)buf;
+
+	bufsize = xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->hdr_len;
+
+	if (unlikely(len > bufsize)) {
+		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
+			 vi->dev->name, len, bufsize);
+		DEV_STATS_INC(vi->dev, rx_length_errors);
+		xsk_buff_free(xdp);
+		return NULL;
+	}
+
+	xsk_buff_set_size(xdp, len);
+	xsk_buff_dma_sync_for_cpu(xdp, rq->xsk.pool);
+
+	return xdp;
+}
+
+static int xsk_append_merge_buffer(struct virtnet_info *vi,
+				   struct virtnet_rq *rq,
+				   struct sk_buff *head_skb,
+				   u32 num_buf,
+				   struct virtio_net_hdr_mrg_rxbuf *hdr,
+				   struct virtnet_rq_stats *stats)
+{
+	struct sk_buff *curr_skb;
+	struct xdp_buff *xdp;
+	u32 len, truesize;
+	struct page *page;
+	void *buf;
+
+	curr_skb = head_skb;
+
+	while (--num_buf) {
+		buf = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!buf)) {
+			pr_debug("%s: rx error: %d buffers out of %d missing\n",
+				 vi->dev->name, num_buf,
+				 virtio16_to_cpu(vi->vdev,
+						 hdr->num_buffers));
+			DEV_STATS_INC(vi->dev, rx_length_errors);
+			return -EINVAL;
+		}
+
+		u64_stats_add(&stats->bytes, len);
+
+		xdp = buf_to_xdp(vi, rq, buf, len);
+		if (!xdp)
+			goto err;
+
+		buf = napi_alloc_frag(len);
+		if (!buf) {
+			xsk_buff_free(xdp);
+			goto err;
+		}
+
+		memcpy(buf, xdp->data - vi->hdr_len, len);
+
+		xsk_buff_free(xdp);
+
+		page = virt_to_page(buf);
+
+		truesize = len;
+
+		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+						    buf, len, truesize);
+		if (!curr_skb) {
+			put_page(page);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
+	return -EINVAL;
+}
+
+static struct sk_buff *xdp_construct_skb(struct virtnet_rq *rq,
+					 struct xdp_buff *xdp)
+{
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+	unsigned int size;
+
+	size = xdp->data_end - xdp->data_hard_start;
+	skb = napi_alloc_skb(&rq->napi, size);
+	if (unlikely(!skb)) {
+		xsk_buff_free(xdp);
+		return NULL;
+	}
+
+	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+
+	size = xdp->data_end - xdp->data_meta;
+	memcpy(__skb_put(skb, size), xdp->data_meta, size);
+
+	if (metasize) {
+		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
+	}
+
+	xsk_buff_free(xdp);
+
+	return skb;
+}
+
+static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
+						 struct virtnet_rq *rq, struct xdp_buff *xdp,
+						 unsigned int *xdp_xmit,
+						 struct virtnet_rq_stats *stats)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct bpf_prog *prog;
+	struct sk_buff *skb;
+	u32 ret, num_buf;
+
+	hdr = xdp->data - vi->hdr_len;
+	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
+
+	ret = XDP_PASS;
+	rcu_read_lock();
+	prog = rcu_dereference(rq->xdp_prog);
+	/* TODO: support multi buffer. */
+	if (prog && num_buf == 1)
+		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	rcu_read_unlock();
+
+	switch (ret) {
+	case XDP_PASS:
+		skb = xdp_construct_skb(rq, xdp);
+		if (!skb)
+			goto drop_bufs;
+
+		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
+			dev_kfree_skb(skb);
+			goto drop;
+		}
+
+		return skb;
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		return NULL;
+
+	default:
+		/* drop packet */
+		xsk_buff_free(xdp);
+	}
+
+drop_bufs:
+	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
+
+drop:
+	u64_stats_inc(&stats->drops);
+	return NULL;
+}
+
+struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
+					void *buf, u32 len,
+					unsigned int *xdp_xmit,
+					struct virtnet_rq_stats *stats)
+{
+	struct net_device *dev = vi->dev;
+	struct sk_buff *skb = NULL;
+	struct xdp_buff *xdp;
+
+	len -= vi->hdr_len;
+
+	u64_stats_add(&stats->bytes, len);
+
+	xdp = buf_to_xdp(vi, rq, buf, len);
+	if (!xdp)
+		return NULL;
+
+	if (unlikely(len < ETH_HLEN)) {
+		pr_debug("%s: short packet %i\n", dev->name, len);
+		DEV_STATS_INC(dev, rx_length_errors);
+		xsk_buff_free(xdp);
+		return NULL;
+	}
+
+	if (vi->mergeable_rx_bufs)
+		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
+
+	return skb;
+}
+
 int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
 			    struct xsk_buff_pool *pool, gfp_t gfp)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index bef41a3f954e..e78fcd0a4946 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -25,4 +25,8 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
 			    struct xsk_buff_pool *pool, gfp_t gfp);
+struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
+					void *buf, u32 len,
+					unsigned int *xdp_xmit,
+					struct virtnet_rq_stats *stats);
 #endif
-- 
2.32.0.3.g01195cf9f


