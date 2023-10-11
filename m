Return-Path: <bpf+bounces-11880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3E7C4E9B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CB6282549
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CD1CFA1;
	Wed, 11 Oct 2023 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF261C2A4;
	Wed, 11 Oct 2023 09:27:35 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD02A4;
	Wed, 11 Oct 2023 02:27:32 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtwJVZv_1697016449;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VtwJVZv_1697016449)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 17:27:30 +0800
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
Subject: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Wed, 11 Oct 2023 17:27:07 +0800
Message-Id: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
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

virtqueue_set_dma_premapped() adds a new parameter to disable the
virtqueue premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c     |  2 +-
 drivers/virtio/virtio_ring.c | 11 ++++++++---
 include/linux/virtio.h       |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fe7f314d65c9..6b5f47ebf9b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 		return;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
+		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
 			continue;
 
 		vi->rq[i].do_dma = true;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..b3ded56722f4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * 0: success.
  * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u32 num;
@@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
-	vq->do_unmap = false;
+	if (mode) {
+		vq->premapped = true;
+		vq->do_unmap = false;
+	} else {
+		vq->premapped = false;
+		vq->do_unmap = vq->use_dma_api;
+	}
 
 	END_USE(vq);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4cc614a38376..1cf7b004348b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f


