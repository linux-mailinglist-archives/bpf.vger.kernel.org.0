Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7283459BD13
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiHVJoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiHVJoG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 05:44:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442F24956
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 02:44:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so12487587wri.0
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GW6VO3bDCV3cOjadFb18VK/nIoxLpS7mggGURCBQh/g=;
        b=BF31rBsg+GgLoO/5lG7RtyZK60zH50bFra985p1mmPvB/NupNVwSd1JIVXEQNneKCs
         7fXyjfDFwvjshkg0zG7FhXLpOsXzDTVdA7xd+pWKP1tLQESlOKID2/nquC/aXc+fBbuM
         XDK+0j8lNJ3NFzrqd+amlpyQZvtFmRgTtw1SXYMIvfmAUni6K5kYmVowmbdpsWxEvyyP
         lalzVof0434+qrk8vG1ixc4tODxqxK0PImA2PZBfw8QpEDyJuu03j4R1hL4sEnKR47Dn
         tJvFHSNzczZ7bqNTpmCkoTyipy8s/A4dC8z6erK0R/z+VoRDOjy0tyRBHrei+SMxSBcc
         rTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GW6VO3bDCV3cOjadFb18VK/nIoxLpS7mggGURCBQh/g=;
        b=yJSUR7KAsbL+69Lb7MwIRGMQHLiWY4zVWunI5bk99/f1pScU8J5p7Z0uuMqzEUQhis
         2Qq68X4XeSAbi2rHyrmtoaYzxmBQN56eHRtoJee32LVBd/0VZ1bLbuNT5MAHS6MpIE4L
         6E5eUNenqCpl0icuH6xR1y3ERetlqHASrHn1+51uolEOjPnMtReA59vceZMAXiCbcLR/
         ActFl0zbe4Ot2GYOHr5LfFhDCDEsDoG5xf4+kwUqGIqgRPpEZubqhXdUDCVo8xLsJ7Pb
         GfZyrX8hiPGgRu+kVGWjIXOZKmn2hJ+iW1Og1cxP1qFeMIN7Hm5xtPR+Z4/sOkf/Cdkx
         fd3g==
X-Gm-Message-State: ACgBeo3oBI+gdSIJMOaySwWF1uNgeLruT9PBwFpHgbov/vdDzS1wdzZX
        0+IukOySrb2+NAkB/TIeyT3o3Um7mpx78lRi
X-Google-Smtp-Source: AA6agR73rKqg1PIcbNH+vOs2aaKEWlm/S0vH+8Z0NS1h0GUL/vqwM9nnwaJrI+keqTnuhcFAYEJfdA==
X-Received: by 2002:a5d:448d:0:b0:225:5862:e352 with SMTP id j13-20020a5d448d000000b002255862e352mr2601269wrq.560.1661161442477;
        Mon, 22 Aug 2022 02:44:02 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm14841558wms.17.2022.08.22.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 02:44:02 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 2/2] selftests/bpf: check nullness propagation for reg to reg comparisons
Date:   Mon, 22 Aug 2022 12:43:12 +0300
Message-Id: <20220822094312.175448-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822094312.175448-1-eddyz87@gmail.com>
References: <20220822094312.175448-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that nullness information is porpagated in the branches of
register to register JEQ and JNE operations.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/verifier/jeq_infer_not_null.c         | 186 ++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
new file mode 100644
index 000000000000..1af9fdd31f00
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
@@ -0,0 +1,186 @@
+{
+	/* This is equivalent to the following program:
+	 *
+	 *   r6 = skb->sk;
+	 *   r7 = sk_fullsock(r6);
+	 *   r0 = sk_fullsock(r6);
+	 *   if (r0 == 0) return 0;    (a)
+	 *   if (r0 != r7) return 0;   (b)
+	 *   *r7->type;                (c)
+	 *   return 0;
+	 *
+	 * It is safe to dereference r7 at point (c), because of (a) and (b).
+	 * The test verifies that relation r0 == r7 is propagated from (b) to (c).
+	 */
+	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch",
+	.insns = {
+	/* r6 = skb->sk; */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	/* if (r6 == 0) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* if (r0 == r7) r0 = *(r7->type); */
+	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
+	/* return 0 */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = ACCEPT,
+},
+{
+	/* Same as above, but verify that another branch of JNE still
+	 * prohibits access to PTR_MAYBE_NULL.
+	 */
+	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JNE true branch",
+	.insns = {
+	/* r6 = skb->sk */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	/* if (r6 == 0) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* if (r0 == r7) return 0; */
+	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 2), /* Use ! JNE ! */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* r0 = *(r7->type); */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
+	/* return 0 */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = REJECT,
+	.errstr = "R7 invalid mem access 'sock_or_null'",
+},
+{
+	/* Same as a first test, but not null should be inferred for JEQ branch */
+	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JEQ true branch",
+	.insns = {
+	/* r6 = skb->sk; */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	/* if (r6 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* if (r0 != r7) return 0; */
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 2), /* Use ! JEQ ! */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* r0 = *(r7->type); */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
+	/* return 0; */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = ACCEPT,
+},
+{
+	/* Same as above, but verify that another branch of JNE still
+	 * prohibits access to PTR_MAYBE_NULL.
+	 */
+	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JEQ false branch",
+	.insns = {
+	/* r6 = skb->sk; */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	/* if (r6 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* if (r0 != r7) r0 = *(r7->type); */
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
+	/* return 0; */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.result = REJECT,
+	.errstr = "R7 invalid mem access 'sock_or_null'",
+},
+{
+	/* Maps are treated in a different branch of `mark_ptr_not_null_reg`,
+	 * so separate test for maps case.
+	 */
+	"jne/jeq infer not null, PTR_TO_MAP_VALUE_OR_NULL -> PTR_TO_MAP_VALUE",
+	.insns = {
+	/* r9 = &some stack to use as key */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_9, -8),
+	/* r8 = process local map */
+	BPF_LD_MAP_FD(BPF_REG_8, 0),
+	/* r6 = map_lookup_elem(r8, r9); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* r7 = map_lookup_elem(r8, r9); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* if (r6 == 0) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* if (r6 != r7) return 0; */
+	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
+	/* read *r7; */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_xdp_sock, queue_id)),
+	/* return 0; */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_xskmap = { 3 },
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.result = ACCEPT,
+},
-- 
2.37.1

