Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1340730D4C5
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhBCINK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 03:13:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:59616 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232665AbhBCIMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 03:12:53 -0500
IronPort-SDR: EbRQ2N+sMA1mrxXdBVJ8I/5fstt0LzQsn1IGBOLvp4kSEezhUAJ8uGgGnB4i2uo3Zn8Qf9QeRj
 28mFgmPvcqKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160170071"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="160170071"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:11:39 -0800
IronPort-SDR: MnbekqiMe+eUxo/ZJ4Dc6u292w7O6qrXn1Io2/dbR8McIEzzLID6vn0W0pgCK8zbRpctGKi/Hl
 ZwdtdNtMtIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="413932488"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.142])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2021 00:11:37 -0800
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, bjorn@kernel.org,
        weqaar.a.janjua@intel.com
Cc:     daniel@iogearbox.net, Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: XSK_TRACE_INVALID_DESC_TX test
Date:   Wed,  3 Feb 2021 07:41:27 +0000
Message-Id: <20210203074127.8616-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203074127.8616-1-ciara.loftus@intel.com>
References: <20210203074127.8616-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test sets the length of tx descriptors to an invalid
value. When the kernel tries to transmit these descriptors,
error traces are expected which look like so:

xsk_packet_drop: netdev: ve9266 qid 0 reason: invalid tx desc: \
  addr 258048 len 4097 options 0

The test validates that these traces were successfully generated.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 24 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xdpxceiver.c | 22 ++++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index bc026da25d54..4e654eb0a595 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -295,6 +295,30 @@ retval=$?
 test_status $retval "${TEST_NAME}"
 statusList+=($retval)
 
+### TEST 14
+TEST_NAME="SKB TRACE INVALID_DESC_TX"
+
+vethXDPgeneric ${VETH0} ${VETH1} ${NS1}
+
+params=("-S" "-t" "2" "-C" "${TRACEPKTS}")
+execxdpxceiver params
+
+retval=$?
+test_status $retval "${TEST_NAME}"
+statusList+=($retval)
+
+### TEST 15
+TEST_NAME="DRV TRACE INVALID_DESC_TX"
+
+vethXDPnative ${VETH0} ${VETH1} ${NS1}
+
+params=("-N" "-t" "2" "-C" "${TRACEPKTS}")
+execxdpxceiver params
+
+retval=$?
+test_status $retval "${TEST_NAME}"
+statusList+=($retval)
+
 ## END TESTS
 
 cleanup_exit ${VETH0} ${VETH1} ${NS1}
diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index e63dc1c228ed..6cf824a33fdc 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -37,6 +37,8 @@
  *       Increase the headroom size and send packets. Validate traces.
  *    f. Tracing - XSK_TRACE_DROP_INVALID_FILLADDR
  *       Populate the fill queue with invalid addresses. Validate traces.
+ *    g. Tracing - XSK_TRACE_DROP_INVALID_TXD
+ *       Populate the tx descriptors with invalid addresses. Validate traces.
  *
  * 2. AF_XDP DRV/Native mode
  *    Works on any netdevice with XDP_REDIRECT support, driver dependent. Processes
@@ -50,8 +52,9 @@
  *      zero-copy mode
  *    e. Tracing - XSK_TRACE_DROP_PKT_TOO_BIG
  *    f. Tracing - XSK_TRACE_DROP_INVALID_FILLADDR
+ *    g. Tracing - XSK_TRACE_DROP_INVALID_TXD
  *
- * Total tests: 12
+ * Total tests: 14
  *
  * Flow:
  * -----
@@ -560,8 +563,11 @@ static inline void complete_tx_only(struct xsk_socket_info *xsk, int batch_size)
 	if (!xsk->outstanding_tx)
 		return;
 
-	if (!NEED_WAKEUP || xsk_ring_prod__needs_wakeup(&xsk->tx))
+	if (!NEED_WAKEUP || xsk_ring_prod__needs_wakeup(&xsk->tx)) {
 		kick_tx(xsk);
+		if (opt_trace_code == XSK_TRACE_DROP_INVALID_TXD)
+			xsk->outstanding_tx = 0;
+	}
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
 	if (rcvd) {
@@ -632,6 +638,7 @@ static void tx_only(struct xsk_socket_info *xsk, u32 *frameptr, int batch_size)
 {
 	u32 idx;
 	unsigned int i;
+	bool invalid_tx_test = opt_trace_code == XSK_TRACE_DROP_INVALID_TXD;
 
 	while (xsk_ring_prod__reserve(&xsk->tx, batch_size, &idx) < batch_size)
 		complete_tx_only(xsk, batch_size);
@@ -640,7 +647,8 @@ static void tx_only(struct xsk_socket_info *xsk, u32 *frameptr, int batch_size)
 		struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
 
 		tx_desc->addr = (*frameptr + i) << XSK_UMEM__DEFAULT_FRAME_SHIFT;
-		tx_desc->len = PKT_SIZE;
+		tx_desc->len = invalid_tx_test ? XSK_UMEM__DEFAULT_FRAME_SIZE + 1 : PKT_SIZE;
+
 	}
 
 	xsk_ring_prod__submit(&xsk->tx, batch_size);
@@ -1014,7 +1022,10 @@ static void *worker_testapp_validate(void *arg)
 				rx_pkt(ifobject->xsk, fds);
 				worker_pkt_validate();
 			} else {
-				worker_trace_validate(tr_fp, ifobject->ifname);
+				worker_trace_validate(tr_fp,
+					opt_trace_code == XSK_TRACE_DROP_INVALID_TXD ?
+					ifdict[!ifobject->ifdict_index]->ifname :
+					ifobject->ifname);
 			}
 
 			if (sigvar)
@@ -1187,6 +1198,9 @@ int main(int argc, char **argv)
 		case XSK_TRACE_DROP_INVALID_FILLADDR:
 			reason_str = "invalid fill addr";
 			break;
+		case XSK_TRACE_DROP_INVALID_TXD:
+			reason_str = "invalid tx desc";
+			break;
 		default:
 			ksft_test_result_fail("ERROR: unsupported trace %i\n",
 						opt_trace_code);
-- 
2.17.1

