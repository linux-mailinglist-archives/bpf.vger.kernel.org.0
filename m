Return-Path: <bpf+bounces-68984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E3B8B58F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487041C27D0D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887702D7DF0;
	Fri, 19 Sep 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fA+wri5t"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF92D2383;
	Fri, 19 Sep 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317532; cv=none; b=bMg5cnEpft/O5/QwL9C4ImukjaKb0h+3NiIGuBJ/GTOBIQm5/ZSjmPuHrRgFT9sVZa09isFK0CbgSSZtbFgsGIEAK1w6e9QmRzzxZXrZhyNn2gdqGbYMHN32ueFeYg5gLRAzWu+bk2wTlvWK66NO6tnc0LOSpItADpS7QQKsOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317532; c=relaxed/simple;
	bh=LN0nIbjSUQ5R/oGEIaaVQbHZgKr4ZMPteJbxGMhKgTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZfYncvWKwHNq4vBPE8D3+U/JrFPt8khKonaE3dQMqBNyGyFgA5mthPbf422HJZfHRs7KKD3jbaqKFXe6c1Z7Vg5tL1lcGXh/e62AbsynwvpssEKiFw0mUf/NNtQgDwAObbTRPSjkHUueanPPcIMF3n1Z219FS7IsHXnBJhisxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fA+wri5t; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pqIj0I9se6pPO1BkHrPcvvqb+BMiv20eUsGs8ppHdsc=; b=fA+wri5tjKsTcqW9/oRPrUB4FZ
	9UC5YchpSo8GGWF6NaYAjiwoW9WFtMNl6SPlEd9Ge5Q54P1/y3xn2Hvzx6vbBDjqzLNVz4qTpnekV
	BS04nPCuFZ9NSCrxC835bbewsVD5Zc6EwNi6IMTuPqLnyUdpxfZty/f5NO7GUVDIi3pGavunOkh1l
	FY2j+AbFnNdccs3dw7+f9l4s3JswvA4+qDJ3VedDjLbWLPrEm1GrDYGOTFxIFQ4FdUS+c7m1/awmv
	STKDuFnJPnpkJ0mca0q2WE3t1prr/B0uitLO3ASgydS0gnPP6j+ne7T9/NKP2aYqrglCZQcuSe2Qy
	rnLXNErg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii2-000Nqg-2G;
	Fri, 19 Sep 2025 23:32:02 +0200
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
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 08/20] net: Proxy net_mp_{open,close}_rxq for mapped queues
Date: Fri, 19 Sep 2025 23:31:41 +0200
Message-ID: <20250919213153.103606-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

From: David Wei <dw@davidwei.uk>

When a process in a container wants to setup a memory provider, it will
use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
to try and restart the queue. At this point, proxy the queue restart on
the real rxq in the physical netdev.

For memory providers (io_uring zero-copy rx and devmem), it causes the
real rxq in the physical netdev to be filled from a memory provider that
has DMA mapped memory from a process within a container.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/netdev_rx_queue.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..238d3cd9677e 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -105,13 +105,21 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	if (!netdev_need_ops_lock(dev))
 		return -EOPNOTSUPP;
-
 	if (rxq_idx >= dev->real_num_rx_queues) {
 		NL_SET_ERR_MSG(extack, "rx queue index out of range");
 		return -ERANGE;
 	}
+
 	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
+	rxq = __netif_get_rx_queue_peer(&dev, &rxq_idx);
 
+	/* Check again since dev might have changed */
+	if (!netdev_need_ops_lock(dev))
+		return -EOPNOTSUPP;
+	if (!dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");
+		return -EBUSY;
+	}
 	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
 		return -EINVAL;
@@ -124,8 +132,6 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
 		return -EEXIST;
 	}
-
-	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
 		return -EEXIST;
@@ -136,7 +142,6 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		return -EBUSY;
 	}
 #endif
-
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
 	if (ret) {
@@ -166,7 +171,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
 		return;
 
-	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	rxq = __netif_get_rx_queue_peer(&dev, &ifq_idx);
 
 	/* Callers holding a netdev ref may get here after we already
 	 * went thru shutdown via dev_memory_provider_uninstall().
-- 
2.43.0


