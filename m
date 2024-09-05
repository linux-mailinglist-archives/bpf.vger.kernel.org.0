Return-Path: <bpf+bounces-38967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847FF96D150
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3352E284422
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE35194AD6;
	Thu,  5 Sep 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2YdYY9vk"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680017BEC3;
	Thu,  5 Sep 2024 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523637; cv=none; b=ucyo5nl2fjiV5k85wNl4EmxJK5FHe4uCFzm2WLu1HEHiIGDTnjgORdhRwtPxDEZv3WKizO2OfftJ52VUefdTVvO4QOUC8MJNjWbiwIHP7dQ47PPzjSz7DYfU+Wf0l2zuNF8OFmA4q/C9JktK7j51wgLE3V0NaynJSVV9lpTGrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523637; c=relaxed/simple;
	bh=CIQC+Ngpksj3MzY0MT6B9MJaRA8pVyw9VqjGyo8+pvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=exhUEp856HjqD4fArho6bPWA5Xf+3Yt69RcIoqPhKz3drfdgIZlnFDBxTT3OhbxALmiClviW5psNbkJJg1+2QhdibJnVgCfK1F6Tzab+8RYyZldH8Bwyi6GFZJsFvdXPgnRHHAT9IHtt7aWM4HR1gjwqRBtW8mwCaWHzXcQT5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2YdYY9vk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523634; x=1757059634;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CIQC+Ngpksj3MzY0MT6B9MJaRA8pVyw9VqjGyo8+pvw=;
  b=2YdYY9vkBa5OqU+kPB2eeXcOoY9yupC82YchzWE1s88irWWr8ZvqZNC5
   azv4txY3sLl8saiDMz0uBThDBVXxc3YMkdaO36Cf79wxDHDTlh9NiLNIc
   FmwgXd1ZReu2WLLJd4eaXC4/XFz8W+XlzoET+aiLtCE8vHz6jCcoT+m9X
   F4Pj/J5RCKUKLHHcwNlR9zZx0YKYuQbxsqZtCYR1YPjoNyYp42WnSgs/D
   VbUwhJQx6mZ02dBlT+pg8VxTZZ4/9bb95BIeOS78I8YVRRfKJjcUEMHl4
   NR/IC41ux8VBk8A9TZDyMFRyPSbt6dnIQbi3vx9s0jwf6zXUIE5nSDD6h
   w==;
X-CSE-ConnectionGUID: un5sTwBcTQSB1/6lZ6FYYg==
X-CSE-MsgGUID: BN0vGI4ZQ6eO+6H3cx6oFA==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="32000382"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:06:59 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:06:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:31 +0200
Subject: [PATCH net-next 03/12] net: lan966x: replace a few variables with
 new equivalent ones
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-3-e083f8620165@microchip.com>
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
In-Reply-To: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14-dev

