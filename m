Return-Path: <bpf+bounces-38821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172196A68E
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F224128608D
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B70192B90;
	Tue,  3 Sep 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6oBwy5u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B971922CE;
	Tue,  3 Sep 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388255; cv=none; b=Ly7fPxLHD/QA/KthGM+9a3+cyGLN9fkKujihN6SkpLZ0dniIwlNmunfk4FzrP2fVOGEZpAJPV9Yrb/zGnJMnsRAqyPkofbWrBd4+l7xGLc7ffWA+NOYhy7A/udhOt+J6Tx6N025rlVjIFK/0HS1yuRc+MeHHgUTh4e0NHWj0eeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388255; c=relaxed/simple;
	bh=Fg2F6R3nFvdMHEpobW/4u4lur5BSuO0Kf0dhd4qTKUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPNkqv08yaD0YXA97nXGRY18X8Qg5nYVMAJBUr/L/KiINZi6auCUHZXLx7pmDa6+5mqngypN8tImLgV1GU0/OKs3pWREvD42zCly0jKMm+EnNpDfooe/2fZilvEiT0b14pRKW9STIOqLCVspt83VmG+wVxRZiijwEzvY7BSF8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6oBwy5u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388253; x=1756924253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fg2F6R3nFvdMHEpobW/4u4lur5BSuO0Kf0dhd4qTKUI=;
  b=a6oBwy5uluSzkWEhTQKuAomgVP/YWCEtesA674C4VuMJeyy9e5xHqI/5
   04FvzyrRXvNk5K08Wml6F0h+W5jE+p1zsIpHIHxgWgJjMSzwlaZ4JqHQ2
   b/JiLXWZQVBHUzOPCj3f94LVgYDUqf8gyHTZktMipLWm/xfwB2jZWPvrJ
   O70f5YXTFfrcvRbQ49eRRNXUWF4fRhtxxflbt68CybenJVr1rtT+LzaTz
   cKftL+I0/Wl+57gUUpNHEzOxxagmNB87kzbX88+TxnxSdCcAHqZ3kAEtp
   yVHIhAYQBRlugIAw9MjDwl6KFMkqCl+NkTJY+LVvmi0nPrLPkCVaaKBD5
   A==;
X-CSE-ConnectionGUID: sQN5f+hKQnWkFjCleiMglw==
X-CSE-MsgGUID: owishKdvTGWHXbUQRO0ieA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24147022"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24147022"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:30:52 -0700
X-CSE-ConnectionGUID: Q7/catdbTxO2k4Mcg33LwA==
X-CSE-MsgGUID: PaMTAdJpRsW1RE1U4eYlzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88250246"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2024 11:30:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	michal.kubiak@intel.com,
	jacob.e.keller@intel.com,
	amritha.nambiar@intel.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 5/6] ice: remove ICE_CFG_BUSY locking from AF_XDP code
Date: Tue,  3 Sep 2024 11:30:31 -0700
Message-ID: <20240903183034.3530411-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
References: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
state, not VSI one. Therefore it does not protect the queue pair from
e.g. reset.

Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8693509efbe7..5dee829bfc47 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -165,7 +165,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_q_vector *q_vector;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	int timeout = 50;
 	int fail = 0;
 	int err;
 
@@ -176,13 +175,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	rx_ring = vsi->rx_rings[q_idx];
 	q_vector = rx_ring->q_vector;
 
-	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
-		timeout--;
-		if (!timeout)
-			return -EBUSY;
-		usleep_range(1000, 2000);
-	}
-
 	synchronize_net();
 	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
@@ -261,7 +253,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 		netif_carrier_on(vsi->netdev);
 	}
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
 }
-- 
2.42.0


