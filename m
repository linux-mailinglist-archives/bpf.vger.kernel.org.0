Return-Path: <bpf+bounces-9988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC579FF2C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4890D1C20429
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADDC20B14;
	Thu, 14 Sep 2023 08:49:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0C20B0B;
	Thu, 14 Sep 2023 08:49:36 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670291;
	Thu, 14 Sep 2023 01:49:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40471c054f9so1123655e9.0;
        Thu, 14 Sep 2023 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681374; x=1695286174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv22b1bD/6K0IVKOQZcsj8mwHqX6UhX4AG2tvVmiBp8=;
        b=TqJ5glpLJWMR542Zty3RCtP677yf+1yZSp56wHoQMEep0GKQNfdiMf6MQvIDjBJh2o
         UOyGC0Pb6fkJvD9WW4RoFtC6ZYPtN5r0waQkoMwK4DGJ9TlabUUMAbxd3DLMyYSOhNmM
         CSfj46ODYQZhCY+GMIsMBpVegZbpr79Vy0Uvx9bQGN/tvADzW/Jonb8snBbHeocKmPVZ
         IUjIQLLX0hGsbaNIkB1B/nV460EFGZbbStL4VTDSXYJiwHVyVHqlaVLWiTtDKWkDW6Xd
         jQfOaPa0MOFSXy2+s+zp9XF4E3ApMUd4y/XjR+bfX/ojdpEsmBZJRFB8H3uEKS/zjgmL
         DTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681374; x=1695286174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mv22b1bD/6K0IVKOQZcsj8mwHqX6UhX4AG2tvVmiBp8=;
        b=lCsJK+4FAO2o8cyG+TEDCKU4pM+BzVVk246ZnuaVhRkblSOujIiJ3uzwV5JgigF83W
         I6Pp+nkbO4nIDLfiMPFdZIEpa1/18Wpp2vX74gJ9lU7Tk/m1JFHNbHsgdbTRRIMaHWvN
         dB2i1sNvAK1QrFWPpLLpGELzJsDr/QrJvwcJ9mCVpVo9Q63ZntQoTGRXUg1NxbfBa8oB
         uvH0dC0JMulORn7MGuhtEYJ/C9Gnh/XWSrSNuCLnoUiNf1mbLFesSvoynjLw6tVyTIOE
         LvRG95C6Xd65yt7TawKqXKEDhi/Y8ZxSKPN9bSTkWu9k4naJn22axxfDk/0v2cmcLRlL
         V8rQ==
X-Gm-Message-State: AOJu0YyZy4WQqbsawwlqOFT6CxzNHguiNlSrAOLWNwe+Z0W1lBh0z333
	yaivVWMVcuO2i4zX39RtXPw=
X-Google-Smtp-Source: AGHT+IFkaq5E1rNzzyHd9P1MK4Kyg6HQIgJriuXkcu78gqDJ8ljBNf4RCESTcgC80LT+i6Wx7TuY0Q==
X-Received: by 2002:a05:600c:1c0d:b0:401:c07f:72bd with SMTP id j13-20020a05600c1c0d00b00401c07f72bdmr4129426wms.4.1694681374012;
        Thu, 14 Sep 2023 01:49:34 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 05/10] selftests/xsk: declare test names in struct
Date: Thu, 14 Sep 2023 10:48:52 +0200
Message-ID: <20230914084900.492-6-magnus.karlsson@gmail.com>
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

Declare the test names statically in a struct so that we can refer to
them when adding the support to execute a single test in the next
commit. Before this patch, the names of them were not declared in a
single place which made it not possible to refer to them.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 191 +++++++----------------
 tools/testing/selftests/bpf/xskxceiver.h |  37 +----
 2 files changed, 57 insertions(+), 171 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index e8425f758d79..38d4c036060d 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -444,7 +444,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 }
 
 static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
-			   struct ifobject *ifobj_rx, enum test_mode mode)
+			   struct ifobject *ifobj_rx, enum test_mode mode,
+			   const struct test_spec *test_to_run)
 {
 	struct pkt_stream *tx_pkt_stream;
 	struct pkt_stream *rx_pkt_stream;
@@ -466,6 +467,8 @@ static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			ifobj->bind_flags |= XDP_COPY;
 	}
 
+	strncpy(test->name, test_to_run->name, MAX_TEST_NAME_SIZE);
+	test->test_func = test_to_run->test_func;
 	test->mode = mode;
 	__test_spec_init(test, ifobj_tx, ifobj_rx);
 }
