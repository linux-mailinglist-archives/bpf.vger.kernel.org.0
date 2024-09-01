Return-Path: <bpf+bounces-38684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F380C9676CB
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 15:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675261F21A74
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1417DFF5;
	Sun,  1 Sep 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QWp8ZvcY"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD417DFEC
	for <bpf@vger.kernel.org>; Sun,  1 Sep 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198076; cv=none; b=bK7lMDI2ny6YiDKaxN80h3O9ryrRIWdN6BtHcX0aUpARJ3jOhembIERIbirAzW7ec3c2Bc/KflUYM+vsNfkjniR33oASumCsR5cz9w14Dx6Xcw0lvRalSoizNjInXYQDrzI0V1R11gchxHXy0GagzzV0pTsi9WlXm/9iLiXepUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198076; c=relaxed/simple;
	bh=CB9krOCCZUydcFRPKL9eAZfHHhNNTrwagbgeo9IorfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePxyt3+cixtzfcCM8JRy9pQY/hLl+VoDGvCveyL/vDN6B1n9BLBN/Fx3AgbGD0s5X+XsTkt106N7t1f1NG2k+1wp0ptVGexL2xLOxEmuvDEzo0Lmgxf9iIRxsY5sBFIRcUBE0kwRwL9DRV0L90l4JM6y1GE8uyTvwoIjtxfRmNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QWp8ZvcY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725198072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/fw2V2lsSEY6Zw7Gjns+M8Uy3pcrWYbLrye98HThtE=;
	b=QWp8ZvcYQPQiZTfoR56dpQ/pt/83p20IwXghAQHb+RO//X7RXcOA3MHCOjWqt3VTdvTQtM
	AYGoPinxTGKvni6s6UXu4Z+LHkYsYzPvoysH4IZJC6HV6gWmP9b0iToApA/A/VNM/Q6F07
	NemNeBqoH5rNdGEJcFf5OEesTYWjCY4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add testcases for another tailcall infinite loop fixing
Date: Sun,  1 Sep 2024 21:38:55 +0800
Message-ID: <20240901133856.64367-4-leon.hwang@linux.dev>
In-Reply-To: <20240901133856.64367-1-leon.hwang@linux.dev>
References: <20240901133856.64367-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The issue has been fixed on both x64 and arm64.

On x64:

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
334/26  tailcalls/tailcall_bpf2bpf_freplace:OK
334/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
334/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
334/29  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_3:OK
334/30  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_4:OK
334/31  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_5:OK
334     tailcalls:OK
Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED

on arm64:

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
334/26  tailcalls/tailcall_bpf2bpf_freplace:OK
334/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
334/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
334/29  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_3:OK
334/30  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_4:OK
334/31  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_5:OK
334     tailcalls:OK
Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 216 +++++++++++++++++-
 .../tailcall_bpf2bpf_hierarchy_freplace.c     |  30 +++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  37 ++-
 3 files changed, 279 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 21c5a37846ade..0faa0f57f71d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -5,6 +5,7 @@
 #include "tailcall_poke.skel.h"
 #include "tailcall_bpf2bpf_hierarchy2.skel.h"
 #include "tailcall_bpf2bpf_hierarchy3.skel.h"
+#include "tailcall_bpf2bpf_hierarchy_freplace.skel.h"
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 
@@ -1525,7 +1526,8 @@ static void test_tailcall_freplace(void)
 
 	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
 	freplace_prog = freplace_skel->progs.entry_freplace;
-	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
+	err = bpf_program__set_attach_target(freplace_prog, prog_fd,
+					     "subprog_tailcall_tc");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
 
@@ -1534,7 +1536,7 @@ static void test_tailcall_freplace(void)
 		goto out;
 
 	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
-						     "subprog");
+						     "subprog_tailcall_tc");
 	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
 		goto out;
 
@@ -1556,6 +1558,204 @@ static void test_tailcall_freplace(void)
 	tailcall_freplace__destroy(freplace_skel);
 }
 
