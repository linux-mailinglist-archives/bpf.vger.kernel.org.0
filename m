Return-Path: <bpf+bounces-20048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DA48375F7
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A38B23C35
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8DD495DD;
	Mon, 22 Jan 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iELZpnfN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70FD487B9;
	Mon, 22 Jan 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961802; cv=none; b=hdCsmuR4uigI1mMeWv0GsxbCupmLfRCfWNm56N39HHQ0/dRL30F4yPOTVR4WL2/03BZ3A6cP8tbwrALzzePfTy2Guvx/Y4xSgZ5GoPhRB3RMK2/sMGjLRKtB2gjm4BAIuC/q+DXEIg3uKz1h1loD1weGodAa1KQWaiKNoYX2x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961802; c=relaxed/simple;
	bh=f0m782620pfAxPMwmIUm1Niw+9h/4bYmsbpHFSSlmtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9AtoVoEdYhiEdVXlHKa1ay0s0LT6Mp02jWYUi6nTenE+idSm5PbcRmVWh5epb4AbFPcfkhdM1XQJymcvzX/N1T8ggZZxnVyx6Cu69zN7DbeZgca7Ze9WzZJ9C/QeSgZc6NHTgUk2vsPmTClCoHZ6/2g1/rq9jOXJC2htDFAexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iELZpnfN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961801; x=1737497801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0m782620pfAxPMwmIUm1Niw+9h/4bYmsbpHFSSlmtk=;
  b=iELZpnfNXJtq4sMQy9UIdtb8zjzwi7MoLn/WQ0/zdtlOM/o98EFgKVIw
   CyjRBKly1FJD9RAlYQA3rmdpjUcxg1L/Wns5LCq8Y8zYJJS07KW9jJygN
   VkuKuYZfWjFNyY/BFIiAS+QJLHAvjzB1YJeBbLA/sy3yTpUYcOlb7g0gz
   uEcCN3toL1zcsC211l4AgA8OLrrz2T9/XvB+ojl+Oa3LJdM5YXze2t5s9
   9rNDEzVm/4JAONjiWDxRbFmmHIwAxy6i6DY4kHSdS6bd2JROaKOYmBeLl
   izLvNgdGd6SbIycFoHMlGpIqpAYC3RSxT14hemUlJNe6+t0rK8tosunTB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995609"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995609"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360656"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:38 -0800
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
Subject: [PATCH v5 bpf 07/11] intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
Date: Mon, 22 Jan 2024 23:16:06 +0100
Message-Id: <20240122221610.556746-8-maciej.fijalkowski@intel.com>
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

Ice and i40e ZC drivers currently set offset of a frag within
skb_shared_info to 0, wchih is incorrect. xdp_buffs that come from
xsk_buff_pool always have 256 bytes of a headroom, so they need to be
taken into account to retrieve xdp_buff::data via skb_frag_address().
Otherwise, bpf_xdp_frags_increase_tail() would be starting its job from
xdp_buff::data_hard_start which would result in overwriting existing
payload.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index fede0bb3e047..65f38a57b3df 100644
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


