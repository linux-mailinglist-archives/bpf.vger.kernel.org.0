Return-Path: <bpf+bounces-32168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5C9083D7
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2013E285E25
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F81836D0;
	Fri, 14 Jun 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NASL+KsT"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD51487E7;
	Fri, 14 Jun 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347187; cv=none; b=nm55GA/iP9wAW02DBasxxxWeKOIsv2UQ381yLNS34dhJ22aFycgcFd+788qNc3wJK6jEGZfRJc5iW81DB7iRq/GR4B67gd5mGNgGbeKkDtDElAVUpx05J29M5IzKISAFGUTXgpuw9OSzQktkwvqnY9Pw8Fu9UkDbz9D/PGP1+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347187; c=relaxed/simple;
	bh=tcxopaJoD+u815bFN/f9f0HYtcCX8rUPp/jcsEYNy3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mts2awH53MRs44TVRJlnxeM+7TTKIYJ5e6E1HJ0GQSVlQPgDs8+U+9SiYqw/q7p2zOnnsjmKI2LVFSFDkQOAvBrRajYUwCoFz1O1NU7fXjvKwBbZb6ZDVErirhu4FSwJVDdgEfk8axlblN6jQy5Hs67XqoYrr8q0tEBgmPSkOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NASL+KsT; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347177; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TukRhtN8QeiEObGWmfADeZDtr0qZu2kwqlq7Wk+V02Y=;
	b=NASL+KsToaV+3ibjQmDWusJZlxMe7kFbekIghkSzC11dQqSwxdB/7J412vRGnSlpb5Bl6nBTVzHch2QsE3x9QjjhJKA7HmFrRjBcQ5/DpZ6DWo/uf3gcEOaJTPRP6S8PRg70GMo8ECOUd3/PXlF19DMm2tTVlzgyaHJISyPzWtk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QEk9._1718347176;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QEk9._1718347176)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:37 +0800
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
Subject: [PATCH net-next v5 03/15] virtio_ring: virtqueue_set_dma_premapped() support to disable
Date: Fri, 14 Jun 2024 14:39:21 +0800
Message-Id: <20240614063933.108811-4-xuanzhuo@linux.alibaba.com>
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

virtio-net sq will only enable premapped mode when sq is bound to
the af-xdp.

So we need the helper (virtqueue_set_dma_premapped) to enable the
premapped mode when af-xdp binds to sq. And to disable the
premapped mode when af-xdp unbinds to sq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c     | 2 +-
 drivers/virtio/virtio_ring.c | 7 ++++---
 include/linux/virtio.h       | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..838b450d9591 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -938,7 +938,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq, true));
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d0d3004a408a..12083a0e6052 100644
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
index ca318a66a7e1..69677d02cee9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f


