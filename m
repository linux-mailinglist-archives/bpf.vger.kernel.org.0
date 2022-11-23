Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC42636B3C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiKWUbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbiKWUbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:31:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624FB8DA52;
        Wed, 23 Nov 2022 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669235246; x=1700771246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q0Sn23Y5RcrLJJSzqjsvSLaJWPYpAiItTX0oz16kJUE=;
  b=08NRozcLUHVeYVWxiN1Eq99OALe5SMCNao/zhQi60Q7wgoMnrKwbVPHg
   J97DqVBHhbsl/TTyB4Jvj7X5U34IhrX3ZcLpWDFzz9Q+eJWcW6HsRlRNL
   9iD3h0qP3G5MyhMQ4OFXb8ubmaR1u1AlPwgu7WrFkvEyAv10lftLQnMuM
   zmdo/SAWbfFRlBByCs2A6cIwF2MhL9a8N+E8PMcgUytAsoarct0MIzVam
   BpC6NFx51wg4eukn3LVGH2X7GCrLZr7IZo5J5MsVM0mm1hUAvGzHn9aWH
   U6QGNQ0nlXbSl3CMwUa5yAJewuYEcLD5mY9pwD5b8VnGKX22GpL/HdDSV
   w==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="184921912"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 13:27:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 13:27:15 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 23 Nov 2022 13:27:12 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <UNGLinuxDriver@microchip.com>, <alexandr.lobakin@intel.com>,
        <maciej.fijalkowski@intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 3/7] net: lan966x: Add len field to lan966x_tx_dcb_buf
Date:   Wed, 23 Nov 2022 21:31:35 +0100
Message-ID: <20221123203139.3828548-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221123203139.3828548-1-horatiu.vultur@microchip.com>
References: <20221123203139.3828548-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
While at this, also arrange the members in lan966x_tx_dcb_buf not to
have any holes.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 5 +++--
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

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
index bc93051aa0798..c762e3732f88f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -173,11 +173,12 @@ struct lan966x_rx {
 };
 
 struct lan966x_tx_dcb_buf {
+	dma_addr_t dma_addr;
 	struct net_device *dev;
 	struct sk_buff *skb;
-	dma_addr_t dma_addr;
-	bool used;
-	bool ptp;
+	u32 len;
+	u32 used : 1;
+	u32 ptp : 1;
 };
 
 struct lan966x_tx {
-- 
2.38.0

