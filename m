Return-Path: <bpf+bounces-78993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AECD23209
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E35030F5BDE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAE331A4E;
	Thu, 15 Jan 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QBrstOem"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AC330B29;
	Thu, 15 Jan 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465589; cv=none; b=p1zQlsE90H7EsCLH4DsI3gOJ54+DU5Pr/fGZv69U6CQeYOVDdfmOOG2dyM2VVBc+B44fG8mFFZMK4n0BH7pUZN63Veb2CN0MaN+cRZvxd7ea/YAMeCuABKhm/WN1tkUpJ/T+Fv3nIB8MeV3nadHFw/VYZmsOfdFbZtfRTQto4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465589; c=relaxed/simple;
	bh=MZfEByh+9dl0thDVWSYPQbzKvrntUG3X1FtuXaD+Hac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiEi77ugdtXUKOmtWZ/81+UcV7xTP9O97M1g1zSnoWN4Z2quxZqMJHSlFBS8VzM+9fMxh7wBLjjmVjWSGsHfWUNZ4PI9CfprmckG2at4z6evSYfDKQbDVgyVyF6b4eE5bcMRUyALFnns+bRqXPkjjd6QcclDCcyAmRazxs7YvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QBrstOem; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kDPOfxKZxMLXp+34wuu3rEJf6xcjKsdKBrNkbxQ+SfU=; b=QBrstOem6c9SVEzcGdbGhdNm5u
	E5nHReqPA1TEzjqhiKM/kIzLoK8Kkz7d4wfLk8utv/XtRd/oNyCi8RdLSzttwpVTY3Mu5K5RBEaEU
	Ov8K5yERzFDCTJS7E2yqWGZgYg9oRGiHZdQ737hB8Rw3H5c5y1Fj8UBpWb0jt3JCyiyE5vXh1ov+w
	b7lrVH+qfuGJ1fRzF7vq3R5H+smPfPekwd7Hg+hurR4GBm+x0/sPfYUJuUvdaKMYoHy7VyyCb6VOU
	UHKDdad6+jo4qhiNPCvjnjr//Qkr3EsWdfKhHz84wqyMvglXmnT5biKPpYSIgJN5uJNnK5iY1oHPa
	U++yRm5g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgF-000Npu-2u;
	Thu, 15 Jan 2026 09:26:11 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v7 06/16] net: Proxy netdev_queue_get_dma_dev for leased queues
Date: Thu, 15 Jan 2026 09:25:53 +0100
Message-ID: <20260115082603.219152-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27881/Thu Jan 15 08:25:08 2026)

From: David Wei <dw@davidwei.uk>

Extend netdev_queue_get_dma_dev to return the physical device of the
real rxq for DMA in case the queue was leased. This allows memory
providers like io_uring zero-copy or devmem to bind to the physically
leased rxq via virtual devices such as netkit.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/netdev_queues.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index fae92ee090c4..97acf6440829 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -9,16 +9,29 @@
  * @dev:	net_device
  * @idx:	queue index
  *
- * Get dma device for zero-copy operations to be used for this queue.
+ * Get dma device for zero-copy operations to be used for this queue. If the
+ * queue is leased to a physical queue, we retrieve the latter's dma device.
  * When such device is not available or valid, the function will return NULL.
  *
  * Return: Device or NULL on error
  */
 struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
 {
-	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
+	const struct netdev_queue_mgmt_ops *queue_ops;
 	struct device *dma_dev;
 
+	if (idx < dev->real_num_rx_queues) {
+		struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
+
+		if (rxq->lease) {
+			rxq = rxq->lease;
+			dev = rxq->dev;
+			idx = get_netdev_rx_queue_index(rxq);
+		}
+	}
+
+	queue_ops = dev->queue_mgmt_ops;
+
 	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
 		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
 	else
-- 
2.43.0


