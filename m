Return-Path: <bpf+bounces-20580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D97840622
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F19A1F24D3D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36FA64CEB;
	Mon, 29 Jan 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5J1gdwt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E57612C1;
	Mon, 29 Jan 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533544; cv=none; b=uDNOZAiN3/T/587aRaJZfx4q+wlosVepjXjrD3UcbmbxBP6HjHW4p1/ql1ffD45k6Akm70VmTGEY7KOxXA/sW3NmoUrWkj9TYnCp90Wew+vsGkeAtQ/jy8pILSFlS2qhMIL8Sn/OqZU8xUWzDTHOClPeCN6h3azDgVWXQxLSAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533544; c=relaxed/simple;
	bh=3g/FhS8Tz9Uv+C3aF9YuSbYH1gtm3NTUoRt3ttrDE2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCRTCisjxu0P25sM5Qvj9MG9ZQUEOgmvyBobBlnhnoKbOkRMEWAn4nlBOJHk7LVLBtz6uSblq7ZaS3XgTGmJiqS46xOPLwViqmyG/0lIkyazJ0fTWWD8+WXwRWCzVSjoPt7TrknTqlEMU1gnatbnJDdDoYyGaqRBLTtIKJtAf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5J1gdwt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533543; x=1738069543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3g/FhS8Tz9Uv+C3aF9YuSbYH1gtm3NTUoRt3ttrDE2I=;
  b=g5J1gdwtJqe7L9qmHJA8MJH3rj7J5vGu0+faF+bYMExhCWVaZaXjqjS2
   xkmCubexjlOtpoN6vNgG07OHAJBL1KXLTKYksCNnMprfH/+HfgUe5cXdn
   TmLpaRz1Qnc8hTY2OHixDLvnlqKUiTHF5JNFRniuac6oNJr0Ed2iD6gkd
   O95MIVGEWUoQTJmG5Yp091OqouQPPWCufhEWalGjh5qysMa6OwXy3DZmn
   BB9U4H1yimweNIt1fu5ROpQFTqswOT372+zkl7oSup03lIYY6s5pri5MH
   APhvENrxz9apDQ7ktGohZijJjHWZXgFBCorJr5+j9oiYutlKREK9ZE7K+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473441"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473441"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106777"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106777"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:05:34 -0800
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
Subject: [PATCH net-next v4 04/11] net: phylink: add phylink_pcs_neg_mode() declaration into phylink.h
Date: Mon, 29 Jan 2024 21:02:46 +0800
Message-Id: <20240129130253.1400707-5-yong.liang.choong@linux.intel.com>
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

From: Choong Yong Liang <yong.liang.choong@intel.com>

Add phylink_pcs_neg_mode() declaration to the header file for other modules
to call the function.

Signed-off-by: Choong Yong Liang <yong.liang.choong@intel.com>
---
 drivers/net/phy/phylink.c | 7 ++++---
 include/linux/phylink.h   | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 27aa5d0a9fc6..f8bbc808be61 100644
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
index adb47d1aa67b..fb021275a095 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -595,6 +595,9 @@ int phylink_ethtool_set_eee(struct phylink *, struct ethtool_eee *);
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


