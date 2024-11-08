Return-Path: <bpf+bounces-44347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17E9C1E5B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CA828306C
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C71F4721;
	Fri,  8 Nov 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d32+GHvX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA61EF084;
	Fri,  8 Nov 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073647; cv=none; b=hGYd9z/+q5HowozbEULYRFDHioX8G4r6TL/kE+tKAbE9rJ+l3zDBPUSAPFJZ1xcf4MFEiah9qBMxFTkODlWRp3FiyNCQJ1YKdXifrfxhRTuyFxGCM7mZXiZJuMm8lIQ8FyMg7hmL/P7TID7ogtMXafRXMGlRLN1QG5b1VGJKiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073647; c=relaxed/simple;
	bh=PSjf47u3YOTCBsa4PtDSDpvo0vyF79XYA2Q5XDd9TxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcMsI2yduuzTqcxtem3r/RSbHrmZ/yQuPv9JgLYv0AdtzYUqkiUQqRDZfW9thUznEaXWhv8iRKn06vnp47q6FCO6ixG4dbnO7PgljYfYIWhJfjPa0k1HHMwtvS97u1NDa3IWBJe+vbf0f+A/7U6Qeg3u3LfMyFT7Rm+u+VC9g6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d32+GHvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED249C4CED0;
	Fri,  8 Nov 2024 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073647;
	bh=PSjf47u3YOTCBsa4PtDSDpvo0vyF79XYA2Q5XDd9TxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d32+GHvXZ7xpuam6Qy4zGrbp38HhiJoTO7a08Lj7YPDg9wzCrp/YUr285ji2iwf2r
	 NfP5Tmic8Qc1iYgbTvodtpNRuwIDqi9ee7fsP0Wv0tJfUtlGg3z9GeCjzYZ9QBU0ew
	 ufLM/TPXGVarX/SSNZ5cBzIAPAKa53jQ6r61t/R13SEfxzH+z1QQlih9sUMoK4fsAL
	 bNWwGZ15ZBX5MISgTCWisib/Jt4eAnlj1Ju6n1cI6gLKbwGVmJlhwlbY+2BRaJJoE8
	 SsSgHsKrnti9u66b7NP9dtfpWBmld+Prd7Ij4sGcLQIoOSloRZQLndH68EpPYsL4J9
	 ZFVCENxjJt/bg==
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
Subject: [PATCHv9 bpf-next 07/13] selftests/bpf: Add uprobe session cookie test
Date: Fri,  8 Nov 2024 14:45:38 +0100
Message-ID: <20241108134544.480660-8-jolsa@kernel.org>
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
index d9c20ca7a833..986852ec26f5 100644
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
@@ -1062,6 +1063,34 @@ static void test_session_skel_api(void)
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
@@ -1160,4 +1189,6 @@ void test_uprobe_multi_test(void)
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
2.47.0


