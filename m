Return-Path: <bpf+bounces-29044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577778BF80F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9871C20C14
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2605537E0;
	Wed,  8 May 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UP2Rkp6C"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6B51C5B;
	Wed,  8 May 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155531; cv=none; b=TdEeNPzfuPg6zq3YSv1ggHWJCZ/+cCly53R2RywyWjTYWAEj53A71wc5zkkNHmebmSPYJc8Bss3PjBEQKHDwUblUAMDdGYeNOdpCK06IvqmbP6EBDvyJjHHtbVRLeOWBgx8WAlZRig/mhEA1FSu5JhQDZ6eYMiVF1d2rGdnyOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155531; c=relaxed/simple;
	bh=SmwSjJoCX19mP91qQ9JubGTzEyFRF8mTMAQVk2wzJ7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6g2D73AJMp6NemcXTeBEgeK54arxJZH4lrK8lyIsCRmXDVAVG442bOq+mJXZIQKn1zJjLnMh3F8GfQpP9X4agrI7dlULEX2OtqzACDhJCQjcQze0/rsu39BmI2D8honyGY9DgfZjAWb0jdNCVANmflQXhRe0jt0i1NbFvI9XU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UP2Rkp6C; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715155521; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=w+xoLhCkuriDHCYx04FNeRIrQPTNECBhmpziqU++sC8=;
	b=UP2Rkp6CTES2txNvtycFITlqXBiNSW94AYKVac+pkJv83i8DMtLFkIjkNtm/YZUguWSULz9KFmqdzSew6zt9EO6zNZmwBPV/QCc4ET18MaOtElkCGZ87i2ah/i6NuQ/yp0fLkq/X7Xd/l0E4IVVnekcfjrxzLS3OGycmvt5qsAQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W62sm-d_1715155519;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62sm-d_1715155519)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 16:05:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
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
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 3/7] virtio_net: add prefix virtnet to all struct inside virtio_net.h
Date: Wed,  8 May 2024 16:05:10 +0800
Message-Id: <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7cdcbabd0b89
Content-Transfer-Encoding: 8bit

We move some structures to the header file, but these structures do not
prefixed with virtnet. This patch adds virtnet for these.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.h      |  12 ++--
 drivers/net/virtio/virtnet_main.c | 110 +++++++++++++++---------------
 2 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
index a7990eb20ab5..4d902a79bde7 100644
--- a/drivers/net/virtio/virtnet.h
+++ b/drivers/net/virtio/virtnet.h
@@ -49,8 +49,8 @@ struct virtnet_rq_dma {
 };
 
 /* Internal representation of a send virtqueue */
