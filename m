Return-Path: <bpf+bounces-56838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750FBA9F042
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 14:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA253B5614
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853E2690C0;
	Mon, 28 Apr 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rPAT4xJq"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A226770A;
	Mon, 28 Apr 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841936; cv=none; b=rKT16GYjZGLpwnf3BjvgT7VDdRsq83SCRj7yyxkFvdU9wJ2yK7gh6cQicr6R4KwdFCyVt/+FZ+z0Z9ro7SYHJBB43RZ5XpLoyx+MOB3o4kZgOs8vmbqtjm3cVU/GSJ3S/B99YMaQTBceBr0Oc5cS0zNKr07KioYU4D7eyHv2H7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841936; c=relaxed/simple;
	bh=/T0BK1dAzfiLg7Xv0sUB5J7Ye6WraCyU1wtHgfAosrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HC8rVxDQlepfmgmHTFLHkjpFCVLZiEOvmw7l/C4hBZMzVu1sIpxa8otffkB32CjXfKEO+A+Tut6o7F6LJzaf3tro9k9UizqHrZt7N5Axh9qIqcrQ5lYEqomrFDlFoDI47chyS2UiTDn6x1vXzH0caCo9d8joc7x0U+lvDkIuGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rPAT4xJq; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC5BI83531559
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745841911;
	bh=uI+faJIxceA72XkODz4Mw86ruNESeEOpXr0xnsfEFzM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rPAT4xJqh+Yb/tPaodYVGiunw2ySTAXQfxfUMXG2GjYNMrmgfFPGYen0b8lL5f5GH
	 gI+OdPgRmnVJvxEZPri39iy6iX1d9HWwGmZbzduZ1F0HrDUqBVzsVi8M6W9PSnSH6P
	 LfJS3iUmMX8WnfXpSWWOCYecAF6cr/5zxgJynFQs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SC5BO1038306
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 07:05:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 07:05:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 07:05:11 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SC5Abt009667;
	Mon, 28 Apr 2025 07:05:10 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53SC59ag026337;
	Mon, 28 Apr 2025 07:05:10 -0500
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
Subject: [PATCH net 2/4] net: ti: icssg-prueth: Report BQL before sending XDP packets
Date: Mon, 28 Apr 2025 17:34:57 +0530
Message-ID: <20250428120459.244525-3-m-malladi@ti.com>
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

When sending out any kind of traffic, it is essential that the driver
keeps reporting BQL of the number of bytes that have been sent so that
BQL can track the amount of data in the queue and prevents it from
overflowing. If BQL is not reported, the driver may continue sending
packets even when the queue is full, leading to packet loss, congestion
and decreased network performance. Currently this is missing in
emac_xmit_xdp_frame() and this patch fixes it.

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index b4be76e13a2f..4f45f2b6b67f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -187,7 +187,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			xdp_return_frame(xdpf);
 			break;
 		default:
-			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
 			prueth_xmit_free(tx_chn, desc_tx);
 			ndev->stats.tx_dropped++;
 			continue;
@@ -567,6 +566,7 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 {
 	struct cppi5_host_desc_t *first_desc;
 	struct net_device *ndev = emac->ndev;
+	struct netdev_queue *netif_txq;
 	struct prueth_tx_chn *tx_chn;
 	dma_addr_t desc_dma, buf_dma;
 	struct prueth_swdata *swdata;
@@ -620,12 +620,17 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 		swdata->data.xdpf = xdpf;
 	}
 
+	/* Report BQL before sending the packet */
+	netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
+	netdev_tx_sent_queue(netif_txq, xdpf->len);
+
 	cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
 	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
 
 	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
 	if (ret) {
 		netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
+		netdev_tx_completed_queue(netif_txq, 1, xdpf->len);
 		goto drop_free_descs;
 	}
 
@@ -979,6 +984,7 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
 	if (ret) {
 		netdev_err(ndev, "tx: push failed: %d\n", ret);
+		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
 		goto drop_free_descs;
 	}
 
-- 
2.43.0