@@ -475,11 +478,6 @@ static void test_spec_reset(struct test_spec *test)
 	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
 }
 
-static void test_spec_set_name(struct test_spec *test, const char *name)
-{
-	strncpy(test->name, name, MAX_TEST_NAME_SIZE);
-}
-
 static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
 				   struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
 				   struct bpf_map *xskmap_tx)
@@ -1724,7 +1722,6 @@ static int testapp_teardown(struct test_spec *test)
 {
 	int i;
 
-	test_spec_set_name(test, "TEARDOWN");
 	for (i = 0; i < MAX_TEARDOWN_ITER; i++) {
 		if (testapp_validate_traffic(test))
 			return TEST_FAILURE;
@@ -1746,11 +1743,10 @@ static void swap_directions(struct ifobject **ifobj1, struct ifobject **ifobj2)
 	*ifobj2 = tmp_ifobj;
 }
 
-static int testapp_bidi(struct test_spec *test)
+static int testapp_bidirectional(struct test_spec *test)
 {
 	int res;
 
-	test_spec_set_name(test, "BIDIRECTIONAL");
 	test->ifobj_tx->rx_on = true;
 	test->ifobj_rx->tx_on = true;
 	test->total_steps = 2;
@@ -1779,9 +1775,8 @@ static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		exit_with_error(errno);
 }
 
-static int testapp_bpf_res(struct test_spec *test)
+static int testapp_xdp_prog_cleanup(struct test_spec *test)
 {
-	test_spec_set_name(test, "BPF_RES");
 	test->total_steps = 2;
 	test->nb_sockets = 2;
 	if (testapp_validate_traffic(test))
@@ -1793,14 +1788,12 @@ static int testapp_bpf_res(struct test_spec *test)
 
 static int testapp_headroom(struct test_spec *test)
 {
-	test_spec_set_name(test, "UMEM_HEADROOM");
 	test->ifobj_rx->umem->frame_headroom = UMEM_HEADROOM_TEST_SIZE;
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_stats_rx_dropped(struct test_spec *test)
 {
-	test_spec_set_name(test, "STAT_RX_DROPPED");
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_test_result_skip("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
@@ -1816,7 +1809,6 @@ static int testapp_stats_rx_dropped(struct test_spec *test)
 
 static int testapp_stats_tx_invalid_descs(struct test_spec *test)
 {
-	test_spec_set_name(test, "STAT_TX_INVALID");
 	pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0);
 	test->ifobj_tx->validation_func = validate_tx_invalid_descs;
 	return testapp_validate_traffic(test);
@@ -1824,7 +1816,6 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
 
 static int testapp_stats_rx_full(struct test_spec *test)
 {
-	test_spec_set_name(test, "STAT_RX_FULL");
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
 	test->ifobj_rx->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
 							 DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
@@ -1837,7 +1828,6 @@ static int testapp_stats_rx_full(struct test_spec *test)
 
 static int testapp_stats_fill_empty(struct test_spec *test)
 {
-	test_spec_set_name(test, "STAT_RX_FILL_EMPTY");
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
 	test->ifobj_rx->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
 							 DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
@@ -1847,9 +1837,8 @@ static int testapp_stats_fill_empty(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
-static int testapp_unaligned(struct test_spec *test)
+static int testapp_send_receive_unaligned(struct test_spec *test)
 {
-	test_spec_set_name(test, "UNALIGNED_MODE");
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
 	/* Let half of the packets straddle a 4K buffer boundary */
@@ -1858,9 +1847,8 @@ static int testapp_unaligned(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
-static int testapp_unaligned_mb(struct test_spec *test)
+static int testapp_send_receive_unaligned_mb(struct test_spec *test)
 {
-	test_spec_set_name(test, "UNALIGNED_MODE_9K");
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
@@ -1872,14 +1860,12 @@ static int testapp_single_pkt(struct test_spec *test)
 {
 	struct pkt pkts[] = {{0, MIN_PKT_SIZE, 0, true}};
 
-	test_spec_set_name(test, "SEND_RECEIVE_SINGLE_PKT");
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
 	return testapp_validate_traffic(test);
 }
 
-static int testapp_multi_buffer(struct test_spec *test)
+static int testapp_send_receive_mb(struct test_spec *test)
 {
-	test_spec_set_name(test, "SEND_RECEIVE_9K_PACKETS");
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
 
@@ -1976,7 +1962,6 @@ static int testapp_xdp_drop(struct test_spec *test)
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
 
-	test_spec_set_name(test, "XDP_DROP_HALF");
 	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_drop, skel_tx->progs.xsk_xdp_drop,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
@@ -2009,8 +1994,6 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
 
 static int testapp_poll_txq_tmout(struct test_spec *test)
 {
-	test_spec_set_name(test, "POLL_TXQ_FULL");
-
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->umem->frame_size = 2048;
@@ -2020,7 +2003,6 @@ static int testapp_poll_txq_tmout(struct test_spec *test)
 
 static int testapp_poll_rxq_tmout(struct test_spec *test)
 {
-	test_spec_set_name(test, "POLL_RXQ_EMPTY");
 	test->ifobj_rx->use_poll = true;
 	return testapp_validate_traffic_single_thread(test, test->ifobj_rx);
 }
@@ -2030,7 +2012,6 @@ static int testapp_too_many_frags(struct test_spec *test)
 	struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
 	u32 max_frags, i;
 
-	test_spec_set_name(test, "TOO_MANY_FRAGS");
 	if (test->mode == TEST_MODE_ZC)
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
 	else
@@ -2136,13 +2117,11 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 
 static int testapp_send_receive(struct test_spec *test)
 {
-	test_spec_set_name(test, "SEND_RECEIVE");
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_send_receive_2k_frame(struct test_spec *test)
 {
-	test_spec_set_name(test, "SEND_RECEIVE_2K_FRAME_SIZE");
 	test->ifobj_tx->umem->frame_size = 2048;
 	test->ifobj_rx->umem->frame_size = 2048;
 	pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
@@ -2152,26 +2131,22 @@ static int testapp_send_receive_2k_frame(struct test_spec *test)
 static int testapp_poll_rx(struct test_spec *test)
 {
 	test->ifobj_rx->use_poll = true;
-	test_spec_set_name(test, "POLL_RX");
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_poll_tx(struct test_spec *test)
 {
 	test->ifobj_tx->use_poll = true;
-	test_spec_set_name(test, "POLL_TX");
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_aligned_inv_desc(struct test_spec *test)
 {
-	test_spec_set_name(test, "ALIGNED_INV_DESC");
 	return testapp_invalid_desc(test);
 }
 
 static int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
 {
-	test_spec_set_name(test, "ALIGNED_INV_DESC_2K_FRAME_SIZE");
 	test->ifobj_tx->umem->frame_size = 2048;
 	test->ifobj_rx->umem->frame_size = 2048;
 	return testapp_invalid_desc(test);
@@ -2179,7 +2154,6 @@ static int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
 
 static int testapp_unaligned_inv_desc(struct test_spec *test)
 {
-	test_spec_set_name(test, "UNALIGNED_INV_DESC");
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
 	return testapp_invalid_desc(test);
@@ -2189,7 +2163,6 @@ static int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 {
 	u64 page_size, umem_size;
 
-	test_spec_set_name(test, "UNALIGNED_INV_DESC_4K1_FRAME_SIZE");
 	/* Odd frame size so the UMEM doesn't end near a page boundary. */
 	test->ifobj_tx->umem->frame_size = 4001;
 	test->ifobj_rx->umem->frame_size = 4001;
@@ -2208,13 +2181,11 @@ static int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 
 static int testapp_aligned_inv_desc_mb(struct test_spec *test)
 {
-	test_spec_set_name(test, "ALIGNED_INV_DESC_MULTI_BUFF");
 	return testapp_invalid_desc_mb(test);
 }
 
 static int testapp_unaligned_inv_desc_mb(struct test_spec *test)
 {
-	test_spec_set_name(test, "UNALIGNED_INV_DESC_MULTI_BUFF");
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
 	return testapp_invalid_desc_mb(test);
@@ -2222,109 +2193,20 @@ static int testapp_unaligned_inv_desc_mb(struct test_spec *test)
 
 static int testapp_xdp_metadata(struct test_spec *test)
 {
-	test_spec_set_name(test, "XDP_METADATA_COPY");
 	return testapp_xdp_metadata_copy(test);
 }
 
 static int testapp_xdp_metadata_mb(struct test_spec *test)
 {
-	test_spec_set_name(test, "XDP_METADATA_COPY_MULTI_BUFF");
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	return testapp_xdp_metadata_copy(test);
 }
 
-static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_type type)
-{
-	int ret = TEST_SKIP;
-
-	switch (type) {
-	case TEST_TYPE_STATS_RX_DROPPED:
-		ret = testapp_stats_rx_dropped(test);
-		break;
-	case TEST_TYPE_STATS_TX_INVALID_DESCS:
-		ret = testapp_stats_tx_invalid_descs(test);
-		break;
-	case TEST_TYPE_STATS_RX_FULL:
-		ret = testapp_stats_rx_full(test);
-		break;
-	case TEST_TYPE_STATS_FILL_EMPTY:
-		ret = testapp_stats_fill_empty(test);
-		break;
-	case TEST_TYPE_TEARDOWN:
-		ret = testapp_teardown(test);
-		break;
-	case TEST_TYPE_BIDI:
-		ret = testapp_bidi(test);
-		break;
-	case TEST_TYPE_BPF_RES:
-		ret = testapp_bpf_res(test);
-		break;
-	case TEST_TYPE_RUN_TO_COMPLETION:
-		ret = testapp_send_receive(test);
-		break;
-	case TEST_TYPE_RUN_TO_COMPLETION_MB:
-		ret = testapp_multi_buffer(test);
-		break;
-	case TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT:
-		ret = testapp_single_pkt(test);
-		break;
-	case TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME:
-		ret = testapp_send_receive_2k_frame(test);
-		break;
-	case TEST_TYPE_RX_POLL:
-		ret = testapp_poll_rx(test);
-		break;
-	case TEST_TYPE_TX_POLL:
-		ret = testapp_poll_tx(test);
-		break;
-	case TEST_TYPE_POLL_TXQ_TMOUT:
-		ret = testapp_poll_txq_tmout(test);
-		break;
-	case TEST_TYPE_POLL_RXQ_TMOUT:
-		ret = testapp_poll_rxq_tmout(test);
-		break;
-	case TEST_TYPE_ALIGNED_INV_DESC:
-		ret = testapp_aligned_inv_desc(test);
-		break;
-	case TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME:
-		ret = testapp_aligned_inv_desc_2k_frame(test);
-		break;
-	case TEST_TYPE_UNALIGNED_INV_DESC:
-		ret = testapp_unaligned_inv_desc(test);
-		break;
-	case TEST_TYPE_UNALIGNED_INV_DESC_4K1_FRAME:
-		ret = testapp_unaligned_inv_desc_4001_frame(test);
-		break;
-	case TEST_TYPE_ALIGNED_INV_DESC_MB:
-		ret = testapp_aligned_inv_desc_mb(test);
-		break;
-	case TEST_TYPE_UNALIGNED_INV_DESC_MB:
-		ret = testapp_unaligned_inv_desc_mb(test);
-		break;
-	case TEST_TYPE_UNALIGNED:
-		ret = testapp_unaligned(test);
-		break;
-	case TEST_TYPE_UNALIGNED_MB:
-		ret = testapp_unaligned_mb(test);
-		break;
-	case TEST_TYPE_HEADROOM:
-		ret = testapp_headroom(test);
-		break;
-	case TEST_TYPE_XDP_DROP_HALF:
-		ret = testapp_xdp_drop(test);
-		break;
-	case TEST_TYPE_XDP_METADATA_COUNT:
-		ret = testapp_xdp_metadata(test);
-		break;
-	case TEST_TYPE_XDP_METADATA_COUNT_MB:
-		ret = testapp_xdp_metadata_mb(test);
-		break;
-	case TEST_TYPE_TOO_MANY_FRAGS:
-		ret = testapp_too_many_frags(test);
-		break;
-	default:
-		break;
-	}
+static void run_pkt_test(struct test_spec *test)
+{
+	int ret;
+
+	ret = test->test_func(test);
 
 	if (ret == TEST_PASS)
 		ksft_test_result_pass("PASS: %s %s%s\n", mode_string(test), busy_poll_string(test),
@@ -2392,6 +2274,39 @@ static bool is_xdp_supported(int ifindex)
 	return true;
 }
 
+static const struct test_spec tests[] = {
+	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
+	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
+	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},
+	{.name = "POLL_RX", .test_func = testapp_poll_rx},
+	{.name = "POLL_TX", .test_func = testapp_poll_tx},
+	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
+	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
+	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
+	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
+	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
+	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
+	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
+	 .test_func = testapp_unaligned_inv_desc_4001_frame},
+	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
+	{.name = "TEARDOWN", .test_func = testapp_teardown},
+	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
+	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
+	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
+	{.name = "STAT_RX_FULL", .test_func = testapp_stats_rx_full},
+	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
+	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
+	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
+	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
+	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
+	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
+	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
+	 .test_func = testapp_send_receive_unaligned_mb},
+	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
+	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
+	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
+};
+
 int main(int argc, char **argv)
 {
 	struct pkt_stream *rx_pkt_stream_default;
@@ -2434,7 +2349,7 @@ int main(int argc, char **argv)
 	init_iface(ifobj_rx, MAC1, MAC2, worker_testapp_validate_rx);
 	init_iface(ifobj_tx, MAC2, MAC1, worker_testapp_validate_tx);
 
-	test_spec_init(&test, ifobj_tx, ifobj_rx, 0);
+	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
 	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
 	rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
 	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
@@ -2443,7 +2358,7 @@ int main(int argc, char **argv)
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
 	if (opt_mode == TEST_MODE_ALL) {
-		ksft_set_plan(modes * TEST_TYPE_MAX);
+		ksft_set_plan(modes * ARRAY_SIZE(tests));
 	} else {
 		if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
 			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
@@ -2454,16 +2369,16 @@ int main(int argc, char **argv)
 			ksft_exit_xfail();
 		}
 
-		ksft_set_plan(TEST_TYPE_MAX);
+		ksft_set_plan(ARRAY_SIZE(tests));
 	}
 
 	for (i = 0; i < modes; i++) {
 		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
 			continue;
 
-		for (j = 0; j < TEST_TYPE_MAX; j++) {
-			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
-			run_pkt_test(&test, i, j);
+		for (j = 0; j < ARRAY_SIZE(tests); j++) {
+			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
+			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
 
 			if (test.fail)
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 1412492e9618..3a71d490db3e 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -34,7 +34,7 @@
 #define MAX_INTERFACES 2
 #define MAX_INTERFACE_NAME_CHARS 16
 #define MAX_SOCKETS 2
-#define MAX_TEST_NAME_SIZE 32
+#define MAX_TEST_NAME_SIZE 48
 #define MAX_TEARDOWN_ITER 10
 #define PKT_HDR_SIZE (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
 #define MIN_PKT_SIZE 64
@@ -66,38 +66,6 @@ enum test_mode {
 	TEST_MODE_ALL
 };
 
-enum test_type {
-	TEST_TYPE_RUN_TO_COMPLETION,
-	TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME,
-	TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT,
-	TEST_TYPE_RX_POLL,
-	TEST_TYPE_TX_POLL,
-	TEST_TYPE_POLL_RXQ_TMOUT,
-	TEST_TYPE_POLL_TXQ_TMOUT,
-	TEST_TYPE_UNALIGNED,
-	TEST_TYPE_ALIGNED_INV_DESC,
-	TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME,
-	TEST_TYPE_UNALIGNED_INV_DESC,
-	TEST_TYPE_UNALIGNED_INV_DESC_4K1_FRAME,
-	TEST_TYPE_HEADROOM,
-	TEST_TYPE_TEARDOWN,
-	TEST_TYPE_BIDI,
-	TEST_TYPE_STATS_RX_DROPPED,
-	TEST_TYPE_STATS_TX_INVALID_DESCS,
-	TEST_TYPE_STATS_RX_FULL,
-	TEST_TYPE_STATS_FILL_EMPTY,
-	TEST_TYPE_BPF_RES,
-	TEST_TYPE_XDP_DROP_HALF,
-	TEST_TYPE_XDP_METADATA_COUNT,
-	TEST_TYPE_XDP_METADATA_COUNT_MB,
-	TEST_TYPE_RUN_TO_COMPLETION_MB,
-	TEST_TYPE_UNALIGNED_MB,
-	TEST_TYPE_ALIGNED_INV_DESC_MB,
-	TEST_TYPE_UNALIGNED_INV_DESC_MB,
-	TEST_TYPE_TOO_MANY_FRAGS,
-	TEST_TYPE_MAX
-};
-
 struct xsk_umem_info {
 	struct xsk_ring_prod fq;
 	struct xsk_ring_cons cq;
@@ -137,8 +105,10 @@ struct pkt_stream {
 };
 
 struct ifobject;
+struct test_spec;
 typedef int (*validation_func_t)(struct ifobject *ifobj);
 typedef void *(*thread_func_t)(void *arg);
+typedef int (*test_func_t)(struct test_spec *test);
 
 struct ifobject {
 	char ifname[MAX_INTERFACE_NAME_CHARS];
@@ -180,6 +150,7 @@ struct test_spec {
 	struct bpf_program *xdp_prog_tx;
 	struct bpf_map *xskmap_rx;
 	struct bpf_map *xskmap_tx;
+	test_func_t test_func;
 	int mtu;
 	u16 total_steps;
 	u16 current_step;
-- 
2.42.0


