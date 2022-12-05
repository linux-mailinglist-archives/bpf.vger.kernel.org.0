Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658B0642104
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiLEBSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 20:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiLEBST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 20:18:19 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2149FF2
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 17:18:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id o13so24310253ejm.1
        for <bpf@vger.kernel.org>; Sun, 04 Dec 2022 17:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NcksBI4HXArmLcx5zMXsTrah0VbT+Jqma5xLR+yDrU=;
        b=nKOr9dPqD/RrE8MU5uzCXftWFB7NbF8CjX95pOT98GR6wOu/SW8UkUntbIs9ArARyd
         QQ8ChOD3ATt5IUqbcWMPQ/wwy9/6YafSLMT5mlQ8vSc+9PIuwHPUyQUCfAQU5KawzRkN
         Mvqg/3Io6/BCtnvWCgtljbpnZQV01ssyrEDuVxSXF7PSZwM7nAqhgMW8LbPwQ4zN0YCx
         H8j0fXWJYE22SUPc5r0ZDi1J7jSgPZ0m6qtvnIA3jDIS4yntZUY1SxaBIQ5IGxtBndtp
         hdrygT1VsXeOe5823EoOjHNjTKHwLeBMExiPN/8ilzUA4UuQq+Hqfm78nhxBFiTMt4SY
         nmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NcksBI4HXArmLcx5zMXsTrah0VbT+Jqma5xLR+yDrU=;
        b=Rwk9CRUdyWyiZf6QG7CGnE3jy56KBVwM/hneRh+zFhZKpuj7y/wmAMhFo5Ra8DF7gs
         dgO3F9PSfwmDL9IfY6gGuGjXV5y/p9C4RYd6uQMesfAPPjSVamyuKEY54pmIp4DRoo63
         i13sVNPhWDkDmvACSHz3dLypIO+dyviwF8pbmvolU/q5Hz/sB9eNZBK2pqmvQxF3OO+W
         JjVNN0Htu7eaIWpjDowUxn+CmFwR2q+ugI0GlSz9H9MpLP+cRY7yBtaYBTdYVluwLDqN
         MjgbfTnRO1aJP8mZL/rlE/VPr0kKfmlLML2xZbTR2yI1vGwkBdKClrwBB3O+lqX/huDs
         bu9w==
X-Gm-Message-State: ANoB5plVZ96Ba+P53VZHcxygkGsz4FhYptY/ByAPq1Y6O5B3ur8iNt8+
        utzQlnP+k44m9dZ0/NJCFDQAAbzjASA=
X-Google-Smtp-Source: AA0mqf6In7/wg4DGjH5Pn63HiuQ2yQ0Qy9EuhieMKpb1J+tq4J+LMWuwmVQLwVWF59x3qZCGiRipfA==
X-Received: by 2002:a17:906:2302:b0:7b9:de77:f0ef with SMTP id l2-20020a170906230200b007b9de77f0efmr46771962eja.5.1670203096369;
        Sun, 04 Dec 2022 17:18:16 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906315200b007b935641971sm5686334eje.5.2022.12.04.17.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:18:16 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Verify copy_register_state() preserves parent/live fields
Date:   Mon,  5 Dec 2022 03:17:54 +0200
Message-Id: <20221205011754.310580-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205011754.310580-1-eddyz87@gmail.com>
References: <20221205011754.310580-1-eddyz87@gmail.com>
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

A testcase to check that verifier.c:copy_register_state() preserves
register parentage chain and livness information.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/search_pruning.c   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
index 68b14fdfebdb..d63fd8991b03 100644
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ b/tools/testing/selftests/bpf/verifier/search_pruning.c
@@ -225,3 +225,39 @@
 	.result_unpriv = ACCEPT,
 	.insn_processed = 15,
 },
+/* The test performs a conditional 64-bit write to a stack location
+ * fp[-8], this is followed by an unconditional 8-bit write to fp[-8],
+ * then data is read from fp[-8]. This sequence is unsafe.
+ *
+ * The test would be mistakenly marked as safe w/o dst register parent
+ * preservation in verifier.c:copy_register_state() function.
+ *
+ * Note the usage of BPF_F_TEST_STATE_FREQ to force creation of the
+ * checkpoint state after conditional 64-bit assignment.
+ */
+{
+	"write tracking and register parent chain bug",
+	.insns = {
+	/* r6 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* r0 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	/* if r0 > r6 goto +1 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_6, 1),
+	/* *(u64 *)(r10 - 8) = 0xdeadbeef */
+	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0xdeadbeef),
+	/* r1 = 42 */
+	BPF_MOV64_IMM(BPF_REG_1, 42),
+	/* *(u8 *)(r10 - 8) = r1 */
+	BPF_STX_MEM(BPF_B, BPF_REG_FP, BPF_REG_1, -8),
+	/* r2 = *(u64 *)(r10 - 8) */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_FP, -8),
+	/* exit(0) */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.flags = BPF_F_TEST_STATE_FREQ,
+	.errstr = "invalid read from stack off -8+1 size 8",
+	.result = REJECT,
+},
-- 
2.34.1

