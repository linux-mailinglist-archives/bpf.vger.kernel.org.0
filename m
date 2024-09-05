Return-Path: <bpf+bounces-38975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF096D16F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B185283B34
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E204199245;
	Thu,  5 Sep 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lkZWGFwR"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319241991B4;
	Thu,  5 Sep 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523670; cv=none; b=kMtZ8j2Q7pJdhKGTHdrBXl/s3LcgXBR3iOb6Z1RkpjlSJCsucGDv7EkNfI3IAvme0lG/VV9SI1i2C5zHEWiqYBBCe4biCQF2lbz/pJWdZqo+JV8zouHa608/WlhhfK2CxiuZlpCXDXsU9KsMD1znpokXbdHgRPHIiCFG6q9ZWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523670; c=relaxed/simple;
	bh=GLt2F6bBkswP8PhABvzG/5XUJcLw1iB4PPTJQ6Ssxz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iWRS/Y/afGSqbhHRnNQDrrIkOQ7tBTLAo6jPNum93ZhgA7SoRukAoGL8pxGOkpDcLHoqtQV6No0CrNibiviQr/70OwK9LBL5KuCYkFMJiUU7gLkmyTADLhCtRrXxcBIsjGr5nXJ7Ag65CkQin041aBOvExDAye7hbzbCzXEvyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lkZWGFwR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523669; x=1757059669;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GLt2F6bBkswP8PhABvzG/5XUJcLw1iB4PPTJQ6Ssxz0=;
  b=lkZWGFwRrya0rh5I6bxBdjmsz2YPEJGsSDdFGy6cS6hKmT+IYYWcfGUC
   cRSQ6K4foki2R4YtXQoKpWCbqTVmQdUYfR06STyJHBvYrYl5bVjwvKdAB
   UEV+Cls1j3R1XzxE0xi/nbezKyFWXH50B5Xh1KnDeSaP89VyGf3Z9812s
   xM8c7YKZ4LCMveO6pQQDMcXYs7IQLM5bnspggdwdzZWiiSmESp5QGbgof
   KBGAcqB1Mh3NEuaMjnuhU/lLzzDliQTgbeO2sglQOFfBhCQ6xSco8CBo9
   /Yb8XA6RH3yI91b6s9SprkWkQUjc7qZcF8zvCT8G/Nc4GucI2TEz90yJy
   Q==;
X-CSE-ConnectionGUID: 7ewQ9CGBRIuJm60AkmofCw==
X-CSE-MsgGUID: EPqxG7qeSDmyWDGl3k00kQ==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34454185"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:09 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:07 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:35 +0200
Subject: [PATCH net-next 07/12] net: lan966x: use the FDMA library for
 allocation of tx buffers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-7-e083f8620165@microchip.com>
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

    - replace the variables: tx->dma, tx->dcbs and tx->curr_entry
      with the equivalents from the FDMA struct.

    - add lan966x_fdma_tx_dataptr_cb callback for obtaining the dataptr.

    - Initialize FDMA struct values.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 75 ++++++++++------------
 .../net/ethernet/microchip/lan966x/lan966x_main.h  | 16 -----
 2 files changed, 34 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 627806a10674..3afc6c4c68a4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -23,6 +23,16 @@ static int lan966x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 	return 0;
 }
 
+static int lan966x_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				      u64 *dataptr)
+{
+	struct lan966x *lan966x = (struct lan966x *)fdma->priv;
+
+	*dataptr = lan966x->tx.dcbs_buf[dcb].dma_addr;
+
+	return 0;
+}
+
 static int lan966x_fdma_channel_active(struct lan966x *lan966x)
 {
 	return lan_rd(lan966x, FDMA_CH_ACTIVE);
@@ -182,46 +192,22 @@ static void lan966x_fdma_rx_reload(struct lan966x_rx *rx)
 		lan966x, FDMA_CH_RELOAD);
 }
 
-static void lan966x_fdma_tx_add_dcb(struct lan966x_tx *tx,
-				    struct lan966x_tx_dcb *dcb)
-{
-	dcb->nextptr = FDMA_DCB_INVALID_DATA;
-	dcb->info = 0;
-}
-
 static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
 	struct fdma *fdma = &tx->fdma;
-	struct lan966x_tx_dcb *dcb;
-	struct lan966x_db *db;
-	int size;
-	int i, j;
+	int err;
 
 	tx->dcbs_buf = kcalloc(fdma->n_dcbs, sizeof(struct lan966x_tx_dcb_buf),
 			       GFP_KERNEL);
 	if (!tx->dcbs_buf)
 		return -ENOMEM;
 
-	/* calculate how many pages are needed to allocate the dcbs */
-	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
-	size = ALIGN(size, PAGE_SIZE);
-	tx->dcbs = dma_alloc_coherent(lan966x->dev, size, &tx->dma, GFP_KERNEL);
-	if (!tx->dcbs)
+	err = fdma_alloc_coherent(lan966x->dev, fdma);
+	if (err)
 		goto out;
 
-	/* Now for each dcb allocate the db */
-	for (i = 0; i < fdma->n_dcbs; ++i) {
-		dcb = &tx->dcbs[i];
-
-		for (j = 0; j < fdma->n_dbs; ++j) {
-			db = &dcb->db[j];
-			db->dataptr = 0;
-			db->status = 0;
-		}
-
-		lan966x_fdma_tx_add_dcb(tx, dcb);
-	}
+	fdma_dcbs_init(fdma, 0, 0);
 
 	return 0;
 
