Return-Path: <bpf+bounces-39274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188297101C
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975671F22CC2
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC951B0135;
	Mon,  9 Sep 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzXho6Ro"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A717557C;
	Mon,  9 Sep 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868019; cv=none; b=idSbegtJ3PksWeh/20OK944G5n80Exhi2ee0FZHjJ6EABIhEe9ovV+57SQBCTFCwslvMfRZctfHJrakQADD4aghj49ewrpUQAwOz8N9tSQaAXkhF8srKEOHTNRQwblqz27+3mV+wG/F/QBQgrL6LXG0E9bgtAQtVqu4Ty9+erR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868019; c=relaxed/simple;
	bh=QcQ3tkDZArjXJxjIDoxxoCerB8p+FJ17FuuJb8viNQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS+OWTfS3qnOUVdbLdGiUHxByQlXEHSeT+/agGPPaFmOudeROvajCc6kl2+LphcDblgBmD84xlQ8MqYjh0CKI8eYeOxgUkG2dR/+iQq+o97TrHdaEyvecRQFH26MNoQoDUPYlbfHL246uM/La0Axgbyb0HNjXF7duJXppPOA4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzXho6Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A79DC4CEC5;
	Mon,  9 Sep 2024 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868019;
	bh=QcQ3tkDZArjXJxjIDoxxoCerB8p+FJ17FuuJb8viNQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzXho6RomaZfCKV/SgPWwiPuXU/mRLlVdiIzqb58hD4XolklxNAGHT6pqObQLUfX7
	 BI73maYTab2TYCuMMm+4EZZudOZ/4pjq7Rv5sr7fVFlhAMhjpcYPz3R2rRqVSt9Kqo
	 1tmEJnluVF8R/cYCM4fTBLgKULGkQ5+3doDcRPJHJCOPscn30rFOJTyJZsrn5n0D0z
	 Kva2H5hwrxPmuZpP2WE/HYX/f9ydVAb+rO1x1o6JPRxoIgjQl2C3Mwco0JlVZYcpMr
	 +posI2XBiU/PGP+mMRcB59GYyAn0E0N1+xJhyyUP6nm14oXkvNMAYMSoTGWzKWXXBp
	 D70eYgTukeuaw==
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
Subject: [PATCHv3 5/7] selftests/bpf: Add uprobe session test
Date: Mon,  9 Sep 2024 09:45:52 +0200
Message-ID: <20240909074554.2339984-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909074554.2339984-1-jolsa@kernel.org>
References: <20240909074554.2339984-1-jolsa@kernel.org>
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
index bf6ca8e3eb13..cc32288bfe26 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
+#include "uprobe_multi_session.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -615,6 +616,50 @@ static void test_link_api(void)
 	__test_link_api(child);
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
+	if (!ASSERT_OK(err, " uprobe_multi_session__attach"))
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
@@ -703,4 +748,6 @@ void test_uprobe_multi_test(void)
 		test_bench_attach_usdt();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
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
2.46.0


