Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9940597B
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbhIIOqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbhIIOqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:46:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A08C0613A3
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 07:33:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a25so4038593ejv.6
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrMA0XSQ71yLEbRWsyu+DocRPQut2y4m9TWpIdwAKEY=;
        b=zXshAqfhQgl6WVmPx7g27hSZkbGzdv3hgskRNFwspXFB02/TPqU9RSZWmtpDl6idZY
         3ja/YAgYt2dpie9Ti/XPcBefklEkEHUSX8j+8l6nbCNTHFfJ7YGd6yfshwG9TcwdDNkc
         xjgDNiRQVRt8YFYIKooUO+SoVF61Hw8ZaKHJwC7QO93/7NB+J7wMHDZLxJxZF5+a9pz6
         0Rj8iOWn4b9DuUN+AivKd0kSY6MVX9nuDPlzrBktBSZ+EnfUFcMfs5nH4T5W3ZJZ/CaB
         RKin8TpfTGcloSMqfwZyV6ADkEVcy0Qn8ULYUjF2+0u/Uo+YCKTGVatdnt0fDpTIqdWB
         tG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrMA0XSQ71yLEbRWsyu+DocRPQut2y4m9TWpIdwAKEY=;
        b=M0aoT25Zng5lAzMuS/J2z+ZefPd+lYXILWGhsk90C2KnU5J6CZeA0rfaeZmSsg3gO5
         JZcRgQMdhBhrF256Bb+VnJ7kP5I7tX5YzrVXwZeYRI9i1hiSH5yyxagUYSN0MaDfMpaQ
         F8WggKJFG38VRioZE7mTz1sVrkAd+tIdxLTB90oD1R4jyUPa1hDs98WLSML5bLoSDc10
         9yYEmVCPAqZOGwGtY8bPNFiExwLnMtsewkpBnDqt+cUP/uB9Cp6XFxwFYbH2yW/R8+EK
         L7xgHHVJlibRc7VPxbpPw1oUtF3PPOXLGu6ZuXTRm6NKm2VeJaYVabZbvvfCqJ04Wn37
         0a2Q==
X-Gm-Message-State: AOAM5336OnyueeRgrilAv/XBIeh05lQOb3Az/J1S3i0wddHn9EK77YHM
        y81Jf6FfNJBP+pNJhXXS2zU3n4gKkV/rOKXh
X-Google-Smtp-Source: ABdhPJx5EvBqW2pdSI18tgWWvd6+tnYwuU6klmk3qMwLWIbQgt1U+fHkZR1PgateQmPpkVkFTot57Q==
X-Received: by 2002:a17:906:f24d:: with SMTP id gy13mr3624452ejb.395.1631198004148;
        Thu, 09 Sep 2021 07:33:24 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bj10sm1030909ejb.17.2021.09.09.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:33:23 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v3 10/13] bpf/tests: Add JMP tests with degenerate conditional
Date:   Thu,  9 Sep 2021 16:33:00 +0200
Message-Id: <20210909143303.811171-11-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
References: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a set of tests for JMP and JMP32 operations where the
branch decision is know at JIT time. Mainly testing JIT behaviour.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 229 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7286cf347b95..ae261667ca0a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -10709,6 +10709,235 @@ static struct bpf_test tests[] = {
 		.fill_helper = bpf_fill_jmp32_jsle_reg,
 		.nr_testruns = NR_PATTERN_RUNS,
 	},
+	/* Conditional jumps with constant decision */
+	{
+		"JMP_JSET_K: imm = 0 -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_IMM(BPF_JSET, R1, 0, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JLT_K: imm = 0 -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_IMM(BPF_JLT, R1, 0, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JGE_K: imm = 0 -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_IMM(BPF_JGE, R1, 0, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JGT_K: imm = 0xffffffff -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_IMM(BPF_JGT, R1, U32_MAX, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JLE_K: imm = 0xffffffff -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_IMM(BPF_JLE, R1, U32_MAX, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP32_JSGT_K: imm = 0x7fffffff -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP32_IMM(BPF_JSGT, R1, S32_MAX, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP32_JSGE_K: imm = -0x80000000 -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP32_IMM(BPF_JSGE, R1, S32_MIN, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP32_JSLT_K: imm = -0x80000000 -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP32_IMM(BPF_JSLT, R1, S32_MIN, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP32_JSLE_K: imm = 0x7fffffff -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP32_IMM(BPF_JSLE, R1, S32_MAX, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JEQ_X: dst = src -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JEQ, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JGE_X: dst = src -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JGE, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JLE_X: dst = src -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JLE, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JSGE_X: dst = src -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JSGE, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JSLE_X: dst = src -> always taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JSLE, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+	},
+	{
+		"JMP_JNE_X: dst = src -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JNE, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JGT_X: dst = src -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JGT, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JLT_X: dst = src -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JLT, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JSGT_X: dst = src -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JSGT, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"JMP_JSLT_X: dst = src -> never taken",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_JMP_REG(BPF_JSLT, R1, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 0 } },
+	},
 	/* Short relative jumps */
 	{
 		"Short relative jump: offset=0",
-- 
2.30.2

