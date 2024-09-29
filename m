Return-Path: <bpf+bounces-40523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120B989778
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B1E28317A
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8A17CA03;
	Sun, 29 Sep 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv2se9nv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792018EB0;
	Sun, 29 Sep 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643542; cv=none; b=ph/EgyjLaVJIdNJBQ/skPCLKqwgt8x83lMlV08ZyI4R7UYZYa5fBxNkRbYaG/xtMK1b4B1VeRJHwHms61hf9WWcuTqN3/ZnIcXoTwn81f7RhpSPU0HhCx/DIuKXzgoHqZTn04qn9NTHvv9+XY1GhwcFkY9cLsZWjdEBDj+x++S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643542; c=relaxed/simple;
	bh=9k6v4VENBPTcpu5P+I+ruL1o1grMLPniGL3MpVpyyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyMFWFKaXwDiCQZDDMhO11uWZTs9etsKn8zQSQTDgJvD8bAcW/nFK1t3HLeDKT5+FdOnDvrofYPydf/R8Nx60nybrd7dQetwbzUeTEYOB4IEb3gt2Nww7A5CG1bBPb9g4DFdqdrY9mY36BsiPAAGFgvA/5e8YzdKLffvGs6lbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv2se9nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBAEC4CEC5;
	Sun, 29 Sep 2024 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643542;
	bh=9k6v4VENBPTcpu5P+I+ruL1o1grMLPniGL3MpVpyyCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fv2se9nvgnBe/iPdT5bkh36fNBgh/5RE3B4GmBN5f2NpO0p9ZMGr/qXqbZA5Dndc6
	 KlTDREn74GSnHUk4Qe9rPy/2A5Ikb8AxjjyJLJFOcjwC39E4HzY19im6oxXV9qFRrK
	 DaGR982f7GUGLMXURoSVI4KDg4oq00hGvfKxr8VcXf4EtSBMacBTgfqJ9FfnHCfGvw
	 495soecn+RvcuiwPrqAZ/GZGgV55pRDrrnj53RRCxjVubq5bEwkHOSOVAzmiYY/4tA
	 WSeSPa9I9S4bb7BqoR7puDxL/VqtmjeN08oJW/6x8f1dzsdUv+4sugoPrnWmroFQLu
	 BcTbRo8iBTVyg==
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
Subject: [PATCHv5 bpf-next 08/13] selftests/bpf: Add uprobe session cookie test
Date: Sun, 29 Sep 2024 22:57:12 +0200
Message-ID: <20240929205717.3813648-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test that verifies the cookie value
get properly propagated from entry to return program.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 31 ++++++++++++
 .../bpf/progs/uprobe_multi_session_cookie.c   | 48 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index b10d2dadb462..cc9030e86821 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -9,6 +9,7 @@
 #include "uprobe_multi_consumers.skel.h"
 #include "uprobe_multi_pid_filter.skel.h"
 #include "uprobe_multi_session.skel.h"
+#include "uprobe_multi_session_cookie.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -1060,6 +1061,34 @@ static void test_session_skel_api(void)
 	uprobe_multi_session__destroy(skel);
 }
 
+static void test_session_cookie_skel_api(void)
+{
+	struct uprobe_multi_session_cookie *skel = NULL;
+	int err;
+
+	skel = uprobe_multi_session_cookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_cookie__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err = uprobe_multi_session_cookie__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi_session_cookie__attach"))
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
@@ -1158,4 +1187,6 @@ void test_uprobe_multi_test(void)
 		test_pid_filter_process(true);
 	if (test__start_subtest("session"))
 		test_session_skel_api();
+	if (test__start_subtest("session_cookie"))
+		test_session_cookie_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
new file mode 100644
index 000000000000..5befdf944dc6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
@@ -0,0 +1,48 @@
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
+	__u64 *cookie;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	cookie = bpf_session_cookie();
+
+	if (bpf_session_is_return())
+		*result = *cookie == val ? val : 0;
+	else
+		*cookie = val;
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
2.46.1


