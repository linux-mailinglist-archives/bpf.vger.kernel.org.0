Return-Path: <bpf+bounces-78773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650FD1BB3E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5218F305A467
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C0636C0AA;
	Tue, 13 Jan 2026 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OLN5F25Y"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908136BCE9;
	Tue, 13 Jan 2026 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346613; cv=none; b=s6qY7P3/YOBiC12F5qBAPtvL8zIvO7v/Yq4vGRXOmBvrT2IQstw3iPjQZy1Cgq/kLoWh4FbQa0ysM47gvmnoJsG6ymy0TxQRxAHoShHhKXpfnpxSI7iEzE1WdgjSCZeUfXrBaSSOhVCGXMekFkRFdV6zHH2EBMFkB+aXjdUnKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346613; c=relaxed/simple;
	bh=MZfEByh+9dl0thDVWSYPQbzKvrntUG3X1FtuXaD+Hac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnxrs8dy5thhAv/xv5S22eKsKjuq1xWjWDcLC0kxN60RJSm0GkDr4ybnC1HB1uOyZcsyLCd0Yxtf2EwL+KQQNOybNJ+AVovri5XOgPc3yZkchv3BXtTUH6pCQUcKCDhvQaUJulEfYsocyjR0BY1Oz75/a0Rop0TnS6J2i3RirOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OLN5F25Y; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kDPOfxKZxMLXp+34wuu3rEJf6xcjKsdKBrNkbxQ+SfU=; b=OLN5F25Ymc7U8P0MG0CM+sPjEw
	o+AdkpJqX0HP3xjG8m857Py4aGdCHbavQM6TEGLHOAIGg17GPpaIaqXWTKtpeMDHNnwuGO27c//3q
	5vroPykmpwfoBTHaCnPhINJlBEdrM+j35MNuamvPukHZmq7XiniGpaUeVEH6WQmbF0QHEhbRwasRk
	anEn0jxNF9X+fC5Jbz99Jdb4YcUEFqUE8TvATr2IznzEKbvsk/GkLdwJ8QNquWnvudiqVDIsd8d+b
	CH3ugauWaGgIU4bcbNuTNdARVPFpiYikkDXpM4AvxI5W8Lp78Fj4ZePJrf2r9XQgVt34E/hLmYjDF
	3/zQNtmg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnj8-0003X0-26;
	Wed, 14 Jan 2026 00:23:06 +0100
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
Subject: [PATCH net-next v6 06/16] net: Proxy netdev_queue_get_dma_dev for leased queues
Date: Wed, 14 Jan 2026 00:22:47 +0100
Message-ID: <20260113232257.200036-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113232257.200036-1-daniel@iogearbox.net>
References: <20260113232257.200036-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

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


