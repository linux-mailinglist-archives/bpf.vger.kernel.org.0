Return-Path: <bpf+bounces-34151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15992ABD9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B51C22027
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15215253D;
	Mon,  8 Jul 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNZXWlnL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553091514E1;
	Mon,  8 Jul 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476873; cv=none; b=DdQDBIrzqw3xrt8/7GMerig5v9BGaKknSHMpg45oE335rf6M2MXYlGBoexbrsS4TMEfRCs7PYQwKvabhVYnJ/E2YcUOUZSMZaG8htBf1x9HAy1PWBqZQKrlTWdHSk02iLyY4rUhXJQX9l+5sXdawVN7WbmZVSJKfC2+/8X/cIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476873; c=relaxed/simple;
	bh=XF8p192SJLccoPBlKVuM26yvvcxsG3badlilFuisUTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8MB/63IY5Ucc1TjtNZc1BPEqCrAbF3+sSN7qv225DNhXpSscdvTHPSaM5fyB8hT6LyG8w7M78yD8ALN+9mPK5ajDuYVLihemrBEQ8Kbl0hmsxfXD3cTVo7mjBYBn8rQLF6qCt9TUS+5fwUsxpNPZGvwi+Nvn4AFrDNtRWcIA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNZXWlnL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720476872; x=1752012872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XF8p192SJLccoPBlKVuM26yvvcxsG3badlilFuisUTo=;
  b=TNZXWlnLpu7yPVk296m5M+iXFqar6rcrqXngYSOTYJHVHC5wHGzaEuhu
   itOS4gMZkIHopqgwFSoXZiXozxYFZh5JgUwC6v+ofG2RlujXHFhS3Z9tv
   Lf3LnpZX1ZtTFas3xJb+ObBKhhPDjxTHjadkjQFpG69fsNviHNvT5kaJn
   w4Bo4OlDwm3gMxliS/Wfcz/wkNJBUy66uA8WM+EfrjSSKucKULoou/Xu9
   +IogSkH9+RXRN0X0+JtsT6mEmudySsmmvRCh/8oQCcvGVjb/pffs8I7hB
   FFuhUuKIquDzPB6b46/iBfPt+2scJqKiGdy6dMpp76mXIjWMV3u9EAnuP
   A==;
X-CSE-ConnectionGUID: Vuj/DK76TASIm46eDxdKnA==
X-CSE-MsgGUID: clOikVc8SxGp686cMsgDDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17340130"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17340130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:14:30 -0700
X-CSE-ConnectionGUID: 6ap3CaaJTgW5WW+V2wVQtw==
X-CSE-MsgGUID: tEdCm3xmQSi8m4bmrzHNSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52237725"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2024 15:14:30 -0700
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
Subject: [PATCH net 5/8] ice: toggle netif_carrier when setting up XSK pool
Date: Mon,  8 Jul 2024 15:14:11 -0700
Message-ID: <20240708221416.625850-6-anthony.l.nguyen@intel.com>
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

This so we prevent Tx timeout issues. One of conditions checked on
running in the background dev_watchdog() is netif_carrier_ok(), so let
us turn it off when we disable the queues that belong to a q_vector
where XSK pool is being configured. Turn carrier on in ice_qp_ena()
only when ice_get_link_status() tells us that physical link is up.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 902096b000f5..3fbe4cfadfbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -180,6 +180,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	}
 
 	synchronize_net();
+	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
@@ -218,6 +219,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
 	struct ice_q_vector *q_vector;
 	int fail = 0;
+	bool link_up;
 	int err;
 
 	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
@@ -248,7 +250,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
-	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	ice_get_link_status(vsi->port_info, &link_up);
+	if (link_up) {
+		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+		netif_carrier_on(vsi->netdev);
+	}
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
-- 
2.41.0


