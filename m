Return-Path: <bpf+bounces-32906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1C914E84
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7041C20AF1
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB59140386;
	Mon, 24 Jun 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcwZeSq6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B313F44D;
	Mon, 24 Jun 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235719; cv=none; b=LoLYJ+fNv8grtGYav/qxg7kOhO2e8sdpAchnqeGoU+S+wK2nmFhbp73t/2Y+6Csbhe3o6p0MakpyS2fRJmsOx4+XLteLAi0iu0Gg520JCwbsqsZx0HXrIbh2aph3OSN6Fi/CjgWLgn6PbSrW7jEkW5MFGOP5X+K7RUivfxtQkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235719; c=relaxed/simple;
	bh=/Se+MUZKf2rO8FEugEfFK6YmuKLizh44eeqE06vUbmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkLIkAOVo0RRUVTr1s5Fihg/Idan+ZsOKV+W3pnRHA+yePkW3oG4EoQmbWh/C0ujAPCT+22fhGPW59H5hPSngNfeUiE8N44v2RuqjOq1mV2/gGZ1uDuKudPzchFVg0UKybMl+2bzrX8BAOi/FjeIFId17FSEF/iW3xoJXWGxLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcwZeSq6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cd717ec07so3319633e87.0;
        Mon, 24 Jun 2024 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235716; x=1719840516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+/PkaXmRsVYIqKGZx4UeA9J6j62ytdn83yxhqwCP6o=;
        b=IcwZeSq6uErbhEH+mrX7Q4zxelMa3rRkqxiJIQd5r7yZkApbbf6KU5ZlSt73CZgCZL
         xGBCBZNGgPQ8eQgPzEeyT233eOAgH9NEhGvgZFz070R95MZxy6mP1sGTvmUtvuFN5Bag
         bzRRxLC4DOVkBhUKUsh0maI+81I1IbLYBm1fKrYUhLUv9Rl7EJyq7/ip8niR1CUmqIwn
         Qd5sib6zquwe2K7n7/D/N1EmuqWtQFyO0jdGaSCItbSgiwr3C/xJkjDF438WwTep58Jy
         rvyQ+txuYPb5oXmfq8CeAKfWL4qXjwxn32YmU4TTepGtnKEWrrkD9GdY+4oojnMoYYEV
         oE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235716; x=1719840516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+/PkaXmRsVYIqKGZx4UeA9J6j62ytdn83yxhqwCP6o=;
        b=kKjZtOdFzncYY5RMCbbpzSi/os/E/maMTwz8xApO8LJqWTKTDyXcqtsifVyf6Pw+XF
         53NY1eDeuQt2WHMC57y14edj9daEbFmZQyaFuS2wRKgaJ5VOxXvkQJkCD8DQFQ+iXzYe
         NHxoTCTuxPZiJLBI9Q5vJHIzrp/09QtAuK70i+KYzDGre+QHR9XWrnOxHiP88e05GCJC
         2jIWg11E8J/Dwf18rzJXlMqe4IwTfWyLCVlvf3rFP8NaQcc/Pu8grldFiOV/EkV+He4E
         6dEjCzPoWeUtnzoBrHyPNNmxnMBbLQQEoEEL7XUrc2/KzECSlUsvdmh18R01L9R9q7LH
         rrJA==
X-Forwarded-Encrypted: i=1; AJvYcCUwXAxVPkF6+Jd2zvQ6rmDH2++64pM2SamAFG2mnw+v54DW4gY/A2gmzbZGg63SmoGb1TEEDh7llmSc79ppPZdQPocDI3kpUT4VWzXr3zoo1TNX7c1GR9hQhVi1638Np8OCNMH9ZCUBMzTCSJlvffJS5eiHyK/nUHLE
X-Gm-Message-State: AOJu0YxHAqr74RleP8U8+wBbdzbGb8VeK2xXyB4wphjSEAQO/8gYFnkJ
	tWdPhRaM54T10pCQarHPYI5uFyp7qrHimsIVPYgKd3YHr6ELLUa1
X-Google-Smtp-Source: AGHT+IH809R8vF6zTQILCWIugVLXjGsYzjDJo9A/xeg6IqGYA6QXLn9MgMKJTyre4EaY/xpUaBI5NA==
X-Received: by 2002:a05:6512:1154:b0:52c:9d38:9df1 with SMTP id 2adb3069b0e04-52ce183263dmr3351699e87.10.1719235715596;
        Mon, 24 Jun 2024 06:28:35 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b4bc2sm982966e87.27.2024.06.24.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:35 -0700 (PDT)
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
Subject: [PATCH RFC net-next v2 11/17] net: stmmac: Introduce internal PCS config register getter
Date: Mon, 24 Jun 2024 16:26:28 +0300
Message-ID: <20240624132802.14238-3-fancer.lancer@gmail.com>
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

