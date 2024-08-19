Return-Path: <bpf+bounces-37493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8983956806
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66326283B0A
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5EA166F39;
	Mon, 19 Aug 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGVNG18m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E47165EF6;
	Mon, 19 Aug 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062487; cv=none; b=gbxaZNYzf6hzIAYVvuDebyI6vgGfHz1MNeoTkuNaqz8N012rdCx5y4w4htBXcj2iHiPwvKghlb2ynvCBe1ODJ9rx1q8c0ojbw/ijNm5iCdMoXG9bEz5GVIxADHsV11HqcNTfpJPRnjzTufrOQMCwzYwR35OfiVzwFN75i96mLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062487; c=relaxed/simple;
	bh=NLhq04lnu+KpbIptdCwfMqC7vkjmfPTxuVrCa4ZWpAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1UjkDP7yHtq4ngSanimrKkH0o+Up0ruUMDgoxOdzzoR/MPF1xxzjoJ97jNHxJdnpiaQFAVc2FPYE8DoiNy6F5nYVCYCsxkQ4E9aCKAnki+OsvOYa2LbKhW0pwROAzto6tQaa1iEE9QoKf2h2nzhTgkDWbQ3xXpwgsZgHf05uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGVNG18m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062486; x=1755598486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NLhq04lnu+KpbIptdCwfMqC7vkjmfPTxuVrCa4ZWpAA=;
  b=NGVNG18mYJUL9xmwvSSnEHT9CKSQSAhFaiPSZ8Dqnod8OpelwhfYi6Do
   DBorKWqO/zu4wu+FLByy8DwQZrCgz2pVb7gqx0NfveIyOilsG6dhOUp8r
   KNs9qpttoWQuxwm287Alz5QLa9a9qB1I2kA4JBbjbQPtm5DbkafE+qK/F
   6C487fqcwsuffuxjiHanCdD5CTU4wf/oxjHzrXPyN7BNRP1Twds0idgL3
   CXAYNq0waxpiLhXHSaKuuUh1bTVXxG3GVVHPNsIr3kxb1B5nU4cROS2U4
   +SyZn27gLhb13CJ605ORQSTfLRpQTo2rnHKd8vZe2SvaVTaY2Fpz+8rpt
   Q==;
X-CSE-ConnectionGUID: mLzU73qNQYS7R3fXVEYOfg==
X-CSE-MsgGUID: 2isc6y5wShqUucSpH80E6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="13090178"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="13090178"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:14:43 -0700
X-CSE-ConnectionGUID: 74XTKPG2TmmdQqfqkloIPg==
X-CSE-MsgGUID: NDiyf87sRkqlF33qI7JN7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91097107"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 03:14:39 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DAB8F28197;
	Mon, 19 Aug 2024 11:14:37 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH iwl-net v3 5/6] ice: remove ICE_CFG_BUSY locking from AF_XDP code
Date: Mon, 19 Aug 2024 12:05:42 +0200
Message-ID: <20240819100606.15383-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819100606.15383-1-larysa.zaremba@intel.com>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
state, not VSI one. Therefore it does not protect the queue pair from
e.g. reset.

Despite being useless, it still can deadlock the unfortunate functions that
have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
returns an error.

Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8693509efbe7..5dee829bfc47 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -165,7 +165,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_q_vector *q_vector;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	int timeout = 50;
 	int fail = 0;
 	int err;
 
@@ -176,13 +175,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	rx_ring = vsi->rx_rings[q_idx];
 	q_vector = rx_ring->q_vector;
 
-	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
-		timeout--;
-		if (!timeout)
-			return -EBUSY;
-		usleep_range(1000, 2000);
-	}
-
 	synchronize_net();
 	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
@@ -261,7 +253,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 		netif_carrier_on(vsi->netdev);
 	}
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
 }
-- 
2.43.0


