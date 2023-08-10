Return-Path: <bpf+bounces-7458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5313E7778A2
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0857E282377
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78A263B5;
	Thu, 10 Aug 2023 12:31:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0162590C;
	Thu, 10 Aug 2023 12:31:21 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06C1B4;
	Thu, 10 Aug 2023 05:31:19 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VpToDv4_1691670673;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VpToDv4_1691670673)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 20:31:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH vhost v13 12/12] virtio_net: merge dma operations when filling mergeable buffers
Date: Thu, 10 Aug 2023 20:30:57 +0800
Message-Id: <20230810123057.43407-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 6ea114ee5d47
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the virtio core will perform a dma operation for each
buffer. Although, the same page may be operated multiple times.

This patch, the driver does the dma operation and manages the dma
address based the feature premapped of virtio core.

This way, we can perform only one dma operation for the pages of the
alloc frag. This is beneficial for the iommu device.

kernel command line: intel_iommu=on iommu.passthrough=0

       |  strict=0  | strict=1
Before |  775496pps | 428614pps
After  | 1109316pps | 742853pps

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 228 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 202 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 486b5849033d..16adb5ef18f8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -126,6 +126,14 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
+/* The dma information of pages allocated at a time. */
+struct virtnet_rq_dma {
+	dma_addr_t addr;
+	u32 ref;
+	u16 len;
+	u16 need_sync;
+};
+
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -175,6 +183,12 @@ struct receive_queue {
 	char name[16];
 
 	struct xdp_rxq_info xdp_rxq;
+
+	/* Record the last dma info to free after new pages is allocated. */
+	struct virtnet_rq_dma *last_dma;
+
+	/* Do dma by self */
+	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -549,6 +563,156 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	return skb;
 }
 
+static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
+{
+	struct page *page = virt_to_head_page(buf);
+	struct virtnet_rq_dma *dma;
+	void *head;
+	int offset;
+
+	head = page_address(page);
+
+	dma = head;
+
+	--dma->ref;
+
+	if (dma->ref) {
+		if (dma->need_sync && len) {
+			offset = buf - (head + sizeof(*dma));
+
+			virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr, offset,
+								len, DMA_FROM_DEVICE);
+		}
+
+		return;
+	}
+
+	virtqueue_dma_unmap_single_attrs(rq->vq, dma->addr, dma->len,
+					 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	put_page(page);
+}
+
+static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
+{
+	void *buf;
+
+	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	if (buf && rq->do_dma)
+		virtnet_rq_unmap(rq, buf, *len);
+
+	return buf;
+}
+
+static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
+{
+	void *buf;
+
+	buf = virtqueue_detach_unused_buf(rq->vq);
+	if (buf && rq->do_dma)
+		virtnet_rq_unmap(rq, buf, 0);
+
+	return buf;
+}
+
+static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
+{
+	struct virtnet_rq_dma *dma;
+	dma_addr_t addr;
+	u32 offset;
+	void *head;
+
+	if (!rq->do_dma) {
+		sg_init_one(rq->sg, buf, len);
+		return;
+	}
+
+	head = page_address(rq->alloc_frag.page);
+
+	offset = buf - head;
+
+	dma = head;
+
+	addr = dma->addr - sizeof(*dma) + offset;
+
+	sg_init_table(rq->sg, 1);
+	rq->sg[0].dma_address = addr;
+	rq->sg[0].length = len;
+}
+
+static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
+{
+	struct page_frag *alloc_frag = &rq->alloc_frag;
+	struct virtnet_rq_dma *dma;
+	void *buf, *head;
+	dma_addr_t addr;
+
+	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
+		return NULL;
+
+	head = page_address(alloc_frag->page);
+
+	if (rq->do_dma) {
+		dma = head;
+
+		/* new pages */
+		if (!alloc_frag->offset) {
+			if (rq->last_dma) {
+				/* Now, the new page is allocated, the last dma
+				 * will not be used. So the dma can be unmapped
+				 * if the ref is 0.
+				 */
+				virtnet_rq_unmap(rq, rq->last_dma, 0);
+				rq->last_dma = NULL;
+			}
+
+			dma->len = alloc_frag->size - sizeof(*dma);
+
+			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
+							      dma->len, DMA_FROM_DEVICE, 0);
+			if (virtqueue_dma_mapping_error(rq->vq, addr))
+				return NULL;
+
+			dma->addr = addr;
+			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+
+			/* Add a reference to dma to prevent the entire dma from
+			 * being released during error handling. This reference
+			 * will be freed after the pages are no longer used.
+			 */
+			get_page(alloc_frag->page);
+			dma->ref = 1;
+			alloc_frag->offset = sizeof(*dma);
+
+			rq->last_dma = dma;
+		}
+
+		++dma->ref;
+	}
+
+	buf = head + alloc_frag->offset;
+
+	get_page(alloc_frag->page);
+	alloc_frag->offset += size;
+
+	return buf;
+}
+
+static void virtnet_rq_set_premapped(struct virtnet_info *vi)
+{
+	int i;
+
+	/* disable for big mode */
+	if (!vi->mergeable_rx_bufs && vi->big_packets)
+		return;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
+			continue;
+
+		vi->rq[i].do_dma = true;
+	}
+}
+
 static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
