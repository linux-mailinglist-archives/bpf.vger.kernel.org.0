Return-Path: <bpf+bounces-10737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA597AD53D
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 857231C20856
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4101427F;
	Mon, 25 Sep 2023 10:02:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96D14019;
	Mon, 25 Sep 2023 10:02:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A9CDE;
	Mon, 25 Sep 2023 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695636125; x=1727172125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pz4M0xCq5nOyGJm1qi3nBCyxuCVBEoRFqVe0XQS6F+Y=;
  b=IzWND/Nu0NZg5fCeRvq3hfF1m+g1I2mXpFM83/4+FhUNraNwhfvTxBhk
   v61kHung8fYlCCa9UwpbDeGSRDiGk8x8pLPYVOi/LYV5C1xz6jK0EhD5+
   xNUQmnNjvSDbbyb2Qv1btGScJicnPr/PaqOLLVeO9gYAElTO6uM1xf/Qn
   RAIwQMuFABCOxYaTtB0dnOQIQ8zOVzMfGb9naGs+69sdJp+cY3ZYFTroa
   xJb80JMbkUaSE2rayUIapjARIzu0qmjA7i5TaIM5g0y2F+w9mGlBTTcgz
   F18UHj55R9Z3sH9z2/uztA6lT3gRcLZx2TcEz7JNKT82Smntv7NHpYGpc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445325177"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445325177"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="697923616"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="697923616"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:02:00 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v2 4/8] selftests/xsk: iterate over all the sockets in the receive pkts function
Date: Mon, 25 Sep 2023 15:52:45 +0530
Message-Id: <20230925102249.1847195-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925102249.1847195-1-tushar.vyavahare@intel.com>
References: <20230925102249.1847195-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve the receive_pkt() function to enable it to receive packets from
multiple sockets. Define a sock_num variable to iterate through all the
sockets in the Rx path. Add nb_valid_entries to check that all the
expected number of packets are received.

Revise the function __receive_pkts() to only inspect the receive ring
once, handle any received packets, and promptly return. Implement a bitmap
to store the value of number of sockets. Update Makefile to include
find_bit.c for compiling xskxceiver.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/Makefile     |   4 +-
 tools/testing/selftests/bpf/xskxceiver.c | 285 ++++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h |   2 +
 3 files changed, 178 insertions(+), 113 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..b9a30ff99208 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -640,7 +640,9 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xskxceiver: xskxceiver.c xskxceiver.h $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+# Include find_bit.c to compile xskxceiver.
+EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c
+$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index e26f942a7b9e..627c68f047e0 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -80,6 +80,7 @@
 #include <linux/if_ether.h>
 #include <linux/mman.h>
 #include <linux/netdev.h>
+#include <linux/bitmap.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -530,8 +531,10 @@ static int test_spec_set_mtu(struct test_spec *test, int mtu)
 
 static void pkt_stream_reset(struct pkt_stream *pkt_stream)
 {
-	if (pkt_stream)
+	if (pkt_stream) {
 		pkt_stream->current_pkt_nb = 0;
+		pkt_stream->nb_rx_pkts = 0;
+	}
 }
 
 static struct pkt *pkt_stream_get_next_tx_pkt(struct pkt_stream *pkt_stream)
@@ -631,14 +634,16 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	return nb_frags;
 }
 
-static void pkt_set(struct xsk_umem_info *umem, struct pkt *pkt, int offset, u32 len)
+static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
 {
 	pkt->offset = offset;
 	pkt->len = len;
-	if (len > MAX_ETH_JUMBO_SIZE)
+	if (len > MAX_ETH_JUMBO_SIZE) {
 		pkt->valid = false;
-	else
+	} else {
 		pkt->valid = true;
+		pkt_stream->nb_valid_entries++;
+	}
 }
 
 static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
@@ -660,7 +665,7 @@ static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info *umem, u32 nb
 	for (i = 0; i < nb_pkts; i++) {
 		struct pkt *pkt = &pkt_stream->pkts[i];
 
-		pkt_set(umem, pkt, 0, pkt_len);
+		pkt_set(pkt_stream, pkt, 0, pkt_len);
 		pkt->pkt_nb = i;
 	}
 
@@ -692,9 +697,10 @@ static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
 
 	pkt_stream = pkt_stream_clone(umem, ifobj->xsk->pkt_stream);
 	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
-		pkt_set(umem, &pkt_stream->pkts[i], offset, pkt_len);
+		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
 
 	ifobj->xsk->pkt_stream = pkt_stream;
+	pkt_stream->nb_valid_entries /= 2;
 }
 
 static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
