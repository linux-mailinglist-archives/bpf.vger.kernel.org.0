Return-Path: <bpf+bounces-35596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80093B9D2
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E935528489C
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3281876;
	Thu, 25 Jul 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gqzAkxks"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD811193
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867601; cv=none; b=tZQuu0U5PApgtrGykSG5RW1a/DXBAeo7OJKCu1bb8yAHapCmSrxvKKbr7vAhErk1MHQ4Xj+9M5uXE+7t3NfVsb6ptZp6xeNFhdh9V/Y3T3x13p+8HkZRpyF4axrXJv+f0LAyJEHsJS/7gaFC7kGId2E5zJ0P8bNT7B/dSvMl9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867601; c=relaxed/simple;
	bh=E2VIj11pKoFdDYnJVTQbGx7YNios2qUz1J9z0VI2VLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9W8gmQye3YLuOD52Z+6WqJHrXHO3rnLuwdys2ah+bJoHiLFbHOgz5XZl52I8NdXBr0PidZ1hQ7ZPtyIz/4yRazK9I2FA/VcQ9MMwf7VqZAPff2UKfRicEixgky1Ni9NhTZrsUSHNns3q89J9riPQkz9ukqo/JsIuJWhGkYlluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gqzAkxks; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721867597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkSmsKt6HKmdu9ujaqGEMcW/QMInfbqNA1B/6UjAG1Q=;
	b=gqzAkxksB0pVzejrkMzlbM6BjCr77qFJ5Zar5IK6IUrJFvLh2pWfnQPGN4NpoNiCiiJg0q
	ttMe3NEtWJOLtCSwT1R5lK6Cx3H/1Lo1DtItT+ohf2fNIbF3RTQz73UbrdWgVoVIrIGS+l
	PWtwyCOP0PKcbRaEVuY5zLi68GJqX00=
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add testcase for updating attached freplace prog to PROG_ARRAY map
Date: Thu, 25 Jul 2024 08:32:51 +0800
Message-ID: <20240725003251.37855-3-leon.hwang@linux.dev>
In-Reply-To: <20240725003251.37855-1-leon.hwang@linux.dev>
References: <20240725003251.37855-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a selftest to confirm the issue, which gets -EINVAL when update
attached freplace prog to PROG_ARRAY map, has been fixed.

cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
327/25  tailcalls/tailcall_freplace:OK
327     tailcalls:OK
Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 76 ++++++++++++++++++-
 .../selftests/bpf/progs/tailcall_freplace.c   | 33 ++++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 23 ++++++
 3 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index e01fabb8cc415..f1145601c0005 100644
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
@@ -1495,6 +1496,77 @@ static void test_tailcall_bpf2bpf_hierarchy_3(void)
 	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
 }
 
+/* test_tailcall_freplace checks that the attached freplace prog is OK to
+ * update to PROG_ARRAY map.
+ */
+static void test_tailcall_freplace(void)
+{
+	struct tailcall_freplace *fr_skel = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	struct bpf_link *fr_link = NULL;
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
+	fr_skel = tailcall_freplace__open();
+	if (!ASSERT_OK_PTR(fr_skel, "open fr_skel"))
+		goto out;
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "open tc_skel"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry);
+	if (!ASSERT_GE(prog_fd, 0, "tc_skel entry prog_id"))
+		goto out;
+
+	err = bpf_program__set_attach_target(fr_skel->progs.entry,
+					     prog_fd, "subprog");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = tailcall_freplace__load(fr_skel);
+	if (!ASSERT_OK(err, "load fr_skel"))
+		goto out;
+
+	fr_link = bpf_program__attach_freplace(fr_skel->progs.entry,
+					       prog_fd, "subprog");
+	if (!ASSERT_OK_PTR(fr_link, "attach_freplace"))
+		goto out;
+
+	prog_fd = bpf_program__fd(fr_skel->progs.entry);
+	if (!ASSERT_GE(prog_fd, 0, "fr_skel entry prog_fd"))
+		goto out;
+
+	map_fd = bpf_map__fd(fr_skel->maps.jmp_table);
+	if (!ASSERT_GE(map_fd, 0, "fr_skel jmp_table map_fd"))
+		goto out;
+
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	prog_fd = bpf_program__fd(tc_skel->progs.entry);
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 34, "test_run retval");
+
+out:
+	bpf_link__destroy(fr_link);
+	tc_bpf2bpf__destroy(tc_skel);
+	tailcall_freplace__destroy(fr_skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1543,4 +1615,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_hierarchy_fentry_entry();
 	test_tailcall_bpf2bpf_hierarchy_2();
 	test_tailcall_bpf2bpf_hierarchy_3();
+	if (test__start_subtest("tailcall_freplace"))
+		test_tailcall_freplace();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace.c b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
new file mode 100644
index 0000000000000..80b5fa386ed9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_freplace.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
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
+__noinline
+int subprog(struct __sk_buff *skb)
+{
+	count++;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+
+	return count;
+}
+
+SEC("freplace")
+int entry(struct __sk_buff *skb)
+{
+	return subprog(skb);
+}
+
+char __license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
new file mode 100644
index 0000000000000..4810961554585
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+__noinline
+int subprog(struct __sk_buff *skb)
+{
+	volatile int ret = 1;
+
+	asm volatile (""::"r+"(ret));
+	return ret;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	return subprog(skb);
+}
+
+char __license[] SEC("license") = "GPL";
+
-- 
2.44.0


