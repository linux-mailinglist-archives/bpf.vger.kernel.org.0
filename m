Return-Path: <bpf+bounces-34782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFFD930B14
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DA3281277
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11813DB88;
	Sun, 14 Jul 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG3pESic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9013C8E8;
	Sun, 14 Jul 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979497; cv=none; b=VR/ooQI1g+hCsDqg4v1nhmnljUUea6TSeEyYdOivc5VVzpB8nkyI3Q3UFpZxbUfrOkhy2hpRue2d3ETygZo1PQUpIfzNyLQftXyqS1S0hK0ZpR2+YqKZydWk6YlA1J9+YsYgkIqc7J48IXI1GAIZiO3b3CsaVewS15olz7iZQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979497; c=relaxed/simple;
	bh=SV59NoCDZEsIWoEZ8m1wiLRmxwg4eOSsNAwhBb54M7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uv0kMHX40hgq5wWGgQ9D3cqqE2gQJ58ypquB6ZzyGEEeXF5rwUrxSDhqsYvuH5inbDMIpEa/ML/hcB/MwlafxgiDN7DCHXYA4y7s+ik6GyE0143F9kFEeyYyqNxOpoLBH5DB8kHGVIvgZVXXPIaYRZHNLQMb3dpeNhisbkVDrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG3pESic; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447d97f98d3so19562081cf.2;
        Sun, 14 Jul 2024 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979494; x=1721584294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtImcwPeg2GxCBruL+KDWulfN186/oe5ccglZIuiGmQ=;
        b=UG3pESics827TxdSh6HEhEoEeToSmCb3kA3P0oOvJTJpZ7wp+b+IVT7oUYwTyL6y2J
         3vHT6HuzPYIPfrUA/NKGVGG1UoYFXgNccD7ECe0AJJHPXmcK6J6q5Mdxi+XPCAxyfg7q
         9SSw/rIkNnRInt1Uf17Y4VcxNRL0LkZfQ/xx7bQGvSOuyZdlPe5VV9J9tPnaJQTQm79V
         ThCEToLMPN6J0KMu/yE19Xl04Cpyz89Qg2Ysj5i/sqoD1L3aVRP31uUtTFM2u7P40rG/
         bjdcQ2JlqfKawB/i7HQWlW+UJPy/whBKfGEZ9e1d/s5au3aTDxwgAgZqE+42J1B420Nx
         Hcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979494; x=1721584294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtImcwPeg2GxCBruL+KDWulfN186/oe5ccglZIuiGmQ=;
        b=uYCEwt34QyrhRkim/coKviOtSmf3dsp1seYnLhvK5HWtqQO9rZKPuSl/CjKd1Yb4pt
         BJOt+efO6VZeEtoqMqFwwHenhtzpGzSzc0wf/01xDLB/ikfnrau79Saaurtaq6Chede4
         fBNYb238NqKv0F3qgqFLeq/nQ387NhwNaSTb+S2EesdXSJM8QNNstBnAtWQs+V4j2IPu
         9J1jwTj3T4iv8+oBlH2nIxP7rh0c/LH+1hIRhsVoHaQP4LviU9QdY055K01h4CnLRWXc
         S1W6wQXZByKa0nSpce7E8I67I/rs6HdNQNr9OeWbequks7nmNDR1DEpWeqkza598tnhv
         xr3A==
X-Gm-Message-State: AOJu0YzQ68nK43UZfU78AIWiy9pu1oPrMIT+rsc5l4uyjjULZWERhrVl
	xMg6s/26Ih5N4u5yIPVxDY5dzTR/yW8d5ylFn6GZVrrNJj9WI1CIPSaO7g==
X-Google-Smtp-Source: AGHT+IHlHI1THSfFh2F1K9EqvKpO8OA2UwpG5hWJuPi4BFcCR0tJl5Y+MnR2fnrM9nw+Nqbu4aqT5w==
X-Received: by 2002:a05:622a:15d3:b0:447:e51b:60c0 with SMTP id d75a77b69052e-447fa825dd8mr219483131cf.12.1720979493953;
        Sun, 14 Jul 2024 10:51:33 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:33 -0700 (PDT)
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
Subject: [RFC PATCH v9 04/11] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Sun, 14 Jul 2024 17:51:23 +0000
Message-Id: <20240714175130.4051012-5-amery.hung@bytedance.com>
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

Test struct_ops programs returning referenced kptr. When the return type
of a struct_ops operator is pointer to struct, the verifier should
only allow programs that return a scalar NULL or a non-local kptr with the
correct type in its unmodified form.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +
 .../prog_tests/test_struct_ops_kptr_return.c  | 87 +++++++++++++++++++
 .../bpf/progs/struct_ops_kptr_return.c        | 29 +++++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 24 +++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 30 +++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 23 +++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 28 ++++++
 8 files changed, 233 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 316a4c3d3a88..c90bb3a5e86a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -922,11 +922,19 @@ static int bpf_testmod_ops__test_refcounted(int dummy,
 	return 0;
 }
 
