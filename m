Return-Path: <bpf+bounces-2904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE6E73667F
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5052810FF
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A80C143;
	Tue, 20 Jun 2023 08:39:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010DAD37
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079AAC433C0;
	Tue, 20 Jun 2023 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250388;
	bh=L0w8dJO+NL2ZM4gfbTKPBvbNpym8PsvyuP/F+8FI4JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSGlpLG73bnORe4pMuC6JQ7vVG09AngbfX7EiYlDFG8bIiaEYQf2P/tB3RUHJgPh4
	 pgjQCjxWaylYlHb/DaEF+WQp8biuTl0SFGePRe+OQY+awyb9RFOgPK7swK4diaMD80
	 sqVQxbTmtlh82q3gqMekfL+2eLFsPpXsLoknDxKG1YyZIpN2WeOf98TKkgnpJw7Rn2
	 lJCRbWbY27z4jxF+bAezSASyHXUCd+sVasTR7v69dzxbGn2+kYEIexPFT2b/Apy7fx
	 E5pkiT4xegXfcHcrCufKkSM3xZPWeuuGA8Iv9xjbA79r99WRJPtTLybesrYEzoXNET
	 EmGfCe4MhWPDw==
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
Subject: [PATCHv2 bpf-next 24/24] selftests/bpf: Add extra link to uprobe_multi tests
Date: Tue, 20 Jun 2023 10:35:50 +0200
Message-ID: <20230620083550.690426-25-jolsa@kernel.org>
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
index efa7b5d49940..9057a228c12d 100644
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
 	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
 		goto cleanup;
 
+	opts->retprobe = false;
+	link_extra = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe_extra, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link_extra, "bpf_program__attach_uprobe_multi_opts"))
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
 
 	err = elf_find_multi_func_offset(path, 3, syms, (unsigned long **) &offsets);
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


