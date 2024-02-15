Return-Path: <bpf+bounces-22054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF585593F
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5341C29A4D
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2128F4E;
	Thu, 15 Feb 2024 03:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDsRkvRQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EA12B7C;
	Thu, 15 Feb 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966484; cv=none; b=cA2m/k5lWD/ZDiIVbxCvSWG0TTt8NnDn6a/CK1YHmfSs6be1RJ8zMmqLFGgWwu8jN8mndUANyoCnb0NcnKkfKRV+vJpjstEc7Yz3WCwt+EIr8C4/twOJRqm+Yp3J3MJPpK2nJCgdZ2r6MGlWh/7rqgbbsDuQPAvnzqKsAvCjivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966484; c=relaxed/simple;
	bh=N38loWFo7GWrJwwLm4tKbNOCG6/JHGqNKZcHVjVV0zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DES4+nRyxsLDhAjSqpjc7v0WK/j6/inkJT74npSl6yBq2TJ9YJhsvxy1UpWtwbWTbP3SHbPJ7SCi3NMkP2dQACANaX9ewBdoJdETFtl4LPZFBkOsNQy2vCgB7U9g9zzQ3C20mdvCaMPeT5cpT81DmMiMAIOEGg1EdKc8NBwE1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDsRkvRQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966483; x=1739502483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N38loWFo7GWrJwwLm4tKbNOCG6/JHGqNKZcHVjVV0zo=;
  b=iDsRkvRQMDRa+uQ6VV67mkQvEDkDeEbnAasWg8LIEFnDvPvhOsmNl7XA
   b377T/RuiCJ9vJlPTN33zoHKaaAnOpz5hGhRwn1DfoVxVIBfFfLl/Kbwx
   nCkn5sZgYIkbYYQMzZ2vPxFClkul/KcqKgFJRf9bTzYFcH2vqx41/HsJP
   6dSXI4YQd6Z5YR0b8hPaDLk0vNgip0DflIaCsqRWmEhfloBUgLiOiB6J0
   optO2e/GOD3uioY3j4oE7t+KVaJ/qcjD8XXeZiRf8KRe3aBhQ/YyEufAR
   94I6Soow2ECfXsNqkYghonej4M/QqOYCmRGBO6YSjoxxfWAwLzM+VUEfW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461309"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461309"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385742"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:07:54 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>,
	Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: [PATCH net-next v5 4/9] net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
Date: Thu, 15 Feb 2024 11:04:54 +0800
Message-Id: <20240215030500.3067426-5-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
References: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the XPCS datasheet, a soft reset is required to initiate
Clause 37 auto-negotiation when the XPCS switches interface modes.

When the interface mode is set to 2500BASE-X, Clause 37 Auto-Negotiation
is turned off.

Subsequently, when the interface mode switches from 2500BASE-X to SGMII,
re-initiating Clause 37 auto-negotiation is required for the SGMII
interface mode to function properly.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/pcs/pcs-xpcs.c | 62 +++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 52a7757ee419..cf1ed89d6418 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -848,6 +848,60 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
 }
 
+static int xpcs_switch_to_aneg_c37_sgmii(const struct xpcs_compat *compat,
+					 struct dw_xpcs *xpcs,
+					 unsigned int neg_mode)
+{
+	bool an_c37_enabled;
+	int ret, mdio_ctrl;
+
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL);
+		if (mdio_ctrl < 0)
+			return mdio_ctrl;
+
+		an_c37_enabled = mdio_ctrl & AN_CL37_EN;
+		if (!an_c37_enabled) {
+			//Perform soft reset to initiate C37 auto-negotiation
+			ret = xpcs_soft_reset(xpcs, compat);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+static int xpcs_switch_interface_mode(const struct xpcs_compat *compat,
+				      struct dw_xpcs *xpcs,
+				      phy_interface_t interface,
+				      unsigned int neg_mode)
+{
+	int ret;
+
+	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+		ret = txgbe_xpcs_switch_mode(xpcs, interface);
+		if (ret)
+			return ret;
+	} else {
+		if (xpcs->interface != interface) {
+			xpcs->interface = interface;
+
+			switch (compat->an_mode) {
+			case DW_AN_C37_SGMII:
+				ret = xpcs_switch_to_aneg_c37_sgmii(compat,
+								    xpcs,
+								    neg_mode);
+				if (ret)
+					return ret;
+				break;
+			default:
+				return 0;
+			}
+		}
+	}
+	return 0;
+}
+
 int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		   const unsigned long *advertising, unsigned int neg_mode)
 {
@@ -858,11 +912,9 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	if (!compat)
 		return -ENODEV;
 
-	if (xpcs->dev_flag == DW_DEV_TXGBE) {
-		ret = txgbe_xpcs_switch_mode(xpcs, interface);
-		if (ret)
-			return ret;
-	}
+	ret = xpcs_switch_interface_mode(compat, xpcs, interface, neg_mode);
+	if (ret)
+		return ret;
 
 	switch (compat->an_mode) {
 	case DW_10GBASER:
-- 
2.34.1


