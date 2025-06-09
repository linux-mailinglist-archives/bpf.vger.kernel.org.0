Return-Path: <bpf+bounces-60114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307FAD2A81
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F7516FCF8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86F22B8B3;
	Mon,  9 Jun 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyfjUnL7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878422B5B6
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511673; cv=none; b=oWacbYEl4oSLL19/kGGP8BEUs/I06I43rpEzRH2BCn/aRPbzhkrKUOnP7WjK5OYOXCVjfdEBZOZquDK5q5zxCLRPR3kWi3pDyqUg4V5s4ceRYZdv70Q1rCfFX5Bt7vFYeR7+yhl96grOV0vJFazX9PFBuUluhCB9j/DrW4dJuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511673; c=relaxed/simple;
	bh=qh0k3BC4YAbpA91BQC8h3AMqpQHQjpEI/9Rjuw8TUxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiJvZoryNok7N5k8bc3FYGJ+D9YbDFTb9WbUxjlkeFdwc1Ava+v6HR3QNqGhau8X60S2I8Y5T/uF21NDcdrczxjOaEybhFHCJ7NUvErq91vh62t+dB1INQqHOWZFkvDDk1Wy3Iqeaye8FoZNzkfMjF0XHH1Hd8q2oCLdu8wT0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyfjUnL7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2352400344aso41784495ad.2
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749511671; x=1750116471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/wfH9PNqpXv6DNNF/6iVf3ZA5Q113cKBAZRN+oA9y0=;
        b=KyfjUnL7e+hVd8xt40eIn8Pvs8naG7oWYdX/euS6NLJWj4MMxQ9jvPMySLVpnUWhGr
         RvevWCFo3/FLPB5t1mVG6IW0+J/f0Gt+yp8p9jVfEuRsSxCNjS3dtr9ACekSajEUTC+T
         CTkq7b+5eI8NdqwnUKJVdezMU0/+7gETCTXPCJQ67OEjFcHVIVCxskgO3fzXWQC0fipg
         0UaZC+BlW6VNxoidEUhFm0CTBWE9PTYKEW9KxAQsIZxhhKR/av7kbOjAm+xYgcGiRNoL
         HK2N/zqxS1LYlvmMv9zL1nAENnk7/O0M12DQquKqiMchtbDr2RAXlrc7K8UHMPliTdlO
         lLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749511671; x=1750116471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/wfH9PNqpXv6DNNF/6iVf3ZA5Q113cKBAZRN+oA9y0=;
        b=AAk1DGm3MnneQ7LSQicUvkqQePuYlxH7bDjWlPohi+/ZKvkFXIUfaMUSWcQVJ3ft06
         MDub6N6JiY4nq4kAcH/suZCps0plUtP62vleC2VF+ey3o1fs3XGadaIVK+I65ABnPgwL
         rRPUEvvxhEba37AkZLC5kf+yxJRTlykHVZCfx15EYoXCLItp34o0VQj5pAuxKCSnJi6W
         Y2/5iXL4O1XYZvse6vArwdFo7ciq4UcxMfrAAu4mZOeNpr4YiWpCT0ukx3GeozUsH2ut
         Y3xIn5E0hEF/4q9O5Q6vMv1+Z26qlANRcneudLc3K1AN4QSx3fx3keXRHdBaXn3hF06l
         ZUug==
X-Gm-Message-State: AOJu0Yy/hodbN1ZZ2dHvrs2Cy8nJN8oOF4eNpsPsSTk/gek5VRCPI4n6
	C8Ug21kMxfHTY599AQeAtbDGV+JCEKvu+KmJcaTQ/T9iaBDijfl5cC44J4ExqA==
X-Gm-Gg: ASbGncs0Q8oBG8UjNYbPA0kfnDRfXYo4xEorKT5P8noyyj9bjSncMtxNR9yXUQuExHS
	m45RtljZIKA16XekAmWrnlRunpGYXLxbXWzJRrBr+r1F4CM4BzrSCDE+B8gjIQmIxcE4yslS7r/
	KLzVUOTtWuhOYne/hbYvW5F4nMjZ+s+fAOvZf4PL0fdUsFpwKGjI8eKHNc0l/8t0XHG2BHZ6lYG
	ZMiNBsHu0K8iKSie9KtzYd2EdVWnLut/ev6oZaxo3D3Vau8CGLQ7i+21I2kM1NefflVh2hsC6cW
	Hv5tWjJulMK1o4N7ouZq0nqyupuvarjQF6E0u9C0Zg7izrE0ptgo
X-Google-Smtp-Source: AGHT+IG+m1EDAIYVsty/rYmTzwZmt3skgU7MDVmqAImtqjFtuVCv3dFXjtK+gOEMHjZlpzpk/cHeGw==
X-Received: by 2002:a17:903:244e:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23601cfddb7mr201569035ad.21.1749511671436;
        Mon, 09 Jun 2025 16:27:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fe0048sm6171270a91.42.2025.06.09.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 16:27:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/4] selftests/bpf: Test accessing struct_ops this pointer
