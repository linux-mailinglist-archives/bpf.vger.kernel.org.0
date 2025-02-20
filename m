Return-Path: <bpf+bounces-52104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6DA3E684
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58C13B4CCF
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051E1EDA37;
	Thu, 20 Feb 2025 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mez5n8q8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1F1E571F
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086747; cv=none; b=geeuEe+CShz0vWNfi01TKC1W0st97shPPoyY4Rs+bbAPiS7jUnw62F6gv56Jr0bQpglgr7ZyeIrH2Tbqp32N0pm5oWSFjC7BTA8L1jM8cgIsZDKIRAmFdIZ2H/K/7bHz3t9MZ8riofjcnx6nD67xK+fTZAmopMeq78dAp8s/diA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086747; c=relaxed/simple;
	bh=vMnPESJfHGNt1Gj9N7yHxVSqN+V1FY0M0EJ87CHpSNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgNHAREv6lNzI3Cqmi7yb9odZZ9ROM3/bIbiANIut4PSQjhHJrTTD+BURiPfTL6AJNizxExW6gtj15RBU2wRK9xHKdYQK1QEaWXbinaAKEng2tXMFkDOOnU/onXWQHXC8j13tkZsSO8TYPZCP4y1e1BrHvUQuNRNQ5xoGwY1n/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mez5n8q8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2225775a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 13:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740086743; x=1740691543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaGLztfh2fP6mgWri7vLULlHzC9G6rgKmlVZeWoNlvA=;
        b=mez5n8q8w1CFqLRJXLwUkyBmZzR+M+c66p3IhpZbG1yE1bGvarcUUnSESTuUrTWQLF
         wFd26708OkTgF3wJ3hVO6TaJ7k1fmTd3x+J7OZjs6NMCl15c8KicUmKamuHexSttONef
         189VeGf5FPYxJDNY78sOKNH8dd+zh2nkUWQTWpr/VjX1YcFnW6hyvOz1syuy7QP/Anxx
         xNBPMi74K4RqZo9x71rQFIakKx4+cGfEqDOe2xn0B4KWTJ5MOnLBuV1Z1QM4gcoiVbDQ
         k8ffyolBsUT3oVcC+XhqJmGrIcYitYUMGiy5ZPO91Vc7g+jOMSvJ3GDvSzP4a0T224+r
         GeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086743; x=1740691543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaGLztfh2fP6mgWri7vLULlHzC9G6rgKmlVZeWoNlvA=;
        b=rMlsrQdE7KKyPJze7xEwrbjFNRWQgFlguhN61iexFPEE0EmqApml5stDDs4jAvOWxC
         uWfeJ7ECiwg6YoYyB1nfhfo+CgNkiT6lahYSnsrr81MkKesJvBfolIgoxNjgaFJhHffZ
         M+cRgauL6hMh8MWfnpeP+TsENVeEB9kvxcXiEGC/gb8MzasC25hqBXShbgUVVNmI6Aw7
         cqIkwFQJMLCIf3+ea6eIyMBjVQCx/78Ja3tOmfqLL1jg43bgRpMIa0qgLmjwdiZRC7K1
         7OFm2sW0VW1G4I4bIGb8Ped0bKmDg92WgECXaIT6AzkhiNOmRaJvOPWqmWl3KZQJ1OnI
         1CeQ==
X-Gm-Message-State: AOJu0YwZnNRfyPSM20Ssf0w8MTe8+nvmv0q9bo0+pLtqLLP0kF2qN4yY
	ZC49HScjZuE6trt/wix2iaselC5G+ebllpEQkZn1x2SRxoKwskPOQ4+Z3g==
X-Gm-Gg: ASbGncupwpv9ebXEftDO9t+kIisX3EGpK5Cp1QCODuBhwcZ35W3KpPCVc0ECTvGKQ0F
	I8hTLk1XS5BzaCZ8un2XzCZkKuXvqMefq1VoKdMkD5THZ7Fyx/+lD2NFnvymrzqwvf0DUkWAfPa
	D3g2c6m2HuAapx38XfKPPuSXy8Ias8+1nKPD2Lwr3suuHKKTWBddMd3Fr5SbSqlCxS4R9ktAx8B
	9kXSS7ni+EETxUCPG3n6V8EeL4RCeptOT3UrYifrCZBqjGgtK23PoapULZxfgF1d93ciz9LN4Hc
	FHfHubscIOXChMWnVLTi3ubKNKV9hXw5yVxjeO/r2loMg6brwQvW0/AhhQRu5Fkd7g==
X-Google-Smtp-Source: AGHT+IFsj2+wFS+8EoNZIvaSagUkV3lYYkzp3GYfRK3O60oaHmTLaV22vqGDNZ8n1Z/qYGaAlziIig==
X-Received: by 2002:a17:90b:1f81:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2fce7b11203mr1133048a91.27.1740086742693;
        Thu, 20 Feb 2025 13:25:42 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d046sm126107795ad.114.2025.02.20.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:25:42 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue that generate kfuncs
