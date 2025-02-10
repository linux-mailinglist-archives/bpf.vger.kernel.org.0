Return-Path: <bpf+bounces-51012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA51A2F58A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDDC3A5B5C
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83D257437;
	Mon, 10 Feb 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVzBhNzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C32566F7;
	Mon, 10 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209434; cv=none; b=hT1j1Ps8K4nTq+2HoFQS9OQz0HiG0EVKjN4kiI2b7F+pOC1GF5OfhGPeZ16204GTRFM6hp2Bjc6Y6kqJrXbClV3IKEh2cs3R7u+X5nRQi61gpYWlApE+BvFPl9B+aeomHzlhcyxME8LlUdN8T1rY1flwjyzmhydH1H9gC3Jn/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209434; c=relaxed/simple;
	bh=0CPds7L6bVfgfkSwoGmkmAs/hqh/qG7iMp0sGgwerYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3Ktl5XRtPWFd5sqcHpOqGppHei2ZRJiEfTefpZgl+uibquFgztI5CMAz1q0cYC8ZLkfHm9EXhC0uediAoTlW0JWeiJcSqBY4HRTGSAIuAl9UYmwA7FtbLOctwaAXIXjaGzFocg558UjypM9gfFU368JYhkSQSEbHG0cRhC8tS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVzBhNzi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f48ab13d5so74926735ad.0;
        Mon, 10 Feb 2025 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209432; x=1739814232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEMmk+QJ7T9vF+Ze9uAr46CKRIACQEkQZAvqN5YNqmw=;
        b=ZVzBhNziVplqmuWewBolSNgISidkMHdwraaoM2y9qeHBa/ZKb9nsQhwkuAEyarrj7f
         AxDpj4cPCX8TwSyp29oy9AakqNVNDIiiXFHGaKSASEtmaDCSTw56sJk6g+L5ZW+vSQPn
         Ckda2pjkR5CD9BZNgdZ+9f0qjsHZBjCru9bt4ewtaCsc8Ezb7oVsO9BLopP6pw8gFnKU
         7hnY9LP22Iys7rk5XJfcFunVmEIufN+HPpnQ/yYNbz883jd+xPq2AeFcyGC6MP0REPN1
         DdcoKkE7ovexbUg3ZizY35DTnpdmJK1rz5RpUEg7l4qGegng6H2wdKrs1pRq4kDxqb1/
         ShFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209432; x=1739814232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEMmk+QJ7T9vF+Ze9uAr46CKRIACQEkQZAvqN5YNqmw=;
        b=Rgum5uyJOiyRtuHATNsuj6yGNX26zfLFQaz3vi+a8F5oxkb4UCy/eWKpK/+iM3T5Fm
         52Al6SiQx82a8XdLTp3k4u1f9r96pim7+HSnm9gYf81gGETPN6jsdBDCJFe8Me2awXhq
         //FgfgBKlv7r7WGJ1zHJls+foWB1JCqoveoUkLaURELLvN3bZkjDPuYoCeamZTkYg7rF
         L70pNXFvYi626NElekQ+yQqg6299AywwaE7prZAewHlpL45fNT1mK0P3L9nVwfVw9hkv
         C0z88ULjnKe6PGgg8LiLUBB6MRPYV4+R/h7p/8m9Os9DSIyKFyculMG2P+7fkg2L0rQI
         YMzw==
X-Gm-Message-State: AOJu0YwHu9yoRAQneBP9SCV3TnIlWmeIx4e3j9tzOFGUXgWW3mM0y87R
	qp8NodWcSMsOcwkY9AfD/MKC2FfcJm8L5d5BFJtUNosLsbgNn5/lukKO0LZK
X-Gm-Gg: ASbGncsVLIF7RSqXEYv9XOfsEVvEY5otYkf7ZC4+pSeefKSzLqsI6n/lEZEcHZ19CTN
	aKbFGbFE//p1OFcSiKu31+RGsNQKeiGiCLcFrHuRlofg9V8qco+I5tnCHaeSlc+bDgHZcAEi6B5
	QELQm7jfBAvT3SA9YKxTC45xbeD+9W9TO5lzxeWn5IoIdtnFR37Br18Sh/lXPP+9kEsxQL23dR0
	p6bG94S62drZ5HD2idlSwhuKRryyOcD6VPSwRCXAGbabvpyQgDkROs4yOkr8Jtf9xGrGpoUpiCd
	Uh3w9vvLLPDswqmEqitf6NEftcjrux8rexHIwFdhRWZhkc4+mDSchctY8KI1umF4cA==
X-Google-Smtp-Source: AGHT+IERlv+OOVOKrywdfqoHxBOBZTc8CSY6txjHghiULgu81kyLynUEGjTh3ePAlFroyOWv0s1Hiw==
X-Received: by 2002:a17:903:947:b0:21b:d2b6:ca7f with SMTP id d9443c01a7336-21f4e75a0aamr244044785ad.32.1739209432026;
        Mon, 10 Feb 2025 09:43:52 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:51 -0800 (PST)
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
Subject: [PATCH bpf-next v4 05/19] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Mon, 10 Feb 2025 09:43:19 -0800
Message-ID: <20250210174336.2024258-6-ameryhung@gmail.com>
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


