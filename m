Return-Path: <bpf+bounces-12262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BD7CA763
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03359B20EA0
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2526E17;
	Mon, 16 Oct 2023 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE5266D5;
	Mon, 16 Oct 2023 12:00:41 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C5E5;
	Mon, 16 Oct 2023 05:00:38 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuH0NZd_1697457635;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuH0NZd_1697457635)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 20:00:36 +0800
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
Subject: [PATCH net-next v1 01/19] virtio_net: rename free_old_xmit_skbs to free_old_xmit
Date: Mon, 16 Oct 2023 20:00:15 +0800
Message-Id: <20231016120033.26933-2-xuanzhuo@linux.alibaba.com>
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

Since free_old_xmit_skbs not only deals with skb, but also xdp frame and
subsequent added xsk, so change the name of this function to
free_old_xmit.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fe7f314d65c9..3d87386d8220 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -744,7 +744,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	}
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
+static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
 	unsigned int packets = 0;
@@ -816,7 +816,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
 		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq, false);
+			free_old_xmit(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
@@ -2124,7 +2124,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit(sq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -2246,7 +2246,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit(sq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
@@ -2336,7 +2336,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (use_napi)
 			virtqueue_disable_cb(sq->vq);
 
-		free_old_xmit_skbs(sq, false);
+		free_old_xmit(sq, false);
 
 	} while (use_napi && kick &&
 	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
-- 
2.32.0.3.g01195cf9f


