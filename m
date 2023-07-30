Return-Path: <bpf+bounces-6373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D957685C9
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AAE1C20AFB
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E12102;
	Sun, 30 Jul 2023 13:46:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B4363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C4C433C7;
	Sun, 30 Jul 2023 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724759;
	bh=kaXT5SWYy3HvZaU51TWaPrB5JkawjmLDVE9u8Ixyp60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5pBomrxaqq1pzOj9CxjZkTw5UpSuaTTXrAa+hB27vqLuueht0sYmP2iZPkGMCO98
	 DbJyHe5mcAYwtjP2ZhBWrvHbdn8kdtXMmdKS3aWrSiQWKrngYaJfqr5OQm5IKc0SfN
	 YJOvYD+XEM+Q0LlJmtD51prPx8HBoK+FdWcN3XkIqDweJBfSyZxhudFQ5t2xzOoa/o
	 LlWFBUlM/UauU+1pjtmkmi399vSDeJ+JDd6LWul6MLQV3yBMZF5jKvRJmfTDvF03En
	 lb5EbnQR+/W0vAby+4JrjrHXdWDvLHpJ/IYf3ruVVF8zpKfpnF+OB98w9L4GRdm5zg
	 aeMezhIMiJKiQ==
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
Subject: [PATCHv5 bpf-next 21/28] selftests/bpf: Add uprobe_multi link test
Date: Sun, 30 Jul 2023 15:42:16 +0200
Message-ID: <20230730134223.94496-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730134223.94496-1-jolsa@kernel.org>
References: <20230730134223.94496-1-jolsa@kernel.org>
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
 .../bpf/prog_tests/uprobe_multi_test.c        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2ac8954123e4..e460fd4d370d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -3,6 +3,7 @@
 #include <unistd.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
+#include "bpf/libbpf_internal.h"
 
 static char test_data[] = "test_data";
 
@@ -130,6 +131,71 @@ static void test_attach_api_syms(void)
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
@@ -138,4 +204,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_pattern();
 	if (test__start_subtest("attach_api_syms"))
 		test_attach_api_syms();
+	if (test__start_subtest("link_api"))
+		test_link_api();
 }
-- 
2.41.0


