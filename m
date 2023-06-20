Return-Path: <bpf+bounces-2902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF473667A
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDCE1C204FD
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75CC121;
	Tue, 20 Jun 2023 08:39:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F054400
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93143C433C0;
	Tue, 20 Jun 2023 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250369;
	bh=kZy5bTsbbvLVgAHgZbnAdm5n4EFCVtfh0fohPp/Ix+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhdEH0NdaP2fTsgpEo7cRSCaRt9MbAx/V6ZCNjFQlQeaktmDf7OQp99wbQw4p499t
	 wAuExOT6ejEO5VM0qw4Is+2iMqhEBhOI+cW8XTF+Sz32TG7Q64mHKWRfAWkJVYo0Uq
	 lMwgwzI9uKDmfa5+OXAOAy22nJrcyjTSYwiEj1vzp7TbvsUIpeRvwdUscLaRTKDaoF
	 E0A1oUPZfF1KHQLi2RBtnHtgfUVe8veW05Jhynqht4Bz4JExjLqYMDHQlbxRQjbI5k
	 zgT8A1o3NNCQ7qE34oaLCzG0Vl25nwYubP75krvN511Kd43dAikgSovIs1zMLfYwS+
	 iGEoTuBmk++hA==
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
Subject: [PATCHv2 bpf-next 22/24] selftests/bpf: Add uprobe_multi cookie test
Date: Tue, 20 Jun 2023 10:35:48 +0200
Message-ID: <20230620083550.690426-23-jolsa@kernel.org>
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

Adding test for cookies setup/retrieval in uprobe_link uprobes
and making sure bpf_get_attach_cookie works properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 26b2d1bffdfd..47f692a64cef 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -11,6 +11,7 @@
 #include <bpf/btf.h>
 #include "test_bpf_cookie.skel.h"
 #include "kprobe_multi.skel.h"
+#include "uprobe_multi.skel.h"
 
 /* uprobe attach point */
 static noinline void trigger_func(void)
@@ -239,6 +240,81 @@ static void kprobe_multi_attach_api_subtest(void)
 	bpf_link__destroy(link1);
 	kprobe_multi__destroy(skel);
 }
+
+/* defined in prog_tests/uprobe_multi_test.c */
+void uprobe_multi_func_1(void);
+void uprobe_multi_func_2(void);
+void uprobe_multi_func_3(void);
+
+static void uprobe_multi_test_run(struct uprobe_multi *skel)
+{
+	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
+	skel->bss->uprobe_multi_func_2_addr = (__u64) uprobe_multi_func_2;
+	skel->bss->uprobe_multi_func_3_addr = (__u64) uprobe_multi_func_3;
+
+	skel->bss->pid = getpid();
+	skel->bss->test_cookie = true;
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 1, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_2_result, 1, "uprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_3_result, 1, "uprobe_multi_func_3_result");
+
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_1_result, 1, "uretprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_2_result, 1, "uretprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_3_result, 1, "uretprobe_multi_func_3_result");
+}
+
+static void uprobe_multi_attach_api_subtest(void)
+{
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	struct uprobe_multi *skel = NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+	__u64 cookies[3];
+
+	cookies[0] = 3; /* uprobe_multi_func_1 */
+	cookies[1] = 1; /* uprobe_multi_func_2 */
+	cookies[2] = 2; /* uprobe_multi_func_3 */
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+	opts.cookies = &cookies[0];
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi"))
+		goto cleanup;
+
+	link1 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe, -1,
+						      "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
+		goto cleanup;
+
+	cookies[0] = 2; /* uprobe_multi_func_1 */
+	cookies[1] = 3; /* uprobe_multi_func_2 */
+	cookies[2] = 1; /* uprobe_multi_func_3 */
+
+	opts.retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe, -1,
+						      "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+	uprobe_multi__destroy(skel);
+}
+
 static void uprobe_subtest(struct test_bpf_cookie *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
@@ -515,6 +591,8 @@ void test_bpf_cookie(void)
 		kprobe_multi_attach_api_subtest();
 	if (test__start_subtest("uprobe"))
 		uprobe_subtest(skel);
+	if (test__start_subtest("multi_uprobe_attach_api"))
+		uprobe_multi_attach_api_subtest();
 	if (test__start_subtest("tracepoint"))
 		tp_subtest(skel);
 	if (test__start_subtest("perf_event"))
-- 
2.41.0


