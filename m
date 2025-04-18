Return-Path: <bpf+bounces-56244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38923A93B18
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0708A44647D
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6921C9F0;
	Fri, 18 Apr 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk9zEWpb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57E214225;
	Fri, 18 Apr 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994321; cv=none; b=NH3/9XHD9YQTibNYR/LdwUaha3P+8X1iajlhkFmWfT7777T7qhQrSq5AwmtnxEGrUt/rVhuxXxAdhTuiF1LZSj6pi5osoHxJVHN4zyjDUJsSraK4keXoxhU4dnX9tNqC5pXmrK3QJ9mf6wBzk+wtr+TUXWowpuJmzUhKbO/mJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994321; c=relaxed/simple;
	bh=2hcr7RkzabYlbqbjd/UmRQGPg75CpH7103MgtxpOV5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOpKl8xidaUL91xDOsj6rupCw2n9vQrxhcuZ+3DqRxzc/6zMl1Uh1fYqutvoOtHy0Txqlz19j3LBWdJdFT7+GgU/XbUJhk9H1zfDFxo2dbdmJ4lYt/b+7ndATjKSGUWamqor7j1J7IndlxjAj/6epwkAyxkzInwgaQEyLJJi9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk9zEWpb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994320; x=1776530320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hcr7RkzabYlbqbjd/UmRQGPg75CpH7103MgtxpOV5U=;
  b=Hk9zEWpb5U2YGYZvo+q6j6fs+zf+xUBg+xa6RENgUJkRafRU1uCp0Aes
   VcGLPlJDCLvn+NOx9W8ow40/c32HDlT3niEtiEraPHovjW4k4K1JowaVc
   9IvC02v+Mptkd6pa61Y6LBPgdwr8TZTNybd95CzB+YWWsx3Ti90Si3Kdc
   qglEp7kt8O5EDOhFpsgzMHXBumvJ0bd9AWXV9X0ztZOW6gNmmWcjp53rk
   BdQwTvSjnUKrKItzgRaC9CnDdjUPObPm4DTtKLNKvDLqXv9uIOEcEwr8W
   ZpWcItpdUxgqakiZAVCb6P8Zo7tFURobh0Ey7EZbPVnAWn8IEXhNtV7Wy
   w==;
X-CSE-ConnectionGUID: SEDBQARKTVmcrIFEfl5mPg==
X-CSE-MsgGUID: iJPAu37LTYeT/UbWyxl1oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454392"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454392"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:36 -0700
X-CSE-ConnectionGUID: IStYbDlET/60oIESx3FNNg==
X-CSE-MsgGUID: 5y2ycaERQ4ykVJ2he9yAeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892266"
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
Subject: [PATCH net-next 07/14] igc: optimize TX packet buffer utilization for TSN mode
Date: Fri, 18 Apr 2025 09:38:13 -0700
Message-ID: <20250418163822.3519810-8-anthony.l.nguyen@intel.com>
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

In preparation for upcoming frame preemption patches, optimize the TX
packet buffer size. The total packet buffer size (RX + TX) is 64KB, with
a maximum of 34KB for either RX or TX. Split the buffer evenly,
allocating 32KB to each.

For TX, assign 7KB to each of the four TX packet buffers (total 28KB)
and reserve 4KB for BMC.

References:
I225/I226 SW User Manual Section 4.7.9, Section 8.3.2

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index ec8f926362eb..5502edd6261f 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -419,8 +419,8 @@
 	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
 	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
 #define IGC_TXPBSIZE_TSN ( \
-	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
-	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
+	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
+	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.47.1


