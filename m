Return-Path: <bpf+bounces-10269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E27A45B1
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586631C210B6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF81C692;
	Mon, 18 Sep 2023 09:12:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF191C68D;
	Mon, 18 Sep 2023 09:12:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC1D1;
	Mon, 18 Sep 2023 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028344; x=1726564344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0W3sSMs/Ftaa33bowMzNo7vJwcrmOy74CE4Ab7L0+JQ=;
  b=kSDnF2/wgGESSOr/81tzzIhkTDb+d6W0sHubXLYJwfSjduv19ZVjDzPY
   lkKWNGOOy/vuNWqP1JHo+g6r/UeQqc4WTP/vrH5MMXYE2CLpAiIB0wvqo
   gcq+BSsbULH4ffPlMXomzM5Bb1XIMcbOnSydNO/EZ/jA+D56QdLQ65TIQ
   kXB0LavVnHO7t7W735Idkxh3mHsOVk0xaMPNBsCERDyLlbHjghup5OgKu
   9dy9BRuwnjYwrU9tUrYXrj01ue4nMTKOdLsbRSUhecqJd80JUNvclbf35
   4sg0UZuzzzOhmHYzd2TKiwLwbN00suVSNPg1zcAzZP6eunoWGS2JB6HRs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364647996"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364647996"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815950047"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815950047"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:20 -0700
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
Subject: [PATCH bpf-next 6/8] selftests/xsk: iterate over all the sockets in the send pkts function
Date: Mon, 18 Sep 2023 15:03:02 +0530
Message-Id: <20230918093304.367826-7-tushar.vyavahare@intel.com>
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

Update send_pkts() to handle multiple sockets for sending packets.
Multiple TX sockets are utilized alternately based on the batch size for
improve packet transmission.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 64 +++++++++++++++++-------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index e67032f04a74..0ef0575c095c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1204,13 +1204,13 @@ static int receive_pkts(struct test_spec *test)
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
@@ -1222,9 +1222,12 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
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
@@ -1303,7 +1306,7 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 	xsk->outstanding_tx += valid_frags;
 
 	if (use_poll) {
-		ret = poll(fds, 1, POLL_TMOUT);
+		ret = poll(&fds, 1, POLL_TMOUT);
 		if (ret <= 0) {
 			if (ret == 0 && timeout)
 				return TEST_PASS;
@@ -1349,27 +1352,50 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 	return TEST_PASS;
 }
 
+bool all_packets_sent(struct test_spec *test, unsigned long *bitmap)
+{
+	if (test_bit(test->nb_sockets, bitmap))
+		return true;
+
+	return false;
+}
+
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
-	struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
 	bool timeout = !is_umem_valid(test->ifobj_rx);
-	struct pollfd fds = { };
-	u32 ret;
+	u32 i, ret;
 
-	fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
-	fds.events = POLLOUT;
+	DECLARE_BITMAP(bitmap, MAX_SOCKETS);
 
-	while (pkt_stream->current_pkt_nb < pkt_stream->nb_pkts) {
-		ret = __send_pkts(ifobject, &fds, timeout);
-		if (ret == TEST_CONTINUE && !test->fail)
-			continue;
-		if ((ret || test->fail) && !timeout)
-			return TEST_FAILURE;
-		if (ret == TEST_PASS && timeout)
-			return ret;
+	while (!(all_packets_sent(test, bitmap))) {
+		for (i = 0; i < test->nb_sockets; i++) {
+			struct pkt_stream *pkt_stream;
+
+			pkt_stream = ifobject->xsk_arr[i].pkt_stream;
+			if (!pkt_stream || pkt_stream->current_pkt_nb >= pkt_stream->nb_pkts) {
+				__test_and_set_bit((1 << i), bitmap);
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
+			if ((ret || test->fail) && !timeout)
+				return TEST_FAILURE;
+
+			if (ret == TEST_PASS && timeout)
+				return ret;
+		}
 	}
 
-	return wait_for_tx_completion(ifobject->xsk);
+	return TEST_PASS;
 }
 
 static int get_xsk_stats(struct xsk_socket *xsk, struct xdp_statistics *stats)
-- 
2.34.1


