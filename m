Return-Path: <bpf+bounces-14362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9CA7E33EB
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C2280F39
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BE10A34;
	Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849BDF6C;
	Tue,  7 Nov 2023 03:12:50 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE40D71;
	Mon,  6 Nov 2023 19:12:47 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvsPa.7_1699326764;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvsPa.7_1699326764)
          by smtp.aliyun-inc.com;
          Tue, 07 Nov 2023 11:12:45 +0800
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
Subject: [PATCH net-next v2 14/21] virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
Date: Tue,  7 Nov 2023 11:12:20 +0800
Message-Id: <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 59a160d210e8
Content-Transfer-Encoding: 8bit

virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
 drivers/net/virtio/xsk.h        |  5 +++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index a431a2c1ee47..a13d6d301fdb 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -225,6 +225,11 @@ struct virtnet_info {
 	struct failover *failover;
 };
 
+static inline bool virtnet_is_skb_ptr(void *ptr)
+{
+	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
+}
+
 static inline bool virtnet_is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static inline u32 virtnet_ptr_to_xsk(void *ptr);
+
 static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
 {
 	struct virtnet_sq_dma *next, *head;
@@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
 static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 					 u64 *bytes, u64 *packets)
 {
+	unsigned int xsknum = 0;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!virtnet_is_xdp_frame(ptr)) {
+		if (virtnet_is_skb_ptr(ptr)) {
 			struct sk_buff *skb;
 
 			if (sq->do_dma)
@@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 			*bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
+		} else if (virtnet_is_xdp_frame(ptr)) {
 			struct xdp_frame *frame;
 
 			if (sq->do_dma)
@@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 			*bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+		} else {
+			*bytes += virtnet_ptr_to_xsk(ptr);
+			++xsknum;
 		}
 		(*packets)++;
 	}
+
+	if (xsknum)
+		xsk_tx_completed(sq->xsk.pool, xsknum);
 }
 
 static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 1bd19dcda649..7ebc9bda7aee 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
 	return (void *)(p | VIRTIO_XSK_FLAG);
 }
 
+static inline u32 virtnet_ptr_to_xsk(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
-- 
2.32.0.3.g01195cf9f


