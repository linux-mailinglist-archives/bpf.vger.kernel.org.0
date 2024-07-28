Return-Path: <bpf+bounces-35829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764793E4E9
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CEE2813DE
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E08383A2;
	Sun, 28 Jul 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fHcl5eUx"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A706374CC
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167239; cv=none; b=gc4b5rPyzZ+CJxlR9mH2LvX9U9W0h8pRYjQ0TZBCGES/viD48WkSeeoJZ0vUqBW3yClw0aPsWltKsMknaJuuPcaDR8JCctQwVzzXRRkWVDR2nCrCxj/oNVwRgL4zsAwc5t9Ft4NCCra0JupGFL9ZB+NtZ7o4cOCd0Kcbska21gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167239; c=relaxed/simple;
	bh=wHi/pJurCZ/VdAu/Ewv0T+VZJUwDBUm0kDmcef0HGSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYqbO+TnvHoy3ld+lTaRU3adKwWeYfG3Njn8uhYxMbLKHC7+UuIER/5oUYXlvHa1OdIRpsZsX7LZhg1fhaSvtyr3xXBHj8FBu5DvedaOi1aPRp9hYH3QVhpFFzGwExwUohXilOm3MolmBworZAkrg+I2zSfF7FXHZ7mNeEA0kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fHcl5eUx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722167234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkK1Y9hCmEC5l9aC+B6CsEWVLbhtS8P9KLQzN0GATAQ=;
	b=fHcl5eUxaZ7Y2OOFXdHGWgAWLFftghfFLJfm3qWGwWSx91+Mi8yBDWTg7cv6ySelZor/wl
	E6wcGQK50iqqdOsFhUMlmrsnpr/r7vnDDXOVwQG/1GFcQVj7PH1KMGFE8bWNYGTabft+gb
	8mTWGc71s3EVKbIftr5qEwNXvCHCEbs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	wutengda@huaweicloud.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for updating attached freplace prog to prog_array map
Date: Sun, 28 Jul 2024 19:46:12 +0800
Message-ID: <20240728114612.48486-3-leon.hwang@linux.dev>
In-Reply-To: <20240728114612.48486-1-leon.hwang@linux.dev>
References: <20240728114612.48486-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a selftest to confirm the issue, which gets -EINVAL when update
attached freplace prog to prog_array map, has been fixed.

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
328/25  tailcalls/tailcall_freplace:OK
328     tailcalls:OK
Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 65 ++++++++++++++++++-
 .../selftests/bpf/progs/tailcall_freplace.c   | 23 +++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 22 +++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index e01fabb8cc415..21c5a37846ade 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -5,7 +5,8 @@
 #include "tailcall_poke.skel.h"
 #include "tailcall_bpf2bpf_hierarchy2.skel.h"
 #include "tailcall_bpf2bpf_hierarchy3.skel.h"
-
+#include "tailcall_freplace.skel.h"
+#include "tc_bpf2bpf.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1495,6 +1496,66 @@ static void test_tailcall_bpf2bpf_hierarchy_3(void)
 	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
 }
 
+/* test_tailcall_freplace checks that the attached freplace prog is OK to
+ * update the prog_array map.
+ */
+static void test_tailcall_freplace(void)
+{
+	struct tailcall_freplace *freplace_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct bpf_program *freplace_prog;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	int prog_fd, map_fd;
+	char buff[128] = {};
+	int err, key;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	freplace_skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace__open"))
+		return;
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	freplace_prog = freplace_skel->progs.entry_freplace;
+	err = bpf_program__set_attach_target(freplace_prog, prog_fd, "subprog");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_freplace__load"))
+		goto out;
+
+	freplace_link = bpf_program__attach_freplace(freplace_prog, prog_fd,
+						     "subprog");
+	if (!ASSERT_OK_PTR(freplace_link, "attach_freplace"))
+		goto out;
+
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+	prog_fd = bpf_program__fd(freplace_prog);
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 34, "test_run retval");
+
+out:
+	bpf_link__destroy(freplace_link);
+	tc_bpf2bpf__destroy(tc_skel);
+	tailcall_freplace__destroy(freplace_skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1543,4 +1604,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_hierarchy_fentry_entry();
 	test_tailcall_bpf2bpf_hierarchy_2();
 	test_tailcall_bpf2bpf_hierarchy_3();
+	if (test__start_subtest("tailcall_freplace"))
+		test_tailcall_freplace();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
new file mode 100644
index 0000000000000..6713b809df442
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
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
+SEC("freplace")
+int entry_freplace(struct __sk_buff *skb)
+{
+	count++;
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return count;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
new file mode 100644
index 0000000000000..8a0632c37839a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__noinline
+int subprog(struct __sk_buff *skb)
+{
+	int ret = 1;
+
+	__sink(ret);
+	return ret;
+}
+
+SEC("tc")
+int entry_tc(struct __sk_buff *skb)
+{
+	return subprog(skb);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.44.0


