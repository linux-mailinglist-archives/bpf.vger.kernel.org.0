Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2543FD807
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhIAKtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbhIAKtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 06:49:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E986C061575;
        Wed,  1 Sep 2021 03:48:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u9so3760475wrg.8;
        Wed, 01 Sep 2021 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6ztmsfCuyf/euy3NnBbv+85iaiLweq/gL4Cay2GcwU=;
        b=Ky7qdDNN3z79k7fh9Oy0Jtw3NnDMHK88LiMnqBYG2a26fSVRBBUPqIAz6ITpGCQ+Yj
         LizV3x5RlqBFK7nwWtlDT9SVQZWQCNJIUb9CW2/h6GwQm8dMb8+6LFFcFroNRqbd0Ipg
         Aom9Se8JeNLEyXfyS1dv7bcME2+3LWbXp4mi60sBqQQzdBALMJp3ZO5xPaQaT9KvyupE
         JdFTrKWIbSKkMhJ+zFsvSv8LsB+v/fRxEAfd/qOCa/xUxRSUiGumDq0AZOP4/rm1qVoS
         WsWb3uujplu5fub8q8t4j90hDsBOsugIO4hF7MMSZwmkKJMmkNvDUdP7bUF+CKs4pIZD
         nO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6ztmsfCuyf/euy3NnBbv+85iaiLweq/gL4Cay2GcwU=;
        b=UZ9+1Gy6AGjxlUtr7VcXEKLKzAwRx45B3JVDr93gaMTkYPk3mKKgppdxzsEJId2kAC
         CzwrGcSl7QX8HpXpFS9a0qNuTKVdTLJK5m8DgJKgy/nIVnNN62Jy7kobG95r494ovNH5
         lMJt5pIfiWRAwGbKwSP7n0unlaEfTFNwHoZgRWe4SEN8qn6tuFk28WgRxKZQ/PgRsU3T
         BKPrj+kTZMi13pQMNnMlAQn32cjQR+IL1l+JKBza9ItAVDHO4LI33tXsrZo8JCoVPoCl
         N73HMty7brwCL6Z2Xcxr4tfYU5Z7NGPiaHbqEbti34H5XL0+2VBq5LtH6Rlsax/KbOx6
         jwOg==
X-Gm-Message-State: AOAM532CEOOAnOaGvxTGDjCiB0m4OhvtNJlOGlNNL6VUbsiu3crFCHM9
        EzeLbSp9rswuaLFw+pa9StM=
X-Google-Smtp-Source: ABdhPJx8sRv3wR4d/1p1VGBiiQOoSdy77R7CgoNNVwQVccil4/50cRMYYetI7kqQ0XeCC4WkuEQWWA==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr36537616wrp.381.1630493293611;
        Wed, 01 Sep 2021 03:48:13 -0700 (PDT)
Received: from localhost.localdomain (h-46-59-47-246.A165.priv.bahnhof.se. [46.59.47.246])
        by smtp.gmail.com with ESMTPSA id r12sm21530843wrv.96.2021.09.01.03.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:48:13 -0700 (PDT)
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
To:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com
Cc:     jonathan.lemon@gmail.com, ciara.loftus@intel.com,
        bpf@vger.kernel.org, yhs@fb.com, andrii@kernel.org
Subject: [PATCH bpf-next 10/20] selftests: xsk: replace second_step global variable
Date:   Wed,  1 Sep 2021 12:47:22 +0200
Message-Id: <20210901104732.10956-11-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210901104732.10956-1-magnus.karlsson@gmail.com>
References: <20210901104732.10956-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

Replace the second_step global variable with a test specification
variable called total_steps that a test can be set to indicate how
many times the packet stream should be sent without reinitializing any
sockets. This eliminates test specific code in the test runner around
the bidirectional test.

The total_steps variable is 1 by default as most tests only need a
single round of packets.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 77 +++++++++++-------------
 tools/testing/selftests/bpf/xdpxceiver.h |  4 +-
 2 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index a896d5845c0e..0a3e28c9e2a9 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -408,6 +408,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	test->ifobj_tx = ifobj_tx;
 	test->ifobj_rx = ifobj_rx;
+	test->current_step = 0;
+	test->total_steps = 1;
 }
 
 static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
