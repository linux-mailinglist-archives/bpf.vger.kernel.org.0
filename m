Return-Path: <bpf+bounces-3791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E291743785
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE16281003
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1B8A957;
	Fri, 30 Jun 2023 08:38:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A6A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5000C433C0;
	Fri, 30 Jun 2023 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114314;
	bh=6SXTWVOLI7wqDLoX13ipktDRhQL8JTRXvac7QW5dSm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV2qcfsS4GEVBl+dIYupU1tPX3rex6Od4TbhHzFiaUpxhE2KZlBgf09zCsOBUzi1f
	 nt5ZNv3cQgPt4riCfRk/eujiYQJTGjww9Fa6o25LVJUUHvy6Ihnm0EmsXiFaN1GL9i
	 X7wqXQOca8YVPo1xXHOStWkc/hzuhBpnE++wqgQkJPgdeXu3HRzbi1CPD2rFKZQyxI
	 26H5NgqXF8ymdA2sdyPcgMo6SwGextb40Sj7TprxM4idJfsBLSPNyGqj60irenht4f
	 NF6mIWm37QF7PpiuwPtrdto/JXP/tmAbnDUX6HZwRulw0oE+bI+oF77JDvPhmQ5JkQ
	 0QX5XZ4lBOMhg==
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
Subject: [PATCHv3 bpf-next 24/26] selftests/bpf: Add uprobe_multi cookie test
Date: Fri, 30 Jun 2023 10:33:42 +0200
Message-ID: <20230630083344.984305-25-jolsa@kernel.org>
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

Adding test for cookies setup/retrieval in uprobe_link uprobes
and making sure bpf_get_attach_cookie works properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 26b2d1bffdfd..4162d1724b79 100644
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
+	link1 = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe, -1,
+						 "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	cookies[0] = 2; /* uprobe_multi_func_1 */
+	cookies[1] = 3; /* uprobe_multi_func_2 */
+	cookies[2] = 1; /* uprobe_multi_func_3 */
+
+	opts.retprobe = true;
+	link2 = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe, -1,
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


