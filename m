Return-Path: <bpf+bounces-29521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E068C2A79
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB6B21759
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0C4CE09;
	Fri, 10 May 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS+6vjLl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3D175A6;
	Fri, 10 May 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369057; cv=none; b=D9Xo++vnOcYo+EpJU6nMiVUaPXhaV9tSov05Zd/Spl38H2L4yzuqBQ+z6k8Onr4EiJ/V3PtuD+okmec3ctmqWdoRuS9b0Tlli7ly9dMneh3T2i1wOdTCTC9x63CysTBm6h1O70p1IQFFtPL/jZvGyqWetVgGENfxIzlIHyaoevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369057; c=relaxed/simple;
	bh=nq/5uzUIqCMQh9wr42wW2/1TiuLcNo+khEi8EO26S0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrmsqbsQyKnUQ7rM/8XYy8nOlDQPZkxuI2Aj6djpmhSP7imNNxzgCA4EnzB5eiWuvN+J2ItSoxfYSp1sWHknKBOl2hXOH21c2DIZ4FlCZpeQpcISqg7P0b+wkDiy0eu+1apBwcF3ushUEDfreQ5PHyWiOnvM4xnhLAjwMkTTbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS+6vjLl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43e06d21a06so3389451cf.3;
        Fri, 10 May 2024 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369054; x=1715973854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5YJln67TCREziDO9SweZeJHQaPK0JaGLKJWTfi8+Uw=;
        b=JS+6vjLl/S7brC33p74BLwU9gAssidd9ZZAuGByk3GdjY7YsV0QTxT51wM7kUFGEO2
         QACcGL/ycTOsjJhjUPi9M/Bo0ofZErX3gtGQb858Vy+8C5alh5L5Cz/gkcUDS/bHacfk
         yC2nEd3FUoz+jmx766jL49D8ELBwn7or5lKZM96xmMOt3MHwz4rVNi9BoyJZCmgOq2xF
         4rKnORAvyT94nzCeFARoE3gEEnvYx0PivAUIwGAr+r0RmgRvuHVB+0UCCsP3+W+NGlFf
         4WCWRNWx0wm/JwbXjHqKMvXHWqFZnqeXXc7kDhLvVRT7GaVzpBWv7IdD5wqSCe4sUKyb
         eJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369054; x=1715973854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5YJln67TCREziDO9SweZeJHQaPK0JaGLKJWTfi8+Uw=;
        b=MGvkFR8iG/04Nfq9Z7aRkERGdjzH/bszdqVUnkyihBca2HKIEMTNceDjOeEfJcl2Hb
         jUO2dZ6Xg5jeuGxNKEY8tvc2ZwdAgIzSbRGZGMkdj1/wtBI/HhID2peoqGUI9wsj1S8R
         UEqrv6CJgqr+rSFsWseoOQZvnCRz7QPylaaTyidjBHm8NM8hNE6CYZSZRGc5yjzYYXm1
         UBGZRe6NihGG5U3JTJsURk1A4GNnLPYDeTpBvd/1bhQfvTT/H/RJtntm+3kC+8qK1cDe
         rjimLpMJOW2PrRZB4pXmOUTeQjmKnMtpz92G4sOxyFvDG4lYhHg74cxfKh/HEYFYJdb9
         NozA==
X-Gm-Message-State: AOJu0YxMhKBrfClJiJXucHD9rjaeLNMSSmRSeiAnJZCt3iaGUL6jPKKh
	/fZL41uhu/2n9griEIe1CO/FUrfg4aL4u6nO6EmtLtPekah5xHSYDdVfMA==
X-Google-Smtp-Source: AGHT+IHUeBUPOnJem25O0whoxu9a+QzTReLiUSrMMikCo2/mA8RGqzVM/VGGYWjviSLmcGfRyqH50Q==
X-Received: by 2002:a05:622a:1a88:b0:43d:ebab:d4dd with SMTP id d75a77b69052e-43dfd9a9294mr39286661cf.0.1715369054695;
        Fri, 10 May 2024 12:24:14 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Fri, 10 May 2024 19:23:54 +0000
Message-Id: <20240510192412.3297104-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A reference is automatically acquired for a referenced kptr argument
annotated via the stub function with "__ref_acquired" in a struct_ops
program. It must be released and cannot be acquired more than once.