@@ -713,7 +715,7 @@ static bool rx_stats_are_valid(struct ifobject *ifobject)
 	optlen = sizeof(stats);
 	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, &stats, &optlen);
 	if (err) {
-		ksft_test_result_fail("ERROR: [%s] getsockopt(XDP_STATISTICS) error %u %s\n",
+		ksft_test_result_fail("ERROR Rx: [%s] getsockopt(XDP_STATISTICS) error %u %s\n",
 				      __func__, -err, strerror(-err));
 		return true;
 	}
@@ -754,7 +756,7 @@ static void tx_stats_validate(struct ifobject *ifobject)
 	optlen = sizeof(stats);
 	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, &stats, &optlen);
 	if (err) {
-		ksft_test_result_fail("ERROR: [%s] getsockopt(XDP_STATISTICS) error %u %s\n",
+		ksft_test_result_fail("ERROR Tx: [%s] getsockopt(XDP_STATISTICS) error %u %s\n",
 				      __func__, -err, strerror(-err));
 		return;
 	}
@@ -766,12 +768,13 @@ static void tx_stats_validate(struct ifobject *ifobject)
 			      __func__, stats.tx_invalid_descs, ifobject->pkt_stream->nb_pkts);
 }
 
-static void thread_common_ops(struct ifobject *ifobject, void *bufs)
+static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
 	u64 umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	size_t mmap_sz = umem_sz;
 	int ctr = 0, ret;
+	void *bufs;
 
 	ifobject->ns_fd = switch_namespace(ifobject->nsname);
 
@@ -813,26 +816,19 @@ static void thread_common_ops(struct ifobject *ifobject, void *bufs)
 	ifobject->xsk = &ifobject->xsk_arr[0];
 }
 
-static bool testapp_is_test_two_stepped(void)
-{
-	return (test_type != TEST_TYPE_BIDI && test_type != TEST_TYPE_BPF_RES) || second_step;
-}
-
 static void testapp_cleanup_xsk_res(struct ifobject *ifobj)
 {
-	if (testapp_is_test_two_stepped()) {
-		xsk_socket__delete(ifobj->xsk->xsk);
-		(void)xsk_umem__delete(ifobj->umem->umem);
-	}
+	xsk_socket__delete(ifobj->xsk->xsk);
+	xsk_umem__delete(ifobj->umem->umem);
 }
 
 static void *worker_testapp_validate_tx(void *arg)
 {
-	struct ifobject *ifobject = (struct ifobject *)arg;
-	void *bufs = NULL;
+	struct test_spec *test = (struct test_spec *)arg;
+	struct ifobject *ifobject = test->ifobj_tx;
 
-	if (!second_step)
-		thread_common_ops(ifobject, bufs);
+	if (test->current_step == 1)
+		thread_common_ops(test, ifobject);
 
 	print_verbose("Sending %d packets on interface %s\n", ifobject->pkt_stream->nb_pkts,
 		      ifobject->ifname);
@@ -841,18 +837,19 @@ static void *worker_testapp_validate_tx(void *arg)
 	if (stat_test_type == STAT_TEST_TX_INVALID)
 		tx_stats_validate(ifobject);
 
-	testapp_cleanup_xsk_res(ifobject);
+	if (test->total_steps == test->current_step)
+		testapp_cleanup_xsk_res(ifobject);
 	pthread_exit(NULL);
 }
 
 static void *worker_testapp_validate_rx(void *arg)
 {
-	struct ifobject *ifobject = (struct ifobject *)arg;
+	struct test_spec *test = (struct test_spec *)arg;
+	struct ifobject *ifobject = test->ifobj_rx;
 	struct pollfd fds[MAX_SOCKS] = { };
-	void *bufs = NULL;
 
-	if (!second_step)
-		thread_common_ops(ifobject, bufs);
+	if (test->current_step == 1)
+		thread_common_ops(test, ifobject);
 
 	if (stat_test_type != STAT_TEST_RX_FILL_EMPTY)
 		xsk_populate_fill_ring(ifobject->umem);
@@ -871,7 +868,8 @@ static void *worker_testapp_validate_rx(void *arg)
 	if (test_type == TEST_TYPE_TEARDOWN)
 		print_verbose("Destroying socket\n");
 
-	testapp_cleanup_xsk_res(ifobject);
+	if (test->total_steps == test->current_step)
+		testapp_cleanup_xsk_res(ifobject);
 	pthread_exit(NULL);
 }
 
