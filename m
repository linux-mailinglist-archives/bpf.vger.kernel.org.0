Return-Path: <bpf+bounces-38977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E947696D175
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198761C22D40
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9D19992D;
	Thu,  5 Sep 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EA40rSQF"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657B1991D9;
	Thu,  5 Sep 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523672; cv=none; b=lGMpekIXCBK33vcCn34BpCrIPyel5q+qdk1bQWcTTYq7wHIDxbVAb6fDTlIxf97+eah6nDcvjB0fbc32J5J7E2CQVsqkSdgMlPeVQYiwnMbFstFIx6pGJwTH9dsg+eJB1Sul81dxXs7ADf9k1dRr0DEGaPgdzLTrgeCy9SZ+7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523672; c=relaxed/simple;
	bh=M2TwK1cJ9yncTsoISBdNRRNCZrwjb2y9dw1H8CTcJxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HJxcdp58tjb3FdH4K3UaOfbSXv+Otj6h8YKZk8yY22I8uclIpj1zKG5hsQZxBLf/qZbkpOpcl75QNfOjfibuqsn3DifkBbZ1RwSZ3ZR6/4wzUsvRjYwGleXW5e6dUfxEezb4e0zTKxOLtaGJw+RUkwOr98pEl0VEoB6WrKDWrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EA40rSQF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523670; x=1757059670;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=M2TwK1cJ9yncTsoISBdNRRNCZrwjb2y9dw1H8CTcJxs=;
  b=EA40rSQFKHDgtBpgnVgFQVvalUVNaLGmSPy95uGRIMonjlXfaey6MxKR
   uu97D44xOkSaohWKhwucEztDFxo5ChW9PCHcpE7H75qR5np2Ilw00rS2l
   a2NrXbWX8BIqz8J+IH+VnvavfgR67NHMZyUv1QIqiYwPjU1Q2BjY7kL8l
   pYDzymn6v0LkRjMSV3Fp7AZtfZjb2ddzIS1PbB0c51efalqnGygpObkPG
   qdsmCuvUnNovL627y+Q/kPgIgo3YT2B70Oz4lRn2MbGc2t16GvFMrhn9T
   rVIeoas7XVkCqkOPYfn0SD6XICDL3869TgOzyaHIw6w+YplkqFb28VSMF
   g==;
X-CSE-ConnectionGUID: 7ewQ9CGBRIuJm60AkmofCw==
X-CSE-MsgGUID: DhKSG2F5SmW+R/YLwklhMw==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34454188"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:19 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:39 +0200
Subject: [PATCH net-next 11/12] net: lan966x: use a few FDMA helpers
 throughout
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-11-e083f8620165@microchip.com>
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

The library provides helpers for a number of DCB and DB operations. Use
these throughout the code and remove the old ones.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 42 ++++++----------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index b5a97c5a2e1b..4c8f83e4c5de 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -126,14 +126,6 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 	return 0;
 }
 
-static void lan966x_fdma_rx_advance_dcb(struct lan966x_rx *rx)
-{
-	struct fdma *fdma = &rx->fdma;
-
-	fdma->dcb_index++;
-	fdma->dcb_index &= fdma->n_dcbs - 1;
-}
-
 static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
@@ -355,8 +347,8 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 		if (!dcb_buf->used)
 			continue;
 
-		db = &fdma->dcbs[i].db[0];
-		if (!(db->status & FDMA_DCB_STATUS_DONE))
+		db = fdma_db_get(fdma, i, 0);
+		if (!fdma_db_is_done(db))
 			continue;
 
 		dcb_buf->dev->stats.tx_packets++;
@@ -396,19 +388,6 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 	spin_unlock_irqrestore(&lan966x->tx_lock, flags);
 }
 
-static bool lan966x_fdma_rx_more_frames(struct lan966x_rx *rx)
-{
-	struct fdma *fdma = &rx->fdma;
-	struct fdma_db *db;
-
-	/* Check if there is any data */
-	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
-	if (unlikely(!(db->status & FDMA_DCB_STATUS_DONE)))
-		return false;
-
-	return true;
-}
-
 static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 {
 	struct lan966x *lan966x = rx->lan966x;
@@ -417,7 +396,7 @@ static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	struct fdma_db *db;
 	struct page *page;
 
-	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
+	db = fdma_db_next_get(fdma);
 	page = rx->page[fdma->dcb_index][fdma->db_index];
 	if (unlikely(!page))
 		return FDMA_ERROR;
@@ -450,7 +429,7 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 	u64 timestamp;
 
 	/* Get the received frame and unmap it */
-	db = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
+	db = fdma_db_next_get(fdma);
 	page = rx->page[fdma->dcb_index][fdma->db_index];
 
 	skb = build_skb(page_address(page), fdma->db_size);
@@ -508,7 +487,7 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 
 	/* Get all received skb */
 	while (counter < weight) {
-		if (!lan966x_fdma_rx_more_frames(rx))
+		if (!fdma_has_frames(fdma))
 			break;
 
 		counter++;
@@ -518,22 +497,22 @@ static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 			break;
 		case FDMA_ERROR:
 			lan966x_fdma_rx_free_page(rx);
-			lan966x_fdma_rx_advance_dcb(rx);
+			fdma_dcb_advance(fdma);
 			goto allocate_new;
 		case FDMA_REDIRECT:
 			redirect = true;
 			fallthrough;
 		case FDMA_TX:
-			lan966x_fdma_rx_advance_dcb(rx);
+			fdma_dcb_advance(fdma);
 			continue;
 		case FDMA_DROP:
 			lan966x_fdma_rx_free_page(rx);
-			lan966x_fdma_rx_advance_dcb(rx);
+			fdma_dcb_advance(fdma);
 			continue;
 		}
 
 		skb = lan966x_fdma_rx_get_frame(rx, src_port);
-		lan966x_fdma_rx_advance_dcb(rx);
+		fdma_dcb_advance(fdma);
 		if (!skb)
 			goto allocate_new;
 
@@ -597,7 +576,8 @@ static int lan966x_fdma_get_next_dcb(struct lan966x_tx *tx)
 
 	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb_buf = &tx->dcbs_buf[i];
-		if (!dcb_buf->used && &fdma->dcbs[i] != fdma->last_dcb)
+		if (!dcb_buf->used &&
+		    !fdma_is_last(&tx->fdma, &tx->fdma.dcbs[i]))
 			return i;
 	}
 

-- 
2.34.1


