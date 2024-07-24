Return-Path: <bpf+bounces-35534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42593B56F
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AA51F247A8
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674C16C6A5;
	Wed, 24 Jul 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMIWQCum"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A916B38B;
	Wed, 24 Jul 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840320; cv=none; b=qNk4y9Bc6PvnTaltQ2wpy5aeeMoLYRlmJIuVwsWwaUct9uP8adHXshZX/nwK/2ot1duTf9/Ac0O9Rjv7JxMfj4p5RBaD/QtJcddvSA6pnEIvyd+KxEYXfheCnyFd2kjdDze1g7NMG36OBV9iLOLc7/bedHDdM2AieXWwivbF+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840320; c=relaxed/simple;
	bh=XXOM9x7lnT1f6EFgRH1Y5lZwdBw476V3dhOkr66oUaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpYLslFadGBh9T2JKP+EljGekdcuUNM5g0SMU4ZgM9xB1h5l1LpgHOy1CLB69rjofPiEBm/ofA3EiB+npBDYn/sCTx49QOtTmbMhb9UcRhdTM/H4C2j6rQrnXn5z176pnC0/4xaxGBkXmFOln3M+V+bmvB1ZuL1uuAn2EoyESB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMIWQCum; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721840320; x=1753376320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXOM9x7lnT1f6EFgRH1Y5lZwdBw476V3dhOkr66oUaI=;
  b=BMIWQCumqrYm/eJ2L6FN8hYY8/LlidF7uFRehUivCfl41sAVBflehHSY
   +HVRePgW4EkyFWgZWvWoIy1Rut9DhYsKtnJl+Axd1wn0jKPSdXqNMtBQa
   R5N2SeQWaasyyxAtUaPx0/v1N/EA4nDvIH3Wv3cvDU+28gXkjcNMCpB2q
   wBOC+ikEHG7oqQ5Wxvu2gfNMAWqsgOghN/O3t4idXSdjCty/5SUi1+Yj7
   GXqVHyHylEfKmF5HmJoiCTXXl6gBDE94YhvC7mS2c+x4Yi/j2TeoqL4wj
   FWiNrC7Kco2znWamqqjR4GPeZLAh2fxQ7/i5ZpOkerLtKS7zFPhr6x8Qo
   A==;
X-CSE-ConnectionGUID: XtVSzlWCRTqaw7ilNiPG7w==
X-CSE-MsgGUID: jrMqB3RKTY22NemXHPYUSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30679784"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30679784"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:58:39 -0700
X-CSE-ConnectionGUID: WfIoqxQxRLeuGcfyfGQuwQ==
X-CSE-MsgGUID: CkD4sznGSp2VYi1mOn9WdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="56960631"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2024 09:58:34 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 909A12878C;
	Wed, 24 Jul 2024 17:58:32 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
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
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: [PATCH iwl-net v2 4/6] ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
Date: Wed, 24 Jul 2024 18:48:35 +0200
Message-ID: <20240724164840.2536605-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724164840.2536605-1-larysa.zaremba@intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider the following scenario:

.ndo_bpf()		| ice_prepare_for_reset()		|
________________________|_______________________________________|
rtnl_lock()		|					|
ice_down()		|					|
			| test_bit(ICE_VSI_DOWN) - true		|
			| ice_dis_vsi() returns			|
ice_up()		|					|
			| proceeds to rebuild a running VSI	|

.ndo_bpf() is not the only rtnl-locked callback that toggles the interface
to apply new configuration. Another example is .set_channels().

To avoid the race condition above, act only after reading ICE_VSI_DOWN
under rtnl_lock.

Fixes: 0f9d5027a749 ("ice: Refactor VSI allocation, deletion and rebuild flow")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f9852f1a136e..b773078ad81a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2665,8 +2665,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
  */
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 {
-	if (test_bit(ICE_VSI_DOWN, vsi->state))
-		return;
+	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
 
 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
@@ -2674,15 +2673,16 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
-
-			ice_vsi_close(vsi);
+			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
+			if (!already_down)
+				ice_vsi_close(vsi);
 
 			if (!locked)
 				rtnl_unlock();
-		} else {
+		} else if (!already_down) {
 			ice_vsi_close(vsi);
 		}
-	} else if (vsi->type == ICE_VSI_CTRL) {
+	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
 		ice_vsi_close(vsi);
 	}
 }
-- 
2.43.0


