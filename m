Return-Path: <bpf+bounces-4325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3AE74A560
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4001C20E83
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3B18001;
	Thu,  6 Jul 2023 20:48:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8717FE7;
	Thu,  6 Jul 2023 20:48:18 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5AA1992;
	Thu,  6 Jul 2023 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676497; x=1720212497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dk4iFMiEs0gLFMsQ7PMv53QQTsgL7E1uAShStgtbHss=;
  b=g/Vc1uyVCzxl3cNux2Nvw58kTJvvtjySZDnfp6RpP2BQlE/sMYjxluRJ
   OC0pPfKcdO0kC4/3AKFalCUtoUAO/aaz/HE6B5v7thI/1Y2eUXaYSPb+D
   PwpSp6jQ5wygvNL3GTKCaayKQj3A3YZMeeMC1xh0kISyjntuML1aFerBk
   3GR+HJ9b0Vq3DbSpNl5DewdnTddyMRvF3I1aqBQuBa0w6duDYSaTAcqKx
   pAe0J1FTdgTyV9XtQmbTPm3qcR55Wu0H99eM7Q2D/6rv84LJbSphen/Jq
   IIM/Tv2+st0F+JdbpO3TKMZopzLuWs8M2tvu6kO2tmJsNAPgerGVKE6F0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195611"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:48:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059817"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059817"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:48:13 -0700
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
Subject: [PATCH v5 bpf-next 20/24] selftests/xsk: add unaligned mode test for multi-buffer
Date: Thu,  6 Jul 2023 22:46:46 +0200
Message-Id: <20230706204650.469087-21-maciej.fijalkowski@intel.com>
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

Add a test for multi-buffer AF_XDP when using unaligned mode. The test
sends 4096 9K-buffers.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 15 +++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 6fb682facce5..0a1e693e5713 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -50,6 +50,8 @@
  *       are discarded and let through, respectively.
  *    i. 2K frame size tests
  *    j. If multi-buffer is supported, send 9k packets divided into 3 frames
+ *    k. If multi-buffer and huge pages are supported, send 9k packets in a single frame
+ *       using unaligned mode
  *
  * Total tests: 12
  *
@@ -1761,6 +1763,16 @@ static int testapp_unaligned(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_unaligned_mb(struct test_spec *test)
+{
+	test_spec_set_name(test, "UNALIGNED_MODE_9K");
+	test->mtu = MAX_ETH_JUMBO_SIZE;
+	test->ifobj_tx->umem->unaligned_mode = true;
+	test->ifobj_rx->umem->unaligned_mode = true;
+	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	return testapp_validate_traffic(test);
+}
+
 static int testapp_single_pkt(struct test_spec *test)
 {
 	struct pkt pkts[] = {{0, MIN_PKT_SIZE, 0, true}};
@@ -2038,6 +2050,9 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 	case TEST_TYPE_UNALIGNED:
 		ret = testapp_unaligned(test);
 		break;
+	case TEST_TYPE_UNALIGNED_MB:
+		ret = testapp_unaligned_mb(test);
+		break;
 	case TEST_TYPE_HEADROOM:
 		ret = testapp_headroom(test);
 		break;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index cfc7c572fd2c..48cb48f1c5e6 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -86,6 +86,7 @@ enum test_type {
 	TEST_TYPE_XDP_DROP_HALF,
 	TEST_TYPE_XDP_METADATA_COUNT,
 	TEST_TYPE_RUN_TO_COMPLETION_MB,
+	TEST_TYPE_UNALIGNED_MB,
 	TEST_TYPE_MAX
 };
 
-- 
2.34.1


