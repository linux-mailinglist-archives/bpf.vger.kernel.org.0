Return-Path: <bpf+bounces-56245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC55A93B1A
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CF48A2D04
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A52219EAD;
	Fri, 18 Apr 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APSexM6j"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384321ABC5;
	Fri, 18 Apr 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994322; cv=none; b=kKf2QJaKqah+r7Fp+GyxRRFEYCySnOqWev8ztSGIotdPr1217LdKdRE9Iq5KsIWZpZIyZowx1sqQRzWFMEvlnWFet/REBo3oUczw8sU5Oa13cz1fiqLFG+c7T8uDE5kSHXrtQ8+DmCIco744o/QV2J3LKMk77+de/3aRsdHqsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994322; c=relaxed/simple;
	bh=Q7xILmCUIdiQQUv2BVkO4pHZIFRPAtA5ohjA3TYi4Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSQKj2I5V1NaBUqNtULvtFgMQ7z41s0Huwv54uQFtlMa75M4q4TP2bzPeMkyrLzI7NC9yK7m1UNNhVKMhHQrJf8foCWZ/qJTB4NbzeHtm39sVXv4P2EFv3icOeMYji5+5My7YSuSCTI+vIIN/CO9C4oaLygBaWGDqyi+ZzzV/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APSexM6j; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994320; x=1776530320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7xILmCUIdiQQUv2BVkO4pHZIFRPAtA5ohjA3TYi4Dw=;
  b=APSexM6jDcQbVbRfeCjwLa8m5iriVlXZro/S98WMsatg/NPXBz0Za1r9
   QWBuGzKDs1i7KSO73iSpnnpnANYLapFfwMJdkK35EJFG5TjoZsDHHmv6v
   viqmDa6Tibss6UeA9J6qSmh/FI0BSrzXaDoJTEQz9OH9pHpx8pKtSXPD9
   X5oqWNl1+M04M7/gqQKPNdqL5jRzO2/vRCjwf7MJaYz2auEmac7HHyuay
   iczy+KQE0EgVB6RLf0O0NJ4JOEIkAkv87rqYv4CVR9WgpR75SGuc1Vsl9
   JpAg5lV86JH+NEyUfO/wbcl3tDhGGKJrh0nUPBYDo9Gdbo1M/sNs9wnuH
   A==;
X-CSE-ConnectionGUID: ngAc+fVrQE29qDHN601HQQ==
X-CSE-MsgGUID: SR7/MPSwQhe57QPa/ydSkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454412"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454412"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:36 -0700
X-CSE-ConnectionGUID: bUoT+eHZQxO+bo78FB1r8w==
X-CSE-MsgGUID: QPxAPYuNQympF3jUo5HBDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892274"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:35 -0700
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
Subject: [PATCH net-next 08/14] igc: use FIELD_PREP and GENMASK for existing RX packet buffer size
Date: Fri, 18 Apr 2025 09:38:14 -0700
Message-ID: <20250418163822.3519810-9-anthony.l.nguyen@intel.com>
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

Prepare for an upcoming patch that modifies the RX buffer size in TSN mode.
Refactor IGC_RXPBSIZE_EXP_BMC_DEFAULT and IGC_RXPBS_CFG_TS_EN using
FIELD_PREP and GENMASK to improve clarity and maintainability. Refactor
both macros for consistency, even though the upcoming patch only use
IGC_RXPBSIZE_EXP_BMC_DEFAULT.

The newly introduced macros follow the naming from the i226 SW User Manual
for easy reference.

I've tested IGC_RXPBSIZE_EXP_BMC_DEFAULT and IGC_RXPBS_CFG_TS_EN before
and after the refactoring, and their values remain unchanged.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 5502edd6261f..12a16a7acb03 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -396,9 +396,20 @@
 #define IGC_RCTL_PMCF		0x00800000 /* pass MAC control frames */
 #define IGC_RCTL_SECRC		0x04000000 /* Strip Ethernet CRC */
 
-/* RXPBSIZE default value for Express and BMC buffer */
-#define IGC_RXPBSIZE_EXP_BMC_DEFAULT	0x000000A2
-#define IGC_RXPBS_CFG_TS_EN		0x80000000 /* Timestamp in Rx buffer */
+/* Mask for RX packet buffer size */
+#define IGC_RXPBSIZE_EXP_MASK		GENMASK(5, 0)
+#define IGC_BMC2OSPBSIZE_MASK		GENMASK(11, 6)
+/* Mask for timestamp in RX buffer */
+#define IGC_RXPBS_CFG_TS_EN_MASK	GENMASK(31, 31)
+/* High-priority RX packet buffer size (KB). Used for Express traffic when preemption is enabled */
+#define IGC_RXPBSIZE_EXP(x)		FIELD_PREP(IGC_RXPBSIZE_EXP_MASK, (x))
+/* BMC to OS packet buffer size in KB */
+#define IGC_BMC2OSPBSIZE(x)		FIELD_PREP(IGC_BMC2OSPBSIZE_MASK, (x))
+/* Enable RX packet buffer for timestamp descriptor, saving 16 bytes per packet if set */
+#define IGC_RXPBS_CFG_TS_EN		FIELD_PREP(IGC_RXPBS_CFG_TS_EN_MASK, 1)
+/* Default value following I225/I226 SW User Manual Section 8.3.1 */
+#define IGC_RXPBSIZE_EXP_BMC_DEFAULT ( \
+	IGC_RXPBSIZE_EXP(34) | IGC_BMC2OSPBSIZE(2))
 
 /* Mask for TX packet buffer size */
 #define IGC_TXPB0SIZE_MASK		GENMASK(5, 0)
-- 
2.47.1


