Return-Path: <bpf+bounces-9987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F37779FF1D
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6E01F21DBC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ABA20B02;
	Thu, 14 Sep 2023 08:49:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870315E86;
	Thu, 14 Sep 2023 08:49:34 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D791;
	Thu, 14 Sep 2023 01:49:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3159b524c56so99956f8f.1;
        Thu, 14 Sep 2023 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681372; x=1695286172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7q/VKsTWwbx/9E2p5FgiUC33daDmCGNWOZGzKJIt0Y=;
        b=OzxiGw2ABfmkUYEBtyHvcFaKN3Q8t9NDVOtIV5vzw5rLMQxTM+YOY860qmIP14FW+6
         T6rxSf0dNNHxNzxWdn6+7WY2He7TmzoIr6hse1KuFaqrNPgN03Or0auM4OwRCJ7YlwL1
         m8B1J3bnt5hiy1pCGj1kUt0LEqKjzGaLPfjQY4iE6chC1E5YyGaVQcF5D22yNOy9lWvx
         DFHG22x1NYVPTrkx29EJB17VNMB5U5xBkHwX5bnv39jItIZX1XRa+lrzr+l4+6vNhCQS
         Vl31iEJdtueZ2mQbkJVqH9MsLU8n1Vt/TYvXonoJHVI7aw3lWeEN57QeO7SKQXCtwsUs
         WtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681372; x=1695286172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7q/VKsTWwbx/9E2p5FgiUC33daDmCGNWOZGzKJIt0Y=;
        b=IsalViOU5ggGgHJEzd81iay8+Djr8wu2KJFdc4qz+Os06eAwKtTm8ZZty/zpBZlwze
         aREbjCDLorMq4DI2w1EblhADcMVU+5zCWh3/yOYsVLkCo1bAGWgNVuTd9knuqBXzUWv6
         vWNzXMRNfS1sg38fRpUbbnFuwN8omuLVrRllHBoms+otShiCHomzcQi3nH/wx4O8pcuG
         h5AmFYaKUyxorfiskOARgAwoUsijuKbilDQenJb9Y5xP/8Q2FIKmQuM1r9gQUeq53e5f
         cccFnssxkcZnA05L0fGuJ3qx03eEKWMhf4+yKs+MP6qJqUCsQVTc9VtpAtp8QaboMDHj
         uDEg==
X-Gm-Message-State: AOJu0YzYW5XZ++QJMGqYRxnAGuJeLRYOAYOebtUOsPleMFoiTx+Izqhw
	2t+Sx/jJU2zP8tCa42SjAMI=
X-Google-Smtp-Source: AGHT+IE/s+8ZN6D6rhn0YK4JzkX5Bj2sGIfN+63tLB9anH+ig3gbARoYdENIP00aKK7XnFgQB9QDxg==
X-Received: by 2002:adf:ebc8:0:b0:31a:e54e:c790 with SMTP id v8-20020adfebc8000000b0031ae54ec790mr3878065wrn.6.1694681372205;
        Thu, 14 Sep 2023 01:49:32 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:31 -0700 (PDT)
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
	jolsa@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH bpf-next v4 04/10] selftests/xsk: move all tests to separate functions
Date: Thu, 14 Sep 2023 10:48:51 +0200
Message-ID: <20230914084900.492-5-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914084900.492-1-magnus.karlsson@gmail.com>
References: <20230914084900.492-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 64a671fca54a..e8425f758d79 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1872,13 +1872,14 @@ static int testapp_single_pkt(struct test_spec *test)
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
 
@@ -1983,7 +1984,7 @@ static int testapp_xdp_drop(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
-static int testapp_xdp_metadata_count(struct test_spec *test)
+static int testapp_xdp_metadata_copy(struct test_spec *test)
 {
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
@@ -2133,6 +2134,105 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
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
@@ -2160,32 +2260,22 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
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
@@ -2194,49 +2284,22 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
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
@@ -2251,13 +2314,10 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
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
2.42.0


