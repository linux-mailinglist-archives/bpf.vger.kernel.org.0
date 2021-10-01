Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E641EE2A
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbhJANGz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 09:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbhJANGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 09:06:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D3C061780
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 06:04:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so33794774edc.11
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=viy6/L1w5zzBK7Cww93yBpzUD2D5BBFDTZa/eQUpqNc=;
        b=EXyHgYVUU43xdYgTdllAkO1ir3c44HrPz6AN9CYTieQ5CYAzXON8RnwGoHmDfdVvUm
         rkYN0NcgXrNVsj/cRVlWBkqZ550kQOvyZ1upqWTBdyEzSkaZu0qvKqjXAv9DVXY0MP7y
         bdumuL/tNZGucZMK6tKtidIt7vjPCCXsjCE96tBSApBksflMa1kA28+EHF06rNMJPIU8
         iZhqDYVR8Zbdbwc7l8aPjzLqrYKa2wNY1JGzPQg8cJ9KutHlJo3m+udDV6CBs6xpeM1u
         Tz8oh4Yki2oOtcCd1fnfWxF3cbkuKPFBeqUIH/lsPxt6DpU99isNjUbDDMkW5U0aTIIU
         4CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=viy6/L1w5zzBK7Cww93yBpzUD2D5BBFDTZa/eQUpqNc=;
        b=5yMyzyjs1+/1h752PO1tDNhgFL3YVXPd4/bp/nEZulpzpRpHn+cuWPT6MrzunVs/dJ
         RaE34045rBTxX+qlkrLrZMRSjWZ6iLlH7sXbhhxRDHtjapk/otxqVJT5l4ULdA0E7nBe
         GlpDLqsfOj6UTevjJj/5VNGTQv0+UmSU+DHfIhZ3d9oPXtHG3Yht2qRi5Dlo7TBENfKd
         rMqSOnJ/8/sJi2yWJ6igcNNsHhykPWd+aOXE5d1X+a2IaDD7iGVhVYDEFGQko+EXpHB9
         UWJ0pOae9a+AfeQ+S4M/O3dl60vXll89Sk8Phzyg4pfbOUn9wTixw2Rzv9Xw4buw7FKO
         sm+w==
X-Gm-Message-State: AOAM533zhEg+82GDSyVBlOrBsSZp9SmLbV+TqTQMTgDpO/FDQ9Jqj3Y9
        pHZ4i4JM5lN8xvOg86gmgdw/FQ==
X-Google-Smtp-Source: ABdhPJwgoeychVRQ5rN4WrY9sZgznqfBhrsFLMNvcK4WKpWZeiUi2Dq8BTJD+yTY3ilF3tNSac+3eQ==
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr14397741edk.11.1633093440032;
        Fri, 01 Oct 2021 06:04:00 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id p22sm2920279ejl.90.2021.10.01.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:03:59 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 02/10] bpf/tests: Add zero-extension checks in BPF_ATOMIC tests
