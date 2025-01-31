Return-Path: <bpf+bounces-50224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E27A24345
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EF716423F
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128F1F3D41;
	Fri, 31 Jan 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwDurmWP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDA1F2C5D;
	Fri, 31 Jan 2025 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351767; cv=none; b=VRCDk36VbqPhmbXwHAuU35J5hYKyhc7Y3XskNDPHd3lol1YB2Ad95AoNaiXtucjmjs/BuVlw1IjZ+t2CYOnBsU1mZczPFbr+xcE3r/JRBhT0QTf6/BIy/sucs9OZpEXkQmt537q6uNiVAWMp5cxIW0uVvWNnHT6MPRZk1WmUnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351767; c=relaxed/simple;
	bh=Eii9FQ+DTTqmpz923cWf0JM70bcV8nIl9miv2RT2emk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLAXgnbFW5PQaDfckF5uybdegvnuuSiXah46YmOZFXbr+tBf1mM4M4tUW22+rvHCaOGlGeWV9P8evkSp3DhoR9cZ/JIstHy5ZnfW8Qm6fFV097HK0r5LnftfEKbgh7eNalc01iPqwXlJ+z84Kv8Z+fI4i1bpBgltaA4grIwTYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwDurmWP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee74291415so3173811a91.3;
        Fri, 31 Jan 2025 11:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351765; x=1738956565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK5ysT2yUWJFdfhYa20N6Qw0GVTqj3D7iUCa6tFcono=;
        b=QwDurmWPlKBRkR1d7IugwO1Wsuf55U64idAabUQlP0troTlO/SOs87XW4lBk7C8tL5
         JGq3d2ZavZ6CzEsnfzs7MujKoeNSS23D7s9mWPY0BXuTtNQNrEF+ppfRLVOso/uAdbGL
         EQ/VdRIoej4t8rm6zg8+6/hT8Hde4K54060mfRkddSurToKOZWdiKulNIEvnqNPIsGIi
         QkoZ1/VrJvwx0mVQFBjerynRvLTcS9bG3d9e+f72z8o5GNweJVRWW158WuNA6waAS4ZA
         oEGtyBpl3i/Cn2E1uIPSAprSa6TEK4Abx3/I3F+967daUhlYAByGb0/27zgEMhl/a1Nf
         d9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351765; x=1738956565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK5ysT2yUWJFdfhYa20N6Qw0GVTqj3D7iUCa6tFcono=;
        b=qYaqAnvJkurXqhluqXtUixbFqEv3l/QSPkQ0MOvO+H73qaI/vRfdiCeTU0fbFUarQW
         EqE2k7Pf7Oq4CyqAL7VczhSgQ/aWPJiv+PSWL4M0pmexKuJo6qqRhFajT/42+YOA+44W
         4GVLo3BLu/IVcshZ83H/ldGpSLuuK3Wb3T+zDpWTas5MyUc1zTkYS+aolUJ0bRfqPaF0
         6WwlNksoREBhBAJvnOo5m6GcwzY2C0ltBOyRI3y4pECPkm6g5B0JSqaTFT27IjsxsiaZ
         BkQ+mdzSrKKBM5QcWYJJylcYBJGi/Y+fqu54OI6KgGXsSwjcu2vt9W3HZCCU7WnVfekF
         6NXQ==
X-Gm-Message-State: AOJu0YwNY8qwp5zj/QaIBvyd8Af4NzFa8j/xqkVcfJ3Q1xg/axLf9tYR
	Yv5mRCU5uVXzLwjg+oFho0iZ7iF98h8Hqa3oZFhkB23UTl53AMgapSIr7qagMKc=
X-Gm-Gg: ASbGnctNTwSCw6Ks56Q7y/t01cwR6Slwg7HiNKK9mJb9efOHEnblwKjZnA7bimGxLyh
	Y+Tky/qVJxIVFzqVknK23XdspgUtA9rQbcFSz7oAK0H+KHw/4EspiacuJbwNePSiMoezmS9/Fz0
	3QzXLzmbVEBGZ1O9VKjFAtnid+jpnyFS9+uUMkCnzj0dcrjx1m99xJOmHMY9Q7JyUIGvHSwXOy1
	vjkw3AMn2nnT2rdqZsbKulngigl9SVtGPgP3etTes1I1dGhv/85NpmV+4YLDM8J1sQkiSxgfUHP
	mUB/RGIhktEtwunG4mIVZIT70JkQoMCSHqo7Kuqrxo8mbtyJk45iNNnEYAVoSrM/cw==
X-Google-Smtp-Source: AGHT+IEEXHWLmOhh13FwPFBLHMmlwA7pa6MRznWdUkROl2Tpf+kPpzmuzOL+nHbd5NDVzg3sgNKEZw==
X-Received: by 2002:a17:90b:2d0c:b0:2ee:b66d:6576 with SMTP id 98e67ed59e1d1-2f83ac8452cmr17947837a91.30.1738351764983;
        Fri, 31 Jan 2025 11:29:24 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:24 -0800 (PST)
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
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/18] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Fri, 31 Jan 2025 11:28:42 -0800
Message-ID: <20250131192912.133796-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
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


