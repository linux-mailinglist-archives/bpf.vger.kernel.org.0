Return-Path: <bpf+bounces-32909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C280914E90
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0981C21E62
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5831A1428F9;
	Mon, 24 Jun 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho+6YDFy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9211142621;
	Mon, 24 Jun 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235726; cv=none; b=rVDHGCcO+41Qdoal69ZulzljyjTpAKDOsJbt0013OkHHatSF9jFbxlxphPjoStHNtKfHTO+BY//UTC0/Gwm9URMT2qVF/wgsBJ2W0EBwKbkbTh9+dDhbrDge1RyXRU+5bOjvf/c+xIjJNqvpAOh+Iv7GXrjxiJ3KuSTSmEpe8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235726; c=relaxed/simple;
	bh=ym+4Y7Ib1Bp26UCwCyfmGDHf+s9FRlXIxWhUXBMvrPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmsDC651+WhCxCBuGNoKURo/yWJWhjJfMEAknet4m8QiecdbJxn9JM0qxQ89QDNsqGbZmWC/BQWAe+goJHoMRYU+KIpTK/qkK0VuVmgGlxEhCTbkuNKJA6QZcG4D57KJXXKuKqDzGDdYaMDG+61fJUgiCU0NZ2Gxir5HMhDVuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho+6YDFy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso38156031fa.0;
        Mon, 24 Jun 2024 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235723; x=1719840523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJoJKZg8DGaUrEn+jqEV7Z916g2ud2UaUPgX3w+6oi0=;
        b=Ho+6YDFydmB120QYAz5GgPtCaXdnmR4m4xKuS/IVBluI6l3+D8SghqpslpkfGr7Ott
         DTrKduZaYxQLGwkkLhKy4yLRwkF0qfCk4hCrE1KUUaE3j+rjDbuNGV8n+LXdzo3Pi9/D
         IbabACdGpUfTX4zSRhs/fHFHc4iDA4TL3jcT3Ccl9gBE6G1TOLegWXfR/L8nPk1jz1tE
         1//zVN3c3hKG+2qstjPyIad1CzwqiHPVQwB084Of8VM4e/rQZGx5XMESYiI4J4qzA5i9
         2p5OC6BE7kJOAjbEo3tBL8m/HjriLexUiKyEHl0sZdW8VNccyYTm16ji8atoX9V5jomC
         SH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235723; x=1719840523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJoJKZg8DGaUrEn+jqEV7Z916g2ud2UaUPgX3w+6oi0=;
        b=Ki+elq9drf/v9RLTYhif2nq8j0M7Zl6EJU4Z6pepJuwC4qAvJu+s1QH/ckxshX8v3M
         csWpflv1BBFc4egENb+CqLnb5mkbfZXPlPJVoLtSZc+nRFUQociV3OWTzFbAntCuWAFT
         4kn0kgoCt5b1lfCeFr2H4wdGIGMYBlj8ieDownfRoxEyZo35gh2eLH36eAtQRfz70UPd
         /CPR/Mo8i1AGDNZBS1MXTvol6+sPhTa6eLFvrtDP+CGjR+WBfrFMABnv2O2Mgb01i/S2
         U/CNONsx9dnCJIJA7XR6kqIK6el7wuzw6HWEO9tdEqki/ve9qRblD7rkxLWbYSs0R2TD
         63gA==
X-Forwarded-Encrypted: i=1; AJvYcCWbVWVWfzRlQKW5FB/Q2dhMVUNLVkk05ojdrso5thE7IDyp7sB6kuKJaMSXumAcNfMYK5dQ7lgYo9AFK3Ja6QU9roUbYCe07ddjYiPRNNBHittO96DFW4pLFFG1XxH9KscUeIbKaXVE4Mf9+IzlMLOSqv8YzSY8Wsqd
X-Gm-Message-State: AOJu0YwLAFUqcxNMmyqhx8mPOlayO1dfMZACzQ91nTPO/pFwgfum73hF
	LlCNsb2LmJ2PojZ5mCN6EAVc6kABPsuRKaGC75Iu55LpL/uEggcm
X-Google-Smtp-Source: AGHT+IFkIfRbp+aHOp0QJLguwUS6UijGlNN4urIEqL5oFVzo2oSq28oQIZx1BDU3sm9HOV8ePIuJXA==
X-Received: by 2002:a05:651c:10e:b0:2ec:4f0f:d93d with SMTP id 38308e7fff4ca-2ec56a6a72cmr15464891fa.5.1719235722742;
        Mon, 24 Jun 2024 06:28:42 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d600c1bsm9632101fa.8.2024.06.24.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:42 -0700 (PDT)
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
Subject: [PATCH RFC net-next v2 14/17] net: stmmac: Move internal PCS PHYLINK ops to stmmac_pcs.c
Date: Mon, 24 Jun 2024 16:26:31 +0300
Message-ID: <20240624132802.14238-6-fancer.lancer@gmail.com>
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

