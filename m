Return-Path: <bpf+bounces-10972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547FB7B0573
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 728E61C20B68
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6C34180;
	Wed, 27 Sep 2023 13:31:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2E31A9E;
	Wed, 27 Sep 2023 13:31:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAD126;
	Wed, 27 Sep 2023 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821515; x=1727357515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HhBEFJ1grTJwx6XlI6gwJ82kxBFuJH5rVHwsvnAOcP8=;
  b=mrs7RFbvVzDEuS0Lo7FlV4s4ln/+nnz24Kvv9Lk+4nVotuImDSlRQvh1
   S7jPVhGbqLlrZPo25mio9l0V/ddFnF7Ew70zg6pti7V7GL/17kg7jNQRF
   IRB7wF2+ve4j5bdtXNJt4GuKbbfOzgmzAGPEywG28Y0eNFY4+df67t7M3
   Kin+IASSGgzwISAXx+ZlzK4SF7ugEwZO/M/lkgobYqDiCE7Prc+jvZxwJ
   Nn6eHkuo2g5xX4LlWDlwoZXovY+WL22u1Zdp0T6a2z34HBnJU1K+BjEJI
   CsEsgG+yAw2beq2pjwNbK88x1AgjnC0r2+gRmwbEbVPsWP9Xzs6Fkq6ta
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448316416"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="448316416"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698878970"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698878970"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:31:50 -0700
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
Subject: [PATCH bpf-next v3 6/8] selftests/xsk: iterate over all the sockets in the send pkts function
Date: Wed, 27 Sep 2023 19:22:39 +0530
Message-Id: <20230927135241.2287547-7-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
References: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
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

Update send_pkts() to handle multiple sockets for sending packets.
Multiple TX sockets are utilized alternately based on the batch size for
improve packet transmission.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 57 ++++++++++++++++--------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 57a5126f6182..ce869431556c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1194,13 +1194,13 @@ static int receive_pkts(struct test_spec *test)
 	return TEST_PASS;
 }
 
-static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeout)
+static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
-	struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
-	struct xsk_socket_info *xsk = ifobject->xsk;
+	struct pkt_stream *pkt_stream = xsk->pkt_stream;
 	struct xsk_umem_info *umem = ifobject->umem;
 	bool use_poll = ifobject->use_poll;
+	struct pollfd fds = { };
 	int ret;
 
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
@@ -1212,9 +1212,12 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 		return TEST_CONTINUE;
 	}
 
+	fds.fd = xsk_socket__fd(xsk->xsk);
+	fds.events = POLLOUT;
+
 	while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
 		if (use_poll) {
-			ret = poll(fds, 1, POLL_TMOUT);
+			ret = poll(&fds, 1, POLL_TMOUT);
 			if (timeout) {
 				if (ret < 0) {
 					ksft_print_msg("ERROR: [%s] Poll error %d\n",
@@ -1293,7 +1296,7 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 	xsk->outstanding_tx += valid_frags;
 
 	if (use_poll) {
-		ret = poll(fds, 1, POLL_TMOUT);
+		ret = poll(&fds, 1, POLL_TMOUT);
 		if (ret <= 0) {
 			if (ret == 0 && timeout)
 				return TEST_PASS;
@@ -1339,27 +1342,43 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 	return TEST_PASS;
 }
 
+bool all_packets_sent(struct test_spec *test, unsigned long *bitmap)
+{
+	return bitmap_full(bitmap, test->nb_sockets);
+}
+
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
-	struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
 	bool timeout = !is_umem_valid(test->ifobj_rx);
-	struct pollfd fds = { };
-	u32 ret;
+	DECLARE_BITMAP(bitmap, test->nb_sockets);
+	u32 i, ret;
 
-	fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
-	fds.events = POLLOUT;
+	while (!(all_packets_sent(test, bitmap))) {
+		for (i = 0; i < test->nb_sockets; i++) {
+			struct pkt_stream *pkt_stream;
 
-	while (pkt_stream->current_pkt_nb < pkt_stream->nb_pkts) {
-		ret = __send_pkts(ifobject, &fds, timeout);
-		if (ret == TEST_CONTINUE && !test->fail)
-			continue;
-		if ((ret || test->fail) && !timeout)
-			return TEST_FAILURE;
-		if (ret == TEST_PASS && timeout)
-			return ret;
+			pkt_stream = ifobject->xsk_arr[i].pkt_stream;
+			if (!pkt_stream || pkt_stream->current_pkt_nb >= pkt_stream->nb_pkts) {
+				__set_bit(i, bitmap);
+				continue;
+			}
+			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
+			if (ret == TEST_CONTINUE && !test->fail)
+				continue;
+
+			if ((ret || test->fail) && !timeout)
+				return TEST_FAILURE;
+
+			if (ret == TEST_PASS && timeout)
+				return ret;
+
+			ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
+			if (ret)
+				return TEST_FAILURE;
+		}
 	}
 
-	return wait_for_tx_completion(ifobject->xsk);
+	return TEST_PASS;
 }
 
 static int get_xsk_stats(struct xsk_socket *xsk, struct xdp_statistics *stats)
-- 
2.34.1


