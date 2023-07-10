Return-Path: <bpf+bounces-4591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671FC74D3E1
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C1C1C209FD
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C7D2EE;
	Mon, 10 Jul 2023 10:51:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A935BE76
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:51:44 +0000 (UTC)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B23C3;
	Mon, 10 Jul 2023 03:51:43 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-3459baa237bso22912685ab.3;
        Mon, 10 Jul 2023 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688986302; x=1691578302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9OF5rBDxNaq2DXKTbLZbdXHNFefw4Fd6mHFek0g5ew=;
        b=Pj6bEUk7bbrQ24jt74tpb/KwzjGwHGC6+/a+Et1mMEMCBH0GNMyRv+2Ac542F/BtX8
         xxRmAH9ZQQd60SczD2HfTkKH6xgs3zPKdPzLoRyiTlsD78+4QaIb4Ag1Xr81uif1Xiry
         FywA3Fl+evLMrngvcATXuoZjsGiomLn6ovriVqjzQqwB4e0T8oEILkU2rREjLdbGhVn4
         PBr4x3vlSbLCZpwQRT+O7yZ//l6/Yt5WAsx3J7cpS8ZPhCLeYtYJcElhtFwXV6x6FOVg
         /KgSa+/YLuxH3q7H99oUJpWB9LTAwjjp928OT7sGDZTwfwEKFnSvmuRZeMrDTC5JIQZy
         l6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986302; x=1691578302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9OF5rBDxNaq2DXKTbLZbdXHNFefw4Fd6mHFek0g5ew=;
        b=aR4S9u+u0jmoBrLSSb79THXvN8pOK1pxC+RJU8k8k+1DtWq2JKMAwtABquK5L0Ib8e
         mAtKShU7Lo10491W4LWgjwAn1E5fhgHr7EJEYEgHoJUePQBBPeira4iQrWmdGwEr9cze
         xhKdhRvYTZRsW4MJDbTKzXqg1iwQWYGLu4kvLQmvlAhVGVgz86Cq/8BOthXnK/aJtYwJ
         vl3oZ7zk9YpWZy6zwfobWxs732PSOzLJk0T2mH5Pl0fxSjaiHwlE/QZuOTJ0W2BaV+lk
         NuUb6ntbX8DamIe4LS+uvFx+ojX+tqkf9tmslvj//cLn3QxIQQ3WiLIeZIuvKJ3oVtO3
         ijWg==
X-Gm-Message-State: ABy/qLYqtX8kFvvU6xcJ2qLWlQc72mBUNu5ZtM4FhH9pEcquGTbAHivJ
	Bs5Ioosze7GSozhFV6qpAWQ=
X-Google-Smtp-Source: APBJJlEqjFnrvKb9nACwwOX7jpspg56BTIFmgbdx1btyclRuFS3qHPuQ7rREV2KdztzJWAl2JUL9uw==
X-Received: by 2002:a92:c846:0:b0:346:579f:408 with SMTP id b6-20020a92c846000000b00346579f0408mr4751365ilq.1.1688986302281;
        Mon, 10 Jul 2023 03:51:42 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.106])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a191100b00263eb5054ebsm6475036pjg.27.2023.07.10.03.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 03:51:41 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	daniel@iogearbox.net,
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
	dsahern@kernel.org,
	jolsa@kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH RESEND bpf-next v8 1/3] bpf, x86: save/restore regs with BPF_DW size
Date: Mon, 10 Jul 2023 18:48:32 +0800
Message-Id: <20230710104834.947884-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710104834.947884-1-imagedong@tencent.com>
References: <20230710104834.947884-1-imagedong@tencent.com>
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
index 438adb695daa..fcbd3b7123a4 100644
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


