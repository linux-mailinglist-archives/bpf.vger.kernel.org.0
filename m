Return-Path: <bpf+bounces-19590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564E82EBE6
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BBE2856B3
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A21B7E2;
	Tue, 16 Jan 2024 09:43:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18691774D;
	Tue, 16 Jan 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lmFRG_1705398201;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lmFRG_1705398201)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
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
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 07/17] virtio_net: xsk: tx: support wakeup
Date: Tue, 16 Jan 2024 17:43:03 +0800
Message-Id: <20240116094313.119939-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1913ebd4ae28
Content-Transfer-Encoding: 8bit

xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
user.

Virtio-net does not support to actively generate an interruption, so it
tries to trigger tx NAPI on the local cpu.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 20 ++++++--------------
 drivers/net/virtio/virtio_net.h |  9 +++++++++
 drivers/net/virtio/xsk.c        | 23 +++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  1 +
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 4575c885acb0..cb0a1ea712de 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -233,15 +233,6 @@ static void disable_delayed_refill(struct virtnet_info *vi)
 	spin_unlock_bh(&vi->refill_lock);
 }
 
-static void virtqueue_napi_schedule(struct napi_struct *napi,
-				    struct virtqueue *vq)
-{
-	if (napi_schedule_prep(napi)) {
-		virtqueue_disable_cb(vq);
-		__napi_schedule(napi);
-	}
-}
-
 static bool virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
@@ -250,7 +241,7 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 	opaque = virtqueue_enable_cb_prepare(vq);
 	if (napi_complete_done(napi, processed)) {
 		if (unlikely(virtqueue_poll(vq, opaque)))
-			virtqueue_napi_schedule(napi, vq);
+			virtnet_vq_napi_schedule(napi, vq);
 		else
 			return true;
 	} else {
@@ -269,7 +260,7 @@ static void skb_xmit_done(struct virtqueue *vq)
 	virtqueue_disable_cb(vq);
 
 	if (napi->weight)
-		virtqueue_napi_schedule(napi, vq);
+		virtnet_vq_napi_schedule(napi, vq);
 	else
 		/* We were probably waiting for more output buffers. */
 		netif_wake_subqueue(vi->dev, vq2txq(vq));
@@ -639,7 +630,7 @@ void virtnet_check_sq_full_and_disable(struct virtnet_info *vi,
 		netif_stop_subqueue(dev, qnum);
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
-				virtqueue_napi_schedule(&sq->napi, sq->vq);
+				virtnet_vq_napi_schedule(&sq->napi, sq->vq);
 		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
 			free_old_xmit(sq, false);
@@ -1807,7 +1798,7 @@ static void skb_recv_done(struct virtqueue *rvq)
 	struct virtnet_rq *rq = &vi->rq[vq2rxq(rvq)];
 
 	rq->calls++;
-	virtqueue_napi_schedule(&rq->napi, rvq);
+	virtnet_vq_napi_schedule(&rq->napi, rvq);
 }
 
 static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
@@ -1819,7 +1810,7 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	 * Call local_bh_enable after to trigger softIRQ processing.
 	 */
 	local_bh_disable();
-	virtqueue_napi_schedule(napi, vq);
+	virtnet_vq_napi_schedule(napi, vq);
 	local_bh_enable();
 }
 
@@ -3969,6 +3960,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index cc735a09a3d9..c30fb152ecd0 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -299,6 +299,15 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int
 		return false;
 }
 
+static inline void virtnet_vq_napi_schedule(struct napi_struct *napi,
+					    struct virtqueue *vq)
+{
+	if (napi_schedule_prep(napi)) {
+		virtqueue_disable_cb(vq);
+		__napi_schedule(napi);
+	}
+}
+
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index d2a96424ade9..9e5523ff5707 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -95,6 +95,29 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_sq *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return 0;
+
+	local_bh_disable();
+	virtnet_vq_napi_schedule(&sq->napi, sq->vq);
+	local_bh_enable();
+
+	return 0;
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
 				    struct xsk_buff_pool *pool)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 73ca8cd5308b..1bd19dcda649 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -17,4 +17,5 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 #endif
-- 
2.32.0.3.g01195cf9f


