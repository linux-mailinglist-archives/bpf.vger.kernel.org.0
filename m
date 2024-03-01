Return-Path: <bpf+bounces-23185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4686E97E
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8C31F26B9A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905543BB33;
	Fri,  1 Mar 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgQ7OFU9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D593B1AB;
	Fri,  1 Mar 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321163; cv=none; b=PPrDkZ7xQywLyB6FIT37LaTjEE6C/EhMMMcM3chx7wPrYcQSIVge5a7S4XAyUszgyFfVxkaq80ktdXnr5bTRdUJ9mhJmsdQqKrm/+6a0ynuPUfFtwkVolkYAGRrVkLY9KKPjaw4Uwu4HCAYv/uI0DUbz/Vv3ZQrdNzilmM40ZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321163; c=relaxed/simple;
	bh=SGGKMMtB60E5h74dmhwfT/9k7zgRLTvdOUSCxw0qhI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daGqiNuIRkqhFrB4CRhFARbWNXQdLpP1x4MCJfPr2md0fAAjYIE73KA75srWJeR+GELu9GUBtE9xjDmFa44AhlIrEQk0lsZuM1hfraOU5jliqDifSChj39MuRiipwjMmT+GWkpbAwTKaYsky1BtPfIVSi2t9Fp3lmtwFMRatdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgQ7OFU9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709321161; x=1740857161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGGKMMtB60E5h74dmhwfT/9k7zgRLTvdOUSCxw0qhI4=;
  b=FgQ7OFU9jCdkjbv4WqYWGh6u8puw/U3GlPJl5DqZEbGWVSyqOLyNY+NC
   cyJsECHEs63Y7mfdqzL6aa81J/cRb/nVeItJS/CLXfPdGBpUG2PBJOpLh
   07yLcihV8FnuIiAtYnBy82dUULjijAzeHJ+uqS/Ig3kBAhbrAzDsiY4KO
   gpbgv6+HF6o2ZjBKZptrDM6vYm5Uc9bY4/lUkHsYGMaMchGbiwwxpQnm0
   Ea2vkLC34zEFiycetOgC91Xpw5yuXXuLmUoMGRdzbpAuWgNO0z3lMafox
   FhHcqXwGOJnvDObxX/oUAVi+EbgILCWyaA1cxSvxOStp2AQfNAXH0GOgx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7694934"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7694934"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12998479"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 11:25:57 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 3/4] ice: reorder disabling IRQ and NAPI in ice_qp_dis
Date: Fri,  1 Mar 2024 11:25:48 -0800
Message-ID: <20240301192549.2993798-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
References: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

ice_qp_dis() currently does things in very mixed way. Tx is stopped
before disabling IRQ on related queue vector, then it takes care of
disabling Rx and finally NAPI is disabled.

Let us start with disabling IRQs in the first place followed by turning
off NAPI. Then it is safe to handle queues.

One subtle change on top of that is that even though ice_qp_ena() looks
more sane, clear ICE_CFG_BUSY as the last thing there.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8b81a1677045..2eecd0f39aa6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -179,6 +179,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
+
+	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
@@ -195,13 +199,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
-
 	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
 	if (err)
 		return err;
 
-	ice_qvec_toggle_napi(vsi, q_vector, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
@@ -259,11 +260,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	if (err)
 		return err;
 
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return 0;
 }
-- 
2.41.0


