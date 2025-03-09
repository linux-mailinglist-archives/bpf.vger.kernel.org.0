Return-Path: <bpf+bounces-53673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CBA58372
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 11:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565D81893870
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A371CBA18;
	Sun,  9 Mar 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1s/kDOx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688111C68BE;
	Sun,  9 Mar 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517311; cv=none; b=MVnBPthW5F6IM4h2y2a9K0ot1Q3HH/9/IdjOf5125BhUKq8mL5KKHFjRWgxYnZzO4k5eqsKIoRG6HNwCEWVX90nqGMlKwk9deCBYhXEcTFwOwRVpUE/P48BlVljz2Plq/e9C/8p7KEfF1m1uutAJlI2U+pvz8Hg1TqQmg7guwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517311; c=relaxed/simple;
	bh=Ocq5e0cvJCj6sSblL8b9kb+v9HOHoUW+NcBfEhCLAg4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGb/5Hpvrwv1q+hGmmwqsLY7iy0SQ7JI/3r12D2m6lS2NMJLUMqE/WHyliazENewhNq/h0QgibvFWaP6m0sVPW9lS++nEYXLxW8vqx5uKMCcu3ahz8PttqeEU0L3n9Azhm/RlJk/+szIKkXTFX/vI/TYysiRXVlOdFuU6mT9BTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1s/kDOx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741517310; x=1773053310;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Ocq5e0cvJCj6sSblL8b9kb+v9HOHoUW+NcBfEhCLAg4=;
  b=M1s/kDOxblojHQ1GuPsr6t90zOxzQfiQznkh2XqnW7ehhvp+7g72jcSG
   ojRe/au2QGkITfsbxrN84kj3xlaMInQfoLM8l9vb/yKvrq6siYD1Zpb9j
   i17ANUH/ejZFMpNdZSvBJUUoMcKn7coqQJFd5q024NznJD3ID9jrScbk8
   eLJv99KyrZ3+K+4POUIdeLJtdOSPaErL2QS4BGehXbdbDbgk5xvezpQ/V
   6fncbn1tq3Tjq2qlNzqXOdf/E41ZJKsCHggVkl3H9RCM0HcboqP8s03Yt
   G8PjWWFcXZIyKd77DLQC0IQJVFI4RuFx0RE0g/5ZuP/LaOTxLJaeOKT7G
   Q==;
X-CSE-ConnectionGUID: QFpLFD2KRbyXWLzIj1locA==
X-CSE-MsgGUID: uJiVV2BwRDyprvmLVAA3EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42636131"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42636131"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 03:48:29 -0700
X-CSE-ConnectionGUID: bA9EKfNKRpuXm3mKYtZVlg==
X-CSE-MsgGUID: IHMZ2A0sRnSSqUpzMYSp8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124655116"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa003.jf.intel.com with ESMTP; 09 Mar 2025 03:48:21 -0700
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
Subject: [PATCH iwl-next v9 08/14] igc: use FIELD_PREP and GENMASK for existing RX packet buffer size
Date: Sun,  9 Mar 2025 06:46:42 -0400
Message-Id: <20250309104648.3895551-9-faizal.abdul.rahim@linux.intel.com>
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

Prepare for an upcoming patch that modifies the RX buffer size in TSN mode.
Refactor IGC_RXPBSIZE_EXP_BMC_DEFAULT and IGC_RXPBS_CFG_TS_EN using
FIELD_PREP and GENMASK to improve clarity and maintainability. Refactor
both macros for consistency, even though the upcoming patch only use
IGC_RXPBSIZE_EXP_BMC_DEFAULT.

The newly introduced macros follow the naming from the i226 SW User Manual
for easy reference.

I've tested IGC_RXPBSIZE_EXP_BMC_DEFAULT and IGC_RXPBS_CFG_TS_EN before
and after the refactoring, and their values remain unchanged.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index db937931c646..3564d15df57b 100644
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
2.34.1


