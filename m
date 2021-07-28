Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846743D93E2
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhG1RF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhG1RFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E802C0613D3
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gn26so5769567ejc.3
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLSnZf2T+9/r31bMLVfzXUveqMn1a/Ddr4yrjJ0MZeY=;
        b=g0oyhIVfistVOBI6eGjtFCMTHq5vrJTxg1tr2jw8ObAMvKVUa+NAz7lGmAd6KLMaws
         Er0/MRu5EOIaUPQKPaI7WldxyPqQosQg4ilxav8wmfcvHWyzLNdsSvwkm6kEj098e4ZK
         y9VtomtD3cTWbTTlrhk4YGk6VyDg3OHRxIpDDabLXAhMtvvGfoCvwG0vf69UW6/F6t23
         v6TjzJiKLBUs+4YeeKA0HYAj8NWNgQ314+YG0/9/lqYJkp1P6o5cwN1Cx1NtkN6D6cgx
         1xT3TzzXkWRfxb7LCIEu1cbn3v+Mfhpsc7fqthQ0ZLLNs0y5xEa3v5t2/5+T0RGhAffs
         yHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLSnZf2T+9/r31bMLVfzXUveqMn1a/Ddr4yrjJ0MZeY=;
        b=oQ9cg+/Z9X4RDHBrfShGwdZdbOHwUCJdSkU1xfSV+bYDQHo2p3RUl+xTbxPkCUp1CY
         LONbjlAJmUgDLwW/dECxGELuV7r94mYxR7DiiGLtfMz1RZiROhpb0L0QbjYtLI0vz7G2
         ELCLNB0Bdcz1Bta/1H77U/1QigyvgWNhZa/E4ht4yfdt5U4aF/kEqqU3fiIpuDRx+FiE
         OUs3C4Ofa1HQ5y4mztgmjFyYmVgJQfKth9DwlE0PwphFxtzUWZl+I6H+aQxe8xtdEpfk
         PjfRlfHr4M1fOBBbWQDXxxhIKIf2e4bnhrIMHG/AyqmjKaFhaxGFrU+ktyW5XUzjqIw8
         5lVw==
X-Gm-Message-State: AOAM533y8OdA1EGqx42aS1+D/KA+Bt2j5v6V7j2Fm6fX8auI84vYPMgZ
        24YcB0OhfdZtGt6mz1IdRjst2w==
X-Google-Smtp-Source: ABdhPJz1NaWqB3fYJpVrauwKqVUUax9+WM7qHWy4Y+WG9uqyQWFEwy/MurMMH4vjx18X/r+zWe8dsQ==
X-Received: by 2002:a17:907:16a1:: with SMTP id hc33mr456131ejc.536.1627491942894;
        Wed, 28 Jul 2021 10:05:42 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:42 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 12/14] bpf/tests: Add tests for atomic operations
Date:   Wed, 28 Jul 2021 19:05:00 +0200
Message-Id: <20210728170502.351010-13-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tests for each atomic arithmetic operation and BPF_XCHG, derived from
old BPF_XADD tests. The tests include BPF_W/DW and BPF_FETCH variants.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 252 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 166 insertions(+), 86 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 314af6eaeb92..ac50cb023324 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5500,49 +5500,6 @@ static struct bpf_test tests[] = {
 		.stack_depth = 40,
 	},
 	/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
