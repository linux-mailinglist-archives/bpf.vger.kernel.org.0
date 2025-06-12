Return-Path: <bpf+bounces-60453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4BEAD6C84
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670113AFCC0
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EC222B5B8;
	Thu, 12 Jun 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SBKpd59Z"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCC1F92E;
	Thu, 12 Jun 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721573; cv=none; b=qtVsP2w2h/ZdvcORkWO9WTUcYIoQUSUUaoyMAj83KwP3CyvWZF2fPp37Xh11iQ0hDGK6wWXp/rosB3TSYzVpBQUBpUwu6gIGiThBYQHU/qm9tCb1EW42PE0kRkI5FdUydbkf+VO6ITi/V4yZFZcSZSpsHAtmnNDryc03PJw5e6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721573; c=relaxed/simple;
	bh=Dh0E6ChvgZtODSm2CyrhYN1/rcw1qbw6D7lUcqZQoPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B9Ueg86MPA9q2FzX5t47mmYMDu8/Ln7aNYXnWy9qXqZRVljltXecJVGNUX8gJiaC0lNYNAhDxC6Eqd47bdqhIQd6ov8o+n9HqPNvlfFGsi384A1oFdaplb3OVwfzLHp/leLYYmrjHiT1qo1yWQ7IjJJwll14rqsixMp+nIgxarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SBKpd59Z; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C9jRZX1635161;
	Thu, 12 Jun 2025 04:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749721527;
	bh=1wGCQc0mcjPV9WgUkNTeUr3SyYHwhLuPypKWT3sxnDM=;
	h=From:To:CC:Subject:Date;
	b=SBKpd59ZfkK9r8jsdEr/Qis3VM6MSHyCwkYAyVVxxkHKaiYT263Q39aEo0HB8jbxL
	 Xyp4KaI/iG+HKlysjnGrKMt0Znr+MLgkMUrJGVSe7CPLnGnD6Yo6OK+svo8aTbvtz8
	 diFfqWDvjpAdBk1zeHlxnzBedKBTMiNlD56ACPrQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C9jRrE1841138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 04:45:27 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 04:45:27 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 04:45:27 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C9jRVC490857;
	Thu, 12 Jun 2025 04:45:27 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 55C9jP8J021791;
	Thu, 12 Jun 2025 04:45:26 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <m-malladi@ti.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix packet handling for XDP_TX
Date: Thu, 12 Jun 2025 15:15:23 +0530
Message-ID: <20250612094523.1615719-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

While transmitting XDP frames for XDP_TX, page_pool is
used to get the DMA buffers (already mapped to the pages)
and need to be freed/reycled once the transmission is complete.
This need not be explicitly done by the driver as this is handled
more gracefully by the xdp driver while returning the xdp frame.
__xdp_return() frees the XDP memory based on its memory type,
under which page_pool memory is also handled. This change fixes
the transmit queue timeout while running XDP_TX.

logs:
[  309.069682] icssg-prueth icssg1-eth eth2: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 45860 ms
[  313.933780] icssg-prueth icssg1-eth eth2: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 50724 ms
[  319.053656] icssg-prueth icssg1-eth eth2: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 55844 ms
...

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 5b8fdb882172..12f25cec6255 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -98,20 +98,11 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 {
 	struct cppi5_host_desc_t *first_desc, *next_desc;
 	dma_addr_t buf_dma, next_desc_dma;
-	struct prueth_swdata *swdata;
-	struct page *page;
 	u32 buf_dma_len;
 
 	first_desc = desc;
 	next_desc = first_desc;
 
-	swdata = cppi5_hdesc_get_swdata(desc);
-	if (swdata->type == PRUETH_SWDATA_PAGE) {
-		page = swdata->data.page;
-		page_pool_recycle_direct(page->pp, swdata->data.page);
-		goto free_desc;
-	}
-
 	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
 	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
 
@@ -135,7 +126,6 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
 	}
 
-free_desc:
 	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
 }
 EXPORT_SYMBOL_GPL(prueth_xmit_free);
@@ -612,13 +602,8 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	if (page) {
-		swdata->type = PRUETH_SWDATA_PAGE;
-		swdata->data.page = page;
-	} else {
-		swdata->type = PRUETH_SWDATA_XDPF;
-		swdata->data.xdpf = xdpf;
-	}
+	swdata->type = PRUETH_SWDATA_XDPF;
+	swdata->data.xdpf = xdpf;
 
 	/* Report BQL before sending the packet */
 	netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);

base-commit: 5d6d67c4cb10a4b4d3ae35758d5eeed6239afdc8
-- 
2.43.0


