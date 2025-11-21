Return-Path: <bpf+bounces-75268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78044C7BEF4
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 393913641BE
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7ED313267;
	Fri, 21 Nov 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBI/WnMD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B43126AC
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766841; cv=none; b=KFnfpHDxSu4rdPtkbKb71v5X4rsNhKTrYO4LRkg32g7kBlAKodVMWTmrgRjpjx1aTEfZRezfA3bNjZHh2QmM0dDp+SI0vcX9qFMnQj0z8XNGcX3x0ztGwUyJazF8LRI5BcdXvhk28JhrXZFrOBjJJ3BSLtIzKhTE9a1Ps/Qk1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766841; c=relaxed/simple;
	bh=q1OrpPANoc1cu/MnzrZ+x/nBm2N3G1drvCgJ6RweiVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj9EONdvB8venM0MyBQjEGTIMP6yvmLCkDwnwZVYqo71hgti3FlGLaHd0IPNiFKCzLdatf+h2eeV9iTQBeDUwx5LM1ICJ52aF8sG8yKNXlERHXhZjTSpsjuBSqCWGwQPrU+D7jA67IY+xLaHehxB8upJ2txd5COH0sdBv4ZUEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBI/WnMD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ade456b6abso2093033b3a.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 15:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766839; x=1764371639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71gecULlLY4ThXFLJO+sdi9rDjPxaS+h+ctwCXYTDTs=;
        b=OBI/WnMD0Iqvv9EO4uc40AY807wk3rxh0jwJRoBnizpQ5Fyqd9zB+BQzOqeOcPV5oI
         8YywyshjB0Rc9PGjZfNp+7tviYh2KgemZsAc9X4sTLvAKwEWygIw6qEg9liNH4yWG0wQ
         udRCRNAK1U79SXUN4JNjmUSO+NmNqIXp7Zr+HP2KxvLno5k0FqZWc69c5o8nQrrnWIEg
         Lovv386nDMKQ5h02+TOUZrE8cRAlBQ4MHHrH/0CnrJRz5KSqEXfkfgMbjjPUm1G4Rm5u
         K7VvbNaVL/b1vd7XFXDB1O+kGcEkgC5KTwCPa38EdDpe3Z3GCkhlF4bGQm9jwlhfnc4L
         eaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766839; x=1764371639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71gecULlLY4ThXFLJO+sdi9rDjPxaS+h+ctwCXYTDTs=;
        b=mWPp9x0dw1916sK1uNbBOlHDWut5mrF0j8vTzlA7xKu2OzVf93duSVak9jwpOtGoZp
         thdspIA3bUyoW6L2/605UQP09wXrZ7/91BAxUjrjUuedLGES3ibikdh3fK7u6IyawHgP
         ljl7UDNA8hTKfbiaZKCu27Jci5gCu+VTJOcrvYFHEX4mw0k0I7O2ZOhquiy0eAug5x94
         j087yrSxkg7KLq1UeP55H/g6vcExvY89ZkWdpSUfyHu9J6IeCafYRq008rjO5Y0zQ4+C
         FvJ47/Xu5U4mWWCDXAG1Z2/2pkgrBceh/S+nB+U7JReXsXKm0lcUbfwKVNwtabTVaUTJ
         rXPg==
X-Gm-Message-State: AOJu0YwU6ad7xqy5IeugKfy1guA1AaTEYww9Od+R+hozUPOl0ewQwXCa
	DsFLX5Y/pv7frqku1ByFBvRI6ydTQwMX1puoZ7TcjY1DSntrF72rbbwUm3z2yw==
