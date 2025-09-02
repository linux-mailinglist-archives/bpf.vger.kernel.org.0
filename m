Return-Path: <bpf+bounces-67192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D9B40733
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0D73BC469
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A203341667;
	Tue,  2 Sep 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK9dtusF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42731AF2A;
	Tue,  2 Sep 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823823; cv=none; b=dAmivKeMKx/UaT1X0PpazvXoRDDPb7e725824QH4ZOUBGjDIzm0NX/uDTAi4b37vyKJSdNMIWqlYMuL7YqN9pX/L5i9+ybSEpcWuXOv8V6wMx68IJBlU5VB6ImtJ37qaDxdF5fL1TQ8Nukl1aYN1bOGVLjkPvo3UVzpfw1zBsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823823; c=relaxed/simple;
	bh=U58L1T99uUbwn0HcZc+ldzOCdS/KBLvjySrspupL31s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtTlXLNzHeAwSB1z7aruJuE6fMxQy0BqjIWg1RUOQ+THA7ErKXo/uMqW2VC0Bq5/9/XHPT8ddZyTohVt49+60ouS2djyR07HF2q043X5xxDif50eui6L77X8r6/bHQjtXjsrdh0q4gnINKjxhisJppMoE7hN1374l6m0QtMbm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK9dtusF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB92DC4CEF5;
	Tue,  2 Sep 2025 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823823;
	bh=U58L1T99uUbwn0HcZc+ldzOCdS/KBLvjySrspupL31s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bK9dtusFypGXWOXcTKV4gb1oKv2meDiM+gwmZheGuwQCUB50ixKxtTaEgDzy7bn59
	 Tkh7mQCNj3KJz3jivETh4i5I749p49B5g+bjaZjPh3a5+DdjpLEwDrKl1lk4j6ZCkH
	 Q+KAFAM76PW/egl3y1Xpjxw6U49dxCX+nrxHcFIc5zLS5SFyMC5a3gfN4JIRxZdGw/
	 pZYFCwPC2e4FwO1Xr2I1cwSnhWpOiD1reDeWf9Drx7AUWThfOErwkHZ4vfDhPjYOS2
	 BfHPt7OvbKgIubZ30T2uUyb5gZHoaJ3RSboAUmcuc3FHnqI1UTbTyXDz1wLx1w3bYj
	 1kK8jSxx9vWOg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 10/11] selftests/bpf: Add uprobe multi unique attach test
Date: Tue,  2 Sep 2025 16:35:03 +0200
Message-ID: <20250902143504.1224726-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check the unique uprobe attchment together
with not-unique uprobe on top of uprobe_multi link.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 99 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi_unique.c | 34 +++++++
 2 files changed, 133 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_unique.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 4630a6c65c3c..1043bc4387e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -14,6 +14,7 @@
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
 #include "uprobe_multi_verifier.skel.h"
+#include "uprobe_multi_unique.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -1477,12 +1478,110 @@ static void unique_regs_ip(void)
 	uprobe_multi__destroy(skel);
 }
 
+static void unique_attach(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.unique = true,
+	);
+	struct bpf_link *link_1, *link_2 = NULL;
+	struct bpf_program *prog_1, *prog_2;
+	struct uprobe_multi_unique *skel;
+
+	skel = uprobe_multi_unique__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_unique__open_and_load"))
+		return;
+
+	skel->bss->my_pid = getpid();
+
+	prog_1 = skel->progs.test1;
+	prog_2 = skel->progs.test2;
+
+	/* not-unique and unique */
+	link_1 = bpf_program__attach_uprobe_multi(prog_1, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					NULL);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	link_2 = bpf_program__attach_uprobe_multi(prog_2, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					&opts);
+	if (!ASSERT_ERR_PTR(link_2, "bpf_program__attach_uprobe_multi")) {
+		bpf_link__destroy(link_2);
+		goto cleanup;
+	}
+
+	bpf_link__destroy(link_1);
+
+	/* unique and unique */
+	link_1 = bpf_program__attach_uprobe_multi(prog_1, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					&opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	link_2 = bpf_program__attach_uprobe_multi(prog_2, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					&opts);
+	if (!ASSERT_ERR_PTR(link_2, "bpf_program__attach_uprobe_multi")) {
+		bpf_link__destroy(link_2);
+		goto cleanup;
+	}
+
+	bpf_link__destroy(link_1);
+
+	/* unique and not-unique */
+	link_1 = bpf_program__attach_uprobe_multi(prog_1, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					&opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	link_2 = bpf_program__attach_uprobe_multi(prog_2, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					NULL);
+	if (!ASSERT_ERR_PTR(link_2, "bpf_program__attach_uprobe_multi")) {
+		bpf_link__destroy(link_2);
+		goto cleanup;
+	}
+
+	bpf_link__destroy(link_1);
+
+	/* not-unique and not-unique */
+	link_1 = bpf_program__attach_uprobe_multi(prog_1, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					NULL);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	link_2 = bpf_program__attach_uprobe_multi(prog_2, -1, "/proc/self/exe",
+					"uprobe_multi_func_1",
+					NULL);
+	if (!ASSERT_OK_PTR(link_2, "bpf_program__attach_uprobe_multi")) {
+		bpf_link__destroy(link_1);
+		goto cleanup;
+	}
+
+	uprobe_multi_func_1();
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
+
+	bpf_link__destroy(link_1);
+	bpf_link__destroy(link_2);
+
+cleanup:
+	uprobe_multi_unique__destroy(skel);
+}
+
 static void test_unique(void)
 {
 	if (test__start_subtest("unique_regs_common"))
 		unique_regs_common();
 	if (test__start_subtest("unique_regs_ip"))
 		unique_regs_ip();
+	if (test__start_subtest("unique_attach"))
+		unique_attach();
 }
 #else
 static void test_unique(void) { }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_unique.c b/tools/testing/selftests/bpf/progs/uprobe_multi_unique.c
new file mode 100644
index 000000000000..e31e17bd85ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_unique.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+pid_t my_pid = 0;
+
+int test1_result = 0;
+int test2_result = 0;
+
+SEC("uprobe.multi")
+int BPF_UPROBE(test1)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	test1_result = 1;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int BPF_UPROBE(test2)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	test2_result = 1;
+	return 0;
+}
-- 
2.51.0


