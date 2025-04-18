Return-Path: <bpf+bounces-56243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC6A93B13
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292B6189DE73
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A021C163;
	Fri, 18 Apr 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHjRjKgi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0E219EAD;
	Fri, 18 Apr 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994321; cv=none; b=ZOF1gtMlX2UNxR9y7ubtEr9cor/itZKTdqk3R0dJOg7Ks5r7ah5lEof2UtpeDy6NyeAGeAEwsbM+zlJBGPiu0qEG+1iliPUzzDCuwnCgZa6XUuKT+LNKtiMhDPyoV5yC5XtGHe17ijNCwnr50pp0cFKPHidXI0tFEDr3RQ/yKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994321; c=relaxed/simple;
	bh=QL8UnrxzhOjr9Cxq9AJgHKXXFDVi01UtywCQhOOKU4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG3+ZaiLmEYdfJS05XeD8XKTW/aWpCvv5GOi1XOsC6Utgw2hKVDV1Yi6gJldySoxhNQbCQTCJMEaZgRQvuKBmJSlIy+tWX7TIMg/pvCCMZ6tjlCAd6x86/DJkcoCuIsa9pWbRok8lDjCdue59zYyUhf2m04/m6aRAH3vAbzmg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHjRjKgi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994319; x=1776530319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QL8UnrxzhOjr9Cxq9AJgHKXXFDVi01UtywCQhOOKU4s=;
  b=gHjRjKgi12jCIHMezRtNYpY36kbeVQUM9J5UOcKh/NLDOP8zHGwX39CP
   4NkWJcJD5r+MezXeZBi/fQdX6z5ca47+YnvEpJE+1kxAgvzmikTqwxGa4
   1+kjEXnbRTtA0U/IM/sgd4BoMEYHUWsM2bUUY+bK00yg5WlOIw5wHd3Ka
   W/PFac6E92MJVlDV7XjRReaUFN0gxl/VIJB0IIatPuA8qqObn4+0fgOgv
   Dbfj3CVNttg/cMgSSU9gtmKD1oSkou+M4BHWNJ+uXg7z+8x8Kbg72YL8E
   xcbhm/IzsprSKguzUlm8q6RWw+50TaiDANmEAfS/kD31FweobxsoCYO6F
   Q==;
X-CSE-ConnectionGUID: LtbWn616S6CYH/SJ6aMWoQ==
X-CSE-MsgGUID: vYd9FXpASUKToACW6dhtBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454366"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454366"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:35 -0700
X-CSE-ConnectionGUID: ewWXYFpNT8a5NZBC4ftn7Q==
X-CSE-MsgGUID: cyKMxUMgTzSlCh/Mk596Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892259"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	przemyslaw.kitszel@intel.com,
	chwee.lin.choong@intel.com,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	xiaolei.wang@windriver.com,
	hayashi.kunihiko@socionext.com,
	ast@kernel.org,
	jesper.nilsson@axis.com,
	mcoquelin.stm32@gmail.com,
	rmk+kernel@armlinux.org.uk,
	fancer.lancer@gmail.com,
	kory.maincent@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	hkelam@marvell.com,
	alexandre.torgue@foss.st.com,
	daniel@iogearbox.net,
	linux-arm-kernel@lists.infradead.org,
	hawk@kernel.org,
	quic_jsuraj@quicinc.com,
	gal@nvidia.com,
	john.fastabend@gmail.com,
	0x1207@gmail.com,
	bpf@vger.kernel.org,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 06/14] igc: use FIELD_PREP and GENMASK for existing TX packet buffer size
Date: Fri, 18 Apr 2025 09:38:12 -0700
Message-ID: <20250418163822.3519810-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
References: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

In preparation for an upcoming patch that will modify the TX buffer size
in  TSN mode, replace IGC_TXPBSIZE_TSN and IGC_TXPBSIZE_DEFAULT
implementation with new macros that utilizes FIELD_PREP and GENMASK for
clarity.

The newly introduced macros follow the naming from the i226 SW User Manual
for easy reference.

I've tested IGC_TXPBSIZE_TSN and IGC_TXPBSIZE_DEFAULT before and after the
refactoring, and their values remain unchanged.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 34b3b1a7610e..ec8f926362eb 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -398,10 +398,29 @@
 
 /* RXPBSIZE default value for Express and BMC buffer */
 #define IGC_RXPBSIZE_EXP_BMC_DEFAULT	0x000000A2
-#define IGC_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
 #define IGC_RXPBS_CFG_TS_EN		0x80000000 /* Timestamp in Rx buffer */
 
-#define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
+/* Mask for TX packet buffer size */
+#define IGC_TXPB0SIZE_MASK		GENMASK(5, 0)
+#define IGC_TXPB1SIZE_MASK		GENMASK(11, 6)
+#define IGC_TXPB2SIZE_MASK		GENMASK(17, 12)
+#define IGC_TXPB3SIZE_MASK		GENMASK(23, 18)
+/* Mask for OS to BMC packet buffer size */
+#define IGC_OS2BMCPBSIZE_MASK		GENMASK(29, 24)
+/* TX Packet buffer size in KB */
+#define IGC_TXPB0SIZE(x)		FIELD_PREP(IGC_TXPB0SIZE_MASK, (x))
+#define IGC_TXPB1SIZE(x)		FIELD_PREP(IGC_TXPB1SIZE_MASK, (x))
+#define IGC_TXPB2SIZE(x)		FIELD_PREP(IGC_TXPB2SIZE_MASK, (x))
+#define IGC_TXPB3SIZE(x)		FIELD_PREP(IGC_TXPB3SIZE_MASK, (x))
+/* OS to BMC packet buffer size in KB */
+#define IGC_OS2BMCPBSIZE(x)		FIELD_PREP(IGC_OS2BMCPBSIZE_MASK, (x))
+/* Default value following I225/I226 SW User Manual Section 8.3.2 */
+#define IGC_TXPBSIZE_DEFAULT ( \
+	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
+	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
+#define IGC_TXPBSIZE_TSN ( \
+	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
+	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.47.1