@@ -238,7 +224,7 @@ static void lan966x_fdma_tx_free(struct lan966x_tx *tx)
 
 	kfree(tx->dcbs_buf);
 
-	size = sizeof(struct lan966x_tx_dcb) * fdma->n_dcbs;
+	size = sizeof(struct fdma_dcb) * fdma->n_dcbs;
 	size = ALIGN(size, PAGE_SIZE);
 	dma_free_coherent(lan966x->dev, size, fdma->dcbs, fdma->dma);
 }
@@ -252,9 +238,9 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 	/* When activating a channel, first is required to write the first DCB
 	 * address and then to activate it
 	 */
-	lan_wr(lower_32_bits((u64)tx->dma), lan966x,
+	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
 	       FDMA_DCB_LLP(fdma->channel_id));
-	lan_wr(upper_32_bits((u64)tx->dma), lan966x,
+	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
 	       FDMA_DCB_LLP1(fdma->channel_id));
 
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
@@ -349,22 +335,23 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 	struct lan966x_tx *tx = &lan966x->tx;
 	struct lan966x_rx *rx = &lan966x->rx;
 	struct lan966x_tx_dcb_buf *dcb_buf;
+	struct fdma *fdma = &tx->fdma;
 	struct xdp_frame_bulk bq;
-	struct lan966x_db *db;
 	unsigned long flags;
 	bool clear = false;
+	struct fdma_db *db;
 	int i;
 
 	xdp_frame_bulk_init(&bq);
 
 	spin_lock_irqsave(&lan966x->tx_lock, flags);
-	for (i = 0; i < tx->fdma.n_dcbs; ++i) {
+	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb_buf = &tx->dcbs_buf[i];
 
 		if (!dcb_buf->used)
 			continue;
 
-		db = &tx->dcbs[i].db[0];
+		db = &fdma->dcbs[i].db[0];
 		if (!(db->status & FDMA_DCB_STATUS_DONE))
 			continue;
 
@@ -617,10 +604,10 @@ static void lan966x_fdma_tx_setup_dcb(struct lan966x_tx *tx,
 				      int next_to_use, int len,
 				      dma_addr_t dma_addr)
 {
-	struct lan966x_tx_dcb *next_dcb;
-	struct lan966x_db *next_db;
+	struct fdma_dcb *next_dcb;
+	struct fdma_db *next_db;
 
-	next_dcb = &tx->dcbs[next_to_use];
+	next_dcb = &tx->fdma.dcbs[next_to_use];
 	next_dcb->nextptr = FDMA_DCB_INVALID_DATA;
 
 	next_db = &next_dcb->db[0];
@@ -635,13 +622,14 @@ static void lan966x_fdma_tx_setup_dcb(struct lan966x_tx *tx,
 static void lan966x_fdma_tx_start(struct lan966x_tx *tx, int next_to_use)
 {
 	struct lan966x *lan966x = tx->lan966x;
-	struct lan966x_tx_dcb *dcb;
+	struct fdma *fdma = &tx->fdma;
+	struct fdma_dcb *dcb;
 
 	if (likely(lan966x->tx.activated)) {
 		/* Connect current dcb to the next db */
-		dcb = &tx->dcbs[tx->last_in_use];
-		dcb->nextptr = tx->dma + (next_to_use *
-					  sizeof(struct lan966x_tx_dcb));
+		dcb = &fdma->dcbs[tx->last_in_use];
+		dcb->nextptr = fdma->dma + (next_to_use *
+					  sizeof(struct fdma_dcb));
 
 		lan966x_fdma_tx_reload(tx);
 	} else {
@@ -999,6 +987,11 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	lan966x->tx.fdma.channel_id = FDMA_INJ_CHANNEL;
 	lan966x->tx.fdma.n_dcbs = FDMA_DCB_MAX;
 	lan966x->tx.fdma.n_dbs = FDMA_TX_DCB_MAX_DBS;
+	lan966x->tx.fdma.priv = lan966x;
+	lan966x->tx.fdma.size = fdma_get_size(&lan966x->tx.fdma);
+	lan966x->tx.fdma.db_size = PAGE_SIZE << lan966x->rx.page_order;
+	lan966x->tx.fdma.ops.nextptr_cb = &fdma_nextptr_cb;
+	lan966x->tx.fdma.ops.dataptr_cb = &lan966x_fdma_tx_dataptr_cb;
 	lan966x->tx.last_in_use = -1;
 
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 8edb5ea484ee..99efc596c9e6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -191,17 +191,6 @@ enum vcap_is1_port_sel_rt {
 
 struct lan966x_port;
 
-struct lan966x_db {
-	u64 dataptr;
-	u64 status;
-};
-
-struct lan966x_tx_dcb {
-	u64 nextptr;
-	u64 info;
-	struct lan966x_db db[FDMA_TX_DCB_MAX_DBS];
-};
-
 struct lan966x_rx {
 	struct lan966x *lan966x;
 
@@ -243,13 +232,8 @@ struct lan966x_tx {
 
 	struct fdma fdma;
 
-	/* Pointer to the dcb list */
-	struct lan966x_tx_dcb *dcbs;
 	u16 last_in_use;
 
-	/* Represents the DMA address to the first entry of the dcb entries. */
-	dma_addr_t dma;
-
 	/* Array of dcbs that are given to the HW */
 	struct lan966x_tx_dcb_buf *dcbs_buf;
 

-- 
2.34.1


