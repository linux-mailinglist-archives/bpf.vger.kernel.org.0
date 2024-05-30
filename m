Return-Path: <bpf+bounces-30941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545788D4AD0
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088E21F23681
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAE1779BB;
	Thu, 30 May 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xe0ZKpeZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331617FACC;
	Thu, 30 May 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068263; cv=none; b=MfcDT31rXdmnjA2Fnt/dBrmT4RBv35D8SYfUnFdrmBbEI6ZhV7Av47UKeTvGF+189xB7nL8iJxpOZyqpkdjSwoQNL8sNq3Jk9qvpBrkLKBBpGdmbRB4k+wVGDswrTslqvUGogBMOtb9SlbgkLcMA5ZZ/Svq016xBzYi3ZdKU6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068263; c=relaxed/simple;
	bh=vK2lnPXrFgi4vN1pvQNFjeduefPWbc9wVyj9JcUiBA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjhA4GV4uT3W3Pimi9X1I8PDfZcAj3bSfj7FMVnFbwefz49Rw38NQlKEQ1N0Y70lrrc+eVKI2+Bbw5OxILaonPTKYLloJj1Rh029LI9YM9amuqwrV+wrl63gsIa5iT0JXDFqQJuMPQ01itgsPHsMCFB0miiFuJFmYDIZej+CGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xe0ZKpeZ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068258; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NE5xMR+GAAqdD3lWIpQVtq+5ZyPXa19FRaSZUNahye8=;
	b=xe0ZKpeZJF1cNsJ1FjXo13lsyP4rc0Iz3643stka5OmEiUI2t/KjEQ2uiueP+wQsy0YylelGSk6WtMwoSKdOo7dLh2hP+jrzbur5PrMJh/GPrhup1sw97p31GNolBzsrUSDgzBGOmh6BY65O40o3n0D5W8SdHutSp7clpWMD1ws=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7Wnmnq_1717068257;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7Wnmnq_1717068257)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 11/12] virtio_ring: virtqueue_set_dma_premapped() support to disable
Date: Thu, 30 May 2024 19:24:05 +0800
Message-Id: <20240530112406.94452-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: fcf606ca5ff8
Content-Transfer-Encoding: 8bit

virtio-net sq will only enable premapped mode when the sq is bound to
the af-xdp.

So we need the helper (virtqueue_set_dma_premapped) to enable the
premapped mode when af-xdp binds to the sq. And to disable the
premapped mode when af-xdp unbinds to the sq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet_main.c | 2 +-
 drivers/virtio/virtio_ring.c      | 7 ++++---
 include/linux/virtio.h            | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 68b90ee788bd..60ef7bb2228d 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -707,7 +707,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq, true));
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cdcd8ae63c71..37c9c5b55864 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2764,8 +2764,9 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
 /**
  * virtqueue_set_dma_premapped - set the vring premapped mode
  * @_vq: the struct virtqueue we're talking about.
+ * @premapped: bool enable/disable the premapped mode
  *
- * Enable the premapped mode of the vq.
+ * Enable/disable the premapped mode of the vq.
  *
  * The vring in premapped mode does not do dma internally, so the driver must
  * do dma mapping in advance. The driver must pass the dma_address through
@@ -2782,7 +2783,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * 0: success.
  * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u32 num;
@@ -2796,7 +2797,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
+	vq->premapped = premapped;
 
 	END_USE(vq);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 6e57098c457e..38e18a764573 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f


