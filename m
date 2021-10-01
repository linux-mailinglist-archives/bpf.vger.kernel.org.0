Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3716041EE26
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353935AbhJANGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 09:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354285AbhJANGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 09:06:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79DC0613EE
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 06:04:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so34436424edv.12
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6y4JSy406Wu+PL5pFim+RuAZbB2EbfKD2rlF0TOar4=;
        b=RzpiLocflVSAD7CChVeRqlnX4KIPe8PDNEC+u6+IUU3ez+0g/3JZa0oyT2EHegTfol
         XRq62uP4Yyrs2xsKClcNp+rDh8CAzRMYCHZpMM/uI1e6u4vf/dfJ3d/456kmgg8RJ+m8
         rEwEq66lgQbQn8k6fVKHrgm5SOgbyUtYLtJJC97RjspN/iA1ZpnTDm/GDQVQyH7Aas3i
         K9X/qy8dvj9VUCNz3nbxFvd1CWLYgqyrfFPLq+avzg3QPSamtzeC8B7k/EO2uMAM3jzU
         ZSh11RPz+XxTNCKxfkXCQa1DsjVUrrwzmJpgVz71Y6HsVm59TECvq/hhAWVQ+rFpc5lH
         baQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6y4JSy406Wu+PL5pFim+RuAZbB2EbfKD2rlF0TOar4=;
        b=cVKs2KYJYV9XHF9Z9vUwdYLvf8F8TedaGN/odTaZbuMrskHPAFVPHgcxL9ke4XkXAa
         SrZvGe8qv5juM6W6bQt5+VccSm+uAr8uaqveVFxgb5M4vKdAVpvPBHY8IUWEUtyV2NVa
         45Btclaq8/Nhn79Y3HfMixEksdBV/lvwMV3alasO4T9LXeiycEb0veORm/XCPOnKRY4o
         FLZThZTGPj6yVfaMWO20gmh+FyB66gIHlBGys3OlzSc8NPWb/9ouIhZoHjhjWyRVbIjZ
         IF/272jLXXdiTTHF20wFrZf7WCRoY6I+V6/+xuT5IW79+WBu6RFcEvrunpMxyXDEGRFA
         D9lA==
X-Gm-Message-State: AOAM531MNMg6QQRjW3WE8uWDtd25132tfQIZGjbhqnx+6f5DtXR7i9x8
        yhL6NKR2CIbEdJAlB6tOmkwxXw==
X-Google-Smtp-Source: ABdhPJwj3yV8GHKjigIxa2Jnn7+zh39UAhWAy3pPE2urx3c414BWuJS1mfT237HxRD5wmYkPrqREjg==
X-Received: by 2002:a50:8282:: with SMTP id 2mr14038488edg.98.1633093442602;
        Fri, 01 Oct 2021 06:04:02 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id p22sm2920279ejl.90.2021.10.01.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:04:02 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 04/10] bpf/tests: Add tests to check source register zero-extension
Date:   Fri,  1 Oct 2021 15:03:42 +0200
Message-Id: <20211001130348.3670534-5-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001130348.3670534-1-johan.almbladh@anyfinetworks.com>
References: <20211001130348.3670534-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests to check that the source register is preserved when
zero-extending a 32-bit value. In particular, it checks that the source
operand is not zero-extended in-place.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 84efb23e09d0..c7db90112ef0 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -10586,6 +10586,149 @@ static struct bpf_test tests[] = {
 		{},
 		{ { 0, 2 } },
 	},
