Return-Path: <bpf+bounces-6821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160B76E208
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B0C1C21478
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5913AD9;
	Thu,  3 Aug 2023 07:38:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC119454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A010DC433C8;
	Thu,  3 Aug 2023 07:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048328;
	bh=UVSEgNTzIVPEsp/ldi2kMTzfANM9le6efNH62rxLv0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uOEOW2v5pAA+k8Hx94D00YZaJugsKZesTJCfrK8vmrZEg3MCsD5l5JszW1OD+wFTD
	 1KuiedND0BQSMH9FMQwLzyVCKi5I9tRaI0Xc5EOtfJEh3oRWnth1HxAIoncpJiip5u
	 zibCzbmB0tdLEj1FcQGO3AJuB9/WMnrQdiBZvw+UIuFmwC2TK0BQwpYvwCgfe9eDsW
	 qRfJq1R/l0gTUoDDDXDRaHg30KPBz51T6SCuFSBAf+Se8jtc22/lKe9BNe+7Y3fxcU
	 jHfHwB+mTCAdDwY857zr6sXuq+GG4Ye6MQpyzMWb36+de2RP0fkyaL9/lBvVMQQHr2
	 djfw1DTWXcWCg==
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
Subject: [PATCHv6 bpf-next 26/28] selftests/bpf: Add uprobe_multi cookie test
Date: Thu,  3 Aug 2023 09:34:18 +0200
Message-ID: <20230803073420.1558613-27-jolsa@kernel.org>
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

Adding test for cookies setup/retrieval in uprobe_link uprobes
and making sure bpf_get_attach_cookie works properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 26b2d1bffdfd..1454cebc262b 100644
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
+	link1 = bpf_program__attach_uprobe_multi(skel->progs.uprobe, -1,
+						 "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	cookies[0] = 2; /* uprobe_multi_func_1 */
+	cookies[1] = 3; /* uprobe_multi_func_2 */
+	cookies[2] = 1; /* uprobe_multi_func_3 */
+
+	opts.retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi(skel->progs.uretprobe, -1,
+						      "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_retprobe"))
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


