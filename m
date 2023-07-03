Return-Path: <bpf+bounces-3909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D32374624D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA291C209F1
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2918007;
	Mon,  3 Jul 2023 18:17:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1017FEB;
	Mon,  3 Jul 2023 18:17:37 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ECE10C2;
	Mon,  3 Jul 2023 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408252; x=1719944252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bmM4j59hI6XMaQ5uFEnyIsFi8Ea8WeAFE4olclpHNls=;
  b=VKCAuGE3hEYUiSvOa5KaC+VD8E3e6IM91YI9NDuGgGSunJy096azUCrZ
   Kvr4VxWPxznGQnymDz2Ht0HHt9gcR3uJ5wu42H4uysRc6w/Kgy8GWr5vC
   Od4Nofz/wfWSxMjdJ5pD5ERn+EVuKes+q/GLpNjWYmNAFtjh03BqM6zOf
   6/uo+cN8iCFCdVimq9SPxnlGaBKD0DaBU3aHIw1Kunp8LC8UPime74M7E
   jM3EL+d70tKeixeQQyrSKT2K/5k3OKM1GHQZ4SXQchjeadRbGrLQ5+uDL
   LmyP23VL4OYqMnZQwLkULChWyzluS1kxV05u+xuVoy5/m/inBUWlA2C67
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393682722"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393682722"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892615160"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892615160"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 11:17:13 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5109435833;
	Mon,  3 Jul 2023 19:17:12 +0100 (IST)
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
Subject: [PATCH bpf-next v2 16/20] selftests/bpf: Add flags and new hints to xdp_hw_metadata
Date: Mon,  3 Jul 2023 20:12:22 +0200
Message-ID: <20230703181226.19380-17-larysa.zaremba@intel.com>
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

Add hints added in the previous patches (VLAN tags and checksum level)
to the xdp_hw_metadata program.

Also, to make metadata layout more straightforward, add flags field
to pass information about validity of every separate hint separately.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 35 +++++++++++++---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 42 ++++++++++++++++---
 tools/testing/selftests/bpf/xdp_metadata.h    | 28 ++++++++++++-
 3 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 63d7de6c6bbb..f46f75db21b4 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -20,6 +20,11 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
+					__u16 *vlan_tag,
+					__be16 *vlan_proto) __ksym;
+extern int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx,
+					__u8 *csum_level) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -84,15 +89,35 @@ int rx(struct xdp_md *ctx)
 		return XDP_PASS;
 	}
 
+	meta->hint_valid = 0;
+
 	err = bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
-	if (!err)
+	if (err) {
+		meta->rx_timestamp_err = err;
+	} else {
+		meta->hint_valid |= XDP_META_FIELD_TS;
 		meta->xdp_timestamp = bpf_ktime_get_tai_ns();
+	}
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
+	err = bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag,
+					   &meta->rx_vlan_proto);
+	if (err)
+		meta->rx_vlan_tag_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
+
+	err = bpf_xdp_metadata_rx_csum_lvl(ctx, &meta->rx_csum_lvl);
+	if (err)
+		meta->rx_csum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CSUM_LVL;
 
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..d234cbcc9103 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -19,6 +19,9 @@
 #include "xsk.h"
 
 #include <error.h>
+#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/errqueue.h>
 #include <linux/if_link.h>
 #include <linux/net_tstamp.h>
@@ -150,21 +153,34 @@ static __u64 gettime(clockid_t clock_id)
 	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
 }
 
+#define VLAN_PRIO_MASK		GENMASK(15, 13) /* Priority Code Point */
+#define VLAN_CFI_MASK		GENMASK(12, 12) /* Canonical Format / Drop Eligible Indicator */
+#define VLAN_VID_MASK		GENMASK(11, 0)	/* VLAN Identifier */
+static void print_vlan_tag(__u16 tag)
+{
+	__u16 vlan_id = FIELD_GET(VLAN_VID_MASK, tag);
+	__u8 pcp = FIELD_GET(VLAN_PRIO_MASK, tag);
+	bool cfi = FIELD_GET(VLAN_CFI_MASK, tag);
+
+	printf("PCP=%u, CFI=%d, VID=0x%X\n", pcp, cfi, vlan_id);
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
+
+	if (meta->hint_valid & XDP_META_FIELD_TS) {
+		printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
+		       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
 
-	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
-	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
-	if (meta->rx_timestamp) {
 		__u64 usr_clock = gettime(clock_id);
 		__u64 xdp_clock = meta->xdp_timestamp;
 		__s64 delta_X = xdp_clock - meta->rx_timestamp;
@@ -179,8 +195,22 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
 		       (double)delta_X2U / NANOSEC_PER_SEC,
 		       (double)delta_X2U / 1000);
+	} else {
+		printf("No rx_timestamp, err=%d\n", meta->rx_timestamp_err);
 	}
 
+	if (meta->hint_valid & XDP_META_FIELD_VLAN_TAG) {
+		printf("rx_vlan_proto: 0x%X\n", ntohs(meta->rx_vlan_proto));
+		printf("rx_vlan_tag: ");
+		print_vlan_tag(meta->rx_vlan_tag);
+	} else {
+		printf("No rx_vlan_tag or rx_vlan_proto, err=%d\n", meta->rx_vlan_tag_err);
+	}
+
+	if (meta->hint_valid & XDP_META_FIELD_CSUM_LVL)
+		printf("Checksum was checked at level %u\n", meta->rx_csum_lvl);
+	else
+		printf("Checksum was not checked, err=%d\n", meta->rx_csum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 6664893c2c77..ff1372244d34 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -17,12 +17,38 @@
 #define ETH_P_8021AD 0x88A8
 #endif
 
+#ifndef BIT
+#define BIT(nr)			(1 << (nr))
+#endif
+
+enum xdp_meta_field {
+	XDP_META_FIELD_TS	= BIT(0),
+	XDP_META_FIELD_RSS	= BIT(1),
+	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+	XDP_META_FIELD_CSUM_LVL	= BIT(3),
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
+			__u16 rx_vlan_tag;
+			__be16 rx_vlan_proto;
+		};
+		__s32 rx_vlan_tag_err;
+	};
+	union {
+		__u8 rx_csum_lvl;
+		__s32 rx_csum_err;
+	};
+	enum xdp_meta_field hint_valid;
 };
-- 
2.41.0


