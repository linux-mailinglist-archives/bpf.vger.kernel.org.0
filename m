Return-Path: <bpf+bounces-51577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADBA36364
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9269B1890EDE
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E9267AF6;
	Fri, 14 Feb 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUzyFKGD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18126773C
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551535; cv=none; b=suauWKIE2Cyv4vtK8E45TBjoHkNfQY/MG+lzU2E4LKLk+rzXk682sjhy7AT9+5HufFwTAQNkDnFNuDNq+AB3HvmTV0DmTY+YjHQeKtIrimEWZTlRyyIHAiUhCBkqK5/9tHWDn86QsXsGCKz4lq90o6Px2GdXBfiqH4OIaX74Z6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551535; c=relaxed/simple;
	bh=cu4b3Vbm9gFq/EkCNcqo0m8n8rFskmSadxY4u/enMps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li8nazeTZ33JrhjDY8L9VEJRl+G/BfVqwHl2wwpQJ3pKhSP8M9aDG/FBixMj586phBgRphis77dhQ5A6wqxHRyI9HeKgT3Ck2kBE0fT2kqH9+mulHV5N25HNpxkcb8WttQ98E1wVGMTyXLCvIbBDCWDDjE6EpGu8PWxLVHAwliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUzyFKGD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e6028214so32950015ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551533; x=1740156333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB3GDDoQAzmyBzIZYs9Df0cqC8v4dqCoGTbbm/k4J8w=;
        b=KUzyFKGDp3G1MjoUu2MUXEgS1vizU7w6shP2tBG6fJYK7RfyklcgHWSn65CRIFOqjq
         nv6+hcfhJjtGEz0hdz12ObeJorDEX7zInFhx86DekzD1atpN34p03dgJAzOVKkMgV1/g
         GvJmg1AnkzK2YcBKOo9656mWYqG2+Mno7AbmLj/KJ18PZRanKOEFBsKMEWY6irJ3C8OM
         GvrGB9j+B1EsPGS0JBTLrmjTp78OITF6lSx2rVhikEo+w5xXy7/BrxWRWfHL7Z83EvsB
         XocSQIYx5NcZEMETuYXkL+r5o3kpve48tXk/rhpuXewGv9iLIBxTTI85DZUUE85lCgt/
         3XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551533; x=1740156333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB3GDDoQAzmyBzIZYs9Df0cqC8v4dqCoGTbbm/k4J8w=;
        b=qg9dMLhjvk6MQTxhF7Dfqntu6a+CynIAMNbC9mwANLpahkffd7UHEYE5qEJBELqhv+
         A509oTYBecVg2Pr+lMrZsbEo/EZezSkSzn/lW4gIm8Rcc/GF9w5YfheVJ74x9hP1wGr6
         fkrN+dEht15DIMMXuBHXYoz7wqSdMaKbtTXTmVajoUBukccqeKHACSUi+lphC4xLmA24
         siX2/U6ihaHhECNEY84BYAcYANQqZ5IZYn3L3Fy6OtLYql605pUm/glYSkvYXIfdZwMt
         84wqQz+jMOFXuXQm8AVkrLidUDTEv7VdptLaFHvZipKOqR9GejkuuwPwqlCbcco5ayHL
         TCEA==
X-Gm-Message-State: AOJu0YzJ/bMd7QaDRFhoWbNmhbvDISCSwkKBXk1UG25jhgfIGe4wmSuW
	w+PEfrZ8jibEJp11tbU1vSZggMwPbsyYW2fv911/k/8e/NfnwU/4hwsKwQ==
X-Gm-Gg: ASbGncvrJ+K/IbnGgSe7r6mPcBT5PK32t5DoE+xGGCcYfPMo4q4GkcNwvQ1oGlNBJGC
	K8VyyJe3ntzI3gKmqscm3WSY0m/WPTxj0LEZFKIWC4UGM+sDjbPyuLBLAmTU+Qn7hDsxwKkX+cF
	UQqWDY5P7qP1GmDpe0Sr6+m0A8z0xCspXQEpzRNaTCvTn0gQIgdsLMmK/xCerDhsGpYn6MaENb1
	lYOYd/DoEBwVUYG0qh/Q0/j3GeERifTYmn6BOVXm4cB+rff4gdn2hUaIJSRTxS10P3blCGSUOnl
	HtP7kYrz7Dv3a96OknbMXbeFtMtwLXwsNSKKZz76zBp/c6zu0WzOAA7poOAD/u8vOQ==
X-Google-Smtp-Source: AGHT+IFGwcYZvr5LFXDuZuXUHw4nuzpu6le0QkkFljqtCNpszQ75teFvxgeP7dUDJ3+/ksvr21X79g==
X-Received: by 2002:a05:6a21:6e47:b0:1e0:d1c3:97d1 with SMTP id adf61e73a8af0-1ee8cc03463mr222307637.29.1739551532584;
        Fri, 14 Feb 2025 08:45:32 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adbf21517eesm2223346a12.13.2025.02.14.08.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:45:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/5] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Fri, 14 Feb 2025 08:45:18 -0800
Message-ID: <20250214164520.1001211-4-ameryhung@gmail.com>
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


