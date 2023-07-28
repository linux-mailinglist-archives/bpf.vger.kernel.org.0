Return-Path: <bpf+bounces-6252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758877673FC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B0E1C209BA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560023BCF;
	Fri, 28 Jul 2023 17:44:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2B156EF;
	Fri, 28 Jul 2023 17:44:53 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0910CB;
	Fri, 28 Jul 2023 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566291; x=1722102291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBjngCIm/FgHzex8a0aMYEeMlUg/2+IirTvX5FqObz4=;
  b=Bt3vPz9aZ2LmZCLP+ZGBE56+mnBbJLExPDq0jWUzgChuklFGITrAUBK+
   mbc6TxZTj3wjgBFvEnyOCrtgyhXKEisCgYPNbfIuX7tKDxHlNFPsRB3ZA
   dK1o16R4oNe+fLKikHApIat7ZqNIdhysHPSeq2RHFTH+Cexvex3NrFATV
   jq90allEZJYhR9rtI4aLeIVNYEyhVp3siVG39hk2RI6cxo6LfQoEgfcf0
   9fxNuGrsyeiqx/YhucI/KRaJemCkKiLHfrCY+Q+B4dPg9VrlcQOM6YYWB
   MuDQ1TFXyVgvGFoDnm5M9YnDBKIdnk+iVBCM9caxDtuzGHRWwt67dw0u2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367531057"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367531057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757254525"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="757254525"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 10:44:45 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 930E737F68;
	Fri, 28 Jul 2023 18:44:43 +0100 (IST)
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
Subject: [PATCH bpf-next v4 20/21] selftests/bpf: Check VLAN tag and proto in xdp_metadata
Date: Fri, 28 Jul 2023 19:39:22 +0200
Message-ID: <20230728173923.1318596-21-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173923.1318596-1-larysa.zaremba@intel.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Verify, whether VLAN tag and proto are set correctly.

To simulate "stripped" VLAN tag on veth, send test packet from VLAN
interface.

Also, add TO_STR() macro for convenience.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 21 +++++++++++++++++--
 .../selftests/bpf/progs/xdp_metadata.c        |  5 +++++
 tools/testing/selftests/bpf/testing_helpers.h |  3 +++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 1877e5c6d6c7..61e1b073a4b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -38,7 +38,14 @@
 #define TX_MAC "00:00:00:00:00:01"
 #define RX_MAC "00:00:00:00:00:02"
 
+#define VLAN_ID 59
+#define VLAN_PROTO "802.1Q"
+#define VLAN_PID htons(ETH_P_8021Q)
+#define TX_NAME_VLAN TX_NAME "." TO_STR(VLAN_ID)
+#define RX_NAME_VLAN RX_NAME "." TO_STR(VLAN_ID)
+
 #define XDP_RSS_TYPE_L4 BIT(3)
+#define VLAN_VID_MASK 0xfff
 
 struct xsk {
 	void *umem_area;
@@ -215,6 +222,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
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
 
@@ -248,10 +261,14 @@ void test_xdp_metadata(void)
 
 	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
 	SYS(out, "ip link set dev " TX_NAME " up");
-	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
+
+	SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
+		 " type vlan proto " VLAN_PROTO " id " TO_STR(VLAN_ID));
+	SYS(out, "ip link set dev " TX_NAME_VLAN " up");
+	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
 
 	/* Avoid ARP calls */
-	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
+	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
 	close_netns(tok);
 
 	tok = open_netns(RX_NETNS_NAME);
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index d151d406a123..f3db5cef4726 100644
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
@@ -57,6 +60,8 @@ int rx(struct xdp_md *ctx)
 		meta->rx_timestamp = 1;
 
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
+	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
+				     &meta->rx_vlan_proto);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 5312323881b6..7e0f8543a3a4 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -8,6 +8,9 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#define __TO_STR(x) #x
+#define TO_STR(x) __TO_STR(x)
+
 int parse_num_list(const char *s, bool **set, int *set_len);
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info);
 int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
-- 
2.41.0


