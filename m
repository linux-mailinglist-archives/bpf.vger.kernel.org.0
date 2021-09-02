Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B813FF38B
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbhIBSyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347221AbhIBSxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 14:53:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438EC06179A
        for <bpf@vger.kernel.org>; Thu,  2 Sep 2021 11:52:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc21so6684416ejc.7
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dXk1SLqGJIDTAcOIojysHatI5YP/3JqrEvoxslUkeQ=;
        b=x/TPC6caEkLS66fRLTYITw5qA4qfX4duT0pC5uLWfmI88IUxysw3pc3ZWp57xq0l+2
         K+sSRbddEe4QnwsGT2WXQnQ/n/sOBRsgUyz/Tjjg9GOqjZK4DwQxpB+XIIKwtx6167vx
         pkkmqk1AIw0wnu1hGlpQbCPeKd7smUYLtE0pSBgV+8hAtDPMGJje7pFjmmN4XJKfrU5p
         dutklYDNoDJxXSVhf0w3XLbNImAIxITyL7vAb1qy3ylABH0Uaw6CxD0KPd3QvECveCxz
         5N7EM+Na0KHZzBtRaU4bH1XS41RdHaMuF+NhOtdCS5ll/Q4dYPSdGL+5eZYp6gKw8jS4
         Xd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dXk1SLqGJIDTAcOIojysHatI5YP/3JqrEvoxslUkeQ=;
        b=mE0eHGWBl6hVSoyN7Oo92eaACW8eeMFknw2sckcTKv3f7QAX1kzu4qnvYUGLVu4ByD
         XCvrLNhaCk1FV/1PWbnLSwUokZCjmE+zD1uYw1Hyxi/SQhXm5CkpQVO9zCg9p7DIxDqY
         +OtFFsI/izsbTeuttuFmY6PQziKhYtmkEP6Y6/gOj9H7KtIHM7TfC0UJgIwosY/SkAlB
         7lU6kvPRFK9eJ8SZiWbPhNbQMrVgDRjEhMFJ0yyPUzFAaiYcNWEcFswZ1I1ETEhuUxoJ
         aazgpBlyt1wmmjJ16LHTLMbJPp7DQIaLoKup1oLt7WWCZGpSe80IJhvdhlbMzthYGWyc
         bxlA==
X-Gm-Message-State: AOAM532CPNaTErdLUef9p+1x2pwB31tSr+Ze0FTGWun45OgJoYQTUh3w
        HUGq6iYTXPuyYsznS3AgMSDgvw==
X-Google-Smtp-Source: ABdhPJxSCb7S1Yqw9wnJ9oiGUv9Vm01gOspjnPQZmzF5nKVnK3ENKob91pH3jxFmErNTjLqulm5EaA==
X-Received: by 2002:a17:906:b08e:: with SMTP id x14mr5268159ejy.40.1630608767925;
        Thu, 02 Sep 2021 11:52:47 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id mb14sm1592235ejb.81.2021.09.02.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:52:47 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        iii@linux.ibm.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 10/13] bpf/tests: Add JMP tests with degenerate conditional
Date:   Thu,  2 Sep 2021 20:52:26 +0200
Message-Id: <20210902185229.1840281-11-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
References: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
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
index c3d772f663da..b28cd815b6b7 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -10707,6 +10707,235 @@ static struct bpf_test tests[] = {
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
2.25.1

