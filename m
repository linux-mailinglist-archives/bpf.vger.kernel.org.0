Return-Path: <bpf+bounces-9651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DFA79A9B7
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5248D281151
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D758125CB;
	Mon, 11 Sep 2023 15:28:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA011739;
	Mon, 11 Sep 2023 15:28:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17709F2;
	Mon, 11 Sep 2023 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xxAFmOFPowfCTWnGhmAR1kdsvUwVwDMZvbxX5Uff/dU=; b=eIPOXqcFyI5TyK6jXBjbR+q/bB
	+Yq4ylRiCzg7JFuBzoo0H+AAWYrLg1uR8jS/wZsUvirsyZOvvGzU6+GxgXoEmT16vg4CIZuOxle02
	oasmcnPKtXnNCvGyg9kir4eJ1Ll8/Rju/KZjphrp123Ne0HAMuBMVHLvh+lj8PwBhkeNy93zYhtmt
	QPI3fH2mHWNpvodJ4K8wbzrZdAw3FTOfqH63B2z20NQ/A4RD9tuhp3OeToKpqcpHmbIR8OG/hh93k
	jZAXclKzAe5rf5LP+Okwu206Lbk3jT+mmfFMQDaMJJ3j3RkZyFn5xviNHuT9+/52EhJ0OdJgAwXXc
	r9LD3XxQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56338 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qfiqH-0008CF-2r;
	Mon, 11 Sep 2023 16:28:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qfiqI-007TOr-I5; Mon, 11 Sep 2023 16:28:50 +0100
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
Message-Id: <E1qfiqI-007TOr-I5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Sep 2023 16:28:50 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-intel-plat.c         | 35 +++++--------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d352a14f9d48..8cc22f11072e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -14,6 +14,7 @@
 #include "dwmac4.h"
 #include "stmmac.h"
 #include "stmmac_platform.h"
+#include "stmmac_plat_lib.h"
 
 struct intel_dwmac {
 	struct device *dev;
@@ -31,32 +32,14 @@ struct intel_dwmac_data {
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
+	err = dwmac_set_tx_clk_gmii(dwmac->tx_clk, speed);
+	if (err == -ENOTSUPP)
+		dev_err(dwmac->dev, "invalid speed %dMbps\n", speed);
+	else if (err)
+		dev_err(dwmac->dev, "failed to set tx rate for speed %dMbps: %pe\n",
+			speed, ERR_PTR(err));
 }
 
 static const struct intel_dwmac_data kmb_data = {
-- 
2.30.2