-	{
-		"STX_XADD_W: Test: 0x12 + 0x10 = 0x22",
-		.u.insns_int = {
-			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
-			BPF_ST_MEM(BPF_W, R10, -40, 0x10),
-			BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
-			BPF_LDX_MEM(BPF_W, R0, R10, -40),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0x22 } },
-		.stack_depth = 40,
-	},
-	{
-		"STX_XADD_W: Test side-effects, r10: 0x12 + 0x10 = 0x22",
-		.u.insns_int = {
-			BPF_ALU64_REG(BPF_MOV, R1, R10),
-			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
-			BPF_ST_MEM(BPF_W, R10, -40, 0x10),
-			BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
-			BPF_ALU64_REG(BPF_MOV, R0, R10),
-			BPF_ALU64_REG(BPF_SUB, R0, R1),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0 } },
-		.stack_depth = 40,
-	},
-	{
-		"STX_XADD_W: Test side-effects, r0: 0x12 + 0x10 = 0x22",
-		.u.insns_int = {
-			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
-			BPF_ST_MEM(BPF_W, R10, -40, 0x10),
-			BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0x12 } },
-		.stack_depth = 40,
-	},
 	{
 		"STX_XADD_W: X + 1 + 1 + 1 + ...",
 		{ },
@@ -5551,49 +5508,6 @@ static struct bpf_test tests[] = {
 		{ { 0, 4134 } },
 		.fill_helper = bpf_fill_stxw,
 	},
-	{
-		"STX_XADD_DW: Test: 0x12 + 0x10 = 0x22",
-		.u.insns_int = {
-			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
-			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
-			BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
-			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0x22 } },
-		.stack_depth = 40,
-	},
-	{
-		"STX_XADD_DW: Test side-effects, r10: 0x12 + 0x10 = 0x22",
-		.u.insns_int = {
-			BPF_ALU64_REG(BPF_MOV, R1, R10),
-			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
-			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
-			BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
-			BPF_ALU64_REG(BPF_MOV, R0, R10),
-			BPF_ALU64_REG(BPF_SUB, R0, R1),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0 } },
-		.stack_depth = 40,
-	},
-	{
-		"STX_XADD_DW: Test side-effects, r0: 0x12 + 0x10 = 0x22",
-		.u.insns_int = {
-			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
-			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
-			BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0x12 } },
-		.stack_depth = 40,
-	},
 	{
 		"STX_XADD_DW: X + 1 + 1 + 1 + ...",
 		{ },
@@ -5602,6 +5516,172 @@ static struct bpf_test tests[] = {
 		{ { 0, 4134 } },
 		.fill_helper = bpf_fill_stxdw,
 	},
+	/*
+	 * Exhaustive tests of atomic operation variants.
+	 * Individual tests are expanded from template macros for all
+	 * combinations of ALU operation, word size and fetching.
+	 */
+#define BPF_ATOMIC_OP_TEST1(width, op, logic, old, update, result)	\
+{									\
+	"BPF_ATOMIC | " #width ", " #op ": Test: "			\
+		#old " " #logic " " #update " = " #result,		\
+	.u.insns_int = {						\
+		BPF_ALU32_IMM(BPF_MOV, R5, update),			\
+		BPF_ST_MEM(width, R10, -40, old),			\
+		BPF_ATOMIC_OP(width, op, R10, R5, -40),			\
+		BPF_LDX_MEM(width, R0, R10, -40),			\
+		BPF_EXIT_INSN(),					\
+	},								\
+	INTERNAL,							\
+	{ },								\
+	{ { 0, result } },						\
+	.stack_depth = 40,						\
+}
+#define BPF_ATOMIC_OP_TEST2(width, op, logic, old, update, result)	\
+{									\
+	"BPF_ATOMIC | " #width ", " #op ": Test side effects, r10: "	\
+		#old " " #logic " " #update " = " #result,		\
+	.u.insns_int = {						\
+		BPF_ALU64_REG(BPF_MOV, R1, R10),			\
+		BPF_ALU32_IMM(BPF_MOV, R0, update),			\
+		BPF_ST_MEM(BPF_W, R10, -40, old),			\
+		BPF_ATOMIC_OP(width, op, R10, R0, -40),			\
+		BPF_ALU64_REG(BPF_MOV, R0, R10),			\
+		BPF_ALU64_REG(BPF_SUB, R0, R1),				\
+		BPF_EXIT_INSN(),					\
+	},								\
+	INTERNAL,							\
+	{ },								\
+	{ { 0, 0 } },							\
+	.stack_depth = 40,						\
+}
+#define BPF_ATOMIC_OP_TEST3(width, op, logic, old, update, result)	\
+{									\
+	"BPF_ATOMIC | " #width ", " #op ": Test side effects, r0: "	\
+		#old " " #logic " " #update " = " #result,		\
+	.u.insns_int = {						\
+		BPF_ALU64_REG(BPF_MOV, R0, R10),			\
+		BPF_ALU32_IMM(BPF_MOV, R1, update),			\
+		BPF_ST_MEM(width, R10, -40, old),			\
+		BPF_ATOMIC_OP(width, op, R10, R1, -40),			\
+		BPF_ALU64_REG(BPF_SUB, R0, R10),			\
+		BPF_EXIT_INSN(),					\
+	},								\
+	INTERNAL,                                                       \
+	{ },                                                            \
+	{ { 0, 0 } },                                                   \
+	.stack_depth = 40,                                              \
+}
+#define BPF_ATOMIC_OP_TEST4(width, op, logic, old, update, result)	\
+{									\
+	"BPF_ATOMIC | " #width ", " #op ": Test fetch: "		\
+		#old " " #logic " " #update " = " #result,		\
+	.u.insns_int = {						\
+		BPF_ALU32_IMM(BPF_MOV, R3, update),			\
+		BPF_ST_MEM(width, R10, -40, old),			\
+		BPF_ATOMIC_OP(width, op, R10, R3, -40),			\
+		BPF_ALU64_REG(BPF_MOV, R0, R3),                         \
+		BPF_EXIT_INSN(),					\
+	},								\
+	INTERNAL,                                                       \
+	{ },                                                            \
+	{ { 0, (op) & BPF_FETCH ? old : update } },			\
+	.stack_depth = 40,                                              \
+}
+	/* BPF_ATOMIC | BPF_W: BPF_ADD */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	/* BPF_ATOMIC | BPF_W: BPF_ADD | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	/* BPF_ATOMIC | BPF_DW: BPF_ADD */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
+	/* BPF_ATOMIC | BPF_DW: BPF_ADD | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
+	/* BPF_ATOMIC | BPF_W: BPF_AND */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
+	/* BPF_ATOMIC | BPF_W: BPF_AND | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	/* BPF_ATOMIC | BPF_DW: BPF_AND */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
+	/* BPF_ATOMIC | BPF_DW: BPF_AND | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
+	/* BPF_ATOMIC | BPF_W: BPF_OR */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
+	/* BPF_ATOMIC | BPF_W: BPF_OR | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	/* BPF_ATOMIC | BPF_DW: BPF_OR */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
+	/* BPF_ATOMIC | BPF_DW: BPF_OR | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
+	/* BPF_ATOMIC | BPF_W: BPF_XOR */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	/* BPF_ATOMIC | BPF_W: BPF_XOR | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	/* BPF_ATOMIC | BPF_DW: BPF_XOR */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
+	/* BPF_ATOMIC | BPF_DW: BPF_XOR | BPF_FETCH */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
+	/* BPF_ATOMIC | BPF_W: BPF_XCHG */
+	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	/* BPF_ATOMIC | BPF_DW: BPF_XCHG */
+	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+#undef BPF_ATOMIC_OP_TEST1
+#undef BPF_ATOMIC_OP_TEST2
+#undef BPF_ATOMIC_OP_TEST3
+#undef BPF_ATOMIC_OP_TEST4
 	/* BPF_JMP32 | BPF_JEQ | BPF_K */
 	{
 		"JMP32_JEQ_K: Small immediate",
-- 
2.25.1

