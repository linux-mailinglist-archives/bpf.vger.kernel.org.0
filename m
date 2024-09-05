Return-Path: <bpf+bounces-38969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9E096D155
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB2A284025
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA5A1953B9;
	Thu,  5 Sep 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UxobY6O+"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AD194A48;
	Thu,  5 Sep 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523638; cv=none; b=nztbZL2dzb9Hs+h97HyQ7uUlMGAZm9tudQz9faAlHRcdHOHJncyRwD4zzXj5qULuqrGdg0kzi+rmx1SikSpavDtxYZo9ncJDzIj2RTPWFx4NVHqtrenw0u+pAVEDwYYx58mpBnsB5JITH4mVxSbGOYteP/8Cs+77yzn/aP7E2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523638; c=relaxed/simple;
	bh=WdqZWltClNsHkHBP3ox2/SslUl+vy/i1I7VtXRdpTJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CG8xa7QDsAJaezkBdjVRJppfF2O9s4mqYkjIztkZ6d3v1XbHAjed2nwDIJrNvZkWsNzwn9zJ4sDBxFN/stZXDq93i1srDyb9yle8BFGs6E4F/4ZkV3ubqg3RPy9C24px3b/SjmptGAnItI9k5kYKAQaqdcV75Hc7yXh9sUQZisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UxobY6O+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523636; x=1757059636;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WdqZWltClNsHkHBP3ox2/SslUl+vy/i1I7VtXRdpTJI=;
  b=UxobY6O+SLWgXwZk83ZvP5+JDHFL++gAANEGvnAaSSMRjv8nY6M8VYIQ
   0E3CeJyPBANVvyBrMZEkp1eInJIViqCx0nIKJyDJk5cJ++mH8NOtsETbu
   24ZMv6lLS3WuDwv3ygstlex2qIh5rZKljDM/6xH+g8/0GP3FdaqusfExh
   18K6a9FJg+aczI10DVSDEgOO0DlENhqE011DD4dgDAxHl5JXmvNTktEWa
   T4082pt3WxAX2yFduRqNLZkD7h4ryAG2+JL9UUcwtydd85+m/Q3DfQ7Wy
   Jzeya6+x2SLz0gHV+uHCsddKGmHXJIg4Jn6u/mlQ31QR7OFrrBV+RDynN
   A==;
X-CSE-ConnectionGUID: un5sTwBcTQSB1/6lZ6FYYg==
X-CSE-MsgGUID: kXFlxhY2TVybLHqxUJYj4w==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="32000384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:04 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:02 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:33 +0200
Subject: [PATCH net-next 05/12] net: lan966x: use FDMA library for adding
 DCB's in the rx path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-5-e083f8620165@microchip.com>
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

Use the fdma_dcb_add() function to add DCB's in the rx path. This gets
rid of the open-coding of nextptr and dataptr handling and the functions
for adding DCB's.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 54 ++--------------------
 1 file changed, 5 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 99d09c97737e..b85b15ca2052 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -28,20 +28,6 @@ static int lan966x_fdma_channel_active(struct lan966x *lan966x)
 	return lan_rd(lan966x, FDMA_CH_ACTIVE);
 }
 
-static struct page *lan966x_fdma_rx_alloc_page(struct lan966x_rx *rx,
-					       struct fdma_db *db)
-{
-	struct page *page;
-
-	page = page_pool_dev_alloc_pages(rx->page_pool);
-	if (unlikely(!page))
-		return NULL;
-
-	db->dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
-
-	return page;
-}
-
 static void lan966x_fdma_rx_free_pages(struct lan966x_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
@@ -66,26 +52,6 @@ static void lan966x_fdma_rx_free_page(struct lan966x_rx *rx)
 	page_pool_recycle_direct(rx->page_pool, page);
 }
 
-static void lan966x_fdma_rx_add_dcb(struct lan966x_rx *rx,
-				    struct fdma_dcb *dcb,
-				    u64 nextptr)
-{
-	struct fdma *fdma = &rx->fdma;
-	struct fdma_db *db;
-	int i;
-
-	for (i = 0; i < fdma->n_dbs; ++i) {
-		db = &dcb->db[i];
-		db->status = FDMA_DCB_STATUS_INTR;
-	}
-
-	dcb->nextptr = FDMA_DCB_INVALID_DATA;
-	dcb->info = FDMA_DCB_INFO_DATAL(PAGE_SIZE << rx->page_order);
-
-	fdma->last_dcb->nextptr = nextptr;
-	fdma->last_dcb = dcb;
-}
-
 static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
@@ -551,15 +517,11 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 {
 	struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
 	struct lan966x_rx *rx = &lan966x->rx;
+	int old_dcb, dcb_reload, counter = 0;
 	struct fdma *fdma = &rx->fdma;
-	int dcb_reload, counter = 0;
-	struct fdma_dcb *old_dcb;
 	bool redirect = false;
 	struct sk_buff *skb;
-	struct fdma_db *db;
-	struct page *page;
 	u64 src_port;
-	u64 nextptr;
 
 	dcb_reload = fdma->dcb_index;
 
@@ -602,19 +564,13 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 allocate_new:
 	/* Allocate new pages and map them */
 	while (dcb_reload != fdma->dcb_index) {
-		db = &fdma->dcbs[dcb_reload].db[fdma->db_index];
-		page = lan966x_fdma_rx_alloc_page(rx, db);
-		if (unlikely(!page))
-			break;
-		rx->page[dcb_reload][fdma->db_index] = page;
-
-		old_dcb = &fdma->dcbs[dcb_reload];
+		old_dcb = dcb_reload;
 		dcb_reload++;
 		dcb_reload &= fdma->n_dcbs - 1;
 
-		nextptr = fdma->dma + ((unsigned long)old_dcb -
-				     (unsigned long)fdma->dcbs);
-		lan966x_fdma_rx_add_dcb(rx, old_dcb, nextptr);
+		fdma_dcb_add(fdma, old_dcb, FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_INTR);
+
 		lan966x_fdma_rx_reload(rx);
 	}
 

-- 
2.34.1


