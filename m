Return-Path: <bpf+bounces-38968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47096D152
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153911C22A6C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D92194C7D;
	Thu,  5 Sep 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l+nOXx3L"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348C194139;
	Thu,  5 Sep 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523638; cv=none; b=AxynbwC4HVspI9BsfHSFrUosnA4eJy+mayxUCO+2okRS6J1veMA8FRhI1+UvFxMVzwcTQ92PrI+bvJlV85bwxP+xEmLFQsV5C67LckugIsDVr5/i2roKkqxwz9s3Najyc9JJ2ZK5byM6RTXIiLaeyybFafG/aN6P0JjxEN8HO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523638; c=relaxed/simple;
	bh=hxJf7Pk6otSAvbcNvXLGkZ++6B9nqGnLXJWk2e87P64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ShdjyNqgYFhIiCaTIq3lxrnIF3ETEOVGt5m0o+4aesj3lwEWMe9pxL7eufIyxkksDFGFgjpc+AeCAC7W/7cKA/KRgO0SDMcMHb8nhhYq9atEFSkC11w79zxETWnxcuRdZwP6IDkAAULAVOIfgv+lehTHOlqwMEkR7k5fl9NtK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l+nOXx3L; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523636; x=1757059636;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hxJf7Pk6otSAvbcNvXLGkZ++6B9nqGnLXJWk2e87P64=;
  b=l+nOXx3L5rqrK0jM072/dBcihbfUgeZBlV6rphYSFAJ+/HWAYLxC2Run
   dCcWyJj7ZXNzXc9O5vav+jaxyn9Y2cPWCFFJnrJ5L4dreTvijr0fboUej
   SIH8h7gn8sWZHmS2pNTKd3l5wgScsHnGOWSirfR42lpvufqWNJaaH1+nh
   Fzh9pNcReQfZ+yWtgLEiSsgIJqnuEQEOpKPRYa1TPkDwMcei94fkoknUL
   rQ5DBCwN3UMBD+RL30R8kArBP3ZuJ3MegYG+yUk/aKjfVXxeBM5a0ILdR
   aZUB3+xOAK+VT3UC3/xRrDbcTq3/GVwVRVNFDtOiSwLGnoiXV9OHOVf9z
   w==;
X-CSE-ConnectionGUID: un5sTwBcTQSB1/6lZ6FYYg==
X-CSE-MsgGUID: df0rpq7BQtuCCAFK+GBFnw==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="32000383"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:02 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:32 +0200
Subject: [PATCH net-next 04/12] net: lan966x: use the FDMA library for
 allocation of rx buffers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
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

Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for rx
buffer allocation and use the new buffers throughout.

In order to replace the old buffers with the new ones, we have to do the
following refactoring:

    - use fdma_alloc_phys() and fdma_dcb_init()

    - replace the variables: rx->dma, rx->dcbs and rx->last_entry
      with the equivalents from the FDMA struct.

    - make use of fdma->db_size for rx buffer size.

    - add lan966x_fdma_rx_dataptr_cb callback for obtaining the dataptr.

    - Initialize FDMA struct values.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 116 ++++++++++-----------
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  15 ---
 2 files changed, 55 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index b64f04ff99a8..99d09c97737e 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -6,13 +6,30 @@
 
 #include "lan966x_main.h"
 
