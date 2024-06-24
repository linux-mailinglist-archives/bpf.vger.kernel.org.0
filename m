Return-Path: <bpf+bounces-32911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F2914E96
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485A61C21060
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA1D143892;
	Mon, 24 Jun 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDLUVO3n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F191411D3;
	Mon, 24 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235731; cv=none; b=msvUYWZgeXHHB2lanlETWzjP8I/5ASGW0ES6U0lf1IBCzeLydOAYxRsDjhdW+P4g5FYda7zlmFLFUzwV3fIa9kUcSj5xz/LZLb05MbNxiTQF7wI2xnomSqOXmZHDtncV+8Xq+3fd6iLGQ2DZXWjhOa/IEuLQgwEvDgT00NLfwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235731; c=relaxed/simple;
	bh=X1Ada1ye9iKeUslNrsy74En//UFSuGExAFa9+RyTjPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e59/gkM41SrcO5NcKQXTthYVOXid6Rzmuf63vN1m/z3BwuEBgxVVLNjQAKPZlnE9I0oMz/wUP+e+YWziG3w417U0hs/I5rt4LE1/RcU04MLQ9oRN/yKQbdxl5/RPNdW6L3aKJ4xm3lRFdRE3RPWzghR2lMzyt4tGQ/Y3FICa1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDLUVO3n; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so49188561fa.3;
        Mon, 24 Jun 2024 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235728; x=1719840528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U9L4Yq0u2xGF5ZPArCNKUT73HjSRjPESwAp7waM0I4=;
        b=WDLUVO3nD40Kk84jgSwoMDlxK71O1JoIgk/OFatCeVg95kR/i/lM8A68BC4BTSmLZV
         MgXKWSgq7Fq8ctOGYOKyO8aHVqn69xXXoPPdSsQaoea1TrG8l8lStzYnBN2R4T/UUR2T
         ebOnKVjWr33JBTP4QhRFTIgA9D5zgvNu1DQ7cpq2U96AecN0sMQR5DmIVwtf/zW9iV2w
         RUXaHjmP8uZgpYkH5BbNFKuz1nf57t6Gp7p9BteS55Q38h4We8Thzv6FWjhRe0OBu2h0
         92sY/bI4MMVu5dWEbF89FtEkxsJbNKGPRUjbHIvcWD74X0lQylKxGKlxSMyYq0FT67cB
         IvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235728; x=1719840528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U9L4Yq0u2xGF5ZPArCNKUT73HjSRjPESwAp7waM0I4=;
        b=a7SqP8qhMES7UEA0uxcnANsWDQ5wQSCN7jMQ0wSPuxIJ9MrCOh71rGZYVnC3pb/oIY
         2lQuxAPrCmiKHOPj9QonLmfN7ZnHonqnhZa4FxHE7EcuBqtp0B+Y0HPD6AyhDhte1z54
         mr4O+mGKE/5IqDRm5rAXP3NtDu7OTxmFH4QIrNQv27lPXt6tf3GGTWw75tpD0JYe/mHF
         +EQqhBwZ5xj625gyT9TNoHTb6WuCIEf64NTI+DYfX2ZG5Z+9KKGEZHDwS+HCTM4/jZsG
         HQjer80zIsToZCG0MOIXtI8OVUymCkkI4NSEHQ+Airt15nGYvIcxTO4vIG9DUhDC7WN8
         kqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsKCoICH2v8y5/BKq+QsdR2OF7hfnWS45yAUr1g4JtWZYVlMO+Fm+vh8DSB9LSklq1I/I+euEjYU6HRELpsCTcYMnYLliV97guc5Shu3gqR5bNUrtpnczC/hIvktofSjQy93QaqD0/tJSKTO7mlEAtZEcqRMXC/8lh
X-Gm-Message-State: AOJu0YwgWWHtCGIAIHM9Rwz2BKOTia+mMjq9lfi+Y75xjg6o7FQozP9x
	+b1RwVfVRozKmdYbrWr+PPp4QdQnKemm6eqpgbdWmrXhrZxlP3dI
X-Google-Smtp-Source: AGHT+IHaRb4z8zCJyi0+00brLpXIArmVXMkb2V0LJo/l5CAtSvnDvFz1BfQxWmUL7peMQYPsZ68IVA==
X-Received: by 2002:a2e:3518:0:b0:2ec:3e02:972a with SMTP id 38308e7fff4ca-2ec5b3180d8mr24914191fa.11.1719235727509;
        Mon, 24 Jun 2024 06:28:47 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec6563c8a2sm1055351fa.9.2024.06.24.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:47 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 16/17] net: stmmac: Move internal PCS init method to stmmac_pcs.c
