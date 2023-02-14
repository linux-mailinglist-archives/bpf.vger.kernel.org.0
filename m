Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF286971B9
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBNXVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBNXVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:21:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8F828870
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:20:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so260934wmb.2
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MZXg4FU2MR+bjabTpSovsdR/BPwkkH0jRfiKm/AsWg=;
        b=FP554M6W5hRpECFoYzT4VwXGKWFYK63lddG08pwGOuOJR8XINTbo8hFs0roAWtx4RV
         aBSoIQJI/kNDPSmiid/d+ZV9RYcc4Pjak+TlUYvj599JjUda6LV1XoMZVjxDEd3SCn68
         630hCtdGc0NshyiBarg8NkHhBiGzbr91av6gsU2yty6QeN5WQMMTLcgnhjYq91yW5U1W
         EDAQewcRgDNlkyLRUMwpL7l7rc9ZhVxJMz/PwxfC84hpTyYD2tmWr2s+JNw+8MDgVsrv
         D2ih+wZjE6Hk2wB+cNcsxr0LTJIoPSAg5mbX315+XlFDBq74LTY5xoh3QavyG57w2ydE
         IuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MZXg4FU2MR+bjabTpSovsdR/BPwkkH0jRfiKm/AsWg=;
        b=KTb+OcCXWUb9x9XH90jKAdOWke2YbujSS5gtgCeeXe9JgbmB8mwtqBd6cIaObVveA/
         ZIaFUe0NETa89dI0dD7k8LUi3DD7suSroKtMQ2q3BKz8LKKJSlfCuzI1YCarn/iAkQe+
         eOvAf8fWq36khH4CeXQwJmxeMGMZldh0wFibhdFFxa6BnIXHJdQSUDbGrba/HRQKz/e8
         OpXOZ+3fXYjKuH3iPqKIS+g4UbWSh7phLuqlbMujxKbF3sMP920e21bAiyuhoVdeosaX
         JyGHW3XoP16ekjxIg3p8xL/nlzTsIYhovIVFXK/R6GsWY9jE3c3y2nrF5w/PmUJakdfe
         VP2A==
X-Gm-Message-State: AO0yUKXS6LcHhm7S0Nwf0NxnDvEc0DeTL+Ecnszu0OhUfViT3Zn80cPq
        +0cQNLZUwkGy8EoGn5TWfvbDMlbFa6GnMg==
X-Google-Smtp-Source: AK7set8JcWyQWcl3fRvrXAVGlBU09SwyqJCYEE73ZGjeWnMrL5y5rFLVYYkHL5RvCLxWOn2UO8ZJNw==
X-Received: by 2002:a05:600c:2b0f:b0:3da:22a6:7b6b with SMTP id y15-20020a05600c2b0f00b003da22a67b6bmr422382wme.13.1676416857566;
        Tue, 14 Feb 2023 15:20:57 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b47b80cec3sm168515wmb.42.2023.02.14.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:20:57 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: check if verifier tracks constants spilled by BPF_ST_MEM
Date:   Wed, 15 Feb 2023 01:20:28 +0200
Message-Id: <20230214232030.1502829-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214232030.1502829-1-eddyz87@gmail.com>
References: <20230214232030.1502829-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that verifier tracks the value of 'imm' spilled to stack by
BPF_ST_MEM instruction. Cover the following cases:
- write of non-zero constant to stack;
- write of a zero constant to stack.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/bpf_st_mem.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_mem.c

diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
new file mode 100644
index 000000000000..932903f9e585
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
@@ -0,0 +1,37 @@
+{
+	"BPF_ST_MEM stack imm non-zero",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 42),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, -42),
+	/* if value is tracked correctly R0 is zero */
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	/* Use prog type that requires return value in range [0, 1] */
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+	.expected_attach_type = BPF_SK_LOOKUP,
+	.runs = -1,
+},
+{
+	"BPF_ST_MEM stack imm zero",
+	.insns = {
+	/* mark stack 0000 0000 */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	/* read and sum a few bytes */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, -8),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, -4),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, -1),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	/* if value is tracked correctly R0 is zero */
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	/* Use prog type that requires return value in range [0, 1] */
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+	.expected_attach_type = BPF_SK_LOOKUP,
+	.runs = -1,
+},
-- 
2.39.1