Date: Mon,  9 Jun 2025 16:27:45 -0700
Message-ID: <20250609232746.1030044-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609232746.1030044-1-ameryhung@gmail.com>
References: <20250609232746.1030044-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test struct_ops this pointer using bpf_testmod_ops3. Add an integer
field, data, to bpf_testmod_ops3 and a kfunc that reads data through
aux->this_st_ops. Check if the kfunc reads the correct value of data.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_this_ptr.c | 10 ++++++
 .../progs/struct_ops_private_stack_recur.c    |  3 +-
 .../selftests/bpf/progs/struct_ops_this_ptr.c | 30 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 36 +++++++++++++++++--
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  1 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  3 ++
 6 files changed, 78 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_this_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c
new file mode 100644
index 000000000000..6ef238a2050a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+
+#include "struct_ops_this_ptr.skel.h"
+
+void serial_test_struct_ops_this_ptr(void)
+{
+	RUN_TESTS(struct_ops_this_ptr);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
index 31e58389bb8b..215b675ddf94 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -13,8 +14,6 @@ bool skip __attribute((__section__(".data"))) = false;
 bool skip = true;
 #endif
 
-void bpf_testmod_ops3_call_test_1(void) __ksym;
-
 int val_i, val_j;
 
 __noinline static int subprog2(int *a, int *b)
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_this_ptr.c b/tools/testing/selftests/bpf/progs/struct_ops_this_ptr.c
new file mode 100644
index 000000000000..e5a6463c27ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_this_ptr.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops")
+int BPF_PROG(test1)
+{
+	return bpf_kfunc_st_ops_test_this_ptr_impl(NULL);
+}
+
+SEC("syscall")
+__success __retval(1234)
+int syscall_this_ptr(void *ctx)
+{
+	return bpf_testmod_ops3_call_test_1();
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_this_ptr = {
+	.test_1 = (void *)test1,
+	.data = 1234,
+};
+
+
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2e54b95ad898..f692ee43d25c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -272,9 +272,9 @@ static void bpf_testmod_test_struct_ops3(void)
 		st_ops3->test_1();
 }
 
-__bpf_kfunc void bpf_testmod_ops3_call_test_1(void)
+__bpf_kfunc int bpf_testmod_ops3_call_test_1(void)
 {
-	st_ops3->test_1();
+	return st_ops3->test_1();
 }
 
 __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
@@ -1057,6 +1057,23 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 	return args->a;
 }
 
+__bpf_kfunc int bpf_kfunc_st_ops_test_this_ptr_impl(void *aux__prog)
+{
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__prog;
+	struct bpf_testmod_ops3 *ops;
+	int data = -1;
+
+	rcu_read_lock();
+	ops = rcu_dereference(aux->this_st_ops);
+	if (!ops)
+		goto out;
+
+	data = ops->data;
+out:
+	rcu_read_unlock();
+	return data;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1097,6 +1114,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_this_ptr_impl)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1269,6 +1287,17 @@ static void test_1_recursion_detected(struct bpf_prog *prog)
 	       u64_stats_read(&stats->misses));
 }
 
+static int st_ops3_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	if (member->offset == offsetof(struct bpf_testmod_ops3, data) * 8) {
+		((struct bpf_testmod_ops3 *)kdata)->data = ((struct bpf_testmod_ops3 *)udata)->data;
+		return 1;
+	}
+	return 0;
+}
+
 static int st_ops3_check_member(const struct btf_type *t,
 				const struct btf_member *member,
 				const struct bpf_prog *prog)
@@ -1289,13 +1318,14 @@ static int st_ops3_check_member(const struct btf_type *t,
 struct bpf_struct_ops bpf_testmod_ops3 = {
 	.verifier_ops = &bpf_testmod_verifier_ops3,
 	.init = bpf_testmod_ops_init,
-	.init_member = bpf_testmod_ops_init_member,
+	.init_member = st_ops3_init_member,
 	.reg = st_ops3_reg,
 	.unreg = st_ops3_unreg,
 	.check_member = st_ops3_check_member,
 	.cfi_stubs = &__bpf_testmod_ops3,
 	.name = "bpf_testmod_ops3",
 	.owner = THIS_MODULE,
+	.flags = BPF_STRUCT_OPS_F_THIS_PTR,
 };
 
 static int bpf_test_mod_st_ops__test_prologue(struct st_ops_args *args)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c9fab51f16e2..13581657fe35 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -103,6 +103,7 @@ struct bpf_testmod_ops2 {
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
+	int data;
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b58817938deb..625b3f4b03f6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -159,4 +159,7 @@ void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
 
+int bpf_testmod_ops3_call_test_1(void) __ksym;
+int bpf_kfunc_st_ops_test_this_ptr_impl(void *aux__prog) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.47.1


