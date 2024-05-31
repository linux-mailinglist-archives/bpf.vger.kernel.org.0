Return-Path: <bpf+bounces-31020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655F8D60A5
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFBDB23774
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB015747B;
	Fri, 31 May 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FcF+3s6u"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A855894;
	Fri, 31 May 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154796; cv=none; b=G+CJpauY6fnNZeSTkpdE736e5lGJMUuh2hSpD2eFV4Xvwt18bvSUSPvUmc/DErbNTtvmlteSNDLFwGyUfyjdPgap/+iizQFAHAsOTAQhipf70WblaG5ivPPiQCReeOBu1uRLjrTNpsXNL54YnSSlGQ2FmQ1eYr+m0u6AGcUj7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154796; c=relaxed/simple;
	bh=z3Aby6ZKEWo2K9dTSR/iu2+D892ulX4324Qd+67ZMM8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SvhIJiHNDrvvRQloeEZAIgPWZnur5MwCHhatZj2a4IUsDtyyEgaDXUdQM8BQAruxnybUZBcDe4mp+gVx82P2js/j65nTUMySiL31wb94nPbU4iuZ6NOOwrPJWwW1s8elHn6FgxYNTaNJyg7ehhAm9saTz2ji1G3xYvT/iTSoI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FcF+3s6u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jj7AcYEJSvX8DA6Efl2MBL0SU/0tAK+cClfs48CxxHo=; b=FcF+3s6ukj7zNSKLyCLVdDN5Tw
	AIzF6t+uVVlGf4UDE2zFMI+FacTEu7JeR2lUrjFeIYZXm+61Dec5MXncFX3KUnyPQD11dp+LAYc+2
	iuDX+NSu77AXY22P7m9U3GJcjTVf7V2En5q3+Sw6yYuVxpVD1vLixLc7fp387MpXrAsOe/U7Qc/FL
	tDQXC4E7M7HIH8RQyFvqueBQ8iAycuSXS+F+ugKea+8nFPsCROzKcJmH4rq95CkXqlQul0kq9Qw/I
	lLEDQFpSDgPZBVcBZXy/o7kXirsjspv83WsKCBpU1UiZ2eaBdk3UAR8SVhmHDR3bQu4xwjkC0tkp1
	bfFjP44w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59324 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sD0On-0008RU-1m;
	Fri, 31 May 2024 12:26:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sD0Oq-00EzBo-7r; Fri, 31 May 2024 12:26:20 +0100
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC net-next v2 2/8] net: stmmac: provide core phylink PCS
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
Message-Id: <E1sD0Oq-00EzBo-7r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 12:26:20 +0100

There are some common operations shared between the dwmac hwifs, the
only difference is where they are located within the device. These
are already present in the form of dwmac_rane(), dwmac_ctrl_ane() and
dwmac_get_adv_lp(). Rather than use these (which don't quite fit with
phylink PCS, provide phylink PCS specific versions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 58 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 10 ++++
 3 files changed, 69 insertions(+), 1 deletion(-)
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
index 000000000000..849e6f121505
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -0,0 +1,58 @@
+#include "common.h"
+#include "stmmac_pcs.h"
+
+int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
+		     phy_interface_t interface,
+		     const unsigned long *advertising,
+		     unsigned int reg_base)
+{
+	u32 val;
+
+	val = readl(hw->pcsr + GMAC_AN_CTRL(reg_base));
+
+	val |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+
+	if (hw->ps)
+		val |= GMAC_AN_CTRL_SGMRAL;
+
+	writel(val, hw->pcsr + GMAC_AN_CTRL(reg_base));
+
+	return 0;
+}
+
+void dwmac_pcs_get_state(struct mac_device_info *hw,
+			 struct phylink_link_state *state,
+			 unsigned int reg_base)
+{
+	u32 val;
+
+	val = readl(hw->pcsr + GMAC_ANE_LPA(reg_base));
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+			 state->lp_advertising);
+
+	if (val & GMAC_ANE_FD) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+				 state->lp_advertising);
+	}
+
+	if (val & GMAC_ANE_HD) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+				 state->lp_advertising);
+	}
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+			 state->lp_advertising,
+			 FIELD_GET(GMAC_ANE_PSE, val) & STMMAC_PCS_PAUSE);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+			 state->lp_advertising,
+			 FIELD_GET(GMAC_ANE_PSE, val) & STMMAC_PCS_ASYM_PAUSE);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 1bdf87b237c4..888485fa2761 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -137,4 +137,14 @@ static inline void dwmac_get_adv_lp(void __iomem *ioaddr, u32 reg,
 
 	adv_lp->lp_pause = (value & GMAC_ANE_PSE) >> GMAC_ANE_PSE_SHIFT;
 }
+
+int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
+		     phy_interface_t interface,
+		     const unsigned long *advertising,
+		     unsigned int reg_base);
+
+void dwmac_pcs_get_state(struct mac_device_info *hw,
+			 struct phylink_link_state *state,
+			 unsigned int reg_base);
+
 #endif /* __STMMAC_PCS_H__ */
-- 
2.30.2


