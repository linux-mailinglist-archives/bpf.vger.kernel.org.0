Return-Path: <bpf+bounces-34154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DAA92ABDF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F21F22FFE
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302614F9E7;
	Mon,  8 Jul 2024 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPC/4Fgn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC115252D;
	Mon,  8 Jul 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476875; cv=none; b=cUxPfi5mRSD9xJo0f//cxI0Av9Oc+g5M79B9o2lElg3Uksces6lMRaI2S1PgWAhMoWlbrHuAxneYn6cJw8BObf124zcRU0xp401pAOv6WKZ1qHo0JBD03QfkleoNkbOtpmZ0Bkr0P9KGLBgn1KJIz10bbw6YFeaxwEGkpJ0PfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476875; c=relaxed/simple;
	bh=xE86BGRtQWWMnOyK+r1yEqFx04WZKR0PhfuQ7KGuVVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XalS5UC78+GUVwbVbBTPwNGbLpg4XG4X+6BJLPdzvHHGqGeAkV2EzlyvzyE+fE9cgs4zLgd77zhbDEr7qt8Rcnt0LvOR6IYwcVckH7VYfwcLjxq9T/8O8Up/CAO7QOmCkEk7bvR4N6MJvkvHnntI27ywtNkvpAow9zCxFy5IDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPC/4Fgn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720476874; x=1752012874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xE86BGRtQWWMnOyK+r1yEqFx04WZKR0PhfuQ7KGuVVg=;
  b=PPC/4FgnpZbsrox2mt1wVPgaIO7lCeKRVXgYlNGgXRbeoBJtuydEGuSn
   rOsFxvvjBaejF6gpnzOhpSAXtQuztpOVnzJeF/4WX92RI+gpioUpvWnIU
   Pc94hY2HPSx8df75+n7DJYsb+IKqD/c/aOkeU0A6pCBm0P359WZVSgMaE
   /cb0MLT9R/vcxMng1fu9KB2BTzw60eIiH+SjcnrKTc+o2+bncXAcphmUN
   d5O7WUG9dlOezIaP5pcBuGcYWYwtkMPOKZygCLY26AZEYbxMhXt2Ot9cS
   6SCel3VGxHW/28yDZTD9jV1CmLtwRjmkHX0j+mOpppZbDNgQvM/4E3Eox
   Q==;
X-CSE-ConnectionGUID: d9AJYyDtRvmEw0/uumjIjA==
X-CSE-MsgGUID: sTwKS7WjT52HKrx0gxpNKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17340147"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17340147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:14:31 -0700
X-CSE-ConnectionGUID: KgussPKpS0yFJ3BDPlY58A==
X-CSE-MsgGUID: kByg+hGfTPCG6xT/1Kn0Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52237732"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2024 15:14:31 -0700
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
Subject: [PATCH net 7/8] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
Date: Mon,  8 Jul 2024 15:14:13 -0700
Message-ID: <20240708221416.625850-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
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
index f4b2b1bca234..4c115531beba 100644
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
2.41.0


