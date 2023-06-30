Return-Path: <bpf+bounces-3790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E11743784
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2770280D80
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93185A957;
	Fri, 30 Jun 2023 08:38:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD39A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC20BC433C8;
	Fri, 30 Jun 2023 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114302;
	bh=uVaZqtTicYF9UZO+qN7Vxxu5txzKyAnr1YysTA5DfZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PovQMB0FIVZ9i43x4cLF4zahnSdSlJa+iyTqqCoOmylQDucSQPPrWRcC7yrkXiO1l
	 aIetwLp52dvT43RZd6PJUk4gu1PJoDAbf+FkMc3OlZ7Ta/5wbEKYVMYycuPk9Bc5n6
	 9zeS73+ULuuGudPaEaNWQa30SpwHY7ipzgd0hnPGTq+RPhjXcnxONSjE3E7Ulc4Qp2
	 70QQpMUO3egcnsvKuYRoOAN6bJtVAVmybTrBsYED7miEWybgVlqQOUyJr+7vO499fu
	 Zwe/kVyCgycWdxBjogErC8Gn4VDC46AnpVm6HgsL8GtLuUqkOzhuXyi5TISAD2wXB0
	 LZD1r1w1KdBhQ==
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
Subject: [PATCHv3 bpf-next 23/26] selftests/bpf: Add usdt_multi bench test
Date: Fri, 30 Jun 2023 10:33:41 +0200
Message-ID: <20230630083344.984305-24-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
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
index 547d46965d70..b12dc1f992e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
 #include "bpf/libbpf_elf.h"
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


