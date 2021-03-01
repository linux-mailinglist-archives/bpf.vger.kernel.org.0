Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67933327667
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 04:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhCADXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 22:23:23 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37170 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhCADXW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Feb 2021 22:23:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UPrERmG_1614568959;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0UPrERmG_1614568959)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Mar 2021 11:22:39 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH v5 net-next] virtio-net: support XDP when not more queues
Date:   Mon,  1 Mar 2021 11:22:39 +0800
Message-Id: <1614568959-107464-1-git-send-email-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The number of queues implemented by many virtio backends is limited,
especially some machines have a large number of CPUs. In this case, it
is often impossible to allocate a separate queue for
XDP_TX/XDP_REDIRECT, then xdp cannot be loaded to work, even xdp does
not use the XDP_TX/XDP_REDIRECT.

This patch allows XDP_TX/XDP_REDIRECT to run by reuse the existing SQ
with __netif_tx_lock() hold when there are not enough queues.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
v5: change subject from 'support XDP_TX when not more queues'

v4: make sparse happy
    suggested by Jakub Kicinski

v3: add warning when no more queues
    suggested by Jesper Dangaard Brouer

 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba8e637..55f1dd1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -195,6 +195,9 @@ struct virtnet_info {
 	/* # of XDP queue pairs currently used by the driver */
 	u16 xdp_queue_pairs;

+	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
+	bool xdp_enabled;
+
 	/* I like... big packets and I cannot lie! */
 	bool big_packets;

@@ -481,14 +484,42 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 	return 0;
 }

-static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
+static struct send_queue *virtnet_get_xdp_sq(struct virtnet_info *vi)
+	__acquires(lock)
 {
+	struct netdev_queue *txq;
 	unsigned int qp;

-	qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
+	if (vi->curr_queue_pairs > nr_cpu_ids) {
+		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
+
+		/* tell sparse we took the lock, but don't really take it */
+		__acquire(lock);
+	} else {
+		qp = smp_processor_id() % vi->curr_queue_pairs;
+		txq = netdev_get_tx_queue(vi->dev, qp);
+		__netif_tx_lock(txq, raw_smp_processor_id());
+	}
+
 	return &vi->sq[qp];
 }

+static void virtnet_put_xdp_sq(struct virtnet_info *vi, struct send_queue *sq)
+	__releases(lock)
+{
+	struct netdev_queue *txq;
+	unsigned int qp;
+
+	if (vi->curr_queue_pairs <= nr_cpu_ids) {
+		qp = sq - vi->sq;
+		txq = netdev_get_tx_queue(vi->dev, qp);
+		__netif_tx_unlock(txq);
+	} else {
+		/* make sparse happy */
+		__release(lock);
+	}
+}
+
 static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
@@ -512,7 +543,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	if (!xdp_prog)
 		return -ENXIO;

-	sq = virtnet_xdp_sq(vi);
+	sq = virtnet_get_xdp_sq(vi);

 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
 		ret = -EINVAL;
@@ -560,12 +591,13 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	sq->stats.kicks += kicks;
 	u64_stats_update_end(&sq->stats.syncp);

+	virtnet_put_xdp_sq(vi, sq);
 	return ret;
 }

 static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
 {
-	return vi->xdp_queue_pairs ? VIRTIO_XDP_HEADROOM : 0;
+	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
 }

 /* We copy the packet for XDP in the following cases:
@@ -1457,12 +1489,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 		xdp_do_flush();

 	if (xdp_xmit & VIRTIO_XDP_TX) {
-		sq = virtnet_xdp_sq(vi);
+		sq = virtnet_get_xdp_sq(vi);
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			sq->stats.kicks++;
 			u64_stats_update_end(&sq->stats.syncp);
 		}
+		virtnet_put_xdp_sq(vi, sq);
 	}

 	return received;
@@ -2417,10 +2450,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,

 	/* XDP requires extra queues for XDP_TX */
 	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
-		NL_SET_ERR_MSG_MOD(extack, "Too few free TX rings available");
-		netdev_warn(dev, "request %i queues but max is %i\n",
+		netdev_warn(dev, "XDP request %i queues but max is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx mode.\n",
 			    curr_qp + xdp_qp, vi->max_queue_pairs);
-		return -ENOMEM;
+		xdp_qp = 0;
 	}

 	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
@@ -2454,11 +2486,14 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	vi->xdp_queue_pairs = xdp_qp;

 	if (prog) {
+		vi->xdp_enabled = true;
 		for (i = 0; i < vi->max_queue_pairs; i++) {
 			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
 			if (i == 0 && !old_prog)
 				virtnet_clear_guest_offloads(vi);
 		}
+	} else {
+		vi->xdp_enabled = false;
 	}

 	for (i = 0; i < vi->max_queue_pairs; i++) {
@@ -2526,7 +2561,7 @@ static int virtnet_set_features(struct net_device *dev,
 	int err;

 	if ((dev->features ^ features) & NETIF_F_LRO) {
-		if (vi->xdp_queue_pairs)
+		if (vi->xdp_enabled)
 			return -EBUSY;

 		if (features & NETIF_F_LRO)
--
1.8.3.1

