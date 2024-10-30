Return-Path: <bpf+bounces-43534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A89B5F27
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0E4283555
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439751E230F;
	Wed, 30 Oct 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuSZg8p+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210A1E22F5
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281682; cv=none; b=YYoytJyIJgYCOoG6zc09BfwLDFa1Y+P5sNp3sdnwxlD7tsSN26XGepl4bU/xBcknu+9V3vbCK5fTQAquVQIaGnxO8oKimm13siPhIuvxYFR5a9/6UH6vMrDff5oDv5Z9/C0HvD+a3bclymqoErqOa2rSVw9yLD/Vb0Gbqcx/N/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281682; c=relaxed/simple;
	bh=Z5hKlNyATGwPuRIPOX5uum6xAppJ3G2lWkzT96l65v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYUGDAR7djOq5vu1zgRW0gxqChOW6UVMfjrmVGXp5OzcKZwEWbJntYCqIavX5OupOpz4weQ9KDSd9NJ0hceNzazkI3ccnz2SArnz8re3YF1AyZIOUUHy7Q6ysgUNwSYitkRGF9Sq/ywdLvprItgskZEi5GF+J/3n+CKDpLPA+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuSZg8p+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso4792040b3a.2
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730281680; x=1730886480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbxBRdiw4vuwNFRi6uO8o4Znbe87vlxR3OzuEocHlY8=;
        b=RuSZg8p+p+NZ7TWh509vOMmbfJjHbn6gwZMsrO4zfsCfT20k7SBbRx4gTwV1TK7Lv3
         pqxj3VNSHTPP/GRbxSLy2M+F4nnqHUntgo8A7nbnvE6k5eqSD8OHOeNtzkniiE6kek69
         WdO+G3Cpqxj9d5zJ2xAc3J5hrZWZtp9slCjJIS9T+hX7wn2aVvfR/3Cpvnh3OoBz1KJw
         q//MuPQtbtDd8hEVGAZzqT9wtgnLfkzOLB2Mq2il3vLAn5kHg6blRENRmTNHfr2LTSfc
         HwdgeSjMOQBYzCJqrgdw39Q5IpYhZmQ5Hl70H9i3Q89OFE9Llmo3tRy23o0BLYoHXpzw
         oGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281680; x=1730886480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbxBRdiw4vuwNFRi6uO8o4Znbe87vlxR3OzuEocHlY8=;
        b=EgioXWTmbspGJ43xF0jBNeYa/qhEVa8VlsNgEqDCeX7BnImrsugVJSxzLLUCpE3+u2
         T1AYh1hYrLHyCaWjspsbHap5BBjSjScQCFLAFEOi5ku/EZaNor2FVHGRcktp1wR3GAk5
         ohEa2dxQkDmYDiteH/D6riScfFJ+kC+hIDXDty04R44vV4/WtgKCGbyoWFomE6OXqw67
         RvB22BiCaINXsPa73V9coVpZXk7jMK9w3uA6yFZ1LP40aCKW+gIeSXNRGfGKHD2vOry8
         C0g/13+bEdoOTVdszi8sWVt23CaUM7eptRhUGmvO7KhiBWwBnlXwAMABeFkUqVfQYmkT
         z3cQ==
X-Gm-Message-State: AOJu0Yz9dp2xBL+viC8sEtpa+jFPrW4SQDPVS6QCGpjjtynmYbx7jgCv
	Pdjggrvrmu3VtII6RFlWmQjCFkbprDVRUYOHKsVm4sy8ypgkJCWFUSSrVA==
X-Google-Smtp-Source: AGHT+IEpEOVvVc4+nQi+uo/ncBkGLci5e0Sufw9w8UNJxnF9Kh94Y6CAItD42Wpma56/BnTddeAHqg==
X-Received: by 2002:a05:6a00:811:b0:71e:50ef:20f3 with SMTP id d2e1a72fcca58-720ab4c705fmr3281526b3a.28.1730281679872;
        Wed, 30 Oct 2024 02:47:59 -0700 (PDT)
Received: from localhost.localdomain ([117.20.154.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3f0a9sm8853394b3a.213.2024.10.30.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:47:59 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
Date: Wed, 30 Oct 2024 17:47:41 +0800
Message-ID: <20241030094741.22929-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Hwang <leon.hwang@linux.dev>

This patch addresses the bpftool issue "Wrong callq address displayed"[0].

The issue stemmed from an incorrect program counter (PC) value used during
disassembly with LLVM or libbfd. To calculate the correct address for
relative calls, the PC argument must reflect the actual address in the
kernel.

[0] https://github.com/libbpf/bpftool/issues/109

Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/jit_disasm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 7b8d9ec89ebd3..fe8fabba4b05f 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
 	char buf[256];
 	int count;
 
-	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
-				      buf, sizeof(buf));
+	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
 	if (json_output)
 		printf_json(buf);
 	else
@@ -360,7 +359,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			printf("%4x:" DISASM_SPACER, pc);
 		}
 
-		count = disassemble_insn(&ctx, image, len, pc);
+		count = disassemble_insn(&ctx, image + pc, len - pc,
+					 func_ksym + pc);
 
 		if (json_output) {
 			/* Operand array, was started in fprintf_json. Before
-- 
2.44.0


