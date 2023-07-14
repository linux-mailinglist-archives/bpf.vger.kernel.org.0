Return-Path: <bpf+bounces-5013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B4753A05
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D3C2822DC
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36E3D399;
	Fri, 14 Jul 2023 11:37:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378A3D382;
	Fri, 14 Jul 2023 11:37:47 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4518E65;
	Fri, 14 Jul 2023 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334666; x=1720870666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dk4iFMiEs0gLFMsQ7PMv53QQTsgL7E1uAShStgtbHss=;
  b=hjELJMR2khbDnxfYPLTaWGDJAByf70CZuQOKEnJZ68CUMJkwqTOZVc8x
   obbMSzx2laf2thz6v2ovmlde8z81q61R6KNOBAcUPq2/6FK9q9OE0gCjj
   Z5xgY6JTIxrDufMCOfV89EYWXiNhzk6ibCCd9FahuVyLcI3984frnblJT
   9Kcq9GFzgEzFgSOumcHJP79pn0WlN7Zw0SraYGzYNf1W4uC4MvaGZlNx3
   iRUcy8/Pda29+YIc7RvvydaIW53YIDbUlUObsMGmTWCy2DJy23Ft62lJM
   ZSbi+S2LZknqEa2Bh1ZGJywiM4h4yjgv13zOvKHrsp3LH6trIgqk3ymZw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345048329"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345048329"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846425272"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="846425272"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 04:37:43 -0700
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
Subject: [PATCH v6 bpf-next 20/24] selftests/xsk: add unaligned mode test for multi-buffer
Date: Fri, 14 Jul 2023 13:36:36 +0200
Message-Id: <20230714113640.556893-21-maciej.fijalkowski@intel.com>
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


