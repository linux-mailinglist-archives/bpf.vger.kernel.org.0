Return-Path: <bpf+bounces-32172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A079083E2
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E9285E39
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F766185089;
	Fri, 14 Jun 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t7J2NZMt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DE1836C7;
	Fri, 14 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347190; cv=none; b=n14+ArwYFVdJQIkj1H3u2TSyilHpqhHLc3DKqCuRnVWCeX6R9cn6U4uf45YAnDikIw5XfUnkPIw5KfeA/h8uv/WDM/XpiczZ6RL65twLaq8PM+7jNT/I4RMyiR77HuKglvzgNWIQRhQzzpWvlmV22b+4LrNENqMsnSwaYloEyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347190; c=relaxed/simple;
	bh=mHbPA2yoaUoBHrdV0L+VpYOk3kHXG/SX7tMi2lycnyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZppV5261iSGXS6j+6eeF5onRE7lf2xKIOPTsufh3L6TxN/EehnRtwYWSPjIBXObVYo/p6LNrY+CZ+xaQhkJWtxKUQogJyBuz3bjTtVGfSaaBLnEUHOR3r2W46hZyGBOTARq1bt9E1yzNs/3oGFdEu+PigBLyAHLraPJ/8QOsR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t7J2NZMt; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347186; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PKxa5NOAvL+Dy50gDQCc3bEWPaH/ki6UgcOAl3k/kyg=;
	b=t7J2NZMt3QnFm9RMm2L/Yz9xMllqPEGvE783AtUyRtqfrrlLxYHLD/bZs00xX1NvBxe/qA3EnsUcuU6FER/cXS3hUFpgcfNnQgRg/FntBRQx0wT31SIb7kg2saLf9TXH5I+Pz9J6kyj4y3TksYmlGGroeiMuoxIymebAbGuUIsQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8Q97xn_1718347185;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8Q97xn_1718347185)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:45 +0800
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
Subject: [PATCH net-next v5 13/15]  virtio_net: xsk: tx: handle the transmitted xsk buffer
Date: Fri, 14 Jun 2024 14:39:31 +0800
Message-Id: <20240614063933.108811-14-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e008fb4a0943
Content-Transfer-Encoding: 8bit

 virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
 buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9bfccef18e27..d6be569bd849 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -87,6 +87,7 @@ struct virtnet_stat_desc {
 struct virtnet_sq_free_stats {
 	u64 packets;
 	u64 bytes;
+	u64 xsk;
 };
 
 struct virtnet_sq_stats {
@@ -530,6 +531,7 @@ struct virtio_net_common_hdr {
 };
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_xsk_completed(struct send_queue *sq, int num);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -733,6 +735,11 @@ static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
 	return 0;
 }
 
+static u32 virtnet_ptr_to_xsk(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			    struct virtnet_sq_free_stats *stats)
 {
@@ -773,12 +780,22 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			goto retry;
 
 		case VIRTNET_XMIT_TYPE_XSK:
-			/* Make gcc happy. DONE in subsequent commit */
+			stats->bytes += virtnet_ptr_to_xsk(ptr);
+			stats->xsk++;
 			break;
 		}
 	}
 }
 
+static void virtnet_free_old_xmit(struct send_queue *sq, bool in_napi,
+				  struct virtnet_sq_free_stats *stats)
+{
+	__free_old_xmit(sq, in_napi, stats);
+
+	if (stats->xsk)
+		virtnet_xsk_completed(sq, stats->xsk);
+}
+
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -1207,7 +1224,7 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, in_napi, &stats);
+	virtnet_free_old_xmit(sq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -1348,8 +1365,12 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64 kicks = 0;
 	int sent;
 
+	/* Avoid to wakeup napi meanless, so call __free_old_xmit. */
 	__free_old_xmit(sq, true, &stats);
 
+	if (stats.xsk)
+		xsk_tx_completed(sq->xsk.pool, stats.xsk);
+
 	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
 
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
@@ -1368,6 +1389,16 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+static void xsk_wakeup(struct send_queue *sq)
+{
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return;
+
+	local_bh_disable();
+	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	local_bh_enable();
+}
+
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -1381,14 +1412,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 
 	sq = &vi->sq[qid];
 
-	if (napi_if_scheduled_mark_missed(&sq->napi))
-		return 0;
+	xsk_wakeup(sq);
+	return 0;
+}
 
-	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
-	local_bh_enable();
+static void virtnet_xsk_completed(struct send_queue *sq, int num)
+{
+	xsk_tx_completed(sq->xsk.pool, num);
 
-	return 0;
+	/* If this is called by rx poll, start_xmit and xdp xmit we should
+	 * wakeup the tx napi to consume the xsk tx queue, because the tx
+	 * interrupt may not be triggered.
+	 */
+	xsk_wakeup(sq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
@@ -1504,7 +1540,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, false, &stats);
+	virtnet_free_old_xmit(sq, false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -5854,7 +5890,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 		goto retry;
 
 	case VIRTNET_XMIT_TYPE_XSK:
-		/* Make gcc happy. DONE in subsequent commit */
+		xsk_tx_completed(sq->xsk.pool, 1);
 		break;
 	}
 }
-- 
2.32.0.3.g01195cf9f


