Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD4632EB2
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiKUVYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 16:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiKUVYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 16:24:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F1657F7;
        Mon, 21 Nov 2022 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669065882; x=1700601882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06uf81UhcRsqU248Upd8RTcFIMaBlp2xwT4+VIGMlqQ=;
  b=shzXO2NoETQY78xpH9dbe3jDKTpxEt2n99R4SbxG1XNtkMcflipv6Cpi
   QiwrvRCiYNHJ9PIFA+i9Y9ttRE2lgZaDVqtC08Nmzwbf+56UWcwzrRmv4
   QUgqY5e/xPPYNbIQ7YfarNtfkfLq24BFLPee+F/opt3UZpNDPDLJoi3Jf
   8eUj5rGRcn5rwUu2n3y0b4WXp8VUTUJYNWroYhbMLigice4WJ0ngIFE7S
   Za7DJUwCl9Edn/wR4BzDRcnLw30QZ6/aisCVoL/OeFztrzM2wOGWFNbeD
   H8QyvhL9dq1by7U6HVC/+yMW+1B9u9EcdeFq/5qQf1RtdS11ZPXKWKrJc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="189968355"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 14:24:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 14:24:41 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 14:24:38 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 3/7] net: lan966x: Add len field to lan966x_tx_dcb_buf
Date:   Mon, 21 Nov 2022 22:28:46 +0100
Message-ID: <20221121212850.3212649-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221121212850.3212649-1-horatiu.vultur@microchip.com>
References: <20221121212850.3212649-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently when a frame was transmitted, it is required to unamp the
frame that was transmitted. The length of the frame was taken from the
transmitted skb. In the future we might not have an skb, therefore store
the length skb directly in the lan966x_tx_dcb_buf and use this one to
unamp the frame.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 5 +++--
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 94c720e59caee..384ed34197d58 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -391,12 +391,12 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 			continue;
 
 		dcb_buf->dev->stats.tx_packets++;
-		dcb_buf->dev->stats.tx_bytes += dcb_buf->skb->len;
+		dcb_buf->dev->stats.tx_bytes += dcb_buf->len;
 
 		dcb_buf->used = false;
 		dma_unmap_single(lan966x->dev,
 				 dcb_buf->dma_addr,
-				 dcb_buf->skb->len,
+				 dcb_buf->len,
 				 DMA_TO_DEVICE);
 		if (!dcb_buf->ptp)
 			dev_kfree_skb_any(dcb_buf->skb);
@@ -709,6 +709,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 	/* Fill up the buffer */
 	next_dcb_buf = &tx->dcbs_buf[next_to_use];
 	next_dcb_buf->skb = skb;
+	next_dcb_buf->len = skb->len;
 	next_dcb_buf->dma_addr = dma_addr;
 	next_dcb_buf->used = true;
 	next_dcb_buf->ptp = false;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index bc93051aa0798..7bb9098496f60 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -175,6 +175,7 @@ struct lan966x_rx {
 struct lan966x_tx_dcb_buf {
 	struct net_device *dev;
 	struct sk_buff *skb;
+	int len;
 	dma_addr_t dma_addr;
 	bool used;
 	bool ptp;
-- 
2.38.0

