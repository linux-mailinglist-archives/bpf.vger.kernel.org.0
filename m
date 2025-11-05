Return-Path: <bpf+bounces-73598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EDC34AA4
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20B364FDC0C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956902F12AC;
	Wed,  5 Nov 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8hiUjRo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E72EA479
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333093; cv=none; b=Qza+hXZeLz/OhhZLPRN7UOPD3c9ms2tQ+LAa+AP2iZh3MmaeCgM2neogvjq6VLQ69f+jJK9Cvfoc0faxyEvuK1xMVenK6lo9daztOJLlvYesAMBrn0CivKelJDMAkNU8yrQOOiqbAON3Nfzezx3vCcXjChkTMGSX7PrfDU3URPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333093; c=relaxed/simple;
	bh=LTvB9WY4GZ0VpCgAlhFoR4FK2MsAbY8ZIYv1cwIaidI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBW6AAKEjgvUBqtPMFHXuPBIgDx8qcL8oRDyYiB1MKJMlWBGW/xSg02EOndN7IwEFOyK9MS7Sigz3qt+I9vdwa2l+EKQEhYkBbZn/ZInZxfI+eOyMYFmZRgk6YvqL8/SL+w9jrz4h3qgg9zGpaN6a8dpwFZY3lFjNZGk/gXZO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8hiUjRo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1262038866b.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333089; x=1762937889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBjSm9poGBzjWcWad+B44jeFO+cKptmrdyLV1ex7gw8=;
        b=m8hiUjRom9D4XOtR/nWur2U7ewh3bQdILTcssYwwMQ/HxGmXN+OtkIrHBWgDytCG6b
         pEG658MG7JBNgU7jE6yhEaYV/wK+W1fQVG2aEhKOyAgiGS6phpF3Kmr2Yht/r7Z6iJD9
         kB4cZpmMo/zxc8IVSX7I5aoUVaNcqdHndhC0Do+Ljuuu8J1rwKnnipjEoyB3xp/RGuf6
         5owAg5kshtihd2w1lK+uDjPLMI9SZc8UTbUmLF3xTjE0NjGw0BJveRFSUbw/H8GUkjMM
         jTkrou4UeIXeWt7zVnXPaBzROrsNkaeu4RsPixbdabZENGMPb+wUi0diLGSXh+Rqy3nZ
         hVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333089; x=1762937889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBjSm9poGBzjWcWad+B44jeFO+cKptmrdyLV1ex7gw8=;
        b=myASheGW5lOE/RMqb3VPKiWPZmUuldZEJZwkzpEV4cxjCsXQuSMuyrZKLdrJF4si8T
         id34SDCNs8ImUaAFHbt9QI4s9OiHKGOAKPwAOjMn4eq9JXJ2qr/C/zrRipmbbCVYE8BE
         fV+gzDAGX/PA2e2Eb5VLua3Qi6Aa/4DhX1HF0W5HZgjJZBhTDHwwz8hAyLzE3IZI2yHG
         0GDZZeBkStEVXwJzaNv2uR0TNB5N55sb4wbnjfZDfEA7d0UQSTt+v4Dkp6AZpuT2OM6N
         Lwz7kBSljKuZkfG9jgFkVtXl+TupHzB45LEFiuVE7hNGRw07fPPPsSQhzmsuyH+b4Ivm
         91ig==
X-Gm-Message-State: AOJu0YzDHcSQ9D7CqXOrky3O6xUzpX+Woj2QOwX0lDPzuLA8Xl85sBcb
	LuYkMFEW8O+jOXuPHS1bilB0mGqRcTGensE/j/gsbaIG5VQLVCK/eYNxSFs9aA==
X-Gm-Gg: ASbGncvq68rO9cU62vgYHlG0SYXg/FBSna3w522DLED/XIiNtRX0RQpCuOETBpZFpuO
	/NZaaPx0m9UfRc+7yRNZdXN45PrcdvyoL50/kI38P2FOUFvdtMDWBua/OWStxZoMGBsyTkeeM9A
	jywEXGrwMkJLW+fK2CZje9AeLnaa87+6bjAdJJcaxklywGWvXj4aKX9fGoWMvraV2ZFB0nCTD8r
	iNmTa5GwZvMtQA5RCOZcgBbzTGJMvKSNwIsYcDSJ9sH/bM3Hx3Vflov8CND90qXuBfUKJgSseeG
	pqxQJ1g9qkfYEoCiDVBtPfg1TxiYimgpXiU/SmnsTs99KtXMOQFvNgikE5q99xTsfYrId36JEPY
	AGImjc/VvS581i9oPrl1d917pWYuD1hhZ2nTzvk9hMayX5SXWmJZYHTzNd8fmL04lqiKQSaE4kI
	bUxMr6VATU2WlRDnMuYnk9CWXQykIicw==
X-Google-Smtp-Source: AGHT+IFve6rgy0n+/PqslQbZgAECgi6CCmDF5GTHL5UOBp1IWGazW/oq7T51cJj2QyNOXI/AekAeLQ==
X-Received: by 2002:a17:907:60d5:b0:b6d:2f3f:3f98 with SMTP id a640c23a62f3a-b72654e24edmr213658966b.41.1762333088339;
        Wed, 05 Nov 2025 00:58:08 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:07 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 11/12] selftests/bpf: add new verifier_gotox test
Date: Wed,  5 Nov 2025 09:04:09 +0000
Message-Id: <20251105090410.1250500-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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
index 000000000000..b6710f134a1d
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
+		.quad ret0_%= - socket;					\
+		.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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
+		.quad ret0_%= - socket;					\
+		.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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
+		.quad ret0_%= - socket;					\
+		.quad ret1_%= - socket;					\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
+	.quad ret_out_%= - socket;				\
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
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
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


