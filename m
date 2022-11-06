Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6061E6B0
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKFVuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 16:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKFVuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 16:50:05 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F4D86
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 13:50:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so728928wmi.3
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq8aoON28koqCNeo73zTWENzgB0E9SDbVKaoTrqmW7U=;
        b=mlyj/M7Jdm32BOANViBSy5CLu9mEO6QdYRJxTl342W7B8tDYV0x7WEsAgIOdJum1Z5
         oAmfjOkDhYQjQMxDwFNdpWHJUzC846uhjad8E4oh4uLQRkTwrHb8GnP2LBu/z6Wa3fUQ
         8M1zPdHZuTZYUnkh+7j4X72LuYB6+yhf0EwvLFIxe/606zvazTIdThTQHwkKNN2zD/IR
         oTElBREVLJMuGOqy0x+Wxfar7FeCTyQ8aDPLVBmSbbO/nRDBIZH8wOnZTQkE2fVCRh/j
         uXE1zjYtPEoawmLZUtproiNYQsubeoOJVNYwuauH5ciEjReua5QI8aGiSlRBqA2GsigU
         HQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq8aoON28koqCNeo73zTWENzgB0E9SDbVKaoTrqmW7U=;
        b=LlKHY+GVB19wCR3rsm3VI+RxPI6/+6nN5oEIGa86qa8nbJfUFBCaGfLUMjK0ITXUvB
         8sk3hyRqoVogBV0AkDgA1kgFQUA3BXTNl22HTe2EZt1N9hWlag/xR+G82T1TMIZ+ADgS
         ZJ+GLTHqXNE6r76pDtaGFdTonCbp5Jfau7vFEtLuzeAJUw5lKIWLI8eZFdcK8wzHzj2Q
         ejfe7/u9LHHy416wsyDk7+b5ObQOp4MZ8W1myhUHdnSXVLGTJhyHLWezXeu4T0nq2v8e
         iWCM+QpxoFwDuMufID6xIdoQYmuelXhIvl/eA1mEtxv09zMXUbdIppL35cz83NHDry7G
         YtBQ==
X-Gm-Message-State: ACrzQf2ARjQV3lmBfs6wNqnC9Jm8zYYgUqrSu6RGOUugBl8lgUfiJTiT
        jw8p2s7Sqq8lV44U4ShDFOmPTxBbIu4GDIen
X-Google-Smtp-Source: AMsMyM7AhDoefNtDGwrAe04waFFX9Fbog6reL+9yDgdcxNSYIEzW0mzAHjsWy/L+RijTXXUnmObcTw==
X-Received: by 2002:a1c:f30d:0:b0:3c3:7c80:67f4 with SMTP id q13-20020a1cf30d000000b003c37c8067f4mr30980266wmq.86.1667771401159;
        Sun, 06 Nov 2022 13:50:01 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003a3170a7af9sm6345326wme.4.2022.11.06.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:50:00 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, shung-hsi.yu@suse.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: check nullness propagation for reg to reg comparisons
Date:   Sun,  6 Nov 2022 23:49:21 +0200
Message-Id: <20221106214921.117631-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106214921.117631-1-eddyz87@gmail.com>
References: <20221106214921.117631-1-eddyz87@gmail.com>
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
2.34.1

