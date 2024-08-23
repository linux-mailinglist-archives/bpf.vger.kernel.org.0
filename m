Return-Path: <bpf+bounces-37934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB695CA00
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A16281F06
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A851684A4;
	Fri, 23 Aug 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0hxP4Kx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F51885A3;
	Fri, 23 Aug 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407696; cv=none; b=HRWOsGMpch7JtrIKLpYby0DYFHatfrlynJB42BxyAmKimE77053DelsHw1IAlZI3YcFAVATv+yC795RP52EdbjDgvA1LnNuiqbmAK1oa9LJ22asCRSnQJT/R/DsX8gEwCClkQA6RgaLIyNYqdMhPvWIwoqnxsekKy4f2hy9AMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407696; c=relaxed/simple;
	bh=GKovvd1S+/u4MzEkgzpmHw0gmxvHSPUiL4DNwMa1SdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYmzGr8tyZGFYTsE/2bc+nAD0i+n0GpwuPUdorOYwXcas6RsbZR5HmyNMaIhqnHTAu8zCIXKYTiVkreGOZfPLUBGy/Ryly1402BcwHqYptCu5W6swk4VqZaUpB+lnm4cfszrOR48eLHmjcXWy5qVrQg1dblAiofxoamkW7kJNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0hxP4Kx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724407694; x=1755943694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKovvd1S+/u4MzEkgzpmHw0gmxvHSPUiL4DNwMa1SdE=;
  b=T0hxP4KxLbM/3/U/hI0Zc+Rd4hh4voujLmyHFkbyQQCKdBhfvFjc49Nd
   rTRWzCbX1JccEE/brTq9LkMoaFnICmaz/B065E6FXjWOzlL1wHKsJ4YBe
   zXHgor1twAOFT+hOsy5raPG6/M8r4uJqEQvz7B73KRq8gi5S8eMGDdPo9
   FnDZSsCJyU1MFyMELHpEz4H5a8cE+q12wH5KFc49gaJ8eL1tzQJDudL86
   INtPCIZ+QXyJafsxcoFf+H5BGk4A4FqOsnZNlI82ZEqAVJJGc7fiUUQCU
   MSR2d+U9zp+b1upRnFrQcSfzW0e9bPS0pxX7wsMaSBWuY1UCbjl3u2e4M
   Q==;
X-CSE-ConnectionGUID: m0ii1GsDQAimEw7D6VQRLA==
X-CSE-MsgGUID: sGd839/mTZ6joME26veAVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34285061"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34285061"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:08:12 -0700
X-CSE-ConnectionGUID: jkYcS7g1RNim5qu+tjExZw==
X-CSE-MsgGUID: reTV2BhLQC6KeFaVVI7qeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62479063"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 23 Aug 2024 03:08:08 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 26AF533BDA;
	Fri, 23 Aug 2024 11:08:05 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	przemyslaw.kitszel@intel.com,
	anirudh.venkataramanan@intel.com,
	sridhar.samudrala@intel.com,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH iwl-net v4 5/6] ice: remove ICE_CFG_BUSY locking from AF_XDP code
Date: Fri, 23 Aug 2024 11:59:30 +0200
Message-ID: <20240823095933.17922-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823095933.17922-1-larysa.zaremba@intel.com>
References: <20240823095933.17922-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.43.0


