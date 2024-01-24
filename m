Return-Path: <bpf+bounces-20272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626E183B21E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D4A28BD5F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3513475B;
	Wed, 24 Jan 2024 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BI3CzyUN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B37CF3F;
	Wed, 24 Jan 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123815; cv=none; b=r9oCd2Qc76ExkjVCR0U7tQTdrbaCNYK0GbhcaF+6y0UPtCm6voPTIiTIKuZ9RobYUIbP1ipDTn0IXK3RK7uAKMiF0kUypTBir0PxK8QqE2udagmmaG4DLNOt+j2F6X5LMKgXofpu80nCv9rG+3dTnqKeWF3BxuA7uFuelTDi7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123815; c=relaxed/simple;
	bh=riDP4WWn5OWq7Ohih9Z9ln2t6l/4qrywoTHC9hD07tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOvMTlT+ZZ65ztHDXl9/lzh5AfTQjXNdshEbPtlfFLAX5ICFXyrfUOzMoM5igKHex0KRuLQBpQxG2/eTyREIbHC86xLziAOkpsqy2i0/dldkwj0xDNcewPvP19ktzYGWusWph3u+HxQU5oGAT1QkRHLupIF9SK0eEQLwtbTzNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BI3CzyUN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123814; x=1737659814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riDP4WWn5OWq7Ohih9Z9ln2t6l/4qrywoTHC9hD07tM=;
  b=BI3CzyUNXJzA2T9aLzwaTzkfT//2pQxJ3DyVFSK9Zpm1ieIOfjxpDc8L
   wpqHQ8cbG/dVxXR+gmfpgpK/KkQqsVy1m2xpEDbJUUS28VdQT/qbzq5oy
   4N7TDqavtvF8kF3TTDu8E4WSk/z8OmNjsWzG26sNCbcRJ65Lsdj3Li9oh
   sKHP83Bn4/ox54y41L6BB0qV6uy3tsykvB1Co/4mBSzWPcqHlW+CGy6ab
   +3qGhrHpgwJROl+lssJTQzUI9oOhwOPQaCqBwq8VX/tLFG2Xs5vcZQdtK
   mIEpDseudRw9NeFo2UkIlzyhgsNSOnuDJNITIhibAOfGIdD51o5An9aC/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1823271"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1823271"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553524"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553524"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:49 -0800
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
Subject: [PATCH v6 bpf 11/11] i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Wed, 24 Jan 2024 20:16:02 +0100
Message-Id: <20240124191602.566724-12-maciej.fijalkowski@intel.com>
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

Now that i40e driver correctly sets up frag_size in xdp_rxq_info, let us
make it work for ZC multi-buffer as well. i40e_ring::rx_buf_len for ZC
is being set via xsk_pool_get_rx_frame_size() and this needs to be
propagated up to xdp_rxq_info.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d3b00d8ed39a..6e7fd473abfd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3611,7 +3611,14 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
+		xdp_rxq_info_unreg(&ring->xdp_rxq);
 		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					 ring->queue_index,
+					 ring->q_vector->napi.napi_id,
+					 ring->rx_buf_len);
+		if (err)
+			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL,
 						 NULL);
-- 
2.34.1


