Return-Path: <bpf+bounces-73267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E006C296B9
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C204F4E4148
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0402472BD;
	Sun,  2 Nov 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddK4htx0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFE226CF7
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116726; cv=none; b=H2TnV4NWEcKy/GiqnTztGnR7yPMiASP4LFv+FsryxCEIsg1tpcTbe8SBcboU1LGmj1Q87GD4Rrsd5Me70FGHrU/0jYNpwHtl3ZFWmVYg4e42aTRUIJ0v9VQPCFl1AcCntZ9kKFAWIYB+oJKUbffyX6wJyZs9qWJLPrxZ73S90EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116726; c=relaxed/simple;
	bh=vaNTD14OyGjo30AkMzRk4dwObsUjhPjhHEaG4ZSatX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geDc5fnneq7kjTaeJb9XOfrwv4DFK8JJj/H/8V8gs6G0j5wcRjDh2MxNg/BnB+UdaYrtLEhv/zoegcYU3R2hZusxmNa/YIfGPimwywt7kAnSOUXlcWbuA1DBbxeRw9kFNFB7oSteEzvsfu0ENMxKJjaLrSQY7YM2zwiaNdhqi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddK4htx0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so73522a12.2
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762116721; x=1762721521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbmxxf2c0pVmhEDkU1EqPsAg+oZlSIZMM/oC8G1gWno=;
        b=ddK4htx0UAPCweSBlQ6i4hB1O7xrZpPeol3T0pTd7ragSxJphwkdorib5QcstKpUuu
         vekYnKGszap2lBrKJrZKIZVIr9uYpK4kXEQ4VA6jqo1eNwCj151GEG61MyNip9w30wuo
         Nh+7Hx/RrS89yKmqmlwwE0dgj0c8xx6eNccnzDYyeg+edAhntAM/SQZWtrUKViDyVb88
         Cbd0eFkKZWPN8RzewPOuDsXsYSdbAB54/nL9kQT7psXEVZJGqQsbGn7CWtsKKUJLrIu7
         qF7EwmaATSNVBDDkbTMiyRkeAcDWVSwXTY2Y+Vo/4R83IPwlhc+RbnhznEOxd1ZsSqP6
         7GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762116721; x=1762721521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbmxxf2c0pVmhEDkU1EqPsAg+oZlSIZMM/oC8G1gWno=;
        b=cmmAaj0r9pWiaW2PKqNyIdsWIg81l4/Tgc4KG2qGZ9JWbrBEYDhg1N2lmyiPv5dlUN
         OomE81du1Bubr5fGfdyxyY/Dz7cZVIcY11WOUgIS3BRb8H/AKNllO76xqo04zouBiwPT
         sqOnFa5g4Nv+emq4oL5ntw+vRPF4aHIwgZ6x3knRLk8/Cx71Bb7kUCjNPkWWXLWFHKfj
         iPEpDbjVgGGA1nNsG6C9i60qFUPLaiwJRcaWSZXlRV8SPIDlK09F7kDyXPT0yWJqEL92
         wcFe6NN8YtRd3aE7QHbueWqeDpHVyxE4QLWqwN9kgTd1Mt0pt/UXv40I7DsPMSFVhqoL
         JF+A==
X-Gm-Message-State: AOJu0Yxbw1EAMDPdXIP/lJvrPd3iaa+zq36AduKBkcHYqL4Iywk9xNx/
	YoADaGFN6vV493Jizc/ZbN5QVvY1X4wEj9wacmIJc0vorQvu3W13jsXNiwT3qQ==
X-Gm-Gg: ASbGncv7WcHHw+ofLvlyDPXiElNur7x17pW1IO8t/03X/9879mCKPniVPoe2IArO1a/
	SsGveBXgccN8mbAKQ2+kqIflzVUWbv2btNlzlEmQIu3t7TSA8biNr1lfdZgOh21ZTIOM1n1y8z6
	2w3x0MM3uxhORUBzLIjQXHChUDJ8yxXalMttC2hsEv+RW5/utiN5+f8YcAQMZbdlmECL7q39nJl
	t4ZeEBjZZlI/xHb/JOQCZwMo3z2XNKuJ+xFe4SmH4puVXvRdnkzkezR9ZU2rfeKwo72V/SkdB9+
	hxSMySMzLYsjUFXvd+qfeL5lkntnjYHCCfU/jne98BVWsxUkVEqNABhhEYNDiHyxku5LXuJlf9S
	dX80DWcOZVxbzkamlpBJZYhZoT/A8UVvHY/s3Aw6C+TZrIq281hTCnqgWuejQIqgFUhFToCD9y2
	Rvlvvrss89qJcieniLb1YD5O9tIi7YH0Ux8IIukfTU
