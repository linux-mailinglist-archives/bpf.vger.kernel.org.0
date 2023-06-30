Return-Path: <bpf+bounces-3793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1444743789
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E60628106F
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021BA957;
	Fri, 30 Jun 2023 08:39:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AE1FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC1FC433CA;
	Fri, 30 Jun 2023 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114338;
	bh=0Wo4wjjYHpGWo2l5Nll/aWbzb19c+GyKhDECdbc5v9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHsp/WoaugcWOsqv6DJZ57ClmdaUuQhFddvmMqvDJ9gcd096X7Rq5Qnw5TrnNiUc5
	 370rENsrVPRYZIvvljsGWoIugHxYQTAGLdrdR2cD1fm8UwgHNwXSZXxcfstZO2DeNw
	 yG9yHos1vqmYKRY1PNWDaFuQNUVLVYDkaTa2KUglA24liPtO2WBYCKlzOGPUlPWS3Y
	 8MMxEtl+PDREa7tgpZXXyPfWNTNBh0hiI5Xswi/MJ47gRUqcwdLuMbpDU7cNbJJS7I
	 Atlen6t7opaf6scTewYb9RfL72c6NT7Tb7WUGac4PGCaEaAM+2txnqCXTCYUU+IKLW
	 VNsYkmwwHny+A==
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
Subject: [PATCHv3 bpf-next 26/26] selftests/bpf: Add extra link to uprobe_multi tests
Date: Fri, 30 Jun 2023 10:33:44 +0200
Message-ID: <20230630083344.984305-27-jolsa@kernel.org>
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

Attaching extra program to same functions system wide for api
and link tests.

This way we can test the pid filter works properly when there's
extra system wide consumer on the same uprobe that will trigger
the original uprobe handler.

We expect to have the same counts as before.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 19 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 8ca7a45e21e6..39bd16786cd0 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -153,6 +153,7 @@ __test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_mul
 	struct bpf_link *link1 = NULL, *link2 = NULL;
 	struct bpf_link *link3 = NULL, *link4 = NULL;
 	pid_t pid = child ? child->pid : -1;
+	struct bpf_link *link_extra = NULL;
 	struct uprobe_multi *skel = NULL;
 
 	skel = uprobe_multi__open_and_load();
@@ -183,9 +184,16 @@ __test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_mul
 	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retprobe"))
 		goto cleanup;
 
+	opts->retprobe = false;
+	link_extra = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_extra, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link_extra, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
 	uprobe_multi_test_run(skel, child);
 
 cleanup:
+	bpf_link__destroy(link_extra);
 	bpf_link__destroy(link4);
 	bpf_link__destroy(link3);
 	bpf_link__destroy(link2);
@@ -243,6 +251,7 @@ static void __test_link_api(struct child *child)
 		"uprobe_multi_func_2",
 		"uprobe_multi_func_3",
 	};
+	int link_extra_fd = -1;
 	int err;
 
 	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets);
@@ -281,6 +290,14 @@ static void __test_link_api(struct child *child)
 	link4_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (!ASSERT_GE(link2_fd, 0, "link4_fd"))
 		goto cleanup;
+
+	opts.kprobe_multi.flags = 0;
+	opts.uprobe_multi.pid = 0;
+	prog_fd = bpf_program__fd(skel->progs.test_uprobe_extra);
+	link_extra_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link_extra_fd, 0, "link_extra_fd"))
+		goto cleanup;
+
 	uprobe_multi_test_run(skel, child);
 
 cleanup:
@@ -292,6 +309,8 @@ static void __test_link_api(struct child *child)
 		close(link3_fd);
 	if (link4_fd >= 0)
 		close(link4_fd);
+	if (link_extra_fd >= 0)
+		close(link_extra_fd);
 
 	uprobe_multi__destroy(skel);
 	free(offsets);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 1086312b5d1e..8ee957670303 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -102,3 +102,9 @@ int test_uprobe_bench(struct pt_regs *ctx)
 	count++;
 	return 0;
 }
+
+SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_*")
+int test_uprobe_extra(struct pt_regs *ctx)
+{
+	return 0;
+}
-- 
2.41.0