Date: Thu, 20 Feb 2025 13:25:32 -0800
Message-ID: <20250220212532.783859-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220212532.783859-1-ameryhung@gmail.com>
References: <20250220212532.783859-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test gen_prologue and gen_epilogue that generate kfuncs that have not
been seen in the main program.

The main bpf program and return value checks are identical to
pro_epilogue.c introduced in commit 47e69431b57a ("selftests/bpf: Test
gen_prologue and gen_epilogue"). However, now when bpf_testmod_st_ops
detects a program name with prefix "test_kfunc_", it generates slightly
different prologue and epilogue: They still add 1000 to args->a in
prologue, add 10000 to args->a and set r0 to 2 * args->a in epilogue,
but involve kfuncs.

At high level, the alternative version of prologue and epilogue look
like this:

  cgrp = bpf_cgroup_from_id(0);
  if (cgrp)
          bpf_cgroup_release(cgrp);
  else
          /* Perform what original bpf_testmod_st_ops prologue or
           * epilogue does
           */

Since 0 is never a valid cgroup id, the original prologue or epilogue
logic will be performed. As a result, the __retval check should expect
the exact same return value.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/filter.h                        |  10 +
 kernel/bpf/btf.c                              |   1 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |   2 +
 .../bpf/progs/pro_epilogue_with_kfunc.c       | 182 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  90 +++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..3ed6eb9e7c73 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -469,6 +469,16 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = BPF_CALL_IMM(FUNC) })
 
+/* Kfunc call */
+
+#define BPF_CALL_KFUNC(OFF, IMM)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_CALL,			\
+		.dst_reg = 0,					\
+		.src_reg = BPF_PSEUDO_KFUNC_CALL,		\
+		.off   = OFF,					\
+		.imm   = IMM })
+
 /* Raw code statement block */
 
 #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)			\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6c296ff551e0..ddebab05934f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 	spin_unlock_bh(&btf_idr_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_find_btf_id);
 
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id)
diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 509883e6823a..5d3c00a08a88 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -6,6 +6,7 @@
 #include "epilogue_tailcall.skel.h"
 #include "pro_epilogue_goto_start.skel.h"
 #include "epilogue_exit.skel.h"
+#include "pro_epilogue_with_kfunc.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -55,6 +56,7 @@ void test_pro_epilogue(void)
 	RUN_TESTS(pro_epilogue);
 	RUN_TESTS(pro_epilogue_goto_start);
 	RUN_TESTS(epilogue_exit);
