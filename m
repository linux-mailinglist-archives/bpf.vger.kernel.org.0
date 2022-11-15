Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9009562A44E
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 22:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKOVkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 16:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiKOVka (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:40:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED86826118;
        Tue, 15 Nov 2022 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668548430; x=1700084430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2O7GMy+IIz1SySbZrYhpOJz3Xy8edTsWmZxxV8XFC4=;
  b=ZEfG3ByOvC+G9AwTWsMxkvuNm56+3Jgz3/Q0VJOI6gZtcJsnFTaYbmSF
   jhqzHd4+sABv20LC/Ap0lnkzyWq0bVbYufz2deBc3xMZFzDI7a2hCY0CA
   F/7XECzA+wambzYxj/3XjY00AT4wAERviiw+qiw/oZsx7x7A2vXsT8STU
   T2WIJnzwOUp2cXoyAJuZVS6Vw8tbZ3Btmr9fF3l/EBCiUs53X11u3p/+Q
   MmDhZ2KXSB6wRD2fFZwuF7SzINtJh9TFfyv9Riid45AvMMD1rKGXL/4Xe
   9NqL7bZ1LV2f7vMYfVAtt9BQMIoQAyw4IX0oU5gHLSIYtSwicjxEaa0al
   g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="123588507"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 14:40:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 14:40:27 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 15 Nov 2022 14:40:25 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <alexandr.lobakin@intel.com>, <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 2/5] net: lan966x: Introduce helper functions
Date:   Tue, 15 Nov 2022 22:44:53 +0100
Message-ID: <20221115214456.1456856-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221115214456.1456856-1-horatiu.vultur@microchip.com>
References: <20221115214456.1456856-1-horatiu.vultur@microchip.com>
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

Introduce lan966x_fdma_tx_setup_dcb and lan966x_fdma_tx_start functions
and use of them inside lan966x_fdma_xmit. There is no functional change
in here.
They are introduced to be used when XDP_TX/REDIRECT actions are
introduced.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma.c | 71 ++++++++++++-------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 3055124b4dd79..94c720e59caee 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -612,14 +612,53 @@ static int lan966x_fdma_get_next_dcb(struct lan966x_tx *tx)
 	return -1;
 }
 
+static void lan966x_fdma_tx_setup_dcb(struct lan966x_tx *tx,
+				      int next_to_use, int len,
+				      dma_addr_t dma_addr)
+{
+	struct lan966x_tx_dcb *next_dcb;
+	struct lan966x_db *next_db;
+
+	next_dcb = &tx->dcbs[next_to_use];
+	next_dcb->nextptr = FDMA_DCB_INVALID_DATA;
+
+	next_db = &next_dcb->db[0];
+	next_db->dataptr = dma_addr;
+	next_db->status = FDMA_DCB_STATUS_SOF |
+			  FDMA_DCB_STATUS_EOF |
+			  FDMA_DCB_STATUS_INTR |
+			  FDMA_DCB_STATUS_BLOCKO(0) |
+			  FDMA_DCB_STATUS_BLOCKL(len);
+}
+
+static void lan966x_fdma_tx_start(struct lan966x_tx *tx, int next_to_use)
+{
+	struct lan966x *lan966x = tx->lan966x;
+	struct lan966x_tx_dcb *dcb;
+
+	if (likely(lan966x->tx.activated)) {
+		/* Connect current dcb to the next db */
+		dcb = &tx->dcbs[tx->last_in_use];
+		dcb->nextptr = tx->dma + (next_to_use *
+					  sizeof(struct lan966x_tx_dcb));
+
+		lan966x_fdma_tx_reload(tx);
+	} else {
+		/* Because it is first time, then just activate */
+		lan966x->tx.activated = true;
+		lan966x_fdma_tx_activate(tx);
+	}
+
+	/* Move to next dcb because this last in use */
+	tx->last_in_use = next_to_use;
+}
+
 int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 {
 	struct lan966x_port *port = netdev_priv(dev);
 	struct lan966x *lan966x = port->lan966x;
 	struct lan966x_tx_dcb_buf *next_dcb_buf;
-	struct lan966x_tx_dcb *next_dcb, *dcb;
 	struct lan966x_tx *tx = &lan966x->tx;
-	struct lan966x_db *next_db;
 	int needed_headroom;
 	int needed_tailroom;
 	dma_addr_t dma_addr;
@@ -665,16 +704,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 	}
 
 	/* Setup next dcb */
-	next_dcb = &tx->dcbs[next_to_use];
-	next_dcb->nextptr = FDMA_DCB_INVALID_DATA;
-
-	next_db = &next_dcb->db[0];
-	next_db->dataptr = dma_addr;
-	next_db->status = FDMA_DCB_STATUS_SOF |
-			  FDMA_DCB_STATUS_EOF |
-			  FDMA_DCB_STATUS_INTR |
-			  FDMA_DCB_STATUS_BLOCKO(0) |
-			  FDMA_DCB_STATUS_BLOCKL(skb->len);
+	lan966x_fdma_tx_setup_dcb(tx, next_to_use, skb->len, dma_addr);
 
 	/* Fill up the buffer */
 	next_dcb_buf = &tx->dcbs_buf[next_to_use];
@@ -688,21 +718,8 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 	    LAN966X_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
 		next_dcb_buf->ptp = true;
 
-	if (likely(lan966x->tx.activated)) {
-		/* Connect current dcb to the next db */
-		dcb = &tx->dcbs[tx->last_in_use];
-		dcb->nextptr = tx->dma + (next_to_use *
-					  sizeof(struct lan966x_tx_dcb));
-
-		lan966x_fdma_tx_reload(tx);
-	} else {
-		/* Because it is first time, then just activate */
-		lan966x->tx.activated = true;
-		lan966x_fdma_tx_activate(tx);
-	}
-
-	/* Move to next dcb because this last in use */
-	tx->last_in_use = next_to_use;
+	/* Start the transmission */
+	lan966x_fdma_tx_start(tx, next_to_use);
 
 	return NETDEV_TX_OK;
 
-- 
2.38.0

