Return-Path: <bpf+bounces-7353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAC775F8C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673D21C2109E
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6318B09;
	Wed,  9 Aug 2023 12:44:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2F18008;
	Wed,  9 Aug 2023 12:44:24 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B619A1;
	Wed,  9 Aug 2023 05:44:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3174ca258bbso1103243f8f.1;
        Wed, 09 Aug 2023 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585061; x=1692189861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vs/37ewuzXSf2VGFA8hiMCklDqaQzdfvpndzqtLbP0g=;
        b=lShUsGRbTCsp37Ixv9jqP09rurANAloOkpWfGM/v36PsTxLKy6MwDfCVbnEvM3kIn2
         qlpdOJTSsgzTyIvcL8LeVLtbAEbc/kky1DpEK0v9Tobbsk+GLr9r3Rbz+KrNj4GoyIwR
         1lG8JwExVJVpCk1W4Tv3Mvf6wCq45jmScj4H/nYfgeFXZ3N3jTl8PplGRoO5CZaSIAWq
         Ps2xyLX28lC0PpELFcCv0PH72Zuiaus5eL5yFFdepEyZYz0B7JVgJDuTdRLYIsSRo713
         wTAmXZIUs6lNL7DZOj53qhHuQi5jxrx8VV51DiTP9pXhz52otrFhnTkgyqVPjp20Fag1
         zPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585061; x=1692189861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs/37ewuzXSf2VGFA8hiMCklDqaQzdfvpndzqtLbP0g=;
        b=SKZ98kTxt+Qe5vBKvnIvQpUKVIznKjqcsFAps/cegYbuQGjpMcdeTzKRc9FJOtBuym
         VWAeR3jB63PuQEl5R/2EzRY93tLq0FVSMcr6l6DVJcNS3DIroIIZSGcRULezfrUjX3MJ
         fXrsLqCrw6Hltx8hGwjFjnZgln7SSUzY4cRHZSnXtJRmEnd+bkUc40xes3pvA0V8j4xG
         J2OR5TJ7qCmhqK64n8BSZ0uXcNGjmWu8NXMWHO5YFmzniM7pozNGGlo5SJRPWBH9DA9T
         /bYUiwBz69wqd6IvejpTS4jqZbpuGdVP9alnkrtcqZ5GuUQhl0M+IK8IcceE3gSyVvE8
         8BaA==
X-Gm-Message-State: AOJu0YzibK2bc9cxBNtRz2hNhFD6DMfqMKypMd48G6Y0XXAKZEaJVQBA
	/ZhIqtAWGviKv7575aU4G4nWWtRj7HQpUZCE
X-Google-Smtp-Source: AGHT+IFTOQMDBsJ/4LRu+ZRngsBpwGTfcFD3wNwnugGRLxJ1knSXrHGrkRIvr7izB7d7lC3tr2uFiQ==
X-Received: by 2002:a5d:4b82:0:b0:2c7:1c72:699f with SMTP id b2-20020a5d4b82000000b002c71c72699fmr1745742wrt.4.1691585060798;
        Wed, 09 Aug 2023 05:44:20 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:20 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org,
	yhs@fb.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next 04/10] selftests/xsk: move all tests to separate functions
Date: Wed,  9 Aug 2023 14:43:37 +0200
Message-Id: <20230809124343.12957-5-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124343.12957-1-magnus.karlsson@gmail.com>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Prepare for the capability to be able to run a single test by moving
all the tests to their own functions. This function can then be called
to execute that test in the next commit.

