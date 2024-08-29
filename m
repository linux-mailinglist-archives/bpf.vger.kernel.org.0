Return-Path: <bpf+bounces-38458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAFA965037
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E88B24CB8
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013971BD038;
	Thu, 29 Aug 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekz2nSD0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDD1BD002;
	Thu, 29 Aug 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960739; cv=none; b=IqeNFdEHP2jNnhFuaA7LK7OIp8l/f2h0nxmq8OWzNeSemh1IC0sVhV13hsvHmdn7MUgmyKWictRvy0QIV1JoftQ4dIl3RUPUkgxqcEaF6dYz7hjSzIxjdtcQJqzvTcne5+ePE7zt4zldwdXT6YDORcEZseZ4zU7jLCtgTF4Nm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960739; c=relaxed/simple;
	bh=hsofY5mS1ng3aVwCqPdHOCoXxhZ1oo3tDrHGXnPOec0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqga9d3g8vokRm4jTShWwzT6GLOM2Mfx30m2a7ichdnt4gdb0Ls08EAvqTjstwFZ8PifQjZhhyC2am8FzhhysFFQAfLug+20kaUypJJxyItd1JFHp8E9CP6ENf9WdHIy/OQO6qu1vqcdW6RuZbdkWsmaTrwBF0iY4/+iQNy4iJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekz2nSD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2295FC4CEC1;
	Thu, 29 Aug 2024 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724960739;
	bh=hsofY5mS1ng3aVwCqPdHOCoXxhZ1oo3tDrHGXnPOec0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekz2nSD0y7N2VWg2f1ezpLD5FwXmLI9Pl4JxxykMIVap5B8Zbc+W7IY0jHRd28g0u
	 2G0IAPSyDAzIWAMTC2OXbZiWHiKXdQP+4+NlxpPUj19zBYIBLEfa2F3JpnmdLcPD+m
	 nwVTck/6ckwm2QE9t+A7pjU7EZCvzcPSVryUyU0WJHrb+rTcez8wHrZ8DVu2t0N5tH
	 Qw+DCQOqAwd0n66ysJjPrQqFlwn9B+J/DClk/QJ8Y2aF+9pcOapwp8RoO26ya47lr+
	 BZ5sjKL8pvQ3foVQGRQ94AUM8GJUTWRIUsJlvkBX3yLJ2Ao4PEbY4a1iVWKuEZzK49
	 fA8qudoJP/eMw==
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add uprobe pid filter test for multiple processes
Date: Thu, 29 Aug 2024 21:45:05 +0200
Message-ID: <20240829194505.402807-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829194505.402807-1-jolsa@kernel.org>
References: <20240829194505.402807-1-jolsa@kernel.org>
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
 .../bpf/prog_tests/uprobe_multi_test.c        | 103 ++++++++++++++++++
 .../bpf/progs/uprobe_multi_pid_filter.c       |  61 +++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 250eb47c68f9..59c460675af9 100644
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
@@ -935,6 +936,106 @@ static void test_consumers(void)
 	uprobe_multi_consumers__destroy(skel);
 }
 
+typedef struct bpf_link *(create_link_t)(struct uprobe_multi_pid_filter *, int, int, bool);
+
+static struct bpf_program *uprobe_program(struct uprobe_multi_pid_filter *skel, int idx)
+{
+	switch (idx) {
+	case 0: return skel->progs.uprobe_0;
+	case 1: return skel->progs.uprobe_1;
+	case 2: return skel->progs.uprobe_2;
+	}
+	return NULL;
+}
+
+static struct bpf_link *create_link_uprobe(struct uprobe_multi_pid_filter *skel,
+					   int idx, int pid, bool retprobe)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe  = retprobe,
+		.func_name = "uprobe_multi_func_1",
+	);
+
+	return bpf_program__attach_uprobe_opts(uprobe_program(skel, idx), pid,
+					       "/proc/self/exe", 0, &opts);
+}
+
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
+static struct bpf_link *create_link_uprobe_multi(struct uprobe_multi_pid_filter *skel,
+						 int idx, int pid, bool retprobe)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .retprobe = retprobe);
+
+	return bpf_program__attach_uprobe_multi(uprobe_multi_program(skel, idx), pid,
+						"/proc/self/exe", "uprobe_multi_func_1", &opts);
+}
+
+#define TASKS 3
+
+static void run_pid_filter(struct uprobe_multi_pid_filter *skel,
+			   create_link_t create_link, bool retprobe)
+{
+	struct bpf_link *link[TASKS] = {};
+	struct child child[TASKS] = {};
+	int i;
+
+	printf("%s retprobe %d\n", create_link == create_link_uprobe ? "uprobe" : "uprobe_multi",
+		retprobe);
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
+		link[i] = create_link(skel, i, child[i].pid, retprobe);
+		if (!ASSERT_OK_PTR(link[i], "create_link"))
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
+	run_pid_filter(skel, create_link_uprobe, false);
+	run_pid_filter(skel, create_link_uprobe, true);
+	run_pid_filter(skel, create_link_uprobe_multi, false);
+	run_pid_filter(skel, create_link_uprobe_multi, true);
+
+	uprobe_multi_pid_filter__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -1027,4 +1128,6 @@ void test_uprobe_multi_test(void)
 		test_attach_uprobe_fails();
 	if (test__start_subtest("consumers"))
 		test_consumers();
+	if (test__start_subtest("filter_process"))
+		test_pid_filter_process();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c b/tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c
new file mode 100644
index 000000000000..260d46406e47
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c
@@ -0,0 +1,61 @@
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
+
+SEC("uprobe")
+int uprobe_0(struct pt_regs *ctx)
+{
+	update_pid(0);
+	return 0;
+}
+
+SEC("uprobe")
+int uprobe_1(struct pt_regs *ctx)
+{
+	update_pid(1);
+	return 0;
+}
+
+SEC("uprobe")
+int uprobe_2(struct pt_regs *ctx)
+{
+	update_pid(2);
+	return 0;
+}
-- 
2.46.0


