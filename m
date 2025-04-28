Return-Path: <bpf+bounces-56839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A0A9F041
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 14:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D982F188D42C
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3A9269AE7;
	Mon, 28 Apr 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i4Y3GbTO"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84946267AF3;
	Mon, 28 Apr 2025 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841937; cv=none; b=FJ4sMdSq2yFEK/YtHwXRnqvqGy7/u1iXt5ZkUNCZBahar6zb7PmdTlJisvBxpVK6OShqxqrExGOWXDZ+6dsohXhh9DYYxX2cqDyGcUUtJRBlBJijfcJyFBbjXp84Z1WDnMBqfLz9iqFd6t7LUY7dJ/YJoDee7vj7q09pOVc2HYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841937; c=relaxed/simple;
	bh=U3vCcy3+Zjk0V0Ir8A5u4CbF8+Bmq1aNjLLAmQ7P9Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZuKYqjqQrYhU2Z9P4mEePrnhnmhbud2No01oVjC4F1bGi7xSts7EC6rAPaJI27HVkEWPnn1unKxH++OCcJGFkBebY8BTxlHchu/2+/MZSAZiSl83Mi6mlFkaK6JPyvs0ddZKmxxi+S1FGLwRgpTb5Q27VeqS7FBGTK5mlBUfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i4Y3GbTO; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC5EVY3393353
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745841914;
	bh=JCpjZY3u/ZFHiA2q9iwsB5i+6p8X7uN+a9ZDPipJd7g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=i4Y3GbTOdJqLfRgMBJnCUV4HvXYKB+vLXAPHLRz9dcbtumc527NhgNBB8it3K+jYj
	 YKaIyVUP2Gn3Q9pc2rGXfD4Dw3XQ3b9RpqIC2WnL+YKZdV9NX541GKdT9v1Lt+UBUz
	 qQXNaM0MvIBPfi3HHGjimuS3Pj9RBaFObguYVjFM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC5E8K038320
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 07:05:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 07:05:13 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 07:05:14 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SC5DF5098251;
	Mon, 28 Apr 2025 07:05:13 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53SC5CXv026354;
	Mon, 28 Apr 2025 07:05:13 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <m-malladi@ti.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 3/4] net: ti: icssg-prueth: Fix race condition for traffic from different network sockets
Date: Mon, 28 Apr 2025 17:34:58 +0530
Message-ID: <20250428120459.244525-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428120459.244525-1-m-malladi@ti.com>
References: <20250428120459.244525-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When dealing with transmitting traffic from different network
sockets to a single Tx channel, freeing the DMA descriptors can lead
to kernel panic with the following error:

[  394.602494] ------------[ cut here ]------------
[  394.607134] kernel BUG at lib/genalloc.c:508!
[  394.611485] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP

logs: https://gist.github.com/MeghanaMalladiTI/ad1d1da3b6e966bc6962c105c0b1d0b6

The above error was reproduced when sending XDP traffic from XSK
socket along with network traffic from BSD socket. This causes
a race condition leading to corrupted DMA descriptors. Fix this
by adding spinlock protection while accessing the DMA descriptors
of a Tx ring.

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 7 +++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 4f45f2b6b67f..a120ff6fec8f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -157,7 +157,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 	tx_chn = &emac->tx_chns[chn];
 
 	while (true) {
+		spin_lock(&tx_chn->lock);
 		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
+		spin_unlock(&tx_chn->lock);
 		if (res == -ENODATA)
 			break;
 
@@ -325,6 +327,7 @@ int prueth_init_tx_chns(struct prueth_emac *emac)
 		snprintf(tx_chn->name, sizeof(tx_chn->name),
 			 "tx%d-%d", slice, i);
 
+		spin_lock_init(&tx_chn->lock);
 		tx_chn->emac = emac;
 		tx_chn->id = i;
 		tx_chn->descs_num = PRUETH_MAX_TX_DESC;
@@ -627,7 +630,9 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
 	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
 
+	spin_lock_bh(&tx_chn->lock);
 	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
+	spin_unlock_bh(&tx_chn->lock);
 	if (ret) {
 		netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
 		netdev_tx_completed_queue(netif_txq, 1, xdpf->len);
@@ -981,7 +986,9 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	/* cppi5_desc_dump(first_desc, 64); */
 
 	skb_tx_timestamp(skb);  /* SW timestamp if SKBTX_IN_PROGRESS not set */
+	spin_lock_bh(&tx_chn->lock);
 	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
+	spin_unlock_bh(&tx_chn->lock);
 	if (ret) {
 		netdev_err(ndev, "tx: push failed: %d\n", ret);
 		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index b6be4aa57a61..4e5354c2866a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -119,6 +119,7 @@ struct prueth_tx_chn {
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_tx_channel *tx_chn;
 	struct prueth_emac *emac;
+	spinlock_t lock; /* protect TX rings in multi-port mode */
 	u32 id;
 	u32 descs_num;
 	unsigned int irq;
-- 
2.43.0


