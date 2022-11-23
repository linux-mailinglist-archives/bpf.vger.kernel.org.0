Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53323636B44
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiKWUb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiKWUbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:31:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05419736C;
        Wed, 23 Nov 2022 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669235230; x=1700771230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQHtk5rD0UFDH3ezGkF35r6wv2LNLOm3eEkyD65lDDA=;
  b=zRkScIjIYlIS8OzBIbVIOcrldIWOhjHTy9O2I3WwBL05EOGTkbykEQxf
   vT0xLuUFlZf0kyyvnRJqDoEmZT/I4scezPjOpxhf+NyPvaRS4QPKgYDKm
   20bbOX+q40+c0lMJFVxn5BFiNvXah9jF6DL+H54S0WVkWYEZCEPqoVTTI
   8O0k1D3Ij3JHMEMBXa1Tz7Il2qe4kxAVbR2oVAYyDck2qSp7ouFJQo8hD
   qKhSvv3+tcaBWC94kxuTWJoOjRqSAoGVNNSc3eSFKOsuJt9Sl/escG2U6
   fBpOYlb0kSjsm+Dw4LNx3eq1SjlaRqlTxlMQsES9XhD4fdpj+umAC5mip
   g==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="184921883"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 13:27:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 13:27:08 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 23 Nov 2022 13:27:06 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <UNGLinuxDriver@microchip.com>, <alexandr.lobakin@intel.com>,
        <maciej.fijalkowski@intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 1/7] net: lan966x: Add XDP_PACKET_HEADROOM
Date:   Wed, 23 Nov 2022 21:31:33 +0100
Message-ID: <20221123203139.3828548-2-horatiu.vultur@microchip.com>
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

Update the page_pool params to allocate XDP_PACKET_HEADROOM space as
headroom for all received frames.
This is needed for when the XDP_TX and XDP_REDIRECT are implemented.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma.c    | 16 +++++++++++-----
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c |  3 ++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 5fbbd479cfb06..3055124b4dd79 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/bpf.h>
+
 #include "lan966x_main.h"
 
 static int lan966x_fdma_channel_active(struct lan966x *lan966x)
@@ -16,7 +18,7 @@ static struct page *lan966x_fdma_rx_alloc_page(struct lan966x_rx *rx,
 	if (unlikely(!page))
 		return NULL;
 
-	db->dataptr = page_pool_get_dma_addr(page);
+	db->dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
 
 	return page;
 }
@@ -72,7 +74,7 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 		.nid = NUMA_NO_NODE,
 		.dev = lan966x->dev,
 		.dma_dir = DMA_FROM_DEVICE,
-		.offset = 0,
+		.offset = XDP_PACKET_HEADROOM,
 		.max_len = rx->max_mtu -
 			   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	};
@@ -432,11 +434,13 @@ static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	if (unlikely(!page))
 		return FDMA_ERROR;
 
-	dma_sync_single_for_cpu(lan966x->dev, (dma_addr_t)db->dataptr,
+	dma_sync_single_for_cpu(lan966x->dev,
+				(dma_addr_t)db->dataptr + XDP_PACKET_HEADROOM,
 				FDMA_DCB_STATUS_BLOCKL(db->status),
 				DMA_FROM_DEVICE);
 
-	lan966x_ifh_get_src_port(page_address(page), src_port);
+	lan966x_ifh_get_src_port(page_address(page) + XDP_PACKET_HEADROOM,
+				 src_port);
 	if (WARN_ON(*src_port >= lan966x->num_phys_ports))
 		return FDMA_ERROR;
 
@@ -466,6 +470,7 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 
 	skb_mark_for_recycle(skb);
 
+	skb_reserve(skb, XDP_PACKET_HEADROOM);
 	skb_put(skb, FDMA_DCB_STATUS_BLOCKL(db->status));
 
 	lan966x_ifh_get_timestamp(skb->data, &timestamp);
@@ -786,7 +791,8 @@ static int lan966x_fdma_get_max_frame(struct lan966x *lan966x)
 	return lan966x_fdma_get_max_mtu(lan966x) +
 	       IFH_LEN_BYTES +
 	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-	       VLAN_HLEN * 2;
+	       VLAN_HLEN * 2 +
+	       XDP_PACKET_HEADROOM;
 }
 
 int lan966x_fdma_change_mtu(struct lan966x *lan966x)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
index e77d9f2aad2b4..8ebde1eb6a09c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
@@ -44,7 +44,8 @@ int lan966x_xdp_run(struct lan966x_port *port, struct page *page, u32 data_len)
 
 	xdp_init_buff(&xdp, PAGE_SIZE << lan966x->rx.page_order,
 		      &port->xdp_rxq);
-	xdp_prepare_buff(&xdp, page_address(page), IFH_LEN_BYTES,
+	xdp_prepare_buff(&xdp, page_address(page),
+			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
 			 data_len - IFH_LEN_BYTES, false);
 	act = bpf_prog_run_xdp(xdp_prog, &xdp);
 	switch (act) {
-- 
2.38.0

