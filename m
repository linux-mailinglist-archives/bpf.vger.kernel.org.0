Return-Path: <bpf+bounces-20267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208D83B227
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7799BB2F641
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B461339B4;
	Wed, 24 Jan 2024 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi0pGsY1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D5132C10;
	Wed, 24 Jan 2024 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123802; cv=none; b=pEf2jJAM1vUyC3p5Ap3K6IdHa83cQK24SDI5ltwtYdhqT+ettSl948npkXgFoXkIpuOh0LItFg3Je7c5LRhWQ+hEn9NuSTcJc98NNTYymzeu6FLrisU4uIPkxPynINWDjVfKD3ULPBqQlDgDiQ8H7qQtDs573l/FgIcukZqdKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123802; c=relaxed/simple;
	bh=o6Ad2dll/DITDdqWWDrw6egZKCJJPJ/TOiIIkYtMEjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d24eYdHK4OQ5k4xHZpiD7SH2pSZ16JlgdIw4680RopSAVlqA4Q90OeiR9Zq6xddn1ucBG7K2260sHb3ocd4kfPaMXg44il8+PudXCTz8Hk3wM6pnC05YYwexfYJFTjulMDU5PjPW8hh0YO53MepKax9VSSA112Sd4dBNgGgO8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi0pGsY1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123801; x=1737659801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6Ad2dll/DITDdqWWDrw6egZKCJJPJ/TOiIIkYtMEjo=;
  b=bi0pGsY1g0JvEHUXTi1fFt4QolxpamWd7pTY2soivi+sidPNlS30B9cQ
   odZY/EKZfdATz/nuCjrAp2h5GmjsFBiQA6mxhLfhUBhom2fhnkb+/sgSo
   gBGbPeP4r1BeM4BWqWbdhm7Cg2QsWr152fuILFbIO0WiBpAL/sHCpLfMT
   czNmK1IvzCVi1D68xVdD0FbFXyrxt5RbZgV56qtozkDomBRzDHg1s/Ddn
   Y00WvBhFk9KB91/1KniQlAWq7Y2qiOsLyS8W6pX4lmV4XhSE33Yg0aS4z
   6mCwAVh9lv9AHfwYZ0fUAgopfDCRW32SXuc1u6HzXGYaVP9QH7/CnW0cU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1823117"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1823117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553483"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553483"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:33 -0800
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
Subject: [PATCH v6 bpf 07/11] intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
Date: Wed, 24 Jan 2024 20:15:58 +0100
Message-Id: <20240124191602.566724-8-maciej.fijalkowski@intel.com>
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

Ice and i40e ZC drivers currently set offset of a frag within
skb_shared_info to 0, which is incorrect. xdp_buffs that come from
xsk_buff_pool always have 256 bytes of a headroom, so they need to be
taken into account to retrieve xdp_buff::data via skb_frag_address().
Otherwise, bpf_xdp_frags_increase_tail() would be starting its job from
xdp_buff::data_hard_start which would result in overwriting existing
payload.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 82aca0d16a3e..11500003af0d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -414,7 +414,8 @@ i40e_add_xsk_frag(struct i40e_ring *rx_ring, struct xdp_buff *first,
 	}
 
 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
-				   virt_to_page(xdp->data_hard_start), 0, size);
+				   virt_to_page(xdp->data_hard_start),
+				   XDP_PACKET_HEADROOM, size);
 	sinfo->xdp_frags_size += size;
 	xsk_buff_add_frag(xdp);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index d9073a618ad6..8b81a1677045 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -825,7 +825,8 @@ ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
 	}
 
 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
-				   virt_to_page(xdp->data_hard_start), 0, size);
+				   virt_to_page(xdp->data_hard_start),
+				   XDP_PACKET_HEADROOM, size);
 	sinfo->xdp_frags_size += size;
 	xsk_buff_add_frag(xdp);
 
-- 
2.34.1


