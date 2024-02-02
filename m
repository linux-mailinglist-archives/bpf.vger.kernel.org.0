Return-Path: <bpf+bounces-21097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DED847C12
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64908B22AE8
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F585952;
	Fri,  2 Feb 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHbs29K5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2685942
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911530; cv=none; b=WYlw8JpfjEVmJ1CKcJBIkWibOOHuDIG5x4uFFi/GfNKcjLpqv8DHlijVYnuHS0lMM/8/LEwEVIA3+sjAb9a7C4FrD47VCan4FAiSau/VrNqk8Sz+HHNWVyNv+Aq8OwWGLsw5cM6l6U095KW/pKsel4vStOgHJK8fRXQWAE9dEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911530; c=relaxed/simple;
	bh=n0jQDMiHhkaJHMER7xewQ6IioWI2nnoh35A5eCEQkbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcpTddVQUlbTm/2g5jV6SKFyorUqG+ldt5tU0XU/wXgmrUBaW6U5li0j7o3joemEjOiiMCkK3xOnOHkkPnRifKCI08U5Oeq8vBjL0WgllidT6WQziX0eANfzi1YBtHRYLcWNet1lmaIH3zApBNAwMU2m5SFUwmPxwPKUBrUZ6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHbs29K5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6040e7ebf33so10375917b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911527; x=1707516327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XscpGOHaSk/IH5vxlGZdmaBmsn3qpqFTK/IOBMmHW5o=;
        b=bHbs29K5rvizK6Av2dqiJW8yq+Hrgq+KYmccslWcNAzrmwxgoC4PwzVa1k2xbUhsH0
         Hb/Nuj5i7vKEA1T49AH/V1+NC7806xUtHHrDZmdzIJG3UDh+jvMiEfLzzJC0GKg6mRds
         mOJ07yZDaMC49bjwxJx7qZXi2ZZNOxMv3hnBbsB36Zk2Zb3Iggw16KsuVWxmQw21Jt4R
         kUcj2RjgBfE9bGVXNqb0Y5yeqp9Olkdjl+B2mXPdqp8RTruaJz8Fp4KtOsSUmiqpDYPH
         sE1ho3BXnBuMSZdNfYcPEkcxno7aELpEnaMSBiOcJW4W/SD/ch4Fk59maqWTcnljm38X
         H0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911527; x=1707516327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XscpGOHaSk/IH5vxlGZdmaBmsn3qpqFTK/IOBMmHW5o=;
        b=iWvhEWm8fg6MzXYyE9sRFSB0+yi621oGey0h2yS4YR1gCir2JNtPmOfpjEPLheYCMu
         HmEiGwpB84EihazzPMTz1UVhddcSaZ85GD5Eq9h0vLqWVVDndBiAFRHsjOLCVHByot27
         tDw+TGaa/5Ym9xEx/N54R7HqNFpAAVkOylABO/IOJzI/B6SJPxALrUZ0rTODT4te5a5+
         1yBKO3jv+yNzCq8GZBJsIywQ9+U74HLMQ6/6m5F7Fe2zURqIAG5JRFRk+y/CzcEV3/jK
         4S7QWR410wmibAuPehO/YkcqVYz9xM4YkQLUW5UdS/DphDCQNLVVg6kGoV+hUuuh1497
         /iBw==
X-Gm-Message-State: AOJu0Yy/N+9vbgXwuLm+jA2S+nsU8f2FAUFp5UYDeuXFLBd2KsRaxg8F
	1VDMZdJmuy/2d/bbLBj0bAgyVdU2/MRnjlyoPZDU5hJOG36w2ulE+op1y+htAvg=
