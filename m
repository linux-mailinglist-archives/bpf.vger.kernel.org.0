Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC045810F9
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiGZKRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiGZKRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 06:17:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA5A2F669;
        Tue, 26 Jul 2022 03:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658830635; x=1690366635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8AjsIZjBf9/vKxqsEciflqsN/9+tXGQ9x02Llkl3SI=;
  b=VtssfMrk0Mhc85LrwjHWz8+79SPwK4LdTaam9jpXEyv6LYKb6HR3NmcO
   CwpaPC0AKrSgmVwXcvRaH0kt/mYxjrMy7k/uzMKzd8osfPGjZkV+nc2H1
   +akOmLJYkQu26ULwn0W/1JHazKWik3Ehz2meWAzUVYIT9LUtgx7mVzhla
   /w3U1XZCQ2df8BmaKRF0W+1U8IgEJXGDqp3L2339MPOgy0kZRq1X+1HBX
   I4jaew65nnG0fv7guoAtezIws7Bi0P0vbOmfpHq0ijeZ8TvtIEUtFfree
   mwIZvlqecm9YTyGiQagGHxWt6XrOaZ+w+SBaoXr1j4HN/vOIY7hvf9gx5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="349618658"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349618658"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 03:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="742177608"
Received: from silpixa00401350.ir.intel.com (HELO silpixav00401350..) ([10.55.128.131])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2022 03:17:12 -0700
From:   Shibin Koikkara Reeny <shibin.koikkara.reeny@intel.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn@kernel.org, kuba@kernel.org, maciej.fijalkowski@intel.com,
        andrii@kernel.org, ciara.loftus@intel.com,
        Shibin Koikkara Reeny <shibin.koikkara.reeny@intel.com>
Subject: [PATCH bpf-next v2] selftests: xsk: Update poll test cases
Date:   Tue, 26 Jul 2022 10:17:23 +0000
Message-Id: <20220726101723.250746-1-shibin.koikkara.reeny@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Poll test case was not testing all the functionality
of the poll feature in the testsuite. This patch
update the poll test case which contain 2 testcase to
test the RX and the TX poll functionality and additional
2 more testcases to check the timeout features of the
poll event.

Poll testsuite have 4 test cases:

1. TEST_TYPE_RX_POLL:
Check if RX path POLLIN function work as expect. TX path
can use any method to sent the traffic.

2. TEST_TYPE_TX_POLL:
Check if TX path POLLOUT function work as expect. RX path
can use any method to receive the traffic.

3. TEST_TYPE_POLL_RXQ_EMPTY:
Call poll function with parameter POLLIN on empty rx queue
will cause timeout.If return timeout then test case is pass.

4. TEST_TYPE_POLL_TXQ_FULL:
When txq is filled and packets are not cleaned by the kernel
then if we invoke the poll function with POLLOUT then it
should trigger. Additional timer is set in the while loop
to timeout if the TX POLLOUT timeout didn't get trigger.

v1: https://lore.kernel.org/bpf/20220718095712.588513-1-shibin.koikkara.reeny@intel.com/

Changes in v2:
 * Updated the commit message
 * fixed the while loop flow in receive_pkts function.

Signed-off-by: Shibin Koikkara Reeny <shibin.koikkara.reeny@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 172 +++++++++++++++++------
 tools/testing/selftests/bpf/xskxceiver.h |  10 +-
 2 files changed, 138 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 74d56d971baf..4394788829bf 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -424,6 +424,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
 		ifobj->use_poll = false;
+		ifobj->skip_rx = false;
+		ifobj->skip_tx = false;
 		ifobj->use_fill_ring = true;
 		ifobj->release_rx = true;
 		ifobj->pkt_stream = test->pkt_stream_default;
@@ -589,6 +591,19 @@ static struct pkt_stream *pkt_stream_clone(struct xsk_umem_info *umem,
 	return pkt_stream_generate(umem, pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
 }
 
+static void pkt_stream_invalid(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+{
+	struct pkt_stream *pkt_stream;
+	u32 i;
+
+	pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, nb_pkts, pkt_len);
+	for (i = 0; i < nb_pkts; i++)
+		pkt_stream->pkts[i].valid = false;
+
+	test->ifobj_tx->pkt_stream = pkt_stream;
+	test->ifobj_rx->pkt_stream = pkt_stream;
+}
+
 static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
 {
 	struct pkt_stream *pkt_stream;
@@ -817,9 +832,9 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 	return TEST_PASS;
 }
 
-static int receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
+static int receive_pkts(struct ifobject *ifobj, struct pollfd *fds, bool skip_tx)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {RECV_TMOUT, 0};
+	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
 	u32 idx_rx = 0, idx_fq = 0, rcvd, i, pkts_sent = 0;
 	struct pkt_stream *pkt_stream = ifobj->pkt_stream;
 	struct xsk_socket_info *xsk = ifobj->xsk;
@@ -843,17 +858,28 @@ static int receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
 		}
 
 		kick_rx(xsk);
