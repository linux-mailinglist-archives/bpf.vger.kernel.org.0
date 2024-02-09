Return-Path: <bpf+bounces-21580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD184EEE4
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A89281BE5
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776F23B1;
	Fri,  9 Feb 2024 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNOEYTEZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F041C20
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446282; cv=none; b=JyIRb+wtdIgprZ8TV+7PJKtm2wHaIhHiTBD/zDc0SVAJ5FPP2UUJruGhdYnoTD532sKsYwrW6pPKsxbfY3hZOkIqdmf9QlhkNCAfVCRn/LK8tE1MdCBNs8S0dedz2kbc7EpskhqWHStgJ5rK+Yecp1MSa7R08mtxs/L1tWACDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446282; c=relaxed/simple;
	bh=tJaEvUHBGfLHhQQ6Z8IUE3m7lUAI+XObVCJa24vf10U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFumJnzxvuRgK2MiTwd/Ru0lVzRVNATBpVKCqFRvFRrnZZbIOtya5a08wLzvOV/nL3QILnQDoaGwN010+848oiaYbr0Ctqn5BStsbhA7T7geYDiLYhKIQ7FXqDv6yfP6eBE77EBoTC/NXzqW6sKnu0OujJrE+K7yhlMDWI1ndqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNOEYTEZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604b23d91afso7114457b3.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707446279; x=1708051079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL46QOptrTSppgIc8VdwygxoqnHkFvIWCBIzuCoN1ys=;
        b=aNOEYTEZ4uKip1Ek+I+QV93x6SZyzQBA7ZEspN7F9QwXUIaKyZBeN0q/xCA5L5P/Rj
         zFR4ffM1PfRhL3zpmlOSZDcWv29jVx3p3KvqdeeMa+f6JdY94XJ6IgmpBoQpP5P2pYNT
         hd97QOglThw/DMAwqme9jddb2SNq/4ENOFBY1i9XCpyCVfA+5bFr8lBe4hsIx38ZZBUZ
         mtha4RAAeJLMBWbMOTey+rZaNBkZpSMGCbOMD+W0hNYEzc3zTQxPH5OI8KaX3Q+YmI0S
         MKksQU21qb0akNfTQWaJWoOjyprmf+rjzMeef5H+PIEpgXLXXeWqLDCy4auiObtd9Luf
         koLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446279; x=1708051079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL46QOptrTSppgIc8VdwygxoqnHkFvIWCBIzuCoN1ys=;
        b=KYl5oONeM6jdKg9FYZTaP//0c1aQDKYKhe0a44O+8yOEfEmARnz7pr//OTW9KJYibO
         u6buXh+vzH3DLcugyWEQi2EFV5kzOA+cH2JPmf6kwbZD0uE3JsWfZDezNAf407XNaprv
         b/wni6SQpnJ4FTaoq5xMebT2/ieen0ISoS4WIqPDK6pBZfmZU8CnT6QLi+cu+BM9Dh4v
         wiIVlKwKjVEu7jJBzZ9kfvZMCekzZrCGB53DKdZRyxKnlcODzHP7wYEPFGkKVGqkpQ/V
         E8YxFrExFfpAnwRKM+W5J0CCvCDodYHKCZiAPXnChNC5CohI8A7azzwWaR/4qqHJ47Ht
         VLYA==
X-Gm-Message-State: AOJu0Yyt0zm0Qr5JMCo64ifarDVFegO4u8nAjJWZv/aQIQgJBYR/qEyC
	KuC5+wIiPPtGixGAR7y+lBEIIgvuDj8J3udVFhC+/f58X2GDg8HVfGNC/zg/62o=
X-Google-Smtp-Source: AGHT+IFuLiiUNcXD8EVJh15GL87IaTmSgmhzunBtKgIjt2DVZEIHeqlGICvzXjOvdVjAH72FwGqxiw==
X-Received: by 2002:a81:7c46:0:b0:604:8a7c:2913 with SMTP id x67-20020a817c46000000b006048a7c2913mr266526ywc.45.1707446278888;
        Thu, 08 Feb 2024 18:37:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU716rO3obUANevVQ6KrXU90ZUA69XX6V3h5QMr4/BO4UbqL0HQCQaxFkoDDHUlUPcMDoA3Elb7HqNaUThjAHWrZkKNRdyNkLhSvPbU7WEBWTgQuG1CDFbkQJOhh+xtUpU8EDmuUHCvAWKv2e/CqgSqo/sJwnwB6SIx6hvw04f0uxXDoKGTJ3jjvpBIlk9nsFh0+yZbVn09yi8MDS8PW+jOgPd3ePQ803pSHksoKE9XVkdxLwpgG4kllwdp0YdnCxh/Nub0wl7oqP6pjZNzkCHtNBkgsIzKx15Yr1TqO8IgsgM=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id i2-20020a0df802000000b005ff846d1f1dsm144949ywf.134.2024.02.08.18.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:37:58 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v8 4/4] selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
