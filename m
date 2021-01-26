Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1A3046DE
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbhAZRTU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 12:19:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:62057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390019AbhAZI2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 03:28:19 -0500
IronPort-SDR: d/FSdgKqA85MgAVmenr/I2sdKNZ2YIzBIG7mVi0YZCu+tIqBMBnTHPwUrcMkVLoB1Viee/3faq
 H6bSYXD1qsZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177298558"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="177298558"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:22:42 -0800
IronPort-SDR: NDXhNNEkrEwtBVjMJbHmxnY6zHE58njexKdnEcOd4dPhpcsA/whi9wUny8VObvxjwwx8AL8ao5
 /fh0iIO7oHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="361901162"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.142])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2021 00:22:32 -0800
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, bjorn@kernel.org,
        weqaar.a.janjua@intel.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: XSK_TRACE_DROP_PKT_TOO_BIG test
Date:   Tue, 26 Jan 2021 07:52:38 +0000
Message-Id: <20210126075239.25378-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126075239.25378-1-ciara.loftus@intel.com>
References: <20210126075239.25378-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test increases the UMEM headroom to a size that
will cause packets to be dropped. Traces which report
these drops are expected. The test validates that these
traces were successfully generated.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 24 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xdpxceiver.c | 21 +++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index a085ef0602a7..95ceee151de1 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -271,6 +271,30 @@ retval=$?
 test_status $retval "${TEST_NAME}"
 statusList+=($retval)
 
+### TEST 12
+TEST_NAME="SKB TRACE DROP PKT_TOO_BIG"
+
+vethXDPgeneric ${VETH0} ${VETH1} ${NS1}
+
+params=("-S" "-t" "1" "-C" "${TRACEPKTS}")
+execxdpxceiver params
+
+retval=$?
+test_status $retval "${TEST_NAME}"
+statusList+=($retval)
+
+### TEST 13
+TEST_NAME="DRV TRACE DROP PKT_TOO_BIG"
+
+vethXDPnative ${VETH0} ${VETH1} ${NS1}
+
+params=("-N" "-t" "1" "-C" "${TRACEPKTS}")
+execxdpxceiver params
+
+retval=$?
+test_status $retval "${TEST_NAME}"
+statusList+=($retval)
+
 ## END TESTS
 
 cleanup_exit ${VETH0} ${VETH1} ${NS1}
diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 56bf87d41ab5..bee10bb686fc 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -35,6 +35,8 @@
  *       mode is used
  *    e. Tracing - XSK_TRACE_DROP_RXQ_FULL
  *       Reduce the RXQ size and do not read from it. Validate traces.
+ *    f. Tracing - XSK_TRACE_DROP_PKT_TOO_BIG
+ *       Increase the headroom size and send packets. Validate traces.
  *
  * 2. AF_XDP DRV/Native mode
  *    Works on any netdevice with XDP_REDIRECT support, driver dependent. Processes
@@ -47,8 +49,9 @@
  *    - Only copy mode is supported because veth does not currently support
  *      zero-copy mode
  *    e. Tracing - XSK_TRACE_DROP_RXQ_FULL
+ *    f. Tracing - XSK_TRACE_DROP_PKT_TOO_BIG
  *
- * Total tests: 10
+ * Total tests: 12
  *
  * Flow:
  * -----
@@ -275,13 +278,23 @@ static void gen_eth_frame(struct xsk_umem_info *umem, u64 addr)
 static void xsk_configure_umem(struct ifobject *data, void *buffer, u64 size)
 {
 	int ret;
+	struct xsk_umem_config cfg = {
+		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
+		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
+		.frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM,
+		.flags = XSK_UMEM__DEFAULT_FLAGS
+	};
+
+	if (opt_trace_code == XSK_TRACE_DROP_PKT_TOO_BIG)
+		cfg.frame_headroom = XSK_UMEM__DEFAULT_FRAME_SIZE - XDP_PACKET_HEADROOM - 1;
 
 	data->umem = calloc(1, sizeof(struct xsk_umem_info));
 	if (!data->umem)
 		exit_with_error(errno);
 
 	ret = xsk_umem__create(&data->umem->umem, buffer, size,
-			       &data->umem->fq, &data->umem->cq, NULL);
+			       &data->umem->fq, &data->umem->cq, &cfg);
 	if (ret)
 		exit_with_error(ret);
 
@@ -1171,6 +1184,10 @@ int main(int argc, char **argv)
 			expected_traces = opt_pkt_count - TRACE_RXQ_FULL_RXQ_SIZE;
 			reason_str = "rxq full";
 			break;
+		case XSK_TRACE_DROP_PKT_TOO_BIG:
+			expected_traces = opt_pkt_count;
+			reason_str = "packet too big";
+			break;
 		default:
 			ksft_test_result_fail("ERROR: unsupported trace %i\n",
 						opt_trace_code);
-- 
2.17.1

