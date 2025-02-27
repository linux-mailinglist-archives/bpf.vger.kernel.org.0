Return-Path: <bpf+bounces-52763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB6A4822A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39023A8127
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FA25F7BC;
	Thu, 27 Feb 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbW+fQ3v"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218325E81F;
	Thu, 27 Feb 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668167; cv=none; b=E8UBWsjgJKupzxz3hWs+LOEVNgqb1u3L4IMhQZeAtU45Q0Pvoc9iluqfkOIstJ9LkGILvL7Gs9VM3Hge/dslCmJKA34f7xHtGD91ERcf2Wk2iu7USDibF3WULHOlATI/Y3fnPoqex5337KcOdbyQXxByJfE+M9vOFCH7bVavMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668167; c=relaxed/simple;
	bh=TqnvgyMWkrYEi2Qor6A2qUjZkniGUlY4nJeV8q2ZO/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTxDr0ccDAykEhVqbo/LVDMM19J9LAqcEhdyyOarg8hXQI3mXDbD8hRC5gp8eO9sZinKI6/4nlFohSU2JtcuE1TilcAggBGdXCwJH4EytrC5aIwQbm5QtXVxiKCbwwp1qwNq1S4FqwsgTYRNgbFvu/tKCHYt72p1lE8z2mAxWtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbW+fQ3v; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740668166; x=1772204166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TqnvgyMWkrYEi2Qor6A2qUjZkniGUlY4nJeV8q2ZO/k=;
  b=IbW+fQ3vwjyk7VTtcBG/dLjXUXj2bD6F8wu41M6yH31uYsFxlnEItQxq
   vNJCl6gT/K+vVZna6ZCQqMOhsk53NjgeLNAOWFUu6mC4eRL7XiDi/cPTY
   9qN1kJIT5WPyPpEY3/yjeKtAO3IBJZs0gr/mI9N7YLqUYsQBy84pxblkm
   qJAolXkhnxhubaPNteCedUQnFwAkiQyFALkBGF/DCK+q5H3U7OHzl+/hR
   JRjGdDaH59DomUjnwkFYNmsxSg+N2bK8XwI46c3isTQPMkDCi1qYAo0FP
   a+dUd1Ej9klx2NLyw5UoMg6TPA7FvYy6ONHHVF2HtAXo/vG4Rygx0cUzS
   g==;
X-CSE-ConnectionGUID: RTU2AiicQ1CAmz7h5p4apw==
X-CSE-MsgGUID: CSVmYFcUTkmQC8fGA3MS6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41480555"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41480555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:56:05 -0800
X-CSE-ConnectionGUID: WEhk7NGuQqmeUWiW5hWCPg==
X-CSE-MsgGUID: jE2xY6IBR6mEbseQ/OJL9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117541131"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:56:01 -0800
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
Subject: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests and support check
Date: Thu, 27 Feb 2025 14:27:37 +0000
Message-Id: <20250227142737.165268-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227142737.165268-1-tushar.vyavahare@intel.com>
References: <20250227142737.165268-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce tail adjustment functionality in xskxceiver using
bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet sizes
and drop unmodified packets. Implement `is_adjust_tail_supported` to check
helper availability. Develop packet resizing tests, including shrinking
and growing scenarios, with functions for both single-buffer and
multi-buffer cases. Update the test framework to handle various scenarios
and adjust MTU settings. These changes enhance the testing of packet tail
adjustments, improving AF_XDP framework reliability.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 +++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 118 +++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index ccde6a4c6319..2e8e2faf17e0 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -4,6 +4,8 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/errno.h>
 #include "xsk_xdp_common.h"
 
 struct {
@@ -70,4 +72,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, idx, XDP_DROP);
 }
 
+SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
+{
+	__u32 buff_len, curr_buff_len;
+	int ret;
+
+	buff_len = bpf_xdp_get_buff_len(xdp);
+	if (buff_len == 0)
+		return XDP_DROP;
+
+	ret = bpf_xdp_adjust_tail(xdp, count);
+	if (ret < 0) {
+		/* Handle unsupported cases */
+		if (ret == -EOPNOTSUPP) {
+			/* Set count to -EOPNOTSUPP to indicate to userspace that this case is
+			 * unsupported
+			 */
+			count = -EOPNOTSUPP;
+			return bpf_redirect_map(&xsk, 0, XDP_DROP);
+		}
+
+		return XDP_DROP;
+	}
+
+	curr_buff_len = bpf_xdp_get_buff_len(xdp);
+	if (curr_buff_len != buff_len + count)
+		return XDP_DROP;
+
+	if (curr_buff_len > buff_len) {
+		__u32 *pkt_data = (void *)(long)xdp->data;
+		__u32 len, words_to_end, seq_num;
+
+		len = curr_buff_len - PKT_HDR_ALIGN;
+		words_to_end = len / sizeof(*pkt_data) - 1;
+		seq_num = words_to_end;
+
+		/* Convert sequence number to network byte order. Store this in the last 4 bytes of
+		 * the packet. Use 'count' to determine the position at the end of the packet for
+		 * storing the sequence number.
+		 */
+		seq_num = __constant_htonl(words_to_end);
+		bpf_xdp_store_bytes(xdp, curr_buff_len - count, &seq_num, sizeof(seq_num));
+	}
+
+	return bpf_redirect_map(&xsk, 0, XDP_DROP);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
index 5a6f36f07383..45810ff552da 100644
--- a/tools/testing/selftests/bpf/xsk_xdp_common.h
+++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
@@ -4,6 +4,7 @@
 #define XSK_XDP_COMMON_H_
 
 #define MAX_SOCKETS 2
+#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
 
 struct xdp_info {
 	__u64 count;
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index d60ee6a31c09..ee196b638662 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->nb_sockets = 1;
 	test->fail = false;
 	test->set_ring = false;
+	test->adjust_tail = false;
+	test->adjust_tail_support = false;
 	test->mtu = MAX_ETH_PKT_SIZE;
 	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
@@ -992,6 +994,31 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	return true;
 }
 
+static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
+{
+	struct bpf_map *data_map;
+	int value = 0;
+	int key = 0;
+	int ret;
+
+	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
+	if (!data_map || !bpf_map__is_internal(data_map)) {
+		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		exit_with_error(errno);
+	}
+
+	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &value);
+	if (ret) {
+		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
+		return false;
+	}
+
+	/* Set the 'count' variable to -EOPNOTSUPP in the XDP program if the adjust_tail helper is
+	 * not supported. Skip the adjust_tail test case in this scenario.
+	 */
+	return value != -EOPNOTSUPP;
+}
+
 static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
 			  u32 bytes_processed)
 {
@@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void *arg)
 
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
-	if (err)
-		report_failure(test);
+
+	if (err) {
+		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
+			test->adjust_tail_support = false;
+		else
+			report_failure(test);
+	}
 
 	pthread_exit(NULL);
 }
@@ -2516,6 +2548,84 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_xdp_adjust_tail(struct test_spec *test, int count)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	struct bpf_map *data_map;
+	int key = 0;
+
+	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
+			       skel_tx->progs.xsk_xdp_adjust_tail,
+			       skel_rx->maps.xsk, skel_tx->maps.xsk);
+
+	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
+	if (!data_map || !bpf_map__is_internal(data_map)) {
+		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		return TEST_FAILURE;
+	}
+
+	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY)) {
+		ksft_print_msg("Error: could not update count element\n");
+		return TEST_FAILURE;
+	}
+
+	return testapp_validate_traffic(test);
+}
+
+static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
+{
+	u32 pkt_cnt = DEFAULT_BATCH_SIZE;
+	int ret;
+
+	test->adjust_tail_support = true;
+	test->adjust_tail = true;
+	test->total_steps = 1;
+
+	pkt_stream_replace_ifobject(test->ifobj_tx, pkt_cnt, pkt_len);
+	pkt_stream_replace_ifobject(test->ifobj_rx, pkt_cnt, pkt_len + value);
+
+	ret = testapp_xdp_adjust_tail(test, value);
+	if (ret)
+		return ret;
+
+	if (!test->adjust_tail_support) {
+		ksft_test_result_skip("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
+				      mode_string(test), busy_poll_string(test));
+	return TEST_SKIP;
+	}
+
+	return 0;
+}
+
+static int testapp_adjust_tail_common(struct test_spec *test, int adjust_value, u32 len,
+				      bool set_mtu)
+{
+	if (set_mtu)
+		test->mtu = MAX_ETH_JUMBO_SIZE;
+	return testapp_adjust_tail(test, adjust_value, len);
+}
+
+static int testapp_adjust_tail_shrink(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false);
+}
+
+static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, -4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
+}
+
+static int testapp_adjust_tail_grow(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, 4, MIN_PKT_SIZE, false);
+}
+
+static int testapp_adjust_tail_grow_mb(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, 4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2622,6 +2732,10 @@ static const struct test_spec tests[] = {
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
 	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
+	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
+	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
+	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
+	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
 	};
 
 static void print_tests(void)
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index e46e823f6a1a..67fc44b2813b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -173,6 +173,8 @@ struct test_spec {
 	u16 nb_sockets;
 	bool fail;
 	bool set_ring;
+	bool adjust_tail;
+	bool adjust_tail_support;
 	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
-- 
2.34.1


