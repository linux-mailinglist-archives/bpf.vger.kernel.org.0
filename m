Return-Path: <bpf+bounces-14364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791F7E33F4
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A881C20A55
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0810612E69;
	Tue,  7 Nov 2023 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0910951;
	Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14613D51;
	Mon,  6 Nov 2023 19:12:50 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvsQheF_1699326767;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvsQheF_1699326767)
          by smtp.aliyun-inc.com;
          Tue, 07 Nov 2023 11:12:48 +0800
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
Subject: [PATCH net-next v2 17/21] virtio_net: xsk: rx: skip dma unmap when rq is bind with AF_XDP
Date: Tue,  7 Nov 2023 11:12:23 +0800
Message-Id: <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
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

When rq is bound with AF_XDP, the buffer dma is managed
by the AF_XDP APIs. So the buffer got from the virtio core should
skip the dma unmap operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 8 +++++---
 drivers/net/virtio/virtio_net.h | 3 +++
 drivers/net/virtio/xsk.c        | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 15943a22e17d..a318b2533b94 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -430,7 +430,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf && rq->do_dma_unmap)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -561,8 +561,10 @@ static void virtnet_set_premapped(struct virtnet_info *vi)
 
 		/* disable for big mode */
 		if (vi->mergeable_rx_bufs || !vi->big_packets) {
-			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
+			if (!virtqueue_set_dma_premapped(vi->rq[i].vq)) {
 				vi->rq[i].do_dma = true;
+				vi->rq[i].do_dma_unmap = true;
+			}
 		}
 	}
 }
@@ -3944,7 +3946,7 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	if (rq->do_dma_unmap)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 1242785e311e..2005d0cd22e2 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -135,6 +135,9 @@ struct virtnet_rq {
 	/* Do dma by self */
 	bool do_dma;
 
+	/* Do dma unmap after getting buf from virtio core. */
+	bool do_dma_unmap;
+
 	struct {
 		struct xsk_buff_pool *pool;
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index e737c3353212..b09c473c29fb 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -210,6 +210,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *
 		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
 
 	rq->xsk.pool = pool;
+	rq->do_dma_unmap = !pool;
 
 	virtnet_rx_resume(vi, rq);
 
-- 
2.32.0.3.g01195cf9f


