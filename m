Return-Path: <bpf+bounces-46947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6B9F19F4
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB9A16B0F8
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03831F12E2;
	Fri, 13 Dec 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T9uV/XWu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D201EE031
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132606; cv=none; b=HhHZPfqb+rF01fGXtdZEEHAkgtH43GtsDvu9ScGWHRIr/6TghcI1hn3op9J0/oOOwmI6Fk3bRWLBBCRyj6GPuT1Nc4o2SmM7HCwd4Vnt32q+k2sfh95DCB8BY1/CmkbQMkx1oWXBRMvb4uXaRsODj1KO2Yi6RonEO1iF1fRKDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132606; c=relaxed/simple;
	bh=UROdt2KIRlGXGZhC8MmjrpDHu3slO/reGPSVhfuuSh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhcLcRbWjnr0M3UNm36J2CRS5HcL9edCDAI4m6jVzAtQdvt8zPGHIEm3+6dheF9cEF6gmMQUmYC3UmMhJWysMWzlav8QPpFNuG3oUE1r8q6E+ppQNZANHPn7Xbh9XVYkby0gmSlShQi/Y23kfrX+xyhYLAg7PT2A6sTTVXbrUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T9uV/XWu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4674f1427deso27318601cf.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132602; x=1734737402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uWgir9hdNGMP/IRXbQNB+3vdHPYt1xWCe9npuxYxzI=;
        b=T9uV/XWu3LoXyfeS833kHdlHGJkGuqEUpRKAVHgo+PY92x62mdu/twd5GXwvAsVKA6
         qWDVzh2N2U4fYKyKy99ypdHhtk7xGwJFEhKFArLXHyi9BCjgMasa/QfNcGROhdysixRl
         K/FrMTzypinlKsqK9ESESphZUx8jVBOWqYL84Qayh63w8nrKS9bo3+fUQGAnvdux66Tl
         7sgqCCYRZrmWzTn0+LsPjL5CQKM7U80zYKtlLeV5uoQf0nWGGrYjqAB4JeZ0Bz+ts+EG
         vF6poCZaFYso8mKILd1+eXSxJdomrlI8lhe3ahTth7T6cofOzmkWNpC+DrqvqRKYnOo5
         L6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132602; x=1734737402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uWgir9hdNGMP/IRXbQNB+3vdHPYt1xWCe9npuxYxzI=;
        b=P/1WvpynWepIgDdHQlVzWKnJgv/gvPRBJH+D54XQhnfAGR9gh/4SvHAMCPOZXUTPTp
         XxddVaEgBRT96Blogna1gN72KbyyfzQ7/dDjTgu1lfqm/gooCIfF1go/Kb/TF4wnq7Cy
         cRhsTOs7QKAFAGqVeNh0GkO+H5Bo+tFlMeqMWdZ3s7huCIWAjWkcDSsmGY3tblp5wEFu
         dPPPt6u++QNWqMu14tFo/ziGis8ygyKfysUrQOr02soLbRvuPmQKPDD+Ey+BYz/4UwID
         42b/K4Pv0vx+7PHf0srbk6wUJyPUaLk/OtYJ/FVLYsykEiNYLI6Ml3f9iuSLifhy1sIM
         oqBQ==
X-Gm-Message-State: AOJu0YyeI323cm/cRwAWO3Md+TO4jca426EiEgOBjGqD4eg9NutI/QyN
	//Z9FHAJemx0BV41XSgYK29jeAL5Iwvi7mwJMGn8YpLyHQUXq88PeRh2HIVe86o=
X-Gm-Gg: ASbGncsLJ/AasFzFl7Ym/wAaj4OYxzoANztzt1DEGzDnOiwPwNdm1jGwjE343g+2oWA
	uaU+S2m2ZM1wvvq9nAKX4YVgG+AvPnrKTWooVcsoxuLPFrG1HvDoWNfVBV5RGJ72ANzMrUvtCPi
	cW4qTYeXSZkV3izgY+lWwpczz+T1XV7GSxgou4ZE1e1nQLaKmbggczmnxZ7tOfhPOOIdgF84kdr
	8nBF1f7ca6QyYI0Ws3CTDazh14SvfAIwJPR4zI//2jNFzFUd08mYPN2M2FTYgzjwnA+YGsjarzU
X-Google-Smtp-Source: AGHT+IHNLiyVdLTQryJ5zl/BlLI0w3IMaaqQp710LjXBU8Kp9kkx4QGyMUZU5Ga/n0POhRU/eSwXDQ==
X-Received: by 2002:ac8:5741:0:b0:467:6cd9:3093 with SMTP id d75a77b69052e-467a582a976mr89521851cf.46.1734132602601;
        Fri, 13 Dec 2024 15:30:02 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:02 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 02/13] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Fri, 13 Dec 2024 23:29:47 +0000
Message-Id: <20241213232958.2388301-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test referenced kptr acquired through struct_ops argument tagged with
"__ref". The success case checks whether 1) a reference to the correct
type is acquired, and 2) the referenced kptr argument can be accessed in
multiple paths as long as it hasn't been released. In the fail cases,
we first confirm that a referenced kptr acquried through a struct_ops
argument is not allowed to be leaked. Then, we make sure this new
referenced kptr acquiring mechanism does not accidentally allow referenced
kptrs to flow into global subprograms through their arguments.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
 .../prog_tests/test_struct_ops_refcounted.c   | 58 ++++++++++++++++
 .../bpf/progs/struct_ops_refcounted.c         | 67 +++++++++++++++++++
 ...ruct_ops_refcounted_fail__global_subprog.c | 32 +++++++++
 .../struct_ops_refcounted_fail__ref_leak.c    | 17 +++++
 6 files changed, 183 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 987d41af71d2..244234546ae2 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1135,10 +1135,17 @@ static int bpf_testmod_ops__test_maybe_null(int dummy,
 	return 0;
 }
 
