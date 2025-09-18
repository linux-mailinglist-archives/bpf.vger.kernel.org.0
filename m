Return-Path: <bpf+bounces-68758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A7B83D07
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29A47BC109
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464752C0263;
	Thu, 18 Sep 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFlYj7Zz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB12E1F13
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187968; cv=none; b=lxrq9yf6MZjVeuqgYrxcP83g8blbvm8boFsmz9IKciHUYqHnFt79ebS+zliYb5MxBUUfBLqBvAi48ZPopZG1deQD6dzT6V5iMgVid7SZqlJsp4wfplrA8XGhLnKCs3TsMys2yIUamxRL4rfkx6MtCAXLdViit+ZBeYr+5KaQNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187968; c=relaxed/simple;
	bh=ZBu0hxEf8gBQIW9phpB5YWnHl1+ES4a+3qN7zp3D+sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBaJqaUloZMcaVcsxXHx27lUJwMLBDMRFtDsHAJf7VU88WkBREPzSSCqE4saTLHMj1k3FHEP2K4iEvikwPfxxCs++TE8qkruoob6/dGAplIzsxAcClqAhkAJH0sV5rPt2ss1cnx9zScJwqVsdXqEhiqvvIngLdiINnfcy5xji8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFlYj7Zz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso441821f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187965; x=1758792765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCf39Yeh2Rl3Ijb+ZRoCRxmNecYknQI1W/2SSguxpUQ=;
        b=bFlYj7Zzmj/dFfKhc3BDwuqywPX8S+XIasNzSzVbdQGJsDbg1anb7XHvvXT3RbI0Fc
         gwj5V8/0AsdFodE8Jv4Yji7FtMuBp9zWLz90zlyqFSzUVbpyIv3LWZauha91al4igpa7
         VBn/bm8o2oLV8k0dd73D4GppghWcHTelbopEOn7y/3ZJ+8rCn6cs2zybW19I5bEKndT+
         hl1IfEhNZzn0YhOtYKFr3U13lP4zDBiGRl59N4JfIOpYZyg/aFtb/rAzZboLF1s39gJ2
         /OldEwbbQ650YQDkySMn5uszMeEAeHfPfDPh53gskFpSWhxDVvcJKkgIZq7KMtpLe6kB
         H+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187965; x=1758792765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCf39Yeh2Rl3Ijb+ZRoCRxmNecYknQI1W/2SSguxpUQ=;
        b=J2Nok+dIsYpQ6BE7hsWrZ+5QJCcKK/ZNFlhaVOF5BTIo7CJ5xo4dnCFocvHodeI8WE
         +W+5sZ9rhPLLTdN93TJMCRKW8735Jcnk+3qYTvtA581oEDH97gIcU9qlCBKIiuCyy0z5
         spIDgyHSNT5n+3Vwuz8Yf1t7E0YdfVkgYR402yyTez6UZ33WpOmZi2HBmfIS8jHhcGnH
         1UXn/UESf8H7bXqc9YLmN6ZLXNQKR/IdsA7wzwv3ZTKVYTEUpQwiEfLe166SmN7NartC
         ++LuD7DBRJG06TCscOw7V3qeBsVCxdVBPbIdIGbwGyzZKuTOk/ORedcMk+WkUtPaJFC0
         IcUA==
X-Gm-Message-State: AOJu0YzTsgM5p0eJW9yQs7FiUPL6sm9TXNGrE7n5i3qbE+3ME8ENDoZq
	0xdazoPbH+kcOwE8IYURKK5XBbypDugVh61Lxy3pexdqe5Dj4/S0XN2UpW6scg==
X-Gm-Gg: ASbGncu/qKXq8gBKurC84nOchLaAGktBe/HVMrOoDN/J6OKzddZcqMet6Eqf1DSAUVd
	O/lsbOIfRZCqHeSiyVfAtSuWIBBPstVfoCLvmJHOUelNtRD7kMpuAIabt7xUnAxAdV4RoRzJLBs
	gBYUHw6ms/HVT2y4lytrOLuYQTj1sGV+teNrh9Qe/MpwbQj5rl0xViPJTcZtMQOMjTjYbwIqo41
	PhOUZ0kRjd+cyKtWaFLpkLEf260JRUL3q5p7MStIhg8+V7mKlaBd2QfFqEcRErur5CfoSzUrdX2
	2wc+zA2plyc/ZCoN8bk7OIRx2QBeql0x8oFOmXRXwDG2iuoomNBVea07xJr9tXG3BCNqxzZCa4D
	XeCZWkXg0MVYUdMFZBANmvrTzVJsED0VMqjjY3uh9JdSvhmdAXza94aBk3rJTFfXirYm9kbM=
X-Google-Smtp-Source: AGHT+IEKlOgDdqVhpPC2D+1jFKMiORdtA/fygtXhK3knji5QIhdvqwCdAimYvfgbDjwGOVjKzwHDkQ==
X-Received: by 2002:a05:6000:608:b0:3ec:d7c4:25b7 with SMTP id ffacd0b85a97d-3ecdf9b88d0mr5253210f8f.10.1758187964839;
        Thu, 18 Sep 2025 02:32:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:44 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/13] bpf, x86: allow indirect jumps to r8...r15
Date: Thu, 18 Sep 2025 09:38:44 +0000
Message-Id: <20250918093850.455051-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
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


