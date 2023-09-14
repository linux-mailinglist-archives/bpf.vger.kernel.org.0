Return-Path: <bpf+bounces-10021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4C7A0679
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF1281A7A
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754D21A17;
	Thu, 14 Sep 2023 13:51:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D6241F6;
	Thu, 14 Sep 2023 13:51:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EAC1BE3;
	Thu, 14 Sep 2023 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8fReHoJYksbbxqknkvPfNrb5e3cqgf2PgJTyjFj+x+Y=; b=cGroKfB7bVzGWXQukapi2TIE/o
	RKThpImDI0Q543380fqqnxbRYDEgqnUHMPcnksXnsS9TMjL52K2GxtXIquB3dnAsvg5TDQIxNybhB
	pnw0WX3L2/ymrLrPQRDFGCyAgQln0t1eeQEaqt3Z41mefQ6F19LbnVuZWWYXwCLERz7Gg0fi8MPPO
	bkWmsmQwU7vuJw9GtYSBZiWacg6Lw7pEXVilBknwdI2N7bvxA7zig0qmnRQohJWfC5MgGC6RHgcfO
	AQe/Fhb2ARjP5Hs/1XpWe1f6DDZbazamPlwgNVuiblVn1dKKDbdGLuC87bSOFXWez4kwiPH6ATPlr
	b+eDqUNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59538 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgmkZ-0004FZ-15;
	Thu, 14 Sep 2023 14:51:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgmka-007Z4Z-1E; Thu, 14 Sep 2023 14:51:20 +0100
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
Subject: [PATCH net-next 1/6] net: stmmac: add stmmac_set_tx_clk_gmii()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgmka-007Z4Z-1E@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 14:51:20 +0100

Add a helper function for setting the transmit clock for GMII
interfaces. This handles 1G, 100M and 10M using the standard clock
rates of 125MHz, 25MHz and 2.5MHz.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 25 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 0f28795e581c..f7635ed2b255 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -700,6 +700,31 @@ EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 
+int stmmac_set_tx_clk_gmii(struct clk *tx_clk, unsigned int speed)
+{
+	unsigned long rate;
+
+	switch (speed) {
+	case SPEED_1000:
+		rate = 125000000;
+		break;
+
+	case SPEED_100:
+		rate = 25000000;
+		break;
+
+	case SPEED_10:
+		rate = 2500000;
+		break;
+
+	default:
+		return -ENOTSUPP;
+	}
+
+	return clk_set_rate(tx_clk, rate);
+}
+EXPORT_SYMBOL_GPL(stmmac_set_tx_clk_gmii);
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index c5565b2a70ac..8dc2287c6724 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -11,6 +11,7 @@
 
 #include "stmmac.h"
 
+int stmmac_set_tx_clk_gmii(struct clk *tx_clk, unsigned int speed);
 struct plat_stmmacenet_data *
 stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 struct plat_stmmacenet_data *
-- 
2.30.2


