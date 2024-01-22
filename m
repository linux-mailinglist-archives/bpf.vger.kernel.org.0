Return-Path: <bpf+bounces-20047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CC8375F5
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDAD1F256AC
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77965495CE;
	Mon, 22 Jan 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYFErYjc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D248CD6;
	Mon, 22 Jan 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961799; cv=none; b=mpIbwi+6czgTKSjubOOA0CK2lsKt+tN1wewisKoFZG74eH2VVtoUF69lmitLWRDSDC664+WGCBPEvlX8dvNm976BXRl+g96zRQJNEOFh9aDdzjh1R0TaUR5kfoZfIqLve4/zb2OMdShKprkNbd2t3oOOiFqXomou8hF+0PMCMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961799; c=relaxed/simple;
	bh=cFOLQ0EFPS6dnmzZYjdx/0EEdNdAeIapFTowJ39C8hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/Bl5VdbDw5sjCsIvYH8JsH8wICMwBMc0PwSLqN5RDO8xjzuSNx35NbEj/FbSeqAnlI56V70vI2hQHYT2YcZXoeIQexcxFEsfQBjzbDMBN5SOUMcTkNKiYAnZGXN/I+QuCz6UoXj2w2XQjTWWW5/Br7HUAJ7oZXrFvtQNsOfyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYFErYjc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961798; x=1737497798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFOLQ0EFPS6dnmzZYjdx/0EEdNdAeIapFTowJ39C8hU=;
  b=kYFErYjcllMgZI6PvIQheg89Y69/ujRL4DV3Dml/LXZdaM6Gh2DHFU4o
   vY2Fk0gbI83m6OkccRHZpov/iCw4DY+lin4uMtgUyiO8hObmZ2fqaCXB3
   iuNqvqr0tExmM5jl4D24uTjDVfY7Wh8UITr95ZnoBAjm40uUqtpWMFTzS
   QgTLrZUwJy5HniFW6bIMYKHEo1w1PDMPdASBlO142VUAu0joBPh8LrFut
   DQchsS+lOiMwHF2B5MsL5IVKFLecN/ZQsBWJenkYYmtZW5H3qJ8eYx173
   whyqVx1SddqLwRurLpjp8kHl429+Zl8U8p/DxdFCozVlVzJvD2KfaWuAt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995591"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995591"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360624"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:35 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH v5 bpf 06/11] ice: remove redundant xdp_rxq_info registration
Date: Mon, 22 Jan 2024 23:16:05 +0100
Message-Id: <20240122221610.556746-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_rxq_info struct can be registered by drivers via two functions -
xdp_rxq_info_reg() and __xdp_rxq_info_reg(). The latter one allows
drivers that support XDP multi-buffer to set up xdp_rxq_info::frag_size
which in turn will make it possible to grow the packet via
bpf_xdp_adjust_tail() BPF helper.

Currently, ice registers xdp_rxq_info in two spots:
1) ice_setup_rx_ring() // via xdp_rxq_info_reg(), BUG
2) ice_vsi_cfg_rxq()   // via __xdp_rxq_info_reg(), OK

Cited commit under fixes tag took care of setting up frag_size and
updated registration scheme in 2) but it did not help as
1) is called before 2) and as shown above it uses old registration
function. This means that 2) sees that xdp_rxq_info is already
registered and never calls __xdp_rxq_info_reg() which leaves us with
xdp_rxq_info::frag_size being set to 0.

To fix this misbehavior, simply remove xdp_rxq_info_reg() call from
ice_setup_rx_ring().

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 1760e81379cc..765aea630a1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -513,11 +513,6 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 	if (ice_is_xdp_ena_vsi(rx_ring->vsi))
 		WRITE_ONCE(rx_ring->xdp_prog, rx_ring->vsi->xdp_prog);
 
-	if (rx_ring->vsi->type == ICE_VSI_PF &&
-	    !xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
-		if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-				     rx_ring->q_index, rx_ring->q_vector->napi.napi_id))
-			goto err;
 	return 0;
 
 err:
-- 
2.34.1


