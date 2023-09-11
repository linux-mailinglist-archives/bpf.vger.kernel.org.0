Return-Path: <bpf+bounces-9657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89379A9C7
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7816D281260
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A786814F73;
	Mon, 11 Sep 2023 15:29:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719501171B;
	Mon, 11 Sep 2023 15:29:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7ACF2;
	Mon, 11 Sep 2023 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5Bw3V6l7OAdGCcXOYDDsqxqV/1ww1WRoNiEO2wv3Q/8=; b=RJiWET2MHDWctlVVcsFfn5ix1R
	m0nXj7KKH8ih0U5Y4kTSHGg6cN/NiPlQitQfMXT/oXvPXOzESoWSFVfUBSsVqb1q4W9bORGNXFHXa
	Ay41NSHe4Y9rhRXWEFyCcPGeD07jrMXnFeesGg8bgQ4BjlsojnzSh+POwkq6Qy+B8sqBXZAjG02gg
	qYGv0TGJVnxOS8f5GPZ1uq+gDXG8odvbCx81ozafH3a4CyjOqGA/Hq8e/HaH30046pZ8EUHHYRhJn
	MWU+74YnqeHkaIAL0FJ9b9OFd+xnpPQGtiMPXi6AQORKFLYnu/Pp9VIiOGBGuaZGSqREac0e8QPSV
	Dv8+pfFA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39316 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qfiqu-0008Em-2w;
	Mon, 11 Sep 2023 16:29:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qfiqs-007TPg-LS; Mon, 11 Sep 2023 16:29:26 +0100
In-Reply-To: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/6] net: stmmac: rk: use dwmac_set_tx_clk_gmii()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qfiqs-007TPg-LS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Sep 2023 16:29:26 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 61 ++++++-------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d920a50dd16c..30172ca3bd06 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 
 #include "stmmac_platform.h"
+#include "stmmac_plat_lib.h"
 
 struct rk_priv_data;
 struct rk_gmac_ops {
@@ -1081,28 +1082,14 @@ static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned long rate;
-	int ret;
-
-	switch (speed) {
-	case 10:
-		rate = 2500000;
-		break;
-	case 100:
-		rate = 25000000;
-		break;
-	case 1000:
-		rate = 125000000;
-		break;
-	default:
-		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
-		return;
-	}
-
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
-			__func__, rate, ret);
+	int err;
+
+	err = dwmac_set_tx_clk_gmii(clk_mac_speed, speed);
+	if (err == -ENOTSUPP)
+		dev_err(dev, "invalid speed %dMbps\n", speed);
+	else if (err)
+		dev_err(dev, "failed to set tx rate for speed %dMbps: %pe\n",
+			speed, ERR_PTR(err));
 }
 
 static const struct rk_gmac_ops rk3568_ops = {
@@ -1387,28 +1374,14 @@ static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
-	unsigned long rate;
-	int ret;
-
-	switch (speed) {
-	case 10:
-		rate = 2500000;
-		break;
-	case 100:
-		rate = 25000000;
-		break;
-	case 1000:
-		rate = 125000000;
-		break;
-	default:
-		dev_err(dev, "unknown speed value for RGMII speed=%d", speed);
-		return;
-	}
-
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
-			__func__, rate, ret);
+	int err;
+
+	err = dwmac_set_tx_clk_gmii(clk_mac_speed, speed);
+	if (err == -ENOTSUPP)
+		dev_err(dev, "invalid speed %dMbps\n", speed);
+	else if (err)
+		dev_err(dev, "failed to set tx rate for speed %dMbps: %pe\n",
+			speed, ERR_PTR(err));
 }
 
 static void rv1126_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
-- 
2.30.2


