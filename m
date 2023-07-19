Return-Path: <bpf+bounces-5374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C9759DE8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720321C21173
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3626B71;
	Wed, 19 Jul 2023 18:42:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F726B6A;
	Wed, 19 Jul 2023 18:42:43 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D391FDD;
	Wed, 19 Jul 2023 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792148; x=1721328148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqS87x2rOA9msJ1UR+GS50iLEBTnRdV1uZjDodrFi+U=;
  b=IQV5kgPHxagU88//vUtuBuMw2qcrD3pmQg+PaKwaxroRH31kyl5YfnRR
   sxNzet1Wte774+bYmpAQKNGKeD2S4FnG+DZgDfLLG1fVUknJBtmGZ0CNE
   fmHxQ0H9It5T76ORmsUc8dbPGTJ9hbe+RQZPYTl5OUoQfAWkFtSVDuiOe
   9Z5Ei2QfyAnlBmF9O9sAcmymZ79VF/Z4/HVyRF2TJ//OfkB+t18P5nrnv
   3x8tYk86G22Cn0ZHiMviLQmigj5Y3Od6NJYISnm0GDOZB3euUsn3D2kxX
   kNs3Hs8IaFhBiKcbAd0d7QpEwoQhptCazBgHm8cMJ01hWHb0diiArOkNA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370111371"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370111371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794146756"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794146756"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 11:42:21 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8B13534EFD;
	Wed, 19 Jul 2023 19:42:20 +0100 (IST)
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
Subject: [PATCH bpf-next v3 20/21] selftests/bpf: Check VLAN tag and proto in xdp_metadata
Date: Wed, 19 Jul 2023 20:37:33 +0200
Message-ID: <20230719183734.21681-21-larysa.zaremba@intel.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Verify, whether VLAN tag and proto are set correctly.

To simulate "stripped" VLAN tag on veth, send test packet from VLAN
interface.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 22 +++++++++++++++++--
 .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 1877e5c6d6c7..6665cf0c59cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -38,7 +38,15 @@
 #define TX_MAC "00:00:00:00:00:01"
 #define RX_MAC "00:00:00:00:00:02"
 
+#define VLAN_ID 59
+#define VLAN_ID_STR "59"
+#define VLAN_PROTO "802.1Q"
+#define VLAN_PID htons(ETH_P_8021Q)
+#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
+#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
+
 #define XDP_RSS_TYPE_L4 BIT(3)
+#define VLAN_VID_MASK 0xfff
 
 struct xsk {
 	void *umem_area;
@@ -215,6 +223,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->rx_vlan_tci & VLAN_VID_MASK, VLAN_ID, "rx_vlan_tci"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
+		return -1;
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
@@ -248,10 +262,14 @@ void test_xdp_metadata(void)
 
 	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
 	SYS(out, "ip link set dev " TX_NAME " up");
-	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
+
+	SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
+		 " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
+	SYS(out, "ip link set dev " TX_NAME_VLAN " up");
+	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
 
 	/* Avoid ARP calls */
-	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
+	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
 	close_netns(tok);
 
 	tok = open_netns(RX_NETNS_NAME);
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index d151d406a123..d3111649170e 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
+					__u16 *vlan_tci,
+					__be16 *vlan_proto) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
 		meta->rx_timestamp = 1;
 
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
+	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_vlan_proto);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
-- 
2.41.0


