Return-Path: <bpf+bounces-51579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6AA36367
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425E01896F58
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7D26772E;
	Fri, 14 Feb 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3lmmVWr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3045267AEF
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551536; cv=none; b=L4CjQyQs6ogyjLk5AYAhW1B6qsBm7GYFbgf4ZYdjYmZ81Ej/bVdo1YsbmZnpx0T7lQj+VDD7yZoA5uD+Wxb9UEEs0FR0NxQSN4XwpVZHYd1PPKL34FCaBoqrt8oW/bd7hDOOIcj67VfJ2LsltO9iL1XniHUcFyhlQ0y1LYJK6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551536; c=relaxed/simple;
	bh=0CPds7L6bVfgfkSwoGmkmAs/hqh/qG7iMp0sGgwerYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7GKhvjEuALvp/6hFrWSXgh5/cx8Vs9s3WxR5XL34t+LIPhqhzEff3JBp2MJQQKiIym8gkfjq915to5v0biAPc74PHKrmKmraSIjIBWpCb5bLHBaEKKXZeyuNVGGTuSEKOWYh7dgMY021Z3P2qS3ywsqJe7efmy3rRGJa/pQLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3lmmVWr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e6028214so32950525ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551534; x=1740156334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEMmk+QJ7T9vF+Ze9uAr46CKRIACQEkQZAvqN5YNqmw=;
        b=m3lmmVWrYeMLiUVWcJOGiccRqe4uyWnJKrjoG5qqFcFAlSLlzYqEWApUtPWB0ad5sB
         sQkFOP6IZzxm0BIazVZFrSKjxc2+Eib81t/GVDvAo6FvMyKQWtaSVxgeWnsTcKltWQs0
         z3/flUuCqDt4oeiCYx/0Bmw03JqP4xjgFJ6TXV7582YGy5Amom/kMmAR/GupkABQ+BYn
         RpLxoaYzza9lQHaPJUhMbBrsuhmh7TCHmozLBF+nCkyYR/tAIPaCiTFwyQ1HTeJRGag/
         ih5gikQunWks0IZYbyDIJTya76v9MV0j9JBP8umK8gI1vKAyhsEreMe8xVkaaeoeRMIE
         hq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551534; x=1740156334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEMmk+QJ7T9vF+Ze9uAr46CKRIACQEkQZAvqN5YNqmw=;
        b=N6zVclOTnW9A7CV9tjMXRRAty05Z5hBq5A5Imuw6i0NELb2vrKqhZK6+9LrJzVeVy+
         R1CpXN9sb7Xhakysxxfy/fJ3xjLRrksk+u27nthLN7u3smju41+w1ON1tGtRoWMtbTHR
         2qgt4QLji7hHgCWxd37yDDiXGKTKmvE0SmbR/QhO+TKamE2qcnyooimJob8yXBlBjaTC
         uqwjsz4rJi5Zb/wBXKlFTQgS8UhOKdNHgiSA/Ztzvn2+pdihxyfHh86gKAbXPYzW+aIv
         weSE+MLPG9uIuSwpoB8v+wqQAEpN3uzYk0wYRIkM8f4R8CohnEo1QBCRPAbmxe/hApC/
         ZNCw==
X-Gm-Message-State: AOJu0YyrOYVWQ0yXf5C22RRaR/MXFGgYbpRyIvgZP/OCiQlAfuDqhkgK
	+Oku+Fn1aknjsMo+J+qiQktQcM+6g9vpRqG6G/2MMc6LXK1Vf2VFAte/Ew==
X-Gm-Gg: ASbGncvAtOd0xa5Cyt6iR9709n8OuvfSZRdieq9PJPUY4GMH04ew4lFMteUO6RRnypF
	fNq0c0cASA7TKoYYPMYHxlHKaXMlaNzuEVvON0mG6MRlanpZEjIy85JBUhqqJcnHsvfzjL5UPoo
	FvSMhOXNOMpp4X4OoV1Is1rL49/bdJcqBPM6NrTLzA7UkdVVGBn8ivSPJzxLcrKsX2IsNg0WT5B
	784phU0Reg29jqITQsd3RuBp2mUu4kyKyzd/0wpTmRf+sY+wPw9mHB129Hm6VG8Og0BDXGC4Ssw
	uLxg/sEoi8g6s7vB0sSWtTmoGJW3mBOrUvxcJPBJAKwqjkfZE9MmkJcr1RfHAiblJA==
X-Google-Smtp-Source: AGHT+IFIbc6PUK6Fke3Dxcz+ecX4ln+1dUz1osI2wOwLSybQwzFFFTQdjaQFMdfr/Ix8GS7t7dKztA==
X-Received: by 2002:a05:6a21:32a3:b0:1ed:a6d7:3c07 with SMTP id adf61e73a8af0-1ee8cb0e846mr222957637.4.1739551534160;
        Fri, 14 Feb 2025 08:45:34 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adbf21517eesm2223346a12.13.2025.02.14.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:45:33 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/5] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Fri, 14 Feb 2025 08:45:20 -0800
Message-ID: <20250214164520.1001211-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214164520.1001211-1-ameryhung@gmail.com>
References: <20250214164520.1001211-1-ameryhung@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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
2.47.1


