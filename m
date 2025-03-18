Return-Path: <bpf+bounces-54263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CCEA666F2
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889917AB4CD
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 03:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5DB1C760A;
	Tue, 18 Mar 2025 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbzvvaRA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D421E4B2;
	Tue, 18 Mar 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267352; cv=none; b=CfirWpb/XIs6Hq7g24M7VapBcxZnsy0SFXFtlJUbsvpefVtdw4ZOFd+VFSTTTnPkw28NvZNNFgIMwUa+xMIQyEHmXe+93MuDIKR+ViH9T1ZUQUNkmD5uvoBliUNg6jom+uvOxCchZJXYkqLmril3KXddpgDZc4mbrO0wmfxw2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267352; c=relaxed/simple;
	bh=O0fK5/NJ16oq12TJBtAiaYUTMAWhtIJvsRgrDuLihXc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ee6q+xYJnneIbc334OAxS/VtlRYkIIG9z8xDHDYOZTlmpC0DipmxEtq3Fa+EXZEwfV/f/lpCacEehUjxm9BbNVAP4aPwCyiptqMy5sedB/QjEKic87ut9xGiIn1uEE6oZ0WQuLvmNDP6yQWOE9arhQnvMJE0d3LEyAIh8p01i30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbzvvaRA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742267351; x=1773803351;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=O0fK5/NJ16oq12TJBtAiaYUTMAWhtIJvsRgrDuLihXc=;
  b=kbzvvaRAyRaQmmlOucSO71tNH5GQx8lGWvD2Z9SLWzIzkc92ELChGLvK
   5pOgiMG9ZuoC1wV+cLSjot4xaW+dk4LgsyBZrm+0KIh+jreJ8RA61p4Le
   01QyBa1xs3iVJ8Zfk7NNVml629QxLfXqEr1Mmpz8c3uq0bG7Jaebfg+EF
   5feC9AnlUFnTFar030nykX6OUbjaWt+iH+hmiFdKwp7Xu3SPmVi32JfxX
   h5cV2HYprPs4LSH/XFvRKvHkUFuJOQHg/FWFrTOVOIxmWXO3a6Fgwax9f
   hRB4tJqf1Qkh7JtyzRFArRVR8V2xtjxh1+1emxfCF8wHCstnO+B58T+FJ
   g==;
X-CSE-ConnectionGUID: zRTiAeOWS4qWAqx345OpfA==
X-CSE-MsgGUID: vqW8uy7fT8qxeTxSi5ZmGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54382992"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54382992"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:09:10 -0700
X-CSE-ConnectionGUID: lymCxIyuRPicsXPF/Gr7Dw==
X-CSE-MsgGUID: FYsgDx6pTFWhjwheNf0n3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126313844"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa003.fm.intel.com with ESMTP; 17 Mar 2025 20:09:02 -0700
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
Subject: [PATCH iwl-next v10 06/14] igc: use FIELD_PREP and GENMASK for existing TX packet buffer size
Date: Mon, 17 Mar 2025 23:07:34 -0400
Message-Id: <20250318030742.2567080-7-faizal.abdul.rahim@linux.intel.com>
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
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index b6744ece64f0..b180e1497cc5 100644
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
2.34.1


