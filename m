Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2AF660202
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAFOWe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 09:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjAFOWd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 09:22:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4B7BDCA
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 06:22:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vm8so3801453ejc.2
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqSwrmyUfS8urhsTZW4x4sTLziqYtGvymWJdaJ6t66s=;
        b=I0Anb6qPLvnZOrgkpNUofR36jBrXm1hAdtVIdNTIdXfmfwKzN7ZabUTgkaJJwhg0S4
         +KOsPBIBpe52dfIIWVUs/bIq4ToNXPgAjzPQrMWyTMiS7oZI3jqjZVFEVbNs3wX5AHF0
         lbZTW/1NF4SbWlQzD8bpyJYUPuT23VVGUPIg5hARBYkC0MeziEI17BrRM916bZslfkty
         7tJaBWKix8oSxsDoTEKnB6XERf4UAv2Usga0UHWRDnyLHYydUWapZazxY3yeYsLp3cer
         m+sug2JzOx/2dUu085CeyHg3+4rjJn4rP+Sy4QY94adiooKUAlk2gZkd4s5PWuNm1NLS
         ttuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqSwrmyUfS8urhsTZW4x4sTLziqYtGvymWJdaJ6t66s=;
        b=PN1H97NJxLLkcp7CDmb41guMuvtsus4TaafNGrJ4YaYIN8fWTvlvGvc22XOOY4StJL
         JkeDismYawr8ZkjqNCDBHlTldqesm/v5B08Cv2JuLPd5KZPSAD+p/i702vDhCJ5UzRe3
         KQhMhkF/vT1GfkXy5ipPbi3J6x++UU2Gm/s5vnBxCdy7EOEtAo/oj9f73psW++eQFvPo
         b8fM/Olgoa//dd033iK/zU2N2qigdvNIYZNhleOFc/T3pTHd4SKqsVDKdBT3m/7uxCsA
         TNZNf15zjCzDSEpnKxWerhSs4VESvXiN6fHnAfhoaFG1oBrSCP0pjXWprB0ROWzUlQiR
         bz2A==
X-Gm-Message-State: AFqh2kqu7XyqDizbdhGswkVLloNGxVN7lzzbq6q1OIum95hvUa6MsWH5
        sdNvlfUFTbFy+i3y+2cqzZj6BQ1Q5e8=
X-Google-Smtp-Source: AMrXdXu2IonQ29D0KmM1sEHbyN4N5HV9dF1rTnJ63BCEafnnbyo8tzNKTZUM3OjqfOee/Ux/OpHR+g==
X-Received: by 2002:a17:906:9f28:b0:7c1:5b5e:4d85 with SMTP id fy40-20020a1709069f2800b007c15b5e4d85mr45378353ejc.51.1673014951114;
        Fri, 06 Jan 2023 06:22:31 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b007bdc2de90e6sm446730ejc.42.2023.01.06.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 06:22:30 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Verify copy_register_state() preserves parent/live fields
Date:   Fri,  6 Jan 2023 16:22:14 +0200
Message-Id: <20230106142214.1040390-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106142214.1040390-1-eddyz87@gmail.com>
References: <20230106142214.1040390-1-eddyz87@gmail.com>
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
2.39.0

