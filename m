Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74CF3E4268
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhHIJTK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhHIJTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A6C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w5so3605343ejq.2
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivItAJWaysrbfF/J+Y6JuP9ZojNub1x2UM33Bx6oxug=;
        b=pl+HU7EFTU+Jqhx054rLSLXWCgK1DY2sZUV6iol55nBdGDiTaewMlxFlHslRBhg0S8
         69qUDRUpR5/fttQ+mM0HnkhPRd2xgh5FGCYhoud592T7tB0WThNYgLSJukDndj0TUxYh
         TbN83A1NELThUUbX5q2lSwAwQ5GvkpfNwAtXKP3EmqwVr2MsYGId02Tf3qZWOda8h/6O
         kiFnh1t44+chd6GLhOKY3gfgJ6e+eDA74Ma33PwetfpwTXh/fqGin/a324BsBX2Yth72
         icVRjbtXjrfkMJSz49dRqhQSjYoGElDMChKy83GjZzXl1mMMLLIJWFbPaum1eNiqTUbM
         UHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivItAJWaysrbfF/J+Y6JuP9ZojNub1x2UM33Bx6oxug=;
        b=oTSgi7IIela4+lYyzhehi+IQj3MMFeekU5wCmU0pfSOh/Lkwo2wp5YWPKws9uc695P
         qodZijn3oVfRkqhJEaUoX8N9jZ+zxxwybFsB6AaackAEQY5jUHCwbtjS+rKfgdJED8UI
         SmIWyAm10Cd+/ZLBQabjYHPyiIrAeBxMr/REf9+Hr7VeznGect9j7Vgye2Yh8GuTAzrf
         bBXizmynAG9loX71w0727bpxWfV12TmHl/yBOogSqEOgMF2h7TXMTBinq1BaQ03h6sJz
         fQl5DdGQUcV0m8r20whTMlZeWWszQKnBnGNZA64HYsJKhso/e79YxuvQdfQ54Ubjl3UT
         NDiw==
X-Gm-Message-State: AOAM5301OrNjpDvkY+wHItRP1+ss9nsiExd35FHAPFBmpDWgSyK9NnnZ
        amV7d+y5S9smL7Ym0RZbOCGQMA==
X-Google-Smtp-Source: ABdhPJxvvaBXxLXVcdNNvg7SCIIyjG3ZBZmxv2fl4IOxoYa1Ga5s7xoQdpQXjDfvwSmkWuiQlJhn9A==
X-Received: by 2002:a17:906:3888:: with SMTP id q8mr21266286ejd.269.1628500722182;
        Mon, 09 Aug 2021 02:18:42 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:41 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 01/14] bpf/tests: Add BPF_JMP32 test cases
Date:   Mon,  9 Aug 2021 11:18:16 +0200
Message-Id: <20210809091829.810076-2-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An eBPF JIT may implement JMP32 operations in a different way than JMP,
especially on 32-bit architectures. This patch adds a series of tests
for JMP32 operations, mainly for testing JITs.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 lib/test_bpf.c | 511 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 511 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index f6d5d30d01bf..377e866764cb 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4398,6 +4398,517 @@ static struct bpf_test tests[] = {
 		{ { 0, 4134 } },
 		.fill_helper = bpf_fill_stxdw,
 	},
