Return-Path: <bpf+bounces-35535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93193B572
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBE91C23013
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03916D4D1;
	Wed, 24 Jul 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjEnupCW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618016B749;
	Wed, 24 Jul 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840321; cv=none; b=XjifR+3KrSZht62nPl/r1ys3jbJosebV7bKCfWAxYQMECR2G5CX5fwK+a6AdFFNyMtXMGUqwr5xNoTzYiJGPGY4hb4+0B3Vs4CfnPuJz477hl0/1v2A/GeCcKX55ISchfwaXF3p2y2cHl0sEJGHYLAtfBl4Ncvr4LsmF7hDFbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840321; c=relaxed/simple;
	bh=BZD7fxo2009l6zfgoD9aO0y7LSTsVh4ZDQmghEWlGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQSNFUrIH73nydVjvbJvd+9qbI1m8d+xtEjKSzC8e/N2So5Ptl47J50uo/Aqd1Wv7UVnl1kr2ztrXLw2uANVvBXefV2M4Q7IVSkketcyYPXStHHMuShWi9eFwGARVwkwIpwFk2W6/T/s6yduVK1CXjM/8t+kwA2iiuHDHMZsf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjEnupCW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721840320; x=1753376320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZD7fxo2009l6zfgoD9aO0y7LSTsVh4ZDQmghEWlGu8=;
  b=CjEnupCWwWlkV8O7mMEoXqnTGnIDlZz0EVvtO7JpvhK3sgYdeKqWb/dD
   Ic2GmnirSVXomeAVjwaYWYtABht5xioMZLauvNMiJsGVcEu2wj3dBHbr+
   7pMTEJSSf+vn/kJ6qhcXgrEc5zc34TdDggyaE8F/24AaGA1mLkYKBxsVf
   SuZOg57PO9nfBeXuems78n4DynUgApOJ5kr1wWo/yMjUmxLfwmQKbXTn/
   wjOEMrL8gZIibCPZOVDtDs7rr+3fDcd1m8ZN5+FovclbY+41mgBygKHVU
   Z/mIywW3ZIVEkTuOD84miI9D9MckGMseO/yfn8+/04X/7gpf3U8Cabx0/
   w==;
X-CSE-ConnectionGUID: DIbq58YyTEyX0KsBMiezdQ==
X-CSE-MsgGUID: M0IhWQ7vS2O2/dXrihn91g==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30679796"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30679796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:58:40 -0700
X-CSE-ConnectionGUID: maqkn2tPQI+cyQwhL7cjiw==
X-CSE-MsgGUID: nDssrBtuQcmLwkCfsXcdqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="56960634"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2024 09:58:36 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6C0582878E;
	Wed, 24 Jul 2024 17:58:34 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
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
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: [PATCH iwl-net v2 5/6] ice: remove ICE_CFG_BUSY locking from AF_XDP code
Date: Wed, 24 Jul 2024 18:48:36 +0200
Message-ID: <20240724164840.2536605-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724164840.2536605-1-larysa.zaremba@intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
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

Despite being useless, it still can deadlock the unfortunate functions that
have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
returns an error.

Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 5dd50a2866cc..d23fd4ea9129 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -163,7 +163,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_q_vector *q_vector;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	int timeout = 50;
 	int err;
 
 	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
@@ -173,13 +172,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	rx_ring = vsi->rx_rings[q_idx];
 	q_vector = rx_ring->q_vector;
 
-	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
-		timeout--;
-		if (!timeout)
-			return -EBUSY;
-		usleep_range(1000, 2000);
-	}
-
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
 	ice_qvec_toggle_napi(vsi, q_vector, false);
 
@@ -250,7 +242,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return 0;
 }
-- 
2.43.0


