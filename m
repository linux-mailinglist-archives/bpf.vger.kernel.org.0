Return-Path: <bpf+bounces-3179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993AD73A861
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA1B1C211BA
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9C6206B2;
	Thu, 22 Jun 2023 18:41:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7D1E536;
	Thu, 22 Jun 2023 18:41:08 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562BF1;
	Thu, 22 Jun 2023 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459268; x=1718995268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLFeE5MAtl9eWX0lpvDfmdHFjEW/w4520/nD9Ne+d1E=;
  b=KVkg/41sGZD0jvWKJWTeCli0wmYg4NjL1cSKUEe5DX40FJuqGHvMsaMH
   Qe5gidAonsAv3VR6+2XXbUO/x5P1SoUlQdt8mmv0mLtIiN+6u+uQo+LEA
   CQUQCZdjHvQw6pZjB4Zp6C+kgDYQZF5AH/wP7wJd8B8arPw8NSkUXD7xn
   hiG2hd4JWxI4gkzW39EVk503z0vzn0S6Bmr+t7IOs6fWPu9Vymfxqq1HC
   PS0upqqllE90VO71oqYXsLgMXLnYtiZySfu686geXIbOctkud/hMaE4wE
   Xa2FvIjGq9ZYysdqRkrifvDHQbAeW0d6CF8Q0L9W5gLBC9yvG8oqUX/Dn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340917779"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340917779"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961687001"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961687001"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 11:41:06 -0700
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net-next 2/6] ice: allow hot-swapping XDP programs
Date: Thu, 22 Jun 2023 11:35:57 -0700
Message-Id: <20230622183601.2406499-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Currently ice driver's .ndo_bpf callback brings interface down and up
independently of XDP resources' presence. This is only needed when
either these resources have to be configured or removed. It means that
if one is switching XDP programs on-the-fly with running traffic,
packets will be dropped.

To avoid this, compare early on ice_xdp_setup_prog() state of incoming
bpf_prog pointer vs the bpf_prog pointer that is already assigned to
VSI. Do the swap in case VSI has bpf_prog and incoming one are non-NULL.

Lastly, while at it, put old bpf_prog *after* the update of Rx ring's
bpf_prog pointer. In theory previous code could expose us to a state
where Rx ring's bpf_prog would still be referring to old_prog that got
released with earlier bpf_prog_put().

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 65bf399a0efc..5dd88611141e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2633,11 +2633,11 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
 	int i;
 
 	old_prog = xchg(&vsi->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
-
 	ice_for_each_rxq(vsi, i)
 		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 }
 
 /**
@@ -2922,6 +2922,12 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		}
 	}
 
+	/* hot swap progs and avoid toggling link */
+	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
+		ice_vsi_assign_bpf_prog(vsi, prog);
+		return 0;
+	}
+
 	/* need to stop netdev while setting up the program for Rx rings */
 	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, vsi->state)) {
 		ret = ice_down(vsi);
@@ -2954,13 +2960,6 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		xdp_ring_err = ice_realloc_zc_buf(vsi, false);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Rx resources failed");
-	} else {
-		/* safe to call even when prog == vsi->xdp_prog as
-		 * dev_xdp_install in net/core/dev.c incremented prog's
-		 * refcount so corresponding bpf_prog_put won't cause
-		 * underflow
-		 */
-		ice_vsi_assign_bpf_prog(vsi, prog);
 	}
 
 	if (if_running)
-- 
2.38.1