The PCS-related code is now ready to be consolidated in the PCS-specific
module. Let's move the PHYLINK PCS operations implementation to the
stmmac_pcs.c file. No semantics has changed. The same functionality has
been re-implemented in stammac_pcs.c by using the generic link status
register macros and the phylink_pcs_ops instance has been populated with
the new callbacks.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note the code has been equipped with some TODO-notes to think about on the
RFC review stage.
---
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 12 ---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 74 ----------------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  | 12 ---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 80 -----------------
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 86 +++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 17 ++--
 7 files changed, 91 insertions(+), 191 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index f3a95d27298c..94be66e794be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -87,19 +87,7 @@ enum power_event {
 
 /* SGMII/RGMII status register */
 #define GMAC_RGSMIIIS_CONFIG_REG	GENMASK(15, 0)
-#define GMAC_RGSMIIIS_LNKMODE		BIT(0)
-#define GMAC_RGSMIIIS_SPEED		GENMASK(2, 1)
-#define GMAC_RGSMIIIS_SPEED_SHIFT	1
-#define GMAC_RGSMIIIS_LNKSTS		BIT(3)
-#define GMAC_RGSMIIIS_JABTO		BIT(4)
-#define GMAC_RGSMIIIS_FALSECARDET	BIT(5)
 #define GMAC_RGSMIIIS_SMIDRXS		BIT(16)
-/* LNKMOD */
-#define GMAC_RGSMIIIS_LNKMOD_MASK	0x1
-/* LNKSPEED */
-#define GMAC_RGSMIIIS_SPEED_125		0x2
-#define GMAC_RGSMIIIS_SPEED_25		0x1
-#define GMAC_RGSMIIIS_SPEED_2_5		0x0
 
 /* GMAC Configuration defines */
 #define GMAC_CONTROL_2K 0x08000000	/* IEEE 802.3as 2K packets */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 9511ea753da7..332018ecd624 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -395,79 +395,6 @@ static u16 dwmac1000_pcs_get_config_reg(struct mac_device_info *hw)
 	return FIELD_GET(GMAC_RGSMIIIS_CONFIG_REG, val);
 }
 
-static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
-				      unsigned long *supported,
-				      const struct phylink_link_state *state)
-{
-	/* Only support in-band */
-	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int dwmac1000_mii_pcs_enable(struct phylink_pcs *pcs)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-
-	dwmac1000_pcs_enable_irq(hw);
-
-	return 0;
-}
-
-static void dwmac1000_mii_pcs_disable(struct phylink_pcs *pcs)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-
-	dwmac1000_pcs_disable_irq(hw);
-}
-
-static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
-				    unsigned int neg_mode,
-				    phy_interface_t interface,
-				    const unsigned long *advertising,
-				    bool permit_pause_to_mac)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-
-	return dwmac_pcs_config(hw, neg_mode, advertising, advertising);
-}
-
-static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
-					struct phylink_link_state *state)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-	unsigned int spd_clk;
-	u32 status;
-
-	status = readl(hw->pcsr + GMAC_RGSMIIIS);
-
-	state->link = status & GMAC_RGSMIIIS_LNKSTS;
-	if (!state->link)
-		return;
-
-	spd_clk = FIELD_GET(GMAC_RGSMIIIS_SPEED, status);
-	if (spd_clk == GMAC_RGSMIIIS_SPEED_125)
-		state->speed = SPEED_1000;
-	else if (spd_clk == GMAC_RGSMIIIS_SPEED_25)
-		state->speed = SPEED_100;
-	else if (spd_clk == GMAC_RGSMIIIS_SPEED_2_5)
-		state->speed = SPEED_10;
-
-	state->duplex = status & GMAC_RGSMIIIS_LNKMOD_MASK ?
-			DUPLEX_FULL : DUPLEX_HALF;
-
-	dwmac_pcs_get_state(hw, state);
-}
-
-static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
-	.pcs_validate = dwmac1000_mii_pcs_validate,
-	.pcs_enable = dwmac1000_mii_pcs_enable,
-	.pcs_disable = dwmac1000_mii_pcs_disable,
-	.pcs_config = dwmac1000_mii_pcs_config,
-	.pcs_get_state = dwmac1000_mii_pcs_get_state,
-};
-
 static struct phylink_pcs *
 dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
 			     phy_interface_t interface)
@@ -621,7 +548,6 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
-	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
 	mac->mac_pcs.neg_mode = true;
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index bb2997191f08..5c765e16bc13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -568,18 +568,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 #define GMAC_PHYIF_CTRLSTATUS_LUD		BIT(1)
 #define GMAC_PHYIF_CTRLSTATUS_SMIDRXS		BIT(4)
 #define GMAC_PHYIF_CTRLSTATUS_CONFIG_REG	GENMASK(31, 16)
