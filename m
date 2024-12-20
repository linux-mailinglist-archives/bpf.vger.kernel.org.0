Return-Path: <bpf+bounces-47472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4589F9ACB
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA5916677F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4915222571;
	Fri, 20 Dec 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRF2yFF0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EE225A5A;
	Fri, 20 Dec 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724595; cv=none; b=JP/H9CWjIfa5ND3NDFrNs5ggLygok1QG3i2G64Cb7mW7kv3YSCjyRWR/5TRQt2ySoXB0dNnH2vBLs/J211JXFNhVlSrrUoLo8/yKqzfS1a+zmXVtlWm+5wnqSC0EkueeBb/6QZWyB0w9lFwToSS1XABO84UvbvIHun7glsBPIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724595; c=relaxed/simple;
	bh=n5icmZkxkP3FtQtKKyziYzt+JyJhdO3osQV6HrLB17o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TS+UeAlrVCQ+/eG2UisCEkUcgnvo78KLY09AKx6o4o35DhqiMdka7yF7p3tWxGf8aaGSBm+6MoLDpucJey7ELykCaR5cnD66YXFRwb/GD/TC/eA/VA/dtPVfFo3B7Ex+vXx3l0jPnXNys94nlWpIjtwOr9D8mRrLEy8n86OvYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRF2yFF0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1805466b3a.1;
        Fri, 20 Dec 2024 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724592; x=1735329392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY5SYRjy7PKianvBBFp4ljQ5nK+6RTkJRG7kXPaZpVY=;
        b=fRF2yFF0q4IaU2eX+DyrhKmFab4WllPCdHIR9/9S1hQ6UkuOB4ut0w1a238fnuy0iv
         bnHIkZm0yFdYUkw7DjFM+w+8xHcCNUBeI0yZ9ae9yYsNeqEa0rZcIZVu7QJWWJ7sJ/ca
         t3exR7BaAfhw5/n58IYsAEL+mu3xKRwfsAfRvS6WJfcOQ/79YK//e9gf/lG+pMrKKemG
         cSC1IxTDUm18ape9FdqDCm8468fnY047w3lCZ0iWyCcCWh98unB/mxycBSAG6sublsjS
         31VZXgHWQjDwKcfJ1Ix4zAiUQoeJPbzkawcQBL2zkKDU0xMum8vhUrCMQCW8vczlUXwl
         ZLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724592; x=1735329392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY5SYRjy7PKianvBBFp4ljQ5nK+6RTkJRG7kXPaZpVY=;
        b=LO3oROxdhOkObPfubg+2dSIAN0XiRQxErfyQcF4Vz0EaJFIQgMAIgwGUPdZ7C31nKp
         zTCZfo3qKqriV2CI3HEu7oDaMZw1ugB5+yi3In2ONwIUZz0LLcp8dPnBoUgSo8JunNmh
         eG9IqvXDxGb/NFevjICCyPn9AiAJsF6ZAp9BImhTUVBM0flTB8EA7dCj4AouXixNK6cK
         /Rc5qkWQFsftF9B2vnrNUSfvh1PPJ2tuE/U3/VP1YPsEOergThinRr98eiTGQkaO8p1j
         gCrqYOd1KHxP1Oh/v1T7w8cqmtIsWgcE7OXtvfy+oegw1imTraawuE9RAvcYj36Ofww9
         F1Kg==
X-Gm-Message-State: AOJu0Yz9Vb5hjkG5AsKzq6pm83+WN9cDjZvS1EIvzTN6bPDIOpE8ofV2
	tlo5FFRi+B8mvoyeexIA+uFmA/t/bYFWEjjoXtvWG+J3kYa9yMUag4bkFQ==
X-Gm-Gg: ASbGncvO6DJpHJVdY6l1YAdQtSphQgr1NtxR2EBxviYHEh75IQh1HC19U7kxTDARIgD
	hVF1hoK9hSUWxK+Qf8DUCwex+UrlgQRzzEQLx2h+UPvWrWdfrN7ImOS/GU0OuThWKyETCj+dBlY
	Dq3NrtokNKyGLXYYJCA8B5/3JOBo5AhUwBYOi524z1KaIn4p45iGv3etOhRfJefA1zz3oYkOcRc
	4E8BX2m+0uLxI9/gKIj81gjUXNpKgQsyzNbHpL9REuyhgVy6eao/iaZNh0hk18tN2+EHM8HaRNe
	+BpLQdZBVSFkkTMvnr8IBzz3h94CEtbg
