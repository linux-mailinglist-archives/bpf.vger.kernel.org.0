Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156FD30D4B1
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 09:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhBCIMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 03:12:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:59625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhBCIMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 03:12:12 -0500
IronPort-SDR: qIVr45DpNiWt+6+6SPJe7Td9IOzDv+RPpdp8SZtYtW5nRUCHl9y0QIdxx+ek7TBMRMjmchl01H
 g57us12R3UEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160170057"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="160170057"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:11:31 -0800
IronPort-SDR: J7MES4oinC1uPoALeo7Iy87MkdRm/By922t4z73Epkp6Vl6TkLeyVKy12wrL44FRGWNoc14X8X
 27utOiNIUojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="413932457"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.142])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2021 00:11:29 -0800
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, bjorn@kernel.org,
        weqaar.a.janjua@intel.com
Cc:     daniel@iogearbox.net, Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next v4 2/6] selftests/bpf: restructure setting the packet count
Date:   Wed,  3 Feb 2021 07:41:23 +0000
Message-Id: <20210203074127.8616-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203074127.8616-1-ciara.loftus@intel.com>
References: <20210203074127.8616-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prior to this, the packet count was fixed at 10000 for every test.
Future tracing tests need to modify the count in order to ensure
the trace buffer does not become full. So, make it possible to set
the count from test_xsk.h using the -C opt.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh    | 17 +++++++++--------
 tools/testing/selftests/bpf/xsk_prereqs.sh |  3 +--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 88a7483eaae4..2b4a4f42b220 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -82,6 +82,7 @@ do
 done
 
 TEST_NAME="PREREQUISITES"
+DEFAULTPKTS=10000
 
 URANDOM=/dev/urandom
 [ ! -e "${URANDOM}" ] && { echo "${URANDOM} not found. Skipping tests."; test_exit 1 1; }
@@ -154,7 +155,7 @@ TEST_NAME="SKB NOPOLL"
 
 vethXDPgeneric ${VETH0} ${VETH1} ${NS1}
 
-params=("-S")
+params=("-S" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -166,7 +167,7 @@ TEST_NAME="SKB POLL"
 
 vethXDPgeneric ${VETH0} ${VETH1} ${NS1}
 
-params=("-S" "-p")
+params=("-S" "-p" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -178,7 +179,7 @@ TEST_NAME="DRV NOPOLL"
 
 vethXDPnative ${VETH0} ${VETH1} ${NS1}
 
-params=("-N")
+params=("-N" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -190,7 +191,7 @@ TEST_NAME="DRV POLL"
 
 vethXDPnative ${VETH0} ${VETH1} ${NS1}
 
-params=("-N" "-p")
+params=("-N" "-p" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -202,7 +203,7 @@ TEST_NAME="SKB SOCKET TEARDOWN"
 
 vethXDPgeneric ${VETH0} ${VETH1} ${NS1}
 
-params=("-S" "-T")
+params=("-S" "-T" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -214,7 +215,7 @@ TEST_NAME="DRV SOCKET TEARDOWN"
 
 vethXDPnative ${VETH0} ${VETH1} ${NS1}
 
-params=("-N" "-T")
+params=("-N" "-T" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -226,7 +227,7 @@ TEST_NAME="SKB BIDIRECTIONAL SOCKETS"
 
 vethXDPgeneric ${VETH0} ${VETH1} ${NS1}
 
-params=("-S" "-B")
+params=("-S" "-B" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
@@ -238,7 +239,7 @@ TEST_NAME="DRV BIDIRECTIONAL SOCKETS"
 
 vethXDPnative ${VETH0} ${VETH1} ${NS1}
 
-params=("-N" "-B")
+params=("-N" "-B" "-C" "${DEFAULTPKTS}")
 execxdpxceiver params
 
 retval=$?
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
index 9d54c4645127..41dd713d14df 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
@@ -15,7 +15,6 @@ NC='\033[0m'
 STACK_LIM=131072
 SPECFILE=veth.spec
 XSKOBJ=xdpxceiver
-NUMPKTS=10000
 
 validate_root_exec()
 {
@@ -131,5 +130,5 @@ execxdpxceiver()
 			copy[$index]=${!current}
 		done
 
-	./${XSKOBJ} -i ${VETH0} -i ${VETH1},${NS1} ${copy[*]} -C ${NUMPKTS}
+	./${XSKOBJ} -i ${VETH0} -i ${VETH1},${NS1} ${copy[*]}
 }
-- 
2.17.1

