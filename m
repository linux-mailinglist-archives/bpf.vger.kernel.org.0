Return-Path: <bpf+bounces-44351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC89C1E65
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFF41F232B6
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75801F471E;
	Fri,  8 Nov 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY8RSN89"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFB1401C;
	Fri,  8 Nov 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073698; cv=none; b=SqM4dRL3EYzvzGF7k6kRdbUwwPScu+xpNPyQ2luhIwDHS53Efp9TBbij4GuXJquCQEfI7g3n7pyc1Qmjf7d/siHdrLna0+r5Bnik1/07OBqY5D4AWja+N1OrfBD3nFhLM/+8EAlionAaGrFSULRjwFacw/6ZbFj7cWooWmdsgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073698; c=relaxed/simple;
	bh=3LNaXCCN5bYz0E0+hXQcyWtC+0ealvGqMW8XnmzMv+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLAf5+UPOdLueC224GL41sJXCtyBvwjruoulJhc1CTGHi0xOkeO8OsU6Z0JpajCuIuA3SpM4jL+UtSXAWxqivrOmjrpelC2TwsEPk+DDaXW07UHI2sgGBOyM7zFT/ccDBWzV+p7Lo2KOzetuL9qtmhtUsRLfQcgjxSZFc/Rc1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY8RSN89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDD8C4CECD;
	Fri,  8 Nov 2024 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073697;
	bh=3LNaXCCN5bYz0E0+hXQcyWtC+0ealvGqMW8XnmzMv+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fY8RSN89hzpTHclQTW1DjV+SOqabit3tsafc4PFNWb6QQjqlpysnw6gPDA9OvXZSQ
	 NgAbb0I6IIkNf/nTtelqfIgOmYwpVhAAJb1hLPW3n+Qh6oLvSBDCBD4/qba8UCTwiR
	 +qlD8H1OjLfNWJWCv7a2bFQnNq70LF4+v/Wm4hA8TVe07R9VvG9LBqM4AUIrd3dw7E
	 Ymw+z+GTa7+wnwz2BxwtstwjRpw/cwsScTE4BaiqMiZr2GL0851jjB+N5uJ6TNL4Yi
	 dvyOZ2h3olyzxEVfbNuQhyiozlOyVVjD1OWMyUfOrrJyiNZj/7UoA23hCssoAjHPKh
	 v5KOSOt03pzjg==
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
Subject: [PATCHv9 bpf-next 11/13] selftests/bpf: Add uprobe session single consumer test
Date: Fri,  8 Nov 2024 14:45:42 +0100
Message-ID: <20241108134544.480660-12-jolsa@kernel.org>
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

Testing that the session ret_handler bypass works on single
uprobe with multiple consumers, each with different session
ignore return value.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++
 .../bpf/progs/uprobe_multi_session_single.c   | 44 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 5dad31d1b606..93f5cabd6d01 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -9,6 +9,7 @@
 #include "uprobe_multi_consumers.skel.h"
 #include "uprobe_multi_pid_filter.skel.h"
 #include "uprobe_multi_session.skel.h"
+#include "uprobe_multi_session_single.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
 #include "uprobe_multi_verifier.skel.h"
@@ -1071,6 +1072,36 @@ static void test_session_skel_api(void)
 	uprobe_multi_session__destroy(skel);
 }
 
+static void test_session_single_skel_api(void)
+{
+	struct uprobe_multi_session_single *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	int err;
+
+	skel = uprobe_multi_session_single__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_single__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err = uprobe_multi_session_single__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi_session_single__attach"))
+		goto cleanup;
+
+	uprobe_multi_func_1();
+
+	/*
+	 * We expect consumer 0 and 2 to trigger just entry handler (value 1)
+	 * and consumer 1 to hit both (value 2).
+	 */
+	ASSERT_EQ(skel->bss->uprobe_session_result[0], 1, "uprobe_session_result_0");
+	ASSERT_EQ(skel->bss->uprobe_session_result[1], 2, "uprobe_session_result_1");
+	ASSERT_EQ(skel->bss->uprobe_session_result[2], 1, "uprobe_session_result_2");
+
+cleanup:
+	uprobe_multi_session_single__destroy(skel);
+}
+
 static void test_session_cookie_skel_api(void)
 {
 	struct uprobe_multi_session_cookie *skel = NULL;
@@ -1245,6 +1276,8 @@ void test_uprobe_multi_test(void)
 		test_pid_filter_process(true);
 	if (test__start_subtest("session"))
 		test_session_skel_api();
+	if (test__start_subtest("session_single"))
+		test_session_single_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
new file mode 100644
index 000000000000..7c960376ae97
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
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
+__u64 uprobe_session_result[3] = {};
+int pid = 0;
+
+static int uprobe_multi_check(void *ctx, int idx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	uprobe_session_result[idx]++;
+
+	/* only consumer 1 executes return probe */
+	if (idx == 0 || idx == 2)
+		return 1;
+
+	return 0;
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
+int uprobe_0(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, 0);
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
+int uprobe_1(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, 1);
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
+int uprobe_2(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, 2);
+}
-- 
2.47.0


