Return-Path: <bpf+bounces-7313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E547755BD
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DE71C21029
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B8182DF;
	Wed,  9 Aug 2023 08:38:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AE6AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C677C433C8;
	Wed,  9 Aug 2023 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570300;
	bh=DSOy7tf57CPi59BqT+HgfoPBm60V5VC+YwYP7qkR+HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAd72I7fwdqapkTH/LuAZUHTmA31ll2zpt4cL8GvGPJlD1EOU/mWxqF5VjXSOs/dM
	 DwV0MuH5NoY95zyM+/sxIDostD0tN5HUFpwzUWA6+72Z1+qXRtMAuCr4xvKbXVzJTK
	 Apa1LZ1ZKURDKHI0gdeFCJI2PHHIfwJNDLkuqM6iQzZru5qYAMTmyOfA1Grf8Klt6M
	 u1MZsS8/bKz4gHPWrO2AKKG4YM0EqD0ntSLaESlQJp8U6ZLBLQ5H7kZ9OURbgVsaUd
	 ug00dF5u2BPu8YmGgGgMMfRdaYe4k1O9555lUYzbv6u516rjn4g566GNBPcFhI1Vz0
	 I5i2E/TqIAa0Q==
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
Subject: [PATCHv7 bpf-next 21/28] selftests/bpf: Add uprobe_multi link test
Date: Wed,  9 Aug 2023 10:34:33 +0200
Message-ID: <20230809083440.3209381-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe_multi test for bpf_link_create attach function.

Testing attachment using the struct bpf_link_create_opts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2ac8954123e4..3860beda82c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -3,6 +3,7 @@
 #include <unistd.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
+#include "bpf/libbpf_internal.h"
 
 static char test_data[] = "test_data";
 
@@ -130,6 +131,72 @@ static void test_attach_api_syms(void)
 	test_attach_api("/proc/self/exe", NULL, &opts);
 }
 
+static void test_link_api(void)
+{
+	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *path = "/proc/self/exe";
+	struct uprobe_multi *skel = NULL;
+	unsigned long *offsets = NULL;
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+	int err;
+
+	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
+		return;
+
+	opts.uprobe_multi.path = path;
+	opts.uprobe_multi.offsets = offsets;
+	opts.uprobe_multi.cnt = ARRAY_SIZE(syms);
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	opts.kprobe_multi.flags = 0;
+	prog_fd = bpf_program__fd(skel->progs.uprobe);
+	link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link1_fd, 0, "link1_fd"))
+		goto cleanup;
+
+	opts.kprobe_multi.flags = BPF_F_UPROBE_MULTI_RETURN;
+	prog_fd = bpf_program__fd(skel->progs.uretprobe);
+	link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link2_fd, 0, "link2_fd"))
+		goto cleanup;
+
+	opts.kprobe_multi.flags = 0;
+	prog_fd = bpf_program__fd(skel->progs.uprobe_sleep);
+	link3_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link3_fd, 0, "link3_fd"))
+		goto cleanup;
+
+	opts.kprobe_multi.flags = BPF_F_UPROBE_MULTI_RETURN;
+	prog_fd = bpf_program__fd(skel->progs.uretprobe_sleep);
+	link4_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link4_fd, 0, "link4_fd"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	if (link1_fd >= 0)
+		close(link1_fd);
+	if (link2_fd >= 0)
+		close(link2_fd);
+	if (link3_fd >= 0)
+		close(link3_fd);
+	if (link4_fd >= 0)
+		close(link4_fd);
+
+	uprobe_multi__destroy(skel);
+	free(offsets);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -138,4 +205,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_pattern();
 	if (test__start_subtest("attach_api_syms"))
 		test_attach_api_syms();
+	if (test__start_subtest("link_api"))
+		test_link_api();
 }
-- 
2.41.0


