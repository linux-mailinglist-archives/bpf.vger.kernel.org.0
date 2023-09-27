Return-Path: <bpf+bounces-10974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5F7B0578
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 462F12830BD
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D0341BB;
	Wed, 27 Sep 2023 13:32:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12C347BD;
	Wed, 27 Sep 2023 13:32:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A24136;
	Wed, 27 Sep 2023 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821525; x=1727357525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C7dr1ZrgIHOnJW+9ttlqfuOrJFB4+/hVEJYg0Q2RZoU=;
  b=D9zkJlnc42mJhVrI0d83Umqm1m0bokhXZwJ3g3ha1aknLyCzDZ1Woi6m
   QUn3ackvfNk9oTBccu1XG6G3CTR4EDC7snZGOXbqyz2Ews9rlCXDnyFux
   Wj1AN/D1d6mYL0l4tv3EwFojv0XcYxisnxq2zizUiWuHwM7LthduBzaPU
   oW8GBfH8Jp+xJPnWsON4IwsdkbNMwPoUPmGnJb0nvOyrmaNIHIpDmwClM
   9oZRs1nM6SdytNrae+UbDNjOWwKkIgBiI2wmPYNYBEjFYhNz8MBbSRpWO
   VNWSX6OZbhfju8Bv8k7goiqPZh9NPCcaHv+93LPsXFYW16MdfjYPnxbLv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448316462"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="448316462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698879130"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698879130"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:32:01 -0700
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
Subject: [PATCH bpf-next v3 8/8] selftests/xsk: add a test for shared umem feature
Date: Wed, 27 Sep 2023 19:22:41 +0530
Message-Id: <20230927135241.2287547-9-tushar.vyavahare@intel.com>
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

Add a new test for testing shared umem feature. This is accomplished by
adding a new XDP program and using the multiple sockets.

The new XDP program redirects the packets based on the destination MAC
address.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/progs/xsk_xdp_progs.c       | 20 ++++++-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |  2 +
 tools/testing/selftests/bpf/xskxceiver.c      | 55 +++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h      |  2 +-
 4 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 734f231a8534..ccde6a4c6319 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -3,11 +3,12 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
 #include "xsk_xdp_common.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__uint(key_size, sizeof(int));
 	__uint(value_size, sizeof(int));
 } xsk SEC(".maps");
@@ -52,4 +53,21 @@ SEC("xdp.frags") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
+SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+
+	if (eth + 1 > data_end)
+		return XDP_DROP;
+
+	/* Redirecting packets based on the destination MAC address */
+	idx = ((unsigned int)(eth->h_dest[5])) / 2;
+	if (idx > MAX_SOCKETS)
+		return XDP_DROP;
+
+	return bpf_redirect_map(&xsk, idx, XDP_DROP);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
index f55d61625336..5a6f36f07383 100644
--- a/tools/testing/selftests/bpf/xsk_xdp_common.h
+++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
@@ -3,6 +3,8 @@
 #ifndef XSK_XDP_COMMON_H_
 #define XSK_XDP_COMMON_H_
 
+#define MAX_SOCKETS 2
+
 struct xdp_info {
 	__u64 count;
 } __attribute__((aligned(32)));
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 0432c516a413..837e0ffbdc47 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -651,7 +651,7 @@ static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
 	return ceil_u32(len, umem->frame_size) * umem->frame_size;
 }
 
-static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32 pkt_len)
+static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb_start, u32 nb_off)
 {
 	struct pkt_stream *pkt_stream;
 	u32 i;
@@ -666,12 +666,17 @@ static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32 pkt_len)
 		struct pkt *pkt = &pkt_stream->pkts[i];
 
 		pkt_set(pkt_stream, pkt, 0, pkt_len);
-		pkt->pkt_nb = i;
+		pkt->pkt_nb = nb_start + i * nb_off;
 	}
 
 	return pkt_stream;
 }
 
+static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32 pkt_len)
+{
+	return __pkt_stream_generate(nb_pkts, pkt_len, 0, 1);
+}
+
 static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
 {
 	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
@@ -721,6 +726,24 @@ static void pkt_stream_receive_half(struct test_spec *test)
 	pkt_stream->nb_valid_entries /= 2;
 }
 
+static void pkt_stream_even_odd_sequence(struct test_spec *test)
+{
+	struct pkt_stream *pkt_stream;
+	u32 i;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
+		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
+						   pkt_stream->pkts[0].len, i, 2);
+		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
+
+		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
+		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
+						   pkt_stream->pkts[0].len, i, 2);
+		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
+	}
+}
+
 static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
 {
 	if (!pkt->valid)
@@ -1584,6 +1607,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	void *bufs;
 	int ret;
+	u32 i;
 
 	if (ifobject->umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
@@ -1608,9 +1632,12 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 
 	xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream, ifobject->use_fill_ring);
 
-	ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
-	if (ret)
-		exit_with_error(errno);
+	for (i = 0; i < test->nb_sockets; i++) {
+		ifobject->xsk = &ifobject->xsk_arr[i];
+		ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, i);
+		if (ret)
+			exit_with_error(errno);
+	}
 }
 
 static void *worker_testapp_validate_tx(void *arg)
@@ -2111,6 +2138,23 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_xdp_shared_umem(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+
+	test->total_steps = 1;
+	test->nb_sockets = 2;
+
+	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_shared_umem,
+			       skel_tx->progs.xsk_xdp_shared_umem,
+			       skel_rx->maps.xsk, skel_tx->maps.xsk);
+
+	pkt_stream_even_odd_sequence(test);
+
+	return testapp_validate_traffic(test);
+}
+
 static int testapp_poll_txq_tmout(struct test_spec *test)
 {
 	test->ifobj_tx->use_poll = true;
@@ -2412,6 +2456,7 @@ static const struct test_spec tests[] = {
 	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
 	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
 	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
+	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
 	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index fa409285eafd..f174df2d693f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -8,6 +8,7 @@
 #include <limits.h>
 
 #include "xsk_xdp_progs.skel.h"
+#include "xsk_xdp_common.h"
 
 #ifndef SOL_XDP
 #define SOL_XDP 283
@@ -35,7 +36,6 @@
 #define TEST_SKIP 2
 #define MAX_INTERFACES 2
 #define MAX_INTERFACE_NAME_CHARS 16
-#define MAX_SOCKETS 2
 #define MAX_TEST_NAME_SIZE 48
 #define MAX_TEARDOWN_ITER 10
 #define PKT_HDR_SIZE (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
-- 
2.34.1


