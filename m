Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E654CE55
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354041AbiFOQOy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354074AbiFOQNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 12:13:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7B39BAB;
        Wed, 15 Jun 2022 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655309595; x=1686845595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n1z9AW0joriVRC5RBVVqnvcO+4hndBjTIShR7TYLoMg=;
  b=faBNvX7572/GAeSx62d1hSy3RkHxWFnuPEddensok6q2dmWCkDRksYNL
   7JOEa6hvZnhSVwXoPPzJ2LUafe2JmWIbzZZFNAEH0tgYEl+xKKSxu0XMr
   spnMvdrWUxLrCrMzemNVNXQbOeX1jS7orxcSDxijSYBLv4HD1Q7xx6I0M
   WvSXUWlegRBYMKqDxm/OOpCDh2fp9JyQsxJxsQZdrL7RZ6B1R5gcgtuJF
   xLq0j1yzaAr/5aUkn+qTDgS+4wFp0P1l8nxzpM7HQc9VPWjrAuLvbGb6p
   cgabBrvNsy9u/d1BLIBu9sNOQjwhlp100NLH3NjwFlrBy0hDJDCrZonn7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280050187"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="280050187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="713005371"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2022 09:11:16 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn@kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 bpf-next 08/11] selftests: xsk: add support for executing tests on physical device
Date:   Wed, 15 Jun 2022 18:10:38 +0200
Message-Id: <20220615161041.902916-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220615161041.902916-1-maciej.fijalkowski@intel.com>
References: <20220615161041.902916-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, architecture of xdpxceiver is designed strictly for
conducting veth based tests. Veth pair is created together with a
network namespace and one of the veth interfaces is moved to the
mentioned netns. Then, separate threads for Tx and Rx are spawned which
will utilize described setup.

Infrastructure described in the paragraph above can not be used for
testing AF_XDP support on physical devices. That testing will be
conducted on a single network interface and same queue. Xdpxceiver
needs to be extended to distinguish between veth tests and physical
interface tests.

Since same iface/queue id pair will be used by both Tx/Rx threads for
physical device testing, Tx thread, which happen to run after the Rx
thread, is going to create XSK socket with shared umem flag. In order to
track this setting throughout the lifetime of spawned threads, introduce
'shared_umem' boolean variable to struct ifobject and set it to true
when xdpxceiver is run against physical device. In such case, UMEM size
needs to be doubled, so half of it will be used by Rx thread and other
half by Tx thread. For two step based test types, value of XSKMAP
element under key 0 has to be updated as there is now another socket for
the second step. Also, to avoid race conditions when destroying XSK
resources, move this activity to the main thread after spawned Rx and Tx
threads have finished its job. This way it is possible to gracefully
remove shared umem without introducing synchronization mechanisms.

To run xsk selftests suite on physical device, append "-i $IFACE" when
invoking test_xsk.sh. For veth based tests, simply skip it. When "-i
$IFACE" is in place, under the hood test_xsk.sh will use $IFACE for both
interfaces supplied to xdpxceiver, which in turn will interpret that
this execution of test suite is for a physical device.

Note that currently this makes it possible only to test SKB and DRV mode
(in case underlying device has native XDP support). ZC testing support
is added in a later patch.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  |  52 +++++--
 tools/testing/selftests/bpf/xdpxceiver.c | 189 ++++++++++++++---------
 tools/testing/selftests/bpf/xdpxceiver.h |   1 +
 3 files changed, 156 insertions(+), 86 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 567500299231..19b24cce5414 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -73,14 +73,20 @@
 #
 # Run and dump packet contents:
 #   sudo ./test_xsk.sh -D
+#
+# Run test suite for physical device in loopback mode
+#   sudo ./test_xsk.sh -i IFACE
 
 . xsk_prereqs.sh
 
-while getopts "vD" flag
+ETH=""
+
+while getopts "vDi:" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
 		D) dump_pkts=1;;
+		i) ETH=${OPTARG};;
 	esac
 done
 
@@ -132,18 +138,25 @@ setup_vethPairs() {
 	ip link set ${VETH0} up
 }
 
-validate_root_exec
-validate_veth_support ${VETH0}
-validate_ip_utility
-setup_vethPairs
-
-retval=$?
-if [ $retval -ne 0 ]; then
-	test_status $retval "${TEST_NAME}"
-	cleanup_exit ${VETH0} ${VETH1} ${NS1}
-	exit $retval
+if [ ! -z $ETH ]; then
+	VETH0=${ETH}
+	VETH1=${ETH}
+	NS1=""
+else
+	validate_root_exec
+	validate_veth_support ${VETH0}
+	validate_ip_utility
+	setup_vethPairs
+
+	retval=$?
+	if [ $retval -ne 0 ]; then
+		test_status $retval "${TEST_NAME}"
+		cleanup_exit ${VETH0} ${VETH1} ${NS1}
+		exit $retval
+	fi
 fi
 
