Return-Path: <bpf+bounces-35003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B295934E29
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B837282826
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4313D63D;
	Thu, 18 Jul 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD46c9B9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9A13AD32
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309287; cv=none; b=ANFDqsLcY9uMPZEj0uyk2u8zz6nUDCKDvlNH5gHc6Vk6Uds6Fz+zGx0AjfTcleOJuAElZ0DHx3/3XEcCZ+Hz3jvOVJgvVm3WpBa3/bmMqMQuSixm+D02ZoOi64Eby6ckObcQdVrb9cTL9gABF5GYJk/XJIE0wxLWaskPw9H8SnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309287; c=relaxed/simple;
	bh=E6XbZXkIUw3rFes4kKX2xCFAuaGjEE2Tk+8UFZn+oCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhAYEfm2wbgQgnZsJ/RHHeaOrX47QEHzMB/Vt8k3TKcr7DlpcnJEEReHWlmZQLGfPpdg5zI2PIMcPiDvh/WeotkQLQsJRAETdv+lbr0fsZ6P1H9bH/XoXaqY1GiBypeDhuTQ7SeCCbhK0o3XwflShW5ed64ppa6O+zG/kEpxpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD46c9B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81155C4AF0A;
	Thu, 18 Jul 2024 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309286;
	bh=E6XbZXkIUw3rFes4kKX2xCFAuaGjEE2Tk+8UFZn+oCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qD46c9B94upHX+Hh0unoQ5iw0HJnn0V+ertn2XS5w8xWlHt1lgmxS9mGXCbY0AKdI
	 MNV6YmGNQBhEWgQrcmC117+NRLY16QThV/zIi5zJS6oHQCGr7UE2IqGmSz/pq51Ct0
	 Y7/y7K6WghO7m2Acmn09MgP8EriMpYH4X3eIjng+ip+s41YeGr94hGIg+bdj27Zbn1
	 26E8N//OlWQehIKVYPJNGoWoUl8gx7JC5ypTGxbAf1szUx9QejMnvKnKvSnY2gBl8A
	 bU537KCTvjxlkgSIf1L5hYgChWkTU6qJFjSPjgnlYZl9E/1/wpWX/aBqtJA0YSW+WH
	 EDURk2Dd53jmw==
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
Subject: [PATCHv2 bpf-next 1/2] selftests/bpf: Add uprobe fail tests for uprobe multi
Date: Thu, 18 Jul 2024 15:27:49 +0200
Message-ID: <20240718132750.2914808-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718132750.2914808-1-jolsa@kernel.org>
References: <20240718132750.2914808-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addig tests for checking on recovery after failing to
attach uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index bf6ca8e3eb13..da8873f24a53 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -516,6 +516,113 @@ static void test_attach_api_fails(void)
 	uprobe_multi__destroy(skel);
 }
 
+#ifdef __x86_64__
+noinline __attribute__((naked)) void uprobe_multi_error_func(void)
+{
+	asm volatile ("int3");
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
+		"uprobe_multi_error_func",
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
+static short sema_1 __maybe_unused, sema_2 __maybe_unused;
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
+	 * We attach to 3 uprobes on 2 functions so 2 uprobes share single function,
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
@@ -703,4 +810,6 @@ void test_uprobe_multi_test(void)
 		test_bench_attach_usdt();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	if (test__start_subtest("attach_uprobe_fails"))
+		test_attach_uprobe_fails();
 }
-- 
2.45.2


