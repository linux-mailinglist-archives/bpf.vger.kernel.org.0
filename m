Return-Path: <bpf+bounces-38976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D896D172
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3F1C22756
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80E199397;
	Thu,  5 Sep 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tr0CV1ky"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDED1991CA;
	Thu,  5 Sep 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523671; cv=none; b=oLTb4jw4wW8wLeMskkv7wpIV9MS/uEmthoEJUB5GnQsKWmUio+bW6GtGbEoyxil7zWD73ZFOvynLzYV/ikgNNtXmPhhcvHUkz+L1Ejp9NnefeFyQJgWxIiUuhgxjWu1+W2pKBxpXH5SK+pyKkbcLhSonAU4ri3GPiO0MPniUFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523671; c=relaxed/simple;
	bh=4SWvhSG7TJHT1LJwDw37nF7hc4dbd0N3qUSKXp5KcLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fW3cS7qaf6C2RHap652fPcZ88mpyvk3Cc6Ee9FHrgDgxcyje2VJmwNBLJsirazDYACR281n27lw+iVRBizXxr0amIlvqU4j2gHK8xFxO+nueiQNZ+B9vYz68FM8zWPoq3UdisRWzMJgFc7p3i81PVUubv0IA8Boyc5gxRDXnQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tr0CV1ky; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523669; x=1757059669;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4SWvhSG7TJHT1LJwDw37nF7hc4dbd0N3qUSKXp5KcLk=;
  b=tr0CV1kygcFxOHeXETov4jyo58p4j6gPmUB5YxY0f7oJBiOxudUx40xz
   5XqsURaQGfBt993nSWEKJgLgNa9zjYblQmq+nfKKi9u9K9vvUTW9MxMip
   GdMZt9IncLYQYO87Zf4R55VWxvQUDr8aIIgRsrAKTyrAr47p3umMVWa/t
   hWDEsxiepzlilioGsLA3BwdDhtFR+k+SNBi0sgtFcJjfY4bFokrla4hZw
   77kWeZKHP0RF4Fzyd6Gj9zfbPmqwF5yh3lA8zxQ90WLetPICwsrluMFDH
   7eulNPFBLLTuAmfDlLDMwMmpXsuMcWx2bTL2m5gJ8SVM4CZUNT7F457BD
   Q==;
X-CSE-ConnectionGUID: 7ewQ9CGBRIuJm60AkmofCw==
X-CSE-MsgGUID: dhkEme0bSz6YMamOZOP7bg==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34454187"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:07:17 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:07:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:38 +0200
Subject: [PATCH net-next 10/12] net: lan966x: ditch tx->last_in_use
 variable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-10-e083f8620165@microchip.com>
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

This variable is used in the tx path to determine the last used DCB. The
library has the variable last_dcb for the exact same purpose. Ditch the
last_in_use variable throughout.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c    | 20 ++++----------------
 .../net/ethernet/microchip/lan966x/lan966x_main.h    |  2 --
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 6f7e3c27c1a7..b5a97c5a2e1b 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -293,7 +293,6 @@ static void lan966x_fdma_tx_disable(struct lan966x_tx *tx)
 		lan966x, FDMA_CH_DB_DISCARD);
 
 	tx->activated = false;
-	tx->last_in_use = -1;
 }
 
 static void lan966x_fdma_tx_reload(struct lan966x_tx *tx)
@@ -598,34 +597,24 @@ static int lan966x_fdma_get_next_dcb(struct lan966x_tx *tx)
 
 	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb_buf = &tx->dcbs_buf[i];
-		if (!dcb_buf->used && i != tx->last_in_use)
+		if (!dcb_buf->used && &fdma->dcbs[i] != fdma->last_dcb)
 			return i;
 	}
 
 	return -1;
 }
 
-static void lan966x_fdma_tx_start(struct lan966x_tx *tx, int next_to_use)
+static void lan966x_fdma_tx_start(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
-	struct fdma *fdma = &tx->fdma;
-	struct fdma_dcb *dcb;
 
 	if (likely(lan966x->tx.activated)) {
-		/* Connect current dcb to the next db */
-		dcb = &fdma->dcbs[tx->last_in_use];
-		dcb->nextptr = fdma->dma + (next_to_use *
-					  sizeof(struct fdma_dcb));
-
 		lan966x_fdma_tx_reload(tx);
 	} else {
 		/* Because it is first time, then just activate */
 		lan966x->tx.activated = true;
 		lan966x_fdma_tx_activate(tx);
 	}
-
-	/* Move to next dcb because this last in use */
-	tx->last_in_use = next_to_use;
 }
 
 int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
@@ -716,7 +705,7 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 		       &lan966x_fdma_xdp_tx_dataptr_cb);
 
 	/* Start the transmission */
-	lan966x_fdma_tx_start(tx, next_to_use);
+	lan966x_fdma_tx_start(tx);
 
 out:
 	spin_unlock(&lan966x->tx_lock);
@@ -799,7 +788,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 		next_dcb_buf->ptp = true;
 
 	/* Start the transmission */
-	lan966x_fdma_tx_start(tx, next_to_use);
+	lan966x_fdma_tx_start(tx);
 
 	return NETDEV_TX_OK;
 
@@ -985,7 +974,6 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	lan966x->tx.fdma.db_size = PAGE_SIZE << lan966x->rx.page_order;
 	lan966x->tx.fdma.ops.nextptr_cb = &fdma_nextptr_cb;
 	lan966x->tx.fdma.ops.dataptr_cb = &lan966x_fdma_tx_dataptr_cb;
-	lan966x->tx.last_in_use = -1;
 
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
 	if (err)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 99efc596c9e6..25cb2f61986f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -232,8 +232,6 @@ struct lan966x_tx {
 
 	struct fdma fdma;
 
-	u16 last_in_use;
-
 	/* Array of dcbs that are given to the HW */
 	struct lan966x_tx_dcb_buf *dcbs_buf;
 

-- 
2.34.1


