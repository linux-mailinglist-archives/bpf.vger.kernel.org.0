Return-Path: <bpf+bounces-55626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E2A83799
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 06:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BF98C2CD8
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4DC1F2388;
	Thu, 10 Apr 2025 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzanCsz+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FEF38F80;
	Thu, 10 Apr 2025 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257669; cv=none; b=EhseSNxMEViA/O3pMcA8PY7LKi4E5yfcLwArgc9Pb10nGIEnSzTyYjAylxYuzq1lGKiERzToqx1MistLED8evAiihOdpYFKxIwdxVDStwnJZ6rYA/Jsw9znUJBg7qLJMUkX0lmkfSrm4xAUO3FRho+6VcU9Z45Z04vAdy5Tjh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257669; c=relaxed/simple;
	bh=YFq/vy9ty//7bbhsTW5Cj4Myq4fj6yOx2jp89I4jJWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjCW+rNs5ojF8DMe48N3vqIzvRD6U6BSCtoS719lYOpIiuWU3g6PYTqjB3N8a59IIT22NqRUJwCDNhQKWQ4hqx33dJ8jOg+n7BvvX46oARb9Gp8JUvGPGngHVJTxaBQH6Bct+Jbmig5UBBBBVmTYUh4vS0nESquXV+iop+xcdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzanCsz+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744257668; x=1775793668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YFq/vy9ty//7bbhsTW5Cj4Myq4fj6yOx2jp89I4jJWU=;
  b=PzanCsz+i7GH5Go+suZK54eNDh2Y77HeT6enDN5eMdqHmr1JGBeztQ/P
   6gX2qfScYyeOHj8LnsGlBFo8YPpfed/Cu/Qexn/EcDoiGW/QreI0unQCe
   GhxQUVhp/TdkuulXpZiddjW3vbPPDYMomfylS5lE8jqgENcQXdefy+f3p
   XP7r17D9Dz4Oq3OWGC++FX2OLq78XuKT3yYpDnFNr4RCCgOg8PSWRbqm1
   U6NClCHUczkkZ70zqnpfc1fbJh7Jw9Opp3GcPxQBpduP8Msu4LE67biqJ
   fuNMoGUcoVgeu+i4Ur7VpFzh44fN8Jc2oULC5ZqYyaQy3ujwjF/3apge7
   Q==;
X-CSE-ConnectionGUID: a4il0XvxSGOCAv0NtIuczg==
X-CSE-MsgGUID: VGY121dETje/eJtsomCIJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="33365761"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="33365761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 21:01:07 -0700
X-CSE-ConnectionGUID: iMKgq+xBQyeQN71Mps1JJQ==
X-CSE-MsgGUID: qakRDw9ETA69xUeOjZy2FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="159744181"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 21:01:04 -0700
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
Subject: [PATCH bpf-next v4 2/2] selftests/xsk: Add tail adjustment tests and support check
Date: Thu, 10 Apr 2025 03:31:16 +0000
Message-Id: <20250410033116.173617-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410033116.173617-1-tushar.vyavahare@intel.com>
References: <20250410033116.173617-1-tushar.vyavahare@intel.com>
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
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  50 +++++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 105 +++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index ccde6a4c6319..683306db8594 100644
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
@@ -14,6 +16,7 @@ struct {
 } xsk SEC(".maps");
 
 static unsigned int idx;
+int adjust_value = 0;
 int count = 0;
 
 SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
@@ -70,4 +73,51 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
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
+	ret = bpf_xdp_adjust_tail(xdp, adjust_value);
+	if (ret < 0) {
+		/* Handle unsupported cases */
+		if (ret == -EOPNOTSUPP) {
+			/* Set adjust_value to -EOPNOTSUPP to indicate to userspace that this case
+			 * is unsupported
+			 */
+			adjust_value = -EOPNOTSUPP;
+			return bpf_redirect_map(&xsk, 0, XDP_DROP);
+		}
+
+		return XDP_DROP;
+	}
+
+	curr_buff_len = bpf_xdp_get_buff_len(xdp);
+	if (curr_buff_len != buff_len + adjust_value)
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
+		 * the packet. Use 'adjust_value' to determine the position at the end of the
+		 * packet for storing the sequence number.
+		 */
+		seq_num = __constant_htonl(words_to_end);
+		bpf_xdp_store_bytes(xdp, curr_buff_len - sizeof(seq_num), &seq_num,
+				    sizeof(seq_num));
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
index d60ee6a31c09..0ced4026ee44 100644
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
+	int adjust_value = 0;
+	int key = 0;
+	int ret;
+
+	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
+	if (!data_map || !bpf_map__is_internal(data_map)) {
+		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		exit_with_error(errno);
+	}
+
+	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
+	if (ret) {
+		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
+		exit_with_error(errno);
+	}
+
+	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
+	 * helper is not supported. Skip the adjust_tail test case in this scenario.
+	 */
+	return adjust_value != -EOPNOTSUPP;
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
@@ -2516,6 +2548,71 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_xdp_adjust_tail(struct test_spec *test, int adjust_value)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+
+	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
+			       skel_tx->progs.xsk_xdp_adjust_tail,
+			       skel_rx->maps.xsk, skel_tx->maps.xsk);
+
+	skel_rx->bss->adjust_value = adjust_value;
+
+	return testapp_validate_traffic(test);
+}
+
+static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
+{
+	int ret;
+
+	test->adjust_tail_support = true;
+	test->adjust_tail = true;
+	test->total_steps = 1;
+
+	pkt_stream_replace_ifobject(test->ifobj_tx, DEFAULT_BATCH_SIZE, pkt_len);
+	pkt_stream_replace_ifobject(test->ifobj_rx, DEFAULT_BATCH_SIZE, pkt_len + value);
+
+	ret = testapp_xdp_adjust_tail(test, value);
+	if (ret)
+		return ret;
+
+	if (!test->adjust_tail_support) {
+		ksft_test_result_skip("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
+				      mode_string(test), busy_poll_string(test));
+		return TEST_SKIP;
+	}
+
+	return 0;
+}
+
+static int testapp_adjust_tail_shrink(struct test_spec *test)
+{
+	/* Shrink by 4 bytes for testing purpose */
+	return testapp_adjust_tail(test, -4, MIN_PKT_SIZE * 2);
+}
+
+static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
+{
+	test->mtu = MAX_ETH_JUMBO_SIZE;
+	/* Shrink by the frag size */
+	return testapp_adjust_tail(test, -XSK_UMEM__MAX_FRAME_SIZE, XSK_UMEM__LARGE_FRAME_SIZE * 2);
+}
+
+static int testapp_adjust_tail_grow(struct test_spec *test)
+{
+	/* Grow by 4 bytes for testing purpose */
+	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
+}
+
+static int testapp_adjust_tail_grow_mb(struct test_spec *test)
+{
+	test->mtu = MAX_ETH_JUMBO_SIZE;
+	/* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
+	return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
+				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2622,6 +2719,10 @@ static const struct test_spec tests[] = {
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


