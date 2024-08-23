Return-Path: <bpf+bounces-37935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A451295CA03
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606A4281CA2
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D718891C;
	Fri, 23 Aug 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnyYpVUe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2461BF3A;
	Fri, 23 Aug 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407697; cv=none; b=SD/Z+vlhCutB9NgAaJgi4g/kHYbsweeaT9DPsmmPtdFMRce6jtMB4SgOrkuZg4yXKkSJ6Zx54pn9FbmD6u43quZSyoWYAQ3cfqg9bugDrlIuz7RdjBx9dNO4umMuAKQwF8v0Ltwl3hkJPzx1IET73E6I8x3WXUaEPzaC4uxqnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407697; c=relaxed/simple;
	bh=pPZzUi92RCPmXkYRAwLn62bmcZwB1cpvraqBFYr+I68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ2/VaMiXwMkIa9IZHJnGn5v/gF01a6uLwKz8Vgbz79A3bpW+zXv1R9mDvdecYo6ipdomd1Nh5P+qfLdg2lo0HARgAvS+dGL1WU8QsYoxJWLKOlXEjjRlah4cJBPsMk5aQ0cGwmkK+0haz5YaoMDnmdy9UKWo9MuHg/z07tDgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnyYpVUe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724407696; x=1755943696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPZzUi92RCPmXkYRAwLn62bmcZwB1cpvraqBFYr+I68=;
  b=KnyYpVUezHKsdjKbMU95FSjguR9/vTD8+YH+bfTREOKiSmdb8LEJ9B+Q
   SAVuoUMsIY/iMgLUW/1TTkMQYBDWJpw4dwVHSQaOpplCF8CLbcALsYlI8
   4j7UhnLJ7g7tatpCrNYWS6QKHuNuIjEEoeCUkbdSosQcdn3fb70A2iW5N
   SvKK+/5f0WSKy/ku99iyGcnA31PNb2N0SWo89rxdSI53m0GfWdxf+VLJN
   Xf2MD2Xvekls5NxzdvQTVT6I9Py8WM3H8OO3DL9Y9tK0ZTP5v3S0v/u5w
   PIuKHH7C/QNobqLWa6p6DDkMyTE0lPkx3utbkGtUy1t3Y72LVtL2Ym1wb
   g==;
X-CSE-ConnectionGUID: kr57NMNcTxqIEvb079kI8g==
X-CSE-MsgGUID: Cvq0ItDRQZmEiA/pvvCUWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34285079"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34285079"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:08:15 -0700
X-CSE-ConnectionGUID: 58cZOUOOQIek5SMcwl17xw==
X-CSE-MsgGUID: LYBAkeKxQ+y7kAoyMW2llQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62479138"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 23 Aug 2024 03:08:10 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 71C9D33BD5;
	Fri, 23 Aug 2024 11:08:07 +0100 (IST)
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
	przemyslaw.kitszel@intel.com,
	anirudh.venkataramanan@intel.com,
	sridhar.samudrala@intel.com,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH iwl-net v4 6/6] ice: do not bring the VSI up, if it was down before the XDP setup
Date: Fri, 23 Aug 2024 11:59:31 +0200
Message-ID: <20240823095933.17922-7-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823095933.17922-1-larysa.zaremba@intel.com>
References: <20240823095933.17922-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a718763d2370..d3277d5d3bd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2984,8 +2984,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		   struct netlink_ext_ack *extack)
 {
 	unsigned int frame_size = vsi->netdev->mtu + ICE_ETH_PKT_HDR_PAD;
-	bool if_running = netif_running(vsi->netdev);
 	int ret = 0, xdp_ring_err = 0;
+	bool if_running;
 
 	if (prog && !prog->aux->xdp_has_frags) {
 		if (frame_size > ice_max_xdp_frame_size(vsi)) {
@@ -3002,8 +3002,11 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
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
2.43.0


