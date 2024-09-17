Return-Path: <bpf+bounces-40036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266D97AD31
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858B81C220F6
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854315ECC5;
	Tue, 17 Sep 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmEa9k5f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36415B561;
	Tue, 17 Sep 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563190; cv=none; b=KtWSWtgo9f8TNke/+583m+aaUy5ws72aSdIkjNxPTKl5jwm3JhY5kG3Ym126PdqYFhu0K0idWl2KOr6Q9unJub0E+qPy9G4/ZjooZLkpxMZ0Odh/OHvjCjOhFZbglvRkDkt8BqMgxpMu6bH90yzm9TaGudlqGWtoKV1rClSQzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563190; c=relaxed/simple;
	bh=ShXB489+gH5xzNqGVywABGETB3D2nsBgIplRythHk90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzNEQVUvyzYA5V9uum1qKOASVyq5Ip7NUbw1kvipCd9XOx9zNLrydCNX5QUFiDlg7iXGbaMs5w12epHvi2B4LPcEIMF7wdQvx6Fz+41YGkdfFpYh1zJMvWO5RGbdJJmjK4lE7HvD8WKWEWZ/s/ctBY68HS6mhGomq7VBcmu3zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmEa9k5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394B0C4CEC5;
	Tue, 17 Sep 2024 08:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563190;
	bh=ShXB489+gH5xzNqGVywABGETB3D2nsBgIplRythHk90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmEa9k5fuW96PPW4IIaDFygX4DTRCbo16wBnKl84PD3kdVGkf4agtbZuPD1BIDkgk
	 uDU9L5XoenaE+taNxmR8MqZrqwiDY8acguAJLsl7OaYgrNMuaCwuDyjVy5J3YTxuY9
	 VDV6okRnIMYVjYoJFcrHd5sOg9MHAvsUxucQt7MRsA6fITUKA7reE+4SweYJnwrUNW
	 OZL0cH8lH1cKWCYWL9WrmDJ2nh/v9ZzamWgQo9paTpHOJi4HCmKOe0xbfWB2w2EbdP
	 PQj+56dG1S4lDnl6uhFpsXGQTPOQ9mKdh+IjnZBuHmIQCqyj4drLDzdqPrnwX9tDWm
	 qEl6AwMx7suOw==
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
Subject: [PATCHv4 13/14] selftests/bpf: Add uprobe session single consumer test
Date: Tue, 17 Sep 2024 10:50:23 +0200
Message-ID: <20240917085024.765883-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++
 .../bpf/progs/uprobe_multi_session_single.c   | 44 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 210cdb620ee0..594aa8c06f58 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -7,6 +7,7 @@
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
 #include "uprobe_multi_session.skel.h"
+#include "uprobe_multi_session_single.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
 #include "uprobe_multi_verifier.skel.h"
@@ -669,6 +670,36 @@ static void test_session_skel_api(void)
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
@@ -835,6 +866,8 @@ void test_uprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("session"))
 		test_session_skel_api();
+	if (test__start_subtest("session_single"))
+		test_session_single_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
new file mode 100644
index 000000000000..1fa53d3785f6
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
+static int uprobe_multi_check(void *ctx, bool is_return, int idx)
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
+	return uprobe_multi_check(ctx, bpf_session_is_return(), 0);
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
+int uprobe_1(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, bpf_session_is_return(), 1);
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
+int uprobe_2(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, bpf_session_is_return(), 2);
+}
-- 
2.46.0