+	/* BPF_JMP32 | BPF_JEQ | BPF_K */
+	{
+		"JMP32_JEQ_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 123),
+			BPF_JMP32_IMM(BPF_JEQ, R0, 321, 1),
+			BPF_JMP32_IMM(BPF_JEQ, R0, 123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 123 } }
+	},
+	{
+		"JMP32_JEQ_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
+			BPF_JMP32_IMM(BPF_JEQ, R0, 12345678 & 0xffff, 1),
+			BPF_JMP32_IMM(BPF_JEQ, R0, 12345678, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 12345678 } }
+	},
+	{
+		"JMP32_JEQ_K: negative immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JEQ, R0,  123, 1),
+			BPF_JMP32_IMM(BPF_JEQ, R0, -123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	/* BPF_JMP32 | BPF_JEQ | BPF_X */
+	{
+		"JMP32_JEQ_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 1234),
+			BPF_ALU32_IMM(BPF_MOV, R1, 4321),
+			BPF_JMP32_REG(BPF_JEQ, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 1234),
+			BPF_JMP32_REG(BPF_JEQ, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1234 } }
+	},
+	/* BPF_JMP32 | BPF_JNE | BPF_K */
+	{
+		"JMP32_JNE_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 123),
+			BPF_JMP32_IMM(BPF_JNE, R0, 123, 1),
+			BPF_JMP32_IMM(BPF_JNE, R0, 321, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 123 } }
+	},
+	{
+		"JMP32_JNE_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
+			BPF_JMP32_IMM(BPF_JNE, R0, 12345678, 1),
+			BPF_JMP32_IMM(BPF_JNE, R0, 12345678 & 0xffff, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 12345678 } }
+	},
+	{
+		"JMP32_JNE_K: negative immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JNE, R0, -123, 1),
+			BPF_JMP32_IMM(BPF_JNE, R0,  123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	/* BPF_JMP32 | BPF_JNE | BPF_X */
+	{
+		"JMP32_JNE_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 1234),
+			BPF_ALU32_IMM(BPF_MOV, R1, 1234),
+			BPF_JMP32_REG(BPF_JNE, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 4321),
+			BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1234 } }
+	},
+	/* BPF_JMP32 | BPF_JSET | BPF_K */
+	{
+		"JMP32_JSET_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 1),
+			BPF_JMP32_IMM(BPF_JSET, R0, 2, 1),
+			BPF_JMP32_IMM(BPF_JSET, R0, 3, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
+	{
+		"JMP32_JSET_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x40000000),
+			BPF_JMP32_IMM(BPF_JSET, R0, 0x3fffffff, 1),
+			BPF_JMP32_IMM(BPF_JSET, R0, 0x60000000, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x40000000 } }
+	},
+	{
+		"JMP32_JSET_K: negative immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JSET, R0, -1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	/* BPF_JMP32 | BPF_JSET | BPF_X */
+	{
+		"JMP32_JSET_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 8),
+			BPF_ALU32_IMM(BPF_MOV, R1, 7),
+			BPF_JMP32_REG(BPF_JSET, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 8 | 2),
+			BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 8 } }
+	},
+	/* BPF_JMP32 | BPF_JGT | BPF_K */
+	{
+		"JMP32_JGT_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 123),
+			BPF_JMP32_IMM(BPF_JGT, R0, 123, 1),
+			BPF_JMP32_IMM(BPF_JGT, R0, 122, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 123 } }
+	},
+	{
+		"JMP32_JGT_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_JMP32_IMM(BPF_JGT, R0, 0xffffffff, 1),
+			BPF_JMP32_IMM(BPF_JGT, R0, 0xfffffffd, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JGT | BPF_X */
+	{
+		"JMP32_JGT_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
+			BPF_JMP32_REG(BPF_JGT, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
+			BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JGE | BPF_K */
+	{
+		"JMP32_JGE_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 123),
+			BPF_JMP32_IMM(BPF_JGE, R0, 124, 1),
+			BPF_JMP32_IMM(BPF_JGE, R0, 123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 123 } }
+	},
+	{
+		"JMP32_JGE_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_JMP32_IMM(BPF_JGE, R0, 0xffffffff, 1),
+			BPF_JMP32_IMM(BPF_JGE, R0, 0xfffffffe, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JGE | BPF_X */
+	{
+		"JMP32_JGE_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
+			BPF_JMP32_REG(BPF_JGE, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
+			BPF_JMP32_REG(BPF_JGE, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JLT | BPF_K */
+	{
+		"JMP32_JLT_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 123),
+			BPF_JMP32_IMM(BPF_JLT, R0, 123, 1),
+			BPF_JMP32_IMM(BPF_JLT, R0, 124, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 123 } }
+	},
+	{
+		"JMP32_JLT_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_JMP32_IMM(BPF_JLT, R0, 0xfffffffd, 1),
+			BPF_JMP32_IMM(BPF_JLT, R0, 0xffffffff, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JLT | BPF_X */
+	{
+		"JMP32_JLT_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
+			BPF_JMP32_REG(BPF_JLT, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
+			BPF_JMP32_REG(BPF_JLT, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JLE | BPF_K */
+	{
+		"JMP32_JLE_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 123),
+			BPF_JMP32_IMM(BPF_JLE, R0, 122, 1),
+			BPF_JMP32_IMM(BPF_JLE, R0, 123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 123 } }
+	},
+	{
+		"JMP32_JLE_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffd, 1),
+			BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffe, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JLE | BPF_X */
+	{
+		"JMP32_JLE_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
+			BPF_JMP32_REG(BPF_JLE, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
+			BPF_JMP32_REG(BPF_JLE, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfffffffe } }
+	},
+	/* BPF_JMP32 | BPF_JSGT | BPF_K */
+	{
+		"JMP32_JSGT_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JSGT, R0, -123, 1),
+			BPF_JMP32_IMM(BPF_JSGT, R0, -124, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	{
+		"JMP32_JSGT_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_JMP32_IMM(BPF_JSGT, R0, -12345678, 1),
+			BPF_JMP32_IMM(BPF_JSGT, R0, -12345679, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSGT | BPF_X */
+	{
+		"JMP32_JSGT_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
+			BPF_JMP32_REG(BPF_JSGT, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
+			BPF_JMP32_REG(BPF_JSGT, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSGE | BPF_K */
+	{
+		"JMP32_JSGE_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JSGE, R0, -122, 1),
+			BPF_JMP32_IMM(BPF_JSGE, R0, -123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	{
+		"JMP32_JSGE_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_JMP32_IMM(BPF_JSGE, R0, -12345677, 1),
+			BPF_JMP32_IMM(BPF_JSGE, R0, -12345678, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSGE | BPF_X */
+	{
+		"JMP32_JSGE_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
+			BPF_JMP32_REG(BPF_JSGE, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
+			BPF_JMP32_REG(BPF_JSGE, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSLT | BPF_K */
+	{
+		"JMP32_JSLT_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JSLT, R0, -123, 1),
+			BPF_JMP32_IMM(BPF_JSLT, R0, -122, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	{
+		"JMP32_JSLT_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_JMP32_IMM(BPF_JSLT, R0, -12345678, 1),
+			BPF_JMP32_IMM(BPF_JSLT, R0, -12345677, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSLT | BPF_X */
+	{
+		"JMP32_JSLT_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
+			BPF_JMP32_REG(BPF_JSLT, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
+			BPF_JMP32_REG(BPF_JSLT, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSLE | BPF_K */
+	{
+		"JMP32_JSLE_K: Small immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_JMP32_IMM(BPF_JSLE, R0, -124, 1),
+			BPF_JMP32_IMM(BPF_JSLE, R0, -123, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	{
+		"JMP32_JSLE_K: Large immediate",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_JMP32_IMM(BPF_JSLE, R0, -12345679, 1),
+			BPF_JMP32_IMM(BPF_JSLE, R0, -12345678, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
+	/* BPF_JMP32 | BPF_JSLE | BPF_K */
+	{
+		"JMP32_JSLE_X",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
+			BPF_JMP32_REG(BPF_JSLE, R0, R1, 2),
+			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
+			BPF_JMP32_REG(BPF_JSLE, R0, R1, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -12345678 } }
+	},
 	/* BPF_JMP | BPF_EXIT */
 	{
 		"JMP_EXIT",
-- 
2.25.1

