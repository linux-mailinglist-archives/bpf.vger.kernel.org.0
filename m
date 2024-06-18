Return-Path: <bpf+bounces-32387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803190C6A2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260832828FD
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CA19DF68;
	Tue, 18 Jun 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UDrGUMpv"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D219D063;
	Tue, 18 Jun 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697411; cv=none; b=OeKa8KHECh+oiYq7nLL6DKbmwH0kQGjh6I+Bb/gg5/wrTjmgrKQ1kVYHz7oPA1MmtNH/P8Vgag6ZZ2DUeZb7DJRLM1jjjZC79KPmcnlq9TOd8acL4o/7CaDe9gCFOrlzs9J8jMRNZNfat8HAGoTbPR0WJQSDaoMVjVj1t2R21VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697411; c=relaxed/simple;
	bh=IbrWDD/M6UuraqnIRgfvTJ/ldPjzXo4zDvUASkwkvi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpmS4yLhRiLBSlWi4xO+LbjzcC8JgBbiVw9ny+KusGKEWL1QywjKVpr16peTr22Ek1gKXoT/9Ub/bL9oFt+2RZE16F29OK8KFLNma0WuIO8v5QqS8RgCt4w4nSf8vo3R8TZ81xKzIykJmRPTqzNYth/A1mACEqSgiWJdqIwxAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UDrGUMpv; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697406; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0+975V3JDgAw2XntSD3QdhSCqZPFbCdxtW+HMDHVqrc=;
	b=UDrGUMpv5Z2M2UrzT5wSlX2zW8pPE22mDFXI1f/iTXhx27rHpkNeVsfgCMBIP5QV2qym8WhjoOLMzNJ72nTkUZVMuvpKgiLP5cE2jiRiTJoVIAWHTJoeRLb8Z9olb944gn8QyiwmPgi58gy8i1/n0AKfLyIAeF0kF/OP6/b4awU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jSGAN_1718697405;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jSGAN_1718697405)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:46 +0800
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
Subject: [PATCH net-next v6 02/10] virtio_net: separate virtnet_tx_resize()
Date: Tue, 18 Jun 2024 15:56:35 +0800
Message-Id: <20240618075643.24867-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 8baa0af3684b
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
index 8ad158bbf188..1ac5f472d4ef 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2647,12 +2647,11 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
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
 
@@ -2673,10 +2672,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
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
@@ -2685,6 +2691,23 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
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


