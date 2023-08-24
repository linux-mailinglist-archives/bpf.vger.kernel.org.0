Return-Path: <bpf+bounces-8467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D8786F1E
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E91C20E21
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD1134BB;
	Thu, 24 Aug 2023 12:29:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8FFC1F;
	Thu, 24 Aug 2023 12:29:46 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA9510D7;
	Thu, 24 Aug 2023 05:29:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fef6cee938so5161075e9.0;
        Thu, 24 Aug 2023 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880181; x=1693484981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vs/37ewuzXSf2VGFA8hiMCklDqaQzdfvpndzqtLbP0g=;
        b=Lm2fqA5lhd/08taq9EcwVgDGpWNIWhXEj7+lrPVtObRUUPq5IHNGOBMitab3hHDVFp
         OWpTHl41XNFpNbNTGhSy0QUXMNNbJPPWDP5ftTP/ZvgJhZ3JoE5MOuwtgWUwq/JTnbn9
         x8A940UPpP6I1uGPA7wk8xMCrxz3shZ4XY/O7n/D6e388vK8dGmPhHUN4+9QPi1UOO6g
         qj5YQkCEtVvoQCynSR9n9G8hGNgTro4aX+ZaNTpomhJWRhcFzzfPmg7tIhEmIhwPzmZX
         hfhvWiJ5o6swDEKPs9YXVtPPBv5JnJEFtWkAxeMVdwrSFK0/VqG4PW5R6UtbLv0Eb6OH
         6T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880181; x=1693484981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs/37ewuzXSf2VGFA8hiMCklDqaQzdfvpndzqtLbP0g=;
        b=R5eNM1VfSo+OZ3wuRXGc9BvFzmn5AF2leLs9l3Q9d+pvc0IWtLWKWnRmVeFsUN6Ep+
         JZzMWIly4/gXLxYxy/F8QbCW3g7BOvLmkpBJNKwr753OEszN+jgstmxWmOcGv7aF2fgy
         aF2wGBVTWQ/rNVyTs2agHi627b+4tWk4Fl4YGUP5rleGsmWPwMAT9Pxlu3r1/G45HkJC
         sx5k9tYa8wTrwgeyNq3eoZN+qHN/Sf13MWwwqEq7UEo+7wSjS6KgGTDq3+2AfWE+DDnG
         XgJXQchdixmLdoG7c71Ft3O1YzdCfSSUifNcn8RomCtaGz5uEnFeT39Vw+6V79Cp2257
         9S9A==
X-Gm-Message-State: AOJu0YzPetH5sbuVeywX1/z75V7XurzzNUJODbE4xdt6Lx4PtxySD9RQ
	3+rkkIhYpoXo6F1rQIwhuDg=
X-Google-Smtp-Source: AGHT+IG+dRj4G6TWlkCF9Aso687Q3JSOMAChrWd94/sDtIOeweE3ro+FT4pizyL4S1PDFdm+F0LJ5A==
X-Received: by 2002:a05:600c:1c8d:b0:3ff:8617:672b with SMTP id k13-20020a05600c1c8d00b003ff8617672bmr3423336wms.2.1692880181132;
        Thu, 24 Aug 2023 05:29:41 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 04/11] selftests/xsk: move all tests to separate functions
Date: Thu, 24 Aug 2023 14:28:46 +0200
Message-Id: <20230824122853.3494-5-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824122853.3494-1-magnus.karlsson@gmail.com>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
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


