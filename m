Return-Path: <bpf+bounces-11925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC077C5813
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B660C1C20F0B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A2208AA;
	Wed, 11 Oct 2023 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrLENzky"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB505208A5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:27:48 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A4A4
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9daca2b85so737025ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038065; x=1697642865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkWNJjpWixu6rUQLCUScaaQlNZQ316HHtfjOeQpbK8Q=;
        b=GrLENzkybbdB9Aw+wX57DHhAVHVRJ2owSuZ1el8mu7Zwqpl0RK2+PioeguI5bDasjV
         ltCMr5PyBTfeGXe7ZwDBU7bBBlLYPbAE3T/WCqwCxDOt5BypNhZ7NAbaOi7kftvMM0Vq
         5BfQXS6zWVS+G4iZJloDuFloe8EVqkyisZLu35yxZ4FSkFIeGCgZ47xBE30+jl6DOxUQ
         euCz+z1sog3c9FgzDxhz7VAOszPPTCDUjxiHFxMHv6MvqKd+fL0YmvjiydOYeBLkw+f0
         rYyiIPwmeCa30FD9GTHpki7OtxSTJAgqYkDSbODKwYSIr6E9kcd3ETp1EeKwQhohkEWh
         rKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038065; x=1697642865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkWNJjpWixu6rUQLCUScaaQlNZQ316HHtfjOeQpbK8Q=;
        b=u4tRoquLXP2YAImtm9GvWELf186tTRKJ0dPrPwFdDZMRyM8Q8z/2BJsbb8/QKm5wWB
         CRC/j73/3jDv6WzCMCc/9nk15de+9VeQfhIErifauYE15fEHvckgkzzioH307ffvSjhc
         XvXndLtVq39pU1fxPs4r7TTLhk0FV6iBuK++AP2fns93qztUoWnl21DFXdFAHGx/AnI5
         B1sFB2lamFXimIg7EEmPf1yAOtQp8dex5KbrxDSd3FVD3whezbK8oJj2SBnTtqta2wPJ
         JU6fjGWRIOhSPsLnpJBLHFyaZLfYPSojoN32M913Q6uifP08gP3Q6cpCeWD4b+Bf+RuF
         Nz2A==
X-Gm-Message-State: AOJu0Yx5b7oVTkwcf6htVtCeQQTFUcpAUElXh0a8lYeUJCa2f/6WFwWM
	Gfj0lfzarvstCQTDwULyojYCWi2Ip5yrDQ==
X-Google-Smtp-Source: AGHT+IHh/R6f0P6IzLJsHMb20ngDKMAGr5aB2xC83cOQFGozh6d/JS8uxiKbJMPbakuxW0YXV9IO1g==
X-Received: by 2002:a17:902:cecb:b0:1c0:cbaf:6954 with SMTP id d11-20020a170902cecb00b001c0cbaf6954mr30749174plg.25.1697038065436;
        Wed, 11 Oct 2023 08:27:45 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001c755810f89sm14092070plb.181.2023.10.11.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:27:44 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next v2 3/4] bpf, x64: Load tail_call_cnt pointer
Date: Wed, 11 Oct 2023 23:27:24 +0800
Message-ID: <20231011152725.95895-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011152725.95895-1-hffilwlqm@gmail.com>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rename RESTORE_TAIL_CALL_CNT() to LOAD_TAIL_CALL_CNT_PTR().

With previous commit, rax is used to propagate tail_call_cnt pointer
instead of tail_call_cnt. So, LOAD_TAIL_CALL_CNT_PTR() is better.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36631129cc800..73da9a2125589 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1077,7 +1077,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
+#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
@@ -1697,7 +1697,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2479,7 +2479,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
+	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2599,10 +2599,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		save_args(m, &prog, arg_stack_off, true);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
+			/* Before calling the original function, load the
+			 * tail_call_cnt_ptr to rax.
 			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
+			LOAD_TAIL_CALL_CNT_PTR(stack_size);
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
@@ -2658,10 +2658,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 			goto cleanup;
 		}
 	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
+		/* Before running the original function, load the
+		 * tail_call_cnt_ptr to rax.
 		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
+		LOAD_TAIL_CALL_CNT_PTR(stack_size);
 
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
-- 
2.41.0


