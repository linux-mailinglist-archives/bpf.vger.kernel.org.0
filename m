Return-Path: <bpf+bounces-34780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A99930B10
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EB71F219D1
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840B13CF9E;
	Sun, 14 Jul 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzIBFpQv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B22E3E4;
	Sun, 14 Jul 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979495; cv=none; b=jPf2yYCq8QFx6Uwe8QzN4MM6gr7tCQnlrYHxdXbjp8YFg7z4Okw276FFrn9BMWSHNHqscLX0LqWW918lq+mWvnUqjWhqUz4NjpcMFBduY769XZAPDAD5GJG+4Vu8BUQohG/aflXaC1crCpWpxpfni0RW9jzW0tKBNte77vip2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979495; c=relaxed/simple;
	bh=rDwABeGlVqrKbor/mbg+ljxecU8TehoRDExiZ7tktmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVbamJ6yQNRxzWz2D5TWnzSgaY+8v6DixRTLKgyTzzIVVMfNCSmGnxXwr3fRGZ9MJV/SWoBedqreT9CjMWrHez1+ltuisGiMl5q1QZJhzvfCQYUSrjSbq9QKy9lPIpJ5Yudak4VeYVEz5rpfHpEocP9ae1dL4ul0rZcik9Squbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzIBFpQv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79f15e7c879so261888085a.1;
        Sun, 14 Jul 2024 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979492; x=1721584292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ndmJ9l7R0qUCRj64SeRs6YoNt8E4ydj+kVGLYd2HHU=;
        b=kzIBFpQvlvra8KKLRw/mL3NIF3Zmiley9lbzXldHOHFmQySb1gIqvEpEdNJ6RJh+V3
         ld/SOPoACLbEW4ogb6/NdXYDExWuRMAE0h41n1HafIKjq91dXjJn/SF+gCtvgf9lvtDe
         83XE8R2SDhv1YLT2hFCrdIFwF/s2PlFFT4FIUO7BcSIC/30Y8u7Chke5kZ3rMhtGohNa
         lnXmVycct/yAdAGIYNYUTTaZ15C66z15Ak2XhXnaXs/c2dCfB2vJnOPfdKEUeN+tcoAF
         B11jHpSQfU8iifxA5jDADxO9FVhvbXUVTnVHkBGFuisG58UJ90ZZd4oEoo7vQ4aGA6aX
         /v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979492; x=1721584292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ndmJ9l7R0qUCRj64SeRs6YoNt8E4ydj+kVGLYd2HHU=;
        b=IIgSyxyz6L3PonhKnmo25GUPSUxNPXn9cvaYh3Fd2vmfkb/hsQoyhmDbzyKdkCJvd6
         6Xr7v5X9zBV+MMzK+C8OzzjXla8JgPixiDN6Chd/CkcQgAUySyFYwkdi7hwceHbNLLca
         hSD73HkNNg1FFzEzrBViPzItVmnXqdpw6ihLGI2+mqii4pnjKNcxx00bJ06e5HDVSYYI
         2LZ0tqHFK0cqoz9Haf6bQNvm3fThwUGJfwd9FaowDV2E9f7I9aR0I8vTXp3PhJRSd9rt
         SE59ObVNLYkw13tezbrr/7xUVGXhT3qM/WqIo9pClVSES1Rk2KqO1m3iyAqZJy5IBAU1
         CIRw==
X-Gm-Message-State: AOJu0YzlnzUL1xml+JJxW7gjKqEcMy4MSXR5O06HDOOxjcTFUyOujErS
	rIJ1mOos1gNW4srEfBgN/HpdafVfFBP7U3/4ICyit6DiZBFbunht3dWiFQ==
X-Google-Smtp-Source: AGHT+IHAP7UrXe+aE/vFuoHa09yT7GscGF6LJfZYfXIs6E5UOKiIP6lGR2NKv+x4x7tQ3dQbYfqTcQ==
X-Received: by 2002:a05:620a:2a02:b0:79e:fb4f:f5fa with SMTP id af79cd13be357-79f19be636dmr2530264485a.49.1720979492571;
        Sun, 14 Jul 2024 10:51:32 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 02/11] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Sun, 14 Jul 2024 17:51:21 +0000
Message-Id: <20240714175130.4051012-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
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
multiple paths as long as it hasn't been released. In the fail case,
we confirm that a referenced kptr acquried through struct_ops argument,
just like the ones acquired via kfuncs, cannot leak.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
 .../prog_tests/test_struct_ops_refcounted.c   | 41 ++++++++++++
 .../bpf/progs/struct_ops_refcounted.c         | 67 +++++++++++++++++++
 .../struct_ops_refcounted_fail__ref_leak.c    | 17 +++++
 5 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index f8962a1dd397..316a4c3d3a88 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -916,10 +916,17 @@ static int bpf_testmod_ops__test_maybe_null(int dummy,
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
index 23fa1872ee67..bfef5f382d01 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,8 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	/* Used to test ref_acquired arguments. */
+	int (*test_refcounted)(int dummy, struct task_struct *task);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
new file mode 100644
index 000000000000..c463b46538d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
@@ -0,0 +1,41 @@
+#include <test_progs.h>
+
+#include "struct_ops_refcounted.skel.h"
+#include "struct_ops_refcounted_fail__ref_leak.skel.h"
+
+/* Test that the verifier accepts a program that acquires a referenced
+ * kptr and releases the reference
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
+ * kptr without releasing the reference
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
+void test_struct_ops_refcounted(void)
+{
+	if (test__start_subtest("refcounted"))
+		refcounted();
+	if (test__start_subtest("refcounted_fail__ref_leak"))
+		refcounted_fail__ref_leak();
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


