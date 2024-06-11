Return-Path: <bpf+bounces-31831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA5903AF2
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA772B2106E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2773181322;
	Tue, 11 Jun 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MCtyFzy/"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7E180A76;
	Tue, 11 Jun 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106127; cv=none; b=R53hA7uTacSlSpJUYiZ2dvxT0MDVP8AW20AHzBz2h3DfO7zVMD0YM5VYaFhn9BqQSA9vrHFiXvcx9KWMpDUr8r5UMs5AB5hUXmNH/zm6mez5ESO9bWR4xj5RKJ+Gs7B9zC0s26tJ2sMyqGwc1GhYg778ai+1ABaLK4G5VRyaV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106127; c=relaxed/simple;
	bh=s1J/8BXPY3afduNCNpVhntBdgsW3ihQRJHP3VMSoToM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CA1WknlEibGl4rkOOeHC34Zi7LTo7JFzQjtWeYouWvKJgpY8cnkuyfftMyzCSqzidVf4MUqQrWOHEw1b7L44NmJF6eW5CvNhcv7CGgGJEeEcqikcWyFb7J6zPbxLP2wFxC4WDtpmkupJm0RwREQt+4iD1M9cmwMDORkNX75Ry4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MCtyFzy/; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106123; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UbkVCxZYAqLC9rmzu9AsDvcY3U0AB05NHTf6PRDqFg8=;
	b=MCtyFzy/8DhOz3gGCHbSrknRC3FlaYRwUO83kn8JVSgUvGlJWb6qd1MVSSBeNRI3LppdBYGVi/GIO2lTHdChP5Sp77GfTG1IJ7s7aRcd6+5XNNNfcHfYwHGLhtjNQ2Fw+S0aUBW8OswI31TP0VOKuLVrfGy6K1loQM29n/varwQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GJ8Bn_1718106121;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GJ8Bn_1718106121)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:42:01 +0800
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
Subject: [PATCH net-next v4 13/15]  virtio_net: xsk: tx: handle the transmitted xsk buffer
Date: Tue, 11 Jun 2024 19:41:45 +0800
Message-Id: <20240611114147.31320-14-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: c1658a8c15b0
Content-Transfer-Encoding: 8bit

 virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
 buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 60 ++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7f8ef93a194a..d38b4ef80f6f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -87,6 +87,7 @@ struct virtnet_stat_desc {
 struct virtnet_sq_free_stats {
 	u64 packets;
 	u64 bytes;
+	u64 xsk;
 };
 
 struct virtnet_sq_stats {
@@ -529,6 +530,7 @@ struct virtio_net_common_hdr {
 };
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_xsk_completed(struct send_queue *sq, int num);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -730,6 +732,11 @@ static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
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
@@ -762,10 +769,24 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 		case VIRTNET_XMIT_TYPE_DMA:
 			virtnet_sq_unmap(sq, &ptr);
 			goto retry;
+
+		case VIRTNET_XMIT_TYPE_XSK:
+			stats->bytes += virtnet_ptr_to_xsk(ptr);
+			stats->xsk++;
+			break;
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
@@ -1194,7 +1215,7 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
 	struct virtnet_sq_free_stats stats = {0};
 
-	__free_old_xmit(sq, in_napi, &stats);
+	virtnet_free_old_xmit(sq, in_napi, &stats);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -1335,8 +1356,12 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64 kicks = 0;
 	int sent;
 
+	/* Avoid to wakeup napi meanless, so call __free_old_xmit. */
 	__free_old_xmit(sq, true, &stats);
 
+	if (stats.xsk)
+		xsk_tx_completed(sq->xsk.pool, stats.xsk);
+
 	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
 
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
@@ -1355,6 +1380,16 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
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
@@ -1368,14 +1403,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 
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
@@ -1491,7 +1531,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, false, &stats);
+	virtnet_free_old_xmit(sq, false, &stats);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -5839,6 +5879,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	case VIRTNET_XMIT_TYPE_DMA:
 		virtnet_sq_unmap(sq, &buf);
 		goto retry;
+
+	case VIRTNET_XMIT_TYPE_XSK:
+		xsk_tx_completed(sq->xsk.pool, 1);
+		break;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


