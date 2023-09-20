Return-Path: <bpf+bounces-10497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD617A8E8C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1813A281476
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5774121A;
	Wed, 20 Sep 2023 21:33:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8B3C6B3
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 21:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A4C433C7;
	Wed, 20 Sep 2023 21:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695245610;
	bh=CWA6eX9uJCwXVwZUnntLD6wnmPhAJ7H++vKrn/cUIK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4s4fqABLh7NbdvindoA1JgdzM9taW4bt5BNt1qhWsy8zt6pA30CjjO4I+fRMJr2/
	 H3Xyuab4RNn+H6zRKknuTj5OxD8jqe2JeZL0Lt3iBmyoTGifCscz+pqh54ZHh53+Fi
	 8LsZrn0TKgsH3eKaVXtp+ajSPAueYuXLHRRe1MCf5Do53rx4uUAS76uEFnJw4W1Tn9
	 fB9YkOA735WYoul/E7agFvqt9iHe13socdtdgcK7t7jYi1UlP/vMJbs0lZndJDls6x
	 6PXxs2W+mnsPevuq2UjQZcf5WecFiw28qy27BpJEUsyHYYUv3yHVVdYMbjDDRujF7s
	 LX70TlFN4lb4w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv3 bpf-next 9/9] selftests/bpf: Add test for recursion counts of perf event link tracepoint
Date: Wed, 20 Sep 2023 23:31:45 +0200
Message-ID: <20230920213145.1941596-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213145.1941596-1-jolsa@kernel.org>
References: <20230920213145.1941596-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding selftest that puts kprobe on bpf_fentry_test1 that calls bpf_printk
and invokes bpf_trace_printk tracepoint. The bpf_trace_printk tracepoint
has test[234] programs attached to it.

Because kprobe execution goes through bpf_prog_active check, programs
attached to the tracepoint will fail the recursion check and increment the
recursion_misses stats.

Reviewed-and-tested-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/missed.c | 40 ++++++++++++++++++
 .../selftests/bpf/progs/missed_tp_recursion.c | 41 +++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/missed_tp_recursion.c

diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
index 54aaf2f8ad8c..24ade11f5c05 100644
--- a/tools/testing/selftests/bpf/prog_tests/missed.c
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "missed_kprobe.skel.h"
 #include "missed_kprobe_recursion.skel.h"
+#include "missed_tp_recursion.skel.h"
 
 /*
  * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
@@ -89,10 +90,49 @@ static void test_missed_kprobe_recursion(void)
 	missed_kprobe_recursion__destroy(skel);
 }
 
+/*
+ * Putting kprobe on bpf_fentry_test1 that calls bpf_printk and invokes
+ * bpf_trace_printk tracepoint. The bpf_trace_printk tracepoint has test[234]
+ * programs attached to it.
+ *
+ * Because kprobe execution goes through bpf_prog_active check, programs
+ * attached to the tracepoint will fail the recursion check and increment
+ * the recursion_misses stats.
+ */
+static void test_missed_tp_recursion(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct missed_tp_recursion *skel;
+	int err, prog_fd;
+
+	skel = missed_tp_recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "missed_tp_recursion__open_and_load"))
+		goto cleanup;
+
+	err = missed_tp_recursion__attach(skel);
+	if (!ASSERT_OK(err, "missed_tp_recursion__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test1)), 0, "test1_recursion_misses");
+	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "test2_recursion_misses");
+	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
+	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
+
+cleanup:
+	missed_tp_recursion__destroy(skel);
+}
+
 void test_missed(void)
 {
 	if (test__start_subtest("perf_kprobe"))
 		test_missed_perf_kprobe();
 	if (test__start_subtest("kprobe_recursion"))
 		test_missed_kprobe_recursion();
+	if (test__start_subtest("tp_recursion"))
+		test_missed_tp_recursion();
 }
diff --git a/tools/testing/selftests/bpf/progs/missed_tp_recursion.c b/tools/testing/selftests/bpf/progs/missed_tp_recursion.c
new file mode 100644
index 000000000000..762385f827c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/missed_tp_recursion.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * No tests in here, just to trigger 'bpf_fentry_test*'
+ * through tracing test_run
+ */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(trigger)
+{
+	return 0;
+}
+
+SEC("kprobe/bpf_fentry_test1")
+int test1(struct pt_regs *ctx)
+{
+	bpf_printk("test");
+	return 0;
+}
+
+SEC("tp/bpf_trace/bpf_trace_printk")
+int test2(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("tp/bpf_trace/bpf_trace_printk")
+int test3(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("tp/bpf_trace/bpf_trace_printk")
+int test4(struct pt_regs *ctx)
+{
+	return 0;
+}
-- 
2.41.0