+/* test_tailcall_bpf2bpf_freplace checks that the count value of the tail
+ * call limit enforcement matches with expectation for this case:
+ *
+ * entry_tc --> subprog_tailcall_tc --jump-> entry_freplace --tailcall-> entry_tc
+ *
+ * Meanwhile, check the failure that fails to attach tailcall-reachable freplace
+ * prog to not-tailcall-reachable subprog.
+ */
+static void test_tailcall_bpf2bpf_freplace(void)
+{
+	struct tailcall_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	char buff[128] = {};
+	int prog_fd, map_fd;
+	int err, i;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	freplace_skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     prog_fd, "subprog_tailcall_tc");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_freplace__load"))
+		goto out;
+
+	i = 0;
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tc");
+	if (!ASSERT_ERR_PTR(freplace_link, "attach_freplace fail"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, "subprog_tailcall_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_opts");
+	ASSERT_EQ(topts.retval, 34, "test_run_opts retval");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_freplace(bool freplace_subprog,
+						     bool tailcall_tc,
+						     bool target_entry2,
+						     int count1, int count2)
+{
+	struct tailcall_bpf2bpf_hierarchy_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	int freplace_prog_fd, prog_fd, map_fd;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	char buff[128] = {};
+	int err, i, val;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(target_entry2 ? tc_skel->progs.entry_tc_2 :
+				  tc_skel->progs.entry_tc);
+	freplace_skel = tailcall_bpf2bpf_hierarchy_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_bpf2bpf_hierarchy_freplace__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     prog_fd, freplace_subprog ?
+					     "subprog_tailcall_tc" : "entry_tc");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_bpf2bpf_hierarchy_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_bpf2bpf_hierarchy_freplace__load"))
+		goto out;
+
+	freplace_prog_fd = bpf_program__fd(freplace_skel->progs.entry_freplace);
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	val = tailcall_tc ? prog_fd : freplace_prog_fd;
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &val, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						     prog_fd, freplace_subprog ?
+						     "subprog_tailcall_tc" : "entry_tc");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_opts");
+	ASSERT_EQ(topts.retval, count1, "test_run_opts retval");
+
+	i = 0;
+	err = bpf_map_delete_elem(map_fd, &i);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_opts again");
+	ASSERT_EQ(topts.retval, count2, "test_run_opts retval again");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tailcall_bpf2bpf_hierarchy_freplace__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_1 checks the count value of tail
+ * call limit enforcement matches with expectation for this case:
+ *
+ *                                    subprog_tail --tailcall-> entry_freplace
+ * entry_tc --jump-> entry_freplace <
+ *                                    subprog_tail --tailcall-> entry_freplace
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_1(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(false, false, false, 34, 35);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_2 checks the count value of tail
+ * call limit enforcement matches with expectation for this case:
+ *
+ *                                                            subprog_tail --tailcall-> entry_freplace
+ * entry_tc --> subprog_tailcall_tc --jump-> entry_freplace <
+ *                                                            subprog_tail --tailcall-> entry_freplace
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_2(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(true, false, false, 34, 35);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_3 checks the count value of tail
+ * call limit enforcement matches with expectation for this case:
+ *
+ *                                                            subprog_tail --tailcall-> entry_tc
+ * entry_tc --> subprog_tailcall_tc --jump-> entry_freplace <
+ *                                                            subprog_tail --tailcall-> entry_tc
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_3(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(true, true, false, 34, 35);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_4 checks the count value of tail
+ * call limit enforcement matches with expectation for this case:
+ *
+ *                                                                              subprog_tail --tailcall-> entry_freplace
+ * entry_tc_2 --> subprog_tailcall_tc (call 10 times) --jump-> entry_freplace <
+ *                                                                              subprog_tail --tailcall-> entry_freplace
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_4(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(true, false, true, 43, 53);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_freplace_5 checks the count value of tail
+ * call limit enforcement matches with expectation for this case:
+ *
+ *                                                                              subprog_tail --tailcall-> entry_tc_2
+ * entry_tc_2 --> subprog_tailcall_tc (call 10 times) --jump-> entry_freplace <
+ *                                                                              subprog_tail --tailcall-> entry_tc_2
+ */
+static void test_tailcall_bpf2bpf_hierarchy_freplace_5(void)
+{
+	test_tailcall_bpf2bpf_hierarchy_freplace(true, true, true, 340, 350);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1606,4 +1806,16 @@ void test_tailcalls(void)
 	test_tailcall_bpf2bpf_hierarchy_3();
 	if (test__start_subtest("tailcall_freplace"))
 		test_tailcall_freplace();
+	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
+		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_1"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_1();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_2"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_2();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_3"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_3();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_4"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_4();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_freplace_5"))
+		test_tailcall_bpf2bpf_hierarchy_freplace_5();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c
new file mode 100644
index 0000000000000..6f7c1fac9ddb7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count = 0;
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+SEC("freplace")
+int entry_freplace(struct __sk_buff *skb)
+{
+	count++;
+	subprog_tail(skb);
+	subprog_tail(skb);
+	return count;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index 8a0632c37839a..beacf60a52677 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -4,11 +4,30 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+__noinline
+int subprog_tailcall_tc(struct __sk_buff *skb)
+{
+	int ret = 1;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	__sink(skb);
+	__sink(ret);
+	return ret;
+}
+
 __noinline
-int subprog(struct __sk_buff *skb)
+int subprog_tc(struct __sk_buff *skb)
 {
 	int ret = 1;
 
+	__sink(skb);
 	__sink(ret);
 	return ret;
 }
@@ -16,7 +35,21 @@ int subprog(struct __sk_buff *skb)
 SEC("tc")
 int entry_tc(struct __sk_buff *skb)
 {
-	return subprog(skb);
+	subprog_tc(skb);
+	return subprog_tailcall_tc(skb);
+}
+
+SEC("tc")
+int entry_tc_2(struct __sk_buff *skb)
+{
+	int ret, i;
+
+	for (i = 0; i < 10; i++) {
+		ret = subprog_tailcall_tc(skb);
+		__sink(ret);
+	}
+
+	return ret;
 }
 
 char __license[] SEC("license") = "GPL";
-- 
2.44.0


