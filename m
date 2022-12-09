Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FE648320
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLIN64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIN6y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:54 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3D75BFC
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:52 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gh17so11688744ejb.6
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0UShcuPPltA7nazPprqf2YmrY0QD6ji20xhTJBARHA=;
        b=mQfCHVjFgfDF63Pbvf9P3Bo8peSrUeiEfrN1p9JHDkh9zllQtf/Q//qnL1es2hoeyC
         EP2ZV/Wu9QqGMrgoaWh/3SRJMuRVYXa7EG3NRJ77m9MharvWRQm/BsHbT2+NUfqp12D9
         tbjXHQ0eHObz0hIhSQhPTt7NgrC0c50TJNprTdTOaSQ4bv7TYfSqGAJdblxrxcwLv/2M
         aNImIwyUVtfzaCYC4oLEN9wLsfyxZg2SExsy+ipDQuU9KG/iQPa44gd7JKHr1K2uDlOS
         GaNmUB2c/JLqF6buKNAWcIenkBAB7DmUR3hifegmOQUsIpHtGJJJcc5JwHZoW2JqNbXk
         Bu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0UShcuPPltA7nazPprqf2YmrY0QD6ji20xhTJBARHA=;
        b=PsHXfOJAWokmA8iH41iin/aQrZxE1Yy+iGkjnDxZ+Tsxnoe5QiMUoSqKTDrIEa8s7t
         zghyjjZtfuqMLomtaKtTzL/t9Nb8GukS3aJ0nef3uOHiKQV143uVoXzwhLuq6N4JAXUA
         hFMnD7ybiYH3ZHuQ3Buc2r+nh7dhu+bIXTBqu5JUwOAZ4jwQxC3Gjg+LGD+ERprV0vp9
         LRYcgCO4Z2HUxeJSrzxP32bLxUjYMWIFA5JuuHeEqDrqo11BT6qlsQMOdlJZDjAMMx2t
         0gBwoDiaWxk7epU6F0dCojDMs+NBvTWPOF82iiVY3yUvgDTYnN5/rqDrj1fH9OPVpDTq
         1W0A==
X-Gm-Message-State: ANoB5pmUu1rVgZYDTwRlH6NkTQfQ/YeC8hI4HqJ4k7peFH+RuBDsn2Ev
        y5oDsDlfLbZH38GkmkkdNCK0w5BipcGWOA==
X-Google-Smtp-Source: AA0mqf5m62txyql80Vgxnc/qSPLKhJD6/ajPiJalzM7ZewiwtKZ1T1KjQ4vyr6I7YbWpoMoqlhcU/g==
X-Received: by 2002:a17:906:a050:b0:7a4:bbce:ddae with SMTP id bg16-20020a170906a05000b007a4bbceddaemr5307348ejb.59.1670594331362;
        Fri, 09 Dec 2022 05:58:51 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:51 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/7] selftests/bpf: verify states_equal() maintains idmap across all frames
Date:   Fri,  9 Dec 2022 15:57:30 +0200
Message-Id: <20221209135733.28851-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209135733.28851-1-eddyz87@gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
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

A test case that would erroneously pass verification if
verifier.c:states_equal() maintains separate register ID mappings for
call frames.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 3193915c5ee6..bcd15b26dcee 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2305,3 +2305,85 @@
 	.errstr = "!read_ok",
 	.result = REJECT,
 },
+/* Make sure that verifier.c:states_equal() considers IDs from all
+ * frames when building 'idmap' for check_ids().
+ */
+{
+	"calls: check_ids() across call boundary",
+	.insns = {
+	/* Function main() */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	/* fp[-24] = map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NULL with some ID */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1,
+		      0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -24),
+	/* fp[-32] = map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NULL with some ID */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1,
+		      0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -32),
+	/* call foo(&fp[-24], &fp[-32])   ; both arguments have IDs in the current
+	 *                                ; stack frame
+	 */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -24),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -32),
+	BPF_CALL_REL(2),
+	/* exit 0 */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* Function foo()
+	 *
+	 * r9 = &frame[0].fp[-24]  ; save arguments in the callee saved registers,
+	 * r8 = &frame[0].fp[-32]  ; arguments are pointers to pointers to map value
+	 */
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
+	/* r7 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r6 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* if r6 > r7 goto +1      ; no new information about the state is derived from
+	 *                         ; this check, thus produced verifier states differ
+	 *                         ; only in 'insn_idx'
+	 * r9 = r8
+	 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
+	/* r9 = *r9                ; verifier get's to this point via two paths:
+	 *                         ; (I) one including r9 = r8, verified first;
+	 *                         ; (II) one excluding r9 = r8, verified next.
+	 *                         ; After load of *r9 to r9 the frame[0].fp[-24].id == r9.id.
+	 *                         ; Suppose that checkpoint is created here via path (I).
+	 *                         ; When verifying via (II) the r9.id must be compared against
+	 *                         ; frame[0].fp[-24].id, otherwise (I) and (II) would be
+	 *                         ; incorrectly deemed equivalent.
+	 * if r9 == 0 goto <exit>
+	 */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_9, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
+	/* r8 = *r8                ; read map value via r8, this is not safe
+	 * r0 = *r8                ; because r8 might be not equal to r9.
+	 */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_8, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_8, 0),
+	/* exit 0 */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.flags = BPF_F_TEST_STATE_FREQ,
+	.fixup_map_hash_8b = { 3, 9 },
+	.result = REJECT,
+	.errstr = "R8 invalid mem access 'map_value_or_null'",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "",
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+},
-- 
2.34.1

