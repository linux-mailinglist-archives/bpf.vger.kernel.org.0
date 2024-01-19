Return-Path: <bpf+bounces-19943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301DD833187
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F74B224CD
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C65915B;
	Fri, 19 Jan 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvdPM5jR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8BE59155;
	Fri, 19 Jan 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707071; cv=none; b=U8nYq6a3xvSN1XZGIiS1OgLCiPv/Avk43/wW9yYDTjEZ0LftRNC6k3/sTCRKRjwOWop1yokIsGNb9B5HXgECMa4FJ4zUHIqYCL4X6ThomgT1vStqc7AQYg+PksSasvlD6/vSCwyzEeVlmBl0Hl1JAuXfYEoCwYY+iDejgA/KMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707071; c=relaxed/simple;
	bh=cFOLQ0EFPS6dnmzZYjdx/0EEdNdAeIapFTowJ39C8hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWcE5lIMiofiK/L3rvHfMovqh0cOA9obUPG7m1FmsTAKx9K1D6RlNNGrp5FPrF/aPk8wxTdmS/fwjSpTLWr0l9NcCR+BLCTnthFuPtxV9PdJFTTtEbl5NE8UChChtSjdkQt5EU4dnkJ0Fjg90RbTqQJHk+s9ANT8hcKbzqUIItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvdPM5jR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707070; x=1737243070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFOLQ0EFPS6dnmzZYjdx/0EEdNdAeIapFTowJ39C8hU=;
  b=UvdPM5jRHt/QIaed+cTuEdH4AvGum1RPcHCY0gSJLuAph22kabdZRNfV
   p2hqlv4SnLt+Z1HkSIUea5RqenCORUZxqDVtkNSdDVXdM6qtsKkocyZA1
   2HLYSin630zCsnIezVnkMFdXvRZUKPeqQGkd/360y2u06Yi4K6JJUaV+Z
   UddQg3OtmZDVCp5R/hT49P0OrQ0DEdarqU9rqdfV85OXO3l6YNfCfglyp
   mmHY0asfGP+RuNxNexAAT4jrW3/jJsHkydS/JCAo3k6+tvBPjUIdh3wgs
   GatOVKwaJDNnVvLyKA+olNoIIvzcPQHBNT5FU+NC6AUAx6xEaArjGkl1C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771613"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771613"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277435"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277435"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:06 -0800
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
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 06/11] ice: remove redundant xdp_rxq_info registration
Date: Sat, 20 Jan 2024 00:30:32 +0100
Message-Id: <20240119233037.537084-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
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


