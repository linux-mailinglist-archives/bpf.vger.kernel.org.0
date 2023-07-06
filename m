Return-Path: <bpf+bounces-4327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE574A564
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31136281251
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F141801F;
	Thu,  6 Jul 2023 20:48:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540417FE7;
	Thu,  6 Jul 2023 20:48:25 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0E1992;
	Thu,  6 Jul 2023 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676502; x=1720212502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICWBmVvc69wBrAD339XSMRJ9aF5suZUGaMb+/3QhEQM=;
  b=ItEGcNlxSWYWy+m5p3fLke7w0QtFDJK2sQOVePoR/o7OJM9/Piy40V8E
   avNerqw4qmi2vIsUKAMdZ/oJTaphGz+y7VOxWrSDbzTUOSevLKCcSfFTL
   TxH6FdiYnt6iM8Pr4AfjmgqVfzMfOPM+W4ALHFH1NUhGRo7swWP5i4RoK
   Gk3boFNstIXbownTBo+IEpZqTE3OvfD3WE9a6R/rc45JHPdUArOBeBGJO
   V5H9sw9e5oLSOS7kLdj7wd0XgIsYgLhRPwjx58lJNjBWMahKiZdEKQbAV
   9qb8jjsPO+l4iGpXOJZNnK9oXlwTB+R6PQ5z8o7P2GU+Ia9L0AfJ7MUCz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195640"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059864"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059864"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:48:20 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 22/24] selftests/xsk: add metadata copy test for multi-buff
Date: Thu,  6 Jul 2023 22:46:48 +0200
Message-Id: <20230706204650.469087-23-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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


