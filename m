Return-Path: <bpf+bounces-9654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E466579A9BE
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1241C204E8
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD81400C;
	Mon, 11 Sep 2023 15:29:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569E11710;
	Mon, 11 Sep 2023 15:29:14 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24921F2;
	Mon, 11 Sep 2023 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dXrJls0KWbEugGzjnIOny5aYJAM0fzmrBdmbDeg7HCA=; b=BveGPcgcG8RVR4PGBCXXGT63QF
	QNhTdMNEQQUfo+Xd1DMbx4H6b943q4S9sjiuQLfo2yNhIUwtGeHf8q9jwrdQfvsp0LjRoNLGctpWA
	VX7C9H4UyW26wabScfmcgoMRSscvKTxGFivX1dN54U0jr8YUPotl7tTncDgnUB1AYO98asfw/jWMU
	eYMDY06iUjQk5XTdWHiVoiTY0BEk2oJVc2FcOmQvfVmQlcuNuj7Cr77RuLSqLnT4USV9BDojOVMnF
	C8O8QLyRqQHMIrCvaKNxQxJyvjGACSvOuV88G2RkufJwziaYnqrtaEYYU9+kwxZJMqKgnmUnHFbkE
	m53krzJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52148 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qfiqZ-0008D6-1X;
	Mon, 11 Sep 2023 16:29:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qfiqY-007TPF-2f; Mon, 11 Sep 2023 16:29:06 +0100
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
Subject: [PATCH net-next 6/6] net: stmmac: qos-eth: use
 dwmac_set_tx_clk_gmii()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qfiqY-007TPF-2f@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Sep 2023 16:29:06 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 37 ++++++-------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 61ebf36da13d..a8fae37b9858 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -22,6 +22,7 @@
 #include <linux/stmmac.h>
 
 #include "stmmac_platform.h"
+#include "stmmac_plat_lib.h"
 #include "dwmac4.h"
 
 struct tegra_eqos {
@@ -181,32 +182,10 @@ static void dwc_qos_remove(struct platform_device *pdev)
 static void tegra_eqos_fix_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct tegra_eqos *eqos = priv;
-	unsigned long rate = 125000000;
-	bool needs_calibration = false;
 	u32 value;
 	int err;
 
-	switch (speed) {
-	case SPEED_1000:
-		needs_calibration = true;
-		rate = 125000000;
-		break;
-
-	case SPEED_100:
-		needs_calibration = true;
-		rate = 25000000;
-		break;
-
-	case SPEED_10:
-		rate = 2500000;
-		break;
-
-	default:
-		dev_err(eqos->dev, "invalid speed %u\n", speed);
-		break;
-	}
-
-	if (needs_calibration) {
+	if (speed == SPEED_1000 || speed == SPEED_100) {
 		/* calibrate */
 		value = readl(eqos->regs + SDMEMCOMPPADCTRL);
 		value |= SDMEMCOMPPADCTRL_PAD_E_INPUT_OR_E_PWRD;
@@ -246,9 +225,15 @@ static void tegra_eqos_fix_speed(void *priv, unsigned int speed, unsigned int mo
 		writel(value, eqos->regs + AUTO_CAL_CONFIG);
 	}
 
-	err = clk_set_rate(eqos->clk_tx, rate);
-	if (err < 0)
-		dev_err(eqos->dev, "failed to set TX rate: %d\n", err);
+	err = dwmac_set_tx_clk_gmii(eqos->clk_tx, speed);
+	if (err == -ENOTSUPP) {
+		dev_err(eqos->dev, "invalid speed %dMbps\n", speed);
+		err = dwmac_set_tx_clk_gmii(eqos->clk_tx, SPEED_1000);
+	} else if (err) {
+		dev_err(eqos->dev,
+			"failed to set tx rate for speed %dMbps: %pe\n",
+			speed, ERR_PTR(err));
+	}
 }
 
 static int tegra_eqos_init(struct platform_device *pdev, void *priv)
-- 
2.30.2


