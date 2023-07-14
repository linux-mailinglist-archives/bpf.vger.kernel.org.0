Return-Path: <bpf+bounces-5015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C9753A13
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 13:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A941C21691
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739E3D3B8;
	Fri, 14 Jul 2023 11:37:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3B3D382;
	Fri, 14 Jul 2023 11:37:54 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F6E65;
	Fri, 14 Jul 2023 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334673; x=1720870673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICWBmVvc69wBrAD339XSMRJ9aF5suZUGaMb+/3QhEQM=;
  b=l9nwWfphJHNGs/bamejcyPA0CYT11rqgrFyFvN5Vez50fZ+IXdtDVA1+
   +z/XnNg5INobomO2Ls1jeGNxq+kVNyI4QqGlFoSEkwXbVCbki5RpZl4TJ
   PS3XJJFEUkKhm8bVs0tZUuv/01klFPSXBMeFWoY/bE5jTNdZcycrZwiV8
   k2mJ6wyq0frxeGP3fw/AewqtIwyLR5fQM31FhnONClXeIGsojetXr4pc5
   o2s0BA3DgQn7r5HiOyM+EEd0OFElI/IILqL5+PdCrhUXSOg1dOj+EMSOf
   NmtSOaSN314IL8A7xA7v0o3uAim7iKdWDODF6U7StVUOmGgHGE5DrZyVS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345048342"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345048342"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846425294"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="846425294"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 04:37:50 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org
Subject: [PATCH v6 bpf-next 22/24] selftests/xsk: add metadata copy test for multi-buff
Date: Fri, 14 Jul 2023 13:36:38 +0200
Message-Id: <20230714113640.556893-23-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
References: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Enable the already existing metadata copy test to also run in
multi-buffer mode with 9K packets.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c | 2 +-
 tools/testing/selftests/bpf/xskxceiver.c          | 7 ++++++-
 tools/testing/selftests/bpf/xskxceiver.h          | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index ac76e7363776..24369f242853 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -29,7 +29,7 @@ SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
-SEC("xdp") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
+SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 {
 	void *data, *data_meta;
 	struct xdp_info *meta;
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 59210cb33beb..4767d09d6893 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1949,7 +1949,6 @@ static int testapp_xdp_metadata_count(struct test_spec *test)
 	int count = 0;
 	int key = 0;
 
-	test_spec_set_name(test, "XDP_METADATA_COUNT");
 	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_populate_metadata,
 			       skel_tx->progs.xsk_xdp_populate_metadata,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
@@ -2163,6 +2162,12 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		ret = testapp_xdp_drop(test);
 		break;
 	case TEST_TYPE_XDP_METADATA_COUNT:
+		test_spec_set_name(test, "XDP_METADATA_COUNT");
+		ret = testapp_xdp_metadata_count(test);
+		break;
+	case TEST_TYPE_XDP_METADATA_COUNT_MB:
+		test_spec_set_name(test, "XDP_METADATA_COUNT_MULTI_BUFF");
+		test->mtu = MAX_ETH_JUMBO_SIZE;
 		ret = testapp_xdp_metadata_count(test);
 		break;
 	default:
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 7140943410de..9e1f66e0a3b6 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -88,6 +88,7 @@ enum test_type {
 	TEST_TYPE_BPF_RES,
 	TEST_TYPE_XDP_DROP_HALF,
 	TEST_TYPE_XDP_METADATA_COUNT,
+	TEST_TYPE_XDP_METADATA_COUNT_MB,
 	TEST_TYPE_RUN_TO_COMPLETION_MB,
 	TEST_TYPE_UNALIGNED_MB,
 	TEST_TYPE_ALIGNED_INV_DESC_MB,
-- 
2.34.1


