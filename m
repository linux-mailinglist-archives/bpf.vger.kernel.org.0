Return-Path: <bpf+bounces-35269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFCD9394C2
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D28928246D
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105EF28689;
	Mon, 22 Jul 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjIFCV/m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA551CA84
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680095; cv=none; b=PmST3Qk2RbN42BNF43hqhnOJ9YJ4P4DptY/BDrdKYeK/9pZdurwTnqSLHflA/7RLAMPuy54VwXV3lo/nuK7JUdH1VzplIKLJ94ikIeSBlFit5C534Aiy09fp13fTP3uDA1N55byzz85deQGY6cYWKTBdJc/dXRuNmwpNfq52ZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680095; c=relaxed/simple;
	bh=OBc70DlZ1Pa49y9DsiC9+VbiwrZA4g4c3HU4DsFa7vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+6SN8PFRvUa9tRf+PMSKvQ/FLr2JLqI1/REpcpgbvAARyYvisUSNxABzkRNnb+VtFoGqNTX+2tWyAjXfxeopP/IlRyLjSoN0j570rkcE2cbrnpVX6SYebtQZEuVhYXWZ9OZqB+LnzFjIXLpQmVRckULBhRDBMxpFKcSTCPPq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjIFCV/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE6C116B1;
	Mon, 22 Jul 2024 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721680095;
	bh=OBc70DlZ1Pa49y9DsiC9+VbiwrZA4g4c3HU4DsFa7vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjIFCV/mlcm5AvtRYQaIMgb453zcL+uFu/DS4Zco7laYwCmg3JjQl/Iqmtu0Dw/rM
	 7jkMHJkqfRxwHGUoHu0SkQnk52zKBFgyJ/MprBpma2kmD4cTI0YTxQPEyLrj2ms4WR
	 mqGWq7j6xbjhGFiUk60/IpiEX7yNrOaj9YKPWVBj2ypm/785FMVG+JTF8aTcO7/Ui9
	 iJoM1n4xH8OBl+/9nqpJkbue6dd6qgFBiDVJ5vIT9aaJ5QEGDD2IvEOjyd2y5JSZG7
	 Zlz947g/RZHikq0RVgwLlThAQisrpN0IHG5D7rSVvEbPbem3n27jD2Bl0E3Yqoy3yr
	 Nf0WMDJTKD56Q==
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
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv3 bpf-next 1/2] selftests/bpf: Add uprobe fail tests for uprobe multi
Date: Mon, 22 Jul 2024 22:27:57 +0200
Message-ID: <20240722202758.3889061-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722202758.3889061-1-jolsa@kernel.org>
References: <20240722202758.3889061-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for checking on recovery after failing to
attach uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index bf6ca8e3eb13..e6255d4df81d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -516,6 +516,122 @@ static void test_attach_api_fails(void)
 	uprobe_multi__destroy(skel);
 }
 
+#ifdef __x86_64__
+noinline void uprobe_multi_error_func(void)
+{
+	/*
+	 * If --fcf-protection=branch is enabled the gcc generates endbr as
+	 * first instruction, so marking the exact address of int3 with the
+	 * symbol to be used in the attach_uprobe_fail_trap test below.
+	 */
+	asm volatile (
+		".globl uprobe_multi_error_func_int3;	\n"
+		"uprobe_multi_error_func_int3:		\n"
+		"int3					\n"
+	);
+}
+
+/*
+ * Attaching uprobe on uprobe_multi_error_func results in error
+ * because it already starts with int3 instruction.
+ */
+static void attach_uprobe_fail_trap(struct uprobe_multi *skel)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	const char *syms[4] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+		"uprobe_multi_error_func_int3",
+	};
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+
+	skel->links.uprobe = bpf_program__attach_uprobe_multi(skel->progs.uprobe, -1,
+							      "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_ERR_PTR(skel->links.uprobe, "bpf_program__attach_uprobe_multi")) {
+		bpf_link__destroy(skel->links.uprobe);
+		skel->links.uprobe = NULL;
+	}
+}
+#else
+static void attach_uprobe_fail_trap(struct uprobe_multi *skel) { }
+#endif
+
+short sema_1 __used, sema_2 __used;
+
+static void attach_uprobe_fail_refctr(struct uprobe_multi *skel)
+{
+	unsigned long *tmp_offsets = NULL, *tmp_ref_ctr_offsets = NULL;
+	unsigned long offsets[3], ref_ctr_offsets[3];
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *path = "/proc/self/exe";
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+	};
+	const char *sema[3] = {
+		"sema_1",
+		"sema_2",
+	};
+	int prog_fd, link_fd, err;
+
+	prog_fd = bpf_program__fd(skel->progs.uprobe_extra);
+
+	err = elf_resolve_syms_offsets("/proc/self/exe", 2, (const char **) &syms,
+				       &tmp_offsets, STT_FUNC);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_func"))
+		return;
+
+	err = elf_resolve_syms_offsets("/proc/self/exe", 2, (const char **) &sema,
+				       &tmp_ref_ctr_offsets, STT_OBJECT);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_sema"))
+		goto cleanup;
+
+	/*
+	 * We attach to 3 uprobes on 2 functions, so 2 uprobes share single function,
+	 * but with different ref_ctr_offset which is not allowed and results in fail.
+	 */
+	offsets[0] = tmp_offsets[0]; /* uprobe_multi_func_1 */
+	offsets[1] = tmp_offsets[1]; /* uprobe_multi_func_2 */
+	offsets[2] = tmp_offsets[1]; /* uprobe_multi_func_2 */
+
+	ref_ctr_offsets[0] = tmp_ref_ctr_offsets[0]; /* sema_1 */
+	ref_ctr_offsets[1] = tmp_ref_ctr_offsets[1]; /* sema_2 */
+	ref_ctr_offsets[2] = tmp_ref_ctr_offsets[0]; /* sema_1, error */
+
+	opts.uprobe_multi.path = path;
+	opts.uprobe_multi.offsets = (const unsigned long *) &offsets;
+	opts.uprobe_multi.ref_ctr_offsets = (const unsigned long *) &ref_ctr_offsets;
+	opts.uprobe_multi.cnt = 3;
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		close(link_fd);
+
+cleanup:
+	free(tmp_ref_ctr_offsets);
+	free(tmp_offsets);
+}
+
+static void test_attach_uprobe_fails(void)
+{
+	struct uprobe_multi *skel = NULL;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		return;
+
+	/* attach fails due to adding uprobe on trap instruction, x86_64 only */
+	attach_uprobe_fail_trap(skel);
+
+	/* attach fail due to wrong ref_ctr_offs on one of the uprobes */
+	attach_uprobe_fail_refctr(skel);
+
+	uprobe_multi__destroy(skel);
+}
+
 static void __test_link_api(struct child *child)
 {
 	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
@@ -703,4 +819,6 @@ void test_uprobe_multi_test(void)
 		test_bench_attach_usdt();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	if (test__start_subtest("attach_uprobe_fails"))
+		test_attach_uprobe_fails();
 }
-- 
2.45.2


