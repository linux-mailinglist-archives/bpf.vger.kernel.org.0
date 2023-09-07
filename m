Return-Path: <bpf+bounces-9402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F420C797076
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA01C20ADD
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF11117;
	Thu,  7 Sep 2023 07:14:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F151137C
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27651C43391;
	Thu,  7 Sep 2023 07:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070880;
	bh=VQmugnI2kltuYNtUrGsDPwX3U8wwnw265+8NavBzFrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkyAHYsHsb6htLAWGzbfAyizCT+6Zp2fFtq2z2mi8fYE9nKTe8GdWRMP13ke+Bd2o
	 420y5awPYTGge9GH5AQi99CdcFKVeERPiI61lEv8c/dGFHlU1p9umLP56mMymkaFn7
	 Z9lmSWyTkzgfJ/ewXr0mWdG8ywPGREmmY1hNfCKxpu8rR4y/tMN/+CkszrujSa4ZvN
	 Zm09wJo4cyvE+79Vb+ntpqXzI+9Mql03b6fhGXPgFDS5/jJn96uDHtj+jMSrw9Jf+T
	 wCNhmwGIhKHno9mzYZwnZtqkHcp7+bkZJsAPPs6sjbqz0CLMwuuW7Qt0JFAGWKAU7K
	 Z4xv1x/YRc45Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv2 bpf-next 8/9] selftests/bpf: Add test for recursion counts of perf event link kprobe
Date: Thu,  7 Sep 2023 09:13:10 +0200
Message-ID: <20230907071311.254313-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907071311.254313-1-jolsa@kernel.org>
References: <20230907071311.254313-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding selftest that puts kprobe.multi on bpf_fentry_test1 that
calls bpf_kfunc_common_test kfunc which has 3 perf event kprobes
and 1 kprobe.multi attached.

Because fprobe (kprobe.multi attach layear) does not have strict
recursion check the kprobe's bpf_prog_active check is hit for test2-5.

Disabling this test for arm64, because there's no fprobe support yet.

Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 .../testing/selftests/bpf/prog_tests/missed.c | 51 +++++++++++++++++++
 .../bpf/progs/missed_kprobe_recursion.c       | 48 +++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 7f768d335698..3f2187c049db 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -15,3 +15,4 @@ fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_ma
 fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
index fc674258c81f..f10dc9232b3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/missed.c
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "missed_kprobe.skel.h"
+#include "missed_kprobe_recursion.skel.h"
 
 /*
  * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
@@ -40,8 +41,58 @@ static void test_missed_perf_kprobe(void)
 	missed_kprobe__destroy(skel);
 }
 
+static __u64 get_count(int fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	int err;
+
+	err = bpf_prog_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		return (__u64) -1;
+	return info.recursion_misses;
+}
+
+/*
+ * Putting kprobe.multi on bpf_fentry_test1 that calls bpf_kfunc_common_test
+ * kfunc which has 3 perf event kprobes and 1 kprobe.multi attached.
+ *
+ * Because fprobe (kprobe.multi attach layear) does not have strict recursion
+ * check the kprobe's bpf_prog_active check is hit for test2-5.
+ */
+static void test_missed_kprobe_recursion(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct missed_kprobe_recursion *skel;
+	int err, prog_fd;
+
+	skel = missed_kprobe_recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "missed_kprobe_recursion__open_and_load"))
+		goto cleanup;
+
+	err = missed_kprobe_recursion__attach(skel);
+	if (!ASSERT_OK(err, "missed_kprobe_recursion__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(get_count(bpf_program__fd(skel->progs.test1)), 0, "test1_recursion_misses");
+	ASSERT_EQ(get_count(bpf_program__fd(skel->progs.test2)), 1, "test2_recursion_misses");
+	ASSERT_EQ(get_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
+	ASSERT_EQ(get_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
+	ASSERT_EQ(get_count(bpf_program__fd(skel->progs.test5)), 1, "test5_recursion_misses");
+
+cleanup:
+	missed_kprobe_recursion__destroy(skel);
+}
+
 void serial_test_missed(void)
 {
 	if (test__start_subtest("perf_kprobe"))
 		test_missed_perf_kprobe();
+	if (test__start_subtest("kprobe_recursion"))
+		test_missed_kprobe_recursion();
 }
diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c b/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
new file mode 100644
index 000000000000..8ea71cbd6c45
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
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
+SEC("kprobe.multi/bpf_fentry_test1")
+int test1(struct pt_regs *ctx)
+{
+	bpf_kfunc_common_test();
+	return 0;
+}
+
+SEC("kprobe/bpf_kfunc_common_test")
+int test2(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("kprobe/bpf_kfunc_common_test")
+int test3(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("kprobe/bpf_kfunc_common_test")
+int test4(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("kprobe.multi/bpf_kfunc_common_test")
+int test5(struct pt_regs *ctx)
+{
+	return 0;
+}
-- 
2.41.0


