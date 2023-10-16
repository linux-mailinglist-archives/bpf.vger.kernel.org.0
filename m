Return-Path: <bpf+bounces-12281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38677CA7B3
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E121C20A6A
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26728E35;
	Mon, 16 Oct 2023 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1628DD3;
	Mon, 16 Oct 2023 12:01:02 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CFE5;
	Mon, 16 Oct 2023 05:00:59 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuHSrm._1697457652;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuHSrm._1697457652)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 20:00:53 +0800
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
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v1 16/19] virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
Date: Mon, 16 Oct 2023 20:00:30 +0800
Message-Id: <20231016120033.26933-17-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 9790cc452aab
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implementing the logic of xsk rx. If this packet is not for XSK
determined in XDP, then we need to copy once to generate a SKB.
If it is for XSK, it is a zerocopy receive packet process.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  14 ++--
 drivers/net/virtio/virtio_net.h |   4 ++
 drivers/net/virtio/xsk.c        | 120 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   4 ++
 4 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 0e740447b142..003dd67ab707 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -822,10 +822,10 @@ static void put_xdp_frags(struct xdp_buff *xdp)
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
@@ -1589,13 +1589,17 @@ static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 		return;
 	}
 
-	if (vi->mergeable_rx_bufs)
+	rcu_read_lock();
+	if (rcu_dereference(rq->xsk.pool))
+		skb = virtnet_receive_xsk(dev, vi, rq, buf, len, xdp_xmit, stats);
+	else if (vi->mergeable_rx_bufs)
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
 	else if (vi->big_packets)
 		skb = receive_big(dev, vi, rq, buf, len, stats);
 	else
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+	rcu_read_unlock();
 
 	if (unlikely(!skb))
 		return;
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 6e71622fca45..fd7f34703c9b 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -346,6 +346,10 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int
 		return false;
 }
 
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats);
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 841fb078882a..f1c64414fac9 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -13,6 +13,18 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+static unsigned int virtnet_receive_buf_num(struct virtnet_info *vi, char *buf)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+
+	if (vi->mergeable_rx_bufs) {
+		hdr = (struct virtio_net_hdr_mrg_rxbuf *)buf;
+		return virtio16_to_cpu(vi->vdev, hdr->num_buffers);
+	}
+
+	return 1;
+}
+
 static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
@@ -37,6 +49,114 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
 		netif_stop_subqueue(dev, qnum);
 }
 
+static void merge_drop_follow_xdp(struct net_device *dev,
+				  struct virtnet_rq *rq,
+				  u32 num_buf,
+				  struct virtnet_rq_stats *stats)
+{
+	struct xdp_buff *xdp;
+	u32 len;
+
+	while (num_buf-- > 1) {
+		xdp = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!xdp)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 dev->name, num_buf);
+			dev->stats.rx_length_errors++;
+			break;
+		}
+		stats->bytes += len;
+		xsk_buff_free(xdp);
+	}
+}
+
+static struct sk_buff *construct_skb(struct virtnet_rq *rq,
+				     struct xdp_buff *xdp)
+{
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+	unsigned int size;
+
+	size = xdp->data_end - xdp->data_hard_start;
+	skb = napi_alloc_skb(&rq->napi, size);
+	if (unlikely(!skb))
+		return NULL;
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
+	return skb;
+}
+
+struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtnet_info *vi,
+				    struct virtnet_rq *rq, void *buf,
+				    unsigned int len, unsigned int *xdp_xmit,
+				    struct virtnet_rq_stats *stats)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct sk_buff *skb = NULL;
+	u32 ret, headroom, num_buf;
+	struct bpf_prog *prog;
+	struct xdp_buff *xdp;
+
+	len -= vi->hdr_len;
+
+	xdp = (struct xdp_buff *)buf;
+
+	xsk_buff_set_size(xdp, len);
+
+	hdr = xdp->data - vi->hdr_len;
+
+	num_buf = virtnet_receive_buf_num(vi, (char *)hdr);
+	if (num_buf > 1)
+		goto drop;
+
+	headroom = xdp->data - xdp->data_hard_start;
+
+	xdp_prepare_buff(xdp, xdp->data_hard_start, headroom, len, true);
+	xsk_buff_dma_sync_for_cpu(xdp, rq->xsk.pool);
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
+		skb = construct_skb(rq, xdp);
+		xsk_buff_free(xdp);
+		break;
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		goto consumed;
+
+	default:
+		goto drop;
+	}
+
+	return skb;
+
+drop:
+	stats->drops++;
+
+	xsk_buff_free(xdp);
+
+	if (num_buf > 1)
+		merge_drop_follow_xdp(dev, rq, num_buf, stats);
+consumed:
+	return NULL;
+}
+
 static int virtnet_add_recvbuf_batch(struct virtnet_info *vi, struct virtnet_rq *rq,
 				     struct xsk_buff_pool *pool, gfp_t gfp)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index bef41a3f954e..dbd2839a5f61 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -25,4 +25,8 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
 			    struct xsk_buff_pool *pool, gfp_t gfp);
+struct sk_buff *virtnet_receive_xsk(struct net_device *dev, struct virtnet_info *vi,
+				    struct virtnet_rq *rq, void *buf,
+				    unsigned int len, unsigned int *xdp_xmit,
+				    struct virtnet_rq_stats *stats);
 #endif
-- 
2.32.0.3.g01195cf9f