Date: Mon, 24 Jun 2024 16:26:33 +0300
Message-ID: <20240624132802.14238-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the internal PCS initialization procedure is split up into
several functions and special flags:

1. stmmac_check_pcs_mode() - determine the internal PCS based on the
specified interface and init the mac_device_info::pcs field with the
respective flag (STMMAC_PCS_RGMII or STMMAC_PCS_SGMII);

2. stmmac_ops::phylink_select_pcs() - callback specific for the DW GMAC
and DW QoS Eth IP-cores which returns the pointer to the phylink_pcs
structure if any of the STMMAC_PCS_RGMII or STMMAC_PCS_SGMII flag is found
in the mac_device_info::pcs field.

The initialization procedure described above can be simplified by
converting the stmmac_check_pcs_mode() to the PCS-init method defined in
stmmac_pcs.c, which besides would take the STMMAC_FLAG_HAS_INTEGRATED_PCS
flag into account. Seeing the RGMII and SGMII MAC-interfaces can be only
found on the DW GMAC and DW QoS Eth, the stmmac_ops::phylink_select_pcs()
callbacks content can be freely moved right into the generic
phylink_mac_ops::mac_select_pcs() function.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

The change looks very promising and greatly simplifying the internal PCS
initialization procedure by providing a single coherent method activating
the internal PCS capability based on the requested interface and the
detected DW MAC HW-capability.
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 16 +------------
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 17 +------------
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 15 ++----------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 ++++---------------
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  3 +++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 15 ++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  |  2 ++
 7 files changed, 28 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 2d77ffd16f0a..2fbb853cc19c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
-#include <linux/phylink.h>
+
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
@@ -388,17 +388,6 @@ static u16 dwmac1000_pcs_get_config_reg(struct mac_device_info *hw)
 	return FIELD_GET(GMAC_RGSMIIIS_CONFIG_REG, val);
 }
 
-static struct phylink_pcs *
-dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
-			     phy_interface_t interface)
-{
-	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
-	    priv->hw->pcs & STMMAC_PCS_SGMII)
-		return &priv->hw->mac_pcs;
-
-	return NULL;
-}
-
 static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    struct stmmac_extra_stats *x,
 			    u32 rx_queues, u32 tx_queues)
@@ -489,7 +478,6 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
 
 const struct stmmac_ops dwmac1000_ops = {
 	.core_init = dwmac1000_core_init,
-	.phylink_select_pcs = dwmac1000_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac1000_rx_ipc_enable,
 	.dump_regs = dwmac1000_dump_regs,
@@ -541,7 +529,5 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
-	mac->mac_pcs.neg_mode = true;
-
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index c58dc20eddeb..f5449f0962ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
-#include <linux/phylink.h>
+
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
@@ -780,16 +780,6 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	}
 }
 
-static struct phylink_pcs *
-dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
-{
-	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
-	    priv->hw->pcs & STMMAC_PCS_SGMII)
-		return &priv->hw->mac_pcs;
-
-	return NULL;
-}
-
 static int dwmac4_irq_mtl_status(struct stmmac_priv *priv,
 				 struct mac_device_info *hw, u32 chan)
 {
@@ -1178,7 +1168,6 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
-	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1224,7 +1213,6 @@ const struct stmmac_ops dwmac4_ops = {
 const struct stmmac_ops dwmac410_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
-	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1274,7 +1262,6 @@ const struct stmmac_ops dwmac410_ops = {
 const struct stmmac_ops dwmac510_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
-	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1389,7 +1376,5 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
 
-	mac->mac_pcs.neg_mode = true;
-
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 3d39417e906d..4bacfe8a18e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -18,17 +18,13 @@
 	} \
 	__result; \
 })
-#define stmmac_do_typed_callback(__type, __fail_ret, __priv, __module, \
-				 __cname,  __arg0, __args...) \
+#define stmmac_do_callback(__priv, __module, __cname,  __arg0, __args...) \
 ({ \
-	__type __result = __fail_ret; \
+	int __result = -EINVAL; \
 	if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) \
 		__result = (__priv)->hw->__module->__cname((__arg0), ##__args); \
 	__result; \
 })
