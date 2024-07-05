Return-Path: <bpf+bounces-33939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8A9282D5
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42681F24022
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335A6145B07;
	Fri,  5 Jul 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eEdYoh/I"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C47143866;
	Fri,  5 Jul 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165064; cv=none; b=R3vDp82ZUCDo6erPIdUOwn03q/tkq7ZiZG4JFgFJIjl3q3iH2R0khGh+xH0slYm8cauq4370VLSzPrR0aVgjfI2yBpisaEa1ox12HhpDkckRVE2NJi/h+R4Rl/A3MmDWss8x+v6cX1FT8Gl6i/imv78fi276pH6m7UGI1GurJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165064; c=relaxed/simple;
	bh=N3BuQzEZ3xADxJCxh31dFbFp4xi723iW5Mhupk7GrXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyfdDTxzjVzs1m2G7QoDHQUdkSejhErPUpiGebSbDX0fl0ThJpv5ure/Zx4mDJiHru2dT9qR5sILATXuUymd9xcpl+QLfrhNfLHPL6T1gl5IIb2h48oqjA/lN+yjOUBTHYikAAw1lch2aydSXGVC7rYpQoB8oQ4Mrwha4m7JLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eEdYoh/I; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165059; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ixQcmDs1008Adtr8nnLB1TsPVvNLEyo3g5zAUujjY4M=;
	b=eEdYoh/IiGcSuBw2mmpZn45sHSYiaQGXDDzx1Gd8cvCi+Dya1NGq53Wdn6fRDcv/LhexKdgCWhtJSgkF/5AygixDXh4YV/6mmb3pP19LFIkxsh24AjaXJFQOx+kseHJ6rnqxuSjtZDrkAGhG2XyJ7HRV3vFgmETa0zHnzu9OOoc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9uE.dr_1720165057;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9uE.dr_1720165057)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:38 +0800
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
Subject: [PATCH net-next v7 03/10] virtio_net: separate virtnet_tx_resize()
Date: Fri,  5 Jul 2024 15:37:27 +0800
Message-Id: <20240705073734.93905-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
Content-Transfer-Encoding: 8bit

This patch separates two sub-functions from virtnet_tx_resize():

* virtnet_tx_pause
* virtnet_tx_resume

Then the subsequent virtnet_tx_reset() can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df5b23374c53..7d762614113b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2703,12 +2703,11 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	return err;
 }
 
-static int virtnet_tx_resize(struct virtnet_info *vi,
-			     struct send_queue *sq, u32 ring_num)
+static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 {
 	bool running = netif_running(vi->dev);
 	struct netdev_queue *txq;
-	int err, qindex;
+	int qindex;
 
 	qindex = sq - vi->sq;
 
@@ -2729,10 +2728,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	netif_stop_subqueue(vi->dev, qindex);
 
 	__netif_tx_unlock_bh(txq);
+}
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
-	if (err)
-		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
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
@@ -2741,6 +2747,23 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	if (running)
 		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+}
+
+static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
+			     u32 ring_num)
+{
+	int qindex, err;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_tx_resume(vi, sq);
+
 	return err;
 }
 
-- 
2.32.0.3.g01195cf9f


