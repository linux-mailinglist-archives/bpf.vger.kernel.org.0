Return-Path: <bpf+bounces-11450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4767BA1C4
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6C821281E96
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DE2AB5D;
	Thu,  5 Oct 2023 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htb/PLjl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C22E625
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 14:58:57 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97DB6BBBC
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:58:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-692c02adeefso900267b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696517935; x=1697122735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDGdkJCjBYege/vN0Nna3Ehn5wQpBfqGv5JD9salv7Y=;
        b=htb/PLjlUDX02QF+cvaEdqXQHMknhPx84d/GjWWa3LFEh+WxAXd5ShI1uukAaB+cU3
         X+kZUJk5A2H7qd9j8NJhe0+zZgl10hfLkfv41EghpdX0MOzi4C0qSGDL86d2cqeAVI+O
         x8p2Mufz6M9egZiBJKjGi0/0Htxw1GF2iQWVn+1NTPAlJKBlfwV4cwutkR8NRLX/FxnE
         cKnVoV0dM/4KbgRZe+PvNJnJj00e/7gPHvfBPFLUMlaGloNMft93PnIg1NM1BB+hMYIM
         jaF3slM4CGPVQU6SnIhZcm21jwiegw3RbYi56DVGIMg2cNKLKRfQIwZpHxhYwWXCEVvB
         95Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517935; x=1697122735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDGdkJCjBYege/vN0Nna3Ehn5wQpBfqGv5JD9salv7Y=;
        b=db3Qnad1RjRvkML2BAlZoDr+pS12kCeIHqiRIYqAHQmuqvG0CVXkeDsxioo9eNEWjH
         dFkvw2Lg1H2rAYu9SbeXCxjZ/UhXolZSgx6kb5kNrR5CXTN8BuEH61DdYOu0oSYhzlXK
         eOYITZxGnCU4YTFdGJXedg4RXMneOwKkUKF0f4yN75eQyf+HeMqmivgvMM4jX2xSE2FX
         R1+4NloECyoOQX2iqFEPQT5KxJ8zut2UVbpfrBrQgwDWZO97s1JchWPRP3JW5zOGhB3V
         kAfyxGrt1uAj4VkPNWODOZspv76N54zF2QipUHHEXnBbgk4mhOIsTPXEpjYlX9u7DinH
         l+xA==
X-Gm-Message-State: AOJu0Yy7k9exp2WzAmOy0vyAncsVlpuIQjg2MGyT/L7xZA+aX4Fw/S28
	p/dNIX7PRpwCPI2ssft1mrpDBiD176WnwQ==
X-Google-Smtp-Source: AGHT+IEl/wDE0v+WoMvcNnm0PO/hU5k25NJpFMtbkIZq3BQdUj024iT1TtBQ2fAa1wjDXodav+eQvg==
X-Received: by 2002:a05:6a20:3cab:b0:15a:bf8:7dfc with SMTP id b43-20020a056a203cab00b0015a0bf87dfcmr6050574pzj.15.1696517934866;
        Thu, 05 Oct 2023 07:58:54 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001c61512f2a6sm1819930plb.220.2023.10.05.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:58:54 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 2/3] bpf, x64: Load tail_call_cnt pointer
Date: Thu,  5 Oct 2023 22:58:13 +0800
Message-ID: <20231005145814.83122-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005145814.83122-1-hffilwlqm@gmail.com>
References: <20231005145814.83122-1-hffilwlqm@gmail.com>
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
instead of tail_call_cnt. So, RESTORE_TAIL_CALL_CNT() is misleading.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8ad6368353c2b..7a8397a60ea1e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1102,7 +1102,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
+#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
@@ -1722,7 +1722,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2624,10 +2624,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
@@ -2683,10 +2683,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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


