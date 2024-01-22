Return-Path: <bpf+bounces-20049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0858375F9
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E747A2895B4
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4E495FD;
	Mon, 22 Jan 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nx5BfsVI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0B495E4;
	Mon, 22 Jan 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961804; cv=none; b=Oi6yM4XAQhrZwbUfIDRbCuOXlOP65WXqgePMW7fI669iNZW81R7abj7TPfI8DfM7pa500STZOAe/oH78BPrlk4jVTzOAPtAf8lu7S1UfzJzEB7nokcIpXXkGOnVBmIGHj1iUC2pZZhNjlgL/yF3pof5AP+APx+OZSAzQml426pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961804; c=relaxed/simple;
	bh=uk1v+YmAz1abmrXNSE2Dm4Tyo3Zhodkm59mXrvTrAN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rmylq2ZE8rkXidVCZDzMK5z1SIL4Cs056apLS+uYs2Z4GQ7GZuboaqtSK39bFWSEt4wdjhxKSVSy/kD5XmdCGwlVJzZ26r71HWbInTCW1xT9lue0x7Zj1Vjsnw7/yGIPcOID39U1DYXryWe7Bf/bbNKmwlEQh+KI3giA6SgwicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nx5BfsVI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961804; x=1737497804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uk1v+YmAz1abmrXNSE2Dm4Tyo3Zhodkm59mXrvTrAN0=;
  b=Nx5BfsVIZv8Z2VvG6pJdokT5FCVHmx+zb9QOwRpQZUt/ILFuCMd8WNkd
   j91nyMw4Gz0mNCK6rAzkmvSXP6fXyI/zXUeUw+jPloTMNKIW02rp72NQ2
   BR8EBdLHzXhSPDEK1X0ZhgrAdN6lrJI87us11Rlxyf2niKy8UC9OPIWDY
   K++o9jDBpBYyFWw/GsD63iGwEb2DOlDCO/LxfWm87kXhU5Ql2JT9nKLxx
   mA7US0WPCOGe2fGsXMDL1u65eX3bv1meiCDpw06vYxwx03yBzO4oruNzY
   8eKe1a+/+poWA0uqYdFED2r/tvWcqiPo+b/Ngy2B2MczR8JwS5gdytEVC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995627"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995627"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360695"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:41 -0800
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
Subject: [PATCH v5 bpf 08/11] ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Mon, 22 Jan 2024 23:16:07 +0100
Message-Id: <20240122221610.556746-9-maciej.fijalkowski@intel.com>
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

Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
is being set via xsk_pool_get_rx_frame_size() and this needs to be
propagated up to xdp_rxq_info.

Use a bigger hammer and instead of unregistering only xdp_rxq_info's
memory model, unregister it altogether and register it again and have
xdp_rxq_info with correct frag_size value.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b25b7f415965..df174c1c3817 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -564,10 +564,15 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 
 		ring->xsk_pool = ice_xsk_pool(ring);
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
 			ring->rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
+			/* coverity[check_return] */
+			__xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					   ring->q_index,
+					   ring->q_vector->napi.napi_id,
+					   ring->rx_buf_len);
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 							 MEM_TYPE_XSK_BUFF_POOL,
 							 NULL);
-- 
2.34.1


