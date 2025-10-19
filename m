Return-Path: <bpf+bounces-71331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC5BEEC21
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C83BE149
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3572ECE91;
	Sun, 19 Oct 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKHDdPhX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63668228CB8
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904942; cv=none; b=AM9gW5dsUKjvHL73utSzWC3J/okJOPKLkRviKm7uJwArjUDS+AFrRTeuBDqWgWTCiDJOBxChpbECMVNKjCRhX/InP8wuPJkji+gNSI1n5lZ7q/JMUZTr547sL4pYbq5s7d8f90muXCCtf2r6N1SN96rUns/RuxGgG4/6KQeBblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904942; c=relaxed/simple;
	bh=LF3zTH3v5olEX547IRoDrFO4tpwfH7C1RUKVaTyBiz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAvJrWOUhmZEIgLBAcjJNAZUrBzSX892PPfmgigYZ58z8MYQUdLAi7uU5usoPvkSVJxIC8EZ/R9JTVKTbZ8Z6pYDYCKSEkurWzMdNwrVHHTDoxH6YTyrwQApnvVEFLeSk6nRBU9PXBKjHoSwRE3QfY4D0YY2NBJhUU3eMbTGm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKHDdPhX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711f156326so22601125e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904938; x=1761509738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjOW1gA+8kQC5XzA1OawuQ3lbDxPlUFC+x+f+GBPyJY=;
        b=NKHDdPhXBZBs3uaWN0eQST+dtYZAItJQbpQtNQWPSaa1bomErebt7wnN5osyRzTP+W
         K6d3eBrsk1FEFCnjD/TWqk8DArfkTbvZU7WSpuPLo8YiMdwJnzYGA2rPdNrD/DT+yNDT
         I11ctMmJrzOUASDHcSISDUQTBaoAtpR/z4bmBXkV0NKaZARLguBpqGFrzK++PHN9BBdh
         x8Y8DVASuq9JSXZb7xZTKw/SNF4CMOk9+1xlEQ1LcscVEpotwl14RM3sOPbZNHAWahnA
         IPXZBZA1XNk9M8NKI3GtgD6HqfOfn1sIjyq6zQosl1J2MdafRPsbRrK65tidsSCFApLt
         wVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904938; x=1761509738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjOW1gA+8kQC5XzA1OawuQ3lbDxPlUFC+x+f+GBPyJY=;
        b=qv0GgVQlx50NfFg/OFXUyS/fK/w/6ZVDVhDVNv9MTKIGO0L8QfBKGT1gJBANwNNWpQ
         XULt0Yr7v7iLdrk5mWhdoExODtGeuX2+OkXaxs6Ne2ahrIfPaDm0eNL4Fxk99bpkxC1z
         ZZM0FaeA69yl/5G7kx9QCzEP5oEGfUhF++MnOdIP2EA3md0CylJganJQ9j5jDWaboigY
         lKqnxxzh0utbBIZgFE66HTBTT6YwUR6kUXSnifZ8OTrVSsLkKkum2KEmtD9xyo2Rla8V
         gx7Yww6HBWp3oYXqNi3ypEK9dld4Bu7tI561aW+7PWHGafkrSpkVVOulzZ+oJRdSJ3Tl
         7mlg==
X-Gm-Message-State: AOJu0YxSKyj2gX6jSFvr5tf/YuCL4Whuv9mOidcPxNLQKzwoMUCwuOan
	SF99Ur7o9r22ThKImAOyVUO51VAhqxUfre7f5RN6guM84Kp+gn3QvP72KG5vqA==
X-Gm-Gg: ASbGnct7opZk/EJ89zhEU4MH8TzgqZCR5ynwPkAocQWpOIPsi7BtqqRVimjYIJ1rsi/
	PqlhQ3Gbx8wur50yEf92mIqwzZK8BkGCv9mGcKliib3jXKgOJGDmOA8x8taeAHuWekiTXX2CveL
	65rb9Gfn87ay9SoGRvSC8G0G9FUewgxitWo/8DBO+xcgu1SDNvaVPltPDFk+2hbpA6pprsj0bX/
	3x+ZyGPIwBHdAR/hw8AfwMJ+PS9vuk8Ru5fX6ZPsx/dRwpON54R8js/CqxHPN37Wz/ax7PG0RBw
	/6/BxDaUwYMzHc09KsDb29Id2gcSB6659uTiGNLj87efQ4dfI4uvjWQzpYaZOhU5+oUY0zUTESk
	Ph9LOdiipwYqTfBZJ+EpR88rHKq50XQ4bg/afnKVlKjI+5JnmPmQygVclYm09wwTOqAOpG71a8E
	L7feU5FLgCRUUc81Di6OE=
X-Google-Smtp-Source: AGHT+IEfyXCtqlZuRDU/yHUHwW81mOf82GxcvXjMn+uP2nlfmwXeErX6/8o/K4KgVFBXu4sSjmXGWw==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-471179176b9mr92014285e9.28.1760904938048;
        Sun, 19 Oct 2025 13:15:38 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:37 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 16/17] selftests/bpf: add new verifier_gotox test
Date: Sun, 19 Oct 2025 20:21:44 +0000
Message-Id: <20251019202145.3944697-17-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/progs/verifier_gotox.c      | 277 ++++++++++++++++++
 2 files changed, 279 insertions(+)
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
index 000000000000..1a92e4d321e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -0,0 +1,277 @@
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
+__failure __msg("R1 has type 1, expected PTR_TO_INSN")
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
+#endif /* __TARGET_ARCH_x86 */
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


