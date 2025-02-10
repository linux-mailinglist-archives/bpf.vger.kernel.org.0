Return-Path: <bpf+bounces-51010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393EAA2F585
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D743A592B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E32566F3;
	Mon, 10 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7+nG4su"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB92566C0;
	Mon, 10 Feb 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209432; cv=none; b=hMdAIp8u3TeSR+AR5xEXexPXtyWfHj/LMSxX6hXSWZpIcyPEvOMnCiMYiUlxA9tYMhgSYYs8KAzz7vkbNII1i+00UZF+JKxPFmuABuPfpu9AHUyURgP9xMIytDBUW15wG/owXDDCehdvmO/Cs2cjmkaGGOP9PwanCFQ0AxYgBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209432; c=relaxed/simple;
	bh=cu4b3Vbm9gFq/EkCNcqo0m8n8rFskmSadxY4u/enMps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKuJ30pag7tu07ajIHkC9tUgQAE3RauYhxPwJN6Jv+tFtgI8OH8CMzo/iN9FOqDm4I8gmXvQmEhmahJCn1UeoJ8pIwn/+WMlk8qaKiihEYLaoOahmO5DWIfflpHha3h9f482kNosk5DIywM/HTVlR+bCA5oYnIvEd7xeasKZRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7+nG4su; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f441791e40so6426644a91.3;
        Mon, 10 Feb 2025 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209430; x=1739814230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB3GDDoQAzmyBzIZYs9Df0cqC8v4dqCoGTbbm/k4J8w=;
        b=j7+nG4su0VK19Wr1+jFpdry8LLiFxh7mGddIekNzE19V605isUMlCF1VuzBdYREpMT
         hyKbRHR5HhSwstf6Pj+7CcpK3unZTazipEnbYGmI5v6R93TKw9EaVtIzNxtZSH/3qwCm
         KS1cMTtNfY2nk8e0sCQj4Oh5F+HyaJTpUUUhtD0EVNSaUCLjYRz800yTWGFOfBXI7Lzm
         1S5A5sW3e6p2IgKsL4VE08NZ/KTcJbl9OlowlhyBkM/xJp46FcctJaOl0RRxZP7NTGLv
         n1DwR/ZVYLtJfva5ImRAYlB24gcY3jb0YovU6SB1+DtsbECaV1BdCHM4w/zYNHOsIez0
         UIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209430; x=1739814230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB3GDDoQAzmyBzIZYs9Df0cqC8v4dqCoGTbbm/k4J8w=;
        b=hX3mO/iuqdV5Gl+EpNMqlbQ/fogSQHOnhT3515JCWKxN1qS+BsAMra1Yj/Tgbh9Pg+
         GNK5+ecXP3H2b0XQL29azHFPCnbNJF6+bKhYzyZff5v3YyKAjif68hTlWUB7rTOE3ycP
         b2fOqwQrMFl74/EcncKgX9UzHiTdRPJKPja3t+ASq+IPzn6+ngnzbUmf8FQXp+Frk1Pz
         nj/yAnZaBQxyN0VFTjKhC2bnzje38NgfLN+R5a951AazJoC9rF8vwrtufcjoQVpQICin
         hztaFG0pPN4xhFYvnCTm074Q2R+fkb13v23OWO7TWh4Xy3n4/vVKSCzLCY0vzdgrNL00
         w9EQ==
X-Gm-Message-State: AOJu0YyxGNF/4B7OxhWWVRkICty/Xh093dwvN/JHjrJZdQLHoKWjL62j
	pjcB3C27Iw+eyS3fI2RxShHBM9lw13kgGwsdP5gW1P9Hd44ox3Hj/KSjwPDG
X-Gm-Gg: ASbGncshakjE/7iE/MuBuzbT5XUi/MzZoBi9fLGpG3Z9yY4dsxnBoXgEsBcErrhVBt5
	Vxz5hSUaFL4lqamqziq8od7h54w97oyKcIyZPyl1L88UAms65Q6VBc9PL4lc7W1Qo3+Qcb5o8r/
	PNpxiSb4Du5cSoTBf+fKlvK8OiZrNM88uF+fC3U8/1eRpNjs68MNtlBYhrLNRyMTjCwpYKnk1wk
	vTvDCB16aBMd5qcQdUabLrtj+Hk51tBklu37uWBeNXg4K6PBbkT6jgsiv9P2hH6oaYFyLlW+aYl
	zz7XmEQhx/y8YROu2vHYWzXMhNn1ZYlhlV0EHLSJCsq6k8uwkkARt5rV/VwJ8pBaJw==
