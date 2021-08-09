Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002F93E4260
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhHIJT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhHIJTK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A32C061798
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gs8so27656332ejc.13
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLIKNyHzrBewFnJ7SQG7VgJD3e9wDbcV4oYlNStNwLU=;
        b=JtFHbvYWp5+Eq0Gc5l/rELtoIbiBrzfKrFZ9ZcArZ+mRhMjfXu565OzTtJ5XT0y0GP
         PmiBbo5gwaOq+l52ogHz9mtiaN2Ie0ZOdv9MAe+kZnjqnuVJc/x1EEGUUeXKefDkOsqu
         /hdEyniJT5+LYRUIC5cQQkKEIWU5Cwh8zWZX2OOwcU9VH0Ub/UFW1C/ngomz2Evp6Alp
         IKpf2Wx1VJHKRwmd9YmX186R5EMTxWKsAkuNpuJPZr+ZatmvOQurPLPU4Oc10PwXYG8o
         0AhmlqUJBbYHy/vfDBt0INiRlzqLGWg0TsAWN0d9nt3Q1EHIMh6bQjhm3aSvO1Okkj46
         U5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLIKNyHzrBewFnJ7SQG7VgJD3e9wDbcV4oYlNStNwLU=;
        b=UL3XE0fx/26gfQVwVoglqPlZLWyt/RvDTltyDGdN+Kf5MjuJnFLNZMEk9PnZjVLaea
         LTWfFt1Et7QodkWjc7DTbuHm3046ngyvSCT4WDpuMQdeoxSo2Xw5EZNr4wjR4ODuZxc8
         bViwT/ia4dJQNnOGBrbPfUxYqZlmefjSOyuRfNioh+5XRlmjDsuchKqDbb1OFj221d6Z
         SDW+mc3U+wqwYCXHZCC78Qo46aEW3koasvH6zDSFwC6kOKdKapT6XDnzfiBCTIL0IHIm
         HZA/P38a+bqSCSNG79nT1QycUSNZd1jbMqQcZ1NTNJ3jhHtQAKrPdUn4ockazBpLk+Ze
         5NBg==
X-Gm-Message-State: AOAM530QDfNowC0fmDsvSQMhZcl9f+EISIlPOD+EAsEM62hJ7uaMkMWC
        sdAUawtU3hsIvzV34n0+nWjY7Q==
X-Google-Smtp-Source: ABdhPJyGBb2tgCfXQAcbX4LRHU5CG4zU3dhF1mSqMYJwHhm7reoYQZPlUsr9dLhV9LxihIB2X1ELuw==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr21442861ejn.57.1628500728838;
        Mon, 09 Aug 2021 02:18:48 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:48 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 07/14] bpf/tests: Add more ALU64 BPF_MUL tests
Date:   Mon,  9 Aug 2021 11:18:22 +0200
Message-Id: <20210809091829.810076-8-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds BPF_MUL tests for 64x32 and 64x64 multiply. Mainly
testing 32-bit JITs that implement ALU64 operations with two 32-bit
CPU registers per operand.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index b95bed03ab1b..072f9c51bd9b 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -3051,6 +3051,31 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 2147483647 } },
 	},
+	{
+		"ALU64_MUL_X: 64x64 multiply, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
+			BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
+			BPF_ALU64_REG(BPF_MUL, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xe5618cf0 } }
+	},
+	{
+		"ALU64_MUL_X: 64x64 multiply, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
+			BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
+			BPF_ALU64_REG(BPF_MUL, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x2236d88f } }
+	},
 	/* BPF_ALU | BPF_MUL | BPF_K */
 	{
 		"ALU_MUL_K: 2 * 3 = 6",
@@ -3161,6 +3186,29 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU64_MUL_K: 64x32 multiply, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xe242d208 } }
+	},
+	{
+		"ALU64_MUL_K: 64x32 multiply, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xc28f5c28 } }
+	},
 	/* BPF_ALU | BPF_DIV | BPF_X */
 	{
 		"ALU_DIV_X: 6 / 2 = 3",
-- 
2.25.1

