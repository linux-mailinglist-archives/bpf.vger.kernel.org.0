Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2995852146B
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiEJMBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiEJMBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 08:01:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF34451E48;
        Tue, 10 May 2022 04:56:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m62so10032648wme.5;
        Tue, 10 May 2022 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8RQhqbSMSQzlO2uVLhr3KZ2C5bSXSd8PmfwKkTKIDiY=;
        b=i9S6mC9d2nfA5TapOs+3ohWK8WT27Q/pctT1sTq3bk3BpTPQspnL8PjEhiEaKoQfYk
         7JwIPy1qZkeHIfLsGh9qskXF+kZQy35m7mAcksPrz1p0jye9SmsEmNfPvqYdh3qwgRjT
         UBl4fNNvA0PyCxrk+aS0Rcm7KxYnyk3/EuCZixqfC3ysirmiU2879lyYw5UOTaNH1YmQ
         x42AxmAHRpsMHqqalnv9CVREBegykYKeACa7GT7Vhbr1xagKEG+ocf1brWSLFaTYNUgg
         F41DETRP++LuXGlEHwB53ZkmKzHHRzr34o2yY3jWTkiXh76vd1a8+qLM7c4Tv9W6DZrA
         ad9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RQhqbSMSQzlO2uVLhr3KZ2C5bSXSd8PmfwKkTKIDiY=;
        b=BBeRCwWAtnha6EU5AH6YwdCRTxrHBInIAkV72tFo+NG+b3sUAZfYQTwzcRmLKqX2kN
         jb6wag+dFCqC+cQc5sMVpuVV8gt2HzAq4MHRod7qPcYIZ+nacwEhfspEQqspQcs9++aJ
         /i0V4NJ6R8XWSBS2uybv5aP6Jk2Pa/Y0SmTSjp6da4mtPSig2teRkOI6hRq4nfIcYnSo
         RliB6WezN5kFdO3ZDRcMlANDhS2fj+U8zpSw0F/QLWE/lQ/rNmX/AbhOgFypcz7CpQcI
         ZzO+FOE/j9+wQZ7mPPx2HdqWpnjV5odbD2nPYvC200t7e0gXur5/FDBpogkcvzsg4ZC6
         sonw==
X-Gm-Message-State: AOAM530qNAzxlGXhw9CpXASRjS31ljoi7J7CFUUBLPXjQhRqGoH9gi1J
        JQukpIiTBxj95lBqP2tOXRY=
X-Google-Smtp-Source: ABdhPJzDjdJjWvtr8gRvargpUqTSQD8Z2G6nT4s1K68C6ryesG7ysc+wVzzX8AOSaA38oACZ1dLCRg==
X-Received: by 2002:a05:600c:354e:b0:394:89ba:e211 with SMTP id i14-20020a05600c354e00b0039489bae211mr12567844wmq.86.1652183814247;
        Tue, 10 May 2022 04:56:54 -0700 (PDT)
Received: from localhost.localdomain ([188.149.128.194])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c4b9900b003942a244f51sm2267797wmp.42.2022.05.10.04.56.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 04:56:53 -0700 (PDT)
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
To:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, yhs@fb.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
Cc:     jonathan.lemon@gmail.com, bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/9] selftests: xsk: fix reporting of failed tests
Date:   Tue, 10 May 2022 13:55:59 +0200
Message-Id: <20220510115604.8717-5-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220510115604.8717-1-magnus.karlsson@gmail.com>
References: <20220510115604.8717-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

Fix the reporting of failed tests as it was broken in several
ways. First, a failed test was reported as both failed and passed
messing up the count. Second, tests were not aborted after a failure
and could generate more "failures" messing up the count even
more. Third, the failure reporting from the application to the shell
script was wrong. It always reported pass. And finally, the handling
of the failures in the launch script was not correct.

Correct all this by propagating the failure up through the function
calls to a calling function that can abort the test. A receiver or
sender thread will mark the new variable in the test spec called fail,
if a test has failed. This is then picked up by the main thread when
everyone else has exited and this is then marked and propagated up to
the calling script.

