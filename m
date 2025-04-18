Return-Path: <bpf+bounces-56239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99ECA93B11
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF157ADA5E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2621170D;
	Fri, 18 Apr 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElLg237o"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B42215792;
	Fri, 18 Apr 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994318; cv=none; b=cfQLUvaf7NQzpj0m8EI9fZQZS1FmHqzPSMlv7hu4OwKyUnnVhSdOpDnRM2+s5HGt6bwS9a98XLTihsP2xqfc1I12ip+Ep83EqL92D1YC8C7jqtlWIRe+SXzyiyGq0oVt3AI2QAW21XaD8Ytt0vvRfA4UF5p2oICT3WvqDGghPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994318; c=relaxed/simple;
	bh=AtORh+C/RnJb7OaKXNfLBopb4E8qh/pXxldrFvkHkzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYwXEuKpujTexZ6EpPhFAb2Umb+ezrV/oCb93Lr/7jzKmRXKQQ2rQnFwb9HjFKWK6TK2KPZG7HHJiEv0DYb4U/GaZoAHKWbNL7x2dgN8aa+dHSWzPIJpOzeXl16Xc66wu5O2DBFEjriyuOejH2nwhkCiIZnzG8ZoSjI/JqJPDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElLg237o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994316; x=1776530316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AtORh+C/RnJb7OaKXNfLBopb4E8qh/pXxldrFvkHkzU=;
  b=ElLg237oyy4nGh6jZjuZDBVIzgH+gViT/aJGeYO8Y4KFu44Xxwx+MhLV
   S9DXR9XkUMM1C32UyKSQ8Jjr49JJdw+jrKZMeFhRcUfrs+tfVmVZDPf33
   1rhKAH242qJGLugQy7/eTmeWCBzGM33e7utBV+KQrKV4gHAMiVBPDHICQ
   iIl9t/A2LRSt611IY50ryLpBYuXbNa5Ngdxi9YhfGcyCbZBYOh4O91cYC
   6gVaZ9Y0uXpDuQFOCn7EfKXDXlcvuLtVtrvWLvl6l/u/rTim+bdSaZ5Bh
   ykhBU0GabRuewtMaUZWFGu+QV7UH4uoSmO6uvzPATBllzmYxh9kgctgJB
   Q==;
X-CSE-ConnectionGUID: DfDOKDIvTOSyU2RGJAHcuw==
X-CSE-MsgGUID: e98KrQ3DTjqRHEGQxPbcrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454304"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454304"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:34 -0700
X-CSE-ConnectionGUID: j8lM+5MhSPaoaOGxcyCz4Q==
X-CSE-MsgGUID: zpLoSDBVRjiVUq3GJybrwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892238"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:33 -0700
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
	bpf@vger.kernel.org
Subject: [PATCH net-next 03/14] net: ethtool: mm: reset verification status when link is down
Date: Fri, 18 Apr 2025 09:38:09 -0700
Message-ID: <20250418163822.3519810-4-anthony.l.nguyen@intel.com>
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

When the link partner goes down, "ethtool --show-mm" still displays
"Verification status: SUCCEEDED," reflecting a previous state that is
no longer valid.

Reset the verification status to ensure it reflects the current state.

Reviewed-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 net/ethtool/mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index bfd988464d7d..ad9b40034003 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -415,6 +415,10 @@ void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
 		/* New link => maybe new partner => new verification process */
 		ethtool_mmsv_apply(mmsv);
 	} else {
+		/* Reset the reported verification state while the link is down */
+		if (mmsv->verify_enabled)
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+
 		/* No link or pMAC not enabled */
 		ethtool_mmsv_configure_pmac(mmsv, false);
 		ethtool_mmsv_configure_tx(mmsv, false);
-- 
2.47.1


