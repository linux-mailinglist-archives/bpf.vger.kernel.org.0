Return-Path: <bpf+bounces-9649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460879A9A7
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2391C208E5
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621411C89;
	Mon, 11 Sep 2023 15:28:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACD1170E;
	Mon, 11 Sep 2023 15:28:46 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75789E4;
	Mon, 11 Sep 2023 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P6DsgJ0EF8GDgyic7GQZdDjnAhVZ69mVqqsinIQxsnI=; b=xZu3Ajjq2TSvy0DyIJCfkWSo3k
	7br7UoFE1XZmxm0LZPslxVl5WlKtO0zNzP8jZUZn4Jefzkq3tqRdEM3PpdZu1+SAuegInzBDn5/k3
	7BUf2CFw9jyeSA8B88ekRLYE81o94jBtRcEkiM8rvUA5CwDrXBNS9vJ0QNwHFK6SqBM35GtTDPlW3
	t1oiqyAHxta6r1R41wrx/OaqBetCbZJz3VVS1vQ4Z71jCVNokwNI2qQPImYz2+59N6Yla55ST+0zm
	yFhg6D8WE2nUMcNzufxbPZhl5dcwbfg3iMXn/DldsWreh2uFhJf1pte5RrR3lXzS2swfMsAT0kgac
	HHpFES6Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57004 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qfiq7-0008Bi-1y;
	Mon, 11 Sep 2023 16:28:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qfiq8-007TOe-9F; Mon, 11 Sep 2023 16:28:40 +0100
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
Subject: [PATCH net-next 1/6] net: stmmac: add platform library
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Sep 2023 16:28:40 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a platform library of helper functions for common traits in the
platform drivers. Currently, this is setting the tx clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 5b57aee19267..ba2cbfa0c9d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o \
+	      stmmac_xdp.o stmmac_plat_lib.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
new file mode 100644
index 000000000000..abb9f512bb0e
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
@@ -0,0 +1,29 @@
+#include <linux/stmmac.h>
+#include <linux/clk.h>
+
+#include "stmmac_plat_lib.h"
+
+int dwmac_set_tx_clk_gmii(struct clk *tx_clk, int speed)
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
+EXPORT_SYMBOL_GPL(dwmac_set_tx_clk_gmii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.h
new file mode 100644
index 000000000000..926fdce379b3
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.h
@@ -0,0 +1,8 @@
+#ifndef STMMAC_PLAT_LIB_H
+#define STMMAC_PLAT_LIB_H
+
+struct clk;
+
+int dwmac_set_tx_clk_gmii(struct clk *tx_clk, int speed);
+
+#endif
-- 
2.30.2


