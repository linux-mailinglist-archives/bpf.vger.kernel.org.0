Return-Path: <bpf+bounces-5461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CD75AD2C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAF81C213EA
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DB17FE7;
	Thu, 20 Jul 2023 11:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D71174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D630EC433C8;
	Thu, 20 Jul 2023 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853162;
	bh=n1KB+WDu9D681cV0l4zEC5LDZYZ+vt8QEyxrCaRiSh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOysyxJS8+QitYIs9QHlHowvTdurw9lSDFDiOXfVvaSOJ+jkfEY85Dr4YPAmXZfaJ
	 rmKdP0qVb1cWKNMjQlpA2IWBAGiHIUO3cv8M5tb3dBP2p1eMDniQOvOvXS0yTxuLy9
	 UJWIHJJECzyaSr3XSTIo7u95lTidIBHYIyOSVE5PqLbseVYxNMS4KliVfOEvsGudcR
	 Ahvvv5RsgYBegCDDu1ObIjPn4IHOGPps/3Hvk/8LUoyf9AeIbubiVWFcArS1sG/R3R
	 TfPyVpQ8qj5gjqihJ7H+CZRWc8WhyMHmagkOpmWKpM91w9UBImy03hiyqJ0rZgAvyf
	 3ZifU+B/mCOiQ==
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
Subject: [PATCHv4 bpf-next 20/28] selftests/bpf: Add uprobe_multi api test
Date: Thu, 20 Jul 2023 13:35:42 +0200
Message-ID: <20230720113550.369257-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
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


