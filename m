Return-Path: <bpf+bounces-42476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A078F9A485A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A74D1F247D8
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F98208986;
	Fri, 18 Oct 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g42RI5FU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC4208984;
	Fri, 18 Oct 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284178; cv=none; b=Vpht0jdIjGY6q60IveGw1JJ0+pJontNILdag2mT0nMU2Uyn0f6w5NxoFy3CNtBh5IX2rBVcbk6IrXYPZ6hW4aPNwhtApB3O0WbVqfXZXqhpPGqhoIYG+mdjl3JpOmvWGLn9xZkMesi/d1uIoRDPEhoohcvJ9PO3I2Zyff6eSXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284178; c=relaxed/simple;
	bh=e/JgbYiCi/7UBhwN/I0I8AkHVXsJpTb8JQnSwgJINjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk2qiCHpmv0YI/YdBOnys2WvpdA4ZgGu7kMSbg6WcgLXzH5moEoEjzaSjFKpYB+KLnvjAs6fLx75gw5Hb5YBxvssVnIgum63vEJLyG5lLyG/tG8wmDHGrhBWWkgJG6Jq76TOBn0hJ6gT33QPLDSU71p9zvf7tVF2FSlJ8uzDqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g42RI5FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB86C4CEC3;
	Fri, 18 Oct 2024 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284178;
	bh=e/JgbYiCi/7UBhwN/I0I8AkHVXsJpTb8JQnSwgJINjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g42RI5FUqYvpCqgjSVAOjT/xJv1vRrxE50tNZteyEUIGWkxwGeIqbd8ykqDxRcXZp
	 XS/khEBGp0uMTchlOSo992Liesp9njgo6Fsu4gM8vzpbT+zt7McIR13YuPjhxQFuPs
	 MZ1pgWHEe3cbwwBySNzwh3nBNsrEWtq4UXw8BEDGiDjK4pgU13i/Io7E/1qT7dVg4+
	 0To4nWTntpiRSOakrMYD3+tcLc4wUVgZrd02siZlLpGNXlC0YzKz1CeFaGfJO3DjDZ
	 fPvcFHKX1C4nFSUb7w3v5mw2p/0B9Rjp446thD5//7kc0EuOjW/x4F/hzntUzXDkwA
	 Uq+GRSzgupzwQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv8 bpf-next 08/13] selftests/bpf: Add uprobe session recursive test
Date: Fri, 18 Oct 2024 22:41:04 +0200
Message-ID: <20241018204109.713820-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018204109.713820-1-jolsa@kernel.org>
References: <20241018204109.713820-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test that verifies the cookie value is stored
properly when single uprobe-ed function is executed recursively.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 57 +++++++++++++++++++
 .../progs/uprobe_multi_session_recursive.c    | 44 ++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index cc9030e86821..284cd7fce576 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -10,6 +10,7 @@
 #include "uprobe_multi_pid_filter.skel.h"
 #include "uprobe_multi_session.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
+#include "uprobe_multi_session_recursive.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -36,6 +37,12 @@ noinline void usdt_trigger(void)
 	STAP_PROBE(test, pid_filter_usdt);
 }
 
+noinline void uprobe_session_recursive(int i)
+{
+	if (i)
+		uprobe_session_recursive(i - 1);
+}
+
 struct child {
 	int go[2];
 	int c2p[2]; /* child -> parent channel */
@@ -1089,6 +1096,54 @@ static void test_session_cookie_skel_api(void)
 	uprobe_multi_session_cookie__destroy(skel);
 }
 
+static void test_session_recursive_skel_api(void)
+{
+	struct uprobe_multi_session_recursive *skel = NULL;
+	int i, err;
+
+	skel = uprobe_multi_session_recursive__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_recursive__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err = uprobe_multi_session_recursive__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi_session_recursive__attach"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(skel->bss->test_uprobe_cookie_entry); i++)
+		skel->bss->test_uprobe_cookie_entry[i] = i + 1;
+
+	uprobe_session_recursive(5);
+
+	/*
+	 *                                         entry uprobe:
+	 * uprobe_session_recursive(5) {             *cookie = 1, return 0
+	 *   uprobe_session_recursive(4) {           *cookie = 2, return 1
+	 *     uprobe_session_recursive(3) {         *cookie = 3, return 0
+	 *       uprobe_session_recursive(2) {       *cookie = 4, return 1
+	 *         uprobe_session_recursive(1) {     *cookie = 5, return 0
+	 *           uprobe_session_recursive(0) {   *cookie = 6, return 1
+	 *                                          return uprobe:
+	 *           } i = 0                          not executed
+	 *         } i = 1                            test_uprobe_cookie_return[0] = 5
+	 *       } i = 2                              not executed
+	 *     } i = 3                                test_uprobe_cookie_return[1] = 3
+	 *   } i = 4                                  not executed
+	 * } i = 5                                    test_uprobe_cookie_return[2] = 1
+	 */
+
+	ASSERT_EQ(skel->bss->idx_entry, 6, "idx_entry");
+	ASSERT_EQ(skel->bss->idx_return, 3, "idx_return");
+
+	ASSERT_EQ(skel->bss->test_uprobe_cookie_return[0], 5, "test_uprobe_cookie_return[0]");
+	ASSERT_EQ(skel->bss->test_uprobe_cookie_return[1], 3, "test_uprobe_cookie_return[1]");
+	ASSERT_EQ(skel->bss->test_uprobe_cookie_return[2], 1, "test_uprobe_cookie_return[2]");
+
+cleanup:
+	uprobe_multi_session_recursive__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -1189,4 +1244,6 @@ void test_uprobe_multi_test(void)
 		test_session_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
+	if (test__start_subtest("session_cookie_recursive"))
+		test_session_recursive_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
new file mode 100644
index 000000000000..8fbcd69fae22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+
+int idx_entry = 0;
+int idx_return = 0;
+
+__u64 test_uprobe_cookie_entry[6];
+__u64 test_uprobe_cookie_return[3];
+
+static int check_cookie(void)
+{
+	__u64 *cookie = bpf_session_cookie();
+
+	if (bpf_session_is_return()) {
+		if (idx_return >= ARRAY_SIZE(test_uprobe_cookie_return))
+			return 1;
+		test_uprobe_cookie_return[idx_return++] = *cookie;
+		return 0;
+	}
+
+	if (idx_entry >= ARRAY_SIZE(test_uprobe_cookie_entry))
+		return 1;
+	*cookie = test_uprobe_cookie_entry[idx_entry];
+	return idx_entry++ % 2;
+}
+
+
+SEC("uprobe.session//proc/self/exe:uprobe_session_recursive")
+int uprobe_recursive(struct pt_regs *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	return check_cookie();
+}
-- 
2.46.2


