Return-Path: <bpf+bounces-30940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE568D4ACB
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B130E285702
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055D1822CA;
	Thu, 30 May 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ks5FUj9N"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175601779BB;
	Thu, 30 May 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068262; cv=none; b=ln2YX+uODke94klMWZGKpBa4oqz1yvMzbOmLtuM37ToYQuvJJJ3Ts3teLQ0Fvx/SBTMgFgBAVuwjpaszVi+RLNDmGzup0IrFM0weRb3X7uMv8yeQp6ynpSLbRgUA6S6+QHHbCa5i7X96D5lWUrMRUGatJyS8hO/EHTuKjO7vJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068262; c=relaxed/simple;
	bh=Zdb1GWr7PeiI7ct6T0jO3OunX52i68pI0x9TPMix4oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HX+t0M3XUSwvAOnl2ej6sJ+RT/P444BSq8dTDcgHMikbSHqySxFtQtSFtU0pSoJOoJJ1v0EktxN94xE/YmdBCBqRBzgMUw9MAr9faYuKjIXHC8ZLjNHsNCFihTVXiy5IGrXGnBhU/PPK+MlIkvEZx2G9LOAK5lke1yIS0dq2c4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ks5FUj9N; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068251; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TIMrPzpMJh2GcPqD9+DKRytFNSJoZR+IJw9N4Fv2Vc8=;
	b=Ks5FUj9NHtipnkcG6GsIfz5MDDjzOTvvsCqu0oA7pkfDWE+1d33uX8JSxLLR/wmqAqiCzpbCpEywHp1t9FYCFOA+2CAh+axQ4PqhHGjvHLYtq4Gvyb8dVgXy/QL0qIYUo55rb8m4GMHIsSgjjMR+j0NKlqHgPlL9ZPrtSGMkCbU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7Ws87X_1717068250;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7Ws87X_1717068250)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:11 +0800
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
Subject: [PATCH net-next v2 04/12] virtio_net: separate virtnet_rx_resize()
Date: Thu, 30 May 2024 19:23:58 +0800
Message-Id: <20240530112406.94452-5-xuanzhuo@linux.alibaba.com>
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

This patch separates two sub-functions from virtnet_rx_resize():

* virtnet_rx_pause
* virtnet_rx_resume

Then the subsequent reset rx for xsk can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/virtnet.h      |  3 +++
 drivers/net/virtio/virtnet_main.c | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
index d4cc4ddb0786..b0f2ae4bd1c4 100644
--- a/drivers/net/virtio/virtnet.h
+++ b/drivers/net/virtio/virtnet.h
@@ -236,4 +236,7 @@ struct virtnet_info {
 
 	u64 device_stats_cap;
 };
+
+void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
+void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 #endif
diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index fc28fadf944e..a2bf576e644c 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -2378,28 +2378,41 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
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
 
 	if (running) {
 		napi_disable(&rq->napi);
 		cancel_work_sync(&rq->dim.work);
 	}
+}
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
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
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	if (err)
+		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_rx_resume(vi, rq);
 	return err;
 }
 
-- 
2.32.0.3.g01195cf9f


