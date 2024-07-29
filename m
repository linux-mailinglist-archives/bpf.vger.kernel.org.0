Return-Path: <bpf+bounces-35923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802693FEC4
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BE81F20FD8
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7618D4A2;
	Mon, 29 Jul 2024 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZcST0ez"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2818A951;
	Mon, 29 Jul 2024 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283650; cv=none; b=LJTaK9Q9VqeS/Z0ULiftvbw8KPZg2K0ggMXt85toE1EvgGpfnsnf3wBePFVxvTzv29Xr/iikcZ160HAmgZAPu11uKitiuKqSA1P6HBYvPKw9ztKVyXEyGW6Yp4abeg4eDVJzyJKSW/G18E+Bbqjh1BIi5X7+9+tEXpWWsMfAE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283650; c=relaxed/simple;
	bh=n7ANfRKum6afoJJa4U7py2dwNaCRzE2vIh6HSC/8KQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb5Oo68lcMy3cx91YOh35U3qdOL5elfTY5FHp5WU4sxv5fOArhCxw9Ampu+cV0ubAKfxxRk/mYDYIV0aOgxymgbi2MCSEcfZDLa2/y7Lj6rsMaBFibTgZuuYACVml/zKtSGH0xfvcu2afMIuKwsJkAfGD9v5YERAFIk5jsa+6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZcST0ez; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722283648; x=1753819648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7ANfRKum6afoJJa4U7py2dwNaCRzE2vIh6HSC/8KQM=;
  b=WZcST0ez25ay/ISrtO9HWUehNe0PVhjiZQk4fHLnXtBDH3HucGIzPiVy
   Si53FUAQOaYdd3MwpQJwunRyLovBFUjfxPAL3lun8L0Ae1jEO1iXwlL20
   KGvtlalVwAGWR2YuPjYbGzFKau8wbBu/uBGRIxX4xotjgmmfoGwE85p45
   GYW4eSzB1RxEbi1cdZBR16MUjFyNoHC1TQPYmCkGmPH1XDh6o9OwhnJ8W
   djw6Y5BAPJq4E54N4uJuQbFs4DP55myLeNEmZHw6BA5Nl+Gi3VlAMG8ay
   ocAGIcid1cAj3BSLW6Wm3zVzfHx77Wlt50Ti6xFQg7UudPUUgvuniRN6B
   w==;
X-CSE-ConnectionGUID: ADYladQITbu/Vyu44ciWKQ==
X-CSE-MsgGUID: 1wTPd1uuQuWweQICPjOX4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23818547"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23818547"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:07:23 -0700
X-CSE-ConnectionGUID: Y+jJCG9EQCCnLXVTLp6uCQ==
X-CSE-MsgGUID: vtAE8FltSqWOBBOrxmnVLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54681297"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2024 13:07:24 -0700
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
Subject: [PATCH net v2 7/8] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
Date: Mon, 29 Jul 2024 13:07:13 -0700
Message-ID: <20240729200716.681496-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
References: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

It is read by data path and modified from process context on remote cpu
so it is needed to use WRITE_ONCE to clear the pointer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 0f91e9167427..8d25b6981269 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -456,7 +456,7 @@ void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
 	if (rx_ring->vsi->type == ICE_VSI_PF)
 		if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 			xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	rx_ring->xdp_prog = NULL;
+	WRITE_ONCE(rx_ring->xdp_prog, NULL);
 	if (rx_ring->xsk_pool) {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
-- 
2.42.0


