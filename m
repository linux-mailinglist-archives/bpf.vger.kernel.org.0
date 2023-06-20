Return-Path: <bpf+bounces-2899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFAC736675
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475351C20B57
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11159C126;
	Tue, 20 Jun 2023 08:39:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30E4400
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7EAC433C8;
	Tue, 20 Jun 2023 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250339;
	bh=mXFoVKa6sHZeOCEruN48i74RWoq+omOMYLWIsZrOiN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0TARv1//4gsyTqH+OPWX05YvvuEgy/B0hBF+hOCnPasavDT6LooAGkufpgMSWsZ2
	 yBB96e/VzOftDsuL9loSMVQZ3iwOZibS+TUp6/h5dk2Ief5n4+J9kVt1QiHDZ1+nXU
	 EZrNjVIkzTpNeJjbyMg2o+XVp8dGoHRICx7wDSvmHBykgoWFfV8LKwg3qoVteQF668
	 VNZASMCD/Imzl1WF5YqiCZJ+aUuAODBbhyZJpHmhmrhz4of9R2kd8ICUCFtiPquUlD
	 Et3O3/GCjKiBvozjEQbSBw/5cj8yGXjxZ4MMLKPmc7pPaM9BgTKK2JvUFxFCV3QvdJ
	 MqvGA2fii4i9A==
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
Subject: [PATCHv2 bpf-next 19/24] selftests/bpf: Add uprobe_multi bench test
Date: Tue, 20 Jun 2023 10:35:45 +0200
Message-ID: <20230620083550.690426-20-jolsa@kernel.org>
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

Adding test that attaches 50k uprobes in uprobe_multi binary.

After the attach is done we run the binary and make sure we
get proper amount of hits.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 56 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        |  9 +++
 2 files changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index fb5247a86559..9a34c754f1ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -202,6 +202,60 @@ static void test_link_api(void)
 	free(offsets);
 }
 
+static inline __u64 get_time_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
+static void test_bench_attach_uprobe(void)
+{
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct uprobe_multi *skel = NULL;
+	struct bpf_program *prog;
+	int err;
+
+	skel = uprobe_multi__open();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
+		goto cleanup;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, false);
+
+	bpf_program__set_autoload(skel->progs.test_uprobe_bench, true);
+
+	err = uprobe_multi__load(skel);
+	if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
+		goto cleanup;
+
+	attach_start_ns = get_time_ns();
+
+	err = uprobe_multi__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi__attach"))
+		goto cleanup;
+
+	attach_end_ns = get_time_ns();
+
+	system("./uprobe_multi");
+
+	ASSERT_EQ(skel->bss->count, 50000, "uprobes_count");
+
+cleanup:
+	detach_start_ns = get_time_ns();
+	uprobe_multi__destroy(skel);
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
@@ -212,4 +266,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("link_api"))
 		test_link_api();
+	if (test__start_subtest("bench_uprobe"))
+		test_bench_attach_uprobe();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 1eeb9b7b9cad..cd73139dc881 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -89,3 +89,12 @@ int test_uretprobe_sleep(struct pt_regs *ctx)
 	uprobe_multi_check(ctx, true, true);
 	return 0;
 }
+
+int count;
+
+SEC("?uprobe.multi/./uprobe_multi:uprobe_multi_func_*")
+int test_uprobe_bench(struct pt_regs *ctx)
+{
+	count++;
+	return 0;
+}
-- 
2.41.0


