Return-Path: <bpf+bounces-41991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5499E28F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1112A1F232BF
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5751E6339;
	Tue, 15 Oct 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAZL/ejX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4C1DAC8D
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983551; cv=none; b=SRfa/CN+OTS/jFbXqVyC3852h5r4qIBBOo8O805Dzw5CvatKjHzKTPg9lH0f74qO9mBc8JsCfLDYExk+nMaa78uF/GTKXVcEmpwrqnlExC47qYGK/8roSpbnJX2CV/LbrNjY/UwY9uAtApXTn2BzGyNk9NZQeSF+yY6kV/UtuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983551; c=relaxed/simple;
	bh=tiFWq4stA78Nh3pJt3/jzsTBQ26T8kB6IeqRBp9iaoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3iByz+DIR+T5Tov/6QdplH3X5SeT28j+nwKvIRRzHqKJanTMUPYr/xX9WCO/+g0CbwkAeQSerQeDbX4hih94RUX1GUaIMmVikGmSsn8ahwnmA/gcZMyxsqGZHHkApat4wnjUQE+ptjneShpqd3l7dnt7jcPGtCPlqCKdWH9S2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAZL/ejX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC9FC4CEC6;
	Tue, 15 Oct 2024 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983550;
	bh=tiFWq4stA78Nh3pJt3/jzsTBQ26T8kB6IeqRBp9iaoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAZL/ejXNd1yZo2b+hyTEE2YeR1TJXFZBwPmUcBJ0z5ebBhZ5RGYoQqKEeu7qy58z
	 4y7iDOg/YyXjSRBUsRdIUvnj92JZ+APkjLtPMBFtFyIRNnVW3LFcmvceUrW3dUnubW
	 FV0rKGFWHtwPlQM2gEHWaLRkeHFnw2q2dRdI43Uh0pGNZ3hZnYN2N5v/l21psCoxG8
	 1mikaKzk6gAdL5Ily68N3PdJNCeWGgc0wCPdw6EO8fsMXmIvP0Y2ejgcjpZw0zDjzr
	 IHwiPP32lGZAfRBwnVO4WJ/bTkj06jsyK3T9uRknwOnhxq+nOXqDPtrrbcd5YoHGVd
	 vJwo4BeVc2P2w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next 09/15] selftests/bpf: Add uprobe session cookie test
Date: Tue, 15 Oct 2024 11:10:44 +0200
Message-ID: <20241015091050.3731669-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015091050.3731669-1-jolsa@kernel.org>
References: <20241015091050.3731669-1-jolsa@kernel.org>
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
2.46.2


