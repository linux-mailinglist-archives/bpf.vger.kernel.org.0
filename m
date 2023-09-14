Return-Path: <bpf+bounces-10023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C237A068A
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670BD2810F7
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655022F0C;
	Thu, 14 Sep 2023 13:51:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309922EF0;
	Thu, 14 Sep 2023 13:51:33 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDDA1AE;
	Thu, 14 Sep 2023 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DhArgv95jqcFUTmgufM+4MILeoaknnMkgqhkyROEjtk=; b=MwadJQzn6QxRzlXbIa9qLC3A61
	8bUsqbfYuVkcIe8BP4Lqmh74fDO6DsUWhA+GNJYM46EXjXeuOcuMeWFjhako49FJBBnk4FbMpC+WE
	XfVstYhzBZPGJRo6jfICGS29VAOu4j4XioEMp1YzivcITaXALvGDFdJYEEbdS3/ugf4WXwYtpBSDN
	cKs4zLu9Xpul6uQRMnum3P6WNrEyRg/1Cm/y8NADDknsu3SgcDkSB2Iz9THyNDnXA0ZdVj6PPu5gJ
	hBBdNw/AJCrf6AIqqgHG1Xdyuipu1owbJDKZqCT5a4t3Ww/iuGk8PnGaZX1xdryOotI40hsM/BFq6
	SudPpvVQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44274 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgmkj-0004G7-1u;
	Thu, 14 Sep 2023 14:51:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgmkk-007Z4l-BK; Thu, 14 Sep 2023 14:51:30 +0100
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
Subject: [PATCH net-next 3/6] net: stmmac: intel-plat: use
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
Message-Id: <E1qgmkk-007Z4l-BK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 14:51:30 +0100

Use stmmac_set_tx_clk_gmii().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-intel-plat.c         | 34 +++++--------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d352a14f9d48..c6ebd1d91f38 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -31,32 +31,14 @@ struct intel_dwmac_data {
 static void kmb_eth_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct intel_dwmac *dwmac = priv;
-	unsigned long rate;
-	int ret;
-
-	rate = clk_get_rate(dwmac->tx_clk);
-
-	switch (speed) {
-	case SPEED_1000:
-		rate = 125000000;
-		break;
-
-	case SPEED_100:
-		rate = 25000000;
-		break;
-
-	case SPEED_10:
-		rate = 2500000;
-		break;
-
-	default:
-		dev_err(dwmac->dev, "Invalid speed\n");
-		break;
-	}
-
-	ret = clk_set_rate(dwmac->tx_clk, rate);
-	if (ret)
-		dev_err(dwmac->dev, "Failed to configure tx clock rate\n");
+	int err;
+
+	err = stmmac_set_tx_clk_gmii(dwmac->tx_clk, speed);
+	if (err == -ENOTSUPP)
+		dev_err(dwmac->dev, "invalid speed %uMbps\n", speed);
+	else if (err)
+		dev_err(dwmac->dev, "failed to set tx rate for speed %uMbps: %pe\n",
+			speed, ERR_PTR(err));
 }
 
 static const struct intel_dwmac_data kmb_data = {
-- 
2.30.2