+
 if [[ $verbose -eq 1 ]]; then
 	ARGS+="-v "
 fi
@@ -152,26 +165,33 @@ if [[ $dump_pkts -eq 1 ]]; then
 	ARGS="-D "
 fi
 
+retval=$?
 test_status $retval "${TEST_NAME}"
 
 ## START TESTS
 
 statusList=()
 
-TEST_NAME="XSK_SELFTESTS_SOFTIRQ"
+TEST_NAME="XSK_SELFTESTS_${VETH0}_SOFTIRQ"
 
 execxdpxceiver
 
-cleanup_exit ${VETH0} ${VETH1} ${NS1}
-TEST_NAME="XSK_SELFTESTS_BUSY_POLL"
+if [ -z $ETH ]; then
+	cleanup_exit ${VETH0} ${VETH1} ${NS1}
+fi
+TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
 busy_poll=1
 
-setup_vethPairs
+if [ -z $ETH ]; then
+	setup_vethPairs
+fi
 execxdpxceiver
 
 ## END TESTS
 
-cleanup_exit ${VETH0} ${VETH1} ${NS1}
+if [ -z $ETH ]; then
+	cleanup_exit ${VETH0} ${VETH1} ${NS1}
+fi
 
 failures=0
 echo -e "\nSummary:"
diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 3d0731a80e4a..de4cf0432243 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -296,8 +296,8 @@ static void enable_busy_poll(struct xsk_socket_info *xsk)
 		exit_with_error(errno);
 }
 
-static int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
-				struct ifobject *ifobject, bool shared)
+static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
+				  struct ifobject *ifobject, bool shared)
 {
 	struct xsk_socket_config cfg = {};
 	struct xsk_ring_cons *rxr;
@@ -443,6 +443,9 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		memset(ifobj->umem, 0, sizeof(*ifobj->umem));
 		ifobj->umem->num_frames = DEFAULT_UMEM_BUFFERS;
 		ifobj->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
+		if (ifobj->shared_umem && ifobj->rx_on)
+			ifobj->umem->base_addr = DEFAULT_UMEM_BUFFERS *
+				XSK_UMEM__DEFAULT_FRAME_SIZE;
 
 		for (j = 0; j < MAX_SOCKETS; j++) {
 			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
@@ -1101,19 +1104,85 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	return TEST_PASS;
 }
 
+static void xsk_configure_socket(struct test_spec *test, struct ifobject *ifobject,
+				 struct xsk_umem_info *umem, bool tx)
+{
+	int i, ret;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		bool shared = (ifobject->shared_umem && tx) ? true : !!i;
+		u32 ctr = 0;
+
+		while (ctr++ < SOCK_RECONF_CTR) {
+			ret = __xsk_configure_socket(&ifobject->xsk_arr[i], umem,
+						     ifobject, shared);
+			if (!ret)
+				break;
+
+			/* Retry if it fails as xsk_socket__create() is asynchronous */
+			if (ctr >= SOCK_RECONF_CTR)
+				exit_with_error(-ret);
+			usleep(USLEEP_MAX);
+		}
+		if (ifobject->busy_poll)
+			enable_busy_poll(&ifobject->xsk_arr[i]);
+	}
+}
+
+static void thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
+{
+	xsk_configure_socket(test, ifobject, test->ifobj_rx->umem, true);
+	ifobject->xsk = &ifobject->xsk_arr[0];
+	ifobject->xsk_map_fd = test->ifobj_rx->xsk_map_fd;
+	memcpy(ifobject->umem, test->ifobj_rx->umem, sizeof(struct xsk_umem_info));
+}
+
+static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream *pkt_stream)
+{
+	u32 idx = 0, i, buffers_to_fill;
+	int ret;
+
+	if (umem->num_frames < XSK_RING_PROD__DEFAULT_NUM_DESCS)
+		buffers_to_fill = umem->num_frames;
+	else
+		buffers_to_fill = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+
+	ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
+	if (ret != buffers_to_fill)
+		exit_with_error(ENOSPC);
+	for (i = 0; i < buffers_to_fill; i++) {
+		u64 addr;
+
+		if (pkt_stream->use_addr_for_fill) {
+			struct pkt *pkt = pkt_stream_get_pkt(pkt_stream, i);
+
+			if (!pkt)
+				break;
+			addr = pkt->addr;
+		} else {
+			addr = i * umem->frame_size;
+		}
+
+		*xsk_ring_prod__fill_addr(&umem->fq, idx++) = addr;
+	}
+	xsk_ring_prod__submit(&umem->fq, buffers_to_fill);
+}
+
 static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
 	u64 umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	int ret, ifindex;
 	void *bufs;
