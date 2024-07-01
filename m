Return-Path: <bpf+bounces-33520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9FE91E5A9
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F207B255E1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CA16E887;
	Mon,  1 Jul 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIeyOaty"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF316E89D;
	Mon,  1 Jul 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852233; cv=none; b=e9cW+OCuTldJqcW3DyEOhgLYWCto9MMM9MDEj8KuYxX34Bz7N5wDe/VO50002pyP6IIkc0hIssAvMAfEntcVo0WQAlQzQVJF1ouF2sjYNgOYDykLcOh54WMlJ+YhGuGnz4Rob80WQ/LbsryxLDl7nlrWwTC1WQyOgHLqj+WlCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852233; c=relaxed/simple;
	bh=+aplpqVJ07eRtUUaKaxoJja2/QF9BPnMBIwtZcITRG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWbc4OlNJNVr1q5aSGM4/QkCEsfB+WT3UrAELSHhPR8BzrCyeyoNKuVO1c8UzpdG3tG+9Du+kZYQC4UazVxk8DqTKf60W6E2XKg4KUoT+dz+hknOfCDgY6l2k/DhY6ZZTUP9vH64bdkQa5djASXTQ9h3ZHMT/cCukGXGoGZOxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIeyOaty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4CBC116B1;
	Mon,  1 Jul 2024 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852232;
	bh=+aplpqVJ07eRtUUaKaxoJja2/QF9BPnMBIwtZcITRG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIeyOatyjC5I2cxt5bqwMYOoGUcokRcF085YrekvPe7a/jNnr/r5Y25JJCEizd+bi
	 w5C7hXA/DX3TPo9ketPp/CCHbXEk0EcvpUYAk5bKlsvYsp3GQaCerGReJ5sM8Qp6M4
	 ZrBWetrrT/mll4FkT3/T2jWnf0WEzRuqw1gkfNyQsFZ3kCskp+IlQ0uSAT8AozhHKa
	 EQhmO4FOrvwrOwrNZdOxzQOfG+oe89P6QP1qLjYi3O64Zim3smbRA6e8uMXFc/si3O
	 pJHa6ysuEIW1jXmLXPrVNV6b09gHjmwkmMkjKaI8GN228aeUiUQhNHcp1ivp6YEDEN
	 Aeweh+ga0UMkw==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 8/9] selftests/bpf: Add uprobe session recursive test
Date: Mon,  1 Jul 2024 18:41:14 +0200
Message-ID: <20240701164115.723677-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701164115.723677-1-jolsa@kernel.org>
References: <20240701164115.723677-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test that verifies the cookie value is stored
properly when single uprobe-ed function is executed recursively.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 57 +++++++++++++++++++
 .../progs/uprobe_multi_session_recursive.c    | 44 ++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index d5f78fc61013..b521590fdbb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -8,6 +8,7 @@
 #include "uprobe_multi_usdt.skel.h"
 #include "uprobe_multi_session.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
+#include "uprobe_multi_session_recursive.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -34,6 +35,12 @@ noinline void usdt_trigger(void)
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
@@ -684,6 +691,54 @@ static void test_session_cookie_skel_api(void)
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
@@ -776,4 +831,6 @@ void test_uprobe_multi_test(void)
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
2.45.2