X-Google-Smtp-Source: AGHT+IE3aeY4WSqKHsR4EdxpsldksdQNPop3DR0ggg+53K9BinNxVUQPmeJegExa4dFYOb+aDM80kg==
X-Received: by 2002:a05:6a00:244c:b0:724:bf30:3030 with SMTP id d2e1a72fcca58-72abdbe59f6mr5098491b3a.0.1734724592478;
        Fri, 20 Dec 2024 11:56:32 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
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
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 04/14] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Fri, 20 Dec 2024 11:55:30 -0800
Message-ID: <20241220195619.2022866-5-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Test struct_ops programs returning referenced kptr. When the return type
of a struct_ops operator is pointer to struct, the verifier should
only allow programs that return a scalar NULL or a non-local kptr with the
correct type in its unmodified form.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../prog_tests/test_struct_ops_kptr_return.c  | 16 +++++++++
 .../bpf/progs/struct_ops_kptr_return.c        | 30 ++++++++++++++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 26 ++++++++++++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 34 +++++++++++++++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 25 ++++++++++++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 30 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  8 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  4 +++
 8 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
new file mode 100644
index 000000000000..467cc72a3588
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
@@ -0,0 +1,16 @@
+#include <test_progs.h>
+
+#include "struct_ops_kptr_return.skel.h"
+#include "struct_ops_kptr_return_fail__wrong_type.skel.h"
+#include "struct_ops_kptr_return_fail__invalid_scalar.skel.h"
+#include "struct_ops_kptr_return_fail__nonzero_offset.skel.h"
+#include "struct_ops_kptr_return_fail__local_kptr.skel.h"
+
+void test_struct_ops_kptr_return(void)
+{
+	RUN_TESTS(struct_ops_kptr_return);
+	RUN_TESTS(struct_ops_kptr_return_fail__wrong_type);
+	RUN_TESTS(struct_ops_kptr_return_fail__invalid_scalar);
+	RUN_TESTS(struct_ops_kptr_return_fail__nonzero_offset);
+	RUN_TESTS(struct_ops_kptr_return_fail__local_kptr);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
new file mode 100644
index 000000000000..36386b3c23a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
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
+struct task_struct *BPF_PROG(kptr_return, int dummy,
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
+	.test_return_ref_kptr = (void *)kptr_return,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
new file mode 100644
index 000000000000..caeea158ef69
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
@@ -0,0 +1,26 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
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
+__failure __msg("At program exit the register R0 has smin=1 smax=1 should have been in [0, 0]")
+struct task_struct *BPF_PROG(kptr_return_fail__invalid_scalar, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	bpf_task_release(task);
+	return (struct task_struct *)1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__invalid_scalar,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
new file mode 100644
index 000000000000..b8b4f05c3d7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
@@ -0,0 +1,34 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
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
+__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
+struct task_struct *BPF_PROG(kptr_return_fail__local_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *t;
+
+	bpf_task_release(task);
+
+	t = bpf_obj_new(typeof(*task));
+	if (!t)
+		return NULL;
+
+	return t;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__local_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
new file mode 100644
index 000000000000..7ddeb28c2329
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
@@ -0,0 +1,25 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
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
+__failure __msg("dereference of modified trusted_ptr_ ptr R0 off={{[0-9]+}} disallowed")
+struct task_struct *BPF_PROG(kptr_return_fail__nonzero_offset, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	return (struct task_struct *)&task->jobctl;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__nonzero_offset,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
new file mode 100644
index 000000000000..6a2dd5367802
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
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
+__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
+struct task_struct *BPF_PROG(kptr_return_fail__wrong_type, int dummy,
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
+	.test_return_ref_kptr = (void *)kptr_return_fail__wrong_type,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 802cbd871035..89dc502de9d4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1182,11 +1182,19 @@ static int bpf_testmod_ops__test_refcounted(int dummy,
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
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c57b2f9dab10..c9fab51f16e2 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct cgroup;
 
 struct bpf_testmod_test_read_ctx {
 	char *buf;
@@ -38,6 +39,9 @@ struct bpf_testmod_ops {
 	int (*unsupported_ops)(void);
 	/* Used to test ref_acquired arguments. */
 	int (*test_refcounted)(int dummy, struct task_struct *task);
+	/* Used to test returning referenced kptr. */
+	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
+						    struct cgroup *cgrp);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
-- 
2.47.0