Also add a summary function in the calling script so that a user
does not have to go through the sub tests to see if something has
failed.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh    |  23 ++-
 tools/testing/selftests/bpf/xdpxceiver.c   | 173 +++++++++++++--------
 tools/testing/selftests/bpf/xdpxceiver.h   |   4 +
 tools/testing/selftests/bpf/xsk_prereqs.sh |  30 ++--
 4 files changed, 141 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 7989a9376f0e..d06215ee843d 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -87,7 +87,7 @@ done
 TEST_NAME="PREREQUISITES"
 
 URANDOM=/dev/urandom
-[ ! -e "${URANDOM}" ] && { echo "${URANDOM} not found. Skipping tests."; test_exit 1 1; }
+[ ! -e "${URANDOM}" ] && { echo "${URANDOM} not found. Skipping tests."; test_exit $ksft_fail; }
 
 VETH0_POSTFIX=$(cat ${URANDOM} | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 4)
 VETH0=ve${VETH0_POSTFIX}
@@ -155,10 +155,6 @@ TEST_NAME="XSK_SELFTESTS_SOFTIRQ"
 
 execxdpxceiver
 
-retval=$?
-test_status $retval "${TEST_NAME}"
-statusList+=($retval)
-
 cleanup_exit ${VETH0} ${VETH1} ${NS1}
 TEST_NAME="XSK_SELFTESTS_BUSY_POLL"
 busy_poll=1
@@ -166,19 +162,20 @@ busy_poll=1
 setup_vethPairs
 execxdpxceiver
 
-retval=$?
-test_status $retval "${TEST_NAME}"
-statusList+=($retval)
-
 ## END TESTS
 
 cleanup_exit ${VETH0} ${VETH1} ${NS1}
 
-for _status in "${statusList[@]}"
+failures=0
+echo -e "\nSummary:"
+for i in "${!statusList[@]}"
 do
-	if [ $_status -ne 0 ]; then
-		test_exit $ksft_fail 0
+	if [ ${statusList[$i]} -ne 0 ]; then
+	        test_status ${statusList[$i]} ${nameList[$i]}
+		failures=1
 	fi
 done
 
-test_exit $ksft_pass 0
+if [ $failures -eq 0 ]; then
+        echo "All tests successful!"
+fi
diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 6efac9e35c2e..ebbab8f967c1 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -125,9 +125,15 @@ static void __exit_with_error(int error, const char *file, const char *func, int
 #define mode_string(test) (test)->ifobj_tx->xdp_flags & XDP_FLAGS_SKB_MODE ? "SKB" : "DRV"
 #define busy_poll_string(test) (test)->ifobj_tx->busy_poll ? "BUSY-POLL " : ""
 
-#define print_ksft_result(test)						\
-	(ksft_test_result_pass("PASS: %s %s%s\n", mode_string(test), busy_poll_string(test), \
-			       (test)->name))
+static void report_failure(struct test_spec *test)
+{
+	if (test->fail)
+		return;
+
+	ksft_test_result_fail("FAIL: %s %s%s\n", mode_string(test), busy_poll_string(test),
+			      test->name);
+	test->fail = true;
+}
 
 static void memset32_htonl(void *dest, u32 val, u32 size)
 {
@@ -443,6 +449,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->current_step = 0;
 	test->total_steps = 1;
 	test->nb_sockets = 1;
+	test->fail = false;
 }
 
 static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
@@ -689,8 +696,7 @@ static bool is_offset_correct(struct xsk_umem_info *umem, struct pkt_stream *pkt
 	if (offset == expected_offset)
 		return true;
 
-	ksft_test_result_fail("ERROR: [%s] expected [%u], got [%u]\n", __func__, expected_offset,
-			      offset);
+	ksft_print_msg("[%s] expected [%u], got [%u]\n", __func__, expected_offset, offset);
 	return false;
 }
 
@@ -700,7 +706,7 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 	struct iphdr *iphdr = (struct iphdr *)(data + sizeof(struct ethhdr));
 
 	if (!pkt) {
-		ksft_test_result_fail("ERROR: [%s] too many packets received\n", __func__);
+		ksft_print_msg("[%s] too many packets received\n", __func__);
 		return false;
 	}
 
@@ -710,9 +716,8 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 	}
 
 	if (pkt->len != len) {
-		ksft_test_result_fail
-			("ERROR: [%s] expected length [%d], got length [%d]\n",
-			 __func__, pkt->len, len);
+		ksft_print_msg("[%s] expected length [%d], got length [%d]\n",
+			       __func__, pkt->len, len);
 		return false;
 	}
 
