Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220E022CC5D
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGXRlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 13:41:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:38188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgGXRlO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 13:41:14 -0400
IronPort-SDR: ZrbXH8ijgcqSsxfxm8UOmIu3mvkSWyXTg4tBAtt1QQRSPxzuxeaSB8Zhsw7wCr1IMy/azgvlgi
 A2MiMy0WUhNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="168883196"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="168883196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:41:11 -0700
IronPort-SDR: 6e/sdXsSL/1qTo780V27SINW3MAdhlHuIiXymTQAeY7Xx7dazBx/MI+JAyQpuvJ4lfc4JzYM5M
 dPlNOjN+DkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="463300050"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2020 10:41:09 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 bpf-next 6/6] selftests: bpf: add dummy prog for bpf2bpf with tailcall
Date:   Fri, 24 Jul 2020 19:35:57 +0200
Message-Id: <20200724173557.5764-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724173557.5764-1-maciej.fijalkowski@intel.com>
References: <20200724173557.5764-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce 6th test to taicalls kselftest that checks if tailcall can be
correctly executed from the BPF subprogram.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/tailcall6.c | 38 +++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall6.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index bb8fe646dd9f..192c94896809 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -472,6 +473,88 @@ static void test_tailcall_5(void)
 	bpf_object__close(obj);
 }
 
+/* test_tailcall_6 purpose is to make sure that tailcalls are working
+ * correctly in correlation with BPF subprograms
+ */
+static void test_tailcall_6(void)
+{
+	int err, map_fd, prog_fd, main_fd, i;
+	struct bpf_map *prog_array;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	__u32 retval, duration;
+	char prog_name[32];
+
+	err = bpf_prog_load("tailcall6.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+			    &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	prog = bpf_object__find_program_by_title(obj, "classifier");
+	if (CHECK_FAIL(!prog))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (CHECK_FAIL(main_fd < 0))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(obj, "jmp_table");
+	if (CHECK_FAIL(!prog_array))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (CHECK_FAIL(map_fd < 0))
+		goto out;
+
+	/* nop -> jmp */
+	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+
+		prog = bpf_object__find_program_by_title(obj, prog_name);
+		if (CHECK_FAIL(!prog))
+			goto out;
+
+		prog_fd = bpf_program__fd(prog);
+		if (CHECK_FAIL(prog_fd < 0))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+		if (CHECK_FAIL(err))
+			goto out;
+	}
+
+	err = bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
+				0, &retval, &duration);
+	CHECK(err || retval != 1, "tailcall",
+	      "err %d errno %d retval %d\n", err, errno, retval);
+
+	/* jmp -> nop, call subprog that will do tailcall */
+	i = 1;
+	err = bpf_map_delete_elem(map_fd, &i);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	err = bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
+				0, &retval, &duration);
+	CHECK(err || retval != 0, "tailcall", "err %d errno %d retval %d\n",
+	      err, errno, retval);
+
+	/* make sure that subprog can access ctx and entry prog that
+	 * called this subprog can properly return
+	 */
+	i = 0;
+	err = bpf_map_delete_elem(map_fd, &i);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	err = bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
+				0, &retval, &duration);
+	CHECK(err || retval != 108, "tailcall", "err %d errno %d retval %d\n",
+	      err, errno, retval);
+out:
+	bpf_object__close(obj);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -484,4 +567,6 @@ void test_tailcalls(void)
 		test_tailcall_4();
 	if (test__start_subtest("tailcall_5"))
 		test_tailcall_5();
+	if (test__start_subtest("tailcall_6"))
+		test_tailcall_6();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall6.c b/tools/testing/selftests/bpf/progs/tailcall6.c
new file mode 100644
index 000000000000..e72ca5869b58
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall6.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+#define TAIL_FUNC(x) 				\
+	SEC("classifier/" #x)			\
+	int bpf_func_##x(struct __sk_buff *skb)	\
+	{					\
+		return x;			\
+	}
+TAIL_FUNC(0)
+TAIL_FUNC(1)
+
+static __attribute__ ((noinline))
+int subprog_tail(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &jmp_table, 0);
+
+	return skb->len * 2;
+}
+
+SEC("classifier")
+int entry(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &jmp_table, 1);
+
+	return subprog_tail(skb);
+}
+
+char __license[] SEC("license") = "GPL";
+int _version SEC("version") = 1;
-- 
2.20.1

