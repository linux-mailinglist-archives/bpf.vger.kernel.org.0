Return-Path: <bpf+bounces-3106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D4739659
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 06:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE0628185A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 04:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9996567D;
	Thu, 22 Jun 2023 04:21:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DC1C02;
	Thu, 22 Jun 2023 04:21:02 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72DE1BE5;
	Wed, 21 Jun 2023 21:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687407657; x=1718943657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGc33bAqtZims+Z8ZWCPakULdlqRvmto6XOz1iabewY=;
  b=mzaHTrEdnuf0LF8cC5q/9Lf0kh6TxV0nMuI7o7vtLD8fCR1UyL1J09SL
   IsmBLai4klOp/Fx8VOPQc/py3GsZZbi8OE8MG8m8RjN9dyapSBkeD6JTT
   AYoi+jnds48oGynUNz/wsoJlS2ujqrxuOWsk8k03MpjYyd8niJud7ph2y
   d1ga/8aIWfs/p1pe3QGOkC1crQGixevGNVA35qceW6glf6kfXmrKwiPQh
   RHFKSmshtgw/wP7DnVcEPG+RwGk9PAnYEjTw5yE4NYnpWldpYkg1Dy3hB
   eBZl3e65AkkqG4wpUFXw3PBsIi5y+vqZVuOgnqpFw5jObae60LvYO/UFH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363812331"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="363812331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 21:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744453913"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="744453913"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 21:20:45 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan@web.codeaurora.org, Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next 6/6] net: stmmac: Add 1G/2.5G auto-negotiation support for ADL-N
Date: Thu, 22 Jun 2023 12:19:05 +0800
Message-Id: <20230622041905.629430-7-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add modphy register lane to have 1G/2.5G auto-negotiation support for
ADL-N.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 34 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 1ffa03451d26..024f436b276e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -963,14 +963,46 @@ static struct stmmac_pci_info adls_sgmii1g_phy1_info = {
 	.setup = adls_sgmii_phy1_data,
 };
 
+static int adln_common_data(struct pci_dev *pdev,
+			    struct plat_stmmacenet_data *plat)
+{
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
+	plat->rx_queues_to_use = 6;
+	plat->tx_queues_to_use = 4;
+	plat->clk_ptp_rate = 204800000;
+
+	plat->safety_feat_cfg->tsoee = 1;
+	plat->safety_feat_cfg->mrxpee = 0;
+	plat->safety_feat_cfg->mestee = 1;
+	plat->safety_feat_cfg->mrxee = 1;
+	plat->safety_feat_cfg->mtxee = 1;
+	plat->safety_feat_cfg->epsi = 0;
+	plat->safety_feat_cfg->edpp = 0;
+	plat->safety_feat_cfg->prtyen = 0;
+	plat->safety_feat_cfg->tmouten = 0;
+
+	intel_priv->tsn_lane_registers = adln_tsn_lane_registers;
+	intel_priv->max_tsn_lane_registers = ARRAY_SIZE(adln_tsn_lane_registers);
+
+	return intel_mgbe_common_data(pdev, plat);
+}
+
 static int adln_sgmii_phy0_data(struct pci_dev *pdev,
 				struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->bus_id = 1;
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
+	plat->max_speed = SPEED_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
-	return tgl_common_data(pdev, plat);
+	plat->config_serdes = intel_config_serdes;
+
+	intel_priv->pid_modphy = PID_MODPHY1;
+
+	return adln_common_data(pdev, plat);
 }
 
 static struct stmmac_pci_info adln_sgmii1g_phy0_info = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 75a336cf8af1..349c160c17b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -124,8 +124,10 @@ static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
 	{}
 };
 
+static const int adln_tsn_lane_registers[] = {6};
 static const int ehl_tsn_lane_registers[] = {7, 8, 9, 10, 11};
 #else
+static const int adln_tsn_lane_registers[] = {};
 static const int ehl_tsn_lane_registers[] = {};
 #endif /* CONFIG_INTEL_PMC_CORE */
 
-- 
2.25.1