@@ -723,9 +728,8 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 			pkt_dump(data, PKT_SIZE);
 
 		if (pkt->payload != seqnum) {
-			ksft_test_result_fail
-				("ERROR: [%s] expected seqnum [%d], got seqnum [%d]\n",
-					__func__, pkt->payload, seqnum);
+			ksft_print_msg("[%s] expected seqnum [%d], got seqnum [%d]\n",
+				       __func__, pkt->payload, seqnum);
 			return false;
 		}
 	} else {
@@ -761,7 +765,7 @@ static void kick_rx(struct xsk_socket_info *xsk)
 		exit_with_error(errno);
 }
 
-static void complete_pkts(struct xsk_socket_info *xsk, int batch_size)
+static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 {
 	unsigned int rcvd;
 	u32 idx;
@@ -774,18 +778,19 @@ static void complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 		if (rcvd > xsk->outstanding_tx) {
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
-			ksft_test_result_fail("ERROR: [%s] Too many packets completed\n",
-					      __func__);
+			ksft_print_msg("[%s] Too many packets completed\n", __func__);
 			ksft_print_msg("Last completion address: %llx\n", addr);
-			return;
+			return TEST_FAILURE;
 		}
 
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
 		xsk->outstanding_tx -= rcvd;
 	}
+
+	return TEST_PASS;
 }
 
-static void receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
+static int receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
 {
 	struct pkt_stream *pkt_stream = ifobj->pkt_stream;
 	struct pkt *pkt = pkt_stream_get_next_rx_pkt(pkt_stream);
@@ -824,20 +829,19 @@ static void receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
 			u64 addr = desc->addr, orig;
 
 			if (!pkt) {
-				ksft_test_result_fail("ERROR: [%s] Received too many packets.\n",
-						      __func__);
+				ksft_print_msg("[%s] Received too many packets.\n",
+					       __func__);
 				ksft_print_msg("Last packet has addr: %llx len: %u\n",
 					       addr, desc->len);
-				return;
+				return TEST_FAILURE;
 			}
 
 			orig = xsk_umem__extract_addr(addr);
 			addr = xsk_umem__add_offset_to_addr(addr);
 
-			if (!is_pkt_valid(pkt, umem->buffer, addr, desc->len))
-				return;
-			if (!is_offset_correct(umem, pkt_stream, addr, pkt->addr))
-				return;
+			if (!is_pkt_valid(pkt, umem->buffer, addr, desc->len) ||
+			    !is_offset_correct(umem, pkt_stream, addr, pkt->addr))
+				return TEST_FAILURE;
 
 			*xsk_ring_prod__fill_addr(&umem->fq, idx_fq++) = orig;
 			pkt = pkt_stream_get_next_rx_pkt(pkt_stream);
@@ -852,9 +856,11 @@ static void receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
 			pthread_cond_signal(&pacing_cond);
 		pthread_mutex_unlock(&pacing_mutex);
 	}
+
+	return TEST_PASS;
 }
 
-static u32 __send_pkts(struct ifobject *ifobject, u32 pkt_nb)
+static int __send_pkts(struct ifobject *ifobject, u32 *pkt_nb)
 {
 	struct xsk_socket_info *xsk = ifobject->xsk;
 	u32 i, idx, valid_pkts = 0;
@@ -864,14 +870,14 @@ static u32 __send_pkts(struct ifobject *ifobject, u32 pkt_nb)
 
 	for (i = 0; i < BATCH_SIZE; i++) {
 		struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
-		struct pkt *pkt = pkt_generate(ifobject, pkt_nb);
+		struct pkt *pkt = pkt_generate(ifobject, *pkt_nb);
 
 		if (!pkt)
 			break;
 
 		tx_desc->addr = pkt->addr;
 		tx_desc->len = pkt->len;
-		pkt_nb++;
+		(*pkt_nb)++;
 		if (pkt->valid)
 			valid_pkts++;
 	}
@@ -886,10 +892,11 @@ static u32 __send_pkts(struct ifobject *ifobject, u32 pkt_nb)
 
 	xsk_ring_prod__submit(&xsk->tx, i);
 	xsk->outstanding_tx += valid_pkts;
-	complete_pkts(xsk, i);
+	if (complete_pkts(xsk, i))
+		return TEST_FAILURE;
 
 	usleep(10);
-	return i;
+	return TEST_PASS;
 }
 
 static void wait_for_tx_completion(struct xsk_socket_info *xsk)
