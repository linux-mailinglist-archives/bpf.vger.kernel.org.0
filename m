Return-Path: <bpf+bounces-31821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D588903ACC
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483DB2880CB
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994517F4E6;
	Tue, 11 Jun 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wqy4/+T7"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D417F367;
	Tue, 11 Jun 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106116; cv=none; b=rVaPDTjLJz8KOYfLsWc+k9DN2qImbVxCFZ3UKAGjLGJ3C/kO5Cu1EOoGYoR/1loDPCi4pQAzvPLNjKQ/40ylqMOFQdMYcwtKu3twF3UAkSpXFvNMQ3l3Ht838C9gGuL9glTrkhT8TBzzSfiFsf5WU8F0WPyu5IRzPc5GcarYEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106116; c=relaxed/simple;
	bh=RMIftTGOW5DXsFSv8pREtCZVTXp9FNZZQBGXC9FL5kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjV0BeXYj8UybPRDmU/TjLccLnMdqATDq8abcYUXT4O5uUBMnCPRvCPGoREr4skexkny+2mhUeFQeDJ5nuRPw54yV3waYhsLslxvMjJpFXEWnJ4Sj7JFjs9zGfMBRb62qEuHukw0hGqa1SkD2oiALbnxh6SsLwB7ei9LHYta3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wqy4/+T7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106112; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z6fNKpTbPPs+9O1RsxQTUsm9U+ufsMclETU5fQyqE5A=;
	b=wqy4/+T7nVVuzKkZd6hWDUWf3ZjCxxbxkIvacA1mTXV8SKvZCG9ZhzhGeRulGjphTO8nacc/x4vDi5FBvmyR59AU32JBX3Re1ax7bWNsyN41QBswe8+6ip1nx+pMlyImYunEXllDrm5BYwJooeEs471bKb0mQrR3eBfoktruHto=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GFQlk_1718106110;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GFQlk_1718106110)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:51 +0800
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
Subject: [PATCH net-next v4 03/15] virtio_ring: virtqueue_set_dma_premapped() support to disable
Date: Tue, 11 Jun 2024 19:41:35 +0800
Message-Id: <20240611114147.31320-4-xuanzhuo@linux.alibaba.com>
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
index 79e313de1566..20705311f59a 100644
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