@@ -891,16 +889,17 @@ static void testapp_validate_traffic(struct test_spec *test)
 		pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, DEFAULT_PKT_CNT, PKT_SIZE);
 	ifobj_tx->pkt_stream = pkt_stream;
 	ifobj_rx->pkt_stream = pkt_stream;
+	test->current_step++;
 
 	/*Spawn RX thread */
-	pthread_create(&t0, NULL, ifobj_rx->func_ptr, ifobj_rx);
+	pthread_create(&t0, NULL, ifobj_rx->func_ptr, test);
 
 	pthread_barrier_wait(&barr);
 	if (pthread_barrier_destroy(&barr))
 		exit_with_error(errno);
 
 	/*Spawn TX thread */
-	pthread_create(&t1, NULL, ifobj_tx->func_ptr, ifobj_tx);
+	pthread_create(&t1, NULL, ifobj_tx->func_ptr, test);
 
 	pthread_join(t1, NULL);
 	pthread_join(t0, NULL);
@@ -934,15 +933,12 @@ static void testapp_bidi(struct test_spec *test)
 	test_spec_set_name(test, "BIDIRECTIONAL");
 	test->ifobj_tx->rx_on = true;
 	test->ifobj_rx->tx_on = true;
-	for (int i = 0; i < MAX_BIDI_ITER; i++) {
-		print_verbose("Creating socket\n");
-		testapp_validate_traffic(test);
-		if (!second_step) {
-			print_verbose("Switching Tx/Rx vectors\n");
-			swap_directions(&test->ifobj_rx, &test->ifobj_tx);
-		}
-		second_step = true;
-	}
+	test->total_steps = 2;
+	testapp_validate_traffic(test);
+
+	print_verbose("Switching Tx/Rx vectors\n");
+	swap_directions(&test->ifobj_rx, &test->ifobj_tx);
+	testapp_validate_traffic(test);
 
 	swap_directions(&test->ifobj_rx, &test->ifobj_tx);
 }
@@ -961,16 +957,12 @@ static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj
 
 static void testapp_bpf_res(struct test_spec *test)
 {
-	int i;
-
 	test_spec_set_name(test, "BPF_RES");
-	for (i = 0; i < MAX_BPF_ITER; i++) {
-		print_verbose("Creating socket\n");
-		testapp_validate_traffic(test);
-		if (!second_step)
-			swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
-		second_step = true;
-	}
+	test->total_steps = 2;
+	testapp_validate_traffic(test);
+
+	swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
+	testapp_validate_traffic(test);
 }
 
 static void testapp_stats(struct test_spec *test)
@@ -1032,7 +1024,6 @@ static void run_pkt_test(struct test_spec *test, int mode, int type)
 
 	/* reset defaults after potential previous test */
 	xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-	second_step = 0;
 	stat_test_type = -1;
 
 	configured_mode = mode;
diff --git a/tools/testing/selftests/bpf/xdpxceiver.h b/tools/testing/selftests/bpf/xdpxceiver.h
index 03ff52897d7b..ea505a4cb8c0 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.h
+++ b/tools/testing/selftests/bpf/xdpxceiver.h
@@ -24,7 +24,6 @@
 #define MAX_SOCKETS 2
 #define MAX_TEST_NAME_SIZE 32
 #define MAX_TEARDOWN_ITER 10
-#define MAX_BIDI_ITER 2
 #define MAX_BPF_ITER 2
 #define PKT_HDR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
 			sizeof(struct udphdr))
@@ -72,7 +71,6 @@ enum stat_test_type {
 
 static int configured_mode;
 static bool opt_pkt_dump;
-static bool second_step;
 static int test_type;
 
 static bool opt_verbose;
@@ -137,6 +135,8 @@ struct ifobject {
 struct test_spec {
 	struct ifobject *ifobj_tx;
 	struct ifobject *ifobj_rx;
+	u16 total_steps;
+	u16 current_step;
 	char name[MAX_TEST_NAME_SIZE];
 };
 
-- 
2.29.0

