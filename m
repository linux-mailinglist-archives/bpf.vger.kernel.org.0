Return-Path: <bpf+bounces-35919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084693FEBB
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B564B21C3F
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8618A929;
	Mon, 29 Jul 2024 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LL5V2nPc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD92187348;
	Mon, 29 Jul 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283647; cv=none; b=fVgrz4et6XbPUCG+D6cylloRjJgGQABG5i6l0LD/4VvjHrkX9Q5fNqV//CgcHnFH2Dpr+09zt/KDwK6nI0e3h/eaiVMjHU9JgVZSqgQHfhr5n5af9Qrk/I9XYdtSG8nBZC3FLhbbHgN90j8Nz1KMcKJUKFTP4XsEzJptrdcgp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283647; c=relaxed/simple;
	bh=YP5dr/ZSKjCtpvLWie8VEahFsRnH60EdY4KqQYmzPmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL/8K1v33OBocTeRMyCtHhXg6xeczo1XbkZWyA9Oz+V9I7owjDUVtl/9qr1PEzFuWUe7Mk1UvAOyD0E5YIMRAbw1TknW1pUogumGOSUJvQ99bMMOUXFz5LwbX8SUCysYBM8PA+7VyXnzNbr50FTCWe+uNGZJ6gRB5kTyGhhemxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LL5V2nPc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722283645; x=1753819645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YP5dr/ZSKjCtpvLWie8VEahFsRnH60EdY4KqQYmzPmw=;
  b=LL5V2nPcez7bFZjU3YetH9w2OOW5xmoE8J8rZM2XEI50za+rErDREars
   1NoL6Ow3xcfrfZIXtZdN1Hm0f1Lck5Mziqln4+U11c7QlwflMDfo3HkZ3
   PumYRIl2McyNtTMIiPwC+/JQSzBR3zo1+SUoFsw03ffNa0kUcDDfIo0r5
   yg5ASx1ExBHTed3obUBIbr6gj2pQswhLzTWLH7rTspdFKhDTo2kge5RKC
   LQBfjDn5npnDSMTQ7398D0UW/9OJYgfC0kSKuptwvBaCBwt4DSot6csvT
   L9HIlETWP0y10Jgc2TTlxnSHsz9Dbakd4Cxrf3bmlA9DkIv99rlTPl73M
   Q==;
X-CSE-ConnectionGUID: 7CYQDNXaTkW6rC74EPE7JQ==
X-CSE-MsgGUID: xYO+O11VTMOH2zNmxmlWgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23818506"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23818506"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:07:23 -0700
X-CSE-ConnectionGUID: pmNZZa9kRPawsw1DSLxVFw==
X-CSE-MsgGUID: L8kr2zd5SpeT/LZA6GieHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54681281"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2024 13:07:23 -0700
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
Subject: [PATCH net v2 2/8] ice: don't busy wait for Rx queue disable in ice_qp_dis()
Date: Mon, 29 Jul 2024 13:07:08 -0700
Message-ID: <20240729200716.681496-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
References: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

When ice driver is spammed with multiple xdpsock instances and flow
control is enabled, there are cases when Rx queue gets stuck and unable
to reflect the disable state in QRX_CTRL register. Similar issue has
previously been addressed in commit 13a6233b033f ("ice: Add support to
enable/disable all Rx queues before waiting").

To workaround this, let us simply not wait for a disabled state as later
patch will make sure that regardless of the encountered error in the
process of disabling a queue pair, the Rx queue will be enabled.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 72738b8b8a68..3104a5657b83 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -199,10 +199,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-- 
2.42.0