-	u32 i;
 
 	ifobject->ns_fd = switch_namespace(ifobject->nsname);
 
 	if (ifobject->umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB;
 
+	if (ifobject->shared_umem)
+		umem_sz *= 2;
+
 	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
 	if (bufs == MAP_FAILED)
 		exit_with_error(errno);
@@ -1122,24 +1191,9 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ret)
 		exit_with_error(-ret);
 
-	for (i = 0; i < test->nb_sockets; i++) {
-		u32 ctr = 0;
-
-		while (ctr++ < SOCK_RECONF_CTR) {
-			ret = xsk_configure_socket(&ifobject->xsk_arr[i], ifobject->umem,
-						   ifobject, !!i);
-			if (!ret)
-				break;
-
-			/* Retry if it fails as xsk_socket__create() is asynchronous */
-			if (ctr >= SOCK_RECONF_CTR)
-				exit_with_error(-ret);
-			usleep(USLEEP_MAX);
-		}
+	xsk_populate_fill_ring(ifobject->umem, ifobject->pkt_stream);
 
-		if (ifobject->busy_poll)
-			enable_busy_poll(&ifobject->xsk_arr[i]);
-	}
+	xsk_configure_socket(test, ifobject, ifobject->umem, false);
 
 	ifobject->xsk = &ifobject->xsk_arr[0];
 
@@ -1159,22 +1213,18 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 		exit_with_error(-ret);
 }
 
-static void testapp_cleanup_xsk_res(struct ifobject *ifobj)
-{
-	print_verbose("Destroying socket\n");
-	xsk_socket__delete(ifobj->xsk->xsk);
-	munmap(ifobj->umem->buffer, ifobj->umem->num_frames * ifobj->umem->frame_size);
-	xsk_umem__delete(ifobj->umem->umem);
-}
-
 static void *worker_testapp_validate_tx(void *arg)
 {
 	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_tx;
 	int err;
 
-	if (test->current_step == 1)
-		thread_common_ops(test, ifobject);
+	if (test->current_step == 1) {
+		if (!ifobject->shared_umem)
+			thread_common_ops(test, ifobject);
+		else
+			thread_common_ops_tx(test, ifobject);
+	}
 
 	print_verbose("Sending %d packets on interface %s\n", ifobject->pkt_stream->nb_pkts,
 		      ifobject->ifname);
@@ -1185,53 +1235,23 @@ static void *worker_testapp_validate_tx(void *arg)
 	if (err)
 		report_failure(test);
 
-	if (test->total_steps == test->current_step || err)
-		testapp_cleanup_xsk_res(ifobject);
 	pthread_exit(NULL);
 }
 
-static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream *pkt_stream)
-{
-	u32 idx = 0, i, buffers_to_fill;
-	int ret;
-
-	if (umem->num_frames < XSK_RING_PROD__DEFAULT_NUM_DESCS)
-		buffers_to_fill = umem->num_frames;
-	else
-		buffers_to_fill = XSK_RING_PROD__DEFAULT_NUM_DESCS;
-
-	ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
-	if (ret != buffers_to_fill)
-		exit_with_error(ENOSPC);
-	for (i = 0; i < buffers_to_fill; i++) {
-		u64 addr;
-
-		if (pkt_stream->use_addr_for_fill) {
-			struct pkt *pkt = pkt_stream_get_pkt(pkt_stream, i);
-
-			if (!pkt)
-				break;
-			addr = pkt->addr;
-		} else {
-			addr = i * umem->frame_size;
-		}
-
-		*xsk_ring_prod__fill_addr(&umem->fq, idx++) = addr;
-	}
-	xsk_ring_prod__submit(&umem->fq, buffers_to_fill);
-}
-
 static void *worker_testapp_validate_rx(void *arg)
 {
 	struct test_spec *test = (struct test_spec *)arg;
 	struct ifobject *ifobject = test->ifobj_rx;
 	struct pollfd fds = { };
+	int id = 0;
 	int err;
 
-	if (test->current_step == 1)
+	if (test->current_step == 1) {
 		thread_common_ops(test, ifobject);
-
-	xsk_populate_fill_ring(ifobject->umem, ifobject->pkt_stream);
+	} else {
+		bpf_map_delete_elem(ifobject->xsk_map_fd, &id);
+		xsk_socket__update_xskmap(ifobject->xsk->xsk, ifobject->xsk_map_fd);
+	}
 
 	fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
 	fds.events = POLLIN;
@@ -1249,11 +1269,20 @@ static void *worker_testapp_validate_rx(void *arg)
 		pthread_mutex_unlock(&pacing_mutex);
 	}
 
