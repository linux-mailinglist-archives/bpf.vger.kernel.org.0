Return-Path: <bpf+bounces-72268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE45C0B136
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F2484ECB21
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C82FE56B;
	Sun, 26 Oct 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFAce3FI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45642FF15B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506452; cv=none; b=IlhShve3DagNgilT23C42enRiTQUYypa0UxLYGtsCQuiVrHlbDBdz06CpKuJ04TYOraJHP6cCOX1N+CaYtXSKRSmekppJLOSV2x03qVvuAFI4fDDP80hROlpnU0mZRAWQ/x0TwkETuCIwp1IpXQsXhDffakDq/QBDdvhkouH01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506452; c=relaxed/simple;
	bh=7Gq5JEmxCHvnTCWXIsp5u7UtkkXAqPxRsyHsnvYbGkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEssj/8FrDxm7zV4AkCHXS8xyAmemdxRGx9tU8xtLfAmM/+P8c2TMidNn/Co0di38kwpLMS8f7+KronKDw+i2tvEmk/9qm8BG6oCs81P80573wIZAr8enkAad5UL+TeTVLc+SXn9C9dwtuVMWWH6JZ116Sg0BHD+xSNa5DEJLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFAce3FI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710683a644so31518105e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506449; x=1762111249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VeWWUnNs0ajVwBQrlZRgL9NWJ5mgSANySzO3jKGQWY=;
        b=eFAce3FIGNODR6JvOfJRFIcsOIsB2cD7WoaU9hNqXtyLRqCmXXjgotq7sfqS7HpMCW
         vqj6t9UsEgWQWwoARTSeU3Y3SiPCvlUrzTJB7rZBtQU/39iWY47z0yqVfyJzYUb9G6+J
         mVML/PFLSAFzyctCnVWHouP46NXBLfepRyoPiobhLGmHS2ofYHUaq42WLwb/xWMGKv9x
         eoTuUxBk7Vj7CljytuQ1XlYmtisdT2sBnJpebPyY/nGMJ0+2k9uPXWmGJAh0owqOwykc
         YsKg9cM+/1n3/wYtPsTngiPbbkN6KDqHVBO378cPEGc1W2e0otu7EUasQZ/dJ7FdXMci
         yxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506449; x=1762111249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VeWWUnNs0ajVwBQrlZRgL9NWJ5mgSANySzO3jKGQWY=;
        b=lykCnuddZrMYbk0H5dp2PR3NnSlZGbk3w0W8UGtLcuscMjYfItwyW5pMzmUaHhrjXj
         a92HHDGT/+AvvTocJOfSiHPxZ2zM/d0SeYIjUfRpx5xBxMx9Dr5Q//j7+XyNTIGLTLcE
         LygLVTCrG6AapctIybGNW/ZBR9/+D3B1/1R8f+pWwAJxo6EtBBAvpWEcckbcNnRiHHNF
         OZpXXoHcmDjasFnWI3szEPEee3Tc/PM65j0KhjLL7uw9D8Ay9Xr6cK1zmvdWR/H/gQE8
         71G2p+iz8anrKl+Ar2sh8sMl4VxNEBh6jWyzUO0HN9ZPicJbcigIsR3QBo/2d0hUhsTo
         9yUA==
X-Gm-Message-State: AOJu0YzFI4KkTIEToZqLGXNQS2UXKuqpNEsMuxGpHjFQ+nxi9IXjXBGs
	DyPGCQFXEXWiCOarTX07zhGZ18GiDrpQ8s5obKDvF4lPVk/WBlUpCkNak8NpqQ==
X-Gm-Gg: ASbGnctLYESMyEEIjM9IX87OeBuB4FQMI1ya3qPCf5nEKW99o7htedc+0OZyErj7592
	Zop1ZP6a6YhH7J9goYbYfrtN5nsVBjG0ih6SWsaTcWqiFKEVREorTC0HesXVYXowyUzfqc62c12
	uJwZt75HgXnXXyRkDnKrmf2BFRfIetYbNuRkZvJjGNFUuxBQ7YMIQ1e0zpGFbfYTsXGK6CGfrWr
	0E/LjbqYwa+aEVCqA2D1JPpOnqTGDkv4kqrBsdKiQ/ZUuSflHUSxvATo/C9uTOkBNM4kxooopXK
	oM15Slpu7sXpoML+6Hr2My9B/g7/lwym+JthP5eOwO0JP7jPxPidWruEI4IOKGXwq+N911U2N6v
	HWWU8UhlzJ2jZ9Gh+UdWxTx/g2dqXjRdFcPf3Kt97K/AjxvHk0vfuZhVIJpZ8Ck7HNopYoyYvng
	Yp+PtpYvkvxI/28Pujt/eCHpLKBjhOHg==
X-Google-Smtp-Source: AGHT+IHOXuQ8/AXZH2J29ffbRH4+W7rLN0je6XsPt90oYFv61WHMGy3ZyO9jKYvCnlWovcE05HcTzw==
X-Received: by 2002:a05:600c:5845:b0:477:115b:878d with SMTP id 5b1f17b1804b1-477115b891dmr4979395e9.15.1761506448532;
        Sun, 26 Oct 2025 12:20:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:47 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 11/12] selftests/bpf: add new verifier_gotox test
Date: Sun, 26 Oct 2025 19:27:08 +0000
Message-Id: <20251026192709.1964787-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/progs/verifier_gotox.c      | 317 ++++++++++++++++++
 2 files changed, 319 insertions(+)
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
index 000000000000..0f1032783904
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -0,0 +1,317 @@
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
+#endif /* __TARGET_ARCH_x86 */
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


