Return-Path: <bpf+bounces-9650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B8A79A9B1
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD7428113C
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1325C125A8;
	Mon, 11 Sep 2023 15:28:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FA11C84;
	Mon, 11 Sep 2023 15:28:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C496E4;
	Mon, 11 Sep 2023 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n8j/kmn+Ia/Kfu9cLc90F6mFrEGGGfC9nZYxAWE9saM=; b=wCwejzc2F9nHFGVle8SODF74qO
	f6LYiM9drBFbzuPIlU2b8/iRxadKoeytX+FfSp1gP59Z8q01WsrjAQPqJTllKTRtKk6nb5wpxw4ld
	+dWJljKpsqfHRo6H5OGaYMQhWM1aFJ4K+2/WPeSLNyuMEy/7fmBONa8s22lx2R0Gf0wnu1y6Snxf6
	0g8B7M2MGT7DvvAdCYr1kuNE+9eQ9sHecnlyVvY4ejtSrM+nWo/SS7rgdCFpb/OCNCl1xaGu6hYk6
	tyPQYLzKATKc59bddK7V4B4J28gjK4/C82+LF2wqCddc6ri8zIqHHMKx7NMnVKRZCFBoosdFg1QHk
	4HLyQXYw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56330 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qfiqC-0008Bx-2L;
	Mon, 11 Sep 2023 16:28:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qfiqD-007TOl-DS; Mon, 11 Sep 2023 16:28:45 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samin Guo <samin.guo@starfivetech.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 2/6] net: stmmac: imx: use dwmac_set_tx_clk_gmii()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qfiqD-007TOl-DS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Sep 2023 16:28:45 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index df34e34cc14f..d2569faf7cc3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -21,6 +21,7 @@
 #include <linux/stmmac.h>
 
 #include "stmmac_platform.h"
+#include "stmmac_plat_lib.h"
 
 #define GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(21, 16)
 #define GPR_ENET_QOS_INTF_SEL_MII	(0x0 << 16)
@@ -186,7 +187,6 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct imx_priv_data *dwmac = priv;
-	unsigned long rate;
 	int err;
 
 	plat_dat = dwmac->plat_dat;
@@ -196,24 +196,13 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
 	    (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII))
 		return;
 
-	switch (speed) {
-	case SPEED_1000:
-		rate = 125000000;
-		break;
-	case SPEED_100:
-		rate = 25000000;
-		break;
-	case SPEED_10:
-		rate = 2500000;
-		break;
-	default:
-		dev_err(dwmac->dev, "invalid speed %u\n", speed);
-		return;
-	}
-
-	err = clk_set_rate(dwmac->clk_tx, rate);
-	if (err < 0)
-		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
+	err = dwmac_set_tx_clk_gmii(dwmac->clk_tx, speed);
+	if (err == -ENOTSUPP)
+		dev_err(dwmac->dev, "invalid speed %dMbps\n", speed);
+	else if (err)
+		dev_err(dwmac->dev,
+			"failed to set tx rate for speed %dMbps: %pe\n",
+			speed, ERR_PTR(err));
 }
 
 static void imx93_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
-- 
2.30.2


