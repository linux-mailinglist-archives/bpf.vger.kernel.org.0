Return-Path: <bpf+bounces-20268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749E83B215
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B061F21033
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD371339B7;
	Wed, 24 Jan 2024 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBVbNOtd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DA132C16;
	Wed, 24 Jan 2024 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123802; cv=none; b=PCwgXj9csJrlMD21AkF1CHX2i8ZA8+HKp8tywIv/wLxmiurSJ3bQbFRPA8mgboLNYDHDslaNnGLL9ngOoJbEtkyOgedo61NIS6NpzxlRvYXh1zsgh0ACoYL+Xr0M2TTJLZ3698F0XB6YNHGa1jt7iuBKxJl37Gp9EQGXYPEZBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123802; c=relaxed/simple;
	bh=Mg7VTmpQPlKPoK87fa8+BMrUZ+FaaqInPzsO6IkB4yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gcs+uoyz5yhPSygPTDAPlYoB9VftHxEnE8PjGfKQ2CwHHt9peXqVUE6Jrdh6ZURpElDpURUS7r6Bf0qTzZkUx/uHYLxZyDOpUGJ4UC6U/llsqghMIy2LZinanj+wRT6iWEi+hjuzzyUDKL40sX+pHhI0f0OsEgj5nhqH4qBUeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBVbNOtd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123800; x=1737659800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mg7VTmpQPlKPoK87fa8+BMrUZ+FaaqInPzsO6IkB4yQ=;
  b=WBVbNOtdSYrYkY/wQbiXUJODX2I3sJ7FKpm+ucOAUiG6p/whDZ4XxwFV
   4OydUc+qeu3qKSb41MmuB5B4vzpQJHNUnWqr+A/dkUm2llKzXZSfw0wii
   EX/4bK0I73euTa0D2h6bqYJV4YNV2CXEiLmZrIkpK2FnFZUY7eQFMwasf
   lBrG/LXmk2xVWEpIjGMKgXDiQQs1AwTVrRXMAlwAUTLImMnhdtXdef+Go
   OBokDZ10gCIP3jrsEcUWSMYCqbfS6cTsYiR5mCsHQgDTPSeMaJMhO5KAr
   K7bOvic45cNHjflr7fZir+laH8yuyBoL55oNv9JTa5GjVCL8HBdYZpSQX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1823086"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1823086"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553472"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553472"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:30 -0800
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
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH v6 bpf 06/11] ice: remove redundant xdp_rxq_info registration
Date: Wed, 24 Jan 2024 20:15:57 +0100
Message-Id: <20240124191602.566724-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
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
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 0c9b4aa8a049..97d41d6ebf1f 100644
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