-#define GMAC_PHYIF_CTRLSTATUS_LNKMOD		BIT(16)
-#define GMAC_PHYIF_CTRLSTATUS_SPEED		GENMASK(18, 17)
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT	17
-#define GMAC_PHYIF_CTRLSTATUS_LNKSTS		BIT(19)
-#define GMAC_PHYIF_CTRLSTATUS_JABTO		BIT(20)
-#define GMAC_PHYIF_CTRLSTATUS_FALSECARDET	BIT(21)
-/* LNKMOD */
-#define GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK	0x1
-/* LNKSPEED */
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_125		0x2
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_25		0x1
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_2_5		0x0
 
 extern const struct stmmac_dma_ops dwmac4_dma_ops;
 extern const struct stmmac_dma_ops dwmac410_dma_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 1e73c14f36ce..1487f5cc5249 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -780,85 +780,6 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	}
 }
 
-static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
-				   unsigned long *supported,
-				   const struct phylink_link_state *state)
-{
-	/* Only support in-band */
-	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int dwmac4_mii_pcs_enable(struct phylink_pcs *pcs)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-
-	dwmac4_pcs_enable_irq(hw);
-
-	return 0;
-}
-
-static void dwmac4_mii_pcs_disable(struct phylink_pcs *pcs)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-
-	dwmac4_pcs_disable_irq(hw);
-}
-
-static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
-				 phy_interface_t interface,
-				 const unsigned long *advertising,
-				 bool permit_pause_to_mac)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-
-	return dwmac_pcs_config(hw, advertising, interface, advertising);
-}
-
-static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
-				     struct phylink_link_state *state)
-{
-	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-	unsigned int clk_spd;
-	u32 status;
-
-	status = readl(hw->pcsr + GMAC_PHYIF_CONTROL_STATUS);
-
-	state->link = !!(status & GMAC_PHYIF_CTRLSTATUS_LNKSTS);
-	if (!state->link)
-		return;
-
-	clk_spd = FIELD_GET(GMAC_PHYIF_CTRLSTATUS_SPEED, status);
-	if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
-		state->speed = SPEED_1000;
-	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
-		state->speed = SPEED_100;
-	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_2_5)
-		state->speed = SPEED_10;
-
-	/* FIXME: Is this even correct?
-	 * GMAC_PHYIF_CTRLSTATUS_TC = BIT(0)
-	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD = BIT(16)
-	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK = 1
-	 *
-	 * The result is, we test bit 0 for the duplex setting.
-	 */
-	state->duplex = status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK ?
-			DUPLEX_FULL : DUPLEX_HALF;
-
-	dwmac_pcs_get_state(hw, state);
-}
-
-static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
-	.pcs_validate = dwmac4_mii_pcs_validate,
-	.pcs_enable = dwmac4_mii_pcs_enable,
-	.pcs_disable = dwmac4_mii_pcs_disable,
-	.pcs_config = dwmac4_mii_pcs_config,
-	.pcs_get_state = dwmac4_mii_pcs_get_state,
-};
-
 static struct phylink_pcs *
 dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
 {
@@ -1475,7 +1396,6 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
 
-	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
 	mac->mac_pcs.neg_mode = true;
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 3666893acb69..c42fb2437948 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -363,6 +363,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
 		mac->est = mac->est ? : entry->est;
+		mac->mac_pcs.ops = mac->mac_pcs.ops ?: entry->pcs;
 		mac->priv = priv;
 
 		priv->hw = mac;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 41b99f7e36e6..24b95d1fdb64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -1,17 +1,54 @@
+#include <linux/phylink.h>
+
 #include "common.h"
 #include "stmmac_pcs.h"
 
-int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
-		     phy_interface_t interface,
-		     const unsigned long *advertising)
+static int dwmac_pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
+			      const struct phylink_link_state *state)
+{
+	/* Only support in-band */
+	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dwmac_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+
+	stmmac_pcs_enable_irq(hw->priv, hw);
+
+	return 0;
+}
+
+static void dwmac_pcs_disable(struct phylink_pcs *pcs)
 {
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+
+	stmmac_pcs_disable_irq(hw->priv, hw);
+}
+
+static int dwmac_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			    phy_interface_t interface,
+			    const unsigned long *advertising,
+			    bool permit_pause_to_mac)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
 	struct stmmac_priv *priv = hw->priv;
 	u32 val;
 
