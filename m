Return-Path: <bpf+bounces-3904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A574623F
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29FF280E72
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4777168DC;
	Mon,  3 Jul 2023 18:17:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E80156DE;
	Mon,  3 Jul 2023 18:17:32 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AAAE78;
	Mon,  3 Jul 2023 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408247; x=1719944247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sHqdvBvHsNSPyHC4M445WTPfz0TpuEcQFCdK7bBdueQ=;
  b=SI8D6mvPKXSYdKKs+kpVqfI3FjRItjDo5UcnxVDcS2mGT9SRzT4Ejhcy
   uWAVcSHYZeM8vjL8Ii8pUyUEGTNOjwzApT7VM+iTMXPT/ONBPJAEb4FEM
   FNRj+CWoQpXhSZG5pfHs2LLoiBjoPggPEkKU/eCBoF4DFShFE8/EqLLKH
   K1rKdf+baYEw6y+NAH8UKSkfxzJtVPE/b1fpCEy7kq3HtzRZ7KnPKGUwW
   P1RiflAX9fb1oG7xumAbY/W2NPndEw34fMS8b9sVeHtAuMEizc4Do7hWn
   gBxtOWF9ECHb1SS/Oa/3Vaz8iPMMmsJKGX8O4kGwDlT/WOyNmkpdaA8Uv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393682691"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393682691"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892615146"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892615146"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 11:17:07 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B7E4C35803;
	Mon,  3 Jul 2023 19:17:05 +0100 (IST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 13/20] ice: Implement checksum level hint
Date: Mon,  3 Jul 2023 20:12:19 +0200
Message-ID: <20230703181226.19380-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703181226.19380-1-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement .xmo_rx_csum_lvl callback to allow XDP code to determine,
whether checksum was checked by hardware and on what level.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e9f334fecdf1..41ab52b6990d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -660,8 +660,34 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the checksum
+ * @ctx: XDP buff pointer
+ * @csum_lvl: destination address
+ *
+ * Copy HW checksum level (if was checked) to the destination address.
+ */
+static int ice_xdp_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_lvl)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *eop_desc;
+	enum ice_rx_csum_status status;
+	u16 ptype;
+
+	eop_desc = xdp_ext->pkt_ctx.eop_desc;
+	ptype = ice_get_ptype(eop_desc);
+
+	status = ice_get_rx_csum_status(eop_desc, ptype);
+	if (status & ICE_RX_CSUM_NONE)
+		return -ENODATA;
+
+	*csum_lvl = ice_rx_csum_lvl(status);
+	return 0;
+}
+
 const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_csum_lvl		= ice_xdp_rx_csum_lvl,
 };
-- 
2.41.0


