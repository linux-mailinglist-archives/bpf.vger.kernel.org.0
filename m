Return-Path: <bpf+bounces-42479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91209A4861
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5C0B21093
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56C20E02B;
	Fri, 18 Oct 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo0HTjTI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20E209F5A;
	Fri, 18 Oct 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284214; cv=none; b=PjV2TVOH5Qcv5CryauLowCVHYGE9dMuCAws15s4bPPrrB8g63llIFGP0tT08Gz9wdDEqs+KcklPwfhINW+pdpUvfRCRXvROLEcAWDetmHU+nCqIAhWelckhx5nrAhL9Y+vGzf5kAalj56I/oPbzmv4hZdBM9QvcCua5VJme3xHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284214; c=relaxed/simple;
	bh=/2llFpdGYPtAAfCPyuTx0mCmbSBP7WmIfDSVF0KVTJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4wzg275xw82CZCAYJfkFOgzautEyKweYhlYPqZFTfczXQ7i5LK2cwOz6WKpB2POnMqxL3CFK0mCd0IWtzAeVnW3faiFGfhTzSb1N3garzK1hxzyHSICEHOx61Ds0CiJwfb8Lg1phRwyqcFRVjJcG+hCP36MC53nvG2VujcF3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo0HTjTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA1BC4CEC3;
	Fri, 18 Oct 2024 20:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284214;
	bh=/2llFpdGYPtAAfCPyuTx0mCmbSBP7WmIfDSVF0KVTJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wo0HTjTIhvAt6DWRCDEY6TvBmAb1JI6iOVas0rBJ1/lnX0D+0rCvlr84HgSXmoRwm
	 K8rAcHuEyTHt5Nnn4zu1oqF+9mB5K0TXoQn18oY2iNWQ9yRAJ5C8ESscF7h4DzHyjR
	 HbPAGnofcdbW/71SBDkdVMWgouxA4ox1Y79tcWyvaIRoeaLKR2irMN4886Ps7CQ72p
	 Zn5K4MF8OHD1tjStZuXsaGy6c1lh0oqBFDd91SgvElcD0Wv3KMV2f9Klg8CLZAS360
	 fZWYj0lxOCfUdmmANhlAQ6oSsNmpPKIhDVAWCZKHXAzRY6R7jHpYiM3KUohpRrtgg2
	 J+VvyzpXeIuaQ==
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
Subject: [PATCHv8 bpf-next 11/13] selftests/bpf: Add uprobe session single consumer test
Date: Fri, 18 Oct 2024 22:41:07 +0200
Message-ID: <20241018204109.713820-12-jolsa@kernel.org>
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
index e693eeb1a5a5..7e0228f8fcfc 100644
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
@@ -1069,6 +1070,36 @@ static void test_session_skel_api(void)
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
@@ -1243,6 +1274,8 @@ void test_uprobe_multi_test(void)
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
2.46.2


