Return-Path: <bpf+bounces-19944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8EB833189
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432891C21F19
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FCF5A11C;
	Fri, 19 Jan 2024 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnaK8UuL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DB5A115;
	Fri, 19 Jan 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707074; cv=none; b=kNHyxA+bgQxTclOF7OVmc+qB7VhC6z3U/TVXawkWPo2gV+stNnNatR5XTJfjv0AW5bcuPG7QqQKo7c9WIOlI0d5p0O4PR0Gvzm5hO9c9fDqRwFITm4kpfODPHYdafasVn4HkV/IBpPqSonLXxL0LcA0VPPZFuWhtK1SPyf8N2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707074; c=relaxed/simple;
	bh=f0m782620pfAxPMwmIUm1Niw+9h/4bYmsbpHFSSlmtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmsMi2omDCVwktjE2NUBzJTyTz6i3FWn5KC7OVm0nABhDh4F0sdwPp8ONzxNP7A8mNTqNEEI7/Ou+yJ2OHFBanqLKMOjnJKHntzsY2SYuVJFh6JPwBz5fUR/3/iid5lNxUJeH2r22BB7053hOOWyIdcitJeNrU2PqoEt5I0ZcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnaK8UuL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707072; x=1737243072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0m782620pfAxPMwmIUm1Niw+9h/4bYmsbpHFSSlmtk=;
  b=dnaK8UuLhXa+t4JMK/L5LN+mtL/hdYu1WBmv0Z4uVk5vpsRCz0jItRL5
   llmnEnN56+NVLvpv4iANTWj4LkXLVt0IDCcfw+Gs3chLd+t6oIIdQFVqM
   gvgBU5yweIGtCB3NqFcC69rqHyr8h9dw1571VOCz2aBC8Ypaddc0Cn7OE
   yYw7cZQmcUdoAWwCkWgx4K6MMtynKdKSJsjSQLVkQ5HigLGHgpdG/EJ5g
   k/IxelDIXZxLb++sR04J8cMaEfcHXXySn5fUZQ+w0BhP6UTAojZ5Gjg0o
   e4nouLU1KmlAVjBVw9nj4r2ojptkUE+mXGrDtu3J4o+cySPclVablFUjJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771628"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771628"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277438"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277438"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:09 -0800
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
Subject: [PATCH v4 bpf 07/11] intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
Date: Sat, 20 Jan 2024 00:30:33 +0100
Message-Id: <20240119233037.537084-8-maciej.fijalkowski@intel.com>
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


