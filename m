Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD225A2D80
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiHZRaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHZRaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:30:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386107172E
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:30:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w19so4415335ejc.7
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xwWJr3KXk5FI/Lu0S/kdDeP3TU26z9zp15vm0h3W7jE=;
        b=a2udOxIUU2REKnnC90RBA/FfCj+c+yZrWsTFrXW9fWArUuIQC5qDpHurWDlXuULqB/
         K4GL22HUSKpQb6ulJW4f56k0Jti15CEosRWfvRe8voMMucgP2oDEjXGFymHyXHJz5Ap9
         /0bhgTSh0CtP9xbGWiic/ThQ+d2VNs/5yGlR5ZhvIw4KqGAie8l0NMK9Ct/XlmBb9nKH
         5I5RlNYV9U0VDIi7MYEtPmmBDMTJ9irOX1rmDxLr2btGV5wM45i2qlt03UGX7OchNjk+
         pQelV23NgqYUhe2OXrYgQaGAVZSQ+PyjsOIuS92D1jKT07apbxwlZ2r8at0PjNBdo/qS
         JtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xwWJr3KXk5FI/Lu0S/kdDeP3TU26z9zp15vm0h3W7jE=;
        b=nLj+wKuzMMn+7hsAOVqIfaLoChVq53X7jVUsTo70VE8rhj4X/KteHC1Th830ptLkpn
         jeFTpxUDEMuO7d3y1LF6kxrm5+ACJCqCavmexyWnzTuvaxlQaurXALl/GGqfj/FpmghJ
         CV2ohvTIzSYG4tazeUm+WwEVlxohOuZ1AuX2XzyRSqHnPHV5v4goqfhEmu5yR2sySSoP
         f2sY9vjEtNjxa7BwsyhOv8gQ9ol9+EnGTPGAGvCXUvpexAXDLjNxdBOmTfHEuJldfjn7
         rZpUYhOcwXn2LwvSnFruE65cJfxrgyBtux21ADjUsxrp9j8f36qaE/0lQpAtir4axcgd
         qk0Q==
X-Gm-Message-State: ACgBeo3ZAVE5T7mMd+ME6pDZQNSHsLzl7FYXoHpbEm3Jf1mTZR94UPEG
        gAEUkmxvu7PSi2CEgHeiUqI6RJJVMf4GtoUw
X-Google-Smtp-Source: AA6agR7kRJ1qpRiq5NRCok68XuaiobRy5C+GxXYTjj4bWrSkQ+AhyQh4FA2ZZbZ+TWzhh2LMlXweDw==
X-Received: by 2002:a17:907:9693:b0:73d:cc84:deb with SMTP id hd19-20020a170907969300b0073dcc840debmr6001718ejc.552.1661535002888;
        Fri, 26 Aug 2022 10:30:02 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b0073d79d0c9c7sm1119896ejz.127.2022.08.26.10.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:30:02 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: check nullness propagation for reg to reg comparisons
Date:   Fri, 26 Aug 2022 20:29:15 +0300
Message-Id: <20220826172915.1536914-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826172915.1536914-1-eddyz87@gmail.com>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/verifier/jeq_infer_not_null.c         | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
new file mode 100644
index 000000000000..d73f6198d544
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
@@ -0,0 +1,166 @@
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
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
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
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	/* if (r0 == r7) return 0; */
+	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
+	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
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
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	/* if (r0 != r7) return 0; */
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
+	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
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
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
+	/* r7 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	/* r0 = sk_fullsock(skb); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	/* if (r0 == null) return 0; */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
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
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
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
2.37.2

