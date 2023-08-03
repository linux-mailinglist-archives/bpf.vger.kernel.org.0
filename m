Return-Path: <bpf+bounces-6815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D476E1E4
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD0282057
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78F13AD0;
	Thu,  3 Aug 2023 07:37:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4F9454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC0C433C8;
	Thu,  3 Aug 2023 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048268;
	bh=n1KB+WDu9D681cV0l4zEC5LDZYZ+vt8QEyxrCaRiSh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGHqOvSOPEkE2T8ny8Cup0w82J0FShbO09ob3zXZpO27hyAyKkBmQbK+6AZhwh9lV
	 N9X2RUugdel+BWkEA81MMBHwCi2TldL43oZ2pgRaYJ/YcbkjqWfM/719z9JPRfxkXs
	 dDnvxwWyX75dIgBHlhPiW3dJhuKBzuVjBczrHnG2P4xP8CH/ntVNisE3hv6nSQ5FUs
	 FR3gBifmqoX9xSSZgX4KMCpfaY4C0elktayOSpabkaIrE6EweZJQW053feNbnCVpsn
	 h8dRBgBBBRTa3kXvEtgnBad57nbjEUoDd81zyh384BUOiDJIa4soYYGiseqTn1IJg1
	 zvLlOzdS6/HTQ==
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv6 bpf-next 20/28] selftests/bpf: Add uprobe_multi api test
Date: Thu,  3 Aug 2023 09:34:12 +0200
Message-ID: <20230803073420.1558613-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe_multi test for bpf_program__attach_uprobe_multi
attach function.

Testing attachment using glob patterns and via bpf_uprobe_multi_opts
paths/syms fields.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 5cd1116bbb62..2ac8954123e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -69,8 +69,73 @@ static void test_skel_api(void)
 	uprobe_multi__destroy(skel);
 }
 
+static void
+test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
+{
+	struct uprobe_multi *skel = NULL;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	opts->retprobe = false;
+	skel->links.uprobe = bpf_program__attach_uprobe_multi(skel->progs.uprobe, -1,
+							      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(skel->links.uprobe, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	skel->links.uretprobe = bpf_program__attach_uprobe_multi(skel->progs.uretprobe, -1,
+								 binary, pattern, opts);
+	if (!ASSERT_OK_PTR(skel->links.uretprobe, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	opts->retprobe = false;
+	skel->links.uprobe_sleep = bpf_program__attach_uprobe_multi(skel->progs.uprobe_sleep, -1,
+								    binary, pattern, opts);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_sleep, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	skel->links.uretprobe_sleep = bpf_program__attach_uprobe_multi(skel->progs.uretprobe_sleep,
+								       -1, binary, pattern, opts);
+	if (!ASSERT_OK_PTR(skel->links.uretprobe_sleep, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	uprobe_multi__destroy(skel);
+}
+
+static void test_attach_api_pattern(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+
+	test_attach_api("/proc/self/exe", "uprobe_multi_func_*", &opts);
+	test_attach_api("/proc/self/exe", "uprobe_multi_func_?", &opts);
+}
+
+static void test_attach_api_syms(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+	test_attach_api("/proc/self/exe", NULL, &opts);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
 		test_skel_api();
+	if (test__start_subtest("attach_api_pattern"))
+		test_attach_api_pattern();
+	if (test__start_subtest("attach_api_syms"))
+		test_attach_api_syms();
 }
-- 
2.41.0


