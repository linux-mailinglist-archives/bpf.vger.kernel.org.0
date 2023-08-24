Return-Path: <bpf+bounces-8514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E87878D4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B5F1C20D24
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6551E520;
	Thu, 24 Aug 2023 19:34:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADCD1E506;
	Thu, 24 Aug 2023 19:34:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31681B0;
	Thu, 24 Aug 2023 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905668; x=1724441668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WWdujLYIzDptOnZE5vK/7fI8yEEWny/0E84PD8XP9HQ=;
  b=OwFieWOuAcUL/c7K8FSrGAOzv5iNfzHrORQDZzNPbXFr1CkkIK0l2Xwb
   PqtMzt5cBcgycGXTw+B+3ail2MMf6hWkWIa//rV58vbzje0vLlTYmo3b3
   1e8z4vo/T1rECa6Ib2k67fXimRHBrKkQR+b19FxYzhiO0oSgyOmj8a2lh
   iJ4Ossc0W5WJADwTXBkccDwF2TlYHRIqv8Or/x3MN3Hs9hsHoZq2vsOe/
   To8pkcV73ot2yhnP/cbYvRwxpOeJIP3bPLdx015Wp6iabv62cocYfvBAQ
   mseRzTGGLAsDwG75ugzD5hx+9o75a4hb/G8M80o/P3mnR2yI8aLDD2qGp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865409"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865409"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830557"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830557"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:22 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 22FB933E93;
	Thu, 24 Aug 2023 20:34:20 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [RFC bpf-next 16/23] selftests/bpf: Add flags and new hints to xdp_hw_metadata
Date: Thu, 24 Aug 2023 21:26:55 +0200
Message-ID: <20230824192703.712881-17-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add hints added in the previous patches (VLAN tag and checksum)
to the xdp_hw_metadata program.

Also, to make metadata layout more straightforward, add flags field
to pass information about validity of every separate hint separately.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 38 +++++++++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 67 +++++++++++++++++--
 tools/testing/selftests/bpf/xdp_metadata.h    | 34 +++++++++-
 3 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 63d7de6c6bbb..95b17eaf8f05 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -20,6 +20,12 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
+					__u16 *vlan_tci,
+					__be16 *vlan_proto) __ksym;
+extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+				    enum xdp_csum_status *csum_status,
+				    __wsum *csum) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -84,15 +90,35 @@ int rx(struct xdp_md *ctx)
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
+	err = bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
+					   &meta->rx_vlan_proto);
+	if (err)
+		meta->rx_vlan_tag_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
+
+	err = bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
+				       &meta->rx_csum);
+	if (err)
+		meta->rx_csum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CSUM;
 
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..7535baa7e7ef 100644
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
@@ -150,21 +153,58 @@ static __u64 gettime(clockid_t clock_id)
 	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
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
+#define XDP_CHECKSUM_VERIFIED		BIT(0)
+#define XDP_CHECKSUM_COMPLETE		BIT(1)
+
+struct partial_csum_info {
+	__u16 csum_start;
+	__u16 csum_offset;
+};
+
+static void print_csum_state(__u32 status, __u32 info)
+{
+	bool is_verified = status & XDP_CHECKSUM_VERIFIED;
+
+	printf("Checksum status: ");
+	if (status & ~(XDP_CHECKSUM_COMPLETE | XDP_CHECKSUM_VERIFIED))
+		printf("cannot be interpreted, status=0x%X\n", status);
+
+	if (status & XDP_CHECKSUM_COMPLETE)
+		printf("complete, checksum=0x%X%s", info,
+		       is_verified ? ", " : "\n");
+
+	if (is_verified)
+		printf("outermost checksum is verified\n");
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
@@ -179,8 +219,23 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
 		       (double)delta_X2U / NANOSEC_PER_SEC,
 		       (double)delta_X2U / 1000);
+	} else {
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
 
+	if (meta->hint_valid & XDP_META_FIELD_CSUM)
+		print_csum_state(meta->rx_csum_status, meta->rx_csum);
+	else
+		printf("Checksum was not checked, err=%d\n", meta->rx_csum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 6664893c2c77..0b749bfed2de 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -17,12 +17,44 @@
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
+	XDP_META_FIELD_CSUM	= BIT(3),
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
+			__u16 rx_vlan_tci;
+			__be16 rx_vlan_proto;
+		};
+		__s32 rx_vlan_tag_err;
+	};
+	union {
+		struct {
+			__u32 rx_csum_status;
+			__wsum rx_csum;
+		};
+		__s32 rx_csum_err;
+	};
+	enum xdp_meta_field hint_valid;
 };
-- 
2.41.0