X-Google-Smtp-Source: AGHT+IE3kgE9KIO0kJuq+8tZOosZ+zefFP9b3EObvz4VRYyNYlsXcZymM6MBKVLlIAV4x1f5cvugXQ==
X-Received: by 2002:a05:690c:360a:b0:604:31e:2b1f with SMTP id ft10-20020a05690c360a00b00604031e2b1fmr3663113ywb.12.1706911526881;
        Fri, 02 Feb 2024 14:05:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVrB9k8mW/xEdm8t6LIlq4ufSOeZ/seG88ZF7W0PiajpNL6a1IqWCeYNjwdPHC79ySbz/tWIvUF+i14CMqwX+6QzZk9NwBIBJX2v3LA/BI5X1+TrIpXI6aA0+gGvaIOg7C04iCOYpYuplBPyJ+JBmHD9UYLaKSahyNXLs4DrDS/5txuaCeVPCxkZgtAdYw3u6uqhmbi4/2x2PEl8IIPsUxU+4lvLkVrea8ugx3CovhekYTVgCcpTUxCX+tBooPL5tmCKPxvqEvEf0XrnIwLveBbgmiOJEupGmtDgchVmH+5Dhg=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:26 -0800 (PST)
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
Subject: [RFC bpf-next v4 6/6] selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
Date: Fri,  2 Feb 2024 14:05:16 -0800
Message-Id: <20240202220516.1165466-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202220516.1165466-1-thinker.li@gmail.com>
References: <20240202220516.1165466-1-thinker.li@gmail.com>
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
test cases here. It has several pointer arguments to various types. These
pointers are majorly classified to 3 categories; pointers to struct types,
pointers to scalar types, and pointers to array types. They are handled
sightly differently.

A BPF program should check a pointer for NULL beforehand to access the
value pointed by the nullable pointer arguments, or the verifier should
reject the programs. The test here includes two parts; the programs
checking pointers properly and the programs not checking pointers
beforehand. The test checks if the verifier accepts the programs checking
properly and rejects the programs not checking at all.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 23 ++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   | 10 ++
 .../prog_tests/test_struct_ops_maybe_null.c   | 61 ++++++++++++
 .../bpf/progs/struct_ops_maybe_null.c         | 41 ++++++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    | 98 +++++++++++++++++++
 5 files changed, 228 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 4754c662b39f..a81ca9ccf8aa 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -556,7 +556,10 @@ static int bpf_dummy_reg(void *kdata)
 	struct bpf_testmod_ops *ops = kdata;
 	int r;
 
-	r = ops->test_2(4, 3);
+	if (ops->test_maybe_null)
+		r = ops->test_maybe_null(0, NULL, NULL, NULL, NULL);
+	else
+		r = ops->test_2(4, 3);
 
 	return 0;
 }
@@ -565,19 +568,29 @@ static void bpf_dummy_unreg(void *kdata)
 {
 }
 
-static int bpf_testmod_test_1(void)
+static int bpf_testmod_ops__test_1(void)
 {
 	return 0;
 }
 
