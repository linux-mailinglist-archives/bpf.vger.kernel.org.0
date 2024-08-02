Return-Path: <bpf+bounces-36250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A3945695
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924EC1C22CB5
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615BD272;
	Fri,  2 Aug 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FCC1inpq"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9E632;
	Fri,  2 Aug 2024 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722568715; cv=none; b=XeNdpwM3KFNwG9PpB1uqhVnqB2RgNDLSJsPiyRK4/7ScjlkKC5XXkhXWfATe6mKwnR/XHMg+PIDYf1VZuNwPTweDYa2cMHaQV2tYyHArhKNIGnJvd2AwVXiCH0HeI0eBOoPoT1XqzK5VINXiguobKkqW+DdOmeO2bAJDpvhTt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722568715; c=relaxed/simple;
	bh=krI7U8sRBmiw28CnfnkGSQgKpZPhoxDuv6WMnKEa0LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPyjGvggmWtGebKK5PmLR1Fydfa4jad9OPT4XdmwJJC0WQK9+n7vdjyco2K0Q3RFomxIqz4xfE28onE6eJ7Xut1nurNBGuWXvu/wrqMyqNidTvtM+SGn84BQHhw1uE4MLD7c3qKRkLwD37F2fQgRFJzqm7jr/lztZP67uNRkkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FCC1inpq; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 50B9FC0000FB;
	Thu,  1 Aug 2024 20:18:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 50B9FC0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722568707;
	bh=krI7U8sRBmiw28CnfnkGSQgKpZPhoxDuv6WMnKEa0LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCC1inpqffmiJmEp+NcaB3ipvjKhCVumgwgPJvq/vrZtn81BYmSsmNdVL7E7sFesA
	 /p6knY5qmUKRJx+mtz36ElVDV7YGRYS4N57Eg38Fa2TeyRt9idXAvjifCX23o8DGuk
	 d4sKRRcISZU89ZJOQTxGXrgHx+wFJ/M/4Mdd2riI=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 7733318041CAC7;
	Thu,  1 Aug 2024 20:18:24 -0700 (PDT)
From: jitendra.vegiraju@broadcom.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into stmmac hwif handling
Date: Thu,  1 Aug 2024 20:18:21 -0700
Message-Id: <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Integrate dwxgmac4 support into stmmac hardware interface handling.
A dwxgmac4 is an xgmac device and hence it inherits properties from
existing stmmac_hw table entry.
The quirks handling facility is used to update dma_ops field to
point to dwxgmac400_dma_ops when the user version field matches.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h |  4 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 26 +++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h   |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index cd36ff4da68c..9bf278e11704 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -37,11 +37,15 @@
 #define DWXGMAC_CORE_2_10	0x21
 #define DWXGMAC_CORE_2_20	0x22
 #define DWXLGMAC_CORE_2_00	0x20
+#define DWXGMAC_CORE_4_00	0x40
 
 /* Device ID */
 #define DWXGMAC_ID		0x76
 #define DWXLGMAC_ID		0x27
 
+/* User Version */
+#define DWXGMAC_USER_VER_X22	0x22
+
 #define STMMAC_CHAN0	0	/* Always supported and default for all chips */
 
 /* TX and RX Descriptor Length, these need to be power of two.
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 29367105df54..713cb5aa2c3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -36,6 +36,18 @@ static u32 stmmac_get_dev_id(struct stmmac_priv *priv, u32 id_reg)
 	return (reg & GENMASK(15, 8)) >> 8;
 }
 
+static u32 stmmac_get_user_version(struct stmmac_priv *priv, u32 id_reg)
+{
+	u32 reg = readl(priv->ioaddr + id_reg);
+
+	if (!reg) {
+		dev_info(priv->device, "User Version not available\n");
+		return 0x0;
+	}
+
+	return (reg & GENMASK(23, 16)) >> 16;
+}
+
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
@@ -82,6 +94,18 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 	return 0;
 }
 
+static int stmmac_dwxgmac_quirks(struct stmmac_priv *priv)
+{
+	struct mac_device_info *mac = priv->hw;
+	u32 user_ver;
+
+	user_ver = stmmac_get_user_version(priv, GMAC4_VERSION);
+	if (priv->synopsys_id == DWXGMAC_CORE_4_00 &&
+	    user_ver == DWXGMAC_USER_VER_X22)
+		mac->dma = &dwxgmac400_dma_ops;
+	return 0;
+}
+
 static int stmmac_dwxlgmac_quirks(struct stmmac_priv *priv)
 {
 	priv->hw->xlgmac = true;
@@ -256,7 +280,7 @@ static const struct stmmac_hwif_entry {
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxgmac2_setup,
-		.quirks = NULL,
+		.quirks = stmmac_dwxgmac_quirks,
 	}, {
 		.gmac = false,
 		.gmac4 = false,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e53c32362774..6213c496385c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -683,6 +683,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
 extern const struct stmmac_est_ops dwmac510_est_ops;
+extern const struct stmmac_dma_ops dwxgmac400_dma_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
-- 
2.34.1


