Return-Path: <bpf+bounces-32390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305490C6B2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D686CB21EE5
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B619E7E0;
	Tue, 18 Jun 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WkCPGnJC"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2C19DFB8;
	Tue, 18 Jun 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697417; cv=none; b=Da9/hjvBT5hY82u4j2cVFgi+qtKRg4jDmSKk+lN2GmPhGfGrOvBye3qTqB3lVlLAyhU7Z9CV+PGTw7i7wCBCJpEKWRrZacHZ7clWhEv1fERo7Dr48gFwhZi0peeNuXmkHLXhoAjrmwbi9Fu4UdO0IkVa7QoB0N7RmJAzGINRwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697417; c=relaxed/simple;
	bh=waVC2FU3K27ZkBhNh6ZRk5Wta1rOKgPYqdgV623Vo8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzQAePvTZUZemp+wdbsbSShBJBNqFm3gOi3zWiYGDviHVF/NxWh+o6dMXlXzWSEvLY9AX7/Eb2buaBYpLzVkIH1AOWJTdKhb4XolhGC5fapoT0vz9SuoTgXZ14x4tdyP5zFfmy6FNSxAaXNB21flhPsO8EQ6z/Hj8CQZt54rHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WkCPGnJC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697413; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j+HK2Pga9FC+0Ld0lAckCoZyJD7Mum6zyveF3e2PrLs=;
	b=WkCPGnJCI61FLvz7qpiw6i7kJuQBYYqc1NtuYfG8G9aVxquN0gkh5IrNTr8sJ7pc2+/HH5bF5rwxCafWF25aOizNPmOQ8nqHMuRiTwKduHRYKLLGWkd9woaNZcAnsDpFqLPN8u7NQYvoJU17NVp6KRVqrgeeM0vPScTyzNuEYUY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jSGCc_1718697411;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jSGCc_1718697411)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:52 +0800
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
Subject: [PATCH net-next v6 08/10] virtio_net: xsk: rx: support recv small mode
Date: Tue, 18 Jun 2024 15:56:41 +0800
Message-Id: <20240618075643.24867-9-xuanzhuo@linux.alibaba.com>
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

In the process:
1. We may need to copy data to create skb for XDP_PASS.
2. We may need to call xsk_buff_free() to release the buffer.
3. The handle for xdp_buff is difference from the buffer.

If we pushed this logic into existing receive handle(merge and small),
we would have to maintain code scattered inside merge and small (and big).
So I think it is a good choice for us to put the xsk code into an
independent function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 135 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2ac5668a94ce..06608d696e2e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -500,6 +500,10 @@ struct virtio_net_common_hdr {
 };
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			       struct net_device *dev,
+			       unsigned int *xdp_xmit,
+			       struct virtnet_rq_stats *stats);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -1040,6 +1044,120 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
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
+	xsk_buff_dma_sync_for_cpu(xdp);
+
+	return xdp;
+}
+
+static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
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
+		return xdp_construct_skb(rq, xdp);
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
+static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
+					       void *buf, u32 len,
+					       unsigned int *xdp_xmit,
+					       struct virtnet_rq_stats *stats)
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
+	if (!vi->mergeable_rx_bufs)
+		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
+
+	return skb;
+}
+
 static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
 				   struct xsk_buff_pool *pool, gfp_t gfp)
 {
@@ -2363,9 +2481,22 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	void *buf;
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
 
+			skb = virtnet_receive_xsk_buf(vi, rq, buf, len, xdp_xmit, &stats);
+			if (skb)
+				virtnet_receive_done(vi, rq, skb);
+
+			packets++;
+		}
+	} else if (!vi->big_packets || vi->mergeable_rx_bufs) {
+		void *ctx;
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
-- 
2.32.0.3.g01195cf9f