X-Google-Smtp-Source: AGHT+IEHDk4VLdI5VY+e9xqlIHFt5I8VqevjQcbPcg7ZKbWfYBGAGfFIgWFg+gdm0ppd6RLydKVo4A==
X-Received: by 2002:a17:907:86a1:b0:b6d:7f07:c015 with SMTP id a640c23a62f3a-b707015bc4amr1038311066b.21.1762116720623;
        Sun, 02 Nov 2025 12:52:00 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71240c245bsm14029566b.10.2025.11.02.12.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:51:59 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v10 bpf-next 10/11] selftests/bpf: add new verifier_gotox test
Date: Sun,  2 Nov 2025 20:57:21 +0000
Message-Id: <20251102205722.3266908-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a set of tests to validate core gotox functionality
without need to rely on compilers.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_gotox.c      | 389 ++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotox.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c0e8ffdaa484..4b4b081b46cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -35,6 +35,7 @@
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
 #include "verifier_gotol.skel.h"
+#include "verifier_gotox.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
@@ -173,6 +174,7 @@ void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
+void test_verifier_gotox(void)                { RUN(verifier_gotox); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
new file mode 100644
index 000000000000..02bee461a072
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Isovalent */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+#ifdef __TARGET_ARCH_x86
+
+#define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
+									\
+	SEC("socket")							\
+	OUTCOME								\
+	__naked void jump_table_ ## NAME(void)				\
+	{								\
+		asm volatile ("						\
+		.pushsection .jumptables,\"\",@progbits;		\
+	jt0_%=:								\
+		.quad ret0_%=;						\
+		.quad ret1_%=;						\
+		.size jt0_%=, 16;					\
+		.global jt0_%=;						\
+		.popsection;						\
+									\
+		r0 = jt0_%= ll;						\
+		r0 += 8;						\
+		r0 = *(u64 *)(r0 + 0);					\
+		.8byte %[gotox_r0];					\
+		ret0_%=:						\
+		r0 = 0;							\
+		exit;							\
+		ret1_%=:						\
+		r0 = 1;							\
+		exit;							\
+	"	:							\
+		: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, (SRC_REG), (OFF) , (IMM))) \
+		: __clobber_all);					\
+	}
+
+/*
+ * The first program which doesn't use reserved fields
+ * loads and works properly. The rest fail to load.
+ */
+DEFINE_SIMPLE_JUMP_TABLE_PROG(ok,                          BPF_REG_0, 0, 0, __success __retval(1))
+DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
+DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
+DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
+
+/*
+ * Gotox is forbidden when there is no jump table loaded
+ * which points to the sub-function where the gotox is used
+ */
+SEC("socket")
+__failure __msg("no jump tables found for subprog starting at 0")
+__naked void jump_table_no_jump_table(void)
+{
+	asm volatile ("						\
+	.8byte %[gotox_r0];					\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+/*
+ * Incorrect type of the target register, only PTR_TO_INSN allowed
+ */
+SEC("socket")
+__failure __msg("R1 has type scalar, expected PTR_TO_INSN")
+__naked void jump_table_incorrect_dst_reg_type(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 8;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	r1 = 42;						\
+	.8byte %[gotox_r1];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r1, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0 , 0))
+	: __clobber_all);
+}
+
+#define DEFINE_INVALID_SIZE_PROG(READ_SIZE, OUTCOME)			\
+									\
+	SEC("socket")							\
+	OUTCOME								\
+	__naked void jump_table_invalid_read_size_ ## READ_SIZE(void)	\
+	{								\
+		asm volatile ("						\
+		.pushsection .jumptables,\"\",@progbits;		\
+	jt0_%=:								\
+		.quad ret0_%=;						\
+		.quad ret1_%=;						\
+		.size jt0_%=, 16;					\
+		.global jt0_%=;						\
+		.popsection;						\
+									\
+		r0 = jt0_%= ll;						\
+		r0 += 8;						\
+		r0 = *(" #READ_SIZE " *)(r0 + 0);			\
+		.8byte %[gotox_r0];					\
+		ret0_%=:						\
+		r0 = 0;							\
+		exit;							\
+		ret1_%=:						\
+		r0 = 1;							\
+		exit;							\
+	"	:							\
+		: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0)) \
+		: __clobber_all);					\
+	}
+
+DEFINE_INVALID_SIZE_PROG(u32, __failure __msg("Invalid read of 4 bytes from insn_array"))
+DEFINE_INVALID_SIZE_PROG(u16, __failure __msg("Invalid read of 2 bytes from insn_array"))
+DEFINE_INVALID_SIZE_PROG(u8,  __failure __msg("Invalid read of 1 bytes from insn_array"))
+
+SEC("socket")
+__failure __msg("misaligned value access off 0+1+0 size 8")
+__naked void jump_table_misaligned_access(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 1;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=16 off=24 size=8")
+__naked void jump_table_invalid_mem_acceess_pos(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 24;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=16 off=-24 size=8")
+__naked void jump_table_invalid_mem_acceess_neg(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 -= 24;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void jump_table_add_sub_ok(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 -= 24;						\
+	r0 += 32;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("writes into insn_array not allowed")
+__naked void jump_table_no_writes(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 8;						\
+	r1 = 0xbeef;						\
+	*(u64 *)(r0 + 0) = r1;					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+#define DEFINE_JUMP_TABLE_USE_REG(REG)					\
+	SEC("socket")							\
+	__success __retval(1)						\
+	__naked void jump_table_use_reg_r ## REG(void)			\
+	{								\
+		asm volatile ("						\
+		.pushsection .jumptables,\"\",@progbits;		\
+	jt0_%=:								\
+		.quad ret0_%=;						\
+		.quad ret1_%=;						\
+		.size jt0_%=, 16;					\
+		.global jt0_%=;						\
+		.popsection;						\
+									\
+		r0 = jt0_%= ll;						\
+		r0 += 8;						\
+		r" #REG " = *(u64 *)(r0 + 0);				\
+		.8byte %[gotox_rX];					\
+		ret0_%=:						\
+		r0 = 0;							\
+		exit;							\
+		ret1_%=:						\
+		r0 = 1;							\
+		exit;							\
+	"	:							\
+		: __imm_insn(gotox_rX, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_ ## REG, 0, 0 , 0)) \
+		: __clobber_all);					\
+	}
+
+DEFINE_JUMP_TABLE_USE_REG(0)
+DEFINE_JUMP_TABLE_USE_REG(1)
+DEFINE_JUMP_TABLE_USE_REG(2)
+DEFINE_JUMP_TABLE_USE_REG(3)
+DEFINE_JUMP_TABLE_USE_REG(4)
+DEFINE_JUMP_TABLE_USE_REG(5)
+DEFINE_JUMP_TABLE_USE_REG(6)
+DEFINE_JUMP_TABLE_USE_REG(7)
+DEFINE_JUMP_TABLE_USE_REG(8)
+DEFINE_JUMP_TABLE_USE_REG(9)
+
+__used static int test_subprog(void)
+{
+	return 0;
+}
+
+SEC("socket")
+__failure __msg("jump table for insn 4 points outside of the subprog [0,10]")
+__naked void jump_table_outside_subprog(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.quad ret_out_%=;					\
+	.size jt0_%=, 24;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 8;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	call test_subprog;					\
+	exit;							\
+	ret_out_%=:						\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void jump_table_contains_non_unique_values(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.quad ret0_%=;						\
+	.quad ret1_%=;						\
+	.size jt0_%=, 80;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 8;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+	ret0_%=:						\
+	r0 = 0;							\
+	exit;							\
+	ret1_%=:						\
+	r0 = 1;							\
+	exit;							\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
+	: __clobber_all);
+}
+
+#endif /* __TARGET_ARCH_x86 */
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


