Return-Path: <bpf+bounces-5375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083A759DEA
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5521C2116D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF3626B7E;
	Wed, 19 Jul 2023 18:42:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D379275D1;
	Wed, 19 Jul 2023 18:42:47 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75731FF9;
	Wed, 19 Jul 2023 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792149; x=1721328149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCRT0YNCRb1+JRzmmOM7Ki1u+a+FvS1+eOg+htCms3s=;
  b=G8IUQu0/Gke0sMeWzyY4uhEe1wKZy50vDTTXHBLCaHvc2oxfcmERqWMt
   GcgQIMnTnwIlgMbSxFj4z1Z9teUbBxiOVG6RK/qgqSf7vDmk8WEX/+PU0
   hB6SHZy0XQhGL8ULURkUhPwdc7P8BUl8y75OT9T5VbS+f0ilPL+yyJMDH
   B6Ba6HIkyk/sBRkPCFpetnjquQoJVIV1I82A0A9jNaqobif4KyAQ+9t/u
   9yCyWet9vTSvyrPv3iIHYNy4mnxBwGdygDziZnun14QyFRxjs93HkP3ms
   M+5r4MbXaGRIsC+4Kdsq6vC8qG/+zHEEZSHjFSWfD1ttTpT/fyu9wHEVB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356504886"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356504886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674405837"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674405837"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 11:42:24 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AED2434F04;
	Wed, 19 Jul 2023 19:42:22 +0100 (IST)
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
Subject: [PATCH bpf-next v3 21/21] selftests/bpf: check checksum state in xdp_metadata
Date: Wed, 19 Jul 2023 20:37:34 +0200
Message-ID: <20230719183734.21681-22-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183734.21681-1-larysa.zaremba@intel.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Verify, whether kfunc in xdp_metadata test correctly returns partial
checksum status and offsets.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 30 +++++++++++++++++++
 .../selftests/bpf/progs/xdp_metadata.c        |  6 ++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 6665cf0c59cc..c0ce66703696 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -47,6 +47,7 @@
 
 #define XDP_RSS_TYPE_L4 BIT(3)
 #define VLAN_VID_MASK 0xfff
+#define XDP_CHECKSUM_PARTIAL BIT(3)
 
 struct xsk {
 	void *umem_area;
@@ -168,6 +169,32 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 	}
 }
 
+struct partial_csum_info {
+	__u16 csum_start;
+	__u16 csum_offset;
+};
+
+static bool assert_checksum_ok(struct xdp_meta *meta)
+{
+	struct partial_csum_info *info;
+	u32 csum_start, csum_offset;
+
+	if (!ASSERT_EQ(meta->rx_csum_status, XDP_CHECKSUM_PARTIAL,
+		       "rx_csum_status"))
+		return false;
+
+	csum_start = sizeof(struct ethhdr) + sizeof(struct iphdr);
+	csum_offset = offsetof(struct udphdr, check);
+	info = (void *)&meta->rx_csum_info;
+
+	if (!ASSERT_EQ(info->csum_start, csum_start, "rx csum_start"))
+		return false;
+	if (!ASSERT_EQ(info->csum_offset, csum_offset, "rx csum_offset"))
+		return false;
+
+	return true;
+}
+
 static int verify_xsk_metadata(struct xsk *xsk)
 {
 	const struct xdp_desc *rx_desc;
@@ -229,6 +256,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
 		return -1;
 
+	if (!assert_checksum_ok(meta))
+		return -1;
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index d3111649170e..e79667a0726e 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -26,6 +26,9 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 					__u16 *vlan_tci,
 					__be16 *vlan_proto) __ksym;
+extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+				    enum xdp_csum_status *csum_status,
+				    union xdp_csum_info *csum_info) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -62,6 +65,9 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_vlan_proto);
 
+	bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
+				 (void *)&meta->rx_csum_info);
+
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
-- 
2.41.0