+	/* TODO Think about this:
+	 * + En/dis SGMII/RGMII IRQs based on the neg_mode value?
+	 * + Do we need to set PCS_CONTROL.TC?.. For SGMII MAC2MAC?
+	 * + The next is SGMII/RTBI/TBI-specific
+	 */
+
 	val = readl(priv->pcsaddr + PCS_AN_CTRL);
 
 	val |= PCS_AN_CTRL_ANE | PCS_AN_CTRL_RAN;
 
+	/* + The SGMRAL flag is SGMII-specific */
 	if (hw->ps)
 		val |= PCS_AN_CTRL_SGMRAL;
 
@@ -20,12 +57,40 @@ int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
 	return 0;
 }
 
-void dwmac_pcs_get_state(struct mac_device_info *hw,
-			 struct phylink_link_state *state)
+static void dwmac_pcs_get_state(struct phylink_pcs *pcs,
+				struct phylink_link_state *state)
 {
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
 	struct stmmac_priv *priv = hw->priv;
 	u32 val;
 
+	val = stmmac_pcs_get_config_reg(priv, hw);
+
+	/* TODO The next is SGMII/RGMII/SMII-specific */
+	state->link = !!(val & PCS_CFG_LNKSTS);
+	if (!state->link)
+		return;
+
+	switch (FIELD_GET(PCS_CFG_LNKSPEED, val)) {
+	case PCS_CFG_LNKSPEED_2_5:
+		state->speed = SPEED_10;
+		break;
+	case PCS_CFG_LNKSPEED_25:
+		state->speed = SPEED_100;
+		break;
+	case PCS_CFG_LNKSPEED_250:
+		state->speed = SPEED_1000;
+		break;
+	default:
+		netdev_err(priv->dev, "Unknown speed detected\n");
+		break;
+	}
+
+	state->duplex = val & PCS_CFG_LNKMOD ? DUPLEX_FULL : DUPLEX_HALF;
+
+	/* TODO Check the PCS_AN_STATUS.Link status here?.. Note the flag is latched-low */
+
+	/* TODO The next is the TBI/RTBI-specific and seems to be valid if PCS_AN_STATUS.ANC */
 	val = readl(priv->pcsaddr + PCS_ANE_LPA);
 
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
@@ -49,7 +114,10 @@ void dwmac_pcs_get_state(struct mac_device_info *hw,
 				 state->lp_advertising);
 	}
 
-	/* TODO Make sure that STMMAC_PCS_PAUSE STMMAC_PCS_ASYM_PAUSE usage is legitimate */
+	/* TODO The databook says the encoding is defined in IEEE 802.3z,
+	 * Section 37.2.1.4. Do we need the STMMAC_PCS_PAUSE and
+	 * STMMAC_PCS_ASYM_PAUSE mask here?
+	 */
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
 			 state->lp_advertising,
 			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_PAUSE);
@@ -59,4 +127,10 @@ void dwmac_pcs_get_state(struct mac_device_info *hw,
 }
 
 const struct phylink_pcs_ops dwmac_pcs_ops = {
+	.pcs_validate = dwmac_pcs_validate,
+	.pcs_enable = dwmac_pcs_enable,
+	.pcs_disable = dwmac_pcs_disable,
+	.pcs_config = dwmac_pcs_config,
+	.pcs_get_state = dwmac_pcs_get_state,
+
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 76badfd208b6..2baebb92bea7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -47,6 +47,16 @@
 #define PCS_ANE_RFE_SHIFT	12
 #define PCS_ANE_ACK		BIT(14)		/* AN Base-page acknowledge */
 
+/* SGMII/RGMII/SMII link status register */
+#define PCS_CFG_LNKMOD		BIT(0)		/* Link Duplex Mode */
+#define PCS_CFG_LNKSPEED	GENMASK(2, 1)	/* Link Speed: */
+#define PCS_CFG_LNKSPEED_2_5	0x0		/* 2.5 MHz - 10 Mbps */
+#define PCS_CFG_LNKSPEED_25	0x1		/* 25 MHz - 100 Mbps */
+#define PCS_CFG_LNKSPEED_250	0x2		/* 250 MHz - 1000 Mbps */
+#define PCS_CFG_LNKSTS		BIT(3)		/* Link Up/Down Status */
+#define PCS_CFG_JABTO		BIT(4)		/* Jabber Timeout (SMII only) */
+#define PCS_CFG_FALSCARDET	BIT(5)		/* False Carrier (SMII only) */
+
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
  * @ioaddr: IO registers pointer
@@ -76,11 +86,4 @@ static inline void dwmac_pcs_isr(void __iomem *pcsaddr,
 	}
 }
 
-int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
-		     phy_interface_t interface,
-		     const unsigned long *advertising);
-
-void dwmac_pcs_get_state(struct mac_device_info *hw,
-			 struct phylink_link_state *state);
-
 #endif /* __STMMAC_PCS_H__ */
-- 
2.43.0


