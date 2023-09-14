Return-Path: <bpf+bounces-10026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F67A06AD
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E810F281ADB
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF823769;
	Thu, 14 Sep 2023 13:51:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15461D556;
	Thu, 14 Sep 2023 13:51:53 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E411B1FC8;
	Thu, 14 Sep 2023 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=blBCZ/n7JwsBPVsYbstO8SD+/phIKgnPgDwevzXDKaM=; b=Mu1CG0VkGeF/qC0Q9tfXvBQeSz
	faafrqhFFvCEqjC5NmQGvN1Gp6ml3Iwtwzh9kl2IomWp1tw9+sODmsMWE4EnKsCgzIwPLGazqNVqL
	RTcPKrCN3wqgCcScIrPeR18qn+VLnE9h95eCevcu6ROG31UpNaFX+gTgUhAPHbceTaGxi2aMvDFmW
	29AyFtVrWW4eWTOX2q26/otD/AXlFM3znfwtsxoGC5Q6J4Hh5QD4e/06HbHykIWu/no8LW1wNLIAK
	zbHuRPERR1whdXqf9y3KuimKFvQHoxmjbJWreLc3dhJouETQ0JAsoTjw2cXSixPoVR7NS6Da95wtX
	mSdBh/sA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59460 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgml0-0004Gx-2q;
	Thu, 14 Sep 2023 14:51:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgmkz-007Z54-P3; Thu, 14 Sep 2023 14:51:45 +0100
In-Reply-To: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
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
 stmmac_set_tx_clk_gmii()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgmkz-007Z54-P3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 14:51:45 +0100

Use stmmac_set_tx_clk_gmii().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 36 ++++++-------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 61ebf36da13d..bc9b054e10af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -181,32 +181,10 @@ static void dwc_qos_remove(struct platform_device *pdev)
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
@@ -246,9 +224,15 @@ static void tegra_eqos_fix_speed(void *priv, unsigned int speed, unsigned int mo
 		writel(value, eqos->regs + AUTO_CAL_CONFIG);
 	}
 
-	err = clk_set_rate(eqos->clk_tx, rate);
-	if (err < 0)
-		dev_err(eqos->dev, "failed to set TX rate: %d\n", err);
+	err = stmmac_set_tx_clk_gmii(eqos->clk_tx, speed);
+	if (err == -ENOTSUPP) {
+		dev_err(eqos->dev, "invalid speed %uMbps\n", speed);
+		err = stmmac_set_tx_clk_gmii(eqos->clk_tx, SPEED_1000);
+	} else if (err) {
+		dev_err(eqos->dev,
+			"failed to set tx rate for speed %uMbps: %pe\n",
+			speed, ERR_PTR(err));
+	}
 }
 
 static int tegra_eqos_init(struct platform_device *pdev, void *priv)
-- 
2.30.2