Date: Thu,  8 Feb 2024 18:37:50 -0800
Message-Id: <20240209023750.1153905-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209023750.1153905-1-thinker.li@gmail.com>
References: <20240209023750.1153905-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Test if the verifier verifies nullable pointer arguments correctly for BPF
struct_ops programs.

"test_maybe_null" in struct bpf_testmod_ops is the operator defined for the
test cases here.

A BPF program should check a pointer for NULL beforehand to access the
value pointed by the nullable pointer arguments, or the verifier should
reject the programs. The test here includes two parts; the programs
checking pointers properly and the programs not checking pointers
beforehand. The test checks if the verifier accepts the programs checking
properly and rejects the programs not checking at all.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 ++
 .../prog_tests/test_struct_ops_maybe_null.c   | 46 +++++++++++++++++++
 .../bpf/progs/struct_ops_maybe_null.c         | 29 ++++++++++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    | 24 ++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a06daebc75c9..66787e99ba1b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -555,7 +555,11 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
-	ops->test_2(4, 3);
+	/* Some test cases (ex. struct_ops_maybe_null) may not have test_2
+	 * initialized, so we need to check for NULL.
+	 */
+	if (ops->test_2)
+		ops->test_2(4, 3);
 
 	return 0;
 }
@@ -573,9 +577,16 @@ static void bpf_testmod_test_2(int a, int b)
 {
 }
 
+static int bpf_testmod_ops__test_maybe_null(int dummy,
+					    struct task_struct *task__nullable)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
+	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 537beca42896..c3b0cf788f9f 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct task_struct;
+
 struct bpf_testmod_test_read_ctx {
 	char *buf;
 	loff_t off;
@@ -31,6 +33,8 @@ struct bpf_iter_testmod_seq {
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	void (*test_2)(int a, int b);
+	/* Used to test nullable arguments. */
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
new file mode 100644
index 000000000000..01dc2613c8a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_maybe_null.skel.h"
+#include "struct_ops_maybe_null_fail.skel.h"
+
+/* Test that the verifier accepts a program that access a nullable pointer
+ * with a proper check.
+ */
+static void maybe_null(void)
+{
+	struct struct_ops_maybe_null *skel;
+
+	skel = struct_ops_maybe_null__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_maybe_null__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that access a nullable pointer
+ * without a check beforehand.
+ */
+static void maybe_null_fail(void)
+{
+	struct struct_ops_maybe_null_fail *skel;
+
+	skel = struct_ops_maybe_null_fail__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+
+	struct_ops_maybe_null_fail__destroy(skel);
+}
+
+void test_struct_ops_maybe_null(void)
+{
+	/* The verifier verifies the programs at load time, so testing both
+	 * programs in the same compile-unit is complicated. We run them in
+	 * separate objects to simplify the testing.
+	 */
+	if (test__start_subtest("maybe_null"))
+		maybe_null();
+	if (test__start_subtest("maybe_null_fail"))
+		maybe_null_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
new file mode 100644
index 000000000000..b450f72e744a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t tgid = 0;
+
+/* This is a test BPF program that uses struct_ops to access an argument
+ * that may be NULL. This is a test for the verifier to ensure that it can
+ * rip PTR_MAYBE_NULL correctly.
+ */
+SEC("struct_ops/test_maybe_null")
+int BPF_PROG(test_maybe_null, int dummy,
+	     struct task_struct *task)
+{
+	if (task)
+		tgid = task->tgid;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_maybe_null = (void *)test_maybe_null,
+};
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
new file mode 100644
index 000000000000..6283099ec383
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t tgid = 0;
+
+SEC("struct_ops/test_maybe_null_struct_ptr")
+int BPF_PROG(test_maybe_null_struct_ptr, int dummy,
+	     struct task_struct *task)
+{
+	tgid = task->tgid;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_struct_ptr = {
+	.test_maybe_null = (void *)test_maybe_null_struct_ptr,
+};
+
-- 
2.34.1