@@ -835,7 +999,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 		void *buf;
 		int off;
 
-		buf = virtqueue_get_buf(rq->vq, &buflen);
+		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
 		if (unlikely(!buf))
 			goto err_buf;
 
@@ -1126,7 +1290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		return -EINVAL;
 
 	while (--*num_buf > 0) {
-		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
+		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
 				 dev->name, *num_buf,
@@ -1351,7 +1515,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	while (--num_buf) {
 		int num_skb_frags;
 
-		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
+		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
 				 dev->name, num_buf,
@@ -1414,7 +1578,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 err_skb:
 	put_page(page);
 	while (num_buf-- > 1) {
-		buf = virtqueue_get_buf(rq->vq, &len);
+		buf = virtnet_rq_get_buf(rq, &len, NULL);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
 				 dev->name, num_buf);
@@ -1524,7 +1688,6 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 			     gfp_t gfp)
 {
-	struct page_frag *alloc_frag = &rq->alloc_frag;
 	char *buf;
 	unsigned int xdp_headroom = virtnet_get_headroom(vi);
 	void *ctx = (void *)(unsigned long)xdp_headroom;
@@ -1533,17 +1696,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	if (unlikely(!skb_page_frag_refill(len, alloc_frag, gfp)))
+
+	buf = virtnet_rq_alloc(rq, len, gfp);
+	if (unlikely(!buf))
 		return -ENOMEM;
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	get_page(alloc_frag->page);
-	alloc_frag->offset += len;
-	sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
-		    vi->hdr_len + GOOD_PACKET_LEN);
+	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
+			       vi->hdr_len + GOOD_PACKET_LEN);
+
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
-	if (err < 0)
+	if (err < 0) {
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
+	}
+
 	return err;
 }
 
@@ -1620,23 +1787,22 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	unsigned int headroom = virtnet_get_headroom(vi);
 	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
-	char *buf;
+	unsigned int len, hole;
 	void *ctx;
+	char *buf;
 	int err;
-	unsigned int len, hole;
 
 	/* Extra tailroom is needed to satisfy XDP's assumption. This
 	 * means rx frags coalescing won't work, but consider we've
 	 * disabled GSO for XDP, it won't be a big issue.
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
-	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
+
+	buf = virtnet_rq_alloc(rq, len + room, gfp);
+	if (unlikely(!buf))
 		return -ENOMEM;
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
 	buf += headroom; /* advance address leaving hole at front of pkt */
-	get_page(alloc_frag->page);
-	alloc_frag->offset += len + room;
 	hole = alloc_frag->size - alloc_frag->offset;
 	if (hole < len + room) {
 		/* To avoid internal fragmentation, if there is very likely not
@@ -1650,11 +1816,15 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 		alloc_frag->offset += hole;
 	}
 
-	sg_init_one(rq->sg, buf, len);
+	virtnet_rq_init_one_sg(rq, buf, len);
+
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
-	if (err < 0)
+	if (err < 0) {
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
+	}
 
 	return err;
 }
@@ -1775,13 +1945,13 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		void *ctx;
 
 		while (stats.packets < budget &&
-		       (buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx))) {
+		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
 			stats.packets++;
 		}
 	} else {
 		while (stats.packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			stats.packets++;
 		}
@@ -3553,8 +3723,11 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 {
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
-		if (vi->rq[i].alloc_frag.page)
+		if (vi->rq[i].alloc_frag.page) {
+			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
+		}
 }
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
@@ -3591,9 +3764,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		struct virtqueue *vq = vi->rq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
-			virtnet_rq_free_unused_buf(vq, buf);
+		struct receive_queue *rq = &vi->rq[i];
+
+		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
+			virtnet_rq_free_unused_buf(rq->vq, buf);
 		cond_resched();
 	}
 }
@@ -3767,6 +3941,8 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
+	virtnet_rq_set_premapped(vi);
+
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
-- 
2.32.0.3.g01195cf9f


