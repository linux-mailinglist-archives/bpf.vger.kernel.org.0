Return-Path: <bpf+bounces-36378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F949479B4
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2A028130B
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB915689A;
	Mon,  5 Aug 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EW2Afmui"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED014B947;
	Mon,  5 Aug 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853513; cv=none; b=brjaZ6uxRaiOmWyYRbzH7Gn5zC2OX+tku4wzIXz2PnyFXe4mJa2a1BhOXj1prWkUJW6v5Z35tQswNjY70An4fz1iTYplyuILrVkzt4m3/Da9czyJ/G8WZNZmHavhWoiXGg8Vpog/vcIPkifDyy7M06G0m483E5K/eLMCR12o1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853513; c=relaxed/simple;
	bh=nG/Bu0qNgThvf6E59RPlDUKB47Hmbg5UAaNMgW7a1zc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rUGx0R7P+KhmjZGvCmZAblGw8Nhh8u5Yd3Ee4z7xhJGO28p4g9708PjhJvQyFlgAPl+s8qaNoHz9n3PgDSemK8SRURLtFyM0NQRqxigOo5b87+Js1KmLieYgTHa95B3cifvsqM3dfQ5DeInNgfZRj2EVr69Mqr94mVJZ28DJCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EW2Afmui; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AasczkNb11bsNmuV1kDQTIcXsK7ueDkdZx5V2wjlYDk=; b=EW2AfmuiMFl735R87cOWrWzVQo
	Iz8+UEKxS9Ju5H0OGygyMA55eOK3ccUIFVAeoJVA0cMuFcEDuLTJKhE0TzAJwhjUAeDR5U71Euvnw
	80f2jWj3WYolVHaDY18jxME4iV5uNM1wfjytXgiFBH6CA2VKoVL6mk2z5P6EQt0opHfbfUmFyxYid
	8o/2UkhZZXIqENTyj7r/vYTkXgAU4v5EtN+ifWm0A9JmgOp7RzJeEHnRJ3I9fxnxs+CCtnFnsh6Al
	3O0GJ3EhTUdtKlpH+7RTcxFZSWb4TVlfRIxYoYgVrlnL23W4YBLO0z3IPDPSEwzQzWTSgzWQUU+E+
	AYMLoO6Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55592 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1saute-0002c5-1Y;
	Mon, 05 Aug 2024 11:24:58 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sauti-000tv6-42; Mon, 05 Aug 2024 11:25:02 +0100
In-Reply-To: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sneh Shah <quic_snehshah@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH RFC net-next v4 05/14] net: stmmac: provide core phylink PCS
 infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sauti-000tv6-42@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:02 +0100

There are some common operations shared between the dwmac hwifs, the
only difference is where they are located within the device. These
are already present in the form of dwmac_rane() and dwmac_ctrl_ane().
Rather than use these (which don't quite fit with phylink PCS, provide
phylink PCS specific versions. Also provide an implementation to parse
the RSGMII status register.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 47 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 50 +++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..9e15f7615ff4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_pcs.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
new file mode 100644
index 000000000000..292c039c9778
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "stmmac.h"
+#include "stmmac_pcs.h"
+
+static void __dwmac_ctrl_ane(struct stmmac_pcs *spcs, bool ane, bool srgmi_ral,
+			     bool loopback)
+
+{
+	u32 val;
+
+	val = readl(spcs->pcs_base + GMAC_AN_CTRL(0));
+
+	/* Enable and restart the Auto-Negotiation */
+	if (ane)
+		val |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+	else
+		val &= ~GMAC_AN_CTRL_ANE;
+
+	/* In case of MAC-2-MAC connection, block is configured to operate
+	 * according to MAC conf register.
+	 */
+	if (srgmi_ral)
+		val |= GMAC_AN_CTRL_SGMRAL;
+
+	if (loopback)
+		val |= GMAC_AN_CTRL_ELE;
+	else
+		val &= ~GMAC_AN_CTRL_ELE;
+
+	writel(val, spcs->pcs_base + GMAC_AN_CTRL(0));
+}
+
+int dwmac_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+		     phy_interface_t interface,
+		     const unsigned long *advertising,
+		     bool permit_pause_to_mac)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+
+	/* The RGMII interface does not have the GMAC_AN_CTRL register */
+	if (phy_interface_mode_is_rgmii(spcs->priv->plat->mac_interface))
+		return 0;
+
+	__dwmac_ctrl_ane(spcs, true, spcs->priv->hw->ps, false);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 4a684c97dfae..f0d6442711ff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -46,6 +46,19 @@
 #define GMAC_ANE_RFE_SHIFT	12
 #define GMAC_ANE_ACK		BIT(14)
 
+/* MAC specific status - for RGMII and SGMII. These appear as
+ * GMAC_RGSMIIIS[15:0] and GMAC_PHYIF_CONTROL_STATUS[31:16]
+ */
+#define GMAC_RS_STAT_LNKMOD		BIT(0)
+#define GMAC_RS_STAT_SPEED		GENMASK(2, 1)
+#define GMAC_RS_STAT_LNKSTS		BIT(3)
+#define GMAC_RS_STAT_JABTO		BIT(4)
+#define GMAC_RS_STAT_FALSECARDET	BIT(5)
+
+#define GMAC_RS_STAT_SPEED_125		2
+#define GMAC_RS_STAT_SPEED_25		1
+#define GMAC_RS_STAT_SPEED_2_5		0
+
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
  * @ioaddr: IO registers pointer
@@ -109,4 +122,41 @@ static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
 
 	writel(value, ioaddr + GMAC_AN_CTRL(reg));
 }
+
+static inline bool dwmac_rs_decode_stat(struct phylink_link_state *state,
+					uint16_t rs_stat)
+{
+	unsigned int speed;
+
+	state->link = !!(rs_stat & GMAC_RS_STAT_LNKSTS);
+	if (!state->link)
+		return false;
+
+	speed = FIELD_GET(GMAC_RS_STAT_SPEED, rs_stat);
+	switch (speed) {
+	case GMAC_RS_STAT_SPEED_125:
+		state->speed = SPEED_1000;
+		break;
+	case GMAC_RS_STAT_SPEED_25:
+		state->speed = SPEED_100;
+		break;
+	case GMAC_RS_STAT_SPEED_2_5:
+		state->speed = SPEED_10;
+		break;
+	default:
+		state->link = false;
+		return false;
+	}
+
+	state->duplex = rs_stat & GMAC_RS_STAT_LNKMOD ?
+			DUPLEX_FULL : DUPLEX_HALF;
+
+	return true;
+}
+
+int dwmac_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+		     phy_interface_t interface,
+		     const unsigned long *advertising,
+		     bool permit_pause_to_mac);
+
 #endif /* __STMMAC_PCS_H__ */
-- 
2.30.2


