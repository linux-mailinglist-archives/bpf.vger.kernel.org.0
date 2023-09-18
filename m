Return-Path: <bpf+bounces-10264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AE7A4595
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29921C20B8C
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68561154B8;
	Mon, 18 Sep 2023 09:12:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310A15493;
	Mon, 18 Sep 2023 09:12:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260BC5;
	Mon, 18 Sep 2023 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028318; x=1726564318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWttYP/kF59pYAkUnLyBOhAUgMjjfnpJEQXByRoiAUM=;
  b=E2EfWPRX+e3mwc9X0wNyVH6QJ8TefCzpmr8f855TB/P6hwATm7dlWDnm
   8YtiLJk7YYA0wnufYaMzNcxiOOPiD3gmtJuylx0ut6F8o0LYO/B29orzK
   XabTlV9GbuFBgOtFFlk6DvkWaKJ2ziSApDJyYnlVrNXKlP6n0wRRpIk5U
   PGc6z4NztJmIIrx6ECzW6fxNBuTHyoOFMo75niP2mMZJAgX0PlMC5853S
   eezr8ud+ozUnpfyJPbsORr7oi/rhuIRxIpxYSt2WLQLIqNjcxdgMc2QVm
   t6guHKmU4lJ/hhID0xg+797zAkbib7wSN8Ok64rjEMw6yEIEh88m62Ln5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364647899"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364647899"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815949967"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815949967"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:11:54 -0700
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
Subject: [PATCH bpf-next 1/8] selftests/xsk: move pkt_stream to the xsk_socket_info
Date: Mon, 18 Sep 2023 15:02:57 +0530
Message-Id: <20230918093304.367826-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918093304.367826-1-tushar.vyavahare@intel.com>
References: <20230918093304.367826-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the packet stream from the ifobject struct to the xsk_socket_info
struct to enable the use of different streams for different sockets. This
will facilitate the sending and receiving of data from multiple sockets
simultaneously using the SHARED_XDP_UMEM feature.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 71 ++++++++++++------------
 tools/testing/selftests/bpf/xskxceiver.h |  2 +-
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 43e0a5796929..16a09751b093 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -260,7 +260,7 @@ static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_i
 	cfg.bind_flags = ifobject->bind_flags;
 	if (shared)
 		cfg.bind_flags |= XDP_SHARED_UMEM;
-	if (ifobject->pkt_stream && ifobject->mtu > MAX_ETH_PKT_SIZE)
+	if (ifobject->mtu > MAX_ETH_PKT_SIZE)
 		cfg.bind_flags |= XDP_USE_SG;
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
@@ -429,11 +429,9 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		if (i == 0) {
 			ifobj->rx_on = false;
 			ifobj->tx_on = true;
-			ifobj->pkt_stream = test->tx_pkt_stream_default;
 		} else {
 			ifobj->rx_on = true;
 			ifobj->tx_on = false;
-			ifobj->pkt_stream = test->rx_pkt_stream_default;
 		}
 
 		memset(ifobj->umem, 0, sizeof(*ifobj->umem));
@@ -443,6 +441,10 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		for (j = 0; j < MAX_SOCKETS; j++) {
 			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
 			ifobj->xsk_arr[j].rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+			if (i == 0)
+				ifobj->xsk_arr[j].pkt_stream = test->tx_pkt_stream_default;
+			else
+				ifobj->xsk_arr[j].pkt_stream = test->rx_pkt_stream_default;
 		}
 	}
 
