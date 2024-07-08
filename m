Return-Path: <bpf+bounces-34150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6F92ABD6
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED431F22F95
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8909152176;
	Mon,  8 Jul 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2v9XHOk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261D14F9F0;
	Mon,  8 Jul 2024 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476872; cv=none; b=lNzuhmdIc9gR85uEUG6Sd9/UlR8HkV4Hv5EM1Uf2/tLdZpiuj2lHKitZ7/pBelonMMVgVN9zcyV7ZCM5a3IC0aOKGnNlspm9hbkRbDNcPXLAkY3XN0fabPHQWBKHi5wI0ixTnIwhVh2hakfhOAy6g9XuZpImautFXIxzJGWuZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476872; c=relaxed/simple;
	bh=Bwr0PTdDGmTP6VB8HL7RHouUSm+zvmEbjPJ9gHz3nX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3IUpu60sJIjdHSfwyyNKe22+tesvLQgLdhT9TRLqL3ntjkNmrf4QPYrroXrcTngynLYlaHM/Nn6nkwA3fWB7bLD9nrtNhCCRReR7o0N++uetfh8aqL48oykzpXfoGlKvxI3xPM5V2EFglUndcJ4fiS8KGOHYD4+KQXt5nQ5kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2v9XHOk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720476871; x=1752012871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bwr0PTdDGmTP6VB8HL7RHouUSm+zvmEbjPJ9gHz3nX4=;
  b=O2v9XHOkkB8nlkzj7uCsrTWiPCafG0W6HfD2/9cPzw3OD3m6VJpPYZrF
   dDPmyZibIb0RZy7d/mA2y7BhQQOe3sIQMzNic/1BeSyD2m8TxhKIH1jzy
   /aJQDrbBnZm3InVZIN7eJuD83BLj5vuUbLQ0jso0YmLyK+eiZDAmaJPoh
   ZRXlmWT+ZvqqQda4PXxhoHVMqQLrNm49fb+7jSiUWDKO72iSoC7DgbMZE
   oCsVjIuolPrWIUSMdGfVB2fmw/vAIqns1djXcfBi8qEtNxOfrqrlCED90
   rr9gYX7/5cZ61SiRE4OwWdBv0jeeuYGB+Zkno7k0x6TlkI2W2OmEuoBKt
   A==;
X-CSE-ConnectionGUID: 5yOY7k9AT+mlzeDEr1g80w==
X-CSE-MsgGUID: rr/lYlnOTtq4eakN5Y7gtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17340114"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17340114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:14:30 -0700
X-CSE-ConnectionGUID: vQEGHPv7T4SJN8R0E4kPIw==
X-CSE-MsgGUID: dQndFPkmRgmM7cJ1Cw37cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52237717"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2024 15:14:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 3/8] ice: replace synchronize_rcu with synchronize_net
Date: Mon,  8 Jul 2024 15:14:09 -0700
Message-ID: <20240708221416.625850-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Given that ice_qp_dis() is called under rtnl_lock, synchronize_net() can
be called instead of synchronize_rcu() so that XDP rings can finish its
job in a faster way. Also let us do this as earlier in XSK queue disable
flow.

Additionally, turn off regular Tx queue before disabling irqs and NAPI.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 3104a5657b83..ba50af9a5929 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -52,10 +52,8 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (ice_is_xdp_ena_vsi(vsi)) {
-		synchronize_rcu();
+	if (ice_is_xdp_ena_vsi(vsi))
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
-	}
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
 
@@ -180,11 +178,12 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		usleep_range(1000, 2000);
 	}
 
+	synchronize_net();
+	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
 	ice_qvec_toggle_napi(vsi, q_vector, false);
 
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (err)
-- 
2.41.0


