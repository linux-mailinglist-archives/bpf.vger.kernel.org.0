Return-Path: <bpf+bounces-47470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B29F9AC7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EAF1669F5
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5573226166;
	Fri, 20 Dec 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq3+q7N/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AF221462;
	Fri, 20 Dec 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724593; cv=none; b=o7sEb3hlA1ccVJpSzBVOM6NJeVFwzKb+d91K3BvzxwdSgy1QsPOrYvg/BBRx0XoBmANJ5y3WOXI152GsFytim53PAui8FnYX8bcRN6FOTBv3oCNMyxFAISagGXF+wcp/BNrgts1+jUwVCKHox4Pf5som0TiUqW0wcuDG2mlrckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724593; c=relaxed/simple;
	bh=t4FUE67K84dtQH35RTVnYwfhNMRurLNJfv1SsEXwGpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvonRS3+WIw7zI4R9BeSlHGZ5OEvd/hq0opWLGdn2nKLPd9GjEwmSCmpW5NywFph6gO0tJeck0hjioeIEywDLYbt7yTCtjx4KyJ+2UZ/85zmZLNRRWOT+C2hQPP/tQdmWoOrZ395jxWj+P/RkMjmO9/V+lJBJF1ASBoGyx+agOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq3+q7N/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725f3594965so2065803b3a.3;
        Fri, 20 Dec 2024 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724590; x=1735329390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf1eNdZAO2NHBNY0w45oV/p8wgFq0vsGvz4g6V3xMYA=;
        b=aq3+q7N/Osdm2g1JmxlIkaMzRu7hnJDI7vgt6GVxESdsfUXx0LKwBwzLKMvQJZ7j36
         BDQ+Y9EOozxVQzQGcMFJ7BSpJuKpWuhgOGuWTK1EDwwOg1J11srNpNaOWgLV2I9m3+3x
         ICvuvG4YIBFJXu+dv9SVkyOklfbeRUMK+0I7Z8NE1Bs91NlUQuoTHTgtXgsiWcAR3fqs
         P7VKRTtmSjupMMT7BfPiidaGv/dVeGpexaUhz8i90x2uyWrkJh8OjSOGZhEOLOKrc89P
         Ai+iyH+P6rVvqvFw0IdTeghkTetS9O4LXJGr78UyBSKeGoVd/ug+uyRJ2z+x2XHGFSqC
         FUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724590; x=1735329390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf1eNdZAO2NHBNY0w45oV/p8wgFq0vsGvz4g6V3xMYA=;
        b=jI121Oc3jSGRsiXrYaco3CHfoOG+Ocybs68IqmMPOo0Nh7g2eFDWhmsyHDf11YbgCE
         8Hd4Vxwtv5R3jsL8O55/ur1Qi5lbOUjfjb3NMqqmRav1Qmt4E+Jgn5yY/3nlFCpC9xVr
         imtXTe53lnsHgZ+Qv4gDPLV8s31cQMCKUHmvQQZoKSUjzzW9Oi1Ef8y1FhmqEaNTYhFd
         fYSVFe5Ob50NsUG7cNGAoE6+pUX7sJa4+0u34lSSl1SogkHqXtLvl87NDTd6rtTInjY4
         QpFo7wVh2XedvviCfY5zMgG2cWGeI9B48AlPahrr+U4W0BMzB6s19V2S45MveQl5Aitu
         NBgA==
X-Gm-Message-State: AOJu0YxFKelHWpHzJDI0Zt8SErH6PQd9ItHsBww34YXz4d1AWt3DLiU7
	Do4IBVtInu6X4+nIE7K/KMp2b0woQaGWxlbnMHekiqQ1syGmfBP3JXo1eg==
X-Gm-Gg: ASbGncuRg8eE73Sjn7z0ZWMQajc1pp/vk6utoFwXizEEWcTTGPlbMDwZaNH3k7EwaV8
	NBqiLQ0WU2YIvkrD+iHrRLYQbpjtnK4anQqhRdNvMyhtZsqDD2qWH3XkaCC8h4TaAVlZFCCDq5F
	6fbIDuyUnbRXlcig/Sr+KdFC+YYVGMX7FCb+P580HCLxEvSWXkzj8FndN9uZEHgdsHDMJxJ7Tyl
	jhQq/0uH/JXVkAEL/M2AGBxGjfirP877Fv/0esKd/dMuk9usgo2xjU962Ro22QqYfg4ZzkvFRyb
	wmW9sRugLYMYJWQbXYu6Y23o5LHIb7Qr
X-Google-Smtp-Source: AGHT+IF8/X0KErNXYH7U4fuIbqu4mQxEYdPR14bCGBKIDM0EVr3nul6SLXtnQ58PO6da7SR0lDGbXg==
X-Received: by 2002:a05:6a21:2d8c:b0:1e1:c943:4e8e with SMTP id adf61e73a8af0-1e5e081ee88mr7010613637.41.1734724590575;
        Fri, 20 Dec 2024 11:56:30 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:30 -0800 (PST)
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
Subject: [PATCH bpf-next v2 02/14] selftests/bpf: Test referenced kptr arguments of struct_ops programs
Date: Fri, 20 Dec 2024 11:55:28 -0800
Message-ID: <20241220195619.2022866-3-amery.hung@gmail.com>
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
 .../bpf/progs/struct_ops_refcounted.c         | 31 ++++++++++++++++
 ...ruct_ops_refcounted_fail__global_subprog.c | 37 +++++++++++++++++++
 .../struct_ops_refcounted_fail__ref_leak.c    | 22 +++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  2 +
 6 files changed, 111 insertions(+)
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
index 000000000000..43493a7ead39
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
@@ -0,0 +1,37 @@
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
+__failure __msg("invalid bpf_context access off=8. Reference may already be released")
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
2.47.0


