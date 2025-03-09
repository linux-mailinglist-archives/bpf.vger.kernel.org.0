Return-Path: <bpf+bounces-53678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6419A5837E
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C0B3AF61E
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F41D7E4F;
	Sun,  9 Mar 2025 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAkWKDmh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864C1C5D5B;
	Sun,  9 Mar 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517349; cv=none; b=dZ/U95pMr1QzrVMf18FeFAVq15RhdufcZHOUFpJDGIeDT0K+ICVPkt8/z4/kIltSD5Q0p8+HswK9mz088EhPJQQArAYaE8HZy/GVpVptA2TtxeR3S5bcEGDSX8e2hPSialhTN+QhicGVCCDD8SbM9ZIqFAversUSYLuwrmN8f18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517349; c=relaxed/simple;
	bh=6TymkuK2Y51ayMl9JT+5/O1CpZULriSQpMIEcVYEhNc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeY39P4M4u8BviQB+Ldm3hvBO3fxURFULgia/DU2BrThttRNel8d3Gx1fkkxYLkNgGP+Az7GSi26qJm+GGmZXI2O7HHm3JBKqFtAuWdMyF+SJOm5soD5luotDOwRu2/YgqdoMRl5RHEim+oFTX9bCYYcrSaLTAF4FPaEOtulCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAkWKDmh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741517349; x=1773053349;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6TymkuK2Y51ayMl9JT+5/O1CpZULriSQpMIEcVYEhNc=;
  b=nAkWKDmhXab7QuFkTvfFk5zf4mZdHCqFYLLtG8VisKPJs+N+qXtEkhaq
   s1/pj71f4nmXenTEWouahzDBCfLlPju/Z8cwBq9B1N3uUodSyMf+N/9dA
   Pb6iKQGfCfkDpbnLLmDlfv3aRGFSeHSzk4xISAmyGyeFATZJE87hMCZgE
   K+oRctRN8sSkHNWVVIXvovL58toaeUbXTo8dnGTB+HPgPzQX/dEQFq4B2
   0BwOz9zaxqtbcYPzydxqBDIldvca1gxuILSnxEKYIz8iOsiR/yJMf7FIb
   gMJg1VbBOl55llXwzP0OVtAxjYAWMEqYu7KTxGZNJk4qX4pqNix+et8UU
   A==;
X-CSE-ConnectionGUID: 4Wl8pSJASYuUydA3NezPmg==
X-CSE-MsgGUID: pYmeh7FhRbecH1Z8/OHbGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42636244"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42636244"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 03:49:08 -0700
X-CSE-ConnectionGUID: CIETKKlOScyYVVZE/Yw8Tw==
X-CSE-MsgGUID: Y5raPSEpQmqkIMkyPaf2Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124655180"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa003.jf.intel.com with ESMTP; 09 Mar 2025 03:49:00 -0700
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v9 13/14] igc: add support to get MAC Merge data via ethtool
Date: Sun,  9 Mar 2025 06:46:47 -0400
Message-Id: <20250309104648.3895551-14-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
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
index 529654ccd83f..fd4b4b332309 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1782,6 +1782,19 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
+static int igc_ethtool_get_mm(struct net_device *netdev,
+			      struct ethtool_mm_state *cmd)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct igc_fpe_t *fpe = &adapter->fpe;
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
@@ -2101,6 +2114,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_link_ksettings	= igc_ethtool_get_link_ksettings,
 	.set_link_ksettings	= igc_ethtool_set_link_ksettings,
 	.self_test		= igc_ethtool_diag_test,
+	.get_mm			= igc_ethtool_get_mm,
 	.set_mm			= igc_ethtool_set_mm,
 };
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index 58fe5f0773d7..c2a77229207b 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -4,6 +4,7 @@
 #ifndef _IGC_TSN_H_
 #define _IGC_TSN_H_
 
+#define IGC_RX_MIN_FRAG_SIZE		60
 #define SMD_FRAME_SIZE			60
 
 enum igc_txd_popts_type {
-- 
2.34.1


