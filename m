Return-Path: <bpf+bounces-16808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553780606F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307D6282076
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC96E585;
	Tue,  5 Dec 2023 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5JRDYaE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF73818F;
	Tue,  5 Dec 2023 13:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810704; x=1733346704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kPavmjuINRjBV2TzGkXgCw1OWnVnrP33kqFdft92jD8=;
  b=K5JRDYaEWdfW7kRWD2LvBQVNg1OgHPh23HLQFCpWVa/27lIL8sjud6Hh
   VTANaLAqLx5zt/3cG4NxD35s1c37atYylZim1uzAeKHlHi8EWom7HhpAK
   WCw425PD5HiwoAMcmoTdvB08giiNCFHBRHx0Ip1xUuCcNT+CVXIKkMiRO
   42dyzCaG3jtf4FfRffHFIjh73TUM+6ZWyCM5+U76JQ8//FCiuKDgVUee9
   JiS/oqju5HgsJ9CIJZ+GNpLU325UoAMz1S2ojG7Y/tG084z0NPdWX60Q0
   CwN8SmWsiQgOA0d4QaVPZ11TLF1GQc87Z9PdJfLxlRmIHv6gi6BSUqPoC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392827585"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392827585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764464740"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="764464740"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 13:11:38 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2A16534328;
	Tue,  5 Dec 2023 21:11:36 +0000 (GMT)
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
Subject: [PATCH bpf-next v8 18/18] selftests/bpf: Check VLAN tag and proto in xdp_metadata
Date: Tue,  5 Dec 2023 22:08:47 +0100
Message-ID: <20231205210847.28460-19-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
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
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 20 +++++++++++++++++--
 .../selftests/bpf/progs/xdp_metadata.c        |  5 +++++
 tools/testing/selftests/bpf/testing_helpers.h |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index e7f06cbdd845..05edcf32f528 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -38,7 +38,13 @@
 #define TX_MAC "00:00:00:00:00:01"
 #define RX_MAC "00:00:00:00:00:02"
 
+#define VLAN_ID 59
+#define VLAN_PROTO "802.1Q"
+#define VLAN_PID htons(ETH_P_8021Q)
+#define TX_NAME_VLAN TX_NAME "." TO_STR(VLAN_ID)
+
 #define XDP_RSS_TYPE_L4 BIT(3)
+#define VLAN_VID_MASK 0xfff
 
 struct xsk {
 	void *umem_area;
@@ -323,6 +329,12 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
+
+		if (!ASSERT_EQ(meta->rx_vlan_tci & VLAN_VID_MASK, VLAN_ID, "rx_vlan_tci"))
+			return -1;
+
+		if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
+			return -1;
 		goto done;
 	}
 
@@ -378,10 +390,14 @@ void test_xdp_metadata(void)
 
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
 
 	switch_ns_to_rx(&tok);
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 5d6c1245c310..31ca229bb3c0 100644
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
@@ -86,6 +89,8 @@ int rx(struct xdp_md *ctx)
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


