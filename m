Return-Path: <bpf+bounces-74582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA9C5F807
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBFCF4E4A22
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CF35CB6D;
	Fri, 14 Nov 2025 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxSC7iEU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3F35C1A3
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158670; cv=none; b=fmsbfUh+9A1rzAdkwpyT5IqezO7D3UPsEMQp/g78W4qwUKG6G7Vnabu2p6W/ZZVSFTO6L0WMa/2C1aLcNagxR17IM4lYGhoyYiU0JSLZpntUspWe1ldty6zrNQOxzuuIxS1glv3bb3OJw2uvYtyzzQOiANZUGPY0NmLJLd2bmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158670; c=relaxed/simple;
	bh=FKZjlGrxhCZEcbp3+WZWyC0g+x5cnX3RvQeGrmv2puI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS9PdRefwD7hFchdKolUzo/Uxb0cSF0yt8OeYppT+tIAocSnjOmOdE9OgBJMo854z0zdQwiUGWIAWPJpy73ITX43eQ3/TPHa92VhWG89uFbWvPvgicgx0pEvjMw4/pzwf0+3sQAwBqbyoVY2afBDukl5KGrIkayUdYWJdrmESZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxSC7iEU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1425251b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158667; x=1763763467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM4xaX7bF7o5c8LoVUbC2uJ+2IwlAvm6tZmTYtow6Qw=;
        b=dxSC7iEU8yKZxMLz2XA+a0QaoP3nQyx9vBBf4+1EwnUQixoZhuUTpYDeMmX6kciBKe
         xAgFyEzQqT1lG259z98jT8X/qXfCxYSwN0GnI5FLO56XgazAt2eMkquHQupHFBVlH1qm
         OdEOYXEaoKeyi9hA3dnUQ8E0VoOIfuOpY5FN0KqNzAkyDktw99gBAsctGkSBT++A3EWa
         /2DzuIxUsV0rk8DMZU6yaiUcwBSN58es/z8KbZ6PAyMyYmVX2TWalPqlutjwhA7npsdk
         4hDQqlt3/GX5PZUjU3VPbZ3AJtE4H2vi6anaU4f2fwojE77MevRGP744pvDTE8Trx3br
         C9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158667; x=1763763467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HM4xaX7bF7o5c8LoVUbC2uJ+2IwlAvm6tZmTYtow6Qw=;
        b=dYnRy6vqbE4Vi3DGvtzrxZ5yxC2xWkoN3JZU5EFdc0XTcj2qiGVQDTMyiX6ZXDyCzY
         NmpOC2lMa6nZrxeNbF0+5Ux2XAvOfy9/dTiQhde/f6EMizeesruTXMnh4zPK339vONHH
         aW/a/1Q+aeDeaqcwpxRTDDIuQ9LvxV2Zbct1bg66GTA2RMyyT8rm4koDsFFefp2Y9/R7
         9ximyBZT1Z4fuW7uVUDZSuFFW+4R3Wc8ahGI/qfRkZm4eOQFftPBmM9RKGs3PTfh8PW0
         J68ePwK4foSnlS0rp3UtMXFBBfA/CZDDp7/PB9pPWDjeP8H3AGTeLJLcZRnlrq3ZhKn2
         hixw==
X-Gm-Message-State: AOJu0YyGtqydpwnvFwQA61LKHM6nHwH06XGpCnhAddUTO3286+sS0l09
	ToUCbLQGAdVIERnTj0RKx9gfSVhHFjT4NpP8N/QBVD2Wa/4xkZhpo8FsicCm9Q==
X-Gm-Gg: ASbGnctAl8HnyHAuBuYaFMMb4wBGP+R4twjfQxf1IshQbGti6pdy7yyif9NkvIySJ2L
	zxtEq/4ox8QG6n9TG+AfLYVYz3qFpNd/5NO9mBtGwuHB1DhWXbDk69EDgS8m4nfChqDIM9YntX0
	p68Y/4s8K0dxmnQoNDydHh0OkgO3A2vexMhjMV8eT+CYe4Xcing0eKfLlMLFY6yyC3JFwVXvv9r
	wIrUX1EKkD2k8Xl/xLA4O4OWff3CZfk34laNzGESWnJJivDJjzzx5Ubo9j96AmiJvuwyUzAKaxO
	b+ZgQK5Zq2Yk2r1o7+2cWXVTPts/cZkp66Q6DXNj4sbiBvcmiMPg0YNmasnMCHs6shUX+V4SbMj
	veew+USZvExRMtwUZokK4gAFqOjeZk6Ow9Z7Ljps9F5P+Gaz+Eu8W7jxxIkgkWrm6GMw+hBMU1z
	GoiDI=