Date:   Fri,  1 Oct 2021 15:03:40 +0200
Message-Id: <20211001130348.3670534-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001130348.3670534-1-johan.almbladh@anyfinetworks.com>
References: <20211001130348.3670534-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch updates the existing tests of BPF_ATOMIC operations to verify
that a 32-bit register operand is properly zero-extended. In particular,
it checks the operation on archs that require 32-bit operands to be
properly zero-/sign-extended or the result is undefined, e.g. MIPS64.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index a838a6179ca4..f6983ad7b981 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -7398,15 +7398,20 @@ static struct bpf_test tests[] = {
 	 * Individual tests are expanded from template macros for all
 	 * combinations of ALU operation, word size and fetching.
 	 */
+#define BPF_ATOMIC_POISON(width) ((width) == BPF_W ? (0xbaadf00dULL << 32) : 0)
+
 #define BPF_ATOMIC_OP_TEST1(width, op, logic, old, update, result)	\
 {									\
 	"BPF_ATOMIC | " #width ", " #op ": Test: "			\
 		#old " " #logic " " #update " = " #result,		\
 	.u.insns_int = {						\
-		BPF_ALU32_IMM(BPF_MOV, R5, update),			\
+		BPF_LD_IMM64(R5, (update) | BPF_ATOMIC_POISON(width)),	\
 		BPF_ST_MEM(width, R10, -40, old),			\
 		BPF_ATOMIC_OP(width, op, R10, R5, -40),			\
 		BPF_LDX_MEM(width, R0, R10, -40),			\
+		BPF_ALU64_REG(BPF_MOV, R1, R0),				\
+		BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
+		BPF_ALU64_REG(BPF_OR, R0, R1),				\
 		BPF_EXIT_INSN(),					\
 	},								\
 	INTERNAL,							\
@@ -7420,11 +7425,14 @@ static struct bpf_test tests[] = {
 		#old " " #logic " " #update " = " #result,		\
 	.u.insns_int = {						\
 		BPF_ALU64_REG(BPF_MOV, R1, R10),			\
-		BPF_ALU32_IMM(BPF_MOV, R0, update),			\
+		BPF_LD_IMM64(R0, (update) | BPF_ATOMIC_POISON(width)),	\
 		BPF_ST_MEM(BPF_W, R10, -40, old),			\
 		BPF_ATOMIC_OP(width, op, R10, R0, -40),			\
 		BPF_ALU64_REG(BPF_MOV, R0, R10),			\
 		BPF_ALU64_REG(BPF_SUB, R0, R1),				\
+		BPF_ALU64_REG(BPF_MOV, R1, R0),				\
+		BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
+		BPF_ALU64_REG(BPF_OR, R0, R1),				\
 		BPF_EXIT_INSN(),					\
 	},								\
 	INTERNAL,							\
@@ -7438,10 +7446,13 @@ static struct bpf_test tests[] = {
 		#old " " #logic " " #update " = " #result,		\
 	.u.insns_int = {						\
 		BPF_ALU64_REG(BPF_MOV, R0, R10),			\
-		BPF_ALU32_IMM(BPF_MOV, R1, update),			\
+		BPF_LD_IMM64(R1, (update) | BPF_ATOMIC_POISON(width)),	\
 		BPF_ST_MEM(width, R10, -40, old),			\
 		BPF_ATOMIC_OP(width, op, R10, R1, -40),			\
 		BPF_ALU64_REG(BPF_SUB, R0, R10),			\
+		BPF_ALU64_REG(BPF_MOV, R1, R0),				\
+		BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
+		BPF_ALU64_REG(BPF_OR, R0, R1),				\
 		BPF_EXIT_INSN(),					\
 	},								\
 	INTERNAL,                                                       \
@@ -7454,10 +7465,10 @@ static struct bpf_test tests[] = {
 	"BPF_ATOMIC | " #width ", " #op ": Test fetch: "		\
 		#old " " #logic " " #update " = " #result,		\
 	.u.insns_int = {						\
-		BPF_ALU32_IMM(BPF_MOV, R3, update),			\
+		BPF_LD_IMM64(R3, (update) | BPF_ATOMIC_POISON(width)),	\
 		BPF_ST_MEM(width, R10, -40, old),			\
 		BPF_ATOMIC_OP(width, op, R10, R3, -40),			\
-		BPF_ALU64_REG(BPF_MOV, R0, R3),                         \
+		BPF_ALU32_REG(BPF_MOV, R0, R3),                         \
 		BPF_EXIT_INSN(),					\
 	},								\
 	INTERNAL,                                                       \
@@ -7555,6 +7566,7 @@ static struct bpf_test tests[] = {
 	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
 	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
 	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
+#undef BPF_ATOMIC_POISON
 #undef BPF_ATOMIC_OP_TEST1
 #undef BPF_ATOMIC_OP_TEST2
 #undef BPF_ATOMIC_OP_TEST3
-- 
2.30.2

