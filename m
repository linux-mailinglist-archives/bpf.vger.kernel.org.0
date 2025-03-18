Return-Path: <bpf+bounces-54269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D13A6670C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA35F17F538
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 03:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6741C3BF7;
	Tue, 18 Mar 2025 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu4H9LEK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853D1C2324;
	Tue, 18 Mar 2025 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267400; cv=none; b=Y8QKOCW66YR4xYJ88ujAsOD0kdMLTVGERLAY+PqzYcYzbRffcEKfvGlWNZLDe1c+JiOZpeQS4ZoCmy4Koo4oZ8P3c5BpKcHxBDQw/cXkUlk4V41JvTrbmBbLPA+5gcW7N4+Fml76aAQA9NGzsgScUY6cWtK+macg1Q8A+mGV11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267400; c=relaxed/simple;
	bh=eqmri3Iwl67FhzCmnSw7Lyi9yy0ti1/vr/CkBiBk4bg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXhQ9u6j5j1bjCf4zfTH1FmMrwZvarHeLPb5fNM6Fk8zoXf3xSvvZtwSsZ7FlZr8IZQMc7c7fkyaLKKo4yDAsfde8I+bEPc5eSe1XtNoCJvKHUtm3iU8FYWA7Ev0Eggv5RJUbAcs27aui/zB7u5h3g0i31/se/Vor7ySwjkGfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu4H9LEK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742267398; x=1773803398;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eqmri3Iwl67FhzCmnSw7Lyi9yy0ti1/vr/CkBiBk4bg=;
  b=Mu4H9LEKti4B/1nEZdGHn9lRQuLvjMZLzSBHPWIrKw/BmwUbMaekGdjA
   HG14CY1Gb+gf7bUovJh8LoarlnJ/B8tYhsxOTWuYRH/Yj180qmT0SMYF9
   asAL8hhaO3gKDGbazLzAuaOoVoErVVX+ZueX1Ejg8OI21YrERYaCEiLke
   lulYixveJqmPDmVfzN7cRzSFm/cSqJgSpUUGB9u3KgEDeKdXfQXVLi459
   W8gKZiUfjkEtEWFG5yGP2xV2iYmg7HPhUU+gsUZLFQhPeA4Hvzw+WcJWi
   6MaB/wvD9EYG/W3rMB42DMt6NXnBDElzlmN4Z8AaaOTH0CHXlQl7wsKPO
   A==;
X-CSE-ConnectionGUID: HTAs0P6oSdyK2GMsYUhAAw==
X-CSE-MsgGUID: dSWlwhWTS/uGsYaso1LYFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54383229"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54383229"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:09:57 -0700
X-CSE-ConnectionGUID: YnI1J2mKQ2ielu1L2PHNDA==
X-CSE-MsgGUID: 22AG3oJXQ4yLx1T4dZ6HFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126313953"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa003.fm.intel.com with ESMTP; 17 Mar 2025 20:09:50 -0700
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
Subject: [PATCH iwl-next v10 12/14] igc: block setting preemptible traffic class in taprio
Date: Mon, 17 Mar 2025 23:07:40 -0400
Message-Id: <20250318030742.2567080-13-faizal.abdul.rahim@linux.intel.com>
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

Since preemptible tc implementation is not ready yet, block it from being
set in taprio. The existing code already blocks it in mqprio.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 71c377cb7a88..fc945c5b7c70 100644
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
2.34.1