+static int lan966x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				      u64 *dataptr)
+{
+	struct lan966x *lan966x = (struct lan966x *)fdma->priv;
+	struct lan966x_rx *rx = &lan966x->rx;
+	struct page *page;
+
+	page = page_pool_dev_alloc_pages(rx->page_pool);
+	if (unlikely(!page))
+		return -ENOMEM;
+
+	rx->page[dcb][db] = page;
+	*dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
+
+	return 0;
+}
+
 static int lan966x_fdma_channel_active(struct lan966x *lan966x)
 {
 	return lan_rd(lan966x, FDMA_CH_ACTIVE);
 }
 
 static struct page *lan966x_fdma_rx_alloc_page(struct lan966x_rx *rx,
-					       struct lan966x_db *db)
+					       struct fdma_db *db)
 {
 	struct page *page;
 
@@ -50,11 +67,11 @@ static void lan966x_fdma_rx_free_page(struct lan966x_rx *rx)
 }
 
 static void lan966x_fdma_rx_add_dcb(struct lan966x_rx *rx,
-				    struct lan966x_rx_dcb *dcb,
+				    struct fdma_dcb *dcb,
 				    u64 nextptr)
 {
 	struct fdma *fdma = &rx->fdma;
-	struct lan966x_db *db;
+	struct fdma_db *db;
 	int i;
 
 	for (i = 0; i < fdma->n_dbs; ++i) {
@@ -65,8 +82,8 @@ static void lan966x_fdma_rx_add_dcb(struct lan966x_rx *rx,
 	dcb->nextptr = FDMA_DCB_INVALID_DATA;
 	dcb->info = FDMA_DCB_INFO_DATAL(PAGE_SIZE << rx->page_order);
 
-	rx->last_entry->nextptr = nextptr;
-	rx->last_entry = dcb;
+	fdma->last_dcb->nextptr = nextptr;
+	fdma->last_dcb = dcb;
 }
 
 static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
@@ -108,45 +125,17 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
-	struct lan966x_rx_dcb *dcb;
-	struct lan966x_db *db;
-	struct page *page;
-	int i, j;
-	int size;
+	int err;
 
 	if (lan966x_fdma_rx_alloc_page_pool(rx))
 		return PTR_ERR(rx->page_pool);
 
-	/* calculate how many pages are needed to allocate the dcbs */
-	size = sizeof(struct lan966x_rx_dcb) * fdma->n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-
-	rx->dcbs = dma_alloc_coherent(lan966x->dev, size, &rx->dma, GFP_KERNEL);
-	if (!rx->dcbs)
-		return -ENOMEM;
-
-	rx->last_entry = rx->dcbs;
-	fdma->db_index = 0;
-	fdma->dcb_index = 0;
-
-	/* Now for each dcb allocate the dbs */
-	for (i = 0; i < fdma->n_dcbs; ++i) {
-		dcb = &rx->dcbs[i];
-		dcb->info = 0;
-
-		/* For each db allocate a page and map it to the DB dataptr. */
-		for (j = 0; j < fdma->n_dbs; ++j) {
-			db = &dcb->db[j];
-			page = lan966x_fdma_rx_alloc_page(rx, db);
-			if (!page)
-				return -ENOMEM;
-
-			db->status = 0;
-			rx->page[i][j] = page;
-		}
+	err = fdma_alloc_coherent(lan966x->dev, fdma);
+	if (err)
+		return err;
 
-		lan966x_fdma_rx_add_dcb(rx, dcb, rx->dma + sizeof(*dcb) * i);
-	}
+	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_INTR);
 
 	return 0;
 }
@@ -168,7 +157,7 @@ static void lan966x_fdma_rx_free(struct lan966x_rx *rx)
 	/* Now it is possible to do the cleanup of dcb */
 	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
-	dma_free_coherent(lan966x->dev, size, rx->dcbs, rx->dma);
+	dma_free_coherent(lan966x->dev, size, fdma->dcbs, fdma->dma);
 }
 
 static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
@@ -180,9 +169,9 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 	/* When activating a channel, first is required to write the first DCB
 	 * address and then to activate it
 	 */
-	lan_wr(lower_32_bits((u64)rx->dma), lan966x,
+	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
 	       FDMA_DCB_LLP(fdma->channel_id));
-	lan_wr(upper_32_bits((u64)rx->dma), lan966x,
+	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
 	       FDMA_DCB_LLP1(fdma->channel_id));
 
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
@@ -297,7 +286,7 @@ static void lan966x_fdma_tx_free(struct lan966x_tx *tx)
 
 	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
-	dma_free_coherent(lan966x->dev, size, tx->dcbs, tx->dma);
+	dma_free_coherent(lan966x->dev, size, fdma->dcbs, fdma->dma);
 }
 
 static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
