Return-Path: <bpf+bounces-41627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7244999376
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DA01C2297E
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4141E47C9;
	Thu, 10 Oct 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5lzm4Jg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3721E32D4;
	Thu, 10 Oct 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591101; cv=none; b=hlXW/Kn2Qatk36f2Q56kTkXfCBsV15yx/3WHP+0atXE5CSlDs/UAR6r7Ieb3/3F2ZoeXwxd5x6aqyQuSc3uk/UQjPM0IbiS5dJ7eRjqsGEy91/S+I777ELoNCz5KrfdRbCbxr9zIBmF0k5K/Srp5XDR8ObByfe+rKvpCY2pG/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591101; c=relaxed/simple;
	bh=GYGtF9yDfymiuEvjDMpm+NelQffajB36h2rBIDSO+Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpceNNCgO4zk3ts3ePeK+b4E6gTTcgORK6uXGOgh6Oo/faybhfU3hr8lIcHemzlLl4+6iFKHL0OmUxuQhqpFKKJPECWpU7GEghZfuhDuM4lSZa1pnQgE+2DWVxX4740cW0EWpwTQw5UEXqmdGXrSyunKW2kDkIpYo146L0h+NSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5lzm4Jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C41C4CECC;
	Thu, 10 Oct 2024 20:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591100;
	bh=GYGtF9yDfymiuEvjDMpm+NelQffajB36h2rBIDSO+Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5lzm4JguS2XbAp/fWMjp72NZgC+85khA5GEVxcwEm7j39TS750tfUVF4Zf3tJ7mP
	 IjOGOpPTYs3yqxNy0Ig+ONxOqNpqJzqELbhMa80FuFw13GBQR+FIZtIJi5thnmv9EQ
	 6NPAhCODiC2FqDwwGRMfJnlfgIM7mKlZUcWdqHWJgAIYFbpcaxmzU2bqyezhVEhU7H
	 A9ni12M64c8W52EZNjxcC4bEyBwMA4mSHJwXshw8eXquj0xjP0r7FvyOe3ysgXXGqY
	 +Q0JRhW/VA2HPO54s4jZ7qQl/VM1gMcFhVLWrOBK3+FUQ1bNjXntz0XG48kFFwIDhZ
	 S0rD5TjvZ2YOQ==
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
Subject: [PATCHv6 bpf-next 08/16] selftests/bpf: Add uprobe session test
Date: Thu, 10 Oct 2024 22:09:49 +0200
Message-ID: <20241010200957.2750179-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test and testing that the entry program
return value controls execution of the return probe program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 47 ++++++++++++
 .../bpf/progs/uprobe_multi_session.c          | 71 +++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2c39902b8a09..b10d2dadb462 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -8,6 +8,7 @@
 #include "uprobe_multi_usdt.skel.h"
 #include "uprobe_multi_consumers.skel.h"
 #include "uprobe_multi_pid_filter.skel.h"
+#include "uprobe_multi_session.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -1015,6 +1016,50 @@ static void test_pid_filter_process(bool clone_vm)
 	uprobe_multi_pid_filter__destroy(skel);
 }
 
+static void test_session_skel_api(void)
+{
+	struct uprobe_multi_session *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = uprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_session__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+	skel->bss->user_ptr = test_data;
+
+	err = uprobe_multi_session__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi_session__attach"))
+		goto cleanup;
+
+	/* trigger all probes */
+	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
+	skel->bss->uprobe_multi_func_2_addr = (__u64) uprobe_multi_func_2;
+	skel->bss->uprobe_multi_func_3_addr = (__u64) uprobe_multi_func_3;
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	/*
+	 * We expect 2 for uprobe_multi_func_2 because it runs both entry/return probe,
+	 * uprobe_multi_func_[13] run just the entry probe. All expected numbers are
+	 * doubled, because we run extra test for sleepable session.
+	 */
+	ASSERT_EQ(skel->bss->uprobe_session_result[0], 2, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_session_result[1], 4, "uprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uprobe_session_result[2], 2, "uprobe_multi_func_3_result");
+
+	/* We expect increase in 3 entry and 1 return session calls -> 4 */
+	ASSERT_EQ(skel->bss->uprobe_multi_sleep_result, 4, "uprobe_multi_sleep_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	uprobe_multi_session__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -1111,4 +1156,6 @@ void test_uprobe_multi_test(void)
 		test_pid_filter_process(false);
 	if (test__start_subtest("filter_clone_vm"))
 		test_pid_filter_process(true);
+	if (test__start_subtest("session"))
+		test_session_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
new file mode 100644
index 000000000000..30bff90b68dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
@@ -0,0 +1,71 @@
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
+__u64 uprobe_multi_func_1_addr = 0;
+__u64 uprobe_multi_func_2_addr = 0;
+__u64 uprobe_multi_func_3_addr = 0;
+
+__u64 uprobe_session_result[3] = {};
+__u64 uprobe_multi_sleep_result = 0;
+
+void *user_ptr = 0;
+int pid = 0;
+
+static int uprobe_multi_check(void *ctx, bool is_return)
+{
+	const __u64 funcs[] = {
+		uprobe_multi_func_1_addr,
+		uprobe_multi_func_2_addr,
+		uprobe_multi_func_3_addr,
+	};
+	unsigned int i;
+	__u64 addr;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	addr = bpf_get_func_ip(ctx);
+
+	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
+		if (funcs[i] == addr) {
+			uprobe_session_result[i]++;
+			break;
+		}
+	}
+
+	/* only uprobe_multi_func_2 executes return probe */
+	if ((addr == uprobe_multi_func_1_addr) ||
+	    (addr == uprobe_multi_func_3_addr))
+		return 1;
+
+	return 0;
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
+int uprobe(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, bpf_session_is_return());
+}
+
+static __always_inline bool verify_sleepable_user_copy(void)
+{
+	char data[9];
+
+	bpf_copy_from_user(data, sizeof(data), user_ptr);
+	return bpf_strncmp(data, sizeof(data), "test_data") == 0;
+}
+
+SEC("uprobe.session.s//proc/self/exe:uprobe_multi_func_*")
+int uprobe_sleepable(struct pt_regs *ctx)
+{
+	if (verify_sleepable_user_copy())
+		uprobe_multi_sleep_result++;
+	return uprobe_multi_check(ctx, bpf_session_is_return());
+}
-- 
2.46.2


