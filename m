Return-Path: <bpf+bounces-70037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A1BACE93
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA27A49A4
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7713016E1;
	Tue, 30 Sep 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7rmum4n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B82FB0A9
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236347; cv=none; b=ASSZ7g1KPK58hBsF921hP45+JGD7vRJDsxr4kk36/DX4VRk0Y6hc0kWKvT/YmM6rxCDiduZyWGnLpO8wH7QZe9ZZ5AWnp7ESSDyqSEVY2ICik0jaR6/i6TkbeoY3bi7T6s4KcS8jFN1e6Ug0Qi9Rus0sC8pgYeoVO1YuDnl1YIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236347; c=relaxed/simple;
	bh=AysDDBiOJn8P9OHp28KnmSDeCK/P9btPR55NzR+Huwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0jqgPBUN7w/DQsURctle1+5ckTapsPBSv+3JlGGH056HX/LXlyPtm2NXoWetIU1ia3rH4evZ8NfQeGQTiQwRO2VppCCTQ55amXc5JwMrnHshjvejNspZBRDmrul9SR/FDdsxDbgMFuFfbyMfuykpQ3ETrlM/dOXXmJYVMwRzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7rmum4n; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bcb25so1146098f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236343; x=1759841143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ6CaE5cwpTLNmErgGl4go+eKXrV3XA4zEggCkzeOUg=;
        b=Z7rmum4nacUNwFgGhqXuLlDiINqRHt8cXNcphrnRAZ5U+AjP4m7RWrsuGv6m6Z61hm
         gI3/kux16ROFHlNfqUYh4oEYkTf8HHy3Mmn2b+dF+T6+wJRNHDD0fJch2uhM+0jnNgaA
         7ri18WJydLyfQgZe0u5YAT9RONKTWcJwZfKkWnfyzfsJqtuLVCU6VCsBQnytButfp9e8
         ODTHYwlpQ+86qhG+pgneoI1nwllNVkeqYEmD3ANkLXAUcLNZz97MQcfXO8C0zlQFdcVi
         HPK6oLYOyydSh4ZiOwuqsaUrLvypuMVZp3+tDj6puGIY09ZMw3PQ+mnadAjiFXK3MQ0r
         XpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236343; x=1759841143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ6CaE5cwpTLNmErgGl4go+eKXrV3XA4zEggCkzeOUg=;
        b=cg8JBlulnJSDXkjI3pfLm6vIvEvr9Ww4jot+LKwI1Lb0aYDiRQjfIk1a45ktX5+QiP
         36M2SaSP2qkZqG8PadvNjZFSw0g87hXHMqFSZvm7SA8aozmSdkmqPVqwA95V637qDIit
         HUZuUhqQy9do+eYkxmWuNJGeaLHpI1ztKK52u28MS05Ra5/73mfQwUTotQrEIXIFmaNQ
         tAVJahtfm3nf/I3Tv1oOrMCr2uPjXL2kuRDgDf0JdypkiZMxbbLpZ9/tGsW1mCoFcvbn
         DU1rQJaqdYYIAGPJffch6NFIccEBUYj0gC8vKywP3i5umWWseaDK9m27IbkV1kkIGJpE
         Hqpw==
X-Gm-Message-State: AOJu0YyyPQ7U2QR6m3+nO/Rc01WteXpfhp3Ri5barddqivQg+1U6yyEe
	HHfc5HFov/H0QWa4K75DBjgDCigU7KEBTuqQqPvl4OlOGBtBO8pgJa5DYu4TyA==
X-Gm-Gg: ASbGnctwTSC3y/k3wdbzxGP7pZXhX6dupo0kTZxJeM2TE4oh0/BHfNau0Vz61vIg2/B
	oIOSiK2y6LWB6g3BNOFaRCWyrT7klys6QU92apD3XF2Vi2p5o07RVehKvwEQFsN9EERoGWX2R8f
	8FdOQPC2Ab1M3pzrfLFficuXtjmj8Ae3joXZbFC85mxJ0HnOlHWF6/wIa2hHHbfgY/qxUAPe8VC
	SkdEeMLtSAws+1C3gAy2GPqgtumsEhE8R6oCwdRQbLahu8t7TVof6bM9Hs3QfVCZ9RUd3sW+Uiy
	t52o9JNcuGWI8sK49KFDyvchti70l2cZUuSFVmt2bulMkoQQCljnGs5h8NgeKpa3JC+IneDwhax
	sxM+ukh4LHNF+bUP0wxD1sCCcty5EeKESHaarNojt6buUtGCy/XoMnG0sNqfTn8jpLA==
X-Google-Smtp-Source: AGHT+IGzDx2ZGG74uBPb8PLBVo30/bpurLAcxG9unxSvSQs8JEhBQ7AxlWY48axu/Ockp0Ko2bJLuw==
X-Received: by 2002:a05:6000:2482:b0:3ce:bf23:3c32 with SMTP id ffacd0b85a97d-40e4a8f9aebmr17944642f8f.22.1759236343442;
        Tue, 30 Sep 2025 05:45:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:42 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 08/15] bpf, x86: allow indirect jumps to r8...r15
Date: Tue, 30 Sep 2025 12:51:04 +0000
Message-Id: <20250930125111.1269861-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
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
index 8ff841e73512..f79ac77e5a39 100644
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
+		__emit_indirect_jump(&prog, reg, ereg);
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
+		__emit_indirect_jump(&prog, reg, ereg);
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
@@ -3551,7 +3565,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


