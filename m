Return-Path: <bpf+bounces-66466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B6B34E69
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8BD1B26253
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284692BE027;
	Mon, 25 Aug 2025 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS8k6hXE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40129C347;
	Mon, 25 Aug 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158629; cv=none; b=aO28i3oPPaCBqV/rCL1bPMR4w00M2cgNWgVzJZ0Tur9r4uNE95/vLVCQ1QaQIT6eVzSz/NpPaYkXk5u7WJmdKStR3u3aLcJA66I0ILZUgZ/CuPUKdgyRTQNGHPIsmjZpmWCIeVghEgVxNT96ED/o5v1uVuTgcfC0qPTwWsLNrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158629; c=relaxed/simple;
	bh=yqT77UmSyx1t5MdTAmBqXhxoquf9o2RBAKSoO5Qxf6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2haghIu/PCfZmmkS71izi4r/jVyhWzpRBAA1h/T6GQlEInJJdd45dwfAI48r08SBOV+fdACLbivZaWddb3TupBZlek1aTfJuOPoXpdo8K4RClnYenTtPjMNE/SZy30jrI5k1Q1Y8cnO6LPkgr8sQuR7KhQM6gXfWG3u9w7RJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS8k6hXE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158628; x=1787694628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqT77UmSyx1t5MdTAmBqXhxoquf9o2RBAKSoO5Qxf6w=;
  b=kS8k6hXEyva0l5C+OtsIX+OERN+NjtPKCLh0hIH+zJ0HrpNcMcia6PTa
   bDzdy+Ymt54hukL0t4SKejIsPXtZsd76Bg1te67YKQ4ve+GWz2QdhM3Xs
   43EE6iQ5EBxHDqqHOfHykdzZwCEvj95Q5qD+9ObKBy6Pc8zeF7qsYTuWa
   QB5aDjxSS+jclNE5y4oCojCzPSc7VCZqaTgkv3o+WNIRWxvmDi0Or5ncV
   ZratmTJNv9AXcpKxoV4r5bbmRaOaGMEdxaJcpZgAO0jEvbuqdGrTxl0NJ
   bmayY0vZKDPjlPJtdkKHlaqeCux1IMXzETSX4EJUhaBbQ8DO9NX74IvqD
   w==;
X-CSE-ConnectionGUID: jtQ76GifSAmYjJU4QgfSsg==
X-CSE-MsgGUID: qR7ZIp3wSf+jypH7JYzZyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68651382"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68651382"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:50:27 -0700
X-CSE-ConnectionGUID: YlvSeKPZTkOXq3TLkmIJdg==
X-CSE-MsgGUID: ASAvfhmjS1WqRABnFtpSCw==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 14:50:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Priya Singh <priyax.singh@intel.com>
Subject: [PATCH net 4/5] ice: fix incorrect counter for buffer allocation failures
Date: Mon, 25 Aug 2025 14:50:15 -0700
Message-ID: <20250825215019.3442873-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
References: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

Currently, the driver increments `alloc_page_failed` when buffer allocation fails
in `ice_clean_rx_irq()`. However, this counter is intended for page allocation
failures, not buffer allocation issues.

This patch corrects the counter by incrementing `alloc_buf_failed` instead,
ensuring accurate statistics reporting for buffer allocation failures.

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Priya Singh <priyax.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 29e0088ab6b2..d2871757ec94 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1352,7 +1352,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			skb = ice_construct_skb(rx_ring, xdp);
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
 			xdp_verdict = ICE_XDP_CONSUMED;
 		}
 		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
-- 
2.47.1


