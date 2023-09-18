Return-Path: <bpf+bounces-10266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD107A45A3
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C803281E69
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9411C2A2;
	Mon, 18 Sep 2023 09:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D71C28D;
	Mon, 18 Sep 2023 09:12:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53671C5;
	Mon, 18 Sep 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028328; x=1726564328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=129fu0935MKoN/Wh+T51K9a2kkrCmK8qnRNT33n1H9k=;
  b=m0y39dOP4hQ2R36aqvr5piduh7XNoxu4PWN4qcmXctjm06IhJcIx18er
   K8MnuT5Tj3lqxCrXyQPdEOJse1nByKgDQ/kmdpOW50i/dghBfpr8Dy/MX
   KbEbfZ+lm8gBfOuqmfZbaRpO3zvKyc6TIcwPEwyZF/yZDyuIgMTm6KDoX
   dssDPTN95MNjm/B/yZPR7R4WE6lLcrPC0yx9RntDhsFLcmC37dYSsw/RF
   coYgWFBO5FHG6AHlqFxAmJWZ2hl7jQ5id/V/jNH3GZn7XVah0SnqK1Frp
   e/mGXVVA2F7gzabXiIBQJrRBil7ZofaPWoGD5SDw+BMYFbrj57bYqjxkI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364647924"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364647924"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815949992"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815949992"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:04 -0700
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
Subject: [PATCH bpf-next 3/8] selftests/xsk: implement a function that generates MAC addresses
Date: Mon, 18 Sep 2023 15:02:59 +0530
Message-Id: <20230918093304.367826-4-tushar.vyavahare@intel.com>
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

Move the src_mac and dst_mac fields from the ifobject structure to the
xsk_socket_info structure to achieve per-socket MAC address assignment.
Implement the function called generate_mac_addresses() to generate MAC
addresses based on the required number by the framework.

Require this in order to steer traffic to various sockets in subsequent
patches.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 45 ++++++++++++++----------
 tools/testing/selftests/bpf/xskxceiver.h |  8 +++--
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index ad1f7f078f5f..9f241f503eed 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -104,9 +104,6 @@
 #include "../kselftest.h"
 #include "xsk_xdp_common.h"
 
-static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
-static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
-
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
@@ -145,6 +142,18 @@ static void report_failure(struct test_spec *test)
 	test->fail = true;
 }
 
+static void generate_mac_addresses(const u8 *g_mac, u32 num_macs)
+{
+	u32 i, j;
+
+	for (i = 0; i < num_macs; i++) {
+		for (j = 0; j < ETH_ALEN; j++)
+			macs[i][j] = g_mac[j];
+
+		macs[i][ETH_ALEN - 1] += i;
+	}
+}
+
 /* The payload is a word consisting of a packet sequence number in the upper
  * 16-bits and a intra packet data sequence number in the lower 16 bits. So the 3rd packet's
  * 5th word of data will contain the number (2<<16) | 4 as they are numbered from 0.
@@ -159,10 +168,10 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
 		ptr[i] = htonl(pkt_nb << 16 | (i + start));
 }
 
-static void gen_eth_hdr(struct ifobject *ifobject, struct ethhdr *eth_hdr)
+static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
 {
-	memcpy(eth_hdr->h_dest, ifobject->dst_mac, ETH_ALEN);
-	memcpy(eth_hdr->h_source, ifobject->src_mac, ETH_ALEN);
+	memcpy(eth_hdr->h_dest, xsk->dst_mac, ETH_ALEN);
+	memcpy(eth_hdr->h_source, xsk->src_mac, ETH_ALEN);
 	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
 }
 
@@ -445,6 +454,9 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 				ifobj->xsk_arr[j].pkt_stream = test->tx_pkt_stream_default;
 			else
 				ifobj->xsk_arr[j].pkt_stream = test->rx_pkt_stream_default;
+
+			memcpy(ifobj->xsk_arr[j].src_mac, macs[j * 2 + i % 2], ETH_ALEN);
+			memcpy(ifobj->xsk_arr[j].dst_mac, macs[j * 2 + (i + 1) % 2], ETH_ALEN);
 		}
 	}
 
@@ -726,16 +738,16 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
 	pkt_stream->current_pkt_nb--;
 }
 
-static void pkt_generate(struct ifobject *ifobject, u64 addr, u32 len, u32 pkt_nb,
-			 u32 bytes_written)
+static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
+			 u32 pkt_nb, u32 bytes_written)
 {
-	void *data = xsk_umem__get_data(ifobject->umem->buffer, addr);
+	void *data = xsk_umem__get_data(umem->buffer, addr);
 
 	if (len < MIN_PKT_SIZE)
 		return;
 
 	if (!bytes_written) {
-		gen_eth_hdr(ifobject, data);
+		gen_eth_hdr(xsk, data);
 
 		len -= PKT_HDR_SIZE;
 		data += PKT_HDR_SIZE;
@@ -1209,7 +1221,7 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 				tx_desc->options = 0;
 			}
 			if (pkt->valid)
-				pkt_generate(ifobject, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
+				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
 					     bytes_written);
 			bytes_written += tx_desc->len;
 
@@ -2120,15 +2132,11 @@ static bool hugepages_present(void)
 	return true;
 }
 
-static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *src_mac,
-		       thread_func_t func_ptr)
+static void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
 	int err;
 
-	memcpy(ifobj->dst_mac, dst_mac, ETH_ALEN);
-	memcpy(ifobj->src_mac, src_mac, ETH_ALEN);
-
 	ifobj->func_ptr = func_ptr;
 
 	err = xsk_load_xdp_programs(ifobj);
@@ -2391,6 +2399,7 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
+	generate_mac_addresses(g_mac, NUM_MAC_ADDRESSES);
 	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
 	ifobj_tx->shared_umem = shared_netdev;
 	ifobj_rx->shared_umem = shared_netdev;
@@ -2404,8 +2413,8 @@ int main(int argc, char **argv)
 			modes++;
 	}
 
-	init_iface(ifobj_rx, MAC1, MAC2, worker_testapp_validate_rx);
-	init_iface(ifobj_tx, MAC2, MAC1, worker_testapp_validate_tx);
+	init_iface(ifobj_rx, worker_testapp_validate_rx);
+	init_iface(ifobj_tx, worker_testapp_validate_tx);
 
 	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
 	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 06b82b39c59c..e003f9ca4692 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -59,6 +59,7 @@
 #define HUGEPAGE_SIZE (2 * 1024 * 1024)
 #define PKT_DUMP_NB_TO_PRINT 16
 #define RUN_ALL_TESTS UINT_MAX
+#define NUM_MAC_ADDRESSES 4
 
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 
@@ -90,6 +91,8 @@ struct xsk_socket_info {
 	struct pkt_stream *pkt_stream;
 	u32 outstanding_tx;
 	u32 rxqsize;
+	u8 dst_mac[ETH_ALEN];
+	u8 src_mac[ETH_ALEN];
 };
 
 struct pkt {
@@ -140,8 +143,6 @@ struct ifobject {
 	bool unaligned_supp;
 	bool multi_buff_supp;
 	bool multi_buff_zc_supp;
-	u8 dst_mac[ETH_ALEN];
-	u8 src_mac[ETH_ALEN];
 };
 
 struct test_spec {
@@ -168,4 +169,7 @@ pthread_mutex_t pacing_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 int pkts_in_flight;
 
+static const u8 g_mac[] = {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
+static u8 macs[NUM_MAC_ADDRESSES][ETH_ALEN] = {0};
+
 #endif				/* XSKXCEIVER_H_ */
-- 
2.34.1


