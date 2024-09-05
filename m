Return-Path: <bpf+bounces-38970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DF96D15A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFE5B24446
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A364E1974FE;
	Thu,  5 Sep 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DrnDreP9"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53383194A73;
	Thu,  5 Sep 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523639; cv=none; b=I5VksXbgTPZ5rm49gBPwyNCEp6cBAWibM41kbc+gS6Qv6aZesXco8zgOL9aK13OnMG0zKum/0Tj5gMt4jeElZAa9b4/zNgiQGnCh3qWB/zn30aArvCHr+8KALuBgZe2VEp4REJdI9mD4bM0uBvfgM9jwzoP8vc8NEibU9BKPqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523639; c=relaxed/simple;
	bh=v0UJx/Km6OEA1FP/PhI1HAV2q6XZjFftqU+W595/U7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q6PeJx2SJJeNo3ijJlYnZk4AWc6vh/+UpV5p5SoSShJ+BRWY93Oeh/drVR6P9qPeGBUZTmVkwGcKGRxkYvEfrLLNhKAF8mxl35GnjygZ6lUFuHGzWYUK2pSYUm5p0mwOt6r87heJDNWL4+dNJakMLXG41ded6kJbxWgfuW4SWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DrnDreP9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523637; x=1757059637;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v0UJx/Km6OEA1FP/PhI1HAV2q6XZjFftqU+W595/U7A=;
  b=DrnDreP9dA4kfkco5N1lSDe1F+DVDuCVOD31B0Vo4tQqyl2xqJlbRvhJ
   EuVkqVG1Rg14F3iyB9ZMLX9xcmuZSob44MM1HBlcoawENr2kaSzTUvbSZ
   FCxX5DZRW222A+YPJMsaZFWWPYEzVRy0tRbqEENFDQ0Q/iKA2HLdjS1Mf
   y2KV2Q9AGhwf0/wMnW+zO+1j2X7UhjIOeGLZtmoBqTZVqoIxGATBNx2r6
   kHCtPYJ/H41RX6L0xfmq+rxWFcF0KqTnvqTeCT/jMYy7BfW4n0M/DwdSR
   l+JVc4kChCr0vtmn3iiVue7HU1Yt/Q97cm9cEwesTKSOGIrBfHSONhJLb
   g==;
X-CSE-ConnectionGUID: un5sTwBcTQSB1/6lZ6FYYg==
X-CSE-MsgGUID: YcCkSixSQ+mSEcIaM7dQ5A==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="32000385"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:12 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:36 +0200
Subject: [PATCH net-next 08/12] net: lan966x: use FDMA library for adding
 DCB's in the tx path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-8-e083f8620165@microchip.com>
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

Use the fdma_dcb_add() function to add DCB's in the tx path. This gets
rid of the open-coding of nextptr and dataptr handling and leaves it to
the library.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 62 +++++++++++-----------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 3afc6c4c68a4..1beafadce87a 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -33,6 +33,16 @@ static int lan966x_fdma_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
 	return 0;
 }
 
+static int lan966x_fdma_xdp_tx_dataptr_cb(struct fdma *fdma, int dcb, int db,
+					  u64 *dataptr)
+{
+	struct lan966x *lan966x = (struct lan966x *)fdma->priv;
+
+	*dataptr = lan966x->tx.dcbs_buf[dcb].dma_addr + XDP_PACKET_HEADROOM;
+
+	return 0;
+}
+
 static int lan966x_fdma_channel_active(struct lan966x *lan966x)
 {
 	return lan_rd(lan966x, FDMA_CH_ACTIVE);
@@ -600,25 +610,6 @@ static int lan966x_fdma_get_next_dcb(struct lan966x_tx *tx)
 	return -1;
 }
 
-static void lan966x_fdma_tx_setup_dcb(struct lan966x_tx *tx,
-				      int next_to_use, int len,
-				      dma_addr_t dma_addr)
-{
-	struct fdma_dcb *next_dcb;
-	struct fdma_db *next_db;
-
-	next_dcb = &tx->fdma.dcbs[next_to_use];
-	next_dcb->nextptr = FDMA_DCB_INVALID_DATA;
-
-	next_db = &next_dcb->db[0];
-	next_db->dataptr = dma_addr;
-	next_db->status = FDMA_DCB_STATUS_SOF |
-			  FDMA_DCB_STATUS_EOF |
-			  FDMA_DCB_STATUS_INTR |
-			  FDMA_DCB_STATUS_BLOCKO(0) |
-			  FDMA_DCB_STATUS_BLOCKL(len);
-}
-
 static void lan966x_fdma_tx_start(struct lan966x_tx *tx, int next_to_use)
 {
 	struct lan966x *lan966x = tx->lan966x;
@@ -692,11 +683,6 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 
 		next_dcb_buf->data.xdpf = xdpf;
 		next_dcb_buf->len = xdpf->len + IFH_LEN_BYTES;
-
-		/* Setup next dcb */
-		lan966x_fdma_tx_setup_dcb(tx, next_to_use,
-					  xdpf->len + IFH_LEN_BYTES,
-					  dma_addr);
 	} else {
 		page = ptr;
 
@@ -713,11 +699,6 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 
 		next_dcb_buf->data.page = page;
 		next_dcb_buf->len = len + IFH_LEN_BYTES;
-
-		/* Setup next dcb */
-		lan966x_fdma_tx_setup_dcb(tx, next_to_use,
-					  len + IFH_LEN_BYTES,
-					  dma_addr + XDP_PACKET_HEADROOM);
 	}
 
 	/* Fill up the buffer */
@@ -728,6 +709,17 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 	next_dcb_buf->ptp = false;
 	next_dcb_buf->dev = port->dev;
 
+	__fdma_dcb_add(&tx->fdma,
+		       next_to_use,
+		       0,
+		       FDMA_DCB_STATUS_INTR |
+		       FDMA_DCB_STATUS_SOF |
+		       FDMA_DCB_STATUS_EOF |
+		       FDMA_DCB_STATUS_BLOCKO(0) |
+		       FDMA_DCB_STATUS_BLOCKL(next_dcb_buf->len),
+		       &fdma_nextptr_cb,
+		       &lan966x_fdma_xdp_tx_dataptr_cb);
+
 	/* Start the transmission */
 	lan966x_fdma_tx_start(tx, next_to_use);
 
@@ -787,9 +779,6 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 		goto release;
 	}
 
-	/* Setup next dcb */
-	lan966x_fdma_tx_setup_dcb(tx, next_to_use, skb->len, dma_addr);
-
 	/* Fill up the buffer */
 	next_dcb_buf = &tx->dcbs_buf[next_to_use];
 	next_dcb_buf->use_skb = true;
@@ -801,6 +790,15 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 	next_dcb_buf->ptp = false;
 	next_dcb_buf->dev = dev;
 
+	fdma_dcb_add(&tx->fdma,
+		     next_to_use,
+		     0,
+		     FDMA_DCB_STATUS_INTR |
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(skb->len));
+
 	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
 	    LAN966X_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
 		next_dcb_buf->ptp = true;

-- 
2.34.1


