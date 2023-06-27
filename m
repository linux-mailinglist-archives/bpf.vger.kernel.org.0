Return-Path: <bpf+bounces-3559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AEC73FB77
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 13:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F162328102F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474D117AC0;
	Tue, 27 Jun 2023 11:54:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB579D6
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:54:04 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E4E5B;
	Tue, 27 Jun 2023 04:54:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3549144a12.1;
        Tue, 27 Jun 2023 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687866842; x=1690458842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UQHgCYMSUpJKwkxCT8Gz4j2ViWlUBZ9rAr/225IOUc=;
        b=l79nZCW6i+H8KEntEfZJU3WoFNVHt3GJ2ez0IKkzMmhANEfia2mXwZIJmhTOkUUAsA
         j0n5ehct3U4l+REY4Cq25vGRWuYSR99M/iVT3GYGXUh6/KjDmFjF2zwxvVz379EKWjO0
         brZ59B4YjkIsFSwsMNvvEZoKsywq4N9QMACvI32ycB1Rzvo6Lc+B/7f7bZAFL1WwE01H
         XwcihlaXNzCDCfAVkZH4oxIGFZQvfpPkTYyPfltEYdsKIyuIz0EpikaUA1X2VFPqrN5D
         prDSeNoAnUjJKLBKzzg7d9wgR3HVKkBCwaAwNqA4quVBaO8EzVSsgioAXlRjsW3DdEK5
         weTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866842; x=1690458842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UQHgCYMSUpJKwkxCT8Gz4j2ViWlUBZ9rAr/225IOUc=;
        b=HPQ1hLUp3I3hGoQAUkVdGAsEhMlIgyF2NTBTnqwV7nDz/FP9BWfmmHy+JYGo1VAJF7
         IPpNcTc16zcRnsblxfw+U1g5S5jW5Jy64UXcsqSan09HaZXsNmr4LsaDLxGh6BLAmlt9
         yUo2Z3Eiupojsi/jvfxFRZ0zgdv+r5aahtlykC6WLXHcD6JTZ1rqofj32Hnt/fFejKUq
         dVNjaGPWzzfSM/nelFl/Fo82VzQmVbuXL5Qq+9y1ORWpsruIUn/guyTlz4u5eScvpGAJ
         AuvA3+xVprnql3kELPtrFp1tjk3cHki6wNjGl7SK5z4OkSTDswUi2AguX6SCtzVNeEcI
         CJGg==
X-Gm-Message-State: AC+VfDwoXH95sFDYDz2Rm5JVqGYcz1e1ZTSJmzjZVHx3cq3TRFBrVkm9
	N+zuXN8mVxw4AOx5PRa1KPE=
X-Google-Smtp-Source: ACHHUZ4DXwh9A/bc0yLr0zijT2AzhRBJ90cHk+qZmsTTw9nYa8YG2g3qscxJc28RujM+uy222e7VGw==
X-Received: by 2002:a17:902:f552:b0:1b5:1e24:8a76 with SMTP id h18-20020a170902f55200b001b51e248a76mr11609716plf.65.1687866842319;
        Tue, 27 Jun 2023 04:54:02 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.112])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001a2104d706fsm4961236plb.225.2023.06.27.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:54:01 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: daniel@iogearbox.net,
	yhs@meta.com,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v8 1/3] bpf, x86: save/restore regs with BPF_DW size
Date: Tue, 27 Jun 2023 19:53:17 +0800
Message-Id: <20230627115319.13128-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627115319.13128-1-imagedong@tencent.com>
References: <20230627115319.13128-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

As we already reserve 8 byte in the stack for each reg, it is ok to
store/restore the regs in BPF_DW size. This will make the code in
save_regs()/restore_regs() simpler.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v6:
- adjust the commit log
---
 arch/x86/net/bpf_jit_comp.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..a407fbbffecd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1860,57 +1860,34 @@ st:			if (is_imm8(insn->off))
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 		      int stack_size)
 {
-	int i, j, arg_size;
-	bool next_same_struct = false;
+	int i;
 
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		arg_size = m->arg_size[j];
-		if (arg_size > 8) {
-			arg_size = 8;
-			next_same_struct = !next_same_struct;
-		}
-
-		emit_stx(prog, bytes_to_bpf_size(arg_size),
-			 BPF_REG_FP,
+	for (i = 0; i < min(nr_regs, 6); i++)
+		emit_stx(prog, BPF_DW, BPF_REG_FP,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 -(stack_size - i * 8));
-
-		j = next_same_struct ? j : j + 1;
-	}
 }
 
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			 int stack_size)
 {
-	int i, j, arg_size;
-	bool next_same_struct = false;
+	int i;
 
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		arg_size = m->arg_size[j];
-		if (arg_size > 8) {
-			arg_size = 8;
-			next_same_struct = !next_same_struct;
-		}
-
-		emit_ldx(prog, bytes_to_bpf_size(arg_size),
+	for (i = 0; i < min(nr_regs, 6); i++)
+		emit_ldx(prog, BPF_DW,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
 			 -(stack_size - i * 8));
-
-		j = next_same_struct ? j : j + 1;
-	}
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-- 
2.40.1