+	/* Checking that ALU32 src is not zero extended in place */
+#define BPF_ALU32_SRC_ZEXT(op)					\
+	{							\
+		"ALU32_" #op "_X: src preserved in zext",	\
+		.u.insns_int = {				\
+			BPF_LD_IMM64(R1, 0x0123456789acbdefULL),\
+			BPF_LD_IMM64(R2, 0xfedcba9876543210ULL),\
+			BPF_ALU64_REG(BPF_MOV, R0, R1),		\
+			BPF_ALU32_REG(BPF_##op, R2, R1),	\
+			BPF_ALU64_REG(BPF_SUB, R0, R1),		\
+			BPF_ALU64_REG(BPF_MOV, R1, R0),		\
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
+			BPF_ALU64_REG(BPF_OR, R0, R1),		\
+			BPF_EXIT_INSN(),			\
+		},						\
+		INTERNAL,					\
+		{ },						\
+		{ { 0, 0 } },					\
+	}
+	BPF_ALU32_SRC_ZEXT(MOV),
+	BPF_ALU32_SRC_ZEXT(AND),
+	BPF_ALU32_SRC_ZEXT(OR),
+	BPF_ALU32_SRC_ZEXT(XOR),
+	BPF_ALU32_SRC_ZEXT(ADD),
+	BPF_ALU32_SRC_ZEXT(SUB),
+	BPF_ALU32_SRC_ZEXT(MUL),
+	BPF_ALU32_SRC_ZEXT(DIV),
+	BPF_ALU32_SRC_ZEXT(MOD),
+#undef BPF_ALU32_SRC_ZEXT
+	/* Checking that ATOMIC32 src is not zero extended in place */
+#define BPF_ATOMIC32_SRC_ZEXT(op)					\
+	{								\
+		"ATOMIC_W_" #op ": src preserved in zext",		\
+		.u.insns_int = {					\
+			BPF_LD_IMM64(R0, 0x0123456789acbdefULL),	\
+			BPF_ALU64_REG(BPF_MOV, R1, R0),			\
+			BPF_ST_MEM(BPF_W, R10, -4, 0),			\
+			BPF_ATOMIC_OP(BPF_W, BPF_##op, R10, R1, -4),	\
+			BPF_ALU64_REG(BPF_SUB, R0, R1),			\
+			BPF_ALU64_REG(BPF_MOV, R1, R0),			\
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),			\
+			BPF_ALU64_REG(BPF_OR, R0, R1),			\
+			BPF_EXIT_INSN(),				\
+		},							\
+		INTERNAL,						\
+		{ },							\
+		{ { 0, 0 } },						\
+		.stack_depth = 8,					\
+	}
+	BPF_ATOMIC32_SRC_ZEXT(ADD),
+	BPF_ATOMIC32_SRC_ZEXT(AND),
+	BPF_ATOMIC32_SRC_ZEXT(OR),
+	BPF_ATOMIC32_SRC_ZEXT(XOR),
+#undef BPF_ATOMIC32_SRC_ZEXT
+	/* Checking that CMPXCHG32 src is not zero extended in place */
+	{
+		"ATOMIC_W_CMPXCHG: src preserved in zext",
+		.u.insns_int = {
+			BPF_LD_IMM64(R1, 0x0123456789acbdefULL),
+			BPF_ALU64_REG(BPF_MOV, R2, R1),
+			BPF_ALU64_REG(BPF_MOV, R0, 0),
+			BPF_ST_MEM(BPF_W, R10, -4, 0),
+			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R1, -4),
+			BPF_ALU64_REG(BPF_SUB, R1, R2),
+			BPF_ALU64_REG(BPF_MOV, R2, R1),
+			BPF_ALU64_IMM(BPF_RSH, R2, 32),
+			BPF_ALU64_REG(BPF_OR, R1, R2),
+			BPF_ALU64_REG(BPF_MOV, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } },
+		.stack_depth = 8,
+	},
+	/* Checking that JMP32 immediate src is not zero extended in place */
+#define BPF_JMP32_IMM_ZEXT(op)					\
+	{							\
+		"JMP32_" #op "_K: operand preserved in zext",	\
+		.u.insns_int = {				\
+			BPF_LD_IMM64(R0, 0x0123456789acbdefULL),\
+			BPF_ALU64_REG(BPF_MOV, R1, R0),		\
+			BPF_JMP32_IMM(BPF_##op, R0, 1234, 1),	\
+			BPF_JMP_A(0), /* Nop */			\
+			BPF_ALU64_REG(BPF_SUB, R0, R1),		\
+			BPF_ALU64_REG(BPF_MOV, R1, R0),		\
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
+			BPF_ALU64_REG(BPF_OR, R0, R1),		\
+			BPF_EXIT_INSN(),			\
+		},						\
+		INTERNAL,					\
+		{ },						\
+		{ { 0, 0 } },					\
+	}
+	BPF_JMP32_IMM_ZEXT(JEQ),
+	BPF_JMP32_IMM_ZEXT(JNE),
+	BPF_JMP32_IMM_ZEXT(JSET),
+	BPF_JMP32_IMM_ZEXT(JGT),
+	BPF_JMP32_IMM_ZEXT(JGE),
+	BPF_JMP32_IMM_ZEXT(JLT),
+	BPF_JMP32_IMM_ZEXT(JLE),
+	BPF_JMP32_IMM_ZEXT(JSGT),
+	BPF_JMP32_IMM_ZEXT(JSGE),
+	BPF_JMP32_IMM_ZEXT(JSGT),
+	BPF_JMP32_IMM_ZEXT(JSLT),
+	BPF_JMP32_IMM_ZEXT(JSLE),
+#undef BPF_JMP2_IMM_ZEXT
+	/* Checking that JMP32 dst & src are not zero extended in place */
+#define BPF_JMP32_REG_ZEXT(op)					\
+	{							\
+		"JMP32_" #op "_X: operands preserved in zext",	\
+		.u.insns_int = {				\
+			BPF_LD_IMM64(R0, 0x0123456789acbdefULL),\
+			BPF_LD_IMM64(R1, 0xfedcba9876543210ULL),\
+			BPF_ALU64_REG(BPF_MOV, R2, R0),		\
+			BPF_ALU64_REG(BPF_MOV, R3, R1),		\
+			BPF_JMP32_IMM(BPF_##op, R0, R1, 1),	\
+			BPF_JMP_A(0), /* Nop */			\
+			BPF_ALU64_REG(BPF_SUB, R0, R2),		\
+			BPF_ALU64_REG(BPF_SUB, R1, R3),		\
+			BPF_ALU64_REG(BPF_OR, R0, R1),		\
+			BPF_ALU64_REG(BPF_MOV, R1, R0),		\
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),		\
+			BPF_ALU64_REG(BPF_OR, R0, R1),		\
+			BPF_EXIT_INSN(),			\
+		},						\
+		INTERNAL,					\
+		{ },						\
+		{ { 0, 0 } },					\
+	}
+	BPF_JMP32_REG_ZEXT(JEQ),
+	BPF_JMP32_REG_ZEXT(JNE),
+	BPF_JMP32_REG_ZEXT(JSET),
+	BPF_JMP32_REG_ZEXT(JGT),
+	BPF_JMP32_REG_ZEXT(JGE),
+	BPF_JMP32_REG_ZEXT(JLT),
+	BPF_JMP32_REG_ZEXT(JLE),
+	BPF_JMP32_REG_ZEXT(JSGT),
+	BPF_JMP32_REG_ZEXT(JSGE),
+	BPF_JMP32_REG_ZEXT(JSGT),
+	BPF_JMP32_REG_ZEXT(JSLT),
+	BPF_JMP32_REG_ZEXT(JSLE),
+#undef BPF_JMP2_REG_ZEXT
 	/* Exhaustive test of ALU64 shift operations */
 	{
 		"ALU64_LSH_K: all shift values",
-- 
2.30.2

