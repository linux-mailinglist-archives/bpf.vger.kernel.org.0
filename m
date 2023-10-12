Return-Path: <bpf+bounces-12056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0E7C73D3
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC84282990
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294538DEC;
	Thu, 12 Oct 2023 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJLQGenP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43637164;
	Thu, 12 Oct 2023 17:12:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9BB7;
	Thu, 12 Oct 2023 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130772; x=1728666772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUcK1rwh0PuHKBdk/brR50LjiE2DrMuT31ALE6+YqG8=;
  b=YJLQGenPZrX5+i56PotA3JwVItul5Lhu3lHuCWGaiIdXcnkxfrxDw8bg
   AqngHCjSJtImPh9VrhzTHBCqaGHUFEWf92ta05LQjkabSWXEJ/1WvTdAg
   TxflrB8Y/YZVEbnPZFLXVauJEE/rCywpb1Yq70U1jRo0WxBlT31E2OENk
   CdkT3wB3V9KueJdiz0YW/jsdmpUEibwTtDz6HhLLUXf5bU/rHpcKzjkfR
   v33RAGY5SBJGyYXoNfvO25X1I5k2nQknb11rxVHIbgYVHxLJdyk6Jjnva
   N/xpRg/8dvi6Y7TLQ3xM2vjxMYsqBW1b6I1ti2bH0ZqihHiS9T1KnOD1a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416027661"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416027661"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783774037"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783774037"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2023 10:12:08 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 327A633EA3;
	Thu, 12 Oct 2023 18:12:06 +0100 (IST)
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
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
Subject: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC mode
Date: Thu, 12 Oct 2023 19:05:13 +0200
Message-ID: <20231012170524.21085-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012170524.21085-1-larysa.zaremba@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In AF_XDP ZC, xdp_buff is not stored on ring,
instead it is provided by xsk_buff_pool.
Space for metadata sources right after such buffers was already reserved
in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
This makes the implementation rather straightforward.

Update AF_XDP ZC packet processing to support XDP hints.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index ef778b8e6d1b..6ca620b2fbdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
 	return ICE_XDP_CONSUMED;
 }
 
+/**
+ * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
+ * @xdp: xdp_buff used as input to the XDP program
+ * @eop_desc: End of packet descriptor
+ * @rx_ring: Rx ring with packet context
+ *
+ * In regular XDP, xdp_buff is placed inside the ring structure,
+ * just before the packet context, so the latter can be accessed
+ * with xdp_buff address only at all times, but in ZC mode,
+ * xdp_buffs come from the pool, so we need to reinitialize
+ * context for every packet.
+ *
+ * We can safely convert xdp_buff_xsk to ice_xdp_buff,
+ * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
+ * right after xdp_buff, for our private use.
+ * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
+ */
+static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
+				   union ice_32b_rx_flex_desc *eop_desc,
+				   struct ice_rx_ring *rx_ring)
+{
+	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
+	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
+	ice_xdp_meta_set_desc(xdp, eop_desc);
+}
+
 /**
  * ice_run_xdp_zc - Executes an XDP program in zero-copy path
  * @rx_ring: Rx ring
  * @xdp: xdp_buff used as input to the XDP program
  * @xdp_prog: XDP program to run
  * @xdp_ring: ring to be used for XDP_TX action
+ * @rx_desc: packet descriptor
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
 static int
 ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
+	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
+	       union ice_32b_rx_flex_desc *rx_desc)
 {
 	int err, result = ICE_XDP_PASS;
 	u32 act;
 
+	ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	if (likely(act == XDP_REDIRECT)) {
@@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
+		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
+					 rx_desc);
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
 			xdp_xmit |= xdp_res;
 		} else if (xdp_res == ICE_XDP_EXIT) {
-- 
2.41.0


