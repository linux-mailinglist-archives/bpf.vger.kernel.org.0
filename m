Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5882654B805
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbiFNRsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 13:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344783AbiFNRsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 13:48:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C03326D6;
        Tue, 14 Jun 2022 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655228893; x=1686764893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jbyI7td2KRcKBkoA25WPiyBKC04wD7j6Wa+zSD6+2c=;
  b=bAaUNk1khy0JKszmgkFt1HV7T5VwBEf1ifSOAe0mcK6enMxiDygrvi/S
   g3hOpiDedHbqvJ2pFoE/wzY7goshDfiChSfjRfGz7cA+p/pf9m5I5TYFt
   ik3NyonvmRMxWGnQyDsAXKcS+IGXKAvcMJZLUW8bydSnlFf7G+XhBbsTB
   SXooccpOPLCdpgUlMasSR+IWyhfCFsQQ1WrLQsLYk57cQ5x2ENJOEL7ic
   OD8Zl5bqjyxDpoD/shyT+cZQreUGcU7lgTE3l6Gv/neye1QYALhK2YitF
   TLqucj8J6omC5aTC98vm3q2x/MV02yPH4qvxteSgWlfYSfskaf1NcdFm7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340356797"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340356797"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 10:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="570110093"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2022 10:48:00 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn@kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 bpf-next 04/10] selftests: xsk: query for native XDP support
Date:   Tue, 14 Jun 2022 19:47:43 +0200
Message-Id: <20220614174749.901044-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220614174749.901044-1-maciej.fijalkowski@intel.com>
References: <20220614174749.901044-1-maciej.fijalkowski@intel.com>
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

Currently, xdpxceiver assumes that underlying device supports XDP in
native mode - it is fine by now since tests can run only on a veth pair.
Future commit is going to allow running test suite against physical
devices, so let us query the device if it is capable of running XDP
programs in native mode. This way xdpxceiver will not try to run
TEST_MODE_DRV if device being tested is not supporting it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 36 ++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index e5992a6b5e09..a1e410f6a5d8 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -98,6 +98,8 @@
 #include <unistd.h>
 #include <stdatomic.h>
 #include <bpf/xsk.h>
+#include <bpf/bpf.h>
+#include <linux/filter.h>
 #include "xdpxceiver.h"
 #include "../kselftest.h"
 
@@ -1605,10 +1607,37 @@ static void ifobject_delete(struct ifobject *ifobj)
 	free(ifobj);
 }
 
+static bool is_xdp_supported(struct ifobject *ifobject)
+{
+	int flags = XDP_FLAGS_DRV_MODE;
+
+	LIBBPF_OPTS(bpf_link_create_opts, opts, .flags = flags);
+	struct bpf_insn insns[2] = {
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
+		BPF_EXIT_INSN()
+	};
+	int ifindex = if_nametoindex(ifobject->ifname);
+	int prog_fd, insn_cnt = ARRAY_SIZE(insns);
+	int err;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, NULL);
+	if (prog_fd < 0)
+		return false;
+
+	err = bpf_xdp_attach(ifindex, prog_fd, flags, NULL);
+	if (err)
+		return false;
+
+	bpf_xdp_detach(ifindex, flags, NULL);
+
+	return true;
+}
+
 int main(int argc, char **argv)
 {
 	struct pkt_stream *pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
+	int modes = TEST_MODE_SKB + 1;
 	u32 i, j, failed_tests = 0;
 	struct test_spec test;
 
@@ -1636,15 +1665,18 @@ int main(int argc, char **argv)
 	init_iface(ifobj_rx, MAC2, MAC1, IP2, IP1, UDP_PORT2, UDP_PORT1,
 		   worker_testapp_validate_rx);
 
+	if (is_xdp_supported(ifobj_tx))
+		modes++;
+
 	test_spec_init(&test, ifobj_tx, ifobj_rx, 0);
 	pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, PKT_SIZE);
 	if (!pkt_stream_default)
 		exit_with_error(ENOMEM);
 	test.pkt_stream_default = pkt_stream_default;
 
-	ksft_set_plan(TEST_MODE_MAX * TEST_TYPE_MAX);
+	ksft_set_plan(modes * TEST_TYPE_MAX);
 
-	for (i = 0; i < TEST_MODE_MAX; i++)
+	for (i = 0; i < modes; i++)
 		for (j = 0; j < TEST_TYPE_MAX; j++) {
 			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
 			run_pkt_test(&test, i, j);
-- 
2.27.0