Replace the old rx and tx variables: channel_id, FDMA_DCB_MAX,
FDMA_RX_DCB_MAX_DBS, FDMA_TX_DCB_MAX_DBS, dcb_index and db_index with
the equivalents from the FDMA rx and tx structs. These variables are not
entangled in any buffer allocation and can therefore be replaced in
advance.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 131 ++++++++++++---------
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  19 +--
 2 files changed, 81 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 3960534ac2ad..b64f04ff99a8 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -27,10 +27,11 @@ static struct page *lan966x_fdma_rx_alloc_page(struct lan966x_rx *rx,
 
 static void lan966x_fdma_rx_free_pages(struct lan966x_rx *rx)
 {
+	struct fdma *fdma = &rx->fdma;
 	int i, j;
 
-	for (i = 0; i < FDMA_DCB_MAX; ++i) {
-		for (j = 0; j < FDMA_RX_DCB_MAX_DBS; ++j)
+	for (i = 0; i < fdma->n_dcbs; ++i) {
+		for (j = 0; j < fdma->n_dbs; ++j)
 			page_pool_put_full_page(rx->page_pool,
 						rx->page[i][j], false);
 	}
@@ -38,9 +39,10 @@ static void lan966x_fdma_rx_free_pages(struct lan966x_rx *rx)
 
 static void lan966x_fdma_rx_free_page(struct lan966x_rx *rx)
 {
+	struct fdma *fdma = &rx->fdma;
 	struct page *page;
 
-	page = rx->page[rx->dcb_index][rx->db_index];
+	page = rx->page[fdma->dcb_index][fdma->db_index];
 	if (unlikely(!page))
 		return;
 
@@ -51,10 +53,11 @@ static void lan966x_fdma_rx_add_dcb(struct lan966x_rx *rx,
 				    struct lan966x_rx_dcb *dcb,
 				    u64 nextptr)
 {
+	struct fdma *fdma = &rx->fdma;
 	struct lan966x_db *db;
 	int i;
 
-	for (i = 0; i < FDMA_RX_DCB_MAX_DBS; ++i) {
+	for (i = 0; i < fdma->n_dbs; ++i) {
 		db = &dcb->db[i];
 		db->status = FDMA_DCB_STATUS_INTR;
 	}
@@ -72,7 +75,7 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 	struct page_pool_params pp_params = {
 		.order = rx->page_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.pool_size = FDMA_DCB_MAX,
+		.pool_size = rx->fdma.n_dcbs,
 		.nid = NUMA_NO_NODE,
 		.dev = lan966x->dev,
 		.dma_dir = DMA_FROM_DEVICE,
@@ -104,6 +107,7 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
 	struct lan966x_rx_dcb *dcb;
 	struct lan966x_db *db;
 	struct page *page;
@@ -114,7 +118,7 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 		return PTR_ERR(rx->page_pool);
 
 	/* calculate how many pages are needed to allocate the dcbs */
-	size = sizeof(struct lan966x_rx_dcb) * FDMA_DCB_MAX;
+	size = sizeof(struct lan966x_rx_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 
 	rx->dcbs = dma_alloc_coherent(lan966x->dev, size, &rx->dma, GFP_KERNEL);
@@ -122,16 +126,16 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 		return -ENOMEM;
 
 	rx->last_entry = rx->dcbs;
-	rx->db_index = 0;
-	rx->dcb_index = 0;
+	fdma->db_index = 0;
+	fdma->dcb_index = 0;
 
 	/* Now for each dcb allocate the dbs */
-	for (i = 0; i < FDMA_DCB_MAX; ++i) {
+	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb = &rx->dcbs[i];
 		dcb->info = 0;
 
 		/* For each db allocate a page and map it to the DB dataptr. */
-		for (j = 0; j < FDMA_RX_DCB_MAX_DBS; ++j) {
+		for (j = 0; j < fdma->n_dbs; ++j) {
 			db = &dcb->db[j];
 			page = lan966x_fdma_rx_alloc_page(rx, db);
 			if (!page)
@@ -149,17 +153,20 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 
 static void lan966x_fdma_rx_advance_dcb(struct lan966x_rx *rx)
 {
-	rx->dcb_index++;
-	rx->dcb_index &= FDMA_DCB_MAX - 1;
+	struct fdma *fdma = &rx->fdma;
+
+	fdma->dcb_index++;
+	fdma->dcb_index &= fdma->n_dcbs - 1;
 }
 
 static void lan966x_fdma_rx_free(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
 	u32 size;
 
 	/* Now it is possible to do the cleanup of dcb */
-	size = sizeof(struct lan966x_tx_dcb) * FDMA_DCB_MAX;
+	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	dma_free_coherent(lan966x->dev, size, rx->dcbs, rx->dma);
 }
@@ -167,21 +174,22 @@ static void lan966x_fdma_rx_free(struct lan966x_rx *rx)
 static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
 	u32 mask;
 
 	/* When activating a channel, first is required to write the first DCB
 	 * address and then to activate it
 	 */
 	lan_wr(lower_32_bits((u64)rx->dma), lan966x,
-	       FDMA_DCB_LLP(rx->channel_id));
+	       FDMA_DCB_LLP(fdma->channel_id));
 	lan_wr(upper_32_bits((u64)rx->dma), lan966x,
-	       FDMA_DCB_LLP1(rx->channel_id));
+	       FDMA_DCB_LLP1(fdma->channel_id));
 
-	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(FDMA_RX_DCB_MAX_DBS) |
+	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
 	       FDMA_CH_CFG_CH_MEM_SET(1),
-	       lan966x, FDMA_CH_CFG(rx->channel_id));
+	       lan966x, FDMA_CH_CFG(fdma->channel_id));
 
 	/* Start fdma */
 	lan_rmw(FDMA_PORT_CTRL_XTR_STOP_SET(0),
@@ -191,13 +199,13 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 	/* Enable interrupts */
 	mask = lan_rd(lan966x, FDMA_INTR_DB_ENA);
 	mask = FDMA_INTR_DB_ENA_INTR_DB_ENA_GET(mask);
-	mask |= BIT(rx->channel_id);
+	mask |= BIT(fdma->channel_id);
 	lan_rmw(FDMA_INTR_DB_ENA_INTR_DB_ENA_SET(mask),
 		FDMA_INTR_DB_ENA_INTR_DB_ENA,
 		lan966x, FDMA_INTR_DB_ENA);
 
 	/* Activate the channel */
-	lan_rmw(FDMA_CH_ACTIVATE_CH_ACTIVATE_SET(BIT(rx->channel_id)),
+	lan_rmw(FDMA_CH_ACTIVATE_CH_ACTIVATE_SET(BIT(fdma->channel_id)),
 		FDMA_CH_ACTIVATE_CH_ACTIVATE,
 		lan966x, FDMA_CH_ACTIVATE);
 }
@@ -205,18 +213,19 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 static void lan966x_fdma_rx_disable(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
 	u32 val;
 
 	/* Disable the channel */
-	lan_rmw(FDMA_CH_DISABLE_CH_DISABLE_SET(BIT(rx->channel_id)),
+	lan_rmw(FDMA_CH_DISABLE_CH_DISABLE_SET(BIT(fdma->channel_id)),
 		FDMA_CH_DISABLE_CH_DISABLE,
 		lan966x, FDMA_CH_DISABLE);
 
 	readx_poll_timeout_atomic(lan966x_fdma_channel_active, lan966x,
-				  val, !(val & BIT(rx->channel_id)),
+				  val, !(val & BIT(fdma->channel_id)),
 				  READL_SLEEP_US, READL_TIMEOUT_US);
 
-	lan_rmw(FDMA_CH_DB_DISCARD_DB_DISCARD_SET(BIT(rx->channel_id)),
+	lan_rmw(FDMA_CH_DB_DISCARD_DB_DISCARD_SET(BIT(fdma->channel_id)),
 		FDMA_CH_DB_DISCARD_DB_DISCARD,
 		lan966x, FDMA_CH_DB_DISCARD);
 }
@@ -225,7 +234,7 @@ static void lan966x_fdma_rx_reload(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
 
-	lan_rmw(FDMA_CH_RELOAD_CH_RELOAD_SET(BIT(rx->channel_id)),
+	lan_rmw(FDMA_CH_RELOAD_CH_RELOAD_SET(BIT(rx->fdma.channel_id)),
 		FDMA_CH_RELOAD_CH_RELOAD,
 		lan966x, FDMA_CH_RELOAD);
 }
@@ -240,28 +249,29 @@ static void lan966x_fdma_tx_add_dcb(struct lan966x_tx *tx,
 static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
+	struct fdma *fdma = &tx->fdma;
 	struct lan966x_tx_dcb *dcb;
 	struct lan966x_db *db;
 	int size;
 	int i, j;
 
-	tx->dcbs_buf = kcalloc(FDMA_DCB_MAX, sizeof(struct lan966x_tx_dcb_buf),
+	tx->dcbs_buf = kcalloc(fdma->n_dcbs, sizeof(struct lan966x_tx_dcb_buf),
 			       GFP_KERNEL);
 	if (!tx->dcbs_buf)
 		return -ENOMEM;
 
 	/* calculate how many pages are needed to allocate the dcbs */
-	size = sizeof(struct lan966x_tx_dcb) * FDMA_DCB_MAX;
+	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	tx->dcbs = dma_alloc_coherent(lan966x->dev, size, &tx->dma, GFP_KERNEL);
 	if (!tx->dcbs)
 		goto out;
 
 	/* Now for each dcb allocate the db */
-	for (i = 0; i < FDMA_DCB_MAX; ++i) {
+	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb = &tx->dcbs[i];
 
-		for (j = 0; j < FDMA_TX_DCB_MAX_DBS; ++j) {
+		for (j = 0; j < fdma->n_dbs; ++j) {
 			db = &dcb->db[j];
 			db->dataptr = 0;
 			db->status = 0;
@@ -280,11 +290,12 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 static void lan966x_fdma_tx_free(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
+	struct fdma *fdma = &tx->fdma;
 	int size;
 
 	kfree(tx->dcbs_buf);
 
-	size = sizeof(struct lan966x_tx_dcb) * FDMA_DCB_MAX;
+	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	dma_free_coherent(lan966x->dev, size, tx->dcbs, tx->dma);
 }
@@ -292,21 +303,22 @@ static void lan966x_fdma_tx_free(struct lan966x_tx *tx)
 static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
+	struct fdma *fdma = &tx->fdma;
 	u32 mask;
 
 	/* When activating a channel, first is required to write the first DCB
 	 * address and then to activate it
 	 */
 	lan_wr(lower_32_bits((u64)tx->dma), lan966x,
-	       FDMA_DCB_LLP(tx->channel_id));
+	       FDMA_DCB_LLP(fdma->channel_id));
 	lan_wr(upper_32_bits((u64)tx->dma), lan966x,
-	       FDMA_DCB_LLP1(tx->channel_id));
+	       FDMA_DCB_LLP1(fdma->channel_id));
 
-	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(FDMA_TX_DCB_MAX_DBS) |
+	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
 	       FDMA_CH_CFG_CH_MEM_SET(1),
-	       lan966x, FDMA_CH_CFG(tx->channel_id));
+	       lan966x, FDMA_CH_CFG(fdma->channel_id));
 
 	/* Start fdma */
 	lan_rmw(FDMA_PORT_CTRL_INJ_STOP_SET(0),
@@ -316,13 +328,13 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 	/* Enable interrupts */
 	mask = lan_rd(lan966x, FDMA_INTR_DB_ENA);
 	mask = FDMA_INTR_DB_ENA_INTR_DB_ENA_GET(mask);
-	mask |= BIT(tx->channel_id);
+	mask |= BIT(fdma->channel_id);
 	lan_rmw(FDMA_INTR_DB_ENA_INTR_DB_ENA_SET(mask),
 		FDMA_INTR_DB_ENA_INTR_DB_ENA,
 		lan966x, FDMA_INTR_DB_ENA);
 
 	/* Activate the channel */
-	lan_rmw(FDMA_CH_ACTIVATE_CH_ACTIVATE_SET(BIT(tx->channel_id)),
+	lan_rmw(FDMA_CH_ACTIVATE_CH_ACTIVATE_SET(BIT(fdma->channel_id)),
 		FDMA_CH_ACTIVATE_CH_ACTIVATE,
 		lan966x, FDMA_CH_ACTIVATE);
 }
@@ -330,18 +342,19 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 static void lan966x_fdma_tx_disable(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
+	struct fdma *fdma = &tx->fdma;
 	u32 val;
 
 	/* Disable the channel */
-	lan_rmw(FDMA_CH_DISABLE_CH_DISABLE_SET(BIT(tx->channel_id)),
+	lan_rmw(FDMA_CH_DISABLE_CH_DISABLE_SET(BIT(fdma->channel_id)),
 		FDMA_CH_DISABLE_CH_DISABLE,
 		lan966x, FDMA_CH_DISABLE);
 
 	readx_poll_timeout_atomic(lan966x_fdma_channel_active, lan966x,
-				  val, !(val & BIT(tx->channel_id)),
+				  val, !(val & BIT(fdma->channel_id)),
 				  READL_SLEEP_US, READL_TIMEOUT_US);
 
-	lan_rmw(FDMA_CH_DB_DISCARD_DB_DISCARD_SET(BIT(tx->channel_id)),
+	lan_rmw(FDMA_CH_DB_DISCARD_DB_DISCARD_SET(BIT(fdma->channel_id)),
 		FDMA_CH_DB_DISCARD_DB_DISCARD,
 		lan966x, FDMA_CH_DB_DISCARD);
 
@@ -354,7 +367,7 @@ static void lan966x_fdma_tx_reload(struct lan966x_tx *tx)
 	struct lan966x *lan966x = tx->lan966x;
 
 	/* Write the registers to reload the channel */
-	lan_rmw(FDMA_CH_RELOAD_CH_RELOAD_SET(BIT(tx->channel_id)),
+	lan_rmw(FDMA_CH_RELOAD_CH_RELOAD_SET(BIT(tx->fdma.channel_id)),
 		FDMA_CH_RELOAD_CH_RELOAD,
 		lan966x, FDMA_CH_RELOAD);
 }
@@ -402,7 +415,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 	xdp_frame_bulk_init(&bq);
 
 	spin_lock_irqsave(&lan966x->tx_lock, flags);
-	for (i = 0; i < FDMA_DCB_MAX; ++i) {
+	for (i = 0; i < tx->fdma.n_dcbs; ++i) {
 		dcb_buf = &tx->dcbs_buf[i];
 
 		if (!dcb_buf->used)
@@ -451,10 +464,11 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 
 static bool lan966x_fdma_rx_more_frames(struct lan966x_rx *rx)
 {
+	struct fdma *fdma = &rx->fdma;
 	struct lan966x_db *db;
 
 	/* Check if there is any data */
-	db = &rx->dcbs[rx->dcb_index].db[rx->db_index];
+	db = &rx->dcbs[fdma->dcb_index].db[fdma->db_index];
 	if (unlikely(!(db->status & FDMA_DCB_STATUS_DONE)))
 		return false;
 
@@ -464,12 +478,13 @@ static bool lan966x_fdma_rx_more_frames(struct lan966x_rx *rx)
 static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 {
 	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
 	struct lan966x_port *port;
 	struct lan966x_db *db;
 	struct page *page;
 
-	db = &rx->dcbs[rx->dcb_index].db[rx->db_index];
-	page = rx->page[rx->dcb_index][rx->db_index];
+	db = &rx->dcbs[fdma->dcb_index].db[fdma->db_index];
+	page = rx->page[fdma->dcb_index][fdma->db_index];
 	if (unlikely(!page))
 		return FDMA_ERROR;
 
@@ -494,14 +509,15 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 						 u64 src_port)
 {
 	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
 	struct lan966x_db *db;
 	struct sk_buff *skb;
 	struct page *page;
 	u64 timestamp;
 
 	/* Get the received frame and unmap it */
-	db = &rx->dcbs[rx->dcb_index].db[rx->db_index];
-	page = rx->page[rx->dcb_index][rx->db_index];
+	db = &rx->dcbs[fdma->dcb_index].db[fdma->db_index];
+	page = rx->page[fdma->dcb_index][fdma->db_index];
 
 	skb = build_skb(page_address(page), PAGE_SIZE << rx->page_order);
 	if (unlikely(!skb))
@@ -546,16 +562,18 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 {
 	struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
 	struct lan966x_rx *rx = &lan966x->rx;
-	int dcb_reload = rx->dcb_index;
 	struct lan966x_rx_dcb *old_dcb;
+	struct fdma *fdma = &rx->fdma;
+	int dcb_reload, counter = 0;
 	struct lan966x_db *db;
 	bool redirect = false;
 	struct sk_buff *skb;
 	struct page *page;
-	int counter = 0;
 	u64 src_port;
 	u64 nextptr;
 
+	dcb_reload = fdma->dcb_index;
+
 	lan966x_fdma_tx_clear_buf(lan966x, weight);
 
 	/* Get all received skb */
@@ -594,16 +612,16 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 
 allocate_new:
 	/* Allocate new pages and map them */
-	while (dcb_reload != rx->dcb_index) {
-		db = &rx->dcbs[dcb_reload].db[rx->db_index];
+	while (dcb_reload != fdma->dcb_index) {
+		db = &rx->dcbs[dcb_reload].db[fdma->db_index];
 		page = lan966x_fdma_rx_alloc_page(rx, db);
 		if (unlikely(!page))
 			break;
-		rx->page[dcb_reload][rx->db_index] = page;
+		rx->page[dcb_reload][fdma->db_index] = page;
 
 		old_dcb = &rx->dcbs[dcb_reload];
 		dcb_reload++;
-		dcb_reload &= FDMA_DCB_MAX - 1;
+		dcb_reload &= fdma->n_dcbs - 1;
 
 		nextptr = rx->dma + ((unsigned long)old_dcb -
 				     (unsigned long)rx->dcbs);
@@ -650,9 +668,10 @@ irqreturn_t lan966x_fdma_irq_handler(int irq, void *args)
 static int lan966x_fdma_get_next_dcb(struct lan966x_tx *tx)
 {
 	struct lan966x_tx_dcb_buf *dcb_buf;
+	struct fdma *fdma = &tx->fdma;
 	int i;
 
-	for (i = 0; i < FDMA_DCB_MAX; ++i) {
+	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb_buf = &tx->dcbs_buf[i];
 		if (!dcb_buf->used && i != tx->last_in_use)
 			return i;
@@ -931,7 +950,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
-	size = sizeof(struct lan966x_rx_dcb) * FDMA_DCB_MAX;
+	size = sizeof(struct lan966x_rx_dcb) * lan966x->rx.fdma.n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	dma_free_coherent(lan966x->dev, size, rx_dcbs, rx_dma);
 
@@ -1034,10 +1053,14 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 		return 0;
 
 	lan966x->rx.lan966x = lan966x;
-	lan966x->rx.channel_id = FDMA_XTR_CHANNEL;
+	lan966x->rx.fdma.channel_id = FDMA_XTR_CHANNEL;
+	lan966x->rx.fdma.n_dcbs = FDMA_DCB_MAX;
+	lan966x->rx.fdma.n_dbs = FDMA_RX_DCB_MAX_DBS;
 	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
 	lan966x->tx.lan966x = lan966x;
-	lan966x->tx.channel_id = FDMA_INJ_CHANNEL;
+	lan966x->tx.fdma.channel_id = FDMA_INJ_CHANNEL;
+	lan966x->tx.fdma.n_dcbs = FDMA_DCB_MAX;
+	lan966x->tx.fdma.n_dbs = FDMA_TX_DCB_MAX_DBS;
 	lan966x->tx.last_in_use = -1;
 
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 4d2aa775fbfd..fb9d8e00fe69 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -211,6 +211,8 @@ struct lan966x_tx_dcb {
 struct lan966x_rx {
 	struct lan966x *lan966x;
 
+	struct fdma fdma;
+
 	/* Pointer to the array of hardware dcbs. */
 	struct lan966x_rx_dcb *dcbs;
 
@@ -220,17 +222,6 @@ struct lan966x_rx {
 	/* For each DB, there is a page */
 	struct page *page[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
 
-	/* Represents the db_index, it can have a value between 0 and
-	 * FDMA_RX_DCB_MAX_DBS, once it reaches the value of FDMA_RX_DCB_MAX_DBS
-	 * it means that the DCB can be reused.
-	 */
-	int db_index;
-
-	/* Represents the index in the dcbs. It has a value between 0 and
-	 * FDMA_DCB_MAX
-	 */
-	int dcb_index;
-
 	/* Represents the dma address to the dcbs array */
 	dma_addr_t dma;
 
@@ -244,8 +235,6 @@ struct lan966x_rx {
 	 */
 	u32 max_mtu;
 
-	u8 channel_id;
-
 	struct page_pool *page_pool;
 };
 
@@ -267,6 +256,8 @@ struct lan966x_tx_dcb_buf {
 struct lan966x_tx {
 	struct lan966x *lan966x;
 
+	struct fdma fdma;
+
 	/* Pointer to the dcb list */
 	struct lan966x_tx_dcb *dcbs;
 	u16 last_in_use;
@@ -277,8 +268,6 @@ struct lan966x_tx {
 	/* Array of dcbs that are given to the HW */
 	struct lan966x_tx_dcb_buf *dcbs_buf;
 
-	u8 channel_id;
-
 	bool activated;
 };
 

-- 
2.34.1


