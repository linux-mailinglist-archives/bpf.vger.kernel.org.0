Return-Path: <bpf+bounces-19939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE3683317F
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED561F21624
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4D5917F;
	Fri, 19 Jan 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkx5ttQs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592C1E48E;
	Fri, 19 Jan 2024 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707059; cv=none; b=lZdzHtgMEIzBd3w9+ghUlynVPmdWDVTX6DfregRuvJ22ZH1JWm+ytP3MkeKVuopBBx69sY5z589ULDETWR4qRCJzlOSRzbemgs8ZIBkvAyJgbMY4FU3xhNBcnPuj4CwPCQrEXzsavUkpZ7XE5xKGtCWVVkv4Uq7m6oEhBdeLSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707059; c=relaxed/simple;
	bh=kpk8AaVXYpFzGtJUYtRfQMluwRjTWdMB9fuKbx4RvTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DK/Z31JnaEqAqDgmMCmOzsSrbsYxFV/FvMLfBnrl5QJJ7DKbFNOJq6dBTxE0hX6A5en4GghXJNaxdfRzpLQjMatdPSH8m3q79ZqM43CKgaymIPMRbJBUZUjeZ/s8aRbfnRSrQrWR2Y8kw0uI1IxO64HXHRBfJeHqKW1N72pWsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkx5ttQs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707058; x=1737243058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kpk8AaVXYpFzGtJUYtRfQMluwRjTWdMB9fuKbx4RvTc=;
  b=kkx5ttQsZZdbE+mwD8c/0DiuId0bO/5G56WBjJe01ZH+jENWnoH6l9ZX
   rcmN4JpcYToWq9uqDnto3Tz12wNbRxulUtO4O/MkdDgO40bHnmQTv2JKE
   eP4lPRkkcKMk64i8yHp/Pcgn3fvsdyztqX2ltTmshJi4PY4fGsHI0gz2+
   1zZE5p+xdNh7MlwMSXLi/bCH9yY063N4nHdbP9aKbbfDnkEFHq/04Fvhd
   NxQR/f/RkJLQf+2OX0fhM1xDSDOZtV9gYy+GOi54dJNsJkUKqpVKLAmfo
   eY7+Z0WclUwxLWfNXrpCNH2qa+O/tNIf+2BF9OpjlJTKzjxl+Urrl/8oI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771540"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277418"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277418"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:30:54 -0800
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
Subject: [PATCH v4 bpf 02/11] xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
Date: Sat, 20 Jan 2024 00:30:28 +0100
Message-Id: <20240119233037.537084-3-maciej.fijalkowski@intel.com>
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

Currently, ZC drivers that support multi-buffer XDP, clear flag that
indicates whether particular xdp_buff contains fragments only on the
first processed fragment. Rest of the ZC XSK logic relies on that as
well, but we could end up with fragments that have XDP_FLAGS_HAS_FRAGS
set, which would confuse for example xsk_buff_free(), which might be
called when bpf_xdp_adjust_tail() removes buffer.

To fix this, let us clear the mentioned flag on xsk_buff_pool side at
allocation time.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
 net/xdp/xsk_buff_pool.c                    | 3 +++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index e99fa854d17f..fede0bb3e047 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -499,7 +499,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
 		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
 					  &rx_bytes, xdp_res, &failure);
-		first->flags = 0;
 		next_to_clean = next_to_process;
 		if (failure)
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 5d1ae8e4058a..d9073a618ad6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -895,7 +895,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 
 		if (!first) {
 			first = xdp;
-			xdp_buff_clear_frags_flag(first);
 		} else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
 			break;
 		}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 28711cc44ced..dc5659da6728 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -555,6 +555,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
 	xskb->xdp.data_meta = xskb->xdp.data;
+	xskb->xdp.flags = 0;
 
 	if (pool->dma_need_sync) {
 		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
@@ -601,6 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
 		}
 
 		*xdp = &xskb->xdp;
+		xskb->xdp.flags = 0;
 		xdp++;
 	}
 
@@ -621,6 +623,7 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
 		list_del_init(&xskb->free_list_node);
 
 		*xdp = &xskb->xdp;
+		xskb->xdp.flags = 0;
 		xdp++;
 	}
 	pool->free_list_cnt -= nb_entries;
-- 
2.34.1