@@ -898,7 +905,7 @@ static void wait_for_tx_completion(struct xsk_socket_info *xsk)
 		complete_pkts(xsk, BATCH_SIZE);
 }
 
-static void send_pkts(struct ifobject *ifobject)
+static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
 	struct pollfd fds = { };
 	u32 pkt_cnt = 0;
@@ -907,6 +914,8 @@ static void send_pkts(struct ifobject *ifobject)
 	fds.events = POLLOUT;
 
 	while (pkt_cnt < ifobject->pkt_stream->nb_pkts) {
+		int err;
+
 		if (ifobject->use_poll) {
 			int ret;
 
@@ -918,13 +927,16 @@ static void send_pkts(struct ifobject *ifobject)
 				continue;
 		}
 
-		pkt_cnt += __send_pkts(ifobject, pkt_cnt);
+		err = __send_pkts(ifobject, &pkt_cnt);
+		if (err || test->fail)
+			return TEST_FAILURE;
 	}
 
 	wait_for_tx_completion(ifobject->xsk);
+	return TEST_PASS;
 }
 
-static bool rx_stats_are_valid(struct ifobject *ifobject)
+static int rx_stats_validate(struct ifobject *ifobject)
 {
 	u32 xsk_stat = 0, expected_stat = ifobject->pkt_stream->nb_pkts;
 	struct xsk_socket *xsk = ifobject->xsk->xsk;
@@ -938,9 +950,9 @@ static bool rx_stats_are_valid(struct ifobject *ifobject)
 	optlen = sizeof(stats);
 	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, &stats, &optlen);
 	if (err) {
-		ksft_test_result_fail("ERROR Rx: [%s] getsockopt(XDP_STATISTICS) error %u %s\n",
-				      __func__, -err, strerror(-err));
-		return true;
+		ksft_print_msg("[%s] getsockopt(XDP_STATISTICS) error %u %s\n",
+			       __func__, -err, strerror(-err));
+		return TEST_FAILURE;
 	}
 
 	if (optlen == sizeof(struct xdp_statistics)) {
@@ -965,13 +977,13 @@ static bool rx_stats_are_valid(struct ifobject *ifobject)
 		}
 
 		if (xsk_stat == expected_stat)
-			return true;
+			return TEST_PASS;
 	}
 
-	return false;
+	return TEST_CONTINUE;
 }
 
-static void tx_stats_validate(struct ifobject *ifobject)
+static int tx_stats_validate(struct ifobject *ifobject)
 {
 	struct xsk_socket *xsk = ifobject->xsk->xsk;
 	int fd = xsk_socket__fd(xsk);
@@ -982,16 +994,18 @@ static void tx_stats_validate(struct ifobject *ifobject)
 	optlen = sizeof(stats);
 	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, &stats, &optlen);
 	if (err) {
-		ksft_test_result_fail("ERROR Tx: [%s] getsockopt(XDP_STATISTICS) error %u %s\n",
-				      __func__, -err, strerror(-err));
-		return;
+		ksft_print_msg("[%s] getsockopt(XDP_STATISTICS) error %u %s\n",
+			       __func__, -err, strerror(-err));
+		return TEST_FAILURE;
 	}
 
-	if (stats.tx_invalid_descs == ifobject->pkt_stream->nb_pkts)
-		return;
+	if (stats.tx_invalid_descs != ifobject->pkt_stream->nb_pkts) {
+		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
+			       __func__, stats.tx_invalid_descs, ifobject->pkt_stream->nb_pkts);
+		return TEST_FAILURE;
+	}
 
-	ksft_test_result_fail("ERROR: [%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
-			      __func__, stats.tx_invalid_descs, ifobject->pkt_stream->nb_pkts);
+	return TEST_PASS;
 }
 
 static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
