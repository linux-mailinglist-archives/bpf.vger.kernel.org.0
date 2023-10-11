Return-Path: <bpf+bounces-11889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F587C4EC5
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80688281FEE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522B1DDDF;
	Wed, 11 Oct 2023 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DAA1DDC6;
	Wed, 11 Oct 2023 09:27:45 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E085B0;
	Wed, 11 Oct 2023 02:27:42 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtwGXce_1697016458;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VtwGXce_1697016458)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 17:27:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 09/22] virtio_net: separate virtnet_rx_resize()
Date: Wed, 11 Oct 2023 17:27:15 +0800
Message-Id: <20231011092728.105904-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch separates two sub-functions from virtnet_rx_resize():

* virtnet_rx_pause
* virtnet_rx_resume

Then the subsequent reset rx for xsk can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 29 +++++++++++++++++++++--------
 drivers/net/virtio/virtio_net.h |  3 +++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index f32cfa189972..ffab59da8506 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -2126,26 +2126,39 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static int virtnet_rx_resize(struct virtnet_info *vi,
-			     struct virtnet_rq *rq, u32 ring_num)
+void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq)
 {
 	bool running = netif_running(vi->dev);
-	int err, qindex;
-
-	qindex = rq - vi->rq;
 
 	if (running)
 		napi_disable(&rq->napi);
+}
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
-	if (err)
-		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq)
+{
+	bool running = netif_running(vi->dev);
 
 	if (!try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
 		virtnet_napi_enable(rq->vq, &rq->napi);
+}
+
+static int virtnet_rx_resize(struct virtnet_info *vi,
+			     struct virtnet_rq *rq, u32 ring_num)
+{
+	int err, qindex;
+
+	qindex = rq - vi->rq;
+
+	virtnet_rx_pause(vi, rq);
+
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_rx_resume(vi, rq);
 	return err;
 }
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 282504d6639a..70eea23adba6 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -253,4 +253,7 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int
 	else
 		return false;
 }
+
+void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
+void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 #endif
-- 
2.32.0.3.g01195cf9f