@@ -714,6 +720,8 @@ static void pkt_stream_receive_half(struct test_spec *test)
 	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
 	for (i = 1; i < pkt_stream->nb_pkts; i += 2)
 		pkt_stream->pkts[i].valid = false;
+
+	pkt_stream->nb_valid_entries /= 2;
 }
 
 static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
@@ -787,6 +795,10 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 
 		if (pkt->valid && pkt->len > pkt_stream->max_pkt_len)
 			pkt_stream->max_pkt_len = pkt->len;
+
+		if (pkt->valid)
+			pkt_stream->nb_valid_entries++;
+
 		pkt_nb++;
 	}
 
@@ -1008,133 +1020,178 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 	return TEST_PASS;
 }
 
-static int receive_pkts(struct test_spec *test, struct pollfd *fds)
+static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 {
-	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
-	struct pkt_stream *pkt_stream = test->ifobj_rx->xsk->pkt_stream;
-	struct xsk_socket_info *xsk = test->ifobj_rx->xsk;
+	u32 frags_processed = 0, nb_frags = 0, pkt_len = 0;
 	u32 idx_rx = 0, idx_fq = 0, rcvd, pkts_sent = 0;
+	struct pkt_stream *pkt_stream = xsk->pkt_stream;
 	struct ifobject *ifobj = test->ifobj_rx;
 	struct xsk_umem_info *umem = xsk->umem;
+	struct pollfd fds = { };
 	struct pkt *pkt;
+	u64 first_addr;
 	int ret;
 
-	ret = gettimeofday(&tv_now, NULL);
-	if (ret)
-		exit_with_error(errno);
-	timeradd(&tv_now, &tv_timeout, &tv_end);
-
-	pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
-	while (pkt) {
-		u32 frags_processed = 0, nb_frags = 0, pkt_len = 0;
-		u64 first_addr;
+	fds.fd = xsk_socket__fd(xsk->xsk);
+	fds.events = POLLIN;
 
-		ret = gettimeofday(&tv_now, NULL);
-		if (ret)
-			exit_with_error(errno);
-		if (timercmp(&tv_now, &tv_end, >)) {
-			ksft_print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
-			return TEST_FAILURE;
-		}
+	ret = kick_rx(xsk);
+	if (ret)
+		return TEST_FAILURE;
 
-		ret = kick_rx(xsk);
-		if (ret)
+	if (ifobj->use_poll) {
+		ret = poll(&fds, 1, POLL_TMOUT);
+		if (ret < 0)
 			return TEST_FAILURE;
 
-		if (ifobj->use_poll) {
-			ret = poll(fds, 1, POLL_TMOUT);
-			if (ret < 0)
-				return TEST_FAILURE;
-
-			if (!ret) {
-				if (!is_umem_valid(test->ifobj_tx))
-					return TEST_PASS;
-
-				ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
-				return TEST_FAILURE;
-			}
+		if (!ret) {
+			if (!is_umem_valid(test->ifobj_tx))
+				return TEST_PASS;
 
-			if (!(fds->revents & POLLIN))
-				continue;
+			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
+			return TEST_CONTINUE;
 		}
 
-		rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
-		if (!rcvd)
-			continue;
+		if (!(fds.revents & POLLIN))
+			return TEST_CONTINUE;
+	}
 
-		if (ifobj->use_fill_ring) {
-			ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
-			while (ret != rcvd) {
-				if (xsk_ring_prod__needs_wakeup(&umem->fq)) {
-					ret = poll(fds, 1, POLL_TMOUT);
-					if (ret < 0)
-						return TEST_FAILURE;
-				}
-				ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
+	rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
+	if (!rcvd)
+		return TEST_CONTINUE;
+
+	if (ifobj->use_fill_ring) {
+		ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
+		while (ret != rcvd) {
+			if (xsk_ring_prod__needs_wakeup(&umem->fq)) {
+				ret = poll(&fds, 1, POLL_TMOUT);
+				if (ret < 0)
+					return TEST_FAILURE;
 			}
+			ret = xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
 		}
+	}
 
-		while (frags_processed < rcvd) {
-			const struct xdp_desc *desc = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++);
-			u64 addr = desc->addr, orig;
+	while (frags_processed < rcvd) {
+		const struct xdp_desc *desc = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++);
+		u64 addr = desc->addr, orig;
 
-			orig = xsk_umem__extract_addr(addr);
-			addr = xsk_umem__add_offset_to_addr(addr);
+		orig = xsk_umem__extract_addr(addr);
+		addr = xsk_umem__add_offset_to_addr(addr);
 
+		if (!nb_frags) {
+			pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
 			if (!pkt) {
 				ksft_print_msg("[%s] received too many packets addr: %lx len %u\n",
 					       __func__, addr, desc->len);
 				return TEST_FAILURE;
 			}
+		}
 
-			print_verbose("Rx: addr: %lx len: %u options: %u pkt_nb: %u valid: %u\n",
-				      addr, desc->len, desc->options, pkt->pkt_nb, pkt->valid);
+		print_verbose("Rx: addr: %lx len: %u options: %u pkt_nb: %u valid: %u\n",
+			      addr, desc->len, desc->options, pkt->pkt_nb, pkt->valid);
 
-			if (!is_frag_valid(umem, addr, desc->len, pkt->pkt_nb, pkt_len) ||
-			    !is_offset_correct(umem, pkt, addr) ||
-			    (ifobj->use_metadata && !is_metadata_correct(pkt, umem->buffer, addr)))
-				return TEST_FAILURE;
+		if (!is_frag_valid(umem, addr, desc->len, pkt->pkt_nb, pkt_len) ||
+		    !is_offset_correct(umem, pkt, addr) || (ifobj->use_metadata &&
+		    !is_metadata_correct(pkt, umem->buffer, addr)))
+			return TEST_FAILURE;
 
-			if (!nb_frags++)
-				first_addr = addr;
-			frags_processed++;
-			pkt_len += desc->len;
-			if (ifobj->use_fill_ring)
-				*xsk_ring_prod__fill_addr(&umem->fq, idx_fq++) = orig;
+		if (!nb_frags++)
+			first_addr = addr;
+		frags_processed++;
+		pkt_len += desc->len;
+		if (ifobj->use_fill_ring)
+			*xsk_ring_prod__fill_addr(&umem->fq, idx_fq++) = orig;
 
-			if (pkt_continues(desc->options))
-				continue;
+		if (pkt_continues(desc->options))
+			continue;
 
-			/* The complete packet has been received */
-			if (!is_pkt_valid(pkt, umem->buffer, first_addr, pkt_len) ||
-			    !is_offset_correct(umem, pkt, addr))
-				return TEST_FAILURE;
+		/* The complete packet has been received */
+		if (!is_pkt_valid(pkt, umem->buffer, first_addr, pkt_len) ||
+		    !is_offset_correct(umem, pkt, addr))
+			return TEST_FAILURE;
 
-			pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
-			nb_frags = 0;
-			pkt_len = 0;
-		}
+		pkt_stream->nb_rx_pkts++;
+		nb_frags = 0;
+		pkt_len = 0;
+	}
 
-		if (nb_frags) {
-			/* In the middle of a packet. Start over from beginning of packet. */
-			idx_rx -= nb_frags;
-			xsk_ring_cons__cancel(&xsk->rx, nb_frags);
-			if (ifobj->use_fill_ring) {
-				idx_fq -= nb_frags;
-				xsk_ring_prod__cancel(&umem->fq, nb_frags);
-			}
-			frags_processed -= nb_frags;
+	if (nb_frags) {
+		/* In the middle of a packet. Start over from beginning of packet. */
+		idx_rx -= nb_frags;
+		xsk_ring_cons__cancel(&xsk->rx, nb_frags);
+		if (ifobj->use_fill_ring) {
+			idx_fq -= nb_frags;
+			xsk_ring_prod__cancel(&umem->fq, nb_frags);
 		}
+		frags_processed -= nb_frags;
+	}
 
-		if (ifobj->use_fill_ring)
-			xsk_ring_prod__submit(&umem->fq, frags_processed);
-		if (ifobj->release_rx)
-			xsk_ring_cons__release(&xsk->rx, frags_processed);
+	if (ifobj->use_fill_ring)
+		xsk_ring_prod__submit(&umem->fq, frags_processed);
+	if (ifobj->release_rx)
+		xsk_ring_cons__release(&xsk->rx, frags_processed);
+
+	pthread_mutex_lock(&pacing_mutex);
+	pkts_in_flight -= pkts_sent;
+	pthread_mutex_unlock(&pacing_mutex);
+	pkts_sent = 0;
+
+return TEST_CONTINUE;
+}
+
+bool all_packets_received(struct test_spec *test, struct xsk_socket_info *xsk, u32 sock_num,
+			  unsigned long *bitmap)
+{
+	struct pkt_stream *pkt_stream = xsk->pkt_stream;
+
+	if (!pkt_stream) {
+		__set_bit(sock_num, bitmap);
+		return false;
+	}
+
+	if (pkt_stream->nb_rx_pkts == pkt_stream->nb_valid_entries) {
+		__set_bit(sock_num, bitmap);
+		if (bitmap_full(bitmap, test->nb_sockets))
+			return true;
+	}
+
+	return false;
+}
+
+static int receive_pkts(struct test_spec *test)
+{
+	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	DECLARE_BITMAP(bitmap, test->nb_sockets);
+	u32 sock_num = 0;
+	int res, ret;
+
+	ret = gettimeofday(&tv_now, NULL);
+	if (ret)
+		exit_with_error(errno);
+
+	timeradd(&tv_now, &tv_timeout, &tv_end);
+
+	while (1) {
+		sock_num = (sock_num + 1) % test->nb_sockets;
+
+		struct xsk_socket_info *xsk = &test->ifobj_rx->xsk_arr[sock_num];
+
+		if ((all_packets_received(test, xsk, sock_num, bitmap)))
+			break;
+
+		res = __receive_pkts(test, xsk);
+		if (!(res == TEST_PASS || res == TEST_CONTINUE))
+			return res;
+
+		ret = gettimeofday(&tv_now, NULL);
+		if (ret)
+			exit_with_error(errno);
 
-		pthread_mutex_lock(&pacing_mutex);
-		pkts_in_flight -= pkts_sent;
-		pthread_mutex_unlock(&pacing_mutex);
-		pkts_sent = 0;
+		if (timercmp(&tv_now, &tv_end, >)) {
+			ksft_print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
+			return TEST_FAILURE;
+		}
 	}
 
 	return TEST_PASS;
@@ -1567,7 +1624,6 @@ static void *worker_testapp_validate_rx(void *arg)
 {
 	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_rx;
-	struct pollfd fds = { };
 	int err;
 
 	if (test->current_step == 1) {
@@ -1582,12 +1638,9 @@ static void *worker_testapp_validate_rx(void *arg)
 		}
 	}
 
-	fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
-	fds.events = POLLIN;
-
 	pthread_barrier_wait(&barr);
 
-	err = receive_pkts(test, &fds);
+	err = receive_pkts(test);
 
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
@@ -1724,9 +1777,15 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
+		u32 i;
+
 		if (ifobj2)
-			xsk_socket__delete(ifobj2->xsk->xsk);
-		xsk_socket__delete(ifobj1->xsk->xsk);
+			for (i = 0; i < test->nb_sockets; i++)
+				xsk_socket__delete(ifobj2->xsk_arr[i].xsk);
+
+		for (i = 0; i < test->nb_sockets; i++)
+			xsk_socket__delete(ifobj1->xsk_arr[i].xsk);
+
 		testapp_clean_xsk_umem(ifobj1);
 		if (ifobj2 && !ifobj2->shared_umem)
 			testapp_clean_xsk_umem(ifobj2);
@@ -1798,16 +1857,18 @@ static int testapp_bidirectional(struct test_spec *test)
 	return res;
 }
 
-static int swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
+static int swap_xsk_resources(struct test_spec *test)
 {
 	int ret;
 
-	xsk_socket__delete(ifobj_tx->xsk->xsk);
-	xsk_socket__delete(ifobj_rx->xsk->xsk);
-	ifobj_tx->xsk = &ifobj_tx->xsk_arr[1];
-	ifobj_rx->xsk = &ifobj_rx->xsk_arr[1];
+	test->ifobj_tx->xsk_arr[0].pkt_stream = NULL;
+	test->ifobj_rx->xsk_arr[0].pkt_stream = NULL;
+	test->ifobj_tx->xsk_arr[1].pkt_stream = test->tx_pkt_stream_default;
+	test->ifobj_rx->xsk_arr[1].pkt_stream = test->rx_pkt_stream_default;
+	test->ifobj_tx->xsk = &test->ifobj_tx->xsk_arr[1];
+	test->ifobj_rx->xsk = &test->ifobj_rx->xsk_arr[1];
 
-	ret = xsk_update_xskmap(ifobj_rx->xskmap, ifobj_rx->xsk->xsk);
+	ret = xsk_update_xskmap(test->ifobj_rx->xskmap, test->ifobj_rx->xsk->xsk);
 	if (ret)
 		return TEST_FAILURE;
 
@@ -1821,7 +1882,7 @@ static int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	if (swap_xsk_resources(test->ifobj_tx, test->ifobj_rx))
+	if (swap_xsk_resources(test))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 3d494adef792..fa409285eafd 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -108,6 +108,8 @@ struct pkt_stream {
 	u32 current_pkt_nb;
 	struct pkt *pkts;
 	u32 max_pkt_len;
+	u32 nb_rx_pkts;
+	u32 nb_valid_entries;
 	bool verbatim;
 };
 
-- 
2.34.1


