Return-Path: <bpf+bounces-15119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5A7ECA18
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C61B20974
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640433DB92;
	Wed, 15 Nov 2023 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULIX03YG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586291B8;
	Wed, 15 Nov 2023 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070918; x=1731606918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DWUvSPk8dYIik6pabuSpB3yucrVqkgv1hHSOpBoNELg=;
  b=ULIX03YGIHg4Kq4BchbCAymhvTLSx78f6uWZtBFNuWmn+GQ3ps/CWwAT
   HWVz8TGCqYPC3FONcJdkxCSf7ItGXaPSyM+B3Jl7T2rRcw5LRbTXD9jS+
   vYHg1q4+VclpRtF7MYdC3U4yvEkoNFVLDNLOU7oqAaClu7HgS9k9vRYVL
   Dtvmpp/ZC2Zp2qm1HLUyp56OwpnMj/gPJCuZ1PKHymX1Vupas2eE+JynR
   700hiBCs5WcE2sQSgEZiq1s5+hBz3Mtp1n+tdKNF5wm4keuWh6aq7+dqI
   AMSfGfXSwqcXinCpuwuTNb0zFrd3jU6jM4BkSRKFmA7hlaODxjVOppgVT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375965679"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375965679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855720236"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="855720236"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2023 09:55:11 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B1A4837841;
	Wed, 15 Nov 2023 17:55:09 +0000 (GMT)
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
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v7 18/18] selftests/bpf: Check VLAN tag and proto in xdp_metadata
Date: Wed, 15 Nov 2023 18:53:00 +0100
Message-ID: <20231115175301.534113-19-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115175301.534113-1-larysa.zaremba@intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify, whether VLAN tag and proto are set correctly.

To simulate "stripped" VLAN tag on veth, send test packet from VLAN
interface.

Also, add TO_STR() macro for convenience.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 21 +++++++++++++++++--
 .../selftests/bpf/progs/xdp_metadata.c        |  5 +++++
 tools/testing/selftests/bpf/testing_helpers.h |  3 +++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 4fcdda02c75e..21b8e0e95019 100644
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
index d151d406a123..2c6c46ef8502 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
+					__be16 *vlan_proto,
+					__u16 *vlan_tci) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -57,6 +60,8 @@ int rx(struct xdp_md *ctx)
 		meta->rx_timestamp = 1;
 
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
+	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
+				     &meta->rx_vlan_tci);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 5b7a55136741..35284faff4f2 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -9,6 +9,9 @@
 #include <bpf/libbpf.h>
 #include <time.h>
 
+#define __TO_STR(x) #x
+#define TO_STR(x) __TO_STR(x)
+
 int parse_num_list(const char *s, bool **set, int *set_len);
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info);
 int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
-- 
2.41.0