@@ -465,10 +454,10 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 static bool lan966x_fdma_rx_more_frames(struct lan966x_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
-	struct lan966x_db *db;
+	struct fdma_db *db;
 
 	/* Check if there is any data */
-	db = &rx->dcbs[fdma->dcb_index].db[fdma->db_index];
+	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
 	if (unlikely(!(db->status & FDMA_DCB_STATUS_DONE)))
 		return false;
 
@@ -480,10 +469,10 @@ static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
 	struct lan966x_port *port;
-	struct lan966x_db *db;
+	struct fdma_db *db;
 	struct page *page;
 
-	db = &rx->dcbs[fdma->dcb_index].db[fdma->db_index];
+	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
 	page = rx->page[fdma->dcb_index][fdma->db_index];
 	if (unlikely(!page))
 		return FDMA_ERROR;
@@ -510,16 +499,16 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
-	struct lan966x_db *db;
 	struct sk_buff *skb;
+	struct fdma_db *db;
 	struct page *page;
 	u64 timestamp;
 
 	/* Get the received frame and unmap it */
-	db = &rx->dcbs[fdma->dcb_index].db[fdma->db_index];
+	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
 	page = rx->page[fdma->dcb_index][fdma->db_index];
 
-	skb = build_skb(page_address(page), PAGE_SIZE << rx->page_order);
+	skb = build_skb(page_address(page), fdma->db_size);
 	if (unlikely(!skb))
 		goto free_page;
 
@@ -562,12 +551,12 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 {
 	struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
 	struct lan966x_rx *rx = &lan966x->rx;
-	struct lan966x_rx_dcb *old_dcb;
 	struct fdma *fdma = &rx->fdma;
 	int dcb_reload, counter = 0;
-	struct lan966x_db *db;
+	struct fdma_dcb *old_dcb;
 	bool redirect = false;
 	struct sk_buff *skb;
+	struct fdma_db *db;
 	struct page *page;
 	u64 src_port;
 	u64 nextptr;
@@ -613,18 +602,18 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 allocate_new:
 	/* Allocate new pages and map them */
 	while (dcb_reload != fdma->dcb_index) {
-		db = &rx->dcbs[dcb_reload].db[fdma->db_index];
+		db = &fdma->dcbs[dcb_reload].db[fdma->db_index];
 		page = lan966x_fdma_rx_alloc_page(rx, db);
 		if (unlikely(!page))
 			break;
 		rx->page[dcb_reload][fdma->db_index] = page;
 
-		old_dcb = &rx->dcbs[dcb_reload];
+		old_dcb = &fdma->dcbs[dcb_reload];
 		dcb_reload++;
 		dcb_reload &= fdma->n_dcbs - 1;
 
-		nextptr = rx->dma + ((unsigned long)old_dcb -
-				     (unsigned long)rx->dcbs);
+		nextptr = fdma->dma + ((unsigned long)old_dcb -
+				     (unsigned long)fdma->dcbs);
 		lan966x_fdma_rx_add_dcb(rx, old_dcb, nextptr);
 		lan966x_fdma_rx_reload(rx);
 	}
@@ -933,8 +922,8 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	int err;
 
 	/* Store these for later to free them */
-	rx_dma = lan966x->rx.dma;
-	rx_dcbs = lan966x->rx.dcbs;
+	rx_dma = lan966x->rx.fdma.dma;
+	rx_dcbs = lan966x->rx.fdma.dcbs;
 	page_pool = lan966x->rx.page_pool;
 
 	napi_synchronize(&lan966x->napi);
@@ -950,7 +939,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
-	size = sizeof(struct lan966x_rx_dcb) * lan966x->rx.fdma.n_dcbs;
+	size = sizeof(struct fdma_dcb) * lan966x->rx.fdma.n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	dma_free_coherent(lan966x->dev, size, rx_dcbs, rx_dma);
 
@@ -962,8 +951,8 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	return err;
 restore:
 	lan966x->rx.page_pool = page_pool;
-	lan966x->rx.dma = rx_dma;
-	lan966x->rx.dcbs = rx_dcbs;
+	lan966x->rx.fdma.dma = rx_dma;
+	lan966x->rx.fdma.dcbs = rx_dcbs;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	return err;
@@ -1056,6 +1045,11 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	lan966x->rx.fdma.channel_id = FDMA_XTR_CHANNEL;
 	lan966x->rx.fdma.n_dcbs = FDMA_DCB_MAX;
 	lan966x->rx.fdma.n_dbs = FDMA_RX_DCB_MAX_DBS;
+	lan966x->rx.fdma.priv = lan966x;
+	lan966x->rx.fdma.size = fdma_get_size(&lan966x->rx.fdma);
+	lan966x->rx.fdma.db_size = PAGE_SIZE << lan966x->rx.page_order;
+	lan966x->rx.fdma.ops.nextptr_cb = &fdma_nextptr_cb;
+	lan966x->rx.fdma.ops.dataptr_cb = &lan966x_fdma_rx_dataptr_cb;
 	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
 	lan966x->tx.lan966x = lan966x;
 	lan966x->tx.fdma.channel_id = FDMA_INJ_CHANNEL;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index fb9d8e00fe69..8edb5ea484ee 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -196,12 +196,6 @@ struct lan966x_db {
 	u64 status;
 };
 
-struct lan966x_rx_dcb {
-	u64 nextptr;
-	u64 info;
-	struct lan966x_db db[FDMA_RX_DCB_MAX_DBS];
-};
-
 struct lan966x_tx_dcb {
 	u64 nextptr;
 	u64 info;
@@ -213,18 +207,9 @@ struct lan966x_rx {
 
 	struct fdma fdma;
 
-	/* Pointer to the array of hardware dcbs. */
-	struct lan966x_rx_dcb *dcbs;
-
-	/* Pointer to the last address in the dcbs. */
-	struct lan966x_rx_dcb *last_entry;
-
 	/* For each DB, there is a page */
 	struct page *page[FDMA_DCB_MAX][FDMA_RX_DCB_MAX_DBS];
 
-	/* Represents the dma address to the dcbs array */
-	dma_addr_t dma;
-
 	/* Represents the page order that is used to allocate the pages for the
 	 * RX buffers. This value is calculated based on max MTU of the devices.
 	 */

-- 
2.34.1


