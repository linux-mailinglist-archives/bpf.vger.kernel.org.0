Return-Path: <bpf+bounces-22051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8CD85592B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412A8B28E00
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C849473;
	Thu, 15 Feb 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHe5034D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EB8C1E;
	Thu, 15 Feb 2024 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966459; cv=none; b=R4/yTjGaZ0K4dbyoLRPJgrK/tlbHpCbwZ/AnL8cACrAuKCE+QGOjiuDreepMZYvmRna3SnBizNOJnE257NH2v8vsKjHHkVQPqS92ltGiEyZOIx7vUx6FDVYHh5pW0qNyujJlWI8pv8J9nnoRElESinMoxl9IWkaa5j5sGyzV9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966459; c=relaxed/simple;
	bh=Id7jaa6k0BX7PLQJS3cBe6qIs2K9RSyvcFT8QOa3qkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UpQA4hHPZXNyohAs/NxgeJLwzqMEdlsjObqZW2Bi/lbHirWAC2FqNFNDfnoWis9KE87j+kBzhAbiv05h5qgdIQocub68sun07KPxrNk2keltIY1uZmIv1LB/pKTgIC/umnH1uUex1w+6NKoyhvhGA+TTMsnGVAgsATlSE/brhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHe5034D; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966458; x=1739502458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Id7jaa6k0BX7PLQJS3cBe6qIs2K9RSyvcFT8QOa3qkE=;
  b=JHe5034DGy5+/NTfiQ+rcMVtiGInq6FV40vtQMCJ4K+BbzD6suj/hiIS
   QQDv7H4Wd9aoMQxN2e0vZTeBAF1IAeDh/BlVCVu9JP/hoKGWr0Lk8/pSV
   /8JAgRRMQWDO4oKMvAxf75/y154zDtQrCcoAayfcvLVEFEZwMY/D4rIgu
   TjnA+hPffMPRMym1g2CI8tE5on7GWlAFsobwpi7tOjrnbuSXDmGyal+o0
   PV6dOdNDVQD0fq42zORh8oU75HWpzuM4tl1GjcvmDOktMuKUVTW+L8erT
   19KBesVneWJcBN942puWCa0kgWVQbm+ZfR9klckCUXfAXAsKvi0ipQxco
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461225"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461225"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385660"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:07:29 -0800
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
Subject: [PATCH net-next v5 1/9] net: phylink: provide mac_get_pcs_neg_mode() function
Date: Thu, 15 Feb 2024 11:04:51 +0800
Message-Id: <20240215030500.3067426-2-yong.liang.choong@linux.intel.com>
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

Phylink invokes the 'mac_get_pcs_neg_mode' function during interface mode
switching and initial startup.

This function is optional; if 'phylink_pcs_neg_mode' fails to accurately
reflect the current PCS negotiation mode, the MAC driver can determine the
mode based on the interface mode, current link negotiation mode, and
advertising link mode.

For instance, if the interface switches from 2500baseX to SGMII mode,
and the current link mode is MLO_AN_PHY, calling 'phylink_pcs_neg_mode'
would yield PHYLINK_PCS_NEG_OUTBAND. Since the MAC and PCS driver require
PHYLINK_PCS_NEG_INBAND_ENABLED, the 'mac_get_pcs_neg_mode' function
will calculate the mode based on the interface, current link negotiation
mode, and advertising link mode, returning PHYLINK_PCS_NEG_OUTBAND to
enable the PCS to configure the correct settings.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phylink.c | 14 +++++++++++---
 include/linux/phylink.h   |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 503fd7c40523..b38b39a6d1f0 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1151,9 +1151,17 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
 
-	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
-						state->interface,
-						state->advertising);
+	if (pl->mac_ops->mac_get_pcs_neg_mode) {
+		pl->pcs_neg_mode = pl->mac_ops->mac_get_pcs_neg_mode
+						(pl->config,
+						 pl->cur_link_an_mode,
+						 state->interface,
+						 state->advertising);
+	} else {
+		pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
+							state->interface,
+							state->advertising);
+	}
 
 	if (pl->using_mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 6ba411732a0d..f0a6c00e8dab 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -168,6 +168,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
  * @mac_finish: finish a major reconfiguration of the interface.
  * @mac_link_down: take the link down.
  * @mac_link_up: allow the link to come up.
+ * @mac_get_pcs_neg_mode: Get PCS negotiation mode for interface mode.
  *
  * The individual methods are described more fully below.
  */
@@ -188,6 +189,10 @@ struct phylink_mac_ops {
 			    struct phy_device *phy, unsigned int mode,
 			    phy_interface_t interface, int speed, int duplex,
 			    bool tx_pause, bool rx_pause);
+	unsigned int (*mac_get_pcs_neg_mode)(struct phylink_config *config,
+					     unsigned int mode,
+					     phy_interface_t interface,
+					     const unsigned long *advertising);
 };
 
 #if 0 /* For kernel-doc purposes only. */
-- 
2.34.1


