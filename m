Return-Path: <bpf+bounces-8519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD347878EB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372EA2816B2
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD41ED34;
	Thu, 24 Aug 2023 19:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEB1ED2B;
	Thu, 24 Aug 2023 19:34:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA161BE9;
	Thu, 24 Aug 2023 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905679; x=1724441679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bhCltMc6p9RLjAFsmeSC85cRm/N9MGOGrgAJApfZ+jw=;
  b=fjfW5p3jS/b2806GMOoysPqhO2xKP8C6sMSWZErd+vLbEm8B/ZmNJjdy
   nyU8H98WXZ+B1O8u9X6JiqjQOTYprv+8QqGSbhOtr+bQDCyivfe3BrRgT
   kjML7xcaWiULZynE62KOfSNHBCA34e2T+Kp+N1BBFwboBTxBKPNr+KKwa
   HHX7kziKpIVq9oeLmvI/jatlk5ChmY4yJymcUWrIxeG6hECtaVqTW0uCG
   HsEXT/aYegMPV6UK31ocfIf1onYvFhXtHa6GCnuZHaPwMtPLSOQwunhRX
   OZ9qfTimogVR4tnyQGYhSq3SqBgbSBPBZMLTNbfzReSAjw42T+Q0JVfCr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865501"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865501"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830587"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830587"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:33 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D3C4234914;
	Thu, 24 Aug 2023 20:34:31 +0100 (IST)
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
Subject: [RFC bpf-next 21/23] selftests/bpf: check checksum state in xdp_metadata
Date: Thu, 24 Aug 2023 21:27:00 +0200
Message-ID: <20230824192703.712881-22-larysa.zaremba@intel.com>
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

Verify, whether kfunc in xdp_metadata test correctly represent veth
metadata state.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c |  3 +++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 61e1b073a4b2..aeb2701efba5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -228,6 +228,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->rx_csum_status, XDP_CHECKSUM_MAGIC, "rx_csum_status"))
+		return -1;
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index f3db5cef4726..766477e0a31d 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -26,6 +26,9 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 					__u16 *vlan_tci,
 					__be16 *vlan_proto) __ksym;
+extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+				    enum xdp_csum_status *csum_status,
+				    __wsum *csum) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -63,6 +66,14 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
 				     &meta->rx_vlan_proto);
 
+	/* This is supposed to fail on veth, so tell userspace
+	 * everything is OK by passing a magic status.
+	 */
+	ret = bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
+				       &meta->rx_csum);
+	if (ret)
+		meta->rx_csum_status = XDP_CHECKSUM_MAGIC;
+
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
-- 
2.41.0