Also, the tests named RUN_TO_COMPLETION_* were not named well, so
change them to SEND_RECEIVE_* as it is just a basic send and receive
test of 4K packets.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 170 +++++++++++++++--------
 1 file changed, 115 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 9f79c2b6aa97..ee72bb0a8978 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1875,13 +1875,14 @@ static int testapp_single_pkt(struct test_spec *test)
 {
 	struct pkt pkts[] = {{0, MIN_PKT_SIZE, 0, true}};
 
+	test_spec_set_name(test, "SEND_RECEIVE_SINGLE_PKT");
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_multi_buffer(struct test_spec *test)
 {
-	test_spec_set_name(test, "RUN_TO_COMPLETION_9K_PACKETS");
+	test_spec_set_name(test, "SEND_RECEIVE_9K_PACKETS");
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
 
@@ -1986,7 +1987,7 @@ static int testapp_xdp_drop(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
-static int testapp_xdp_metadata_count(struct test_spec *test)
+static int testapp_xdp_metadata_copy(struct test_spec *test)
 {
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
@@ -2136,6 +2137,105 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 	}
 }
 
+static int testapp_send_receive(struct test_spec *test)
+{
+	test_spec_set_name(test, "SEND_RECEIVE");
+	return testapp_validate_traffic(test);
+}
+
+static int testapp_send_receive_2k_frame(struct test_spec *test)
+{
+	test_spec_set_name(test, "SEND_RECEIVE_2K_FRAME_SIZE");
+	test->ifobj_tx->umem->frame_size = 2048;
+	test->ifobj_rx->umem->frame_size = 2048;
+	pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	return testapp_validate_traffic(test);
+}
+
+static int testapp_poll_rx(struct test_spec *test)
+{
+	test->ifobj_rx->use_poll = true;
+	test_spec_set_name(test, "POLL_RX");
+	return testapp_validate_traffic(test);
+}
+
+static int testapp_poll_tx(struct test_spec *test)
+{
+	test->ifobj_tx->use_poll = true;
+	test_spec_set_name(test, "POLL_TX");
+	return testapp_validate_traffic(test);
+}
+
+static int testapp_aligned_inv_desc(struct test_spec *test)
+{
+	test_spec_set_name(test, "ALIGNED_INV_DESC");
+	return testapp_invalid_desc(test);
+}
+
+static int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
+{
+	test_spec_set_name(test, "ALIGNED_INV_DESC_2K_FRAME_SIZE");
+	test->ifobj_tx->umem->frame_size = 2048;
+	test->ifobj_rx->umem->frame_size = 2048;
+	return testapp_invalid_desc(test);
+}
+
+static int testapp_unaligned_inv_desc(struct test_spec *test)
+{
+	test_spec_set_name(test, "UNALIGNED_INV_DESC");
+	test->ifobj_tx->umem->unaligned_mode = true;
+	test->ifobj_rx->umem->unaligned_mode = true;
+	return testapp_invalid_desc(test);
+}
+
+static int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
+{
+	u64 page_size, umem_size;
+
+	test_spec_set_name(test, "UNALIGNED_INV_DESC_4K1_FRAME_SIZE");
+	/* Odd frame size so the UMEM doesn't end near a page boundary. */
+	test->ifobj_tx->umem->frame_size = 4001;
+	test->ifobj_rx->umem->frame_size = 4001;
+	test->ifobj_tx->umem->unaligned_mode = true;
+	test->ifobj_rx->umem->unaligned_mode = true;
+	/* This test exists to test descriptors that staddle the end of
+	 * the UMEM but not a page.
+	 */
+	page_size = sysconf(_SC_PAGESIZE);
+	umem_size = test->ifobj_tx->umem->num_frames * test->ifobj_tx->umem->frame_size;
+	assert(umem_size % page_size > MIN_PKT_SIZE);
+	assert(umem_size % page_size < page_size - MIN_PKT_SIZE);
+
+	return testapp_invalid_desc(test);
+}
+
+static int testapp_aligned_inv_desc_mb(struct test_spec *test)
+{
+	test_spec_set_name(test, "ALIGNED_INV_DESC_MULTI_BUFF");
+	return testapp_invalid_desc_mb(test);
+}
+
+static int testapp_unaligned_inv_desc_mb(struct test_spec *test)
+{
+	test_spec_set_name(test, "UNALIGNED_INV_DESC_MULTI_BUFF");
+	test->ifobj_tx->umem->unaligned_mode = true;
+	test->ifobj_rx->umem->unaligned_mode = true;
+	return testapp_invalid_desc_mb(test);
+}
+
+static int testapp_xdp_metadata(struct test_spec *test)
+{
+	test_spec_set_name(test, "XDP_METADATA_COPY");
+	return testapp_xdp_metadata_copy(test);
+}
+
+static int testapp_xdp_metadata_mb(struct test_spec *test)
+{
+	test_spec_set_name(test, "XDP_METADATA_COPY_MULTI_BUFF");
+	test->mtu = MAX_ETH_JUMBO_SIZE;
+	return testapp_xdp_metadata_copy(test);
+}
+
 static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_type type)
 {
 	int ret = TEST_SKIP;
@@ -2163,32 +2263,22 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		ret = testapp_bpf_res(test);
 		break;
 	case TEST_TYPE_RUN_TO_COMPLETION:
-		test_spec_set_name(test, "RUN_TO_COMPLETION");
-		ret = testapp_validate_traffic(test);
+		ret = testapp_send_receive(test);
 		break;
 	case TEST_TYPE_RUN_TO_COMPLETION_MB:
 		ret = testapp_multi_buffer(test);
 		break;
 	case TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT:
-		test_spec_set_name(test, "RUN_TO_COMPLETION_SINGLE_PKT");
 		ret = testapp_single_pkt(test);
 		break;
 	case TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME:
-		test_spec_set_name(test, "RUN_TO_COMPLETION_2K_FRAME_SIZE");
-		test->ifobj_tx->umem->frame_size = 2048;
-		test->ifobj_rx->umem->frame_size = 2048;
-		pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-		ret = testapp_validate_traffic(test);
+		ret = testapp_send_receive_2k_frame(test);
 		break;
 	case TEST_TYPE_RX_POLL:
-		test->ifobj_rx->use_poll = true;
-		test_spec_set_name(test, "POLL_RX");
-		ret = testapp_validate_traffic(test);
+		ret = testapp_poll_rx(test);
 		break;
 	case TEST_TYPE_TX_POLL:
-		test->ifobj_tx->use_poll = true;
-		test_spec_set_name(test, "POLL_TX");
-		ret = testapp_validate_traffic(test);
+		ret = testapp_poll_tx(test);
 		break;
 	case TEST_TYPE_POLL_TXQ_TMOUT:
 		ret = testapp_poll_txq_tmout(test);
@@ -2197,49 +2287,22 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		ret = testapp_poll_rxq_tmout(test);
 		break;
 	case TEST_TYPE_ALIGNED_INV_DESC:
-		test_spec_set_name(test, "ALIGNED_INV_DESC");
-		ret = testapp_invalid_desc(test);
+		ret = testapp_aligned_inv_desc(test);
 		break;
 	case TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME:
-		test_spec_set_name(test, "ALIGNED_INV_DESC_2K_FRAME_SIZE");
-		test->ifobj_tx->umem->frame_size = 2048;
-		test->ifobj_rx->umem->frame_size = 2048;
-		ret = testapp_invalid_desc(test);
+		ret = testapp_aligned_inv_desc_2k_frame(test);
 		break;
 	case TEST_TYPE_UNALIGNED_INV_DESC:
-		test_spec_set_name(test, "UNALIGNED_INV_DESC");
-		test->ifobj_tx->umem->unaligned_mode = true;
-		test->ifobj_rx->umem->unaligned_mode = true;
-		ret = testapp_invalid_desc(test);
+		ret = testapp_unaligned_inv_desc(test);
 		break;
-	case TEST_TYPE_UNALIGNED_INV_DESC_4K1_FRAME: {
-		u64 page_size, umem_size;
-
-		test_spec_set_name(test, "UNALIGNED_INV_DESC_4K1_FRAME_SIZE");
-		/* Odd frame size so the UMEM doesn't end near a page boundary. */
-		test->ifobj_tx->umem->frame_size = 4001;
-		test->ifobj_rx->umem->frame_size = 4001;
-		test->ifobj_tx->umem->unaligned_mode = true;
-		test->ifobj_rx->umem->unaligned_mode = true;
-		/* This test exists to test descriptors that staddle the end of
-		 * the UMEM but not a page.
-		 */
-		page_size = sysconf(_SC_PAGESIZE);
-		umem_size = test->ifobj_tx->umem->num_frames * test->ifobj_tx->umem->frame_size;
-		assert(umem_size % page_size > MIN_PKT_SIZE);
-		assert(umem_size % page_size < page_size - MIN_PKT_SIZE);
-		ret = testapp_invalid_desc(test);
+	case TEST_TYPE_UNALIGNED_INV_DESC_4K1_FRAME:
+		ret = testapp_unaligned_inv_desc_4001_frame(test);
 		break;
-	}
 	case TEST_TYPE_ALIGNED_INV_DESC_MB:
-		test_spec_set_name(test, "ALIGNED_INV_DESC_MULTI_BUFF");
-		ret = testapp_invalid_desc_mb(test);
+		ret = testapp_aligned_inv_desc_mb(test);
 		break;
 	case TEST_TYPE_UNALIGNED_INV_DESC_MB:
-		test_spec_set_name(test, "UNALIGNED_INV_DESC_MULTI_BUFF");
-		test->ifobj_tx->umem->unaligned_mode = true;
-		test->ifobj_rx->umem->unaligned_mode = true;
-		ret = testapp_invalid_desc_mb(test);
+		ret = testapp_unaligned_inv_desc_mb(test);
 		break;
 	case TEST_TYPE_UNALIGNED:
 		ret = testapp_unaligned(test);
@@ -2254,13 +2317,10 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		ret = testapp_xdp_drop(test);
 		break;
 	case TEST_TYPE_XDP_METADATA_COUNT:
-		test_spec_set_name(test, "XDP_METADATA_COUNT");
-		ret = testapp_xdp_metadata_count(test);
+		ret = testapp_xdp_metadata(test);
 		break;
 	case TEST_TYPE_XDP_METADATA_COUNT_MB:
-		test_spec_set_name(test, "XDP_METADATA_COUNT_MULTI_BUFF");
-		test->mtu = MAX_ETH_JUMBO_SIZE;
-		ret = testapp_xdp_metadata_count(test);
+		ret = testapp_xdp_metadata_mb(test);
 		break;
 	case TEST_TYPE_TOO_MANY_FRAGS:
 		ret = testapp_too_many_frags(test);
-- 
2.34.1


