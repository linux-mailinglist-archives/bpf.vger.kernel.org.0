Return-Path: <bpf+bounces-73505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A0C331DB
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 22:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB70B4E7751
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799DB3469E3;
	Tue,  4 Nov 2025 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rweLj4q5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD622FABF7;
	Tue,  4 Nov 2025 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293298; cv=none; b=sBs0584TC2m85Ig0s76k4xlz2z4CFJigt/NMM7r7CN3WXhG8m8DJvfMeKo9V8JJB5ecxU17xgGiZhJi+xfrtK/3XzIhZS8LD/dwZfcjK8D6kfqbaymuWcJIhXKiqzoj1GTi+7Zpnmj+dP3M+DtQvyjXgW6vPlNyvO6xc+ys8dQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293298; c=relaxed/simple;
	bh=INngzCagyASBga4I+f+q6Xk8A/qGU3KnC77T+Drm3Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj+oe4n9MesRoKau2I4hqYIQrBAoTbOXNBqyPjAlLvIKG2m64PmviqNfp3ZEzduDvTvJkmaq+zmu3aIrXhUVPHt96BgORuuag4uJgtwMQAyAk0DCtfsCOlRgp5n06MEyvTcdnSeeNWqUT6jqmiHqYVl4XmM/7gYOv5RyzHmoEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rweLj4q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9908CC116B1;
	Tue,  4 Nov 2025 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762293297;
	bh=INngzCagyASBga4I+f+q6Xk8A/qGU3KnC77T+Drm3Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rweLj4q5NWL8QbS5ncki/D2TWohWzDadqvh9+cXva3fVDDAedQVDv9FBS90t7dgQd
	 TgTP7EjfC1mCVrzhX1izbbvIbxGqA1w70jFwoAASw6lbl0rkx5ltgMfuijzczOnmfH
	 KJKp9Pbz5XT6zNkUs48LWtnwNDh8/0zOspjjCPRDtYhLcxVl1gHjHgsj7Wo4rJLpys
	 CCYnAflM/xQBCj3/oRz9wrJ1rg5dbei2eNH3tqNqqVwspVs+C2AfO/kWPS1iUsOBki
	 pmcoE215jhFNtAxOMfNbhnbdeRqRbryN1kEQ8y4w+kRz4p0m58Pbboo4WNS5ESsyxQ
	 LsQyeBAHTJvGQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv3 4/4] selftests/bpf: Add stacktrace ips test for raw_tp
Date: Tue,  4 Nov 2025 22:54:05 +0100
Message-ID: <20251104215405.168643-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104215405.168643-1-jolsa@kernel.org>
References: <20251104215405.168643-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that verifies we get expected initial 2 entries from
stacktrace for rawtp probe via ORC unwind.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 46 +++++++++++++++++++
 .../selftests/bpf/progs/stacktrace_ips.c      |  8 ++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index 6fca459ba550..c9efdd2a5b18 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -84,12 +84,58 @@ static void test_stacktrace_ips_kprobe_multi(bool retprobe)
 	stacktrace_ips__destroy(skel);
 }
 
+static void test_stacktrace_ips_raw_tp(void)
+{
+	__u32 info_len = sizeof(struct bpf_prog_info);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_prog_info info = {};
+	struct stacktrace_ips *skel;
+	__u64 bpf_prog_ksym = 0;
+	int err;
+
+	skel = stacktrace_ips__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
+		return;
+
+	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+		test__skip();
+		goto cleanup;
+	}
+
+	skel->links.rawtp_test = bpf_program__attach_raw_tracepoint(
+							skel->progs.rawtp_test,
+							"bpf_testmod_test_read");
+	if (!ASSERT_OK_PTR(skel->links.rawtp_test, "bpf_program__attach_raw_tracepoint"))
+		goto cleanup;
+
+	/* get bpf program address */
+	info.jited_ksyms = ptr_to_u64(&bpf_prog_ksym);
+	info.nr_jited_ksyms = 1;
+	err = bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.rawtp_test),
+				      &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		goto cleanup;
+
+	trigger_module_test_read(1);
+
+	load_kallsyms();
+
+	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 2,
+			     bpf_prog_ksym,
+			     ksym_get_addr("bpf_trace_run2"));
+
+cleanup:
+	stacktrace_ips__destroy(skel);
+}
+
 static void __test_stacktrace_ips(void)
 {
 	if (test__start_subtest("kprobe_multi"))
 		test_stacktrace_ips_kprobe_multi(false);
 	if (test__start_subtest("kretprobe_multi"))
 		test_stacktrace_ips_kprobe_multi(true);
+	if (test__start_subtest("raw_tp"))
+		test_stacktrace_ips_raw_tp();
 }
 #else
 static void __test_stacktrace_ips(void)
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_ips.c b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
index e2eb30945c1b..a96c8150d7f5 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -38,4 +38,12 @@ int kprobe_multi_test(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("raw_tp/bpf_testmod_test_read")
+int rawtp_test(void *ctx)
+{
+	/* Skip ebpf program entry in the stack. */
+	stack_key = bpf_get_stackid(ctx, &stackmap, 0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


