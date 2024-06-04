Return-Path: <bpf+bounces-31383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC988FBD06
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6921C28578C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448A14D44E;
	Tue,  4 Jun 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A27RG7p0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215F14B097;
	Tue,  4 Jun 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531464; cv=none; b=fMfI+hvjk62mi4Wc+JnL2WJ+RVYJaSUTxrL8O83lqpCyqcbtSPsnoq5vPSzb8eS3tAlehnbivdg/BUX/24vbV4lXP92C0qRAPp/epkPzVXddMbpvPMpcHLFif4TYsf/SKWuq1BcJ9UzVC44Pm//+lEhRu3pW3QalWnWhDCmgv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531464; c=relaxed/simple;
	bh=hu7KQGmdhNivcXLEk2nPk2e4zfC0G+cAgMVE0tYtsfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOyK4XD4aAQFg+DkpjPIhQVDgS5hoTL7chLYWXzrVhRvyxhWMebQi+zCfkrRjv5kYYK5TJr56iDWCZqcJyvcYPHQPAV/9pYOdpQsGGssjaJFfzp1VElf0U3Z0Fw4KIacZG6K94JsCtURuaVgacV8UcpF0ztOu1jGLSDyrTeF3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A27RG7p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2463C3277B;
	Tue,  4 Jun 2024 20:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531464;
	bh=hu7KQGmdhNivcXLEk2nPk2e4zfC0G+cAgMVE0tYtsfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A27RG7p0Ut4hS8633QUIShMZWre3yWrMVdDj32CeBfvfHNHTChdE0xeZyeftqNNlS
	 svhEuye941yg/qlaFWkXL7i+gDayzw5dJH4l4qKJPHsHv4GJdAx9Y1Bl97d+pkrALT
	 waFQQ5O0nZQRdSzXRtSDFkJgdpbagwZ6q/URHeSCzys/g5lzeVA/3QmLNRvCI7wHQl
	 /UzBPVqP6PL48UoDYKrU4tPLjnKVIfJEHFu0uSVpJH/ZR9QUe7Xhnt7VyYa1tnZFWD
	 UPid2GcHQG6PfXrAf1Ugay5LwIdhIXOSOamr5kErSz/P/MfFLC+FhrRgCJMNshKRbs
	 R7h8QjVN3X7MQ==
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
Subject: [RFC bpf-next 09/10] selftests/bpf: Add uprobe session cookie test
Date: Tue,  4 Jun 2024 22:02:20 +0200
Message-ID: <20240604200221.377848-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test that verifies the cookie value
get properly propagated from entry to return program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 31 ++++++++++++
 .../bpf/progs/uprobe_multi_session_cookie.c   | 50 +++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 4bff681f0d7d..34671253e130 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
 #include "uprobe_multi_session.skel.h"
+#include "uprobe_multi_session_cookie.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 
@@ -558,6 +559,34 @@ static void test_session_error_multiple_instances(void)
 	uprobe_multi_session__destroy(skel_2);
 }
 
+static void test_session_cookie_skel_api(void)
+{
+	struct uprobe_multi_session_cookie *skel = NULL;
+	int err;
+
+	skel = uprobe_multi_session_cookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err = uprobe_multi_session_cookie__attach(skel);
+	if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
+		goto cleanup;
+
+	/* trigger all probes */
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	ASSERT_EQ(skel->bss->test_uprobe_1_result, 1, "test_uprobe_1_result");
+	ASSERT_EQ(skel->bss->test_uprobe_2_result, 2, "test_uprobe_2_result");
+	ASSERT_EQ(skel->bss->test_uprobe_3_result, 3, "test_uprobe_3_result");
+
+cleanup:
+	uprobe_multi_session_cookie__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -650,4 +679,6 @@ void test_uprobe_multi_test(void)
 		test_session_skel_api();
 	if (test__start_subtest("session_errors"))
 		test_session_error_multiple_instances();
+	if (test__start_subtest("session_cookie"))
+		test_session_cookie_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
new file mode 100644
index 000000000000..ea41503fad18
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+
+__u64 test_uprobe_1_result = 0;
+__u64 test_uprobe_2_result = 0;
+__u64 test_uprobe_3_result = 0;
+
+static int check_cookie(__u64 val, __u64 *result)
+{
+	long *cookie;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	cookie = bpf_session_cookie();
+
+	if (bpf_session_is_return()) {
+		*result = *cookie == val ? val : 0;
+	} else {
+		*cookie = val;
+	}
+
+	return 0;
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
+int uprobe_1(struct pt_regs *ctx)
+{
+	return check_cookie(1, &test_uprobe_1_result);
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_2")
+int uprobe_2(struct pt_regs *ctx)
+{
+	return check_cookie(2, &test_uprobe_2_result);
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_3")
+int uprobe_3(struct pt_regs *ctx)
+{
+	return check_cookie(3, &test_uprobe_3_result);
+}
-- 
2.45.1


