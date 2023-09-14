Return-Path: <bpf+bounces-10022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBB7A0686
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D0BB20B5E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D47224FF;
	Thu, 14 Sep 2023 13:51:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA6224DF;
	Thu, 14 Sep 2023 13:51:27 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675181BF8;
	Thu, 14 Sep 2023 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Ggzd6KKNjZJlZVC4V4b37NrE+RHUSzuLGhRyYhd788=; b=IcEV4FdGM9shNwxOpListlONWh
	fy4VPSRWxmMABXIgOPvdf8MUazPc6Kr9XHhjAeaoKMSgSQ1oo/tBbR0yGrYJEDd62y7ujqWnTkdbL
	2UFXgwULFg9PN7nDmWaT+SKWFo2OF6PyU44WQhowM6qP6SEtH3XtrUmgeM/g+WaCknoqA54IbjQ8A
	3+bsp6dytCli9qrjk4Q4axHWiDUwvHbl7Vp+HklzRgIaCyFnqF4iVme9Cj3hATBphAuO29hiKY7Ms
	U17OpNfciuSXr15s/fDIafC6OAcvYIbgV6SZJ2dkuYFyFxwj/QPdAklaQFGlh43PKBUQl20JjpPrA
	T0LEPlMA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44262 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgmke-0004Fl-1T;
	Thu, 14 Sep 2023 14:51:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgmkf-007Z4f-6i; Thu, 14 Sep 2023 14:51:25 +0100
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
Subject: [PATCH net-next 2/6] net: stmmac: imx: use stmmac_set_tx_clk_gmii()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgmkf-007Z4f-6i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 14:51:25 +0100

Use stmmac_set_tx_clk_gmii().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index df34e34cc14f..cb56f9523acc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -186,7 +186,6 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct imx_priv_data *dwmac = priv;
-	unsigned long rate;
 	int err;
 
 	plat_dat = dwmac->plat_dat;
@@ -196,24 +195,13 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
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
+	err = stmmac_set_tx_clk_gmii(dwmac->clk_tx, speed);
+	if (err == -ENOTSUPP)
+		dev_err(dwmac->dev, "invalid speed %uMbps\n", speed);
+	else if (err)
+		dev_err(dwmac->dev,
+			"failed to set tx rate for speed %uMbps: %pe\n",
+			speed, ERR_PTR(err));
 }
 
 static void imx93_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
-- 
2.30.2


