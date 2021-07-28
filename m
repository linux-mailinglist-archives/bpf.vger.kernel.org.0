Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2973D3D93D6
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhG1RFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhG1RFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28680C061757
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x11so4796870ejj.8
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEbBgT9KUgFMR4F2JhORtf43do/IC8QDrTSxMkyYPAs=;
        b=cc2hTasRha1vubPEkzwP+TMNdfoGjj3/IbUNHBwaTGl0a3YNZ91tPGDh1frTixkgQW
         JGIM23kFKgCx2lZ90ge2G2DFZ5lUVMUWKSCmBqpVbXkN3fm38/KGUGZmHrqVzZGPsbwj
         Weyi6RGdMxX0fxnJOeY8NgpYeG5Fs+yxWNkwYps8f+JQCiMbxsbj39S9iCDyJnaDMJV/
         b519GaAAlxZSN/Z13wCiQPIAaSp9wNlXXmKhBY5xZMFoktK9I7hYBVsmebNIFcBDfelw
         mskxmM9b1MGDhuhZmRNR55u+kivBLZDEc5jC7LDIF6Xs1mjhI7piYJN3tgD9ibWDyk/5
         QFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEbBgT9KUgFMR4F2JhORtf43do/IC8QDrTSxMkyYPAs=;
        b=WBHVhXX9gDfCWrn+SVNJotCFI8hMTugdis1jQUuZwfJVywvg4dtcay3/5N3ggTgDSh
         jEohUt/qplFAyXGGEVtYl00yMU9AVp3y4NQ8+UodUL0eehtzJR07tNu0p3lTtynO/4kn
         i3kuFnlduY8XhhZ6oFtyaXX/3fJchbL5+Jk0O+xiAi+KEaL9+IxV6/6V2qW35gsmrk3W
         LgOwQyymcf/9B9T+wGiSd/xF8Aq5bR3IovOSmSCTUVDTjCNjDwZtoxzIRKpJXWDF/OX8
         j72FFR5mJccLiY7hzSf0Edvepo5sMAB9+dfWegbLA5L6Z1yRSU0rITwwVhLgKPPuskFr
         7CQA==
X-Gm-Message-State: AOAM530iYkY+h7Non59ugUgEu+UkNPXc+EQmPO5NALL5by0YkAohBXOb
        AcTB8ptIHPuHwdt0VIGHwTWWlA==
X-Google-Smtp-Source: ABdhPJy7faGa9yzHqcrlQkICMPbNydxdH9Sq2jQtDUfIpdri8SkjZPBiZ1Euk2XsdhIl9XTFIRQ0pQ==
X-Received: by 2002:a17:907:62a1:: with SMTP id nd33mr439365ejc.303.1627491933732;
        Wed, 28 Jul 2021 10:05:33 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:33 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 04/14] bpf/tests: Add more tests of ALU32 and ALU64 bitwise operations
Date:   Wed, 28 Jul 2021 19:04:52 +0200
Message-Id: <20210728170502.351010-5-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests of BPF_AND, BPF_OR and BPF_XOR with different
magnitude of the immediate value. Mainly checking 32-bit JIT sub-word
handling and zero/sign extension.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 9695d13812df..67e7de776c12 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -3514,6 +3514,44 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffffffff } },
 	},
+	{
+		"ALU_AND_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
+			BPF_ALU32_IMM(BPF_AND, R0, 15),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 4 } }
+	},
+	{
+		"ALU_AND_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
+			BPF_ALU32_IMM(BPF_AND, R0, 0xafbfcfdf),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xa1b2c3d4 } }
+	},
+	{
+		"ALU_AND_K: Zero extension",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x0000000080a0c0e0LL),
+			BPF_ALU32_IMM(BPF_AND, R0, 0xf0f0f0f0),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
 	{
 		"ALU64_AND_K: 3 & 2 = 2",
 		.u.insns_int = {
@@ -3584,6 +3622,38 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU64_AND_K: Sign extension 1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x00000000090b0d0fLL),
+			BPF_ALU64_IMM(BPF_AND, R0, 0x0f0f0f0f),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
+	{
+		"ALU64_AND_K: Sign extension 2",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x0123456780a0c0e0LL),
+			BPF_ALU64_IMM(BPF_AND, R0, 0xf0f0f0f0),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
 	/* BPF_ALU | BPF_OR | BPF_X */
 	{
 		"ALU_OR_X: 1 | 2 = 3",
@@ -3656,6 +3726,44 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffffffff } },
 	},
+	{
+		"ALU_OR_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
+			BPF_ALU32_IMM(BPF_OR, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x01020305 } }
+	},
+	{
+		"ALU_OR_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
+			BPF_ALU32_IMM(BPF_OR, R0, 0xa0b0c0d0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xa1b2c3d4 } }
+	},
+	{
+		"ALU_OR_K: Zero extension",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x00000000f9fbfdffLL),
+			BPF_ALU32_IMM(BPF_OR, R0, 0xf0f0f0f0),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
 	{
 		"ALU64_OR_K: 1 | 2 = 3",
 		.u.insns_int = {
@@ -3726,6 +3834,38 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU64_OR_K: Sign extension 1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x012345678fafcfefLL),
+			BPF_ALU64_IMM(BPF_OR, R0, 0x0f0f0f0f),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
+	{
+		"ALU64_OR_K: Sign extension 2",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0xfffffffff9fbfdffLL),
+			BPF_ALU64_IMM(BPF_OR, R0, 0xf0f0f0f0),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
 	/* BPF_ALU | BPF_XOR | BPF_X */
 	{
 		"ALU_XOR_X: 5 ^ 6 = 3",
@@ -3798,6 +3938,44 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xfffffffe } },
 	},
+	{
+		"ALU_XOR_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
+			BPF_ALU32_IMM(BPF_XOR, R0, 15),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x0102030b } }
+	},
+	{
+		"ALU_XOR_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
+			BPF_ALU32_IMM(BPF_XOR, R0, 0xafbfcfdf),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x5e4d3c2b } }
+	},
+	{
+		"ALU_XOR_K: Zero extension",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x00000000795b3d1fLL),
+			BPF_ALU32_IMM(BPF_XOR, R0, 0xf0f0f0f0),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
 	{
 		"ALU64_XOR_K: 5 ^ 6 = 3",
 		.u.insns_int = {
@@ -3868,6 +4046,38 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU64_XOR_K: Sign extension 1",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0x0123456786a4c2e0LL),
+			BPF_ALU64_IMM(BPF_XOR, R0, 0x0f0f0f0f),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
+	{
+		"ALU64_XOR_K: Sign extension 2",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_LD_IMM64(R1, 0xfedcba98795b3d1fLL),
+			BPF_ALU64_IMM(BPF_XOR, R0, 0xf0f0f0f0),
+			BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
+			BPF_MOV32_IMM(R0, 2),
+			BPF_EXIT_INSN(),
+			BPF_MOV32_IMM(R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
 	/* BPF_ALU | BPF_LSH | BPF_X */
 	{
 		"ALU_LSH_X: 1 << 1 = 2",
-- 
2.25.1

