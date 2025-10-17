Return-Path: <bpf+bounces-71261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93ABBEBDDF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 23:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8BB1AE283D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47781333421;
	Fri, 17 Oct 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDAxqkRt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003E330B14
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738195; cv=none; b=BX1ENc0Ql2WzYrAiF4LgkWiKjKeG/9I7LgX5LTtuBdSx0Y9Z7rZtoGgyFcFUfcvVgcDt88LbmSIgobnIJ23sCCuxn7+RLOER3s/HwDvZwzukCZovPgnfSmsrkUxZYbkARExydLw3Q6oZ+7Tet7UEqVPWVqpQk9LUecRX6u7KIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738195; c=relaxed/simple;
	bh=ke/nIytaKFzLHKB2rcdj5OjFMh0y4TieMmEtP2B34VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyH+8e5JkkkwPK4dtiCOQcBvBBpzjPdThgeEE0VAqF4K85sMVVRWaR//XnNLWddqgIfF/kt8o3uLNDQagtxrsyx3zsHTxqIWm3i/OH3DXg8NIdUkU6wFLsuQFyyfhK6tWGCwtMHmTn4Tgy+UcwsMKGyaAUMu2CmJoR4cdTIsNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDAxqkRt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2304923b3a.1
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738193; x=1761342993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axJAoxdtPTp0CVbeRD9RIHfj3kPMwawid7xhixQA1zs=;
        b=lDAxqkRtvuz1nrkr8BC3vqNXwKERYeVc5KKJIBbuZTv73iLHjvhKYfMNUDQ1I+CZov
         osIy6VMSxSbDFzCDazVPN2PDcTBQYoXCnT73CZWX11e1v5BoHB5vpdsMKmEtByXgR2ni
         3c2lqyu245jmJoZ/r6sOLeJPqZ/NimN1zU/6cKmG0auBfN8p/lmu/yVBCfbWPmWp5iS2
         qecPW4JgB5erloSfP8APkd9zR4oEawqGhIHLV4i1R0GUfAnzdhw/ER+KB2HlO0LVAUiV
         2SnZY5IM7yYxTL0FigctNwPUgAx0JIZkiee0NlrHnVTETva+xRbiGl63l5UfdWS033jD
         daeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738193; x=1761342993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axJAoxdtPTp0CVbeRD9RIHfj3kPMwawid7xhixQA1zs=;
        b=MOg2EI6l0QdocyflhcRRwvQ058DrqgfMYggO0EWhLMnxKhZyjkmz07iq0JpteFJQ8p
         xY8n6qtL8mnRSSzkcxQDGERYE/Z6sUWeNA2HkKbDA7z+yHCUzCHd4l5MMBNbExGrgsV+
         CWL4nQUusa6yi0vVIJ10gUBOUJ4BfDTmhidnzRZbFOQf7pYAnyf1sR5mtDXBzjDCGMZG
         02PTbRa8no7/4Ci198yT1NNXORURErm6uFvwrBv5REna+0203wQRzJjmPfVEEDndIlp0
         OMVkgG2cdw/uSIvCC+Jys5G8litZwTbR8uU/r8Qlpikau4WBXG74+XjjgJ3HmdwMnfuR
         emxA==
X-Gm-Message-State: AOJu0YzKH/UbHMuETQQBvlB7hOgkdjK69FavTV0lH0CMlWZdAjaqX69E
	P5oLPru3mzDPO+WmpxLH9n7mAOMiJYBWufKfknNSzwUqg+HlNPImsqEudk1b+Q==
X-Gm-Gg: ASbGncsjYHo48xpVeQhUJWiwByHay/nUuO4T1WGi2pu//cDp6BXR+K1Wjl/i+YuAOuW
	D5lT1HKpSJs12v+n7bI6EMpmOciynZFysC3mUK7RB0lgATakc4shnoH/5rLuUvcZH/IsMeNj0G2
	ivURup+0iBqI70toYFomw2UZEswew+dtxvtFiMLxt3FY0vmiPkEY8hs9rg5Nl/3Sl9Dp5lnVNvf
	DZ6+3vN5rU4sQpxu863Zkmyas4dPOjuUgQDCSov2qy3EJV9ZbX6mMKL6XQ0+YwLMHEkNCdNFGik
	uyfhVA80viSdz41sEhlrTCoagvc301OHdtoua5rrs9MMPVoW39EE7+nykoz+p8bYmZBdEAZtCkL
	kGphdZAmLU4decuCEuqJUeYyd0pO9N0apf10BdJcq2KMNhzFhyfsD21gSksCzpG//FA==
X-Google-Smtp-Source: AGHT+IH2B5wNINI3lMc0wTDaSuiJJ59iSl/DK1gpXKcM9DpFStSWmcNi6aw1o06pp8b7Wkc7BFKUsg==
X-Received: by 2002:a05:6a20:4323:b0:2f4:a8f:7279 with SMTP id adf61e73a8af0-334a862e040mr7707477637.54.1760738193166;
        Fri, 17 Oct 2025 14:56:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39442sm626805b3a.20.2025.10.17.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 14:56:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
Date: Fri, 17 Oct 2025 14:56:27 -0700
Message-ID: <20251017215627.722338-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017215627.722338-1-ameryhung@gmail.com>
References: <20251017215627.722338-1-ameryhung@gmail.com>
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
index 6df6475f5dbc..d3c3a8f1e63b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1101,6 +1101,7 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 }
 
 __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
+__bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux_prog);
 
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
@@ -1143,6 +1144,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_prog_arg, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1604,6 +1606,7 @@ static struct bpf_testmod_multi_st_ops *multi_st_ops_find_nolock(u32 id)
 	return NULL;
 }
 
+/* Call test_1() of the struct_ops map identified by the id */
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 {
 	struct bpf_testmod_multi_st_ops *st_ops;
@@ -1619,6 +1622,20 @@ int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
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


