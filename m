Return-Path: <bpf+bounces-56249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3179A93B24
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCB18A4446
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75CC222564;
	Fri, 18 Apr 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2SUrGMi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CC21506D;
	Fri, 18 Apr 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994325; cv=none; b=qiMbIIjTJtPrP5J0uap9LYCFOw/jH2Qjybj744jhLNhlnrhkD3DeTkW8Zv8ozkQGULVRTgKyS1OgjC166yr0mzB5c/ev7X3q+bFkgt8Ng1o0vYuv18AVX1bLsSLUf3Vt9MW1u/ipLUx2Sb6jXEg2sFgtSnGa/hfZkkeGWXY/Au4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994325; c=relaxed/simple;
	bh=JoqQNz8OLob/5bEzIJxMhxwCkynn9Yc2FkpHNkdjefY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me3zo31tmX5CwP07329WfyLXenzAimeXktrYhWcRFmshEyAJBH0mFBB6mo9IrcAtF0qV9LuzJMFZvVqo5bLg78CINL7Pl6NRWoqX6E2ltN1JfRAvlg+qhh1bODedfJbNd29ErZfFvhW3YAyiRPP4JfqIumNASKxWDm4P/gyLA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2SUrGMi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994324; x=1776530324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JoqQNz8OLob/5bEzIJxMhxwCkynn9Yc2FkpHNkdjefY=;
  b=a2SUrGMi7jsgPePE7GPbAlpam7Iyp+GlmPhXLEWU3IlaatCj9WylNbXQ
   7uL6Lh8IHHhcfKgF3lFdNL//rlHhdIeOSQcOw/4fsQfNnBxvFsQFKK/UL
   XKCIYPJoFESQRmiMRt3T9u8TJRACAzSjweHwVHoKjF0Basxhhx49M5fGw
   zkhoiT6eWRdhiRlf1IX587r56NOKBd3XcRl3kZw8t3ud0plpzdBSpglFo
   hMRb/Zknt1EopvbgAEJ1y7d2BIkOASx3oYPUZ9R/GVPMo+801y9o5x9da
   OjcejUK06YqUUF2EQ59LZoLk/HeCz+0LqKk1WEwCoAtYPMtlQ1jP9FljR
   g==;
X-CSE-ConnectionGUID: HR3KpahPQ7u+niuhWMVVvg==
X-CSE-MsgGUID: 5Rm392VjTPu0XlYKUF6SrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454507"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454507"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:38 -0700
X-CSE-ConnectionGUID: x5bhBfRWTI+VCkQSQ+uQfQ==
X-CSE-MsgGUID: RSZtZWK6R1exQ/h9PwPBrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892293"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:37 -0700
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
Subject: [PATCH net-next 12/14] igc: block setting preemptible traffic class in taprio
Date: Fri, 18 Apr 2025 09:38:18 -0700
Message-ID: <20250418163822.3519810-13-anthony.l.nguyen@intel.com>
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

Since preemptible tc implementation is not ready yet, block it from being
set in taprio. The existing code already blocks it in mqprio.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d160da49b0d2..5b06765a35e9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6486,6 +6486,10 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (!validate_schedule(adapter, qopt))
 		return -EINVAL;
 
+	/* preemptible isn't supported yet */
+	if (qopt->mqprio.preemptible_tcs)
+		return -EOPNOTSUPP;
+
 	igc_ptp_read(adapter, &now);
 
 	if (igc_tsn_is_taprio_activated_by_user(adapter) &&
-- 
2.47.1