@@ -557,17 +559,17 @@ static void pkt_stream_delete(struct pkt_stream *pkt_stream)
 
 static void pkt_stream_restore_default(struct test_spec *test)
 {
-	struct pkt_stream *tx_pkt_stream = test->ifobj_tx->pkt_stream;
-	struct pkt_stream *rx_pkt_stream = test->ifobj_rx->pkt_stream;
+	struct pkt_stream *tx_pkt_stream = test->ifobj_tx->xsk->pkt_stream;
+	struct pkt_stream *rx_pkt_stream = test->ifobj_rx->xsk->pkt_stream;
 
 	if (tx_pkt_stream != test->tx_pkt_stream_default) {
-		pkt_stream_delete(test->ifobj_tx->pkt_stream);
-		test->ifobj_tx->pkt_stream = test->tx_pkt_stream_default;
+		pkt_stream_delete(test->ifobj_tx->xsk->pkt_stream);
+		test->ifobj_tx->xsk->pkt_stream = test->tx_pkt_stream_default;
 	}
 
 	if (rx_pkt_stream != test->rx_pkt_stream_default) {
-		pkt_stream_delete(test->ifobj_rx->pkt_stream);
-		test->ifobj_rx->pkt_stream = test->rx_pkt_stream_default;
+		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
+		test->ifobj_rx->xsk->pkt_stream = test->rx_pkt_stream_default;
 	}
 }
 
@@ -674,9 +676,9 @@ static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
 	struct pkt_stream *pkt_stream;
 
 	pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, nb_pkts, pkt_len);
-	test->ifobj_tx->pkt_stream = pkt_stream;
+	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
 	pkt_stream = pkt_stream_generate(test->ifobj_rx->umem, nb_pkts, pkt_len);
-	test->ifobj_rx->pkt_stream = pkt_stream;
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
 }
 
 static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
@@ -686,11 +688,11 @@ static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
 	struct pkt_stream *pkt_stream;
 	u32 i;
 
-	pkt_stream = pkt_stream_clone(umem, ifobj->pkt_stream);
-	for (i = 1; i < ifobj->pkt_stream->nb_pkts; i += 2)
+	pkt_stream = pkt_stream_clone(umem, ifobj->xsk->pkt_stream);
+	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
 		pkt_set(umem, &pkt_stream->pkts[i], offset, pkt_len);
 
-	ifobj->pkt_stream = pkt_stream;
+	ifobj->xsk->pkt_stream = pkt_stream;
 }
 
 static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
@@ -702,12 +704,12 @@ static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int off
 static void pkt_stream_receive_half(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_rx->umem;
-	struct pkt_stream *pkt_stream = test->ifobj_tx->pkt_stream;
+	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
 	u32 i;
 
-	test->ifobj_rx->pkt_stream = pkt_stream_generate(umem, pkt_stream->nb_pkts,
-							 pkt_stream->pkts[0].len);
-	pkt_stream = test->ifobj_rx->pkt_stream;
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(umem, pkt_stream->nb_pkts,
+							      pkt_stream->pkts[0].len);
+	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
 	for (i = 1; i < pkt_stream->nb_pkts; i += 2)
 		pkt_stream->pkts[i].valid = false;
 }
@@ -796,10 +798,10 @@ static void pkt_stream_generate_custom(struct test_spec *test, struct pkt *pkts,
 	struct pkt_stream *pkt_stream;
 
 	pkt_stream = __pkt_stream_generate_custom(test->ifobj_tx, pkts, nb_pkts, true);
-	test->ifobj_tx->pkt_stream = pkt_stream;
+	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
 
 	pkt_stream = __pkt_stream_generate_custom(test->ifobj_rx, pkts, nb_pkts, false);
-	test->ifobj_rx->pkt_stream = pkt_stream;
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
 }
 
 static void pkt_print_data(u32 *data, u32 cnt)
