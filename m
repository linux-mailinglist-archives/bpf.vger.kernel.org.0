Return-Path: <bpf+bounces-20349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DB83CDE0
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D471C25C94
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14431386D2;
	Thu, 25 Jan 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBQcdUeL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7081339BD
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216135; cv=none; b=mciO2bC3DBn3DjHOUdYuf560LWKdFOuSIckEUWH7KiF3/y0kiG5YXXg1G57d2lXpCDlXH5f5w2irWrbGynY4hvtnvs0frck3I2SCqWZU5UzyNjRneiG5kOnwdxdhZqsaKK4ddAppYwXzw80M0UGjKPDsIRyw5oX13HHcE4DMWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216135; c=relaxed/simple;
	bh=EGBRGZQn7EKYEiDl9jB01mncPW8c90urAXwP0Xi8Sqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpjhX4AHxjnXQ1QAVhCxZR7ipT7hXJto9MpYE25IUqLBepNst5IkWz8W5wVUlcRrsMs6Yj4GOFCgwyFlKXQcPrx5KuFetA74MbEyVGtzMpXH6nVgpLFjrz4yCHbYIkk1e8/l6YeacTN3Zj3qKOOi/oE6NonpqKzdmSGKn/YOjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBQcdUeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9647FC43394;
	Thu, 25 Jan 2024 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216134;
	bh=EGBRGZQn7EKYEiDl9jB01mncPW8c90urAXwP0Xi8Sqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBQcdUeLqhAnMsuVzZBl6LIZlKWehaKk6s02l9oqSiBFzemc4d2/udG80jAHTeW9j
	 1qBrCnqzjby0Uj3AaXqbJ1GiIi3iS8wPWuV+LX2DQmGteiyVQLdnpH7C1D/0MeZq4Z
	 ltF/+4cIIV1dJrxm46mAEDl1sUcATmA0hTOPTHWXDZT+8GoDIjUQjx7QVWRPyn2fqi
	 ++UKRGK/sIHTbw8b+hh4sa3zWn6fDBt9l/HF9P77a3hMbO4IvNFytw5rzTblcS3ITO
	 IpiUeIiOvtviMde02EHOA5JZRyqEzrWdOCMvoq8a/aHnuq0bBLTCKLULtp6B7eN+l5
	 nLbHdPNXRLbdA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 7/7] selftests/bpf: add trusted global subprog arg tests
Date: Thu, 25 Jan 2024 12:55:10 -0800
Message-Id: <20240125205510.3642094-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bunch of test cases validating behavior of __arg_trusted and its
combination with __arg_maybe_null tag. We also validate CO-RE flavor
support by kernel for __arg_trusted args.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_global_ptr_args.c      | 156 ++++++++++++++++++
 2 files changed, 158 insertions(+)
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
index 000000000000..64ce4fac3137
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -0,0 +1,156 @@
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
+__weak int subprog_trusted_task_maybe_null(struct task_struct *task __arg_trusted __arg_maybe_null)
+{
+	if (!task)
+		return 0;
+	return task->pid + task->tgid;
+}
+
+SEC("?kprobe")
+__success __log_level(2)
+__msg("Validating subprog_trusted_task_maybe_null() func#1...")
+__msg(": R1=trusted_ptr_or_null_task_struct(")
+int trusted_task_arg_maybe_null(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+
+	return subprog_trusted_task_maybe_null(t) + subprog_trusted_task_maybe_null(NULL);
+}
+
+__weak int subprog_trusted_task_nonnull(struct task_struct *task __arg_trusted)
+{
+	return task->pid + task->tgid;
+}
+
+SEC("?kprobe")
+__failure __log_level(2)
+__msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Caller passes invalid args into func#1 ('subprog_trusted_task_nonnull')")
+int trusted_task_arg_nonnull_fail1(void *ctx)
+{
+	return subprog_trusted_task_nonnull(NULL);
+}
+
+SEC("?tp_btf/task_newtask")
+__failure __log_level(2)
+__msg("R1 type=ptr_or_null_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Caller passes invalid args into func#1 ('subprog_trusted_task_nonnull')")
+int trusted_task_arg_nonnull_fail2(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+	struct task_struct *maybe_null;
+	int res;
+
+	maybe_null = bpf_task_acquire(t);
+
+	 /* should fail, PTR_TO_BTF_ID_OR_NULL */
+	res = subprog_trusted_task_nonnull(maybe_null);
+
+	if (maybe_null)
+		bpf_task_release(maybe_null);
+
+	return res;
+}
+
+SEC("?kprobe")
+__success __log_level(2)
+__msg("Validating subprog_trusted_task_nonnull() func#1...")
+__msg(": R1=trusted_ptr_task_struct(")
+int trusted_task_arg_nonnull(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+
+	return subprog_trusted_task_nonnull(t);
+}
+
+struct task_struct___local {} __attribute__((preserve_access_index));
+
+__weak int subprog_maybe_null_task_flavor(
+	struct task_struct___local *task __arg_trusted __arg_maybe_null)
+{
+	char buf[16];
+
+	if (!task)
+		return 0;
+
+	return bpf_copy_from_user_task(&buf, sizeof(buf), NULL, (void *)task, 0);
+}
+
+SEC("?uprobe.s")
+__success __log_level(2)
+__msg("Validating subprog_maybe_null_task_flavor() func#1...")
+__msg(": R1=trusted_ptr_or_null_task_struct(")
+int flavor_ptr_maybe_null(void *ctx)
+{
+	struct task_struct___local *t = (void *)bpf_get_current_task_btf();
+
+	return subprog_maybe_null_task_flavor(t);
+}
+
+__weak int subprog_nonnull_task_flavor(struct task_struct___local *task __arg_trusted)
+{
+	char buf[16];
+
+	return bpf_copy_from_user_task(&buf, sizeof(buf), NULL, (void *)task, 0);
+}
+
+SEC("?uprobe.s")
+__success __log_level(2)
+__msg("Validating subprog_nonnull_task_flavor() func#1...")
+__msg(": R1=trusted_ptr_task_struct(")
+int flavor_ptr_nonnull(void *ctx)
+{
+	struct task_struct *t = bpf_get_current_task_btf();
+
+	return subprog_nonnull_task_flavor((void *)t);
+}
+
+__weak int subprog_trusted_destroy(struct task_struct *task __arg_trusted)
+{
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


