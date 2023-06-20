Return-Path: <bpf+bounces-2896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3295A736671
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BC71C20B49
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF31BA5E;
	Tue, 20 Jun 2023 08:38:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486BA92D
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B1BC433C0;
	Tue, 20 Jun 2023 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250311;
	bh=0Unlua6hzVhXFpprqGf3cymjRZWdbiFNWGCDic36H/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dm+xGBSUuktF2U9xjhIx4h4KxYZCf/nns8Nykk6TMKAAhbSZcdYASJJ/eZYWu4GVQ
	 kmo0QOdYJoXHDv6NIkOPhezbXYtwMRnXy9hW1Rfy1RfpdNVNU1yg1grhGbAMM8dRfD
	 xzq6C892JkjKZvlkbHUIy0/73F3FYMFDSRIpMqbRLkwBptrlDBuX602AP4ybMuZ6Zh
	 1mQg7ByPFHOi0N4IJ78qAF8LdV6YbIS1P6YqvZsDWYTtqEPVsEb0pTbCAKo7C0yAB8
	 TxYnOL5/wNihfsAtaEmrJus3S7nqE3wTlVZcH1+ZuTptJwoESwqxQbzFLDNPVdiZWr
	 GOCgk6g7m0ovQ==
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
Subject: [PATCHv2 bpf-next 16/24] selftests/bpf: Add uprobe_multi api test
Date: Tue, 20 Jun 2023 10:35:42 +0200
Message-ID: <20230620083550.690426-17-jolsa@kernel.org>
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

Adding uprobe_multi test for bpf_program__attach_uprobe_multi_opts
attach function.

Testing attachment using glob patterns and via bpf_uprobe_multi_opts
paths/syms fields.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 5cd1116bbb62..28b8e8d451fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -69,8 +69,79 @@ static void test_skel_api(void)
 	uprobe_multi__destroy(skel);
 }
 
+static void
+test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
+{
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	struct bpf_link *link3 = NULL, *link4 = NULL;
+	struct uprobe_multi *skel = NULL;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	opts->retprobe = false;
+	link1 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
+		goto cleanup;
+
+	opts->retprobe = false;
+	link3 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe_sleep, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	link4 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe_sleep, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	bpf_link__destroy(link4);
+	bpf_link__destroy(link3);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
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


