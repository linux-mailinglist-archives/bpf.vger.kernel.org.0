Return-Path: <bpf+bounces-16806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E37806068
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE503281C30
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E476EB44;
	Tue,  5 Dec 2023 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9AF1b/9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BC418B;
	Tue,  5 Dec 2023 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810698; x=1733346698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jzH3bj9QgSXh85bw5eoc4UHZ7Qw6bymnQFHtlbxsrI=;
  b=Y9AF1b/90KyF3T1lrnxrjWSFpc7ghBmvvK7UNRq5HwPJDai/APY2Y1q9
   zI2dE7gXmVztWsX3h58KlYYqO+Jg09tCKHKqTRUHYDcQhNpuorK4Q8vnn
   RbC4RAXIGCaElXBoJvcS/o6vQR7yP7otaKJ/VFsm31WJxFGMtdtaXSwUs
   8kuPD4PC8i/TwMdE+uO4vEfQqrRoYACy0B1qn/pmQ75Sl5mE5rjtE7//f
   L3kIfuy2RzMooyEK1A5pfg0T/WCzeIhnDivdBWkIsj8hblKAU64sMFyKd
   1LhuwDVBfCNb/VDtT8hobY/x2r+6TFsSb6GaiBKyGLrKkWMYdhK/pV4+o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392827560"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392827560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764464731"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="764464731"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 13:11:32 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4507C34338;
	Tue,  5 Dec 2023 21:11:29 +0000 (GMT)
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
Subject: [PATCH bpf-next v8 16/18] selftests/bpf: Add flags and VLAN hint to xdp_hw_metadata
Date: Tue,  5 Dec 2023 22:08:45 +0100
Message-ID: <20231205210847.28460-17-larysa.zaremba@intel.com>
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

Add VLAN hint to the xdp_hw_metadata program.

Also, to make metadata layout more straightforward, add flags field
to pass information about validity of every separate hint separately.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 28 +++++++++++----
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 34 ++++++++++++++++---
 tools/testing/selftests/bpf/xdp_metadata.h    | 26 +++++++++++++-
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 8767d919c881..330ece2eabdb 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -20,6 +20,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
+					__be16 *vlan_proto,
+					__u16 *vlan_tci) __ksym;
 
 SEC("xdp.frags")
 int rx(struct xdp_md *ctx)
@@ -84,15 +87,28 @@ int rx(struct xdp_md *ctx)
 		return XDP_PASS;
 	}
 
+	meta->hint_valid = 0;
+
+	meta->xdp_timestamp = bpf_ktime_get_tai_ns();
 	err = bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
-	if (!err)
-		meta->xdp_timestamp = bpf_ktime_get_tai_ns();
+	if (err)
+		meta->rx_timestamp_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_TS;
+
+	err = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash,
+				       &meta->rx_hash_type);
+	if (err)
+		meta->rx_hash_err = err;
 	else
-		meta->rx_timestamp = 0; /* Used by AF_XDP as not avail signal */
+		meta->hint_valid |= XDP_META_FIELD_RSS;
 
-	err = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
-	if (err < 0)
-		meta->rx_hash_err = err; /* Used by AF_XDP as no hash signal */
+	err = bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
+					   &meta->rx_vlan_tci);
+	if (err)
+		meta->rx_vlan_tag_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
 
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3291625ba4fb..e3ad74eca8ec 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -21,6 +21,9 @@
 #include "xsk.h"
 
 #include <error.h>
+#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/errqueue.h>
 #include <linux/if_link.h>
 #include <linux/net_tstamp.h>
@@ -182,19 +185,31 @@ static void print_tstamp_delta(const char *name, const char *refname,
 	       (double)delta / 1000);
 }
 
+#define VLAN_PRIO_MASK		GENMASK(15, 13) /* Priority Code Point */
+#define VLAN_DEI_MASK		GENMASK(12, 12) /* Drop Eligible Indicator */
+#define VLAN_VID_MASK		GENMASK(11, 0)	/* VLAN Identifier */
+static void print_vlan_tci(__u16 tag)
+{
+	__u16 vlan_id = FIELD_GET(VLAN_VID_MASK, tag);
+	__u8 pcp = FIELD_GET(VLAN_PRIO_MASK, tag);
+	bool dei = FIELD_GET(VLAN_DEI_MASK, tag);
+
+	printf("PCP=%u, DEI=%d, VID=0x%X\n", pcp, dei, vlan_id);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
 
 	meta = data - sizeof(*meta);
 
-	if (meta->rx_hash_err < 0)
-		printf("No rx_hash err=%d\n", meta->rx_hash_err);
-	else
+	if (meta->hint_valid & XDP_META_FIELD_RSS)
 		printf("rx_hash: 0x%X with RSS type:0x%X\n",
 		       meta->rx_hash, meta->rx_hash_type);
+	else
+		printf("No rx_hash, err=%d\n", meta->rx_hash_err);
 
-	if (meta->rx_timestamp) {
+	if (meta->hint_valid & XDP_META_FIELD_TS) {
 		__u64 ref_tstamp = gettime(clock_id);
 
 		/* store received timestamps to calculate a delta at tx */
@@ -206,7 +221,16 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		print_tstamp_delta("XDP RX-time", "User RX-time",
 				   meta->xdp_timestamp, ref_tstamp);
 	} else {
-		printf("No rx_timestamp\n");
+		printf("No rx_timestamp, err=%d\n", meta->rx_timestamp_err);
+	}
+
+	if (meta->hint_valid & XDP_META_FIELD_VLAN_TAG) {
+		printf("rx_vlan_proto: 0x%X\n", ntohs(meta->rx_vlan_proto));
+		printf("rx_vlan_tci: ");
+		print_vlan_tci(meta->rx_vlan_tci);
+	} else {
+		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
+		       meta->rx_vlan_tag_err);
 	}
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 6664893c2c77..87318ad1117a 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -17,12 +17,36 @@
 #define ETH_P_8021AD 0x88A8
 #endif
 
+#ifndef BIT
+#define BIT(nr)			(1 << (nr))
+#endif
+
+/* Non-existent checksum status */
+#define XDP_CHECKSUM_MAGIC	BIT(2)
+
+enum xdp_meta_field {
+	XDP_META_FIELD_TS	= BIT(0),
+	XDP_META_FIELD_RSS	= BIT(1),
+	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+};
+
 struct xdp_meta {
-	__u64 rx_timestamp;
+	union {
+		__u64 rx_timestamp;
+		__s32 rx_timestamp_err;
+	};
 	__u64 xdp_timestamp;
 	__u32 rx_hash;
 	union {
 		__u32 rx_hash_type;
 		__s32 rx_hash_err;
 	};
+	union {
+		struct {
+			__be16 rx_vlan_proto;
+			__u16 rx_vlan_tci;
+		};
+		__s32 rx_vlan_tag_err;
+	};
+	enum xdp_meta_field hint_valid;
 };
-- 
2.41.0


