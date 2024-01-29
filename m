Return-Path: <bpf+bounces-20575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C158840608
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FC1F244C3
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1B62A04;
	Mon, 29 Jan 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3gq8D+w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEA61673;
	Mon, 29 Jan 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533518; cv=none; b=idu00dDRKRmJfF7HxQZu1Vd5z/tuYxYXCYxc6JU+DVf6EVZCz5uCAuyhE6IxkUQ496DI5WnghfxcQkgHWFYb8Lrbxve6vopUMFjTmjC3dEQu9FinD+oe8z+/v5IKNX6egQq7freYWf/zvZBpyveDEhzK2SC6IV+I+7CMVryIfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533518; c=relaxed/simple;
	bh=hWDEomf8s1NSZ88LHI2h/eMgx2/+Wu9+L2VlrPLQc6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QanZExPnY38aZRqKZE03o63/XesxzfrPB69SkTpuqQNbHEyYZcSYyJiKh/TCJY+cdz/P39ABVVLOGZgRMujj6uwVVNQq+diGE6DDRbwV8qm6R467ga0pBZ4T5IUrye9SQat86Bqwfc8TZgnt5aqdzfRXDoqWlbU+Ad96kM9zptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3gq8D+w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533517; x=1738069517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWDEomf8s1NSZ88LHI2h/eMgx2/+Wu9+L2VlrPLQc6g=;
  b=U3gq8D+w5UUddwBeltLUyJk3yRe4ES3MaAjXn/h1n2dzw0sM0kJvPNYe
   MHFv7Dx5Y+HWICz6BJl6jPNnB+R7a02rWhWMDwTlvxdHuLlNPg5wTTPMp
   ZaCrg848mCmNk2VeVSJJXIJnAT/8qbWFxc4aLnR1DVZ68UeQC7XGSqPAl
   4bkkIyZGkTZyCFKrZHA3rUensNrMiTQlkpCoGwYQ04DXM78Sg6kdbAmke
   GQUrJe0SC1WmbJTJmUwvPXJpnBdkGpTNX0aqBRP/HG1+79QswqElqKgV1
   k7ODhgKSC5hZY3F1FEb+iupsjcq8wE7Biyexp1PRyyCvMAbvSPSdIBIjz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473237"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473237"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:05:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106707"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106707"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:05:08 -0800
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
	Simon Horman <simon.horman@corigine.com>,
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
Subject: [PATCH net-next v4 01/11] net: phylink: publish ethtool link modes that supported and advertised
Date: Mon, 29 Jan 2024 21:02:43 +0800
Message-Id: <20240129130253.1400707-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the allow_switch_interface flag to publish all the ethtool
link modes that can be supported and advertised.

This will allow the interface switching based on different ethtool
link modes.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phylink.c | 9 +++++----
 include/linux/phylink.h   | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ed0b4ccaa6a6..38ee2624169c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1839,10 +1839,11 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 	 * against all interface modes, which may lead to more ethtool link
 	 * modes being advertised than are actually supported.
 	 */
-	if (phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
-	    state->interface != PHY_INTERFACE_MODE_RXAUI &&
-	    state->interface != PHY_INTERFACE_MODE_XAUI &&
-	    state->interface != PHY_INTERFACE_MODE_USXGMII)
+	if ((phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
+	     state->interface != PHY_INTERFACE_MODE_RXAUI &&
+	     state->interface != PHY_INTERFACE_MODE_XAUI &&
+	     state->interface != PHY_INTERFACE_MODE_USXGMII) ||
+	     pl->config->allow_switch_interface)
 		state->interface = PHY_INTERFACE_MODE_NA;
 
 	return phylink_validate(pl, supported, state);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index d589f89c612c..b362d3231aa4 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -151,6 +151,7 @@ struct phylink_config {
 	bool poll_fixed_state;
 	bool mac_managed_pm;
 	bool ovr_an_inband;
+	bool allow_switch_interface;
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
-- 
2.34.1


