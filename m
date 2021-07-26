Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743EE3D554B
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhGZHiK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhGZHiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF526C061760
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u12so9459616eds.2
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEbBgT9KUgFMR4F2JhORtf43do/IC8QDrTSxMkyYPAs=;
        b=m7U8yj3NhDBoi4i/ihlJiCagxcyGwCnsNmshZvxYR8c59B/97ampFlxzh2JEpKmLfe
         fTCaBxJf8Yncbge3rHGxNjCjN55n984tUlHTqx59YbuZU+6VtO+/U1zTTVxlRyVC6Fi6
         kTQ9icnpz9r3mtgngUH1ZzzS+uWbusN+dQMapyXneYhSNkmjB/ZFJBCTDdpGRlFKW4lS
         QAC+qVwrkZ/sD41cH6S/aBA2xQ640EFKbz6oEr9IJjNC3ZmiIWcnGzQDk4652BXbeEhS
         /LFoXYvwqDE//CPeOgG96bdZMdZHcw3B/KIWUSngtG4J/PKQabtGBDehO0ogH9el8/Ic
         gSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEbBgT9KUgFMR4F2JhORtf43do/IC8QDrTSxMkyYPAs=;
        b=g0ki48AmoE9k4/1Eo7SAW9YO5MmFVKJH1MQo1JS+yD4L3x/mgArpGVKLVFlwLYrej7
         lipW1vTXqlgv41NzwXPTMQic/nTQdFohac7NYVwhYD3c2uifiZZqyQmqKpnC3uB1PHIX
         ciIR0DfOFrpz9iGZSlyvp/cbZtrq3ajdf+col/WE0Lf+PW25JDIyERrkwiWLYrDt3sVD
         S+mFkm+YYwW/W9zFhulX0FqNJTv0RzNcWucCJ10V5JRMB6ArWIiXlOQdu2Yj9QVTpoE8
         mbzgIHGQO+5hUq02q1wq03t0yoY7r+W3Lg9k1+o64hNp90LPYYaBQTkxHIGd/hMw4UJG
         DpJw==
X-Gm-Message-State: AOAM530KI+FdOQU5WVJ/79u/ik+aLiqEw5urZ4Bo3OLV36KPdsHeurqE
        vMCtdWAWfSJjIyaBR1w0PQ5GeQ==
X-Google-Smtp-Source: ABdhPJxDx+R6zjU56/txwjIQ9ogF4wIfg14UiR+Z5kr9E1fCuox2/k0t04wrOB2XMCn8CNUf7HrNiA==
X-Received: by 2002:aa7:d352:: with SMTP id m18mr20690042edr.235.1627287512437;
        Mon, 26 Jul 2021 01:18:32 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:32 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 04/14] bpf/tests: add more tests of ALU32 and ALU64 bitwise operations
Date:   Mon, 26 Jul 2021 10:17:28 +0200
Message-Id: <20210726081738.1833704-5-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
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

