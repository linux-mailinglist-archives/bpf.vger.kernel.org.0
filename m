Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD35762AE9D
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiKOWtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiKOWtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:49:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEB23BC4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:49:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gv23so7155003ejb.3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Oj+fb93ZyXNteaMzTdG4y305Tgw8dWY+rKdZWNQ6Hs=;
        b=AMJLQcnSTGeuloei0idC/95+usU1tKnVFWm4z0sqlK1TVzfCvA3EE3Kzyai8jH4XGF
         xH9vGVPsCJqi2Nh51z7DQFUgAC4nr+7tfbDev6bhbFNOYDil2nHd88Iq5icfP2Aw5H0U
         4C6wdREN9fkmECiqTtLi/6E1uKnv3fBzfPmgm/1k9+j/Tk8NebnMcv+MCCPHKs27axsH
         3WyOIO4k3PnoTXq0wKFRYTYKDJPmTXUSnnxSfgyIlGnd06amSQqJfvgmPAVwDWS6rPe6
         xuesFfH47RybaDlj4gbB3mcO/+JttTAqQQqNSOwlz9115O+nEFVvKqVZlAM72k/cIYYa
         naaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Oj+fb93ZyXNteaMzTdG4y305Tgw8dWY+rKdZWNQ6Hs=;
        b=KOSysrh1FcwL9C+qQv+rrmNZQ8BuOHMPCafcyeaQJ5zp1XgthfOGZ6nT1MQuJS54ZZ
         C4+eyK2rw43QNe1j2iZgNI05tXa3B6FlIQu+iu24B1w7H5BjITvtxA2w4ZnbXlBguvUr
         u3j43zeLwwabtK9u8KJH4nj6jgmkZYJyZXIG9Qp7ExMAuzd0jmOM7XpG5jtZ69to5KMG
         v7niTahUez6wsUl2aH593DF8K+HqFjG8YgFCZ5WG9uk1BOs3GYPpOLuzdKg6Bh5M4mXz
         dqFQMSI/yAr66Hl7nWFWnqhjT6SbdfaEEJqKPcqqeEO4wHKt6xS6tr7POmqnQ2yFi97X
         K8sw==
X-Gm-Message-State: ANoB5pm0Iqijti7k6ZqmqZwqJLczYy3ZwjbvRAf3CdvSKhMbLqLf5c8o
        1h4TFtApBqqHWU7qH1JdOVsBQE236doXsbfk
X-Google-Smtp-Source: AA0mqf5NBxb2CybZBH1cJ9OW0ZVq1Boa/nu4Fl/3JiKq8PJdoEtUeuLQoW1aXOAVnNqyIFJsi66wBA==
X-Received: by 2002:a17:906:6d52:b0:7ad:9673:8b73 with SMTP id a18-20020a1709066d5200b007ad96738b73mr16299330ejt.14.1668552553105;
        Tue, 15 Nov 2022 14:49:13 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402171600b0046776f98d0csm5461854edu.79.2022.11.15.14.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:49:12 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, shung-hsi.yu@suse.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: check nullness propagation for reg to reg comparisons
Date:   Wed, 16 Nov 2022 00:48:59 +0200
Message-Id: <20221115224859.2452988-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115224859.2452988-1-eddyz87@gmail.com>
References: <20221115224859.2452988-1-eddyz87@gmail.com>
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
 .../bpf/verifier/jeq_infer_not_null.c         | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
new file mode 100644
index 000000000000..67a1c07ead34
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
@@ -0,0 +1,174 @@
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
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R7 pointer comparison",
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
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R7 pointer comparison",
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
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R7 pointer comparison",
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
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R7 pointer comparison",
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

