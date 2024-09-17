Return-Path: <bpf+bounces-40032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ECA97AD33
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC215B29DD7
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E915D5A6;
	Tue, 17 Sep 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU1ClqXS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713C15B57D;
	Tue, 17 Sep 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563143; cv=none; b=n3W26W1ou8X7SLHor/dPuMRe7nzgYNrUqJigETM9Xu/Zwl8thZr6tUACC5FI8KotV8VP4r+01h9Tcsn3qtOdyVX2YxU4Rqe5bz4C82zZPiiK4rD13LVEJnm6tQs+jRBZBIJucVJsBTrojJPSeKxtG4bseLzc2DHiWYBmz8MzbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563143; c=relaxed/simple;
	bh=b0A2fXg46VpGZuPVfILfDGkJwuLwKYJbupEFRw9KQUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccTsqRLSu1sKsjRGqBb1bBCVn0lyG6tyzChDm1T70wX7JJXTZhyPI9AXYIg+NEvVZxAjM6PFXlLzibZbGUrBrv0E1wY+jOy3pai2qH2KqwHcibxd8T1ddh9vlb11FZOgDbUFOv7d2CCK6CziSS+uPgjrlVMOaoB/3Kzp/OklTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU1ClqXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C37FC4CEC5;
	Tue, 17 Sep 2024 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563143;
	bh=b0A2fXg46VpGZuPVfILfDGkJwuLwKYJbupEFRw9KQUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZU1ClqXSbNUjzzPema8GHNbcOwVOi8Okr9fc4lQ273FXgCglrjKlFplJidtyGlxxi
	 t29ZgnNuqx1DvN7I2W9miXbjuYZVIrmTmJY4Q7IbtKhHC3fdO9E1Zp06MAh0CRNhDZ
	 l2B1NSwQt81xEk/U1MoHdKX19O5BuUvBmQBPHclopSlAtNKgBpqSo32XiDUyhqyLTR
	 iV5CFf9x2vz7PKlj1Jlxr5pEkt9WrekRA4yVE4HS6G1/nN1JFTi0jITISRWaNSIwa5
	 Znj2l3+pO8yjv8qA9QhXexJGDXcsw72tp4H4mhdYGIT4SGk2Um7+Z4Wx8kAFfJKR2z
	 2WRRQdwh3A69A==
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
Subject: [PATCHv4 09/14] selftests/bpf: Add uprobe session cookie test
Date: Tue, 17 Sep 2024 10:50:19 +0200
Message-ID: <20240917085024.765883-10-jolsa@kernel.org>
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
index aaafd80623c5..edb71b9293c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -7,6 +7,7 @@
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
 #include "uprobe_multi_session.skel.h"
+#include "uprobe_multi_session_cookie.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -660,6 +661,34 @@ static void test_session_skel_api(void)
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
@@ -750,4 +779,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_fails();
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
2.46.0


