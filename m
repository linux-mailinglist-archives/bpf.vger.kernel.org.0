Return-Path: <bpf+bounces-20715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F08423CB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F071C22994
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71EF80058;
	Tue, 30 Jan 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CySrsmS8"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301F67E98;
	Tue, 30 Jan 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614972; cv=none; b=aYVhhgh98RmVYPHyJwYnbUZLGwvleJmRq15rxE9YVp9q7+ED2bbYAzOO+Z1d2GscRpt7EWIdO4QzzU+I6gZrOQg8UUEXd0D2aKO0a2hF51RPTzZnQ/S4Ms8vomITtcfkFexOdVmz55hHooP4EhOpGDqXsUmSEf4CxvKIfhgZRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614972; c=relaxed/simple;
	bh=kzt88VdnpTofgP+iR2skJ+NHH7VpB8COj0SURHqNfgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hftp5XHC5+lfWII3XiZcHkVn7TYdBD6/1P1u9DlLobDejwHG+CcY9a0y7zLcPLwpIr40PyE7YhDMOCztZrSG5eKjd4S5J6F+LjOBbvdzVe09TPUFdiHJHO1N5sQG8tNjKHOtw0xVcUVh6vLWDyCkhPmQ3CcQer6bUHgnJPvkvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CySrsmS8; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614968; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=r6iCdzsV8xEvLLqA0Ba/UisWAzFxmo/I9b/Z3w5ndek=;
	b=CySrsmS8ySuizfrzaMKq39iCPDyWaz9SP7DEhv817FXW6LmrCKzfSU7R1ZuYQ4b2Fzj9vjReNPzUaxh6xU3qOCmEwBl4bLwRTajbIyVFiacBWUpLyEAOqqX5B7PV12rtFO063emdHtH39F9X70wtoaIdS8VvV7Xc/jyTDjmFFDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W.g78.V_1706614966;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g78.V_1706614966)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:42:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 13/17] virtio_ring: remove api of setting vq premapped
Date: Tue, 30 Jan 2024 19:42:20 +0800
Message-Id: <20240130114224.86536-14-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 239d1d475be4
Content-Transfer-Encoding: 8bit

The virtio-net sets the premapped mode by find_vqs().

So the below API is not used by anyone, we remove it.

int virtqueue_set_dma_premapped(struct virtqueue *_vq);

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 56 ------------------------------------
 include/linux/virtio.h       |  2 --
 2 files changed, 58 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e7badc81642d..ccdd6dd3062f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2775,62 +2775,6 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
-/**
- * virtqueue_set_dma_premapped - set the vring premapped mode
- * @_vq: the struct virtqueue we're talking about.
- *
- * Enable the premapped mode of the vq.
- *
- * The vring in premapped mode does not do dma internally, so the driver must
- * do dma mapping in advance. The driver must pass the dma_address through
- * dma_address of scatterlist. When the driver got a used buffer from
- * the vring, it has to unmap the dma address.
- *
- * This function must be called immediately after creating the vq, or after vq
- * reset, and before adding any buffers to it.
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error.
- * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
- */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	u32 num;
-
-	START_USE(vq);
-
-	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
-
-	if (num != vq->vq.num_free) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
-	if (!vq->use_dma_api) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
-	vq->vq.premapped = true;
-
-	if (vq->packed_ring) {
-		kfree(vq->packed.desc_dma);
-		vq->packed.desc_dma = NULL;
-	} else {
-		kfree(vq->split.desc_dma);
-		vq->split.desc_dma = NULL;
-	}
-
-	END_USE(vq);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
-
 /**
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 37ba44dc34de..7f16bacc6c49 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -82,8 +82,6 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
-
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f


