Return-Path: <bpf+bounces-19091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B8D824C11
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D991C22400
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6830A40;
	Fri,  5 Jan 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otHoZpif"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D9A32
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A853C433C8;
	Fri,  5 Jan 2024 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413377;
	bh=SzxZXTsbWhPg5XXI9fg069m3qoJKnyYfo/VQugja/js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otHoZpif8Cp+9I/tixgM6hP6UuN3Ca51eI/ZgIlqccoH3v8V14VDkmiYasjbVgQst
	 fnWS6tIT/g3fCg4g8kN7LcymmOOKorMbHAyYCxaZlSMQKriSyih7UPu/iGWD9v/Scw
	 aDzBv0t19fZ2SRdy+J4c6j6/TvY13EW8a1y1pGiQaMZsOj5qi2L4obGzRt43nsP1uc
	 aKiCZvOtFeVjDAmUdtyCE4+0T1w+5RM3D19Ssn+AhPaqXavMtGyZyAtUDI4h78inId
	 LDslTXxE7I5Fpce+2B299SFcNWe1GQVY0M7EKTG/eZX2UpztJ5PWWO1HFpo205Ysup
	 NqEID7grPkduQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 8/8] selftests/bpf: add trusted/untrusted global subprog arg tests
Date: Thu,  4 Jan 2024 16:09:09 -0800
Message-Id: <20240105000909.2818934-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bunch of test cases validating behavior of __arg_trusted,
__arg_btf, and their combining with __arg_nonnull.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_global_ptr_args.c      | 160 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d62c5bf00e71..9c6072a19745 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -28,6 +28,7 @@
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
 #include "verifier_global_subprogs.skel.h"
+#include "verifier_global_ptr_args.skel.h"
 #include "verifier_gotol.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
@@ -140,6 +141,7 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
+void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
new file mode 100644
index 000000000000..e0881c9e6706
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "xdp_metadata.h"
+#include "bpf_kfuncs.h"
+
+extern struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
+extern void bpf_task_release(struct task_struct *p) __ksym __weak;
+
+__weak int subprog_btf_task_nullable(struct task_struct *task __arg_untrusted)
+{
+	if (!task)
+		return 0;
+	return task->pid + task->tgid;
+}
+
+SEC("?kprobe")
+__success __log_level(2)
+__msg("Validating subprog_btf_task_nullable() func#1...")
+__msg(": R1=untrusted_ptr_or_null_task_struct(id=2) R10=fp0")
+int btf_task_arg_nullable(void *ctx)
+{
+	struct task_struct *t = (void *)bpf_get_current_task();
+	struct task_struct *untrusted = bpf_core_cast(t, struct task_struct);
+
+	return subprog_btf_task_nullable(untrusted) + subprog_btf_task_nullable(NULL);
+}
+
+__weak int subprog_btf_task_nonnull(struct task_struct *task __arg_untrusted __arg_nonnull)
+{
+	return task->pid + task->tgid;
+}
+
+SEC("?kprobe")
+__failure __log_level(2)
+__msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Caller passes invalid args into func#1 ('subprog_btf_task_nonnull')")
+int btf_task_arg_nonnull_fail1(void *ctx)
+{
+	return subprog_btf_task_nonnull(NULL);
+}
+
+SEC("?tp_btf/task_newtask")
+__failure __log_level(2)
+__msg("R1 type=ptr_or_null_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Caller passes invalid args into func#1 ('subprog_btf_task_nonnull')")
+int btf_task_arg_nonnull_fail2(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+	struct task_struct *nullable;
+	int res;
+
+	nullable = bpf_task_acquire(t);
+
+	 /* should fail, PTR_TO_BTF_ID_OR_NULL */
+	res = subprog_btf_task_nonnull(nullable);
+
+	if (nullable)
+		bpf_task_release(nullable);
+
+	return res;
+}
+
+SEC("?kprobe")
+__success __log_level(2)
+__msg("Validating subprog_btf_task_nonnull() func#1...")
+__msg(": R1=untrusted_ptr_task_struct(id=2) R10=fp0")
+int btf_task_arg_nonnull(void *ctx)
+{
+	struct task_struct *t = (void *)bpf_get_current_task();
+
+	return subprog_btf_task_nonnull(bpf_core_cast(t, typeof(*t)));
+}
+
+__weak int subprog_nullable_trusted_task(struct task_struct *task __arg_trusted)
+{
+	char buf[16];
+
+	if (!task)
+		return 0;
+
+	return bpf_copy_from_user_task(&buf, sizeof(buf), NULL, task, 0);
+}
+
+SEC("?uprobe.s")
+__success __log_level(2)
+__msg("Validating subprog_nullable_trusted_task() func#1...")
+__msg(": R1=trusted_ptr_or_null_task_struct(id=1) R10=fp0")
+int trusted_ptr_nullable(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+
+	return subprog_nullable_trusted_task(t);
+}
+
+__weak int subprog_nonnull_trusted_task(struct task_struct *task __arg_trusted __arg_nonnull)
+{
+	char buf[16];
+
+	return bpf_copy_from_user_task(&buf, sizeof(buf), NULL, task, 0);
+}
+
+SEC("?uprobe.s")
+__success __log_level(2)
+__msg("Validating subprog_nonnull_trusted_task() func#1...")
+__msg(": R1=trusted_ptr_task_struct(id=1) R10=fp0")
+int trusted_ptr_nonnull(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+
+	return subprog_nonnull_trusted_task(t);
+}
+
+__weak int subprog_trusted_destroy(struct task_struct *task __arg_trusted)
+{
+	if (!task)
+		return 0;
+
+	bpf_task_release(task); /* should be rejected */
+
+	return 0;
+}
+
+SEC("?tp_btf/task_newtask")
+__failure __log_level(2)
+__msg("release kernel function bpf_task_release expects refcounted PTR_TO_BTF_ID")
+int BPF_PROG(trusted_destroy_fail, struct task_struct *task, u64 clone_flags)
+{
+	return subprog_trusted_destroy(task);
+}
+
+__weak int subprog_trusted_acq_rel(struct task_struct *task __arg_trusted)
+{
+	struct task_struct *owned;
+
+	if (!task)
+		return 0;
+
+	owned = bpf_task_acquire(task);
+	if (!owned)
+		return 0;
+
+	bpf_task_release(owned); /* this one is OK, we acquired it locally */
+
+	return 0;
+}
+
+SEC("?tp_btf/task_newtask")
+__success __log_level(2)
+int BPF_PROG(trusted_acq_rel, struct task_struct *task, u64 clone_flags)
+{
+	return subprog_trusted_acq_rel(task);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


