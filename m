Return-Path: <bpf+bounces-5370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588A4759DDA
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA031C21154
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242E26B18;
	Wed, 19 Jul 2023 18:42:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D526B03;
	Wed, 19 Jul 2023 18:42:25 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC4C7;
	Wed, 19 Jul 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792140; x=1721328140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4m3X7mzZbMgkHDn5r2M20L0OqIsoKxjQkl+BBpAq8g=;
  b=dfSXs+IAYQ4Pq+PS3GqB1iD4u650jHW78GtJuthmZ43UzkevtWv9nBUT
   89HzbzJ3IVbvr+5XWOgUGxwQJCYuDgwCC0D5FLvGWT8+YguDgYKNQadU5
   N/t3RPOpERgW336UJib8ephbmhCHJMKFZr6EDLhXz3vE2f4MXYlQcepYA
   2EyBkjEslZ2s0brUGfSLiZrPRXKFzuHoxNNPh/zKH3C8wJ2XBng+MU3gB
   99zFriTEFBY0LM60ikMpd1oYXTpGrsGiK6q1hSnqwkbuexw4/IMzZzHTu
   11i0lOtYqzhA5zmRNtqeE/5anZqcuVhA3389xSWwj2YDSI15/8+JvBO+q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370111316"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370111316"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794146723"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794146723"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 11:42:14 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9738835834;
	Wed, 19 Jul 2023 19:42:12 +0100 (IST)
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
Subject: [PATCH bpf-next v3 16/21] selftests/bpf: Add flags and new hints to xdp_hw_metadata
Date: Wed, 19 Jul 2023 20:37:29 +0200
Message-ID: <20230719183734.21681-17-larysa.zaremba@intel.com>
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

Add hints added in the previous patches (VLAN tag and checksum)
to the xdp_hw_metadata program.

Also, to make metadata layout more straightforward, add flags field
to pass information about validity of every separate hint separately.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 37 +++++++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 79 +++++++++++++++++--
 tools/testing/selftests/bpf/xdp_metadata.h    | 31 +++++++-
 3 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 63d7de6c6bbb..75a61317668d 100644
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
+				    union xdp_csum_info *csum_info) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -84,15 +90,36 @@ int rx(struct xdp_md *ctx)
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
+	err = bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
+					   &meta->rx_vlan_proto);
+	if (err)
+		meta->rx_vlan_tag_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
+
+	err = bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
+				       (void *)&meta->rx_csum_info);
+	if (err)
+		meta->rx_csum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CSUM;
 
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..a045de7dc910 100644
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
@@ -150,21 +153,70 @@ static __u64 gettime(clockid_t clock_id)
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
+#define XDP_CHECKSUM_VALID_NUM_MASK	GENMASK(2, 0)
+#define XDP_CHECKSUM_PARTIAL		BIT(3)
+#define XDP_CHECKSUM_COMPLETE		BIT(4)
+
+struct partial_csum_info {
+	__u16 csum_start;
+	__u16 csum_offset;
+};
+
+static void print_csum_state(__u32 status, __u32 info)
+{
+	u8 csum_num = status & XDP_CHECKSUM_VALID_NUM_MASK;
+
+	printf("Checksum status: ");
+	if (status != XDP_CHECKSUM_PARTIAL &&
+	    status & ~(XDP_CHECKSUM_COMPLETE | XDP_CHECKSUM_VALID_NUM_MASK))
+		printf("cannot be interpreted, status=0x%X\n", status);
+
+	if (status == XDP_CHECKSUM_PARTIAL) {
+		struct partial_csum_info *partial_info = (void *)&info;
+
+		printf("partial, csum_start=%u, csum_offset=%u\n",
+		       partial_info->csum_start, partial_info->csum_offset);
+		return;
+	}
+
+	if (status & XDP_CHECKSUM_COMPLETE)
+		printf("complete, checksum=0x%X%s", info,
+		       csum_num ? ", " : "\n");
+
+	if (csum_num > 1)
+		printf("%u consecutive checksums are verified\n", csum_num);
+	else if (csum_num)
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
@@ -179,8 +231,23 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
 		       (double)delta_X2U / NANOSEC_PER_SEC,
 		       (double)delta_X2U / 1000);
+	} else {
+		printf("No rx_timestamp, err=%d\n", meta->rx_timestamp_err);
 	}
 
+	if (meta->hint_valid & XDP_META_FIELD_VLAN_TAG) {
+		printf("rx_vlan_proto: 0x%X\n", ntohs(meta->rx_vlan_proto));
+		printf("rx_vlan_tci: ");
+		print_vlan_tci(meta->rx_vlan_tci);
+	} else {
+		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
+		       meta->rx_vlan_tag_err);
+	}
+
+	if (meta->hint_valid & XDP_META_FIELD_CSUM)
+		print_csum_state(meta->rx_csum_status, meta->rx_csum_info);
+	else
+		printf("Checksum was not checked, err=%d\n", meta->rx_csum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 6664893c2c77..95e7b53d6bfb 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -17,12 +17,41 @@
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
+			__u32 rx_csum_info;
+		};
+		__s32 rx_csum_err;
+	};
+	enum xdp_meta_field hint_valid;
 };
-- 
2.41.0


