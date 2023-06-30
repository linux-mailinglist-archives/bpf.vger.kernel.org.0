Return-Path: <bpf+bounces-3785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C3574377B
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312A31C209A2
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B8A957;
	Fri, 30 Jun 2023 08:37:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F89A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1FAC433C8;
	Fri, 30 Jun 2023 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114244;
	bh=E92IeJoLSBFkGbrsbYzpFje+U2zekAnDaxcskWWFil0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTdmJ/a8VNxJNWMkhaBEnwDqFjxZLU5MkjStmQeOqTmtnpzW/Ez8IwOoI+cZj2RO/
	 r/M+xvjbp6NYi9iO6YiMzKZY6TlaL5vRn72CFcsHHWTh42L2P0Z72NPIWdOI0pbGkM
	 tz7MdNA73vA3vVkxwCBv7Q7xPjLbG8ELgHGX9kXsZmj+ChK31BRAwffGMH6a0YNvhZ
	 MRVs+0Y++wLXn9vweDG3U2M+lUsE4j7e2M/ip2xQmnsvHYjNWcOSMotyOGsmFvyVP4
	 cjjuYANZCQ1ioWIwnZ+SpHT1N+hml20fMqp2oJAVpXh+0pswYeYvmC4/PgfUj3lrXC
	 /CGQH1LVUNOCw==
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
Subject: [PATCHv3 bpf-next 18/26] selftests/bpf: Add uprobe_multi api test
Date: Fri, 30 Jun 2023 10:33:36 +0200
Message-ID: <20230630083344.984305-19-jolsa@kernel.org>
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

Adding uprobe_multi test for bpf_program__attach_uprobe_multi
attach function.

Testing attachment using glob patterns and via bpf_uprobe_multi_opts
paths/syms fields.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 5cd1116bbb62..f97a68871e73 100644
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
+	link1 = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retprobe"))
+		goto cleanup;
+
+	opts->retprobe = false;
+	link3 = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_sleep, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	opts->retprobe = true;
+	link4 = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_sleep, -1,
+						      binary, pattern, opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retprobe"))
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


