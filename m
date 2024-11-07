Return-Path: <bpf+bounces-44217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD299C00C0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 10:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B299283F32
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6F1E22EF;
	Thu,  7 Nov 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n8TwnvEh"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C11E04A6;
	Thu,  7 Nov 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970030; cv=none; b=U6TnprIl06k69TmTwEYf0qiyF+vDOLWtDrxEIR7iIPSqHoChxy/Hb+auMEsT8Qk6jOOtkab1LNiWG5Yj3solxkv4XbFvzu0c6bn53Zf3Dt8sjQFrNcPbK+efjPePHo+kw1Fv9uaznzc9ghi+1LLwJPUwcurUlWC4Qylm0jqTl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970030; c=relaxed/simple;
	bh=f0DPkx2b/M39zMWjz/rEmo1hUpl6qlE7N0DjTki2sXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DarxAinuzAhI8xJy5VhhzkkuYC3JiOZkhgkaZ3GCXnO54BLQaKTczeJq8qer60GC4SQPPlY7R8pr3eorfGqZ5ULXipTLVWk4mb/Nan63zNHCRgFoeUX1laSOhiXsMsBV1YUnEsuk3SQhAizv5cDqV3yYo78CQvjk+hkPLK0E8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n8TwnvEh; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730970026; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LgR1U2ms27+S2ZlqNBsLcPiwCkcrIV0sDV7JnO0EpJo=;
	b=n8TwnvEhxPLEcxUdMtqYumCLZSOTlZjoHh1siAsJMfyBHYRzv+8reRkY2ngXSPdD4SQ6QUgr8M1lDnwftyWibV4eGGV/ROqVZYbdaCo14D7CaCpex3JzuUlOODM8887yoNQeQO5hqoGKVxcmsJH+FJWEF4XfB3owh60z51CnFdY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIuulS9_1730969712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v3 08/13] virtio_net: refactor the xmit type
Date: Thu,  7 Nov 2024 16:54:59 +0800
Message-Id: <20241107085504.63131-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2634baada01d
Content-Transfer-Encoding: 8bit

Because the af-xdp will introduce a new xmit type, so I refactor the
xmit type mechanism first.

We know both xdp_frame and sk_buff are at least 4 bytes aligned.
For the xdp tx, we do not pass any pointer to virtio core as data,
we just need to pass the len of the packet. So we will push len
to the void pointer. We can make sure the pointer is 4 bytes aligned.

And the data structure of AF_XDP also is at least 4 bytes aligned.

So the last two bits of the pointers are free, we can't use these to
distinguish them.

    00 for skb
    01 for SKB_ORPHAN
    10 for XDP
    11 for AF-XDP tx

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e4ebf3ffbf02..079d4a213fda 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG		BIT(0)
-#define VIRTIO_ORPHAN_FLAG	BIT(1)
-
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -509,34 +506,35 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 
-static bool is_xdp_frame(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
-}
+enum virtnet_xmit_type {
+	VIRTNET_XMIT_TYPE_SKB,
+	VIRTNET_XMIT_TYPE_SKB_ORPHAN,
+	VIRTNET_XMIT_TYPE_XDP,
+};
 
-static void *xdp_to_ptr(struct xdp_frame *ptr)
-{
-	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
-}
+/* We use the last two bits of the pointer to distinguish the xmit type. */
+#define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
+static enum virtnet_xmit_type virtnet_xmit_ptr_unpack(void **ptr)
 {
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
-}
+	unsigned long p = (unsigned long)*ptr;
 
-static bool is_orphan_skb(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_ORPHAN_FLAG;
+	*ptr = (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
+
+	return p & VIRTNET_XMIT_TYPE_MASK;
 }
 
-static void *skb_to_ptr(struct sk_buff *skb, bool orphan)
+static void *virtnet_xmit_ptr_pack(void *ptr, enum virtnet_xmit_type type)
 {
-	return (void *)((unsigned long)skb | (orphan ? VIRTIO_ORPHAN_FLAG : 0));
+	return (void *)((unsigned long)ptr | type);
 }
 
-static struct sk_buff *ptr_to_skb(void *ptr)
+static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
+			      enum virtnet_xmit_type type)
 {
-	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
+	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
+				    virtnet_xmit_ptr_pack(data, type),
+				    GFP_ATOMIC);
 }
 
 static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
@@ -548,29 +546,37 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
+	struct xdp_frame *frame;
+	struct sk_buff *skb;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr_to_skb(ptr);
+		switch (virtnet_xmit_ptr_unpack(&ptr)) {
+		case VIRTNET_XMIT_TYPE_SKB:
+			skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
+			stats->napi_packets++;
+			stats->napi_bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+			break;
 
-			if (is_orphan_skb(ptr)) {
-				stats->packets++;
-				stats->bytes += skb->len;
-			} else {
-				stats->napi_packets++;
-				stats->napi_bytes += skb->len;
-			}
+		case VIRTNET_XMIT_TYPE_SKB_ORPHAN:
+			skb = ptr;
+
+			stats->packets++;
+			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
+			break;
+
+		case VIRTNET_XMIT_TYPE_XDP:
+			frame = ptr;
 
 			stats->packets++;
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+			break;
 		}
 	}
 	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
@@ -1430,8 +1436,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT_TYPE_XDP);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -3052,8 +3057,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
-				    skb_to_ptr(skb, orphan), GFP_ATOMIC);
+
+	return virtnet_add_outbuf(sq, num_sg, skb,
+				  orphan ? VIRTNET_XMIT_TYPE_SKB_ORPHAN : VIRTNET_XMIT_TYPE_SKB);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -5930,10 +5936,16 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
-	if (!is_xdp_frame(buf))
+	switch (virtnet_xmit_ptr_unpack(&buf)) {
+	case VIRTNET_XMIT_TYPE_SKB:
+	case VIRTNET_XMIT_TYPE_SKB_ORPHAN:
 		dev_kfree_skb(buf);
-	else
-		xdp_return_frame(ptr_to_xdp(buf));
+		break;
+
+	case VIRTNET_XMIT_TYPE_XDP:
+		xdp_return_frame(buf);
+		break;
+	}
 }
 
 static void free_unused_bufs(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f


