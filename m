Return-Path: <bpf+bounces-31726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F49025F2
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BB31C21A02
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393571459F0;
	Mon, 10 Jun 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktG1mqw5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD914387E;
	Mon, 10 Jun 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034312; cv=none; b=cqOYAtRED0db3O+1Wp0g4SA5Zh5y6mH1AlGVBAXjvxkdrhCRWqcLGQI3hNdVjRYYDn5YXnRs/W1+RJMwkpLK7asbNGO/m+SZUrhq+xrdfrA/ecQoPnJKoFsOY9RuHiImxtTNHbPq97j1+bXjb88gQZcaQ4ytxshyt3o+jdbTIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034312; c=relaxed/simple;
	bh=77taguqMlOk9palmEIZHwzEPuGl4cXRwnQzwDICfdrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW2gOfReW99FyEn2P0H1C5F03DjpShkAxLkWcVceXsqmGfz1EOQD8CqqDCEcIvx9+W7wpdzOA9hfhFssrrsAajYmjEUVDWF9C7KbCavCZ216a4bwFFQ99h9/0mEYcpSDkyAQI5joQ4ITdOknY3c6prUcefJEBggLK8hpWWSK4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktG1mqw5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718034311; x=1749570311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=77taguqMlOk9palmEIZHwzEPuGl4cXRwnQzwDICfdrM=;
  b=ktG1mqw5L1iYa4cKb9v7KEp82MHmR59PjwKhxKr1PUZ1gpR/kWNnwhJ7
   GkMUNX5HomyEtbb4IzrfOf1gFIsJH3GOi1W4reSRj5BaTMJNgHk9g0Rs7
   G9IyW4HplM+0O9/kamMhCmRbKr2WLXC1DK5uy9K7QpUTxHeSEkMGLZ+RZ
   zPOXbuN54gTFv/Mst6Xx5hgCVzGf6hZFobjr7rNCBlmxPnOXl2ypBTyB1
   Z20q4b1Fd1LDrgyMMjLGTIo0TPjZFyZQlVxARZRC9ZPD8f/rKg2aeF7DP
   4uXyy6/grI9/qBaVLJWU3YOKt5+4sZh9tCFX2ofSC/XerBI/T1oz1EK48
   w==;
X-CSE-ConnectionGUID: Xg8+b+XOQJyhftiEc0YARw==
X-CSE-MsgGUID: TgZBS62HT7mM4Ywd/ByQ3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26119872"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26119872"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:45:10 -0700
X-CSE-ConnectionGUID: uVaJisceRt+8/TSVPvmkGA==
X-CSE-MsgGUID: vCchazQYRsOqkyP5o3Padg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43679782"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jun 2024 08:45:05 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0CFDD312D8;
	Mon, 10 Jun 2024 16:44:52 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH iwl-net 3/3] ice: make NAPI setting code aware that rtnl-locked request is waiting
Date: Mon, 10 Jun 2024 17:37:15 +0200
Message-ID: <20240610153716.31493-4-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610153716.31493-1-larysa.zaremba@intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_vsi_rebuild() is a critical section in the reset path. Sometimes,
rtnl-locked callbacks have to wait for it to finish. However, it is
possible they will wait for an eternity, because the critical section
contains calls to ice_queue_set_napi() that try to take rtnl_lock.

Make ice_queue_set_napi() aware that some rtnl-locked code is waiting and
skip taking the lock, if this is the case.

Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c  | 18 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_main.c |  5 ++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 76590cfcaf68..7c1e24afa34b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -307,6 +307,7 @@ enum ice_pf_state {
 	ICE_PHY_INIT_COMPLETE,
 	ICE_FD_VF_FLUSH_CTX,		/* set at FD Rx IRQ or timeout */
 	ICE_AUX_ERR_PENDING,
+	ICE_RTNL_WAITS_FOR_RESET,
 	ICE_STATE_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4774bcc4d5a8..a5dc6fc6e63d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2740,12 +2740,24 @@ ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
 	if (current_work() == &pf->serv_task ||
 	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
 	    test_bit(ICE_DOWN, pf->state) ||
-	    test_bit(ICE_SUSPENDED, pf->state))
+	    test_bit(ICE_SUSPENDED, pf->state)) {
+		bool rtnl_held_here = true;
+
+		while (!rtnl_trylock()) {
+			if (test_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state)) {
+				rtnl_held_here = false;
+				break;
+			}
+			usleep_range(1000, 2000);
+		}
 		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
-				     false);
-	else
+				     true);
+		if (rtnl_held_here)
+			rtnl_unlock();
+	} else {
 		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
 				     true);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cd8be3c3b956..37b3dd22cdc2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3103,8 +3103,11 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 		return -EINVAL;
 	}
 
-	while (test_and_set_bit(ICE_CFG_BUSY, pf->state))
+	while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
+		set_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state);
 		usleep_range(1000, 2000);
+	}
+	clear_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state);
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-- 
2.43.0


