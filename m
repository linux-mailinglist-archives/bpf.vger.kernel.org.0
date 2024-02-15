Return-Path: <bpf+bounces-22052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED8855932
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFAC1C28E5D
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010806107;
	Thu, 15 Feb 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPo1/xsa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5727D272;
	Thu, 15 Feb 2024 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966467; cv=none; b=mJhIO9I+gmd3vRSPGfu/Cr2F7v5yxJn+lGiJ2UkxNlC9KVdcCgM/qhHe4FmYIuHDvjNi1z+n4fR3VpjhL1AL99QV9+qMhd8kN2XArODwtDuKQIHa10WQXaXLb19oKMC6u4A/yByK+hdUnK9084GMWFnSOc/kkaOKXmPZUV70K8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966467; c=relaxed/simple;
	bh=3uXE9YXcC/HOZsioY0h0ZRSdXv1l7hsMeVekHYZK4p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hT94t570p7cLEOt9VGGOYyKe1FbFU/QmHUMjOdySWveaQsy9V3x+uC0ffTnWXjlvKrxyvwdwfkvIh54vr+OzfjQ9ickK0ck+80/Y28lFydWKCMeeju/Vmg20ML5cYg4dJFrbnWQ1xvBe/bH3loNVAjQmns5OcPOvaP4PobLtPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPo1/xsa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966466; x=1739502466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uXE9YXcC/HOZsioY0h0ZRSdXv1l7hsMeVekHYZK4p0=;
  b=FPo1/xsabVzfNkc78eab5CvDzzDRKLb4a/ZG9dJVb+tWjN9XY2Li12Sa
   i38P//KJOFrrw8773MBBV982IERagFhZUa7lcslMYxT4q1uXwtGBn7Snb
   jEmCZMxgfd6A0wpFRJw1Ny4o10O7spmTA31M0gQMF0kXTUkDVuvbvEFt8
   O+wPEmT2+eDr6Yw7DEUj+YpMVNx4XBOacWNlzYkS31s4jkNPORjK5BdUQ
   /k/Elb9VEMh4NGcA0tQe/KwSMV5WI3qkyw0mzagJrVmeCpwtOqTMr0Ahx
   F3N949Ftj7ZfWKcauNXMqAnzQLo6sj+uBBiofuqvpuzdJTkMOhY8dNUZL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461247"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461247"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385671"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:07:38 -0800
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
Subject: [PATCH net-next v5 2/9] net: phylink: add phylink_pcs_neg_mode() declaration into phylink.h
Date: Thu, 15 Feb 2024 11:04:52 +0800
Message-Id: <20240215030500.3067426-3-yong.liang.choong@linux.intel.com>
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

Add phylink_pcs_neg_mode() declaration to the header file for other modules
to call the function.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phylink.c | 7 ++++---
 include/linux/phylink.h   | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b38b39a6d1f0..b4345042d3fe 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1093,9 +1093,9 @@ static void phylink_pcs_an_restart(struct phylink *pl)
  * Note: this is for cases where the PCS itself is involved in negotiation
  * (e.g. Clause 37, SGMII and similar) not Clause 73.
  */
-static unsigned int phylink_pcs_neg_mode(unsigned int mode,
-					 phy_interface_t interface,
-					 const unsigned long *advertising)
+unsigned int phylink_pcs_neg_mode(unsigned int mode,
+				  phy_interface_t interface,
+				  const unsigned long *advertising)
 {
 	unsigned int neg_mode;
 
@@ -1139,6 +1139,7 @@ static unsigned int phylink_pcs_neg_mode(unsigned int mode,
 
 	return neg_mode;
 }
+EXPORT_SYMBOL_GPL(phylink_pcs_neg_mode);
 
 static void phylink_major_config(struct phylink *pl, bool restart,
 				  const struct phylink_link_state *state)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index f0a6c00e8dab..74af8cfbdd92 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -594,6 +594,9 @@ int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
 int phylink_speed_down(struct phylink *pl, bool sync);
 int phylink_speed_up(struct phylink *pl);
+unsigned int phylink_pcs_neg_mode(unsigned int mode,
+				  phy_interface_t interface,
+				  const unsigned long *advertising);
 
 #define phylink_zero(bm) \
 	bitmap_zero(bm, __ETHTOOL_LINK_MODE_MASK_NBITS)
-- 
2.34.1


