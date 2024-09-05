Return-Path: <bpf+bounces-39001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF14896D79D
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B750B21081
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013B19ABB4;
	Thu,  5 Sep 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQavZxQd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF719415D;
	Thu,  5 Sep 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537122; cv=none; b=WJFpBBjUS5x5lAo9B/brGY5whFX1pzpF6BixZd8mOv5e6bka+XxrD8eRtTcquRJ9vyFuJmPjGWKl89Q3SUaxHkbvgHJ7YfhWHL4Qa2ZaTgnKxGd3f/Z+4gJkQHStXDNUF9Psup7QgbAv9TnMkTxwaZtEw9YLjmrgMsNt4Q4A2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537122; c=relaxed/simple;
	bh=9iP/a/0C/4mf7TSl4LPVhAesSJyyFh+wAjB+jhDjfNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkEcOnYDuuOCKoSQ8epjeSY1kLp8pqWfIPq/XWlouAFaDamAo9sf3jBkXofc62JeFJUV/MfsahUFoTW8SVOFueN1J0uBvjcHRT5UkaybFQqYSgTfX2dU3f8jJfnqwNxT0is1VbxEdO4mtm0K2ridDsF4Q8wrIZaCNki6zmrO9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQavZxQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE630C4CEC3;
	Thu,  5 Sep 2024 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725537122;
	bh=9iP/a/0C/4mf7TSl4LPVhAesSJyyFh+wAjB+jhDjfNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQavZxQdr0wBbbeK6n45c7TtfLHJySh2+Qh593SbgFv3CnG7vX5g0lxe7jJ/q2pn8
	 AJ/6r7WF7R2q2eJR0twp0zfcTQDaoZlP90FpCEbTaJgSP0TSedUqH+KFXYygEuH9Pe
	 65JczbNylMVX/GvNleEOMmhwmXk0JgdsIdzbh1p5LDTHCTF2MkNSBD868VmT/UOLWa
	 gJ0aziz7DRv1qHo0eIcGGeXEaB2UpUn2ueLH2oGYvd3nfSm5EPVbkqnlP0sq/K0aXl
	 TdwSkOxV9IWRyrBDf/8o0xrXjeycH7Ccl+XQqfL+EHifHm8BQxZheSpy4fZnzH2jiN
	 xXXi4hpiqUF5Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 3/4] selftests/bpf: Add uprobe multi pid filter test for fork-ed processes
Date: Thu,  5 Sep 2024 14:51:23 +0300
Message-ID: <20240905115124.1503998-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905115124.1503998-1-jolsa@kernel.org>
References: <20240905115124.1503998-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idea is to create and monitor 3 uprobes, each trigered in separate
process and make sure the bpf program gets executed just for the proper
PID specified via pid filter.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 67 +++++++++++++++++++
 .../bpf/progs/uprobe_multi_pid_filter.c       | 40 +++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 250eb47c68f9..9c2f99233304 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -7,6 +7,7 @@
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
 #include "uprobe_multi_consumers.skel.h"
+#include "uprobe_multi_pid_filter.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -935,6 +936,70 @@ static void test_consumers(void)
 	uprobe_multi_consumers__destroy(skel);
 }
 
+static struct bpf_program *uprobe_multi_program(struct uprobe_multi_pid_filter *skel, int idx)
+{
+	switch (idx) {
+	case 0: return skel->progs.uprobe_multi_0;
+	case 1: return skel->progs.uprobe_multi_1;
+	case 2: return skel->progs.uprobe_multi_2;
+	}
+	return NULL;
+}
+
+#define TASKS 3
+
+static void run_pid_filter(struct uprobe_multi_pid_filter *skel, bool retprobe)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .retprobe = retprobe);
+	struct bpf_link *link[TASKS] = {};
+	struct child child[TASKS] = {};
+	int i;
+
+	memset(skel->bss->test, 0, sizeof(skel->bss->test));
+
+	for (i = 0; i < TASKS; i++) {
+		if (!ASSERT_OK(spawn_child(&child[i]), "spawn_child"))
+			goto cleanup;
+		skel->bss->pids[i] = child[i].pid;
+	}
+
+	for (i = 0; i < TASKS; i++) {
+		link[i] = bpf_program__attach_uprobe_multi(uprobe_multi_program(skel, i),
+							   child[i].pid, "/proc/self/exe",
+							   "uprobe_multi_func_1", &opts);
+		if (!ASSERT_OK_PTR(link[i], "bpf_program__attach_uprobe_multi"))
+			goto cleanup;
+	}
+
+	for (i = 0; i < TASKS; i++)
+		kick_child(&child[i]);
+
+	for (i = 0; i < TASKS; i++) {
+		ASSERT_EQ(skel->bss->test[i][0], 1, "pid");
+		ASSERT_EQ(skel->bss->test[i][1], 0, "unknown");
+	}
+
+cleanup:
+	for (i = 0; i < TASKS; i++)
+		bpf_link__destroy(link[i]);
+	for (i = 0; i < TASKS; i++)
+		release_child(&child[i]);
+}
+
+static void test_pid_filter_process(void)
+{
+	struct uprobe_multi_pid_filter *skel;
+
+	skel = uprobe_multi_pid_filter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_pid_filter__open_and_load"))
+		return;
+
+	run_pid_filter(skel, false);
+	run_pid_filter(skel, true);
+
+	uprobe_multi_pid_filter__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -1027,4 +1092,6 @@ void test_uprobe_multi_test(void)
 		test_attach_uprobe_fails();
 	if (test__start_subtest("consumers"))
 		test_consumers();
+	if (test__start_subtest("filter_fork"))
+		test_pid_filter_process();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c b/tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c
new file mode 100644
index 000000000000..67fcbad36661
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 pids[3];
+__u32 test[3][2];
+
+static void update_pid(int idx)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid == pids[idx])
+		test[idx][0]++;
+	else
+		test[idx][1]++;
+}
+
+SEC("uprobe.multi")
+int uprobe_multi_0(struct pt_regs *ctx)
+{
+	update_pid(0);
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uprobe_multi_1(struct pt_regs *ctx)
+{
+	update_pid(1);
+	return 0;
+}
+
+SEC("uprobe.multi")
+int uprobe_multi_2(struct pt_regs *ctx)
+{
+	update_pid(2);
+	return 0;
+}
-- 
2.46.0


