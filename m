Return-Path: <bpf+bounces-19027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E78243A9
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF87B25298
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6E225CA;
	Thu,  4 Jan 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN/wz7xs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDD224E5
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28c7e30c83fso368666a91.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 06:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704378192; x=1704982992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb+Zb1hGgefs5EEJCd0uWySCNqa1KQKVtSoiZtIG8wo=;
        b=bN/wz7xs6v7B4MGmtsy9WWnFdHAJLdyxQPCUkll3whFJX3X6Tx5YE5clgqw5YZaUCS
         bFGN9CJNaRBlSGJjQsa+NBG+IIn/4ILdJ0qBbSoB69XOJhXoNGpvGDWyJGT0HEic6EtA
         na/INBq1Lb+7RqnDGZ3NjbWoougblrs0YqM7dZldoTQyBIhB8oOxca5NM1U1wV6P3gLp
         Fv8BdkQAcyBAKAcEFHX1Qga1oXXRN1xUjkE3jRk8OteeaFFdJ/JQLUglCa1mzQaCXxVM
         +dpdImdE1NYlOhGYQ1N+RpwSaLSfqbI/49VasuNygShbacbwsK6hsPWLAkpiWZW9NKPD
         gl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378192; x=1704982992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb+Zb1hGgefs5EEJCd0uWySCNqa1KQKVtSoiZtIG8wo=;
        b=ULWhmSbxzwlInMid+b76ROOx0Ai/wWqc6su62tXjLDeNH/gY8yP7LHKxKY/0ZYw5F5
         iC1B9tVT/8Y8HEWTwgHTuxY6YEFhgHR9BRaSxlfMfXYkz9qRyIaNb/UI2Zj31lStezZA
         IUjUSWDKptJI+/OweGHBTX7fggmuGGSXY9ScA1ARN4JsoRSqrz0d8Yx10BYS7X+lb8rZ
         XC2W+PaviV61bczca053kW+oonvGOUlI54EsaDqucictuTruZ6ZM/xw5OdkxzsEx4iw4
         a43D9nRxXjTFsbLl081Lr7z8CrVzhyC/WELodktL3KSaXjC5kHiCfq9MbAXyyapbaNES
         4mQg==
X-Gm-Message-State: AOJu0Yyn/cXgmKqEC60Nmn3V6oBx4ufH3fOtl82yU2FdPD+tUgMlSfm4
	0vcFaERB4xCcNKox7O9gnU8rshgQjPM=
X-Google-Smtp-Source: AGHT+IHCZQkhPRxXOO6ah6LSXRSOFLQG+Ynn9rFXGxBzciMWAfMtyYP7foGzL5xjeJNguVBiXh7f3Q==
X-Received: by 2002:a17:90a:c28d:b0:28c:e9a0:ce3d with SMTP id f13-20020a17090ac28d00b0028ce9a0ce3dmr469975pjt.99.1704378192095;
        Thu, 04 Jan 2024 06:23:12 -0800 (PST)
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0028cb82a8da0sm4081507pjc.31.2024.01.04.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:23:11 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/4] bpf, x64: Rename RESTORE_TAIL_CALL_CNT() to LOAD_TAIL_CALL_CNT_PTR()
Date: Thu,  4 Jan 2024 22:22:25 +0800
Message-ID: <20240104142226.87869-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240104142226.87869-1-hffilwlqm@gmail.com>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With previous commit, %rax is used to propagate tail_call_cnt pointer
instead of tail_call_cnt. So, LOAD_TAIL_CALL_CNT_PTR() is more accurate.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 67fa337fc2e0c..4065bdcc5b2a4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1142,7 +1142,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
+#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
@@ -1762,7 +1762,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2558,7 +2558,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
+	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2686,12 +2686,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true);
 
-		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			/* Before calling the original function, load the
+			 * tail_call_cnt_ptr to rax.
 			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
-		}
+			LOAD_TAIL_CALL_CNT_PTR(stack_size);
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
@@ -2749,10 +2748,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			goto cleanup;
 		}
 	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
+		/* Before running the original function, load the
+		 * tail_call_cnt_ptr to rax.
 		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
+		LOAD_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
 	/* restore return value of orig_call or fentry prog back into RAX */
-- 
2.42.1