+static struct task_struct *
+bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
+				      struct cgroup *cgrp)
+{
+	return NULL;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
+	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index bfef5f382d01..2289ecd38401 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct cgroup;
 
 struct bpf_testmod_test_read_ctx {
 	char *buf;
@@ -37,6 +38,9 @@ struct bpf_testmod_ops {
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
 	/* Used to test ref_acquired arguments. */
 	int (*test_refcounted)(int dummy, struct task_struct *task);
+	/* Used to test returning referenced kptr. */
+	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
+						    struct cgroup *cgrp);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
new file mode 100644
index 000000000000..bc2fac39215a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
@@ -0,0 +1,87 @@
+#include <test_progs.h>
+
+#include "struct_ops_kptr_return.skel.h"
+#include "struct_ops_kptr_return_fail__wrong_type.skel.h"
+#include "struct_ops_kptr_return_fail__invalid_scalar.skel.h"
+#include "struct_ops_kptr_return_fail__nonzero_offset.skel.h"
+#include "struct_ops_kptr_return_fail__local_kptr.skel.h"
+
+/* Test that the verifier accepts a program that acquires a referenced
+ * kptr and releases the reference through return
+ */
+static void kptr_return(void)
+{
+	struct struct_ops_kptr_return *skel;
+
+	skel = struct_ops_kptr_return__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_kptr_return__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns a kptr of the
+ * wrong type
+ */
+static void kptr_return_fail__wrong_type(void)
+{
+	struct struct_ops_kptr_return_fail__wrong_type *skel;
+
+	skel = struct_ops_kptr_return_fail__wrong_type__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__wrong_type__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__wrong_type__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns a non-null scalar */
+static void kptr_return_fail__invalid_scalar(void)
+{
+	struct struct_ops_kptr_return_fail__invalid_scalar *skel;
+
+	skel = struct_ops_kptr_return_fail__invalid_scalar__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__invalid_scalar__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__invalid_scalar__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns kptr with non-zero offset */
+static void kptr_return_fail__nonzero_offset(void)
+{
+	struct struct_ops_kptr_return_fail__nonzero_offset *skel;
+
+	skel = struct_ops_kptr_return_fail__nonzero_offset__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__nonzero_offset__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__nonzero_offset__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns local kptr */
+static void kptr_return_fail__local_kptr(void)
+{
+	struct struct_ops_kptr_return_fail__local_kptr *skel;
+
+	skel = struct_ops_kptr_return_fail__local_kptr__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__local_kptr__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__local_kptr__destroy(skel);
+}
+
+void test_struct_ops_kptr_return(void)
+{
+	if (test__start_subtest("kptr_return"))
+		kptr_return();
+	if (test__start_subtest("kptr_return_fail__wrong_type"))
+		kptr_return_fail__wrong_type();
+	if (test__start_subtest("kptr_return_fail__invalid_scalar"))
+		kptr_return_fail__invalid_scalar();
+	if (test__start_subtest("kptr_return_fail__nonzero_offset"))
+		kptr_return_fail__nonzero_offset();
+	if (test__start_subtest("kptr_return_fail__local_kptr"))
+		kptr_return_fail__local_kptr();
+}
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
new file mode 100644
index 000000000000..29b7719cd4c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
@@ -0,0 +1,29 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * allow a referenced kptr or a NULL pointer to be returned. A referenced kptr to task
+ * here is acquried automatically as the task argument is tagged with "__ref".
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	if (dummy % 2) {
+		bpf_task_release(task);
+		return NULL;
+	}
+	return task;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
new file mode 100644
index 000000000000..d67982ba8224
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
@@ -0,0 +1,24 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a non-zero scalar value.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	bpf_task_release(task);
+	return (struct task_struct *)1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
new file mode 100644
index 000000000000..9a4247432539
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a local kptr.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *t;
+
+	t = bpf_obj_new(typeof(*task));
+	if (!t)
+		return task;
+
+	return t;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
new file mode 100644
index 000000000000..5bb0b4029d11
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
@@ -0,0 +1,23 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a modified referenced kptr.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	return (struct task_struct *)&task->jobctl;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
new file mode 100644
index 000000000000..32365cb7af49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
@@ -0,0 +1,28 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a referenced kptr of the wrong type.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *ret;
+
+	ret = (struct task_struct *)bpf_cgroup_acquire(cgrp);
+	bpf_task_release(task);
+
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
-- 
2.20.1


