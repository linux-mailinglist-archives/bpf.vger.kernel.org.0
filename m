Return-Path: <bpf+bounces-10011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52687A03FC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826ADB20EA1
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245CE241F6;
	Thu, 14 Sep 2023 12:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9F241E4
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:35:47 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C31FC9
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 05:35:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fb2e9ebbfso688711b3a.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694694946; x=1695299746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzb5nAmn+mX7YW/p5CUpVW3w6LrJzc04jKkqA/umsbw=;
        b=W7NfCdfeqh282PLNHxRG9VaA39EXe9+87+GWscD4L3s6/QudQllYzmwtO7c5zT4XLd
         oBvnUBdvCq93gEbzmoFYRE3xnszxqGFmIb5X3Jex2jJE5Ba5fEFS/TgVHP1JXsqImfB4
         ekOrw53DU5bjPXTno/kKeMlC6tVoggFvZoOT9y/S8Zk/fGReR+3GTQyQtobx380SU/1N
         5LKGNG95aTodllAhgXncrja4dBkYNQyqfh5HTP4AeDr6dVQFWMAh2UwYH2tZQP0FiCUl
         zEipol8qznW4pSA+KfqDAk/6h2S6K2LfLLliwk1/07y+cjYAZ1NU/jy14qzXtyyGy1cx
         Uo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694694946; x=1695299746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzb5nAmn+mX7YW/p5CUpVW3w6LrJzc04jKkqA/umsbw=;
        b=J0hF5i3MfH36RBGXeGyhYZ9WfxRO7FFmevBE8eQYZ8QU6r6nvL4PBjY4+pKQ6uNmQb
         pr8ZsgnxZBlWctTITHJWBQRJhamRl4P17hN6zXRVw70WE3Ez1BXytuoCIpClGPGRzZso
         S0q0d7ogkV86pi8DSLgbqemreaU1UEVeEQgmlT0DEvffH0xPnz396O0SS1/sUU2uJ93S
         I8o7O47FKbwxQ++mszvYI/yLxmDTPu/6+ujTrvH/Ba7wXLArn96S1SCea2fxPY5RfrDM
         L2SJYqKQKEXIW/7KDDcDMD9tY0rc9TKoY0okDJvcBmZoZtoMw+/hLhe/+X2cByHibcNY
         6VXw==
X-Gm-Message-State: AOJu0YzRnKoVJcq5dhwBgIUR6ljWfSFH0XiwFhyeo3cE7spsnJMHaU9y
	mt6/NmpMqIS8b6lmI+ci32/G0/K95ig=
X-Google-Smtp-Source: AGHT+IEHYv/7iPSnCYvanauAE+kS26lZokwvLDByJ+uBbxnU0Rd0jwP+0M1/OhlIGJ99bPpbXFvT2Q==
X-Received: by 2002:a05:6a00:1a8d:b0:68f:da2a:637b with SMTP id e13-20020a056a001a8d00b0068fda2a637bmr6124881pfv.19.1694694946339;
        Thu, 14 Sep 2023 05:35:46 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id fe20-20020a056a002f1400b00687dde8ae5dsm1252826pfb.154.2023.09.14.05.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:35:45 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tglx@linutronix.de,
	maciej.fijalkowski@intel.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2] bpf, x64: Check imm32 first at BPF_CALL in do_jit()
Date: Thu, 14 Sep 2023 20:35:27 +0800
Message-ID: <20230914123527.34624-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's unnecessary to check 'imm32' in both 'if' and 'else'.

It's better to check it first.

Meanwhile, refactor the code for 'offs' calculation.

v1 -> v2:
 * Add '#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7'.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2846c21d75bfa..fe0393c7e7b68 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1025,6 +1025,7 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 #define RESTORE_TAIL_CALL_CNT(stack)				\
 	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+#define RESTORE_TAIL_CALL_CNT_INSN_SIZE 7
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
@@ -1629,17 +1630,16 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			int offs;
 
+			if (!imm32)
+				return -EINVAL;
+
 			func = (u8 *) __bpf_call_base + imm32;
-			if (tail_call_reachable) {
+			if (tail_call_reachable)
 				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
-				if (!imm32)
-					return -EINVAL;
-				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
-			} else {
-				if (!imm32)
-					return -EINVAL;
-				offs = x86_call_depth_emit_accounting(&prog, func);
-			}
+
+			offs = (tail_call_reachable ?
+				RESTORE_TAIL_CALL_CNT_INSN_SIZE : 0);
+			offs += x86_call_depth_emit_accounting(&prog, func);
 			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
 				return -EINVAL;
 			break;

base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
-- 
2.41.0


