Return-Path: <bpf+bounces-19584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A3B82EBD2
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CD3B233CC
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B9134D7;
	Tue, 16 Jan 2024 09:43:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE012B9B;
	Tue, 16 Jan 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-lmy1m_1705398195;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lmy1m_1705398195)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:43:16 +0800
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
Subject: [PATCH net-next 02/17] virtio_net: separate virtnet_tx_resize()
Date: Tue, 16 Jan 2024 17:42:58 +0800
Message-Id: <20240116094313.119939-3-xuanzhuo@linux.alibaba.com>
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

This patch separates two sub-functions from virtnet_tx_resize():

* virtnet_tx_pause
* virtnet_tx_resume

Then the subsequent virtnet_tx_reset() can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/main.c       | 35 +++++++++++++++++++++++++++------
 drivers/net/virtio/virtio_net.h |  2 ++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 52686beca4ab..49c2c1c985f3 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -2331,12 +2331,11 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	return err;
 }
 
-static int virtnet_tx_resize(struct virtnet_info *vi,
-			     struct virtnet_sq *sq, u32 ring_num)
+void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq)
 {
 	bool running = netif_running(vi->dev);
 	struct netdev_queue *txq;
-	int err, qindex;
+	int qindex;
 
 	qindex = sq - vi->sq;
 
@@ -2357,10 +2356,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	netif_stop_subqueue(vi->dev, qindex);
 
 	__netif_tx_unlock_bh(txq);
+}
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_bufs);
-	if (err)
-		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq)
+{
+	bool running = netif_running(vi->dev);
+	struct netdev_queue *txq;
+	int qindex;
+
+	qindex = sq - vi->sq;
+
+	txq = netdev_get_tx_queue(vi->dev, qindex);
 
 	__netif_tx_lock_bh(txq);
 	sq->reset = false;
@@ -2369,6 +2375,23 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	if (running)
 		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+}
+
+static int virtnet_tx_resize(struct virtnet_info *vi, struct virtnet_sq *sq,
+			     u32 ring_num)
+{
+	int qindex, err;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_bufs);
+	if (err)
+		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_tx_resume(vi, sq);
+
 	return err;
 }
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 7d06e8fda83b..db86338e0dd0 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -212,4 +212,6 @@ struct virtnet_info {
 
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
+void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
+void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
 #endif
-- 
2.32.0.3.g01195cf9f