The test first checks whether a reference to the correct type is acquired
in "ref_acquire". Then, we check if the verifier correctly rejects the
program that fails to release the reference (i.e., reference leak) in
"ref_acquire_ref_leak". Finally, we check if the reference can be only
acquired once through the argument in "ref_acquire_dup_ref".

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
 .../prog_tests/test_struct_ops_ref_acquire.c  | 58 +++++++++++++++++++
 .../bpf/progs/struct_ops_ref_acquire.c        | 27 +++++++++
 .../progs/struct_ops_ref_acquire_dup_ref.c    | 24 ++++++++
 .../progs/struct_ops_ref_acquire_ref_leak.c   | 19 ++++++
 6 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_dup_ref.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_ref_leak.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123..64dcab25b539 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -594,10 +594,17 @@ static int bpf_testmod_ops__test_maybe_null(int dummy,
 	return 0;
 }
 
+static int bpf_testmod_ops__test_ref_acquire(int dummy,
+					     struct task_struct *task__ref_acquired)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
+	.test_ref_acquire = bpf_testmod_ops__test_ref_acquire,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 23fa1872ee67..a0233990fb0e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,8 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	/* Used to test ref_acquired arguments. */
+	int (*test_ref_acquire)(int dummy, struct task_struct *task);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref_acquire.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref_acquire.c
new file mode 100644
index 000000000000..779287a00ed8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref_acquire.c
@@ -0,0 +1,58 @@
+#include <test_progs.h>
+
+#include "struct_ops_ref_acquire.skel.h"
+#include "struct_ops_ref_acquire_ref_leak.skel.h"
+#include "struct_ops_ref_acquire_dup_ref.skel.h"
+
+/* Test that the verifier accepts a program that acquires a referenced
+ * kptr and releases the reference
+ */
+static void ref_acquire(void)
+{
+	struct struct_ops_ref_acquire *skel;
+
+	skel = struct_ops_ref_acquire__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_ref_acquire__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that acquires a referenced
+ * kptr without releasing the reference
+ */
+static void ref_acquire_ref_leak(void)
+{
+	struct struct_ops_ref_acquire_ref_leak *skel;
+
+	skel = struct_ops_ref_acquire_ref_leak__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+
+	struct_ops_ref_acquire_ref_leak__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that tries to acquire a
+ * referenced twice
+ */
+static void ref_acquire_dup_ref(void)
+{
+	struct struct_ops_ref_acquire_dup_ref *skel;
+
+	skel = struct_ops_ref_acquire_dup_ref__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+
+	struct_ops_ref_acquire_dup_ref__destroy(skel);
+}
+
+void test_struct_ops_ref_acquire(void)
+{
+	if (test__start_subtest("ref_acquire"))
+		ref_acquire();
+	if (test__start_subtest("ref_acquire_ref_leak"))
+		ref_acquire_ref_leak();
+	if (test__start_subtest("ref_acquire_dup_ref"))
+		ref_acquire_dup_ref();
+}
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
new file mode 100644
index 000000000000..bae342db0fdb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire.c
@@ -0,0 +1,27 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This is a test BPF program that uses struct_ops to access a referenced
+ * kptr argument. This is a test for the verifier to ensure that it recongnizes
+ * the task as a referenced object (i.e., ref_obj_id > 0).
+ */
+SEC("struct_ops/test_ref_acquire")
+int BPF_PROG(test_ref_acquire, int dummy,
+	     struct task_struct *task)
+{
+	bpf_task_release(task);
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_ref_acquire = (void *)test_ref_acquire,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_dup_ref.c b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_dup_ref.c
new file mode 100644
index 000000000000..489db98a47fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_dup_ref.c
@@ -0,0 +1,24 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+
+SEC("struct_ops/test_ref_acquire")
+int BPF_PROG(test_ref_acquire, int dummy,
+	     struct task_struct *task)
+{
+	bpf_task_release(task);
+	bpf_task_release(task);
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_ref_acquire = (void *)test_ref_acquire,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_ref_leak.c
new file mode 100644
index 000000000000..c5b9a1d748a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_ref_acquire_ref_leak.c
@@ -0,0 +1,19 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_ref_acquire")
+int BPF_PROG(test_ref_acquire, int dummy,
+	     struct task_struct *task)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_ref_acquire = (void *)test_ref_acquire,
+};
+
+
-- 
2.20.1


