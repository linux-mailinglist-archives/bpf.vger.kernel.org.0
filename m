Return-Path: <bpf+bounces-34067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6892A114
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F51C20FEC
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0F81ADA;
	Mon,  8 Jul 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WbcuVMWL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88380626;
	Mon,  8 Jul 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437952; cv=none; b=MHeT6rvfhlsbX457vqQmuLaOcoxapvLmooK4UmC5jUbykcW5XV32ddZzjvsyw+J17SWtwgPmoU6rNc2KnJfuLwfmZskXVFKYmqqOMMEF+oX271mAhftcZsyzO0KAjbMUPUE8WoIXfKVgW3eOHcEDlTOkU6jYNav/GI3c+Bz2noE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437952; c=relaxed/simple;
	bh=jUgA6XkUfMqP0xg7MRBWpYAGVUoAIY7wdBGJtft6GyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEJkA4oMDh/zdcxqRXkSpUYpcZI+c6zQoDxlt+XADVQclA8/tqiCllLlasvlvQCoWDxNf91LoyP/5Io9yjhbxAAA7S5jkjaj4oQLT2wm8Y6ookRm61uWSLMyYgxXfTOx4Kkzh8Rn5qYnAxt+zTNSrHoYE7Ts9SrTpgYTE+KrWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WbcuVMWL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720437948; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=13BiuFsb56awSjLNyG7rsLUz0OwBN3ecOwnI974BTQ8=;
	b=WbcuVMWL5hZQzxcnhB5ZqrR695bwyrnBG2YmwocdZO7g0Eb97G5DohzyrTMgd2Rcy4Xl6wNMdJUPy9PvdtMqYCoppHjfYPHjzKyfbztT1Eo/Mudn+jTv/TzfaTaiG7DChZhpieuCHR4xFrTIsKtPzC9WRiyWD/UFkTVpxiQZNLg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA4mZg7_1720437947;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA4mZg7_1720437947)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 19:25:47 +0800
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
Subject: [PATCH net-next v8 09/10] virtio_net: xsk: rx: support recv small mode
Date: Mon,  8 Jul 2024 19:25:36 +0800
Message-Id: <20240708112537.96291-10-xuanzhuo@linux.alibaba.com>
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

In the process:
1. We may need to copy data to create skb for XDP_PASS.
2. We may need to call xsk_buff_free() to release the buffer.
3. The handle for xdp_buff is difference from the buffer.

If we pushed this logic into existing receive handle(merge and small),
we would have to maintain code scattered inside merge and small (and big).
So I think it is a good choice for us to put the xsk code into an
independent function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a908f5e72677..c9c65948b71f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -498,6 +498,12 @@ struct virtio_net_common_hdr {
 };
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			       struct net_device *dev,
+			       unsigned int *xdp_xmit,
+			       struct virtnet_rq_stats *stats);
+static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
+				 struct sk_buff *skb, u8 flags);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -1062,6 +1068,124 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
+				   struct receive_queue *rq, void *buf, u32 len)
+{
+	struct xdp_buff *xdp;
+	u32 bufsize;
+
+	xdp = (struct xdp_buff *)buf;
+
+	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_len;
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
+	xsk_buff_dma_sync_for_cpu(xdp);
+
+	return xdp;
+}
+
+static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
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
+static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct virtnet_info *vi,
+						 struct receive_queue *rq, struct xdp_buff *xdp,
+						 unsigned int *xdp_xmit,
+						 struct virtnet_rq_stats *stats)
+{
+	struct bpf_prog *prog;
+	u32 ret;
+
+	ret = XDP_PASS;
+	rcu_read_lock();
+	prog = rcu_dereference(rq->xdp_prog);
+	if (prog)
+		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	rcu_read_unlock();
+
+	switch (ret) {
+	case XDP_PASS:
+		return xsk_construct_skb(rq, xdp);
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		return NULL;
+
+	default:
+		/* drop packet */
+		xsk_buff_free(xdp);
+		u64_stats_inc(&stats->drops);
+		return NULL;
+	}
+}
+
+static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
+				    void *buf, u32 len,
+				    unsigned int *xdp_xmit,
+				    struct virtnet_rq_stats *stats)
+{
+	struct net_device *dev = vi->dev;
+	struct sk_buff *skb = NULL;
+	struct xdp_buff *xdp;
+	u8 flags;
+
+	len -= vi->hdr_len;
+
+	u64_stats_add(&stats->bytes, len);
+
+	xdp = buf_to_xdp(vi, rq, buf, len);
+	if (!xdp)
+		return;
+
+	if (unlikely(len < ETH_HLEN)) {
+		pr_debug("%s: short packet %i\n", dev->name, len);
+		DEV_STATS_INC(dev, rx_length_errors);
+		xsk_buff_free(xdp);
+		return;
+	}
+
+	flags = ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len))->hdr.flags;
+
+	if (!vi->mergeable_rx_bufs)
+		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
+
+	if (skb)
+		virtnet_receive_done(vi, rq, skb, flags);
+}
+
 static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
 				   struct xsk_buff_pool *pool, gfp_t gfp)
 {
@@ -2392,32 +2516,68 @@ static void refill_work(struct work_struct *work)
 	}
 }
 
-static int virtnet_receive(struct receive_queue *rq, int budget,
-			   unsigned int *xdp_xmit)
+static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
+				    struct receive_queue *rq,
+				    int budget,
+				    unsigned int *xdp_xmit,
+				    struct virtnet_rq_stats *stats)
+{
+	unsigned int len;
+	int packets = 0;
+	void *buf;
+
+	while (packets < budget) {
+		buf = virtqueue_get_buf(rq->vq, &len);
+		if (!buf)
+			break;
+
+		virtnet_receive_xsk_buf(vi, rq, buf, len, xdp_xmit, stats);
+		packets++;
+	}
+
+	return packets;
+}
+
+static int virtnet_receive_packets(struct virtnet_info *vi,
+				   struct receive_queue *rq,
+				   int budget,
+				   unsigned int *xdp_xmit,
+				   struct virtnet_rq_stats *stats)
 {
-	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct virtnet_rq_stats stats = {};
 	unsigned int len;
 	int packets = 0;
 	void *buf;
-	int i;
 
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		void *ctx;
-
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
-			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
 			packets++;
 		}
 	} else {
 		while (packets < budget &&
 		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
-			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
+			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, stats);
 			packets++;
 		}
 	}
 
+	return packets;
+}
+
+static int virtnet_receive(struct receive_queue *rq, int budget,
+			   unsigned int *xdp_xmit)
+{
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	struct virtnet_rq_stats stats = {};
+	int i, packets;
+
+	if (rq->xsk_pool)
+		packets = virtnet_receive_xsk_bufs(vi, rq, budget, xdp_xmit, &stats);
+	else
+		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
+
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
 		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
 			spin_lock(&vi->refill_lock);
-- 
2.32.0.3.g01195cf9f