-static int bpf_testmod_test_2(int a, int b)
+static int bpf_testmod_ops__test_2(int a, int b)
+{
+	return 0;
+}
+
+static int bpf_testmod_ops__test_maybe_null(int dummy,
+					    struct task_struct *task__nullable,
+					    u32 *scalar__nullable,
+					    u32 (*ar__nullable)[2],
+					    u32 (*ar2__nullable)[])
 {
 	return 0;
 }
 
 static struct bpf_testmod_ops __bpf_testmod_ops = {
-	.test_1 = bpf_testmod_test_1,
-	.test_2 = bpf_testmod_test_2,
+	.test_1 = bpf_testmod_ops__test_1,
+	.test_2 = bpf_testmod_ops__test_2,
+	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index ca5435751c79..845c04ba66c1 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct task_struct;
+
 struct bpf_testmod_test_read_ctx {
 	char *buf;
 	loff_t off;
@@ -28,9 +30,17 @@ struct bpf_iter_testmod_seq {
 	int cnt;
 };
 
+typedef u32 (*ar_t)[2];
+typedef u32 (*ar2_t)[];
+
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	int (*test_2)(int a, int b);
+	/* Used to test nullable arguments. */
+	int (*test_maybe_null)(int dummy, struct task_struct *task,
+			       u32 *scalar,
+			       ar_t ar,
+			       ar2_t ar2);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
new file mode 100644
index 000000000000..10f5f4fee407
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
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
+	struct bpf_link *link_1 = NULL, *link_2 = NULL,
+		*link_3 = NULL, *link_4 = NULL;
+	struct struct_ops_maybe_null_fail *skel;
+
+	skel = struct_ops_maybe_null_fail__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_fail__open"))
+		return;
+
+	link_1 = bpf_map__attach_struct_ops(skel->maps.testmod_struct_ptr);
+	ASSERT_ERR_PTR(link_1, "bpf_map__attach_struct_ops struct_ptr");
+
+	link_2 = bpf_map__attach_struct_ops(skel->maps.testmod_scalar_ptr);
+	ASSERT_ERR_PTR(link_2, "bpf_map__attach_struct_ops scalar_ptr");
+
+	link_3 = bpf_map__attach_struct_ops(skel->maps.testmod_array_ptr);
+	ASSERT_ERR_PTR(link_3, "bpf_map__attach_struct_ops array_ptr");
+
+	link_4 = bpf_map__attach_struct_ops(skel->maps.testmod_var_array_ptr);
+	ASSERT_ERR_PTR(link_4, "bpf_map__attach_struct_ops var_array_ptr");
+
+	bpf_link__destroy(link_1);
+	bpf_link__destroy(link_2);
+	bpf_link__destroy(link_3);
+	bpf_link__destroy(link_4);
+	struct_ops_maybe_null_fail__destroy(skel);
+}
+
+void test_struct_ops_maybe_null(void)
+{
+	if (test__start_subtest("maybe_null"))
+		maybe_null();
+	if (test__start_subtest("maybe_null_fail"))
+		maybe_null_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
new file mode 100644
index 000000000000..9025570f574c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+u64 tgid = 0;
+u32 scalar_value = 0;
+
+/* This is a test BPF program that uses struct_ops to access an argument
+ * that may be NULL. This is a test for the verifier to ensure that it can
+ * rip PTR_MAYBE_NULL correctly. There are tree pointers; task, scalar, and
+ * ar. They are used to test the cases of PTR_TO_BTF_ID, PTR_TO_BUF, and array.
+ */
+SEC("struct_ops/test_maybe_null")
+int BPF_PROG(test_maybe_null, int dummy,
+	     struct task_struct *task,
+	     u32 *scalar,
+	     u32 (*ar)[2],
+	     u32 (*ar2)[])
+{
+	if (task)
+		tgid = task->tgid;
+
+	if (scalar)
+		scalar_value = *scalar;
+
+	if (*ar)
+		scalar_value += (*ar)[0];
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
index 000000000000..cbb46fc9f02f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int tgid = 0;
+u32 scalar_value = 0;
+
+/* These are test BPF struct_ops programs that demonstrates the access of
+ * an argument that may be NULL.  These test programs are used to ensure
+ * that the verifier correctly catches the case where a pointer is not
+ * checked for NULL before dereferencing it.
+ */
+
+/* Test for pointer to a struct type. */
+SEC("struct_ops/test_maybe_null_struct_ptr")
+int BPF_PROG(test_maybe_null_struct_ptr, int dummy,
+	     struct task_struct *task,
+	     u32 *scalar,
+	     u32 (*ar)[2],
+	     u32 (*ar2)[])
+{
+	tgid = task->tgid;
+
+	return 0;
+}
+
+/* Test for pointer to a scalar type. */
+SEC("struct_ops/test_maybe_null_scalar_ptr")
+int BPF_PROG(test_maybe_null_scalar_ptr, int dummy,
+	     struct task_struct *task,
+	     u32 *scalar,
+	     u32 (*ar)[2],
+	     u32 (*ar2)[])
+{
+	scalar_value = *scalar;
+
+	return 0;
+}
+
+/* Test for pointer to an array type. */
+SEC("struct_ops/test_maybe_null_array_ptr")
+int BPF_PROG(test_maybe_null_array_ptr, int dummy,
+	     struct task_struct *task,
+	     u32 *scalar,
+	     u32 (*ar)[2],
+	     u32 (*ar2)[])
+{
+	scalar_value += (*ar)[0];
+	scalar_value += (*ar)[1];
+
+	return 0;
+}
+
+/* Test for pointer to a variable length array type.
+ *
+ * This test program is used to ensure that the verifier correctly rejects
+ * the case that access the content of a variable length array even
+ * checking the pointer for NULL beforhand since the verifier doesn't know
+ * the exact size of the array.
+ */
+SEC("struct_ops/test_maybe_null_var_array_ptr")
+int BPF_PROG(test_maybe_null_var_array_ptr, int dummy,
+	     struct task_struct *task,
+	     u32 *scalar,
+	     u32 (*ar)[2],
+	     u32 (*ar2)[])
+{
+	if (ar2)
+		scalar_value += (*ar2)[0];
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_struct_ptr = {
+	.test_maybe_null = (void *)test_maybe_null_struct_ptr,
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_scalar_ptr = {
+	.test_maybe_null = (void *)test_maybe_null_scalar_ptr,
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_array_ptr = {
+	.test_maybe_null = (void *)test_maybe_null_array_ptr,
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_var_array_ptr = {
+	.test_maybe_null = (void *)test_maybe_null_var_array_ptr,
+};
+
-- 
2.34.1


