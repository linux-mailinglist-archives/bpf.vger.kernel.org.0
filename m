Return-Path: <bpf+bounces-22576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0E860CD4
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 09:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D41F2252B
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97994E1CE;
	Fri, 23 Feb 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ydsz84gL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971764CDE5;
	Fri, 23 Feb 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676885; cv=none; b=tI3HOHUY83OZUkfQPU/lyyS6z1cVzNhaa+aa9yqSqNBJ84TmPwMrthh+uPbY8OlqYvsus63qyhVSITsbLut9EI++fcmQnlEGrK3jxzNjuWJTtYw5G2MazCoYjhuYEOXCuGqaQVYZ0zqJyGaJIAqDRC3hc8NPQbJLcHIr2KfT2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676885; c=relaxed/simple;
	bh=yPM5tBpfJQI8Ju/RW0nFXCP/h+fVOud1sDDLqpPuNJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InBilwd1lieRLMslZbuB79DefeQT09LrW24jQDcM+PeK/OXtOEsk2UjBZQjbuPpSEZ/7BuMzozSTmFY2V5fVunXwrIIfVBXjcxgtErZYqi0upwA+JxnAEDx+zBfv48WdydxOpFNZMZNhWeeXXuoffmuyH8NLCObmpdCChjKN+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ydsz84gL; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708676875; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5W/fyj7ubQoZEKftTvGZ0AfKf1xx3NzxaJdw6hTkCm4=;
	b=Ydsz84gLZVY+uT5fNxJBzhyewfZCtIgh5RvyJJYBcwtIWTFnmvo/6YEKP6nz7YA3kZjAOe+7NZSktS9JfzLdeWgUQrdGN7UADgNdMx5UvWHbSESTdWRsuUIF04XfjScCaReNwoUGxW6fMNVbCknWTdyCR+dBvWfbaW+NpM5b558=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W13gVDK_1708676873;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13gVDK_1708676873)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 16:27:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v2 17/19] virtio_net: unify the code for recycling the xmit ptr
Date: Fri, 23 Feb 2024 16:27:24 +0800
Message-Id: <20240223082726.52915-18-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 510995f33855
Content-Transfer-Encoding: 8bit

There are two completely similar and independent implementations. This
is inconvenient for the subsequent addition of new types. So extract a
function from this piece of code and call this function uniformly to
recover old xmit ptr.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 82 +++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 140b2c155650..62f65e2cacd5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -80,6 +80,11 @@ struct virtnet_stat_desc {
 	size_t offset;
 };
 
+struct virtnet_sq_free_stats {
+	u64 packets;
+	u64 bytes;
+};
+
 struct virtnet_sq_stats {
 	struct u64_stats_sync syncp;
 	u64_stats_t packets;
@@ -363,6 +368,31 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static void __free_old_xmit(struct send_queue *sq, bool in_napi,
+			    struct virtnet_sq_free_stats *stats)
+{
+	unsigned int len;
+	void *ptr;
+
+	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+		++stats->packets;
+
+		if (!is_xdp_frame(ptr)) {
+			struct sk_buff *skb = ptr;
+
+			pr_debug("Sent skb %p\n", skb);
+
+			stats->bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+		} else {
+			struct xdp_frame *frame = ptr_to_xdp(ptr);
+
+			stats->bytes += xdp_get_frame_len(frame);
+			xdp_return_frame(frame);
+		}
+	}
+}
+
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -759,37 +789,19 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
-	unsigned int len;
-	unsigned int packets = 0;
-	unsigned int bytes = 0;
-	void *ptr;
+	struct virtnet_sq_free_stats stats = {0};
 
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (likely(!is_xdp_frame(ptr))) {
-			struct sk_buff *skb = ptr;
-
-			pr_debug("Sent skb %p\n", skb);
-
-			bytes += skb->len;
-			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
-
-			bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		}
-		packets++;
-	}
+	__free_old_xmit(sq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
 	 */
-	if (!packets)
+	if (!stats.packets)
 		return;
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_add(&sq->stats.bytes, bytes);
-	u64_stats_add(&sq->stats.packets, packets);
+	u64_stats_add(&sq->stats.bytes, stats.bytes);
+	u64_stats_add(&sq->stats.packets, stats.packets);
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
@@ -928,15 +940,12 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_sq_free_stats stats = {0};
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
-	unsigned int len;
-	int packets = 0;
-	int bytes = 0;
 	int nxmit = 0;
 	int kicks = 0;
-	void *ptr;
 	int ret;
 	int i;
 
@@ -955,20 +964,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (likely(is_xdp_frame(ptr))) {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
-
-			bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		} else {
-			struct sk_buff *skb = ptr;
-
-			bytes += skb->len;
-			napi_consume_skb(skb, false);
-		}
-		packets++;
-	}
+	__free_old_xmit(sq, false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -988,8 +984,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 out:
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_add(&sq->stats.bytes, bytes);
-	u64_stats_add(&sq->stats.packets, packets);
+	u64_stats_add(&sq->stats.bytes, stats.bytes);
+	u64_stats_add(&sq->stats.packets, stats.packets);
 	u64_stats_add(&sq->stats.xdp_tx, n);
 	u64_stats_add(&sq->stats.xdp_tx_drops, n - nxmit);
 	u64_stats_add(&sq->stats.kicks, kicks);
-- 
2.32.0.3.g01195cf9f