-	if (test->total_steps == test->current_step || err)
-		testapp_cleanup_xsk_res(ifobject);
 	pthread_exit(NULL);
 }
 
+static void testapp_clean_xsk_umem(struct ifobject *ifobj)
+{
+	u64 umem_sz = ifobj->umem->num_frames * ifobj->umem->frame_size;
+
+	if (ifobj->shared_umem)
+		umem_sz *= 2;
+
+	xsk_umem__delete(ifobj->umem->umem);
+	munmap(ifobj->umem->buffer, umem_sz);
+}
+
 static int testapp_validate_traffic(struct test_spec *test)
 {
 	struct ifobject *ifobj_tx = test->ifobj_tx;
@@ -1280,6 +1309,14 @@ static int testapp_validate_traffic(struct test_spec *test)
 	pthread_join(t1, NULL);
 	pthread_join(t0, NULL);
 
+	if (test->total_steps == test->current_step || test->fail) {
+		xsk_socket__delete(ifobj_tx->xsk->xsk);
+		xsk_socket__delete(ifobj_rx->xsk->xsk);
+		testapp_clean_xsk_umem(ifobj_rx);
+		if (!ifobj_tx->shared_umem)
+			testapp_clean_xsk_umem(ifobj_tx);
+	}
+
 	return !!test->fail;
 }
 
@@ -1359,9 +1396,9 @@ static void testapp_headroom(struct test_spec *test)
 static void testapp_stats_rx_dropped(struct test_spec *test)
 {
 	test_spec_set_name(test, "STAT_RX_DROPPED");
+	pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0);
 	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
 		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
-	pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0);
 	pkt_stream_receive_half(test);
 	test->ifobj_rx->validation_func = validate_rx_dropped;
 	testapp_validate_traffic(test);
@@ -1484,6 +1521,11 @@ static void testapp_invalid_desc(struct test_spec *test)
 		pkts[7].valid = false;
 	}
 
+	if (test->ifobj_tx->shared_umem) {
+		pkts[4].addr += UMEM_SIZE;
+		pkts[5].addr += UMEM_SIZE;
+	}
+
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
 	testapp_validate_traffic(test);
 	pkt_stream_restore_default(test);
@@ -1624,7 +1666,6 @@ static void ifobject_delete(struct ifobject *ifobj)
 {
 	if (ifobj->ns_fd != -1)
 		close(ifobj->ns_fd);
-	free(ifobj->umem);
 	free(ifobj->xsk_arr);
 	free(ifobj);
 }
@@ -1663,6 +1704,7 @@ int main(int argc, char **argv)
 	int modes = TEST_MODE_SKB + 1;
 	u32 i, j, failed_tests = 0;
 	struct test_spec test;
+	bool shared_umem;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -1677,6 +1719,10 @@ int main(int argc, char **argv)
 	setlocale(LC_ALL, "");
 
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
+	shared_umem = !strcmp(ifobj_tx->ifname, ifobj_rx->ifname);
+
+	ifobj_tx->shared_umem = shared_umem;
+	ifobj_rx->shared_umem = shared_umem;
 
 	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx)) {
 		usage(basename(argv[0]));
@@ -1713,6 +1759,9 @@ int main(int argc, char **argv)
 
 	pkt_stream_delete(tx_pkt_stream_default);
 	pkt_stream_delete(rx_pkt_stream_default);
+	free(ifobj_rx->umem);
+	if (!ifobj_tx->shared_umem)
+		free(ifobj_tx->umem);
 	ifobject_delete(ifobj_tx);
 	ifobject_delete(ifobj_rx);
 
diff --git a/tools/testing/selftests/bpf/xdpxceiver.h b/tools/testing/selftests/bpf/xdpxceiver.h
index ccfc829b2e5e..b7aa6c7cf2be 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.h
+++ b/tools/testing/selftests/bpf/xdpxceiver.h
@@ -149,6 +149,7 @@ struct ifobject {
 	bool busy_poll;
 	bool use_fill_ring;
 	bool release_rx;
+	bool shared_umem;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
 };
-- 
2.27.0

