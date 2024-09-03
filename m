Return-Path: <bpf+bounces-38822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01D96A690
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415B51C24285
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5779193082;
	Tue,  3 Sep 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbqoL+rk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4A1925A5;
	Tue,  3 Sep 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388256; cv=none; b=DL2+0JEtSnoZ52O5FcPdv0aFYu1ltyLH4Q4rkCuJr9/TH9nPCQKZdYLdUImGHzN0z5cWblKBk8LwJQZ/6yKE3Rc1peFmTyRwtnyBu0LpCtdDvz5NmnjOllA+skiy/gwP6rjpRDFgTjSQaz/aLrs219iQqleIixnKTY00GyzJld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388256; c=relaxed/simple;
	bh=dyjQzCj4lU41lXlE9DbWo6EUkuvxpVw8oPo3yyG7zdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i178AlkZXnAjYobr8VvLMsj0/ts210OjgBg7i7vT/TFzNCSjxcPd5YUJUZ/qo18djvujy5NI2hp9lXzdAft6ua612UE071SjoCE3hLMUw1Ms6s7bn8mZlkJUZ2fIH7RNxWYd86n/flnP6q6s54E30ew77z/lVbJ//o3VzVEVm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbqoL+rk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388255; x=1756924255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyjQzCj4lU41lXlE9DbWo6EUkuvxpVw8oPo3yyG7zdo=;
  b=XbqoL+rkSq93LtnVfG8usuzMO4JcX8OnzTm4/tjQeYQVQtYHckPO7Z9O
   tzOZd/v/j5I4+ENq16kOzYRqifz+NeoVS5ewxWmA5jTJmWppGLiji6u7r
   jEqNemrgPYLy077aZfSSw4rMT5c+tlBNeSrpcXGo1L2Rc22wD+Z7vZpWO
   PCkDZ8htU4sh/6GjUSCNiJ5bfW5rrulKeKg3TqrSbPS7onR5cGRKTL8CQ
   MbpWoQpGACQvl0I4YoxroIVNWY76HCFVHZhlJiomQQEQbjTfgHxGRf6iu
   5QmGlBHF5rffNsFMtGrUYh57fKzkyeK6dJYsApJv51FUSz1i8MNiOVLiZ
   g==;
X-CSE-ConnectionGUID: NqfD+m2JS8ilxZblxY+yoQ==
X-CSE-MsgGUID: TvNaPBq7QKqSHXf4VRZg3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24147029"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24147029"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:30:53 -0700
X-CSE-ConnectionGUID: R8E+XnYFQuOUkp05O6wFuw==
X-CSE-MsgGUID: PJ2z5mu/SU6nzwqPLvoUbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88250252"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2024 11:30:52 -0700
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
Subject: [PATCH net 6/6] ice: do not bring the VSI up, if it was down before the XDP setup
Date: Tue,  3 Sep 2024 11:30:32 -0700
Message-ID: <20240903183034.3530411-7-anthony.l.nguyen@intel.com>
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

After XDP configuration is completed, we bring the interface up
unconditionally, regardless of its state before the call to .ndo_bpf().

Preserve the information whether the interface had to be brought down and
later bring it up only in such case.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 22b8ef5faf8d..c7db88b517da 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3005,8 +3005,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		   struct netlink_ext_ack *extack)
 {
 	unsigned int frame_size = vsi->netdev->mtu + ICE_ETH_PKT_HDR_PAD;
-	bool if_running = netif_running(vsi->netdev);
 	int ret = 0, xdp_ring_err = 0;
+	bool if_running;
 
 	if (prog && !prog->aux->xdp_has_frags) {
 		if (frame_size > ice_max_xdp_frame_size(vsi)) {
@@ -3023,8 +3023,11 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		return 0;
 	}
 
+	if_running = netif_running(vsi->netdev) &&
+		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
+
 	/* need to stop netdev while setting up the program for Rx rings */
-	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, vsi->state)) {
+	if (if_running) {
 		ret = ice_down(vsi);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Preparing device for XDP attach failed");
-- 
2.42.0