@@ -1007,7 +1009,7 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 static int receive_pkts(struct test_spec *test, struct pollfd *fds)
 {
 	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
-	struct pkt_stream *pkt_stream = test->ifobj_rx->pkt_stream;
+	struct pkt_stream *pkt_stream = test->ifobj_rx->xsk->pkt_stream;
 	struct xsk_socket_info *xsk = test->ifobj_rx->xsk;
 	u32 idx_rx = 0, idx_fq = 0, rcvd, pkts_sent = 0;
 	struct ifobject *ifobj = test->ifobj_rx;
@@ -1139,7 +1141,7 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
 static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
-	struct pkt_stream *pkt_stream = ifobject->pkt_stream;
+	struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
 	struct xsk_socket_info *xsk = ifobject->xsk;
 	struct xsk_umem_info *umem = ifobject->umem;
 	bool use_poll = ifobject->use_poll;
@@ -1283,7 +1285,7 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
-	struct pkt_stream *pkt_stream = ifobject->pkt_stream;
+	struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
 	bool timeout = !is_umem_valid(test->ifobj_rx);
 	struct pollfd fds = { };
 	u32 ret;
@@ -1347,8 +1349,8 @@ static int validate_rx_dropped(struct ifobject *ifobject)
 	 * packet being invalid). Since the last packet may or may not have
 	 * been dropped already, both outcomes must be allowed.
 	 */
-	if (stats.rx_dropped == ifobject->pkt_stream->nb_pkts / 2 ||
-	    stats.rx_dropped == ifobject->pkt_stream->nb_pkts / 2 - 1)
+	if (stats.rx_dropped == ifobject->xsk->pkt_stream->nb_pkts / 2 ||
+	    stats.rx_dropped == ifobject->xsk->pkt_stream->nb_pkts / 2 - 1)
 		return TEST_PASS;
 
 	return TEST_FAILURE;
@@ -1412,9 +1414,10 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 		return TEST_FAILURE;
 	}
 
-	if (stats.tx_invalid_descs != ifobject->pkt_stream->nb_pkts / 2) {
+	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
 		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
-			       __func__, stats.tx_invalid_descs, ifobject->pkt_stream->nb_pkts);
+			       __func__, stats.tx_invalid_descs,
+			       ifobject->xsk->pkt_stream->nb_pkts);
 		return TEST_FAILURE;
 	}
 
@@ -1528,7 +1531,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (!ifobject->rx_on)
 		return;
 
-	xsk_populate_fill_ring(ifobject->umem, ifobject->pkt_stream, ifobject->use_fill_ring);
+	xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream, ifobject->use_fill_ring);
 
 	ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
 	if (ret)
@@ -1691,11 +1694,11 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	if (ifobj2) {
 		if (pthread_barrier_init(&barr, NULL, 2))
 			exit_with_error(errno);
-		pkt_stream_reset(ifobj2->pkt_stream);
+		pkt_stream_reset(ifobj2->xsk->pkt_stream);
 	}
 
 	test->current_step++;
-	pkt_stream_reset(ifobj1->pkt_stream);
+	pkt_stream_reset(ifobj1->xsk->pkt_stream);
 	pkts_in_flight = 0;
 
 	signal(SIGUSR1, handler);
@@ -1852,8 +1855,8 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
 static int testapp_stats_rx_full(struct test_spec *test)
 {
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
-	test->ifobj_rx->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
-							 DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
+							      DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
 	test->ifobj_rx->release_rx = false;
@@ -1864,8 +1867,8 @@ static int testapp_stats_rx_full(struct test_spec *test)
 static int testapp_stats_fill_empty(struct test_spec *test)
 {
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
-	test->ifobj_rx->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
-							 DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
+							      DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->use_fill_ring = false;
 	test->ifobj_rx->validation_func = validate_fill_empty;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 8015aeea839d..06b82b39c59c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -87,6 +87,7 @@ struct xsk_socket_info {
 	struct xsk_ring_prod tx;
 	struct xsk_umem_info *umem;
 	struct xsk_socket *xsk;
+	struct pkt_stream *pkt_stream;
 	u32 outstanding_tx;
 	u32 rxqsize;
 };
@@ -120,7 +121,6 @@ struct ifobject {
 	struct xsk_umem_info *umem;
 	thread_func_t func_ptr;
 	validation_func_t validation_func;
-	struct pkt_stream *pkt_stream;
 	struct xsk_xdp_progs *xdp_progs;
 	struct bpf_map *xskmap;
 	struct bpf_program *xdp_prog;
-- 
2.34.1


