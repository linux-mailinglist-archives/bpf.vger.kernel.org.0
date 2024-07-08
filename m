Return-Path: <bpf+bounces-34152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5492ABDA
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7F91C220A6
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856EE152798;
	Mon,  8 Jul 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y90nuG4Z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD5152160;
	Mon,  8 Jul 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476874; cv=none; b=fMnOp9sJkU9WDPn2UvxiX38CBa3UsTToAo8Yya1Y7A2+Eo+J5gxH538EZv9DF+ijvEtbHQ5H71tjvZGeeE+VUJQuFnYHem5ZUVRwHT0mB3njbQm+VE0vzbGHYjR3Z63YobJQtqGmJzH3hFiIVm6eVkQQnnmeGSBP/thIPQGuR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476874; c=relaxed/simple;
	bh=LxW+UOnV5kUT70Gm/2neOCes3ok19si4WL+DMYjSwgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTAAkPIG+jtoI2R56mFEvh58VucY7rjEj4G9sm3d/Aozi9TS80SsMRah8eXYy8TMqGFxszBvIpsWWgawGJyK0eNX6KacvqfQvv+p4RbrbNEDdJv7fVtO247W/W1Y8/vMFhj2p88hoMGz6vIIDbntYO5eRrSOEIsrlSRT0rFbBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y90nuG4Z; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720476872; x=1752012872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LxW+UOnV5kUT70Gm/2neOCes3ok19si4WL+DMYjSwgo=;
  b=Y90nuG4Z528vPV32Mn9tqrZJghiqdkcnDLwoxNyiKXHBujLKfBhdQayl
   UAs98iGZWY0L2rCW+69lvkuk+q/r6qjjTkRAHIs/b9LAlxAq47fY4j9UY
   3SgFNvsQqxAjoN8jWi5DWiwBCKNsfPNcAuH6svMKe55HF5rJfiAFfU5g4
   LMe/uzNGO1Y6DRUl7OxUlJkWavCtMrGtcDwqG9wwtHi17sEWTTEwDfArW
   Uc2DwMMZlcQwaj3xDrKE1Ij3aYx0uNjAdVlHhrGD6vsZ8ILUGZizBsbkQ
   mhixgjZAH5UhzL2vDuZToOp6RAUJ3Fk0P6qaCyHY9bbEAml4+tW/tG9T3
   Q==;
X-CSE-ConnectionGUID: u8gctkrISGiF8WsTi/a7VQ==
X-CSE-MsgGUID: UpFJNSywRIqr6ck541R1LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17340106"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17340106"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:14:29 -0700
X-CSE-ConnectionGUID: ovtFePUmTaO7TrsCOrcTsA==
X-CSE-MsgGUID: coynBxcXQA2rZRqtgpcpmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52237714"
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
Subject: [PATCH net 2/8] ice: don't busy wait for Rx queue disable in ice_qp_dis()
Date: Mon,  8 Jul 2024 15:14:08 -0700
Message-ID: <20240708221416.625850-3-anthony.l.nguyen@intel.com>
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

When ice driver is spammed with multiple xdpsock instances and flow
control is enabled, there are cases when Rx queue gets stuck and unable
to reflect the disable state in QRX_CTRL register. Similar issue has
previously been addressed in commit 13a6233b033f ("ice: Add support to
enable/disable all Rx queues before waiting").

To workaround this, let us simply not wait for a disabled state as later
patch will make sure that regardless of the encountered error in the
process of disabling a queue pair, the Rx queue will be enabled.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 72738b8b8a68..3104a5657b83 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -199,10 +199,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-- 
2.41.0


