Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4D64831E
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLIN6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIN6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5754778
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:51 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f20so5008809lja.4
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkY/XWvbmBpF+aPRF1XnMxkztdOLE18mROLE5X78M7s=;
        b=XDxUAvMl/KgQEqiojkdpFcefu/4S0dTZ0wKasRJw0hlx24MwCtBEA4S5ySkU8dFNrz
         o7QKSwDOY1SqNqJ1E9nQzMQjJRiwmLP/8DBxdVXFynJqu/9Ao+klWECBgv9Qi89X20yu
         vbuufYbsrrt5X2zBEDrrnSItW+HpbCCrpKNpVzzlD0xdMoyneypwxKP3n8dOgenc/sxR
         blhvi8AOXKS2ezlMLsnThsMbcuiKtntcX6rrlpliFV34J6jWbKvMUDJ5DlvO/xMxIbhm
         lk9ksTk+erR2gQLbS/n3++YN3faP3RXokjTlcBYZhmFFpCNLQbs53EpiDsBP64mkWJx5
         sD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkY/XWvbmBpF+aPRF1XnMxkztdOLE18mROLE5X78M7s=;
        b=eJMJ13+olghiHLuixpw2NdyKKaEf/1Fsay89P3j5rH3XxFwnEa5ejlR/HTpwgfFkUg
         OpT8XZWVwAabg5ZOD0co1Paei51r+ZnfqKU6b3ScBglpHtfo51VJ0f/irC0B384KmJc0
         rsksLgk0oC2OdmUcJT7IY0Tg9UgbmNHz5EQryc0cUAvHxjeL13sTJebYLxOmLJ0dy1Yj
         lJthxIFyKejP53ZEBYPX5hm2ID3uyotuoSJHQfMSL9qXXBoBleIMZhYtIukLWXJMhSR7
         AEac50VSDrT7pACYEpcru64fFfMCMUuwWmvTMy/qUKMtR6FGPnQgsnyebggLKXmGbmHY
         H4og==
X-Gm-Message-State: ANoB5plj3V6dBi53ylgcvtR7ZCX79Scn+uU9BSOj+EtTiJLiwohvdAlI
        q/RKz3NipTZ4R300vkDZf+2Jv6Pkbre2AA==
X-Google-Smtp-Source: AA0mqf5HOE7ZtgjZdiX6Xx2mUHG3e/Lub7/IukXh/gQMPW2QHaqYmdfWJ1/63/ETB55Jpgm3eqOBcA==
X-Received: by 2002:a2e:b74e:0:b0:27a:3a56:3e29 with SMTP id k14-20020a2eb74e000000b0027a3a563e29mr444475ljo.45.1670594328588;
        Fri, 09 Dec 2022 05:58:48 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:48 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/7] selftests/bpf: test cases for regsafe() bug skipping check_id()
Date:   Fri,  9 Dec 2022 15:57:28 +0200
Message-Id: <20221209135733.28851-3-eddyz87@gmail.com>
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

Under certain conditions it was possible for verifier.c:regsafe() to
skip check_id() call. This commit adds negative test cases previously
errorneously accepted as safe.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/verifier/direct_packet_access.c       | 54 +++++++++++++++++++
 .../selftests/bpf/verifier/value_or_null.c    | 49 +++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
index 11acd1855acf..dce2e28aeb43 100644
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
@@ -654,3 +654,57 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	"direct packet access: test30 (check_id() in regsafe(), bad access)",
+	.insns = {
+	/* r9 = ctx */
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	/* r7 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r6 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* r2 = ctx->data
+	 * r3 = ctx->data
+	 * r4 = ctx->data_end
+	 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_9, offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_9, offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_9, offsetof(struct __sk_buff, data_end)),
+	/* if r6 > 100 goto exit
+	 * if r7 > 100 goto exit
+	 */
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 100, 9),
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 100, 8),
+	/* r2 += r6              ; this forces assignment of ID to r2
+	 * r2 += 1               ; get some fixed off for r2
+	 * r3 += r7              ; this forces assignment of ID to r3
+	 * r3 += 1               ; get some fixed off for r3
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
+	/* if r6 > r7 goto +1    ; no new information about the state is derived from
+	 *                       ; this check, thus produced verifier states differ
+	 *                       ; only in 'insn_idx'
+	 * r2 = r3               ; optionally share ID between r2 and r3
+	 */
+	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_3),
+	/* if r3 > ctx->data_end goto exit */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 1),
+	/* r5 = *(u8 *) (r2 - 1) ; access packet memory using r2,
+	 *                       ; this is not always safe
+	 */
+	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_2, -1),
+	/* exit(0) */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.flags = BPF_F_TEST_STATE_FREQ,
+	.result = REJECT,
+	.errstr = "invalid access to packet, off=0 size=1, R2",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
diff --git a/tools/testing/selftests/bpf/verifier/value_or_null.c b/tools/testing/selftests/bpf/verifier/value_or_null.c
index 3ecb70a3d939..52a8bca14f03 100644
--- a/tools/testing/selftests/bpf/verifier/value_or_null.c
+++ b/tools/testing/selftests/bpf/verifier/value_or_null.c
@@ -169,3 +169,52 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = ACCEPT,
 },
+{
+	"MAP_VALUE_OR_NULL check_ids() in regsafe()",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	/* r9 = map_lookup_elem(...) */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1,
+		      0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
+	/* r8 = map_lookup_elem(...) */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1,
+		      0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	/* r7 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r6 = ktime_get_ns() */
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* if r6 > r7 goto +1    ; no new information about the state is derived from
+	 *                       ; this check, thus produced verifier states differ
+	 *                       ; only in 'insn_idx'
+	 * r9 = r8               ; optionally share ID between r9 and r8
+	 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
+	/* if r9 == 0 goto <exit> */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
+	/* read map value via r8, this is not always
+	 * safe because r8 might be not equal to r9.
+	 */
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

