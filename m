Return-Path: <bpf+bounces-44348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B59C1E5D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A7B1F23159
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC33B1F4274;
	Fri,  8 Nov 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVo0EZ2K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D61EF098;
	Fri,  8 Nov 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073663; cv=none; b=ncd+/C2x4uBchwR1+TAhp/N23bLjIqaY0jmLvcWWZ4EZ0DAjEVwauFLV0rdfx3NZMrUBZ4+U7SEUvbDsOA8UiogYm/a9Unff9rt4G9nD7AyDBcklRYfZRZ8IHpejqvfXwEiP9UB4BfrcEtJCl/BFqX+5xQscSKOLSZLrtYJ6vbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073663; c=relaxed/simple;
	bh=ha7AcA7R3i4kQJ9vwuQyBMO+nVNqQ1j/M8E3Kb/Bnvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqIXYDc3qliWSpdBY1IRgyH9FzjldPi25cin+Z8H9IpmvEbWiamippojEGHN6oz0di0UE07ciraScHM8poTKLBm6KvZsI4i0GNOHKo7dDm8DQpeB7IM90sL4MxenB16BWTWp3MJ/UJLcLyY21mf9dDQkVMsDkHi5LF+2QEC33IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVo0EZ2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1A8C4CECD;
	Fri,  8 Nov 2024 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073662;
	bh=ha7AcA7R3i4kQJ9vwuQyBMO+nVNqQ1j/M8E3Kb/Bnvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVo0EZ2KAXAlIDzFHiVfNHhvOntmsUA4fBhU9iwB02VqOwKVxSU8j22YYfAGcFDht
	 y0AW80Wli3aNNxowSaySF8m0tSX+IGz9zHscVk34f1f4+7NQNbgeTxMbPhit1iUaYv
	 KfLL4SywbnWnyYJk0qIvcxPIGneYndUQ/cwJ8i8nJ8R0T7fJHrHUT5xdSGmS8Dwoa7
	 lDearAD6XRlgs1D4XCOeU83GNA2vmGIcAcI9Ph15/HSUG7/2RRLrI1Yq0Jv4YWTDlq
	 0NWuaQlk4/bo+5vHSnIpP0JRakyw+KQUhe6s59wa50nSNjy56RHV9BC527G2NgZRJX
	 oxilJo0popR9g==
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
Subject: [PATCHv9 bpf-next 08/13] selftests/bpf: Add uprobe session recursive test
Date: Fri,  8 Nov 2024 14:45:39 +0100
Message-ID: <20241108134544.480660-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108134544.480660-1-jolsa@kernel.org>
References: <20241108134544.480660-1-jolsa@kernel.org>
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
index 986852ec26f5..b9448fb63a19 100644
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
@@ -1091,6 +1098,54 @@ static void test_session_cookie_skel_api(void)
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
@@ -1191,4 +1246,6 @@ void test_uprobe_multi_test(void)
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
2.47.0


