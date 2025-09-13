Return-Path: <bpf+bounces-68300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804AB562C8
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610D81B231E2
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB7253944;
	Sat, 13 Sep 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpRV/qJ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AD24A078
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792028; cv=none; b=uyG0aBYZ9e2OgEfxQ1dlq8Jil3h0xDiemtcJ1v573MP9Cy1Ep5T5psXAErKpwOZAgKYRg3eijEg/PnczD6LkyYZNWhoeg3+ssf4Lbr4FRx2doVxyqSYawlNDaEDmhFBebiBaNAjXK7dmvpxcBdIABXfKJmBFiK+dFG/P5o55Veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792028; c=relaxed/simple;
	bh=ZBu0hxEf8gBQIW9phpB5YWnHl1+ES4a+3qN7zp3D+sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbeRl+O8vvI1f8ZRDVOxlxGHSMhSPl2YVdpIRht8Z8/HgG13tdMfcJBo5UMqiSaMigITIq1Aigf4gvHFiSaza1dCw22YXwI9E6g/MC244a3tjqh7A2nRgkX8t344v/vAN4xEYVfkFIAxefcNoDmT+l1ilTu3PAZJ0l5sOHN17eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpRV/qJ+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dec026c78so28869915e9.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792025; x=1758396825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCf39Yeh2Rl3Ijb+ZRoCRxmNecYknQI1W/2SSguxpUQ=;
        b=MpRV/qJ+knEnye5p0FZ0HKNUQS3aNJsosGo/SOMTZdZNZOQfe6lxZszzgSIR9UH1+L
         rVcEROhGd0fsw9DEljF7TliRwhzFtTvnVx8XCvBE66h+ayAgaMAGIXKqxEzM70em32hq
         t5WHwSjX8a+/5STJCXUeKHdkYUL+O8ZBaLxcvs3hYclkTIETbV9odS/AwzaZlMpOMLC9
         Or/leDaE9S209h2KylpIsviT8K+Q/s97wYEhnpBGNpSMPhHBxsBYK9vuFtjwVkr+GWyt
         tzyYP/qCbfCs4ONNEtOZ9MH8Bhaca8LY/MdgiaOG+EMNzdIiKv3E7urmKaBMEIKbCrPF
         7Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792025; x=1758396825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCf39Yeh2Rl3Ijb+ZRoCRxmNecYknQI1W/2SSguxpUQ=;
        b=jsvYL3SpZFnYbyg8HGXf0ySLa6a+3ZiqNF3Rzo/5IIxdaQd0RGcG2nvZMG0Vehentj
         xm9KzQkUL0P+LLBtii+Mg7B5qWRPT4A88LDx9+U3I7Q7v9Cz6TRVnM57Hu/owK8ctfgO
         QX/iWCtCM2gJ7UwiGszYxpdW8Gx9oxJNbajxTQY9e0u0DMvcz2wYYwgwH3SYjyIdfGIK
         2gz3Ap/fSmpJHVZ8ksjFSaNabaBAyAQXrPc/o6plXTeKcv1AxL1tKLdZzr+2uMPUr/vl
         XVmVzxPe0k+3+fYwcElz58DDCgHaIs1O/mdLn49PzvXljKBEja4GqWTdrOscAdIrl5Wo
         mVPQ==
X-Gm-Message-State: AOJu0Yx5K9hMputYINEgsUof/Al5O1RXVGQQ6cRnGwOkPmZnhQaZnak6
	6ylPxhLVtx0BgpYkJmrFzgA+4Tbff5B62XFhv19H4vsDPa39BCUwQuUhjCizFg==
X-Gm-Gg: ASbGnctf5mf/F747Rf/hOJAJPjpKbzH42DljaVyQt7D6SFCesMJSiYGIeLhnj3IRcTU
	eBgNeuYkwoNCzPHWkjI99TSEckQOCU2qb/vziIxi1RzX9bRUGPWGvvDc1Z2zIeF1T5OW6s1cGKP
	Ct5rOyi+FqsQrhapXROtfjyxuC5JJIHDkxc6vNboFwkPggc96L5qfWlPR2SD8yIB4qI6oYBpa8E
	NfAgOy4lV4euaehUwc9jXKNMPw6dG64OjRfuUHOWzH0FtEs2TajrdLnZM7zYIw+Nxig836kZFuK
	9rIDQqi64SpWMOZ5aMJmryatHQYZYPPiuVkahwd4Ijqdxdus7VNiORGphG9icrPKz8KIm9xhYMO
	fzNm4wEuSvXz5yJg+ZObXTxcMrHhesHe5XRxpy3L4zY6Aiideg3dVneq435LB8gc=
X-Google-Smtp-Source: AGHT+IF/v1LQIIXIldn0/Ys0lpKyz4HOes/o2KSeebazhnwmOPbUyA8ja7XXF89lf79LxefKMmpnfg==
X-Received: by 2002:a05:600c:1d0f:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-45f21ed4986mr67007765e9.26.1757792025097;
        Sat, 13 Sep 2025 12:33:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:44 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 07/13] bpf, x86: allow indirect jumps to r8...r15
Date: Sat, 13 Sep 2025 19:39:16 +0000
Message-Id: <20250913193922.1910480-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the emit_indirect_jump() function only accepts one of the
RAX, RCX, ..., RBP registers as the destination. Make it to accept
R8, R9, ..., R15 as well, and make callers to pass BPF registers, not
native registers. This is required to enable indirect jumps support
in eBPF.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8792d7f371d3..fcebb48742ae 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -660,24 +660,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
-static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
 {
 	u8 *prog = *pprog;
 
+	if (ereg)
+		EMIT1(0x41);
+
+	EMIT2(0xFF, 0xE0 + reg);
+
+	*pprog = prog;
+}
+
+static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
+{
+	u8 *prog = *pprog;
+	int reg = reg2hex[bpf_reg];
+	bool ereg = is_ereg(bpf_reg);
+
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
 		emit_jump(&prog, its_static_thunk(reg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
-		EMIT2(0xFF, 0xE0 + reg);
+		__emit_indirect_jump(pprog, reg, ereg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
 		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
-			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);
+			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);
 		else
-			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+			emit_jump(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
 	} else {
-		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
+		__emit_indirect_jump(pprog, reg, ereg);
 		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
@@ -797,7 +811,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
+	emit_indirect_jump(&prog, BPF_REG_4 /* R4 -> rcx */, ip + (prog - start));
 
 	/* out: */
 	ctx->tail_call_indirect_label = prog - start;
@@ -3517,7 +3531,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


