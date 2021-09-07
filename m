Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B314030EF
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbhIGWZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348709AbhIGWZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 18:25:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A2C06179A
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 15:24:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r7so70219edd.6
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Hoi4u2G8QSI9j8NSKtALs+4n115VKwNp7ykDTPYo/0=;
        b=I+8JwBdVzJ+ayEjXr3bm7ZAMRgaDCMMYC6/sjN9wx0+6Wwx2bqgRf+AQoDYV2LEC2y
         gRKM5HjxKIdN6KLahOUYW4YsqS3tX9CPrcAibe/cOxrwZwHSehybxbBcRbRDh5Objxd5
         ykO3p7Z5P2omOjHGgos7dzcOeqA1ZJN0/jMNpRz+WxYP7glc8U2/8nGwBgve61jVAYVZ
         LKR68dLYcAkdGy22RbO9AcZLjSFl/cMaR2B9HBn+yIekRazNDDEQKidfwhpZgYjAuEj4
         K5bbiBIHqoIv3z8njdqnFxZCE5qOmpsWyhv7UwyyhliJh6rym4BbAtFNNUCBUpeudxpl
         IKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Hoi4u2G8QSI9j8NSKtALs+4n115VKwNp7ykDTPYo/0=;
        b=R6LMm+zX+7iJdbp1U5xPfJnhNWpUXpQMpdTLXOodqWDMAHtD7swAKEUo2qDlZASWB3
         V97XH0nY6nqVec1/mrCwfjwD9OP15ZVeXip86CL/vYnLYH5fMJml3TsywL1nOrqUQh7z
         JfIVndtVjg+if/ymy7r8qU6SL7uY/3L7vkHeqB8b3qvvmkQWCHytbPLF2lVfTxKXFjgR
         U6LyQ2CX3A3QTJZUFthqIu/+2lVWI1e7t+KECWHzMXW+pb2ojg4pn1MF4FLhtgq0quIg
         CDJ8vuWhuYyhKeHVjV9MJiigUTobTdn596Ym0Ij0eNzsSe7Nc4vdH7mOGfgPsg9zrBog
         LWxQ==
X-Gm-Message-State: AOAM531T/cmM0yQfFJacBrPWEf9DeE48+vuQQKZageRuH2WDvIku2irb
        B8Pgq5RFNqEQnaANS3K1vcCOjg==
X-Google-Smtp-Source: ABdhPJy7swd6eI/NjrcwiSEAPou2swBQ1oUK7u0Rb0RnLK6xpm4x/Oap3lg2+jIMOYnt66pxPT2DeQ==
X-Received: by 2002:a05:6402:3188:: with SMTP id di8mr536275edb.300.1631053439113;
        Tue, 07 Sep 2021 15:23:59 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id gb24sm71772ejc.53.2021.09.07.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:23:58 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 10/13] bpf/tests: Add JMP tests with degenerate conditional
Date:   Wed,  8 Sep 2021 00:23:36 +0200
Message-Id: <20210907222339.4130924-11-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
References: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
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
2.25.1

