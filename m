Return-Path: <bpf+bounces-4328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C374A566
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399E02814E1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE0182AA;
	Thu,  6 Jul 2023 20:48:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE1C2DD;
	Thu,  6 Jul 2023 20:48:32 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1A1FCC;
	Thu,  6 Jul 2023 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676505; x=1720212505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJSHCbzJzx9UajiPfimnxIFQzTSub+kwsAojlo4Vs7Q=;
  b=eAQu4TueJGUVVhcKf30fXNzIg+Hp8WfFzv4MEijLfL2oZIHpBUUBCSjp
   VVExQYLBqDH5Bo4VYIGjrondx4wn9IwP/gWo0sVhiBMM39+AoNVDbFsJ5
   HoCzkvqiXtLbLzKPTAJ4bVEf5yKFp5ywa9h0ovPhV5iSAuWLYctkamxsP
   pwCYfFppMA5095pS5zlWComyRf6hxp/93ABEXLbICixs9JCDeMOtK0f6n
   dtrF3ljuoBj/KYxWrHYIHBLPl7vduaMQ1JdnMIPXqvzBokhcvWzYrdnGe
   Q4J2Bqf00amkbEAbO3lnr3Txno/ZEddbJgRaQQRVEWAAqWrXdOXWKWtVo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195669"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195669"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059880"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059880"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:48:22 -0700
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
Subject: [PATCH v5 bpf-next 23/24] selftests/xsk: add test for too many frags
Date: Thu,  6 Jul 2023 22:46:49 +0200
Message-Id: <20230706204650.469087-24-maciej.fijalkowski@intel.com>
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

Add a test that will exercise maximum number of supported fragments.
This number depends on mode of the test - for SKB and DRV it will be 18
whereas for ZC this is defined by a value from NETDEV_A_DEV_XDP_ZC_MAX_SEGS
netlink attribute.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # made use of new netlink attribute
---
 tools/testing/selftests/bpf/xskxceiver.c | 54 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 4767d09d6893..3ff436706640 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1982,6 +1982,48 @@ static int testapp_poll_rxq_tmout(struct test_spec *test)
 	return testapp_validate_traffic_single_thread(test, test->ifobj_rx);
 }
 
+static int testapp_too_many_frags(struct test_spec *test)
+{
+	struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
+	u32 max_frags, i;
+
+	test_spec_set_name(test, "TOO_MANY_FRAGS");
+	if (test->mode == TEST_MODE_ZC)
+		max_frags = test->ifobj_tx->xdp_zc_max_segs;
+	else
+		max_frags = XSK_DESC__MAX_SKB_FRAGS;
+
+	test->mtu = MAX_ETH_JUMBO_SIZE;
+
+	/* Valid packet for synch */
+	pkts[0].len = MIN_PKT_SIZE;
+	pkts[0].valid = true;
+
+	/* One valid packet with the max amount of frags */
+	for (i = 1; i < max_frags + 1; i++) {
+		pkts[i].len = MIN_PKT_SIZE;
+		pkts[i].options = XDP_PKT_CONTD;
+		pkts[i].valid = true;
+	}
+	pkts[max_frags].options = 0;
+
+	/* An invalid packet with the max amount of frags but signals packet
+	 * continues on the last frag
+	 */
+	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+		pkts[i].len = MIN_PKT_SIZE;
+		pkts[i].options = XDP_PKT_CONTD;
+		pkts[i].valid = false;
+	}
+
+	/* Valid packet for synch */
+	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 1].valid = true;
+
+	pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
+	return testapp_validate_traffic(test);
+}
+
 static int xsk_load_xdp_programs(struct ifobject *ifobj)
 {
 	ifobj->xdp_progs = xsk_xdp_progs__open_and_load();
@@ -2039,9 +2081,14 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj->multi_buff_supp = true;
-	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY)
-		if (query_opts.xdp_zc_max_segs > 1)
+	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
+		if (query_opts.xdp_zc_max_segs > 1) {
 			ifobj->multi_buff_zc_supp = true;
+			ifobj->xdp_zc_max_segs = query_opts.xdp_zc_max_segs;
+		} else {
+			ifobj->xdp_zc_max_segs = 0;
+		}
+	}
 }
 
 static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_type type)
@@ -2170,6 +2217,9 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		test->mtu = MAX_ETH_JUMBO_SIZE;
 		ret = testapp_xdp_metadata_count(test);
 		break;
+	case TEST_TYPE_TOO_MANY_FRAGS:
+		ret = testapp_too_many_frags(test);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 9e1f66e0a3b6..233b66cef64a 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -53,6 +53,7 @@
 #define XSK_UMEM__LARGE_FRAME_SIZE (3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE (4 * 1024)
 #define XSK_DESC__INVALID_OPTION (0xffff)
+#define XSK_DESC__MAX_SKB_FRAGS 18
 #define HUGEPAGE_SIZE (2 * 1024 * 1024)
 #define PKT_DUMP_NB_TO_PRINT 16
 
@@ -93,6 +94,7 @@ enum test_type {
 	TEST_TYPE_UNALIGNED_MB,
 	TEST_TYPE_ALIGNED_INV_DESC_MB,
 	TEST_TYPE_UNALIGNED_INV_DESC_MB,
+	TEST_TYPE_TOO_MANY_FRAGS,
 	TEST_TYPE_MAX
 };
 
@@ -155,6 +157,7 @@ struct ifobject {
 	int ifindex;
 	int mtu;
 	u32 bind_flags;
+	u32 xdp_zc_max_segs;
 	bool tx_on;
 	bool rx_on;
 	bool use_poll;
-- 
2.34.1


