Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF36C0EB7
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 11:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCTK1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCTK1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 06:27:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631C14989
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308035; x=1710844035;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kbmyDCZWJ+iTztgJTcATry7c86rMQIfW04wAU0xJyiM=;
  b=CrJmeBdFxOpA4Aav4xzIFvdQnnV6N+HaD1bZ2iRKBPfcaiX/itCq5BzE
   dDHVIXqMUsDi6Hee1EptSsKxDSbELiNjDI0lrDp/lvHzOdbSRytsG1ck4
   zq4mjTqYwhmTIEzOG3D9iuVH2i4+aWSpPhktRosLT5WNXU/AfVv4lsu7m
   P7lVsNS175pRL+feoa7QIQ27+tcENws7ZOa6xvTViqBPyv+hL6oejoH+f
   T8rF9TdK6xGiSnTJUFhr9JB6KPmG8OwFdRDzFsTXGb08UG6DVMf2ve5Ty
   I2uCIktufOjYkbmtrIGiHMF3pL2ihMQrBYfAmzk2p91lxWpwa1GmyZZQU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424901674"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424901674"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="926920267"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="926920267"
Received: from axxiablr1.gar.corp.intel.com ([10.190.162.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:27:11 -0700
From:   Tushar Vyavahare <tushar.vyavahare@intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, tirthendu.sarkar@intel.com,
        maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next] selftests/xsk: add xdp populate metadata test
Date:   Mon, 20 Mar 2023 15:57:05 +0530
Message-Id: <20230320102705.306187-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new test in copy-mode for testing the copying of metadata from the
buffer in kernel-space to user-space. This is accomplished by adding a
new XDP program and using the bss map to store a counter that is written
to the metadata field. This counter is incremented for every packet so
that the number becomes unique and should be the same as the payload. It
is store in the bss so the value can be reset between runs.

The XDP program populates the metadata and the userspace program checks
the value stored in the metadata field against the payload using the new
is_metadata_correct() function. To turn this verification on or off, add
a new parameter (use_metadata) to the ifobject structure.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/progs/xsk_xdp_progs.c       | 25 ++++++++++
 .../testing/selftests/bpf/xsk_xdp_metadata.h  |  5 ++
 tools/testing/selftests/bpf/xskxceiver.c      | 46 ++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h      |  2 +
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 744a01d0e57d..a630c95c7471 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "xsk_xdp_metadata.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
@@ -12,6 +13,7 @@ struct {
 } xsk SEC(".maps");
 
 static unsigned int idx;
+int count = 0;
 
 SEC("xdp") int xsk_def_prog(struct xdp_md *xdp)
 {
@@ -27,4 +29,27 @@ SEC("xdp") int xsk_xdp_drop(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
 }
 
+SEC("xdp") int xsk_xdp_populate_metadata(struct xdp_md *xdp)
+{
+	void *data, *data_meta;
+	struct xdp_info *meta;
+	int err;
+
+	/* Reserve enough for all custom metadata. */
+	err = bpf_xdp_adjust_meta(xdp, -(int)sizeof(struct xdp_info));
+	if (err)
+		return XDP_DROP;
+
+	data = (void *)(long)xdp->data;
+	data_meta = (void *)(long)xdp->data_meta;
+
+	if (data_meta + sizeof(struct xdp_info) > data)
+		return XDP_DROP;
+
+	meta = data_meta;
+	meta->count = count++;
+
+	return bpf_redirect_map(&xsk, 0, XDP_DROP);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xsk_xdp_metadata.h b/tools/testing/selftests/bpf/xsk_xdp_metadata.h
new file mode 100644
index 000000000000..943133da378a
--- /dev/null
+++ b/tools/testing/selftests/bpf/xsk_xdp_metadata.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct xdp_info {
+	__u64 count;
+} __attribute__((aligned(32)));
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a17655107a94..b65e0645b0cd 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -103,6 +103,7 @@
 #include <bpf/bpf.h>
 #include <linux/filter.h>
 #include "../kselftest.h"
+#include "xsk_xdp_metadata.h"
 
 static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
 static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
@@ -464,6 +465,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		ifobj->use_fill_ring = true;
 		ifobj->release_rx = true;
 		ifobj->validation_func = NULL;
+		ifobj->use_metadata = false;
 
 		if (i == 0) {
 			ifobj->rx_on = false;
@@ -798,6 +800,20 @@ static bool is_offset_correct(struct xsk_umem_info *umem, struct pkt_stream *pkt
 	return false;
 }
 
+static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
+{
+	void *data = xsk_umem__get_data(buffer, addr);
+	struct xdp_info *meta = data - sizeof(struct xdp_info);
+
+	if (meta->count != pkt->payload) {
+		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
+			       __func__, pkt->payload, meta->count);
+		return false;
+	}
+
+	return true;
+}
+
 static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 {
 	void *data = xsk_umem__get_data(buffer, addr);
@@ -959,7 +975,8 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
 			addr = xsk_umem__add_offset_to_addr(addr);
 
 			if (!is_pkt_valid(pkt, umem->buffer, addr, desc->len) ||
-			    !is_offset_correct(umem, pkt_stream, addr, pkt->addr))
+			    !is_offset_correct(umem, pkt_stream, addr, pkt->addr) ||
+			    (ifobj->use_metadata && !is_metadata_correct(pkt, umem->buffer, addr)))
 				return TEST_FAILURE;
 
 			if (ifobj->use_fill_ring)
@@ -1686,6 +1703,30 @@ static void testapp_xdp_drop(struct test_spec *test)
 	testapp_validate_traffic(test);
 }
 
+static void testapp_xdp_metadata_count(struct test_spec *test)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	struct bpf_map *data_map;
+	int count = 0;
+	int key = 0;
+
+	test_spec_set_name(test, "XDP_METADATA_COUNT");
+	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_populate_metadata,
+			       skel_tx->progs.xsk_xdp_populate_metadata,
+			       skel_rx->maps.xsk, skel_tx->maps.xsk);
+	test->ifobj_rx->use_metadata = true;
+
+	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
+	if (!data_map || !bpf_map__is_internal(data_map))
+		exit_with_error(ENOMEM);
+
+	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY))
+		exit_with_error(errno);
+
+	testapp_validate_traffic(test);
+}
+
 static void testapp_poll_txq_tmout(struct test_spec *test)
 {
 	test_spec_set_name(test, "POLL_TXQ_FULL");
@@ -1835,6 +1876,9 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 	case TEST_TYPE_XDP_DROP_HALF:
 		testapp_xdp_drop(test);
 		break;
+	case TEST_TYPE_XDP_METADATA_COUNT:
+		testapp_xdp_metadata_count(test);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 3e8ec7d8ec32..bdb4efedf3a9 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -88,6 +88,7 @@ enum test_type {
 	TEST_TYPE_STATS_FILL_EMPTY,
 	TEST_TYPE_BPF_RES,
 	TEST_TYPE_XDP_DROP_HALF,
+	TEST_TYPE_XDP_METADATA_COUNT,
 	TEST_TYPE_MAX
 };
 
@@ -158,6 +159,7 @@ struct ifobject {
 	bool use_fill_ring;
 	bool release_rx;
 	bool shared_umem;
+	bool use_metadata;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
 };
-- 
2.25.1