+	RUN_TESTS(pro_epilogue_with_kfunc);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
new file mode 100644
index 000000000000..c8fc31c4c3c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+void __kfunc_btf_root(void)
+{
+	bpf_kfunc_st_ops_inc10(NULL);
+}
+
+static __noinline __used int subprog(struct st_ops_args *args)
+{
+	args->a += 1;
+	return args->a;
+}
+
+__success
+/* prologue */
+__xlated("0: r8 = r1")
+__xlated("1: r1 = 0")
+__xlated("2: call kernel-function")
+__xlated("3: if r0 != 0x0 goto pc+5")
+__xlated("4: r6 = *(u64 *)(r8 +0)")
+__xlated("5: r7 = *(u64 *)(r6 +0)")
+__xlated("6: r7 += 1000")
+__xlated("7: *(u64 *)(r6 +0) = r7")
+__xlated("8: goto pc+2")
+__xlated("9: r1 = r0")
+__xlated("10: call kernel-function")
+__xlated("11: r1 = r8")
+/* main prog */
+__xlated("12: r1 = *(u64 *)(r1 +0)")
+__xlated("13: r6 = r1")
+__xlated("14: call kernel-function")
+__xlated("15: r1 = r6")
+__xlated("16: call pc+1")
+__xlated("17: exit")
+SEC("struct_ops/test_prologue")
+__naked int test_kfunc_prologue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+__success
+/* save __u64 *ctx to stack */
+__xlated("0: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("1: r1 = *(u64 *)(r1 +0)")
+__xlated("2: r6 = r1")
+__xlated("3: call kernel-function")
+__xlated("4: r1 = r6")
+__xlated("5: call pc+")
+/* epilogue */
+__xlated("6: r1 = 0")
+__xlated("7: call kernel-function")
+__xlated("8: if r0 != 0x0 goto pc+6")
+__xlated("9: r1 = *(u64 *)(r10 -8)")
+__xlated("10: r1 = *(u64 *)(r1 +0)")
+__xlated("11: r6 = *(u64 *)(r1 +0)")
+__xlated("12: r6 += 10000")
+__xlated("13: *(u64 *)(r1 +0) = r6")
+__xlated("14: goto pc+2")
+__xlated("15: r1 = r0")
+__xlated("16: call kernel-function")
+__xlated("17: r0 = r6")
+__xlated("18: r0 *= 2")
+__xlated("19: exit")
+SEC("struct_ops/test_epilogue")
+__naked int test_kfunc_epilogue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+__success
+/* prologue */
+__xlated("0: r8 = r1")
+__xlated("1: r1 = 0")
+__xlated("2: call kernel-function")
+__xlated("3: if r0 != 0x0 goto pc+5")
+__xlated("4: r6 = *(u64 *)(r8 +0)")
+__xlated("5: r7 = *(u64 *)(r6 +0)")
+__xlated("6: r7 += 1000")
+__xlated("7: *(u64 *)(r6 +0) = r7")
+__xlated("8: goto pc+2")
+__xlated("9: r1 = r0")
+__xlated("10: call kernel-function")
+__xlated("11: r1 = r8")
+/* save __u64 *ctx to stack */
+__xlated("12: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("13: r1 = *(u64 *)(r1 +0)")
+__xlated("14: r6 = r1")
+__xlated("15: call kernel-function")
+__xlated("16: r1 = r6")
+__xlated("17: call pc+")
+/* epilogue */
+__xlated("18: r1 = 0")
+__xlated("19: call kernel-function")
+__xlated("20: if r0 != 0x0 goto pc+6")
+__xlated("21: r1 = *(u64 *)(r10 -8)")
+__xlated("22: r1 = *(u64 *)(r1 +0)")
+__xlated("23: r6 = *(u64 *)(r1 +0)")
+__xlated("24: r6 += 10000")
+__xlated("25: *(u64 *)(r1 +0) = r6")
+__xlated("26: goto pc+2")
+__xlated("27: r1 = r0")
+__xlated("28: call kernel-function")
+__xlated("29: r0 = r6")
+__xlated("30: r0 *= 2")
+__xlated("31: exit")
+SEC("struct_ops/test_pro_epilogue")
+__naked int test_kfunc_pro_epilogue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__retval(1011) /* PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] */
+int syscall_prologue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_prologue(&args);
+}
+
+SEC("syscall")
+__retval(20022) /* (KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_epilogue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(22022) /* (PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_pro_epilogue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_with_kfunc = {
+	.test_prologue = (void *)test_kfunc_prologue,
+	.test_epilogue = (void *)test_kfunc_epilogue,
+	.test_pro_epilogue = (void *)test_kfunc_pro_epilogue,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 89dc502de9d4..ecf2ef073fee 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1308,6 +1308,83 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 	return 0;
 }
 
+static int bpf_cgroup_from_id_id;
+static int bpf_cgroup_release_id;
+
+static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
+					  const struct bpf_prog *prog)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	/* r8 = r1; // r8 will be "u64 *ctx".
+	 * r1 = 0;
+	 * r0 = bpf_cgroup_from_id(r1);
+	 * if r0 != 0 goto pc+5;
+	 * r6 = r8[0]; // r6 will be "struct st_ops *args".
+	 * r7 = r6->a;
+	 * r7 += 1000;
+	 * r6->a = r7;
+	 * goto pc+2;
+	 * r1 = r0;
+	 * bpf_cgroup_release(r1);
+	 * r1 = r8;
+	 */
+	*insn++ = BPF_MOV64_REG(BPF_REG_8, BPF_REG_1);
+	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
+	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 5);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_8, 0);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 1000);
+	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
+	*insn++ = prog->insnsi[0];
+
+	return insn - insn_buf;
+}
+
+static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
+					  s16 ctx_stack_off)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	/* r1 = 0;
+	 * r0 = bpf_cgroup_from_id(r1);
+	 * if r0 != 0 goto pc+6;
+	 * r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
+	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
+	 * r6 = r1->a;
+	 * r6 += 10000;
+	 * r1->a = r6;
+	 * goto pc+2
+	 * r1 = r0;
+	 * bpf_cgroup_release(r1);
+	 * r0 = r6;
+	 * r0 *= 2;
+	 * BPF_EXIT;
+	 */
+	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
+	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 6);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 10000);
+	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
+	*insn++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
+	*insn++ = BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, 2);
+	*insn++ = BPF_EXIT_INSN();
+
+	return insn - insn_buf;
+}
+
+#define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
 static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 			       const struct bpf_prog *prog)
 {
@@ -1317,6 +1394,9 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
+	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
+		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
+
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;
 	 * r7 += 1000;
@@ -1340,6 +1420,9 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
+	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
+		return st_ops_gen_epilogue_with_kfunc(insn_buf, prog, ctx_stack_off);
+
 	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
 	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
 	 * r6 = r1->a;
@@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, struct bpf_link *link)
 
 static int st_ops_init(struct btf *btf)
 {
+	struct btf *kfunc_btf;
+
+	bpf_cgroup_from_id_id = bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIND_FUNC, &kfunc_btf);
+	bpf_cgroup_release_id = bpf_find_btf_id("bpf_cgroup_release", BTF_KIND_FUNC, &kfunc_btf);
+	if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.47.1