+static int bpf_testmod_ops__test_refcounted(int dummy,
+					    struct task_struct *task__ref)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
+	.test_refcounted = bpf_testmod_ops__test_refcounted,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index fb7dff47597a..0e31586c1353 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -36,6 +36,8 @@ struct bpf_testmod_ops {
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
 	int (*unsupported_ops)(void);
+	/* Used to test ref_acquired arguments. */
+	int (*test_refcounted)(int dummy, struct task_struct *task);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
new file mode 100644
index 000000000000..976df951b700
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
@@ -0,0 +1,58 @@
+#include <test_progs.h>
+
+#include "struct_ops_refcounted.skel.h"
+#include "struct_ops_refcounted_fail__ref_leak.skel.h"
+#include "struct_ops_refcounted_fail__global_subprog.skel.h"
+
+/* Test that the verifier accepts a program that first acquires a referenced
+ * kptr through context and then releases the reference
+ */
+static void refcounted(void)
+{
+	struct struct_ops_refcounted *skel;
+
+	skel = struct_ops_refcounted__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_refcounted__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that acquires a referenced
+ * kptr through context without releasing the reference
+ */
+static void refcounted_fail__ref_leak(void)
+{
+	struct struct_ops_refcounted_fail__ref_leak *skel;
+
+	skel = struct_ops_refcounted_fail__ref_leak__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+
+	struct_ops_refcounted_fail__ref_leak__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that contains a global
+ * subprogram with referenced kptr arguments
+ */
+static void refcounted_fail__global_subprog(void)
+{
+	struct struct_ops_refcounted_fail__global_subprog *skel;
+
+	skel = struct_ops_refcounted_fail__global_subprog__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+
+	struct_ops_refcounted_fail__global_subprog__destroy(skel);
+}
+
+void test_struct_ops_refcounted(void)
+{
+	if (test__start_subtest("refcounted"))
+		refcounted();
+	if (test__start_subtest("refcounted_fail__ref_leak"))
+		refcounted_fail__ref_leak();
+	if (test__start_subtest("refcounted_fail__global_subprog"))
+		refcounted_fail__global_subprog();
+}
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
new file mode 100644
index 000000000000..2c1326668b92
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
@@ -0,0 +1,67 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This is a test BPF program that uses struct_ops to access a referenced
+ * kptr argument. This is a test for the verifier to ensure that it
+ * 1) recongnizes the task as a referenced object (i.e., ref_obj_id > 0), and
+ * 2) the same reference can be acquired from multiple paths as long as it
+ *    has not been released.
+ *
+ * test_refcounted() is equivalent to the C code below. It is written in assembly
+ * to avoid reads from task (i.e., getting referenced kptrs to task) being merged
+ * into single path by the compiler.
+ *
+ * int test_refcounted(int dummy, struct task_struct *task)
+ * {
+ *         if (dummy % 2)
+ *                 bpf_task_release(task);
+ *         else
+ *                 bpf_task_release(task);
+ *         return 0;
+ * }
+ */
+SEC("struct_ops/test_refcounted")
+int test_refcounted(unsigned long long *ctx)
+{
+	asm volatile ("					\
+	/* r6 = dummy */				\
+	r6 = *(u64 *)(r1 + 0x0);			\
+	/* if (r6 & 0x1 != 0) */			\
+	r6 &= 0x1;					\
+	if r6 == 0 goto l0_%=;				\
+	/* r1 = task */					\
+	r1 = *(u64 *)(r1 + 0x8);			\
+	call %[bpf_task_release];			\
+	goto l1_%=;					\
+l0_%=:	/* r1 = task */					\
+	r1 = *(u64 *)(r1 + 0x8);			\
+	call %[bpf_task_release];			\
+l1_%=:	/* return 0 */					\
+"	:
+	: __imm(bpf_task_release)
+	: __clobber_all);
+	return 0;
+}
+
+/* BTF FUNC records are not generated for kfuncs referenced
+ * from inline assembly. These records are necessary for
+ * libbpf to link the program. The function below is a hack
+ * to ensure that BTF FUNC records are generated.
+ */
+void __btf_root(void)
+{
+	bpf_task_release(NULL);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_refcounted = {
+	.test_refcounted = (void *)test_refcounted,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
new file mode 100644
index 000000000000..c7e84e63b053
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
@@ -0,0 +1,32 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+__noinline int subprog_release(__u64 *ctx __arg_ctx)
+{
+	struct task_struct *task = (struct task_struct *)ctx[1];
+	int dummy = (int)ctx[0];
+
+	bpf_task_release(task);
+
+	return dummy + 1;
+}
+
+SEC("struct_ops/test_refcounted")
+int test_refcounted(unsigned long long *ctx)
+{
+	struct task_struct *task = (struct task_struct *)ctx[1];
+
+	bpf_task_release(task);
+
+	return subprog_release(ctx);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_refcounted = (void *)test_refcounted,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
new file mode 100644
index 000000000000..6e82859eb187
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
@@ -0,0 +1,17 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_refcounted")
+int BPF_PROG(test_refcounted, int dummy,
+	     struct task_struct *task)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_refcounted = (void *)test_refcounted,
+};
-- 
2.20.1


