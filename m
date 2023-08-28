Return-Path: <bpf+bounces-8831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE578A6E7
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAA91C20889
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5281107;
	Mon, 28 Aug 2023 07:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4310F4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C634DC433C8;
	Mon, 28 Aug 2023 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209458;
	bh=BhhS2CBufN3PbYHgfR1CizzQx52bA2IpNoFM5Mkw71o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xya0W5yBHxjGKoUb3ZdbsmDG5vH6Xo9XjlytX5nMvbiUcfz8PUS5jGCjJJBI0B/S+
	 tPJNF2hASSPjFe1bwHBi2XZNNPm+8RP4jXr8fWcbdjkTf4rU9uXTWk8/gU8Mp3ko47
	 qg+XMMMk1XJm3d+tERKDX4foZETe5rycyarNUOD3n43tYyW2rY/4Or/MkLHHpRi9Yp
	 gTcvA6lxUficK3Fbj7D5tyCoq+ujU/qH9/gSvyfhNeRNY8wf/lkQSIqatE5ByOoM5d
	 aJjaLFcP6flESOjvR9p/mWq00eH8N97et/sbELCDl6yQWhJJA3ZB5TqqQM+YnBMG21
	 WfOMxI8N1KClg==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH bpf-next 11/12] selftests/bpf: Add test missed counts of perf event link kprobe
Date: Mon, 28 Aug 2023 09:55:36 +0200
Message-ID: <20230828075537.194192-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that puts kprobe on bpf_fentry_test1 that calls
bpf_kfunc_common_test kfunc, which has also kprobe on.

The latter won't get triggered due to kprobe recursion check
and kprobe missed counter is incremented.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  5 ++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  2 +
 .../testing/selftests/bpf/prog_tests/missed.c | 47 +++++++++++++++++++
 .../selftests/bpf/progs/missed_kprobe.c       | 30 ++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cefc5dd72573..a5e246f7b202 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -138,6 +138,10 @@ __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it)
 	it->cnt = 0;
 }
 
+__bpf_kfunc void bpf_kfunc_common_test(void)
+{
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -343,6 +347,7 @@ BTF_SET8_START(bpf_testmod_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_SET8_END(bpf_testmod_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index f5c5b1375c24..7c664dd61059 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -104,4 +104,6 @@ void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p);
 void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
 void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
 void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
+
+void bpf_kfunc_common_test(void) __ksym;
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
new file mode 100644
index 000000000000..fc674258c81f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "missed_kprobe.skel.h"
+
+/*
+ * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
+ * kfunc, which has also kprobe on. The latter won't get triggered due
+ * to kprobe recursion check and kprobe missed counter is incremented.
+ */
+static void test_missed_perf_kprobe(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link_info info = {};
+	struct missed_kprobe *skel;
+	__u32 len = sizeof(info);
+	int err, prog_fd;
+
+	skel = missed_kprobe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "missed_kprobe__open_and_load"))
+		goto cleanup;
+
+	err = missed_kprobe__attach(skel);
+	if (!ASSERT_OK(err, "missed_kprobe__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	err = bpf_link_get_info_by_fd(bpf_link__fd(skel->links.test2), &info, &len);
+	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
+		goto cleanup;
+
+	ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "info.type");
+	ASSERT_EQ(info.perf_event.type, BPF_PERF_EVENT_KPROBE, "info.perf_event.type");
+	ASSERT_EQ(info.perf_event.kprobe.missed, 1, "info.perf_event.kprobe.missed");
+
+cleanup:
+	missed_kprobe__destroy(skel);
+}
+
+void serial_test_missed(void)
+{
+	if (test__start_subtest("perf_kprobe"))
+		test_missed_perf_kprobe();
+}
diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe.c b/tools/testing/selftests/bpf/progs/missed_kprobe.c
new file mode 100644
index 000000000000..7f9ef701f5de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/missed_kprobe.c
@@ -0,0 +1,30 @@
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
+SEC("kprobe/bpf_fentry_test1")
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
-- 
2.41.0


