Return-Path: <bpf+bounces-52594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24DBA450F8
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 00:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF533169E16
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC012397BE;
	Tue, 25 Feb 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyhW4p9u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608E19DF8B
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526558; cv=none; b=cdTedN7JcHQrMqChlUK5A6JfAOLdzUX6l509V/Nu6J3qU09E0RvKkEINPIMuEGJeC/IkKv4EtJXMD7G86FKlWsOPBVtzS4VHvD/+D/Vs9cLJUtDugf/XKFjoayduiKeKS/BD8kNzO37iXDJ1TTBR5HZMHD/cukJGxPbO6iq9844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526558; c=relaxed/simple;
	bh=Td1aSqY2PTeujWms+T0V6f5aXepUrny5Yle1bnU0wAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3hJPo6rG29E7Ncni9WSdzTmhofMH0D4he7cDn59alaJvwR5oiNM7c+2bwGPhM/vp96rOEm37jkTOQLW8Ogu/oCaK7rgLXOV05kMmXLdTTMkV04NyAvJVrLrd5hM7S14XP0RUkOEAUzEsh8l6Y+iRCXD1/+7djX/VAYcNIxkfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyhW4p9u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221206dbd7eso129015505ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 15:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526556; x=1741131356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++M5yc13uI0CKPja2bQmYPIOMe2UuAQ2B7FBFPYx7xU=;
        b=ZyhW4p9uwPaFoloFV3uuA498AyyuauiaTNy2Kk4g2+DL/ylRxAopl/UmG1GpPCp3hD
         j7tsPtfSGIUke/CWnHCHhJ7Jkdyas7M+HAmPEoOy8a16NM0CkOzHoW/8a07sqkhWWfJy
         S9yHEVsAJeEPHd3P0b12dN9yHY36yNku8jEP8KhlAOSqRjRVJdY+VqK/4o9PePYqlrQi
         njTzfYxhSrSN4vhhdNtnxyshwYEqxgXlGrhtTPihItJFaSgDw91rNRfi7kUotks11Pmq
         Ukt0S2LxfeNJ03LOnL8O9a8k2WIRFS7gZoyd49UyofGoZtEMyuO2nfvk4ITLEikEJWig
         KXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526556; x=1741131356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++M5yc13uI0CKPja2bQmYPIOMe2UuAQ2B7FBFPYx7xU=;
        b=hAKui9pBNfdn3N83x4hK2bECQsaHgT16Cvf+ulDMGqmpu/oGUCdIfaxEUHmqp/t/79
         GR1JSDoH71i/yQebg+M7nOn/m9rU80JKN5MAKRcTWdvFnWk2vfjgiy2MdiPwir4TMZld
         +UMSU2/XgWsqaxNxn/wqgww6heOkDrCfeThCSjBkn3+7FuShS44yaKLq2yRvp+Tq8JZK
         /x+PN512NraxJlAube1P2GdcJKT/eyVHjhRqT4d2Cgs7wNFyrmYtyxebq8tbBdLXNn3j
         iTgn34NtxHNlmhlvMO96q2ptUpwOgDOdO7514kE2ovhvbjdDS84l57+gBBN4UwM7/u+u
         +Pog==
X-Gm-Message-State: AOJu0Ywl1WKsTN/mAKu1yE4wvKIdysfcrQJL96Gqj6s4j9XBluBZx2TP
	nCp68dxe+HYQ41oYx3bcz03oOJYOnY50wsaGDWlbBAb4mpMFRmP7U0dolw==
X-Gm-Gg: ASbGnctosAB2ALvveshtfNYXJkrZP0Tj27WZmpAG0cd8pjN6fx2Ss5inj+jcvklMNK6
	0bBXhYg9BBrX2/h2e7KWcB3F6zkvRuReW6lZ1VF2AjlszJcgCSBj9w684RopZMV454cC5lz01u1
	ZYLdGX0+vQushdP7MeIxCH/jeymmRwBv0IlEf7+8BhCCbH7whyZkqV50Gs3ctPJCvQYYydYgF/A
	38cz6erGoMEvCfbWBcw/FvqNuKKqcIZTbRheAS56EjNarV52ilcxI4LhAzcmygnB4eSamIknnaR
	XFKi73ac40c8BlPounJ5/CmntMQBUhw8ugvQ4Lfazajm2rzAdisuc0afpVFXeBT/0/+ux8oLQ37
	h
X-Google-Smtp-Source: AGHT+IGcp02fXmMD4vlBO3KrParhXCeW5eog2rhg5I732gsh2ScV+pQH+P+fPcAzCnljmn8MybcwmA==
X-Received: by 2002:a05:6a20:7f9a:b0:1ee:ce0a:532a with SMTP id adf61e73a8af0-1f10acf5f9emr1835252637.4.1740526555792;
        Tue, 25 Feb 2025 15:35:55 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81c589sm2167527b3a.135.2025.02.25.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:35:55 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Test gen_pro/epilogue that generate kfuncs
Date: Tue, 25 Feb 2025 15:35:45 -0800
Message-ID: <20250225233545.285481-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225233545.285481-1-ameryhung@gmail.com>
References: <20250225233545.285481-1-ameryhung@gmail.com>
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
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/filter.h                        | 10 ++
 kernel/bpf/btf.c                              |  1 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  2 +
 .../bpf/progs/pro_epilogue_with_kfunc.c       | 88 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 92 +++++++++++++++++++
 5 files changed, 193 insertions(+)
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
index 7a7e02dcde84..1927d7e53b5a 100644
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
index 000000000000..a5a8f08ac8fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
@@ -0,0 +1,88 @@
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
+__xlated("19: r6 = 0")
+__xlated("20: call kernel-function")
+__xlated("21: if r0 != 0x0 goto pc+6")
+__xlated("22: r1 = *(u64 *)(r10 -8)")
+__xlated("23: r1 = *(u64 *)(r1 +0)")
+__xlated("24: r6 = *(u64 *)(r1 +0)")
+__xlated("25: r6 += 10000")
+__xlated("26: *(u64 *)(r1 +0) = r6")
+__xlated("27: goto pc+2")
+__xlated("28: r1 = r0")
+__xlated("29: call kernel-function")
+__xlated("30: r0 = r6")
+__xlated("31: r0 *= 2")
+__xlated("32: exit")
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
+	.test_pro_epilogue = (void *)test_kfunc_pro_epilogue,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 578bfc40dd05..3220f1d28697 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1309,6 +1309,85 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
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
+	 * r6 = 0;
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
+	*insn++ = BPF_MOV64_IMM(BPF_REG_6, 0);
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
@@ -1318,6 +1397,9 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
+	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
+		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
+
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;
 	 * r7 += 1000;
@@ -1341,6 +1423,9 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
+	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
+		return st_ops_gen_epilogue_with_kfunc(insn_buf, prog, ctx_stack_off);
+
 	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
 	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
 	 * r6 = r1->a;
@@ -1411,6 +1496,13 @@ static void st_ops_unreg(void *kdata, struct bpf_link *link)
 
 static int st_ops_init(struct btf *btf)
 {
+	struct btf *kfunc_btf;
+
+	bpf_cgroup_from_id_id = bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIND_FUNC, &kfunc_btf);
+	bpf_cgroup_release_id = bpf_find_btf_id("bpf_cgroup_release", BTF_KIND_FUNC, &kfunc_btf);
+	if (bpf_cgroup_from_id_id < 0 || bpf_cgroup_release_id < 0)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.47.1


