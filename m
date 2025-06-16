Return-Path: <bpf+bounces-60698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6376ADA84D
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 08:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FD518922B3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAC1E5201;
	Mon, 16 Jun 2025 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M4suDSk5"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D872608;
	Mon, 16 Jun 2025 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055653; cv=none; b=VUDJWdiB8OznvDINYY62oVlYdtIIAOHmWhZVjPBWptsm+J2qnsRoD5L4EfF5qXt2lPN8DYQ9ss/l/JcpzIYScP/OkZTDJh8mcrg3nxMUx1if/dMVolIOj70hwjrvzNq3KN5dsiy0k5J5QVQdbU+lleh54W//+G9VqTnrJmyIanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055653; c=relaxed/simple;
	bh=NcfOR+xbcUtfA85Y9HH6vmCb9ZL4oKoRn9ZbKKZJ2Vw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qB22mwo+XOvsLDGR5FJm7PnL9mp/YW2I1O8DN/tEhuttMw0Z2d3exUNcFyto4Sf4+r4mEUGKqYj2Jtmuvm0MpUnfuDNSHDBwKNVESc7wPJKyuLvanE8clzaIlghTS02RwwzGT9n9NzCru7MHCUWTUC/Vv49QkGCSU/XEqXAD/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M4suDSk5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55G6XOH23658728;
	Mon, 16 Jun 2025 01:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750055604;
	bh=9BkVFrTKgC9rH1nlpqm8W5gPeCeKSxMCFUVpVGS1JwA=;
	h=From:To:CC:Subject:Date;
	b=M4suDSk5URjh3EEu2LT1eSO/deE9Cj1GublOs7d9aZyvMXJy85MJBLG0wY35rt/hQ
	 /ZoBbvPQdMaJKtiHLySTzuAWHz7JqO4WsBEd+C6QBtpADloL8He/08jceiwymicDXa
	 GtwX4YqGD3lmFzdOIIcD0p91qguu4JRY99N2xPl0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55G6XOhw2410372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 16 Jun 2025 01:33:24 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 01:33:23 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 01:33:23 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55G6XNHh3813524;
	Mon, 16 Jun 2025 01:33:23 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 55G6XMuC003283;
	Mon, 16 Jun 2025 01:33:23 -0500
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
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix packet handling for XDP_TX
Date: Mon, 16 Jun 2025 12:03:19 +0530
Message-ID: <20250616063319.3347541-1-m-malladi@ti.com>
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

Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
v2-v1:
- Added the missing Fixes tag

v1: https://lore.kernel.org/all/20250612094523.1615719-1-m-malladi@ti.com/

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


