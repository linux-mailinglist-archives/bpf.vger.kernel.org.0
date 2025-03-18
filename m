Return-Path: <bpf+bounces-54262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B77A66702
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE80519A25E1
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A561C5F0A;
	Tue, 18 Mar 2025 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRMVhL9a"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A4199FD0;
	Tue, 18 Mar 2025 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267344; cv=none; b=fUU26/Sj48o82bdZd3Ullg5hRKvZXwy53h2Qr7Gt3OVuQ03Fmk4RymWyC2eB7zophksn+fwtvPiyCPWqmOJyuBQFUt0uaEReksISJimQKiocPvYrW0Tl6ZRJK44F5ikjkj0RINOTe4yalaV8AEenvhJKiAjPiXLfQXqocebLNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267344; c=relaxed/simple;
	bh=cRb+CbjWo0ZjK0e4vuvO/MeSF/KtBDAkMvyjIUZVP0Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNVB6rw2g6y7rTnImfSIu5VtVRhWmYfPvFVcuqu39qhQA4IgtITVvbieI59mxYhxr1KVekWxVYGbLukalQ9IV1hGfy+fSizpj1JIUTO4vwkCRhUlFon/qPBMAWuQK3P1aAnjfAB3GDJE6S3dSiFmpKiwcOLZQtKmRJR7ktZAGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRMVhL9a; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742267343; x=1773803343;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cRb+CbjWo0ZjK0e4vuvO/MeSF/KtBDAkMvyjIUZVP0Y=;
  b=FRMVhL9av5aicfXTQLX/RisbwJ4+NZr5yI3ScPkoA9o0Z/PpbL122O2e
   hFsoltAKCUxYs0skfeJ8mqCGnkJ+ou/uf3VrJ4kVj/It0gr3l5oq/3w3F
   qVeW5BM6STr9prXVNHUnujBPNThUNfswFbZYhpsEQ35Nda6saSGzL5V+y
   2GxQObc3HeIiJE5fW5gbYCLoEioN0JqwSdkQJd/mvf416x8mlQiQYm8u7
   8NovkdVX5y4RE2ZG9uqzMzfUbvD4HmGUfbVZeXlc8nmwimvkHyfP3Rm1R
   HcForriTEliyDshW0fw6FzyUdTIQRMSnPWs5DTnHWvd+HyeU1Bb5c5xpv
   g==;
X-CSE-ConnectionGUID: +Nqqd97wTxqCKwvcE833kQ==
X-CSE-MsgGUID: drxbw7h5TFCbTg0Ndy3Buw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54382976"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54382976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:09:02 -0700
X-CSE-ConnectionGUID: 6ScQ+CC6QASbNGSWqJ1K2Q==
X-CSE-MsgGUID: 8G7UL6nyQd65/FtNHfjpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126313814"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa003.fm.intel.com with ESMTP; 17 Mar 2025 20:08:55 -0700
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
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH iwl-next v10 05/14] igc: rename I225_RXPBSIZE_DEFAULT and I225_TXPBSIZE_DEFAULT
Date: Mon, 17 Mar 2025 23:07:33 -0400
Message-Id: <20250318030742.2567080-6-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename RX and TX packet buffer size macros in preparation for an
upcoming patch that will refactor buffer size handling using FIELD_PREP
and GENMASK.

Changes:
- Rename I225_RXPBSIZE_DEFAULT to IGC_RXPBSIZE_EXP_BMC_DEFAULT.
  The EXP_BMC suffix explicitly indicates Express and BMC buffer
  default values, improving readability and reusability for the
  upcoming changes, while also better reflecting the current buffer
  allocations.
- Rename I225_TXPBSIZE_DEFAULT to IGC_TXPBSIZE_DEFAULT.

These registers apply to both i225 and i226, so using the IGC prefix
aligns with existing macro naming conventions.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 7 ++++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 4 ++--
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8e449904aa7d..b6744ece64f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -396,9 +396,10 @@
 #define IGC_RCTL_PMCF		0x00800000 /* pass MAC control frames */
 #define IGC_RCTL_SECRC		0x04000000 /* Strip Ethernet CRC */
 
-#define I225_RXPBSIZE_DEFAULT	0x000000A2 /* RXPBSIZE default */
-#define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
-#define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
+/* RXPBSIZE default value for Express and BMC buffer */
+#define IGC_RXPBSIZE_EXP_BMC_DEFAULT	0x000000A2
+#define IGC_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
+#define IGC_RXPBS_CFG_TS_EN		0x80000000 /* Timestamp in Rx buffer */
 
 #define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 99123eef610b..6f0110e3ac22 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7156,8 +7156,8 @@ static int igc_probe(struct pci_dev *pdev,
 	}
 
 	/* configure RXPBSIZE and TXPBSIZE */
-	wr32(IGC_RXPBS, I225_RXPBSIZE_DEFAULT);
-	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
+	wr32(IGC_RXPBS, IGC_RXPBSIZE_EXP_BMC_DEFAULT);
+	wr32(IGC_TXPBS, IGC_TXPBSIZE_DEFAULT);
 
 	timer_setup(&adapter->watchdog_timer, igc_watchdog, 0);
 	timer_setup(&adapter->phy_info_timer, igc_update_phy_info, 0);
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 1e44374ca1ff..498741d83ca6 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -136,7 +136,7 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	int i;
 
 	wr32(IGC_GTXOFFSET, 0);
-	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
+	wr32(IGC_TXPBS, IGC_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
 	if (igc_is_device_id_i226(hw))
-- 
2.34.1