The optional PCS module CSRs are mainly represented in the framework of
the address spaces [0x00c0:0x00db] on DW GMAC and [0x00e0:0x00f7] on DW
QoS Eth. The spaces mapping is identical in both IP-cores. But the link
state retrieved from the PHY or from another MAC (in MAC2MAC
setup) is mapped over the SGMII/RGMII/SMII Control and Status register in
a non-compatible way. In particular the DW GMAC register have the link
state mapped at the [15:0] field, and the DW QoS Eth register have it
mapped at the [31:16] field. Other than that the fields semantics is
identical - it's the TX_CONFIG_REG[15:0] register (see SGMII specification
for details) with a bit re-ordered fields and extended with some
SMII-specific flags:
tx_config_reg[0]:   LNKMOD
tx_config_reg[1:2]: LNKSPEED
tx_config_reg[3]:   LNKSTS
tx_config_reg[4]:   JABTO (Jabber Timeout, SMII-specific)
tx_config_reg[5]:   FALSCARDET (False Carrier Detected, SMII-specific)

In order to provide a fully generic internal STMMAC PCS module, let's
introduce the MAC-specific callback returning the link state detected by
the internal PCS.

Note the callback name has been chosen to be referring to the
TX_CONFIG_REG data described in the IP-core databooks and in the SGMII
specification.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c    | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h        |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c   | 13 +++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h          |  3 +++
 5 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 4296ddda8aaa..f3a95d27298c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -86,6 +86,7 @@ enum power_event {
 #define GMAC_RGSMIIIS		0x000000d8	/* RGMII/SMII status */
 
 /* SGMII/RGMII status register */
+#define GMAC_RGSMIIIS_CONFIG_REG	GENMASK(15, 0)
 #define GMAC_RGSMIIIS_LNKMODE		BIT(0)
 #define GMAC_RGSMIIIS_SPEED		GENMASK(2, 1)
 #define GMAC_RGSMIIIS_SPEED_SHIFT	1
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index e525b92955b4..1e50cc573407 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -365,6 +365,16 @@ static void dwmac1000_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + LPI_TIMER_CTRL);
 }
 
+static u16 dwmac1000_pcs_get_config_reg(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 val;
+
+	val = readl(ioaddr + GMAC_RGSMIIIS);
+
+	return FIELD_GET(GMAC_RGSMIIIS_CONFIG_REG, val);
+}
+
 static void dwmac1000_ctrl_ane(void __iomem *pcsaddr, bool ane, bool srgmi_ral,
 			       bool loopback)
 {
@@ -568,6 +578,7 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_timer = dwmac1000_set_eee_timer,
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
+	.pcs_get_config_reg = dwmac1000_pcs_get_config_reg,
 	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index d3c5306f1c41..bb2997191f08 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -567,6 +567,7 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 #define GMAC_PHYIF_CTRLSTATUS_TC		BIT(0)
 #define GMAC_PHYIF_CTRLSTATUS_LUD		BIT(1)
 #define GMAC_PHYIF_CTRLSTATUS_SMIDRXS		BIT(4)
+#define GMAC_PHYIF_CTRLSTATUS_CONFIG_REG	GENMASK(31, 16)
 #define GMAC_PHYIF_CTRLSTATUS_LNKMOD		BIT(16)
 #define GMAC_PHYIF_CTRLSTATUS_SPEED		GENMASK(18, 17)
 #define GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT	17
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e51c95732bad..b7db076b4214 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -456,6 +456,16 @@ static void dwmac4_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + GMAC4_LPI_TIMER_CTRL);
 }
 
+static u16 dwmac4_pcs_get_config_reg(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 val;
+
+	val = readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
+
+	return FIELD_GET(GMAC_PHYIF_CTRLSTATUS_CONFIG_REG, val);
+}
+
 static void dwmac4_write_single_vlan(struct net_device *dev, u16 vid)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
@@ -1274,6 +1284,7 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
 	.debug = dwmac4_debug,
+	.pcs_get_config_reg = dwmac4_pcs_get_config_reg,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
 	.update_vlan_hash = dwmac4_update_vlan_hash,
@@ -1318,6 +1329,7 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
 	.debug = dwmac4_debug,
+	.pcs_get_config_reg = dwmac4_pcs_get_config_reg,
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
@@ -1366,6 +1378,7 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
 	.debug = dwmac4_debug,
+	.pcs_get_config_reg = dwmac4_pcs_get_config_reg,
 	.set_filter = dwmac4_set_filter,
 	.safety_feat_config = dwmac5_safety_feat_config,
 	.safety_feat_irq_status = dwmac5_safety_feat_irq_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index ba930a87b71a..00995a0c9813 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -376,6 +376,7 @@ struct stmmac_ops {
 		      struct stmmac_extra_stats *x, u32 rx_queues,
 		      u32 tx_queues);
 	/* PCS calls */
+	u16 (*pcs_get_config_reg)(struct mac_device_info *hw);
 	void (*pcs_ctrl_ane)(void __iomem *pcsaddr, bool ane, bool srgmi_ral,
 			     bool loopback);
 	/* Safety Features */
@@ -492,6 +493,8 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, set_eee_pls, __args)
 #define stmmac_mac_debug(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, debug, __priv, __args)
+#define stmmac_pcs_get_config_reg(__priv, __args...) \
+	stmmac_do_callback(__priv, mac, pcs_get_config_reg, __args)
 #define stmmac_pcs_ctrl_ane(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, pcs_ctrl_ane, __args)
 #define stmmac_safety_feat_config(__priv, __args...) \
-- 
2.43.0


