Return-Path: <bpf+bounces-51773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547CA38BF7
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 20:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EF116E633
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E9237164;
	Mon, 17 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnHmvrR1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D861236A73
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819216; cv=none; b=K9gYY7Ww5eqUaAm3z2GGx1WxQCagXbeZoZaxvHRW1bT78tFfNRktVqZe9jl9Ut0gQL4eY7fi8iJUof6benYChv3ZXGM5uOjwncwfAEMA7+cmUv+flIvcBKOAlu9ZlKSXdEP3fWj487wpQOGSEWWQBiaHXOj5oZ5zcCpZFl2iE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819216; c=relaxed/simple;
	bh=rXOOgzFu9YyT3Hefgiri6sQY9Mvs8rKjp898OP5AYVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBFqzIPT5y1B+kHIrDABCuae9O4f20Vf9dVc/UiArAzcCJphTN6uyXY/qBg4CW0e9ufGozC3S9u6QaPtHmEnhBQhHTTW1jvfq9n9qjy8nz91mM1x72uaaCZW9AMLvZzpeHA4yYtB06smvRPGJJx8OqMqOxHqrR2FSBJE/V82r1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnHmvrR1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so8741798a91.1
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819213; x=1740424013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt7Sop8OuwrqKYA8GB9ibLZjxogoBvmMTfVhMMkrAcA=;
        b=mnHmvrR1I3EeQyZDRHAKYTk33KgPVify2luapr/R/rSklxUtWBBcI/OUq/KMKQD239
         MTUBCNvD+aW5mTrWrmXFwFBl9Xq75M7bi7iYVri6Q9N4CVzWEEZvwZQzAlkNGrnb8PGg
         bzq8YrWPMcKqrdjDzw8bWuDWeUHf6N6SSFUnw8TyeTagfMcQYQgYPyoc4ZhtpJcNirX7
         Uoqp4TYi4x6rzFlOW522cvBjbbcAM6vkhBi2XzEQ7ACLH/c3PtpiuIOUfoSC4Rui/dVn
         w0YpRTFiq22ZyWsLQ8rxpx0VzIFY00edkNR+MXQzuQevJVUuuJ4mGlUUS49MaLuTwuuq
         2+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819213; x=1740424013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt7Sop8OuwrqKYA8GB9ibLZjxogoBvmMTfVhMMkrAcA=;
        b=OUtLJvSNn6LLXQ7wJIsmCK2qkTSjbYKgyxuKMJjUI485KjoBDH/XC3JmEK0aXEUtXs
         ZLzEk44bAQ5O5Q16XNKkuhDFbBpvEi/dkPgNqUrm+JeiGmIhf4xpl1vxp+nqRtYedtw/
         OR3BAffnlPKqnCNHjumLUb1NtJdsiOucn6Gm4C9+Z91EazXIQfjdKmD/fTY8VY/9aADz
         4M1wm4kMXaammJfLthnOPSb/vBfN5OHf+xanNyt6n+cMITf+6yYOhH80bZE/BV5filRU
         SW4KwKT5OQVa5VW7KtYx0laDU7a2OeES53iJbbnGHkg8uzc6ElLPCNeqS+47eGbrjZq4
         rXeA==
X-Gm-Message-State: AOJu0Yw8uiPWh9aSwP0RgUhAs2RvQtO51+47BaMPHfp2o6WEV5BAT4pz
	sCuIyJVttiHsdfjnEc/OzDkIEEUJNnxeuMcxUIXro2r9fsKJo/yNwQOdLw==
X-Gm-Gg: ASbGncvHFEpmAvqq5/eJ1VI3fwcpkTVgrKhUEa7oElGDa+bBkXJ0MddZn5lCspLYSgA
	PrZaW+kGJ0+p8btHklDdESjI0QvBBjtVncvQgwRIkju5n9dKnzyGJWu5zEkgsxeFH87/IdxqTYY
	6IY9rcu9kQyLecS6TXQn42TDF9I7ztRHvLHaaf2gcTLuyceyMCaetmg1M3lXJBeP5/Y4WTVyU7L
	SvEqSpxQWTiULv5r+K46r1bcgdTiKqeIWeqLmZOhPuswV7Y2MZsa4Ocbet6sotCc55/aWoGBbkW
	ta27oHTngHlRxoy/NhAuTjiSvBdV1avdzbgmso25XIWt0CPJGm07nbE+/QFMi4IfXQ==
X-Google-Smtp-Source: AGHT+IF1YqF7mwTp7By7tWcmicxvDecAQHFHlJFdNw7HtdXt6ot1r5Xl7b36Ngaqnnae4GpJ84yAJA==
X-Received: by 2002:a05:6a00:4fd6:b0:731:e974:f9c2 with SMTP id d2e1a72fcca58-7326144ab2fmr20570203b3a.0.1739819213422;
        Mon, 17 Feb 2025 11:06:53 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265f98e18sm5039118b3a.106.2025.02.17.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:06:53 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Mon, 17 Feb 2025 11:06:38 -0800
Message-ID: <20250217190640.1748177-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217190640.1748177-1-ameryhung@gmail.com>
References: <20250217190640.1748177-1-ameryhung@gmail.com>
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
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
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