@@ -1064,18 +1078,26 @@ static void *worker_testapp_validate_tx(void *arg)
 {
 	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_tx;
+	int err;
 
 	if (test->current_step == 1)
 		thread_common_ops(test, ifobject);
 
 	print_verbose("Sending %d packets on interface %s\n", ifobject->pkt_stream->nb_pkts,
 		      ifobject->ifname);
-	send_pkts(ifobject);
+	err = send_pkts(test, ifobject);
+	if (err) {
+		report_failure(test);
+		goto out;
+	}
 
-	if (stat_test_type == STAT_TEST_TX_INVALID)
-		tx_stats_validate(ifobject);
+	if (stat_test_type == STAT_TEST_TX_INVALID) {
+		err = tx_stats_validate(ifobject);
+		report_failure(test);
+	}
 
-	if (test->total_steps == test->current_step)
+out:
+	if (test->total_steps == test->current_step || err)
 		testapp_cleanup_xsk_res(ifobject);
 	pthread_exit(NULL);
 }
@@ -1116,6 +1138,7 @@ static void *worker_testapp_validate_rx(void *arg)
 	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_rx;
 	struct pollfd fds = { };
+	int err;
 
 	if (test->current_step == 1)
 		thread_common_ops(test, ifobject);
@@ -1127,18 +1150,27 @@ static void *worker_testapp_validate_rx(void *arg)
 
 	pthread_barrier_wait(&barr);
 
-	if (test_type == TEST_TYPE_STATS)
-		while (!rx_stats_are_valid(ifobject))
-			continue;
-	else
-		receive_pkts(ifobject, &fds);
+	if (test_type == TEST_TYPE_STATS) {
+		do {
+			err = rx_stats_validate(ifobject);
+		} while (err == TEST_CONTINUE);
+	} else {
+		err = receive_pkts(ifobject, &fds);
+	}
+
+	if (err) {
+		report_failure(test);
+		pthread_mutex_lock(&pacing_mutex);
+		pthread_cond_signal(&pacing_cond);
+		pthread_mutex_unlock(&pacing_mutex);
+	}
 
-	if (test->total_steps == test->current_step)
+	if (test->total_steps == test->current_step || err)
 		testapp_cleanup_xsk_res(ifobject);
 	pthread_exit(NULL);
 }
 
-static void testapp_validate_traffic(struct test_spec *test)
+static int testapp_validate_traffic(struct test_spec *test)
 {
 	struct ifobject *ifobj_tx = test->ifobj_tx;
 	struct ifobject *ifobj_rx = test->ifobj_rx;
@@ -1163,6 +1195,8 @@ static void testapp_validate_traffic(struct test_spec *test)
 
 	pthread_join(t1, NULL);
 	pthread_join(t0, NULL);
+
+	return !!test->fail;
 }
 
 static void testapp_teardown(struct test_spec *test)
@@ -1171,7 +1205,8 @@ static void testapp_teardown(struct test_spec *test)
 
 	test_spec_set_name(test, "TEARDOWN");
 	for (i = 0; i < MAX_TEARDOWN_ITER; i++) {
-		testapp_validate_traffic(test);
+		if (testapp_validate_traffic(test))
+			return;
 		test_spec_reset(test);
 	}
 }
@@ -1194,7 +1229,8 @@ static void testapp_bidi(struct test_spec *test)
 	test->ifobj_tx->rx_on = true;
 	test->ifobj_rx->tx_on = true;
 	test->total_steps = 2;
-	testapp_validate_traffic(test);
+	if (testapp_validate_traffic(test))
+		return;
 
 	print_verbose("Switching Tx/Rx vectors\n");
 	swap_directions(&test->ifobj_rx, &test->ifobj_tx);
@@ -1222,7 +1258,8 @@ static void testapp_bpf_res(struct test_spec *test)
 	test_spec_set_name(test, "BPF_RES");
 	test->total_steps = 2;
 	test->nb_sockets = 2;
-	testapp_validate_traffic(test);
+	if (testapp_validate_traffic(test))
+		return;
 
 	swap_xsk_resources(test->ifobj_tx, test->ifobj_rx);
 	testapp_validate_traffic(test);
@@ -1278,6 +1315,9 @@ static void testapp_stats(struct test_spec *test)
 		default:
 			break;
 		}
+
+		if (test->fail)
+			break;
 	}
 
 	/* To only see the whole stat set being completed unless an individual test fails. */
@@ -1458,7 +1498,9 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		break;
 	}
 
