Return-Path: <bpf+bounces-18234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B540B817B03
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C071F2296D
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0F73460;
	Mon, 18 Dec 2023 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PE8CEAkL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A237204D;
	Mon, 18 Dec 2023 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702927638; x=1734463638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTwlFRz8fdk58HYGro3I1+ih2y8zV/BOFONogFxKR+w=;
  b=PE8CEAkLhAlty0TAXT/acK0wcjCmaslW0dG+0RGO0ovXjTb/SJkntXzl
   Jx6muI6gmzz3pwzomPUlWgqdRE5JFehhBdoRgQPBJqv6lwDxpj2w+SAbM
   W5g1sUCKUlKXweuiF96oSSz9XZJhaOEtrs2JkwHTA4TFRMFBEI7U9iEAU
   KJltTjKinW71HwGlSvn2NpoRYB9ZGoxRrUuSrOzjNw/LLhjCUGxbMuM2e
   BdMq+xMvTLMGeKrfQJH5x5joockhVWUUhndMhLYtAtH1UpwSEHxvXt8Yh
   W1pUFqZ9+HNwTQ4cQzJH1sZnj1HX+3VkeJU6aC00U52PF8V4fGjZnVw9m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2377443"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2377443"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809940503"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809940503"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2023 11:27:14 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier after reset
Date: Mon, 18 Dec 2023 11:27:06 -0800
Message-ID: <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
functions") has refactored a bunch of code involved in PFR. In this
process, TC queue number adjustment for XDP was lost. Bring it back.

Lack of such adjustment causes interface to go into no-carrier after a
reset, if XDP program is attached, with the following message:

ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
ice 0000:b1:00.0: PF VSI rebuild failed: -22
ice 0000:b1:00.0: Rebuild failed, unload and reload driver

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index de7ba87af45d..1bad6e17f9be 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 		} else {
 			max_txqs[i] = vsi->alloc_txq;
 		}
+
+		if (vsi->type == ICE_VSI_PF)
+			max_txqs[i] += vsi->num_xdp_txq;
 	}
 
 	dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
-- 
2.41.0


