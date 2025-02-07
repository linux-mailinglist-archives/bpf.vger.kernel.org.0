Return-Path: <bpf+bounces-50791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F834A2C994
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5703ACB8A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5209199396;
	Fri,  7 Feb 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NURfRR7t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC41192D63;
	Fri,  7 Feb 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947490; cv=none; b=UXqINUfVaV8jaFVKq/tyrWFrGyMkG2TP/EW4UjXvxpm8dJgCvvk/FYambgr5hSzpEufM1m1UwJW+U55NqjWPGt/8otyUZNaKCsuw7LvACYVQCjwRGU5wwWO5YXHz6FrYgk8HnaX79a0DqK6feMfu3E2PzuwTmwLlVI05BG8BDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947490; c=relaxed/simple;
	bh=qK9qrQMjSldwbrNHCdVyeZMm0a8dUnl6Ry1EmjgiouE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVNRorin0/sVgsFN+IGz2XNQAEy3gm2FbFln2Bdpca1u7VrCi9/lZhdIN+TVRpZmV5nfBakwCjsgeAz2FfLTCqn9mLipkbnS4zijZD2+cP19uALYWPl0mQyWgNZlFhcgcf5Q15Z4dssAE/pz1x+DkwaAHVf0mI64Q7w0pD57uQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NURfRR7t; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947489; x=1770483489;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qK9qrQMjSldwbrNHCdVyeZMm0a8dUnl6Ry1EmjgiouE=;
  b=NURfRR7tLRkkubT71TcDx6OrJ/9vgRAvHABEJoDlWUiVAsAVivhsRFcU
   s2mwu6OUsTsUJdmObuqEFRBnFszkClWdiX52e2oyawBhEBTt6dTOUS4j/
   n2XY3ziyn0fjk83r/9iSD0sJB8DR67UwrY8xBxGa1Ao685RXqs+ceAhA+
   g3x+uZEuaLTI+8qnUF+glkGkANAa+X7Gr1XPi+Hk9wDtYAIhaiooy9LSk
   AYeuF5UOYtFdpJ1nlcfHDQ4M7QHfJC3Ahb5OB2FUmavwQHAkQNiyslfAf
   8cmuGNZoq2O2KMQ5bCfFxir9kqBpnIqapH7xaiJPNaOAMhb9Tn2Dqar45
   Q==;
X-CSE-ConnectionGUID: DfJzUkTbTDasJJbfsE7ZaQ==
X-CSE-MsgGUID: JMwE3jtrQIeLktQ1fImEEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39723059"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39723059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:58:08 -0800
X-CSE-ConnectionGUID: tfr/YcbRRh+AHkcpbOl+AA==
X-CSE-MsgGUID: zvqMVvaISreU+qfufv+6zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111534649"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 07 Feb 2025 08:58:00 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 8/9] igc: Add support to get MAC Merge data via ethtool
Date: Fri,  7 Feb 2025 11:56:48 -0500
Message-Id: <20250207165649.2245320-9-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com>
References: <20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement "ethtool --show-mm" callback for IGC.

Tested with command:
$ ethtool --show-mm enp1s0.
  MAC Merge layer state for enp1s0:
  pMAC enabled: on
  TX enabled: on
  TX active: on
  TX minimum fragment size: 64
  RX minimum fragment size: 60
  Verify enabled: on
  Verify time: 128
  Max verify time: 128
  Verification status: SUCCEEDED

Verified that the fields value are retrieved correctly.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 14 ++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 081e24f228b2..7f0052e0d50c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1782,6 +1782,19 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
+static int igc_ethtool_get_mm(struct net_device *netdev,
+			      struct ethtool_mm_state *cmd)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct fpe_t *fpe = &adapter->fpe;
+
+	ethtool_mmsv_get_mm(&fpe->mmsv, cmd);
+	cmd->tx_min_frag_size = fpe->tx_min_frag_size;
+	cmd->rx_min_frag_size = IGC_RX_MIN_FRAG_SIZE;
+
+	return 0;
+}
+
 static int igc_ethtool_set_mm(struct net_device *netdev,
 			      struct ethtool_mm_cfg *cmd,
 			      struct netlink_ext_ack *extack)
@@ -2093,6 +2106,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_rxfh		= igc_ethtool_set_rxfh,
 	.get_ts_info		= igc_ethtool_get_ts_info,
 	.get_channels		= igc_ethtool_get_channels,
+	.get_mm			= igc_ethtool_get_mm,
 	.set_mm			= igc_ethtool_set_mm,
 	.set_channels		= igc_ethtool_set_channels,
 	.get_priv_flags		= igc_ethtool_get_priv_flags,
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index 898c4630bc70..c82f9718cb85 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -4,6 +4,7 @@
 #ifndef _IGC_TSN_H_
 #define _IGC_TSN_H_
 
+#define IGC_RX_MIN_FRAG_SIZE		60
 #define SMD_FRAME_SIZE			60
 
 DECLARE_STATIC_KEY_FALSE(igc_fpe_enabled);
-- 
2.34.1


