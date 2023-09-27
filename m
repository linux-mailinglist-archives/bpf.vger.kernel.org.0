Return-Path: <bpf+bounces-10935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDF7AFD51
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 59F72283D9D
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67441D69B;
	Wed, 27 Sep 2023 07:58:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435011D550;
	Wed, 27 Sep 2023 07:58:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E3126;
	Wed, 27 Sep 2023 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801503; x=1727337503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U8eljhMLEyBIju175yvG4Bi0XR8ptK6pcnPdUl+zPnU=;
  b=g6NKw6icVW3ezxk8pKsj80unnVVwdHsKf7BO/LTbOtCjs2Mkngd8LEf8
   Ozdmn4tTfAC2z46JsUyxBCjGgeTUQzmyqYa9y+QGgOkBdQFdwBO+AnhOB
   /0V0lDEkQ7wLkJV7kwjDG5UcbDnJgazP7kdSHNDel8gGPpsU6zRHIxoHY
   ReOFpSG8FXyjxoICfCzAl+9+KVy8RstBSkECUujHTsJrILGOlaozOzTQ3
   JNDm70UjpiKCB04/OQvB7CklQ1WLZUl1ZQ2khdiBLAmAupiiwOQI4fvIA
   4lhpZIPa33K39hc78ZxAImeO0YM2VWI9GcrNyBvkPsUxSnZJVte9K/FdM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366818126"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366818126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725714055"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725714055"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 00:58:15 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 60EBD7EAC3;
	Wed, 27 Sep 2023 08:58:13 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [RFC bpf-next v2 14/24] ice: put XDP meta sources assignment under a static key condition
Date: Wed, 27 Sep 2023 09:51:14 +0200
Message-ID: <20230927075124.23941-15-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927075124.23941-1-larysa.zaremba@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Usage of XDP hints requires putting additional information after the
xdp_buff. In basic case, only the descriptor has to be copied on a
per-packet basis, because xdp_buff permanently resides before per-ring
metadata (cached time and VLAN protocol ID).

However, in ZC mode, xdp_buffs come from a pool, so memory after such
buffer does not contain any reliable information, so everything has to be
copied, damaging the performance.

Introduce a static key to enable meta sources assignment only when attached
XDP program is device-bound.

This patch eliminates a 6% performance drop in ZC mode, which was a result
of addition of XDP hints to the driver.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 3d0f15f8b2b8..76d22be878a4 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -210,6 +210,7 @@ enum ice_feature {
 };
 
 DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
+DECLARE_STATIC_KEY_FALSE(ice_xdp_meta_key);
 
 struct ice_channel {
 	struct list_head list;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47e8920e1727..ee0df86d34b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -48,6 +48,9 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
 DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
 EXPORT_SYMBOL(ice_xdp_locking_key);
 
+DEFINE_STATIC_KEY_FALSE(ice_xdp_meta_key);
+EXPORT_SYMBOL(ice_xdp_meta_key);
+
 /**
  * ice_hw_to_dev - Get device pointer from the hardware structure
  * @hw: pointer to the device HW structure
@@ -2634,6 +2637,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
 	return -ENOMEM;
 }
 
+static bool ice_xdp_prog_has_meta(struct bpf_prog *prog)
+{
+	return prog && prog->aux->dev_bound;
+}
+
 /**
  * ice_vsi_assign_bpf_prog - set or clear bpf prog pointer on VSI
  * @vsi: VSI to set the bpf prog on
@@ -2644,10 +2652,16 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
 	struct bpf_prog *old_prog;
 	int i;
 
+	if (ice_xdp_prog_has_meta(prog))
+		static_branch_inc(&ice_xdp_meta_key);
+
 	old_prog = xchg(&vsi->xdp_prog, prog);
 	ice_for_each_rxq(vsi, i)
 		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
 
+	if (ice_xdp_prog_has_meta(old_prog))
+		static_branch_dec(&ice_xdp_meta_key);
+
 	if (old_prog)
 		bpf_prog_put(old_prog);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4fd7614f243d..19fc182d1f4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -572,7 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	if (!xdp_prog)
 		goto exit;
 
-	ice_xdp_meta_set_desc(xdp, eop_desc);
+	if (static_branch_unlikely(&ice_xdp_meta_key))
+		ice_xdp_meta_set_desc(xdp, eop_desc);
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 39775bb6cec1..f92d7d33fde6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -773,6 +773,9 @@ static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
 				   union ice_32b_rx_flex_desc *eop_desc,
 				   struct ice_rx_ring *rx_ring)
 {
+	if (!static_branch_unlikely(&ice_xdp_meta_key))
+		return;
+
 	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
 	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
 	ice_xdp_meta_set_desc(xdp, eop_desc);
-- 
2.41.0