X-Google-Smtp-Source: AGHT+IGXVDAdZN1h/noU242b6kA5t3VYz10TPTNjP9NCttGL/LahHRNlFcfAewGlG13Bn25yZanGEw==
X-Received: by 2002:a17:90b:2c86:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2fa243e10ccmr18748095a91.22.1739209429736;
        Mon, 10 Feb 2025 09:43:49 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:49 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/19] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Mon, 10 Feb 2025 09:43:17 -0800
Message-ID: <20250210174336.2024258-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Test referenced kptr acquired through struct_ops argument tagged with
"__ref". The success case checks whether 1) a reference to the correct
type is acquired, and 2) the referenced kptr argument can be accessed in
multiple paths as long as it hasn't been released. In the fail cases,
we first confirm that a referenced kptr acquried through a struct_ops
argument is not allowed to be leaked. Then, we make sure this new
referenced kptr acquiring mechanism does not accidentally allow referenced
kptrs to flow into global subprograms through their arguments.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../prog_tests/test_struct_ops_refcounted.c   | 12 ++++++
 .../bpf/progs/struct_ops_refcounted.c         | 31 +++++++++++++++
 ...ruct_ops_refcounted_fail__global_subprog.c | 39 +++++++++++++++++++
 .../struct_ops_refcounted_fail__ref_leak.c    | 22 +++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  2 +
 6 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
new file mode 100644
index 000000000000..e290a2f6db95
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
@@ -0,0 +1,12 @@
+#include <test_progs.h>
+
+#include "struct_ops_refcounted.skel.h"
+#include "struct_ops_refcounted_fail__ref_leak.skel.h"
+#include "struct_ops_refcounted_fail__global_subprog.skel.h"
+
+void test_struct_ops_refcounted(void)
+{
+	RUN_TESTS(struct_ops_refcounted);
+	RUN_TESTS(struct_ops_refcounted_fail__ref_leak);
+	RUN_TESTS(struct_ops_refcounted_fail__global_subprog);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
new file mode 100644
index 000000000000..76dcb6089d7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
@@ -0,0 +1,31 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__attribute__((nomerge)) extern void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This is a test BPF program that uses struct_ops to access a referenced
+ * kptr argument. This is a test for the verifier to ensure that it
+ * 1) recongnizes the task as a referenced object (i.e., ref_obj_id > 0), and
+ * 2) the same reference can be acquired from multiple paths as long as it
+ *    has not been released.
+ */
+SEC("struct_ops/test_refcounted")
+int BPF_PROG(refcounted, int dummy, struct task_struct *task)
+{
+	if (dummy == 1)
+		bpf_task_release(task);
+	else
+		bpf_task_release(task);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_refcounted = {
+	.test_refcounted = (void *)refcounted,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
new file mode 100644
index 000000000000..ae074aa62852
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
@@ -0,0 +1,39 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
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
+/* Test that the verifier rejects a program that contains a global
+ * subprogram with referenced kptr arguments
+ */
+SEC("struct_ops/test_refcounted")
+__failure __log_level(2)
+__msg("Validating subprog_release() func#1...")
+__msg("invalid bpf_context access off=8. Reference may already be released")
+int refcounted_fail__global_subprog(unsigned long long *ctx)
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
+	.test_refcounted = (void *)refcounted_fail__global_subprog,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
new file mode 100644
index 000000000000..e945b1a04294
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
@@ -0,0 +1,22 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Test that the verifier rejects a program that acquires a referenced
+ * kptr through context without releasing the reference
+ */
+SEC("struct_ops/test_refcounted")
+__failure __msg("Unreleased reference id=1 alloc_insn=0")
+int BPF_PROG(refcounted_fail__ref_leak, int dummy,
+	     struct task_struct *task)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_refcounted = (void *)refcounted_fail__ref_leak,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index cc9dde507aba..802cbd871035 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1176,10 +1176,17 @@ static int bpf_testmod_ops__test_maybe_null(int dummy,
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
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 356803d1c10e..c57b2f9dab10 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -36,6 +36,8 @@ struct bpf_testmod_ops {
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
 	int (*unsupported_ops)(void);
+	/* Used to test ref_acquired arguments. */
+	int (*test_refcounted)(int dummy, struct task_struct *task);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
-- 
2.47.1