X-Google-Smtp-Source: AGHT+IGft2MjKFCUGD3i6/nQwrRzf5rmwW6A4ZeXUNccmNlQG0+58FOFOyFPWLOLUBfKz9oZ8ByfEg==
X-Received: by 2002:a05:6a00:2345:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-7ba328d4f94mr5599456b3a.5.1763158667204;
        Fri, 14 Nov 2025 14:17:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9e3f288b1sm4405805b3a.7.2025.11.14.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:46 -0800 (PST)
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
Subject: [PATCH bpf-next v6 4/6] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
Date: Fri, 14 Nov 2025 14:17:39 -0800
Message-ID: <20251114221741.317631-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test BPF_PROG_ASSOC_STRUCT_OPS command that associates a BPF program
with a struct_ops. The test follows the same logic in commit
ba7000f1c360 ("selftests/bpf: Test multi_st_ops and calling kfuncs from
different programs"), but instead of using map id to identify a specific
struct_ops, this test uses the new BPF command to associate a struct_ops
with a program.

The test consists of two sets of almost identical struct_ops maps and BPF
programs associated with the map. Their only difference is the unique
value returned by bpf_testmod_multi_st_ops::test_1().

The test first loads the programs and associates them with struct_ops
maps. Then, it exercises the BPF programs. They will in turn call kfunc
bpf_kfunc_multi_st_ops_test_1_prog_arg() to trigger test_1() of the
associated struct_ops map, and then check if the right unique value is
returned.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  72 ++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 4 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
new file mode 100644
index 000000000000..29e8b58a14fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_assoc.skel.h"
+
+static void test_st_ops_assoc(void)
+{
+	struct struct_ops_assoc *skel = NULL;
+	int err, pid;
+
+	skel = struct_ops_assoc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc__open"))
+		goto out;
+
+	/* cannot explicitly associate struct_ops program */
+	err = bpf_program__assoc_struct_ops(skel->progs.test_1_a,
+					    skel->maps.st_ops_map_a, NULL);
+	ASSERT_ERR(err, "bpf_program__assoc_struct_ops");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_a,
+					    skel->maps.st_ops_map_a, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_a,
+					    skel->maps.st_ops_map_a, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_b,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_b,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	/* sys_enter_prog_a already associated with map_a */
+	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_a,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_ERR(err, "bpf_program__assoc_struct_ops");
+
+	err = struct_ops_assoc__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/* run tracing prog that calls .test_1 and checks return */
+	pid = getpid();
+	skel->bss->test_pid = pid;
+	sys_gettid();
+	skel->bss->test_pid = 0;
+
+	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
+	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
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
+	struct_ops_assoc__destroy(skel);
+}
+
+void test_struct_ops_assoc(void)
+{
+	if (test__start_subtest("st_ops_assoc"))
+		test_st_ops_assoc();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
new file mode 100644
index 000000000000..fe47287a49f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
@@ -0,0 +1,105 @@
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
+int test_pid;
+
+/* Programs associated with st_ops_map_a */
+
+#define MAP_A_MAGIC 1234
+int test_err_a;
+
+SEC("struct_ops")
+int BPF_PROG(test_1_a, struct st_ops_args *args)
+{
+	return MAP_A_MAGIC;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter_prog_a, struct pt_regs *regs, long id)
+{
+	struct st_ops_args args = {};
+	struct task_struct *task;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_a++;
+
+	return 0;
+}
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
+#define MAP_B_MAGIC 5678
+int test_err_b;
+
+SEC("struct_ops")
+int BPF_PROG(test_1_b, struct st_ops_args *args)
+{
+	return MAP_B_MAGIC;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter_prog_b, struct pt_regs *regs, long id)
+{
+	struct st_ops_args args = {};
+	struct task_struct *task;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_B_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC("syscall")
+int syscall_prog_b(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_B_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_b = {
+	.test_1 = (void *)test_1_b,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 8074bc5f6f20..f45258202997 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1108,6 +1108,7 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 }
 
 __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
+__bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux_prog);
 
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
@@ -1150,6 +1151,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_prog_arg, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1611,6 +1613,7 @@ static struct bpf_testmod_multi_st_ops *multi_st_ops_find_nolock(u32 id)
 	return NULL;
 }
 
+/* Call test_1() of the struct_ops map identified by the id */
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 {
 	struct bpf_testmod_multi_st_ops *st_ops;
@@ -1626,6 +1629,20 @@ int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 	return ret;
 }
 
+/* Call test_1() of the associated struct_ops map */
+int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux__prog)
+{
+	struct bpf_prog_aux *prog_aux = (struct bpf_prog_aux *)aux__prog;
+	struct bpf_testmod_multi_st_ops *st_ops;
+	int ret = -1;
+
+	st_ops = (struct bpf_testmod_multi_st_ops *)bpf_prog_get_assoc_struct_ops(prog_aux);
+	if (st_ops)
+		ret = st_ops->test_1(args);
+
+	return ret;
+}
+
 static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_multi_st_ops *st_ops =
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 4df6fa6a92cb..d40f4cddbd1e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -162,5 +162,6 @@ struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
 int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
 
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
+int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux__prog) __ksym;
 
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.47.3