-	print_ksft_result(test);
+	if (!test->fail)
+		ksft_test_result_pass("PASS: %s %s%s\n", mode_string(test), busy_poll_string(test),
+				      test->name);
 }
 
 static struct ifobject *ifobject_create(void)
@@ -1497,8 +1539,8 @@ int main(int argc, char **argv)
 {
 	struct pkt_stream *pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	u32 i, j, failed_tests = 0;
 	struct test_spec test;
-	u32 i, j;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -1537,12 +1579,17 @@ int main(int argc, char **argv)
 			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
 			run_pkt_test(&test, i, j);
 			usleep(USLEEP_MAX);
+
+			if (test.fail)
+				failed_tests++;
 		}
 
 	pkt_stream_delete(pkt_stream_default);
 	ifobject_delete(ifobj_tx);
 	ifobject_delete(ifobj_rx);
 
-	ksft_exit_pass();
-	return 0;
+	if (failed_tests)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/bpf/xdpxceiver.h b/tools/testing/selftests/bpf/xdpxceiver.h
index 0eea0e1495ba..7c6bf5ed594d 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.h
+++ b/tools/testing/selftests/bpf/xdpxceiver.h
@@ -25,6 +25,9 @@
 #define SO_PREFER_BUSY_POLL 69
 #endif
 
+#define TEST_PASS 0
+#define TEST_FAILURE -1
+#define TEST_CONTINUE -2
 #define MAX_INTERFACES 2
 #define MAX_INTERFACE_NAME_CHARS 7
 #define MAX_INTERFACES_NAMESPACE_CHARS 10
@@ -160,6 +163,7 @@ struct test_spec {
 	u16 total_steps;
 	u16 current_step;
 	u16 nb_sockets;
+	bool fail;
 	char name[MAX_TEST_NAME_SIZE];
 };
 
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
index 8b77d4c78aba..684e813803ec 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
@@ -15,7 +15,7 @@ validate_root_exec()
 	msg="skip all tests:"
 	if [ $UID != 0 ]; then
 		echo $msg must be run as root >&2
-		test_exit $ksft_fail 2
+		test_exit $ksft_fail
 	else
 		return $ksft_pass
 	fi
@@ -26,7 +26,7 @@ validate_veth_support()
 	msg="skip all tests:"
 	if [ $(ip link add $1 type veth 2>/dev/null; echo $?;) != 0 ]; then
 		echo $msg veth kernel support not available >&2
-		test_exit $ksft_skip 1
+		test_exit $ksft_skip
 	else
 		ip link del $1
 		return $ksft_pass
@@ -36,22 +36,21 @@ validate_veth_support()
 test_status()
 {
 	statusval=$1
-	if [ $statusval -eq 2 ]; then
-		echo -e "$2: [ FAIL ]"
-	elif [ $statusval -eq 1 ]; then
-		echo -e "$2: [ SKIPPED ]"
-	elif [ $statusval -eq 0 ]; then
-		echo -e "$2: [ PASS ]"
+	if [ $statusval -eq $ksft_fail ]; then
+		echo "$2: [ FAIL ]"
+	elif [ $statusval -eq $ksft_skip ]; then
+		echo "$2: [ SKIPPED ]"
+	elif [ $statusval -eq $ksft_pass ]; then
+		echo "$2: [ PASS ]"
 	fi
 }
 
 test_exit()
 {
-	retval=$1
-	if [ $2 -ne 0 ]; then
-		test_status $2 $(basename $0)
+	if [ $1 -ne 0 ]; then
+		test_status $1 $(basename $0)
 	fi
-	exit $retval
+	exit 1
 }
 
 clear_configs()
@@ -75,7 +74,7 @@ cleanup_exit()
 
 validate_ip_utility()
 {
-	[ ! $(type -P ip) ] && { echo "'ip' not found. Skipping tests."; test_exit $ksft_skip 1; }
+	[ ! $(type -P ip) ] && { echo "'ip' not found. Skipping tests."; test_exit $ksft_skip; }
 }
 
 execxdpxceiver()
@@ -85,4 +84,9 @@ execxdpxceiver()
 	fi
 
 	./${XSKOBJ} -i ${VETH0} -i ${VETH1},${NS1} ${ARGS}
+
+	retval=$?
+	test_status $retval "${TEST_NAME}"
+	statusList+=($retval)
+	nameList+=(${TEST_NAME})
 }
-- 
2.34.1