-#define stmmac_do_callback(__priv, __module, __cname,  __arg0, __args...) \
-	stmmac_do_typed_callback(int, -EINVAL, __priv, __module, __cname, \
-				 __arg0, ##__args)
 
 struct stmmac_extra_stats;
 struct stmmac_priv;
@@ -315,9 +311,6 @@ struct stmmac_ops {
 	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
 	/* Update MAC capabilities */
 	void (*update_caps)(struct stmmac_priv *priv);
-	/* Get phylink PCS (for MAC */
-	struct phylink_pcs *(*phylink_select_pcs)(struct stmmac_priv *priv,
-						  phy_interface_t interface);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -439,10 +432,6 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, core_init, __args)
 #define stmmac_mac_update_caps(__priv) \
 	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
-#define stmmac_mac_phylink_select_pcs(__priv, __interface) \
-	stmmac_do_typed_callback(struct phylink_pcs *, ERR_PTR(-EOPNOTSUPP), \
-				 __priv, mac, phylink_select_pcs, __priv,\
-				 __interface)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 72c2d3e2c121..743d356f6d12 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -950,13 +950,16 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
+	if (priv->hw->pcs)
+		return &priv->hw->mac_pcs;
+
 	if (priv->hw->xpcs)
 		return &priv->hw->xpcs->pcs;
 
 	if (priv->hw->phylink_pcs)
 		return priv->hw->phylink_pcs;
 
-	return stmmac_mac_phylink_select_pcs(priv, interface);
+	return NULL;
 }
 
 static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
@@ -1121,23 +1124,6 @@ static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_link_up = stmmac_mac_link_up,
 };
 
-/**
- * stmmac_check_pcs_mode - verify if RGMII/SGMII is supported
- * @priv: driver private structure
- * Description: this is to verify if the HW supports the PCS.
- * Physical Coding Sublayer (PCS) interface that can be used when the MAC is
- * configured for the TBI, RTBI, or SGMII PHY interface.
- */
-static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
-{
-	int interface = priv->plat->mac_interface;
-
-	if (phy_interface_mode_is_rgmii(interface))
-		priv->hw->pcs = STMMAC_PCS_RGMII;
-	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
-		priv->hw->pcs = STMMAC_PCS_SGMII;
-}
-
 /**
  * stmmac_init_phy - PHY initialization
  * @dev: net device structure
@@ -7704,8 +7690,6 @@ int stmmac_dvr_probe(struct device *device,
 	else
 		stmmac_clk_csr_set(priv);
 
-	stmmac_check_pcs_mode(priv);
-
 	pm_runtime_get_noresume(device);
 	pm_runtime_set_active(device);
 	if (!pm_runtime_enabled(device))
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index aa43117134d3..985b4b8c021f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -22,6 +22,7 @@
 
 #include "dwxgmac2.h"
 #include "stmmac.h"
+#include "stmmac_pcs.h"
 
 #define MII_BUSY 0x00000001
 #define MII_WRITE 0x00000002
@@ -505,6 +506,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
 
+	dwmac_pcs_init(priv->hw);
+
 	if (priv->plat->pcs_init) {
 		ret = priv->plat->pcs_init(priv);
 	} else if (priv->plat->mdio_bus_data &&
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index aac49f6472f0..fdfc95299f89 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -167,3 +167,18 @@ void dwmac_pcs_isr(struct mac_device_info *hw, unsigned int intr_status,
 	if (an_status || sr_status)
 		phylink_pcs_change(&hw->mac_pcs, false);
 }
+
+void dwmac_pcs_init(struct mac_device_info *hw)
+{
+	struct stmmac_priv *priv = hw->priv;
+	int interface = priv->plat->mac_interface;
+
+	if (priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)
+		return;
+	else if (phy_interface_mode_is_rgmii(interface))
+		hw->pcs = STMMAC_PCS_RGMII;
+	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
+		hw->pcs = STMMAC_PCS_SGMII;
+
+	hw->mac_pcs.neg_mode = true;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 6e364285a4ef..a17e5b37c411 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -61,4 +61,6 @@
 void dwmac_pcs_isr(struct mac_device_info *hw, unsigned int intr_status,
 		   struct stmmac_extra_stats *x);
 
+void dwmac_pcs_init(struct mac_device_info *hw);
+
 #endif /* __STMMAC_PCS_H__ */
-- 
2.43.0