X-Gm-Gg: ASbGnctnycMyhyeu53obEm4CHRAtM0bM8bHJrOq3SPV1Suekx070hfFpF8koGPDJIFO
	u5dFJYQ8VY93W4hmYzOlnzIE9UtamoZpVI/qZUyq8FlsDIBbgDiozrMStwbJ/f/QU0bkeJ2Qf+w
	V0NO48Gm/8oTOLkDPkO6JPWrxfQzzcoddLK70ytFvqVN/YlyYY9CL0+PJ5cI2F8+5ZYD2JEUZnc
	DBZrK0gQvmLyOiveJfH65mrL0m7AqN2G/Esw0AkN3GCaut8gAe0+U3fCj6+ECm+2Vg1Xc7zevan
	ARxJIh/DsmpbTi1RXV/A69DJXPPr+GfX/e/SReujkb/UlT/4jKU7YXP8D17WdnH4ydADC8+6wni
	qxzBKqbXKyEavXi+msJsnQ23iZZzs2ntF5vIykjp/icKD2PP44luiv1hczJDfYGKWaJfrXEnUA7
	cWzdj+JugnTUF0Tw==
X-Google-Smtp-Source: AGHT+IGssc/baUlMqGF6qrGGy1CLv+fx3lEIjjQ0kRIEnAHLWTzQyG/v7YPR/Prhf5esqyRZS5I4rw==
X-Received: by 2002:a05:6a20:2590:b0:34f:2f38:cad9 with SMTP id adf61e73a8af0-36150f34e6emr4854174637.53.1763766839298;
        Fri, 21 Nov 2025 15:13:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b62e95sm7180762b3a.49.2025.11.21.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:13:58 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 5/6] selftests/bpf: Test ambiguous associated struct_ops
Date: Fri, 21 Nov 2025 15:13:51 -0800
Message-ID: <20251121231352.4032020-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121231352.4032020-1-ameryhung@gmail.com>
References: <20251121231352.4032020-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to make sure implicit struct_ops association does not
break backward compatibility nor return incorrect struct_ops.
struct_ops programs should still be allowed to be reused in
different struct_ops map. The associated struct_ops map set implicitly
however will be poisoned. Trying to read it through the helper
bpf_prog_get_assoc_struct_ops() should result in a NULL pointer.

While recursion of test_1() cannot happen due to the associated
struct_ops being ambiguois, explicitly check for it to prevent stack
overflow if the test regresses.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 38 ++++++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        | 75 +++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 1e24a4915524..02173504f675 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
+#include "struct_ops_assoc_reuse.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -65,8 +66,45 @@ static void test_st_ops_assoc(void)
 	struct_ops_assoc__destroy(skel);
 }
 
+static void test_st_ops_assoc_reuse(void)
+{
+	struct struct_ops_assoc_reuse *skel = NULL;
+	int err;
+
+	skel = struct_ops_assoc_reuse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_a,
+					    skel->maps.st_ops_map_a, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops(syscall_prog_a, st_ops_map_a)");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_b,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops(syscall_prog_b, st_ops_map_b)");
+
+	err = struct_ops_assoc_reuse__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/* run syscall_prog that calls .test_1 and checks return */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_a), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_b), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
+	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
+
+out:
+	struct_ops_assoc_reuse__destroy(skel);
+}
+
 void test_struct_ops_assoc(void)
 {
 	if (test__start_subtest("st_ops_assoc"))
 		test_st_ops_assoc();
+	if (test__start_subtest("st_ops_assoc_reuse"))
+		test_st_ops_assoc_reuse();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
new file mode 100644
index 000000000000..caaa45bdccc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define MAP_A_MAGIC 1234
+int test_err_a;
+int recur;
+
+/*
+ * test_1_a is reused. The kfunc should not be able to get the associated
+ * struct_ops and call test_1 recursively as it is ambiguous.
+ */
+SEC("struct_ops")
+int BPF_PROG(test_1_a, struct st_ops_args *args)
+{
+	int ret;
+
+	if (!recur) {
+		recur++;
+		ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(args, NULL);
+		if (ret != -1)
+			test_err_a++;
+		recur--;
+	}
+
+	return MAP_A_MAGIC;
+}
+
+/* Programs associated with st_ops_map_a */
+
+SEC("syscall")
+int syscall_prog_a(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_a++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_a = {
+	.test_1 = (void *)test_1_a,
+};
+
+/* Programs associated with st_ops_map_b */
+
+int test_err_b;
+
+SEC("syscall")
+int syscall_prog_b(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_b = {
+	.test_1 = (void *)test_1_a,
+};
-- 
2.47.3