-struct send_queue {
-	/* Virtqueue associated with this send _queue */
+struct virtnet_sq {
+	/* Virtqueue associated with this virtnet_sq */
 	struct virtqueue *vq;
 
 	/* TX: fragments + linear part + virtio header */
@@ -70,8 +70,8 @@ struct send_queue {
 };
 
 /* Internal representation of a receive virtqueue */
-struct receive_queue {
-	/* Virtqueue associated with this receive_queue */
+struct virtnet_rq {
+	/* Virtqueue associated with this virtnet_rq */
 	struct virtqueue *vq;
 
 	struct napi_struct napi;
@@ -142,8 +142,8 @@ struct virtnet_info {
 	struct virtio_device *vdev;
 	struct virtqueue *cvq;
 	struct net_device *dev;
-	struct send_queue *sq;
-	struct receive_queue *rq;
+	struct virtnet_sq *sq;
+	struct virtnet_rq *rq;
 	unsigned int status;
 
 	/* Max # of queue pairs supported by the device */
diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 1b85ba2bba8d..f9f01c10dff6 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -273,7 +273,7 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
-static void __free_old_xmit(struct send_queue *sq, bool in_napi,
+static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 			    struct virtnet_sq_free_stats *stats)
 {
 	unsigned int len;
@@ -342,7 +342,7 @@ skb_vnet_common_hdr(struct sk_buff *skb)
  * private is used to chain pages for big packets, put the whole
  * most recent used list in the beginning for reuse
  */
-static void give_pages(struct receive_queue *rq, struct page *page)
+static void give_pages(struct virtnet_rq *rq, struct page *page)
 {
 	struct page *end;
 
@@ -352,7 +352,7 @@ static void give_pages(struct receive_queue *rq, struct page *page)
 	rq->pages = page;
 }
 
-static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
+static struct page *get_a_page(struct virtnet_rq *rq, gfp_t gfp_mask)
 {
 	struct page *p = rq->pages;
 
@@ -366,7 +366,7 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 }
 
 static void virtnet_rq_free_buf(struct virtnet_info *vi,
-				struct receive_queue *rq, void *buf)
+				struct virtnet_rq *rq, void *buf)
 {
 	if (vi->mergeable_rx_bufs)
 		put_page(virt_to_head_page(buf));
@@ -481,7 +481,7 @@ static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
 
 /* Called from bottom half context */
 static struct sk_buff *page_to_skb(struct virtnet_info *vi,
-				   struct receive_queue *rq,
+				   struct virtnet_rq *rq,
 				   struct page *page, unsigned int offset,
 				   unsigned int len, unsigned int truesize,
 				   unsigned int headroom)
@@ -579,7 +579,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	return skb;
 }
 
-static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
+static void virtnet_rq_unmap(struct virtnet_rq *rq, void *buf, u32 len)
 {
 	struct page *page = virt_to_head_page(buf);
 	struct virtnet_rq_dma *dma;
@@ -608,7 +608,7 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 	put_page(page);
 }
 
-static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
+static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
 {
 	void *buf;
 
@@ -619,7 +619,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }
 
-static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
+static void virtnet_rq_init_one_sg(struct virtnet_rq *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
 	dma_addr_t addr;
@@ -639,7 +639,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	rq->sg[0].length = len;
 }
 
-static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
+static void *virtnet_rq_alloc(struct virtnet_rq *rq, u32 size, gfp_t gfp)
 {
 	struct page_frag *alloc_frag = &rq->alloc_frag;
 	struct virtnet_rq_dma *dma;
@@ -711,7 +711,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
-	struct receive_queue *rq;
+	struct virtnet_rq *rq;
 	int i = vq2rxq(vq);
 
 	rq = &vi->rq[i];
@@ -722,7 +722,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
-static void free_old_xmit(struct send_queue *sq, bool in_napi)
+static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 {
 	struct virtnet_sq_free_stats stats = {0};
 
@@ -752,7 +752,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 
 static void check_sq_full_and_disable(struct virtnet_info *vi,
 				      struct net_device *dev,
-				      struct send_queue *sq)
+				      struct virtnet_sq *sq)
 {
 	bool use_napi = sq->napi.weight;
 	int qnum;
@@ -786,7 +786,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
-				   struct send_queue *sq,
+				   struct virtnet_sq *sq,
 				   struct xdp_frame *xdpf)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
@@ -876,9 +876,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct virtnet_sq_free_stats stats = {0};
-	struct receive_queue *rq = vi->rq;
+	struct virtnet_rq *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
-	struct send_queue *sq;
+	struct virtnet_sq *sq;
 	int nxmit = 0;
 	int kicks = 0;
 	int ret;
@@ -1018,7 +1018,7 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct virtnet_rq *rq,
 				       int *num_buf,
 				       struct page *p,
 				       int offset,
@@ -1099,7 +1099,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
 
 static struct sk_buff *receive_small_xdp(struct net_device *dev,
 					 struct virtnet_info *vi,
-					 struct receive_queue *rq,
+					 struct virtnet_rq *rq,
 					 struct bpf_prog *xdp_prog,
 					 void *buf,
 					 unsigned int xdp_headroom,
@@ -1186,7 +1186,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 
 static struct sk_buff *receive_small(struct net_device *dev,
 				     struct virtnet_info *vi,
-				     struct receive_queue *rq,
+				     struct virtnet_rq *rq,
 				     void *buf, void *ctx,
 				     unsigned int len,
 				     unsigned int *xdp_xmit,
@@ -1233,7 +1233,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 
 static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_info *vi,
-				   struct receive_queue *rq,
+				   struct virtnet_rq *rq,
 				   void *buf,
 				   unsigned int len,
 				   struct virtnet_rq_stats *stats)
@@ -1254,7 +1254,7 @@ static struct sk_buff *receive_big(struct net_device *dev,
 	return NULL;
 }
 
-static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
+static void mergeable_buf_free(struct virtnet_rq *rq, int num_buf,
 			       struct net_device *dev,
 			       struct virtnet_rq_stats *stats)
 {
@@ -1328,7 +1328,7 @@ static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
 /* TODO: build xdp in big mode */
 static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				      struct virtnet_info *vi,
-				      struct receive_queue *rq,
+				      struct virtnet_rq *rq,
 				      struct xdp_buff *xdp,
 				      void *buf,
 				      unsigned int len,
@@ -1416,7 +1416,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 }
 
 static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
-				   struct receive_queue *rq,
+				   struct virtnet_rq *rq,
 				   struct bpf_prog *xdp_prog,
 				   void *ctx,
 				   unsigned int *frame_sz,
@@ -1491,7 +1491,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 
 static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 					     struct virtnet_info *vi,
-					     struct receive_queue *rq,
+					     struct virtnet_rq *rq,
 					     struct bpf_prog *xdp_prog,
 					     void *buf,
 					     void *ctx,
@@ -1551,7 +1551,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 
 static struct sk_buff *receive_mergeable(struct net_device *dev,
 					 struct virtnet_info *vi,
-					 struct receive_queue *rq,
+					 struct virtnet_rq *rq,
 					 void *buf,
 					 void *ctx,
 					 unsigned int len,
@@ -1696,7 +1696,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
-static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
+static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
 			struct virtnet_rq_stats *stats)
@@ -1756,7 +1756,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
  * not need to use  mergeable_len_to_ctx here - it is enough
  * to store the headroom as the context ignoring the truesize.
  */
-static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
+static int add_recvbuf_small(struct virtnet_info *vi, struct virtnet_rq *rq,
 			     gfp_t gfp)
 {
 	char *buf;
@@ -1784,7 +1784,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	return err;
 }
 
-static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
+static int add_recvbuf_big(struct virtnet_info *vi, struct virtnet_rq *rq,
 			   gfp_t gfp)
 {
 	struct page *first, *list = NULL;
@@ -1833,7 +1833,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 	return err;
 }
 
-static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
+static unsigned int get_mergeable_buf_len(struct virtnet_rq *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
@@ -1851,7 +1851,7 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 }
 
 static int add_recvbuf_mergeable(struct virtnet_info *vi,
-				 struct receive_queue *rq, gfp_t gfp)
+				 struct virtnet_rq *rq, gfp_t gfp)
 {
 	struct page_frag *alloc_frag = &rq->alloc_frag;
 	unsigned int headroom = virtnet_get_headroom(vi);
@@ -1905,7 +1905,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
  * before we're receiving packets, or from refill_work which is
  * careful to disable receiving (using napi_disable).
  */
-static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
+static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
 			  gfp_t gfp)
 {
 	int err;
@@ -1937,7 +1937,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
-	struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
+	struct virtnet_rq *rq = &vi->rq[vq2rxq(rvq)];
 
 	rq->calls++;
 	virtqueue_napi_schedule(&rq->napi, rvq);
@@ -1988,7 +1988,7 @@ static void refill_work(struct work_struct *work)
 	int i;
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
+		struct virtnet_rq *rq = &vi->rq[i];
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
@@ -2002,7 +2002,7 @@ static void refill_work(struct work_struct *work)
 	}
 }
 
-static int virtnet_receive(struct receive_queue *rq, int budget,
+static int virtnet_receive(struct virtnet_rq *rq, int budget,
 			   unsigned int *xdp_xmit)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
@@ -2056,11 +2056,11 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return packets;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct virtnet_rq *rq)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
-	struct send_queue *sq = &vi->sq[index];
+	struct virtnet_sq *sq = &vi->sq[index];
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
 
 	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
@@ -2084,7 +2084,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	}
 }
 
-static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
+static void virtnet_rx_dim_update(struct virtnet_info *vi, struct virtnet_rq *rq)
 {
 	struct dim_sample cur_sample = {};
 
@@ -2104,10 +2104,10 @@ static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue
 
 static int virtnet_poll(struct napi_struct *napi, int budget)
 {
-	struct receive_queue *rq =
-		container_of(napi, struct receive_queue, napi);
+	struct virtnet_rq *rq =
+		container_of(napi, struct virtnet_rq, napi);
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct send_queue *sq;
+	struct virtnet_sq *sq;
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
@@ -2210,7 +2210,7 @@ static int virtnet_open(struct net_device *dev)
 
 static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 {
-	struct send_queue *sq = container_of(napi, struct send_queue, napi);
+	struct virtnet_sq *sq = container_of(napi, struct virtnet_sq, napi);
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
@@ -2254,7 +2254,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
-static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
+static int xmit_skb(struct virtnet_sq *sq, struct sk_buff *skb)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
@@ -2305,7 +2305,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	int qnum = skb_get_queue_mapping(skb);
-	struct send_queue *sq = &vi->sq[qnum];
+	struct virtnet_sq *sq = &vi->sq[qnum];
 	int err;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
 	bool kick = !netdev_xmit_more();
@@ -2359,7 +2359,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-			     struct receive_queue *rq, u32 ring_num)
+			     struct virtnet_rq *rq, u32 ring_num)
 {
 	bool running = netif_running(vi->dev);
 	int err, qindex;
@@ -2384,7 +2384,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi,
-			     struct send_queue *sq, u32 ring_num)
+			     struct virtnet_sq *sq, u32 ring_num)
 {
 	bool running = netif_running(vi->dev);
 	struct netdev_queue *txq;
@@ -2546,8 +2546,8 @@ static void virtnet_stats(struct net_device *dev,
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		u64 tpackets, tbytes, terrors, rpackets, rbytes, rdrops;
-		struct receive_queue *rq = &vi->rq[i];
-		struct send_queue *sq = &vi->sq[i];
+		struct virtnet_rq *rq = &vi->rq[i];
+		struct virtnet_sq *sq = &vi->sq[i];
 
 		do {
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
@@ -2950,8 +2950,8 @@ static int virtnet_set_ringparam(struct net_device *dev,
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	u32 rx_pending, tx_pending;
-	struct receive_queue *rq;
-	struct send_queue *sq;
+	struct virtnet_rq *rq;
+	struct virtnet_sq *sq;
 	int i, err;
 
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
@@ -3918,8 +3918,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
-		struct send_queue *sq = &vi->sq[i];
+		struct virtnet_rq *rq = &vi->rq[i];
+		struct virtnet_sq *sq = &vi->sq[i];
 
 		stats_base = (const u8 *)&rq->stats;
 		do {
@@ -4145,8 +4145,8 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 static void virtnet_rx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct receive_queue *rq = container_of(dim,
-			struct receive_queue, dim);
+	struct virtnet_rq *rq = container_of(dim,
+			struct virtnet_rq, dim);
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct net_device *dev = vi->dev;
 	struct dim_cq_moder update_moder;
@@ -4488,7 +4488,7 @@ static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
 				       struct netdev_queue_stats_rx *stats)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct receive_queue *rq = &vi->rq[i];
+	struct virtnet_rq *rq = &vi->rq[i];
 	struct virtnet_stats_ctx ctx = {0};
 
 	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);
@@ -4501,7 +4501,7 @@ static void virtnet_get_queue_stats_tx(struct net_device *dev, int i,
 				       struct netdev_queue_stats_tx *stats)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct send_queue *sq = &vi->sq[i];
+	struct virtnet_sq *sq = &vi->sq[i];
 	struct virtnet_stats_ctx ctx = {0};
 
 	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);
@@ -4844,7 +4844,7 @@ static int virtnet_set_features(struct net_device *dev,
 static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct virtnet_info *priv = netdev_priv(dev);
-	struct send_queue *sq = &priv->sq[txqueue];
+	struct virtnet_sq *sq = &priv->sq[txqueue];
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	u64_stats_update_begin(&sq->stats.syncp);
-- 
2.32.0.3.g01195cf9f