+		if (ifobj->use_poll) {
+			ret = poll(fds, 1, POLL_TMOUT);
+			if (ret < 0)
+				exit_with_error(-ret);
+
+			if (!ret) {
+				if (skip_tx)
+					return TEST_PASS;
+
+				ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
+				return TEST_FAILURE;
 
-		rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
-		if (!rcvd) {
-			if (xsk_ring_prod__needs_wakeup(&umem->fq)) {
-				ret = poll(fds, 1, POLL_TMOUT);
-				if (ret < 0)
-					exit_with_error(-ret);
 			}
-			continue;
+
+			if (!(fds->revents & POLLIN))
+				continue;
 		}
 
+		rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
+		if (!rcvd)
+			continue;
+
 		if (ifobj->use_fill_ring) {
 			ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
 			while (ret != rcvd) {
@@ -900,13 +926,34 @@ static int receive_pkts(struct ifobject *ifobj, struct pollfd *fds)
 	return TEST_PASS;
 }
 
-static int __send_pkts(struct ifobject *ifobject, u32 *pkt_nb)
+static int __send_pkts(struct ifobject *ifobject, u32 *pkt_nb, bool use_poll,
+		       struct pollfd *fds, bool timeout)
 {
 	struct xsk_socket_info *xsk = ifobject->xsk;
-	u32 i, idx, valid_pkts = 0;
+	u32 i, idx, ret, valid_pkts = 0;
+
+	while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
+		if (use_poll) {
+			ret = poll(fds, 1, POLL_TMOUT);
+			if (timeout) {
+				if (ret < 0) {
+					ksft_print_msg("DEBUG: [%s] Poll error %d\n",
+						       __func__, ret);
+					return TEST_FAILURE;
+				}
+				if (ret == 0)
+					return TEST_PASS;
+				break;
+			}
+			if (ret <= 0) {
+				ksft_print_msg("DEBUG: [%s] Poll error %d\n",
+					       __func__, ret);
+				return TEST_FAILURE;
+			}
+		}
 
-	while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE)
 		complete_pkts(xsk, BATCH_SIZE);
+	}
 
 	for (i = 0; i < BATCH_SIZE; i++) {
 		struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
@@ -933,11 +980,27 @@ static int __send_pkts(struct ifobject *ifobject, u32 *pkt_nb)
 
 	xsk_ring_prod__submit(&xsk->tx, i);
 	xsk->outstanding_tx += valid_pkts;
-	if (complete_pkts(xsk, i))
-		return TEST_FAILURE;
 
-	usleep(10);
-	return TEST_PASS;
+	if (use_poll) {
+		ret = poll(fds, 1, POLL_TMOUT);
+		if (ret <= 0) {
+			if (ret == 0 && timeout)
+				return TEST_PASS;
+
+			ksft_print_msg("DEBUG: [%s] Poll error %d\n", __func__, ret);
+			return TEST_FAILURE;
+		}
+	}
+
+	if (!timeout) {
+		if (complete_pkts(xsk, i))
+			return TEST_FAILURE;
+
+		usleep(10);
+		return TEST_PASS;
+	}
+
+	return TEST_CONTINUE;
 }
 
 static void wait_for_tx_completion(struct xsk_socket_info *xsk)
@@ -948,29 +1011,33 @@ static void wait_for_tx_completion(struct xsk_socket_info *xsk)
 
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
+	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	bool timeout = test->ifobj_rx->skip_rx;
 	struct pollfd fds = { };
-	u32 pkt_cnt = 0;
+	u32 pkt_cnt = 0, ret;
 
 	fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
 	fds.events = POLLOUT;
 
-	while (pkt_cnt < ifobject->pkt_stream->nb_pkts) {
-		int err;
-
-		if (ifobject->use_poll) {
-			int ret;
-
-			ret = poll(&fds, 1, POLL_TMOUT);
-			if (ret <= 0)
-				continue;
+	ret = gettimeofday(&tv_now, NULL);
+	if (ret)
+		exit_with_error(errno);
+	timeradd(&tv_now, &tv_timeout, &tv_end);
 
-			if (!(fds.revents & POLLOUT))
-				continue;
+	while (pkt_cnt < ifobject->pkt_stream->nb_pkts) {
+		ret = gettimeofday(&tv_now, NULL);
+		if (ret)
+			exit_with_error(errno);
+		if (timercmp(&tv_now, &tv_end, >)) {
+			ksft_print_msg("ERROR: [%s] Send loop timed out\n", __func__);
+			return TEST_FAILURE;
 		}
 
-		err = __send_pkts(ifobject, &pkt_cnt);
-		if (err || test->fail)
+		ret = __send_pkts(ifobject, &pkt_cnt, ifobject->use_poll, &fds, timeout);
+		if ((ret || test->fail) && !timeout)
 			return TEST_FAILURE;
+		else if (ret == TEST_PASS && timeout)
+			return ret;
 	}
 
 	wait_for_tx_completion(ifobject->xsk);
@@ -1235,8 +1302,7 @@ static void *worker_testapp_validate_rx(void *arg)
 
 	pthread_barrier_wait(&barr);
 
-	err = receive_pkts(ifobject, &fds);
-
+	err = receive_pkts(ifobject, &fds, test->ifobj_tx->skip_tx);
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
 	if (err) {
@@ -1265,17 +1331,21 @@ static int testapp_validate_traffic(struct test_spec *test)
 	pkts_in_flight = 0;
 
 	/*Spawn RX thread */
-	pthread_create(&t0, NULL, ifobj_rx->func_ptr, test);
-
-	pthread_barrier_wait(&barr);
-	if (pthread_barrier_destroy(&barr))
-		exit_with_error(errno);
+	if (!ifobj_rx->skip_rx) {
+		pthread_create(&t0, NULL, ifobj_rx->func_ptr, test);
+		pthread_barrier_wait(&barr);
+		if (pthread_barrier_destroy(&barr))
+			exit_with_error(errno);
+	}
 
 	/*Spawn TX thread */
-	pthread_create(&t1, NULL, ifobj_tx->func_ptr, test);
+	if (!ifobj_tx->skip_tx) {
+		pthread_create(&t1, NULL, ifobj_tx->func_ptr, test);
+		pthread_join(t1, NULL);
+	}
 
-	pthread_join(t1, NULL);
-	pthread_join(t0, NULL);
+	if (!ifobj_rx->skip_rx)
+		pthread_join(t0, NULL);
 
 	return !!test->fail;
 }
@@ -1548,10 +1618,28 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 
 		pkt_stream_restore_default(test);
 		break;
-	case TEST_TYPE_POLL:
+	case TEST_TYPE_RX_POLL:
+		test->ifobj_rx->use_poll = true;
+		test_spec_set_name(test, "POLL_RX");
+		testapp_validate_traffic(test);
+		break;
+	case TEST_TYPE_TX_POLL:
 		test->ifobj_tx->use_poll = true;
+		test_spec_set_name(test, "POLL_TX");
+		testapp_validate_traffic(test);
+		break;
+	case TEST_TYPE_POLL_TXQ_TMOUT:
+		test_spec_set_name(test, "POLL_TXQ_FULL");
+		test->ifobj_rx->skip_rx = true;
+		test->ifobj_tx->use_poll = true;
+		pkt_stream_invalid(test, 2 * DEFAULT_PKT_CNT, PKT_SIZE);
+		testapp_validate_traffic(test);
+		pkt_stream_restore_default(test);
+		break;
+	case TEST_TYPE_POLL_RXQ_TMOUT:
+		test_spec_set_name(test, "POLL_RXQ_EMPTY");
+		test->ifobj_tx->skip_tx = true;
 		test->ifobj_rx->use_poll = true;
-		test_spec_set_name(test, "POLL");
 		testapp_validate_traffic(test);
 		break;
 	case TEST_TYPE_ALIGNED_INV_DESC:
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 3d17053f98e5..0db7e0acccb2 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -27,6 +27,7 @@
 
 #define TEST_PASS 0
 #define TEST_FAILURE -1
+#define TEST_CONTINUE 1
 #define MAX_INTERFACES 2
 #define MAX_INTERFACE_NAME_CHARS 7
 #define MAX_INTERFACES_NAMESPACE_CHARS 10
@@ -48,7 +49,7 @@
 #define SOCK_RECONF_CTR 10
 #define BATCH_SIZE 64
 #define POLL_TMOUT 1000
-#define RECV_TMOUT 3
+#define THREAD_TMOUT 3
 #define DEFAULT_PKT_CNT (4 * 1024)
 #define DEFAULT_UMEM_BUFFERS (DEFAULT_PKT_CNT / 4)
 #define UMEM_SIZE (DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE)
@@ -68,7 +69,10 @@ enum test_type {
 	TEST_TYPE_RUN_TO_COMPLETION,
 	TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME,
 	TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT,
-	TEST_TYPE_POLL,
+	TEST_TYPE_RX_POLL,
+	TEST_TYPE_TX_POLL,
+	TEST_TYPE_POLL_RXQ_TMOUT,
+	TEST_TYPE_POLL_TXQ_TMOUT,
 	TEST_TYPE_UNALIGNED,
 	TEST_TYPE_ALIGNED_INV_DESC,
 	TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME,
@@ -145,6 +149,8 @@ struct ifobject {
 	bool tx_on;
 	bool rx_on;
 	bool use_poll;
+	bool skip_rx;
+	bool skip_tx;
 	bool busy_poll;
 	bool use_fill_ring;
 	bool release_rx;
-- 
2.34.1

