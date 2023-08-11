Return-Path: <bpf+bounces-7572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDE77944E
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BD82823AF
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D134CC2;
	Fri, 11 Aug 2023 16:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E6329B4;
	Fri, 11 Aug 2023 16:20:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165692;
	Fri, 11 Aug 2023 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691770831; x=1723306831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1RYLOwVkxSCjQ5uYzeQgvLA4lhYTRStRpWhCmp/yNFE=;
  b=kmGeAR2iXG1GipgK/1+A+YyZp7Y6CVh+aHHbrIQ/ey8+3dy5B36dZhJl
   aA0gisQkZMfB0omHFd0/ke1CAWX2cF4zBn2GBlClbtapNUhdULt4aY1KX
   4N68pLXv1bM2Anix009tcDg/vXlsTPn9tE0R1LtGUzIYA3W5JT7kVn2HV
   37wbVaLQHYta/n36H4gov7OGqU5IFpRJ6R9IUKVWwYVHGQWpHHNDaIh4y
   xIuKEl16jXz0E9Pdi71KumWzSH6UuAywI4oa+2+/ISgsmrY1KHLlmLLUZ
   XqkJN7+eqeSCK4UsuqIKBrNPP2OwDB6MICSlGLakxmLbTEqLh0LnvuM/h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351314621"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351314621"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="906501009"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="906501009"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 09:20:22 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D540533BC2;
	Fri, 11 Aug 2023 17:20:20 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf-next v5 08/21] ice: Support XDP hints in AF_XDP ZC mode
Date: Fri, 11 Aug 2023 18:14:56 +0200
Message-ID: <20230811161509.19722-9-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In AF_XDP ZC, xdp_buff is not stored on ring,
instead it is provided by xsk_pool.
Space for metadata sources right after such buffers was already reserved
in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
This makes the implementation rather straightforward.

Update AF_XDP ZC packet processing to support XDP hints.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index ef778b8e6d1b..fdeddad9b639 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -758,16 +758,25 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
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
 
+	/* We can safely convert xdp_buff_xsk to ice_xdp_buff,
+	 * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
+	 * right after xdp_buff, for our private use.
+	 * Macro insures we do not go above the limit.
+	 */
+	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
+	ice_xdp_meta_set_desc(xdp, rx_desc);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	if (likely(act == XDP_REDIRECT)) {
@@ -907,7 +916,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
+		xdp_res = ice_run_xdp_zc(rx_ring, xdp, xdp_prog, xdp_ring,
+					 rx_desc);
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
 			xdp_xmit |= xdp_res;
 		} else if (xdp_res == ICE_XDP_EXIT) {
-- 
2.41.0


