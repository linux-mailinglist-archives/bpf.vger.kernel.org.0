Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC673E4263
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhHIJTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhHIJTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F3C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z11so23497954edb.11
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVbRKwcYZsowM9HPxnzGwN1JduAyXTyTDesTtMGR0Po=;
        b=U7pCEqX7RD78CWqSMGhVkfpzmUtnbw+C7k8SBIykLrHDVtD9/QsQgp5d9efd+8b0nb
         9+2kkDrKEl2GB05vzLwdh5slXdPw26mGIbuD0hYIxF+DVB3ecWZKyIAHQPkR/+EGZ+pt
         ogxXnZJT7wAUmrPPi36UjjgR8GNtk1rCt97wArNBijP/7C2puP16gGeFoLpo519ZAgwE
         VQ/OZ/aNcGjF/Am1RW8+AdHEOuzE8kbSdelAiUBbg9WL7HASPX7Vt/C0kZz6UWa6sXTT
         T5QJGkhilwKylaoEzqfdt39sw0fCykpusSSS1ID34oYudvhR1oJN7a5E/g2ua7nX2CZx
         1BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVbRKwcYZsowM9HPxnzGwN1JduAyXTyTDesTtMGR0Po=;
        b=D8GBFw5JnTVap/6/pFen1J8wjcKUjB843o2RKH2Cm3nP0SovHF8pFhJ7eKmfS4Hmq9
         GOY1PAiORJSxjpEEHD6uWxeG9TycqNHFtphLoxRF3fhBmmlrTLzNEC0rYrjFGm5yhBLb
         BrqlWyUVONtoVxSN2F3kER16mwawe0De+2kxZgMbdaATQHKBI4ztqzrCCKEaIhhIIu+7
         8JNU7PZM4F/OavPYKEF123K8gd1IIj9yEExk8shW7dbfaDv6sgPauIkPzr0Yiicsltvs
         fGKqnirMKtxqqMUqFC8TbKCX3dM46iN3j0bOPgiexKwJVfkU5z5fDq+s3MZkdyMZBo9I
         Cduw==
X-Gm-Message-State: AOAM532YVr9hZkqOEJQhiLXG5tQLtS+s3OO07wZ+qrgNky6xjBvTVcKZ
        2aSL8k68C2wPOjIPtnZZ8+5+UssGfQWkS6aW+Oc=
X-Google-Smtp-Source: ABdhPJxgl9r1t3WZvdZLqbvpHGq6sh45Kw+wg+F3tWf9eHDnp6HAcS6hT612XkQUqKI7AjNsrgOTCw==
X-Received: by 2002:a05:6402:10d6:: with SMTP id p22mr14456321edu.168.1628500725409;
        Mon, 09 Aug 2021 02:18:45 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:45 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 04/14] bpf/tests: Add more tests of ALU32 and ALU64 bitwise operations
Date:   Mon,  9 Aug 2021 11:18:19 +0200
Message-Id: <20210809091829.810076-5-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests of BPF_AND, BPF_OR and BPF_XOR with different
magnitude of the immediate value. Mainly checking 32-bit JIT sub-word
handling and zero/sign extension.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 lib/test_bpf.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ec36a8bfa3f9..73c2ea0cb13b 100644
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

