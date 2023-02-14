Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747F06971BB
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBNXVF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjBNXVC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:21:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A1311C8
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:21:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so294269wms.0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRfHZVUompfeyDdoexE+s0HNDq5fti0UrvErAsx7I4U=;
        b=QirosLt/DoAg68+MAox/1CbRBDDv3KjzegYe7lrEUtvZAn/a9iKgYbGcXGjtdxklMq
         K7Hhr4nxAsiIriQ4/aJmknQEIMsXI4AaML2eZBj6ezQAZ5vWQfjWqUWpbNCd3P5y0T4f
         7nrQuyTIibnwAinrSxcLOnDBhwo2kQnp3ISgMX/F/veW4uArBLSGMnO6baF0XJRG4Ieo
         HYec3i+yOcSjzo6KWmGpEA5efsS/o5jrhAhULcY1iecn5A3PhaG3Cdf8jcknllkwzdkV
         UHy32Keb/ls9msYA0im0ZUAGpSxwT6kQREh2jNFYmM+SLVZ7T0ZFhih/miJ2WojkSCtA
         shfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRfHZVUompfeyDdoexE+s0HNDq5fti0UrvErAsx7I4U=;
        b=UII9M2jN4kbr3A33x9pxeAALlEnABIdgILc83Hun4GvF0QsM9fbK5JK8pOVDrTxraG
         zB3wgW7lEz8+gSmQdVorBbOh98YuXLia/3rLyxmqwncrywGjJem3eaHa9pSCB9SpLvb6
         WoBDN3pYb1UPbBZb2AmltiWq2nFBrgm5iUlXrO4kv5pdJAjcS3EqDKoHJ/a8kv19wrDZ
         HWZivVJNpf3bu5FfHOv0YKuSOwUvyq133pUhtUC9CFW8dBfxZ1I50v+kwbft0USRE1gN
         8uGtfp+r2+zwzENKG/oXhprQlHaRTzT/SYeKgeDa4hbNCwxxX8azqZ44joT8vBDSNELq
         3ieg==
X-Gm-Message-State: AO0yUKWDBRaHgOKxIZDgSjfH/lKiJJuY4Tqdfw0UPL7tg+zlKs4b8g6U
        gvCoRbkVCKY+HCR04zvpnjXJ3FzQKv9zmA==
X-Google-Smtp-Source: AK7set8mDK3xetG1wRwqbrkceZ3vvENtn6cyOZGihQuWJFB6TmRFnxPCuKuWkLeaTuuqONmuZbee3w==
X-Received: by 2002:a05:600c:4da0:b0:3dc:51ad:9dc4 with SMTP id v32-20020a05600c4da000b003dc51ad9dc4mr417842wmp.18.1676416859871;
        Tue, 14 Feb 2023 15:20:59 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b47b80cec3sm168515wmb.42.2023.02.14.15.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:20:59 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: check if BPF_ST with variable offset preserves STACK_ZERO
Date:   Wed, 15 Feb 2023 01:20:30 +0200
Message-Id: <20230214232030.1502829-5-eddyz87@gmail.com>
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

A test case to verify that variable offset BPF_ST instruction
preserves STACK_ZERO marks when writes zeros, e.g. in the following
situation:

  *(u64*)(r10 - 8) = 0   ; STACK_ZERO marks for fp[-8]
  r0 = random(-7, -1)    ; some random number in range of [-7, -1]
  r0 += r10              ; r0 is now variable offset pointer to stack
  *(u8*)(r0) = 0         ; BPF_ST writing zero, STACK_ZERO mark for
                         ; fp[-8] should be preserved.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/bpf_st_mem.c       | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
index 932903f9e585..3af2501082b2 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
@@ -35,3 +35,33 @@
 	.expected_attach_type = BPF_SK_LOOKUP,
 	.runs = -1,
 },
+{
+	"BPF_ST_MEM stack imm zero, variable offset",
+	.insns = {
+	/* set fp[-16], fp[-24] to zeros */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -24, 0),
+	/* r0 = random value in range [-32, -15] */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_0, 16, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 32),
+	/* fp[r0] = 0, make a variable offset write of zero,
+	 *             this should preserve zero marks on stack.
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_10),
+	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
+	/* r0 = fp[-20], if variable offset write was tracked correctly
+	 *               r0 would be a known zero.
+	 */
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_10, -20),
+	/* Would fail return code verification if r0 range is not tracked correctly. */
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

