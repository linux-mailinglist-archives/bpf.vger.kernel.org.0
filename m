Return-Path: <bpf+bounces-38819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41396A68C
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE953284A2F
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2A1925BF;
	Tue,  3 Sep 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUBXFqSY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2E191F85;
	Tue,  3 Sep 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388254; cv=none; b=cd9S6ZlE9YAFHiZ9qSnZCaJCvetoDXF7H0MBTCaXxxN6feDHBvH3ijiN2f60i2cE2P1iKzlp9yKX2U/du1dlAHp3HUxgI1+haKzsJ/4STvTG2YXzPm5dlRT81iTNx2rDVvBnahjVT8p0TWla3jYRfQsL6ksLcubX4Hm/fQMBgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388254; c=relaxed/simple;
	bh=beVCJWWJ2Vp6YHnA4vCcYui8LUeOGmKMU7d1iT2qF/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bimd2jvzvYyIUrjmtRvT78IvzHdxJkeFhJXF4Z1UbPfIbOUyoU14uIteuwKa357QFDGdwfKFIh3CHhg7THAnf52WlntjTr2Jbyvc64hhy0IhgSZKt1OkAmmsBFF6rzzYPZNzdCSG3hOww1YZpACk5/irQPvyftgNnQf29vsMmWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUBXFqSY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388253; x=1756924253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=beVCJWWJ2Vp6YHnA4vCcYui8LUeOGmKMU7d1iT2qF/4=;
  b=kUBXFqSY4+LkEULLi2F8qbE815XoR38+sH2Nhe9awaQZVfc2Rd5qINA8
   DBr9xbDAU1RkcnFyDxLZbG3wgIqBpAL8EtwiMSWNGc/PeYpfX/12xAXXR
   1XtguvyuGyT/eiowW17VfkCuzXgjLK9vFfDF0K30MyCMOziwtAGZgLwrJ
   8lJ4O+aB9QkwFHL1oUJvIce1kE5iJ62JML9WKo2yVW9JOyqumU5dTO3d7
   Cm15zTPmtNGXiWVcLwYl/7gm+69p/WhBfRs6VswDbWkBEUItCxQY4YaFJ
   dy1Bjc4Rh39/v4mOasoDigoy2IfWTyJXYwcyByn0KNE1T0FmqYRou04iO
   w==;
X-CSE-ConnectionGUID: /clmIV3bSHCcPycKT/fGHw==
X-CSE-MsgGUID: F5ZKqxnTTnG0bXMG5pH6Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24147014"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24147014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:30:51 -0700
X-CSE-ConnectionGUID: SOBaGnoZTG2BVtWHwU2pCw==
X-CSE-MsgGUID: gVNOkTjpSMmV5IyH56kXyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88250239"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2024 11:30:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	michal.kubiak@intel.com,
	jacob.e.keller@intel.com,
	amritha.nambiar@intel.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 4/6] ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
Date: Tue,  3 Sep 2024 11:30:30 -0700
Message-ID: <20240903183034.3530411-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
References: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 3dccfaba024c..737c00b02dd0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2672,8 +2672,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
  */
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 {
-	if (test_bit(ICE_VSI_DOWN, vsi->state))
-		return;
+	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
 
 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
@@ -2681,15 +2680,16 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
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
2.42.0


