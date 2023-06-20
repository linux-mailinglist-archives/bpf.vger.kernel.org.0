Return-Path: <bpf+bounces-2901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE2736679
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1171C20B57
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362BBBE7C;
	Tue, 20 Jun 2023 08:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B84400
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4839C433C8;
	Tue, 20 Jun 2023 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250359;
	bh=BfNxy5P13iMbE7Fn3YYIfXUnUos/78zl3tKv+nobwYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gmla9RqpTj236Js133DeDX4/3Eblw6mp9Gt6NNBGJWp01/Mn/DRCG4Q+TEHpHL9Xj
	 aJ4IgtCciK110o4RVb4kZ70nBI2U132NMSKee7dav/AyjYnmxFjOjSj4S+HQKzG6so
	 zFzyM8maqazfWw55k39N90GsYn8vLlP+9Hsl9Wv3VoFoQPMcaANaEE/YdSZKdoIsOC
	 PC7vjrkUM9z/pcuoq5pYkIddNUAHYpAirejW0hgWrjdwJCjXT5yC+SOjaV+fzWZMZ5
	 PEdJto+u5Cz5dCSLEEMzS6mHSSujHRft9nsh+v0sN6v561VuaA7Hkfpx4GH7c5LJaa
	 +UC2UDMmWfVSQ==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 21/24] selftests/bpf: Add usdt_multi bench test
Date: Tue, 20 Jun 2023 10:35:47 +0200
Message-ID: <20230620083550.690426-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches 50k usdt probes in usdt_multi binary.

After the attach is done we run the binary and make sure we get
proper amount of hits.

With current uprobes:

  # perf stat --null ./test_progs -n 254/6
  #254/6   uprobe_multi_test/bench_usdt:OK
  #254     uprobe_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

   Performance counter stats for './test_progs -n 254/6':

      1353.659680562 seconds time elapsed

With uprobe_multi link:

  # perf stat --null ./test_progs -n 254/6
  #254/6   uprobe_multi_test/bench_usdt:OK
  #254     uprobe_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

   Performance counter stats for './test_progs -n 254/6':

         0.322046364 seconds time elapsed

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 50 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi_usdt.c   | 16 ++++++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 9a34c754f1ad..a9d5a1773407 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
 #include "bpf/libbpf_internal.h"
+#include "uprobe_multi_usdt.skel.h"
 
 static char test_data[] = "test_data";
 
@@ -256,6 +257,53 @@ static void test_bench_attach_uprobe(void)
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
 }
 
+static void test_bench_attach_usdt(void)
+{
+	struct uprobe_multi_usdt *skel = NULL;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct bpf_program *prog;
+	int err;
+
+	skel = uprobe_multi_usdt__open();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
+		goto cleanup;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, false);
+
+	bpf_program__set_autoload(skel->progs.usdt0, true);
+
+	err = uprobe_multi_usdt__load(skel);
+	if (!ASSERT_EQ(err, 0, "uprobe_multi_usdt__load"))
+		goto cleanup;
+
+	attach_start_ns = get_time_ns();
+
+	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0, -1, "./usdt_multi",
+						     "test", "usdt", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	attach_end_ns = get_time_ns();
+
+	system("./usdt_multi");
+
+	ASSERT_EQ(skel->bss->count, 50000, "usdt_count");
+
+cleanup:
+	detach_start_ns = get_time_ns();
+	uprobe_multi_usdt__destroy(skel);
+	detach_end_ns = get_time_ns();
+
+	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
+	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
+
+	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
+	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -268,4 +316,6 @@ void test_uprobe_multi_test(void)
 		test_link_api();
 	if (test__start_subtest("bench_uprobe"))
 		test_bench_attach_uprobe();
+	if (test__start_subtest("bench_usdt"))
+		test_bench_attach_usdt();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c b/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
new file mode 100644
index 000000000000..9e1c33d0bd2f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+int count;
+
+SEC("usdt")
+int usdt0(struct pt_regs *ctx)
+{
+	count++;
+	return 0;
+}
-- 
2.41.0


