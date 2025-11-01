Return-Path: <bpf+bounces-73236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F1C27C64
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919C53BC575
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE682F2909;
	Sat,  1 Nov 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxEADMqi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE762F28F2
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994880; cv=none; b=g/yyjQQlD7Z+Ur3YHng19cxf76aP+WchPIxIdUGcPdP2J60qAiJzviDMVJcawzkgtN9VtxbAUhZHyRqCqxy6pt4O6crD+FJoCbSjYi/I2EHdaqda4Z+Wb00jUr7VJxO577voNDVnrDbYWQWNMKE9w369sEECJtdIM4/IzmMF0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994880; c=relaxed/simple;
	bh=CtNlnOAucmkcnQCgmVDaGj1X4DvJ04vVByQp8SY48TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qT9j0E8EIA5kYgkXtkQ4oXP47P6dLVu+cIugWkUWCmMi0d9Z/slLwLYhOcJgbNOF2EJ/SFbAb6jrPrktqLR1p+Z79OpaibiXutjSKSTwq8SjZ27RHI3OTjkjzRMuhimKxkUOIaVrI24BE3hDuyVfe5X+YGcAhcFrolgq3uTS3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxEADMqi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4771b03267bso20362745e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994876; x=1762599676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6JgHKnk2KCa8JITpxKOKHSwgzgulL4aQAtqByyi7T4=;
        b=dxEADMqi/pvhL2CUjUZcEDKNvBiVXx1mRyRw2OsnQN9m+TpKimTCAv0pYPqtepbErr
         HT1j8yYnhG8tLnMxW2sqWpUTn/vgv6NgFRTVac08542ooiHxjUKUBSYpodF7semgHlZt
         wBqf1iqvTZ0CvCCYciD/5ewpsLJbQbFx0vw5gBXOZPAXn+yA3jimoGON4CYdwDZKzRaD
         gjvlYyN0nMPLH+UkZjOK1QSpCKQhOQHEdJgf4vdUKYdG6lDPEZ2ksRXR6nCwu8LdxX/z
         OPFa9REsx3Kt950HObrO9eSfirE7zZWuop1lZpAlrFIeNdlN3UTUG0Ji0PFkM7SrOxMn
         nHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994876; x=1762599676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6JgHKnk2KCa8JITpxKOKHSwgzgulL4aQAtqByyi7T4=;
        b=clS18HATQFyUSU84SMbQ73dkTpuk3ye4LoiEavET1Rt7xOXnIkOcVqE5xbL3qCyLcS
         ZQ/0bOEThQljl75fAHE5Tv9lfHKBrnEMp8uvJiVAwfYPzSoTq25b4lJfRLCp97lz5PEi
         0VZO2WllLnTqL+jjz62fnqLsHKzM+BoWwzfE+T5OhXzeUYzqNMuCxzwHqL19uTQNO2up
         6bx9L76A5hIlV+vdScA8/AY5LlFgP9WIUUqezPo2qbzARm0FtLImDOXsHr71cJ2PMWF7
         1weqDRpu/u/j0qWMUW1k8WQ3IDQnFCgq5wabAB9SeOoiLwNR0in8kUecPq1RvFWnY4Zj
         1wZQ==
X-Gm-Message-State: AOJu0YxKFGQuiGzHy4zjUxZBdEZQ2muA1OjheDnAtqAEhJDj1HLSq0sd
	jXXKFEEwqULKkGrKZkA7f/TRn1EeeW+rW/4doZ5A5l18H/rmABDSVrqVlrdLzA==
X-Gm-Gg: ASbGnctX0lUgfGuuoOjtrrDVoWHL6XD1w4/a+7nEtKljaj1cQ55DuHJTnBnrlS2OFAZ
	7M1Q9rlDon6/RPrXOtj6TqAVE80ndRKdKuAt1ROqYX5TpsOeIfxUtRyMw6Ip1+axn6icfBBOUmV
	gi4mRMwGbjt7dbkNTzj3ra9RFquou64AZ7GJVhzcDcNO5g4QiZOUCtgiJuKJ/60wN6QKD0GHUcf
	fQF/ceTZI8ZfChnou/mN41Ly9qycW+wBL7JqV8Nr1Y5XEuRA5F9UeQNknxrdKEllLNL2g7hdtgF
	mo/f3w3fWqt7ThuRWPSOqlvo1GU+qFX0YiaLpjWrw3YDLeb+QR/AD9EgEXe2/gGwrgJ0ZRmhPQq
	ujub7/y2M4moC/BT3b1I8WOg6BNizDNi1xOpkadIboxAa8oz8Ndoxj48wzKkDkSHRM3SwHOqHog
	5OlsTRTmHoKhubwbyAwDkqiHQvJpkY5A==
X-Google-Smtp-Source: AGHT+IFcQZu4nIb2zB1rtCK4AswFY4fd+VqjRPaq7U7eqrhBU7rZElJGLGuQSVhPKahqGAuRALni7g==
X-Received: by 2002:a05:600c:1c93:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-47730794401mr58548185e9.4.1761994875861;
        Sat, 01 Nov 2025 04:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:14 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 10/11] selftests/bpf: add new verifier_gotox test
Date: Sat,  1 Nov 2025 11:07:16 +0000
Message-Id: <20251101110717.2860949-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/progs/verifier_gotox.c      | 353 ++++++++++++++++++
 2 files changed, 355 insertions(+)
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
index 000000000000..a1d00a1b4d24
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -0,0 +1,353 @@
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
+#endif /* __TARGET_ARCH_x86 */
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


