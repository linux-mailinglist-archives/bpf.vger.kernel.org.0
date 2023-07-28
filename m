Return-Path: <bpf+bounces-6254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59B767402
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE63E280D8C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11025155;
	Fri, 28 Jul 2023 17:44:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E312514D;
	Fri, 28 Jul 2023 17:44:55 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554619B;
	Fri, 28 Jul 2023 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566294; x=1722102294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bmoV5KED9X/fLK4ezU94EbHC65Ikdbt1JVgLru97zJk=;
  b=Y2uD2BbwUvHkzkCAmgNby/emb4mXMkRa/V7UnQL64EynLhSSx+JK3NV+
   Th9qO2E+3ZRrkh8XaHUz811GgAiS+1CdTZqFvwc5gE1uvD3OtjxThpOly
   Il5Z2Y+QHBHrH7xZsvfUtnWicg6M+7J457Sd9w1vsUx99W22fCFBT/Yo2
   4VeEigs7RVrs1lNqmYwC3pwNfM9DlGCnHrpuB+iT/XcjsBCumtaW0c1JS
   5deFHmeJM23UOOmcjN32sG3U4NLnBRKnuYbBeYIzo/GXqUw6sSGos6LGV
   sgJlV81uOd6T8l6iLwXgGMUjqEOEzRws1s//y9SddyUiWxVx8/b0AwC8a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367531089"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367531089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757254533"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="757254533"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 10:44:47 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9C00137F71;
	Fri, 28 Jul 2023 18:44:45 +0100 (IST)
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
Subject: [PATCH bpf-next v4 21/21] selftests/bpf: check checksum state in xdp_metadata
Date: Fri, 28 Jul 2023 19:39:23 +0200
Message-ID: <20230728173923.1318596-22-larysa.zaremba@intel.com>
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

Verify, whether kfunc in xdp_metadata test correctly returns partial
checksum status and offsets.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 30 +++++++++++++++++++
 .../selftests/bpf/progs/xdp_metadata.c        |  6 ++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 61e1b073a4b2..6c3dd90b271b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -46,6 +46,7 @@
 
 #define XDP_RSS_TYPE_L4 BIT(3)
 #define VLAN_VID_MASK 0xfff
+#define XDP_CHECKSUM_PARTIAL BIT(3)
 
 struct xsk {
 	void *umem_area;
@@ -167,6 +168,32 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
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
@@ -228,6 +255,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
 		return -1;
 
+	if (!assert_checksum_ok(meta))
+		return -1;
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index f3db5cef4726..c99f7f4eb37d 100644
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
@@ -63,6 +66,9 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
 				     &meta->rx_vlan_proto);
 
+	bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
+				 (void *)&meta->rx_csum_info);
+
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
-- 
2.41.0


