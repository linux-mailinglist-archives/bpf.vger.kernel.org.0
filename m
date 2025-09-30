Return-Path: <bpf+bounces-70017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862CBBAC8E9
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB35519282EA
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F82FB0BC;
	Tue, 30 Sep 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmrVt0jE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72A221FCF
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229395; cv=none; b=Gf3JSemxyWlABUkcesHK6oUebj9BlgGZcmV8bzhFTZZ5i36p1tFHlAaakziZo1WuHpM0/8BGevoEl/1O4P9opFUzdioUlBz/M9sMeGemanbTmgv4kma8YnuABiOJYfOxixlKn2dFShK2rY/kRMTFxaPFKDgSQBSnKfmca6rUpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229395; c=relaxed/simple;
	bh=3YXJryXe44ljZis/yIDl/4CnJAQngii5VVSIxposQzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tyrzJsaLvQJCitCjipSGdW+ct9VRvSfozArE+C90sXE0T3n6B95LhhPNgtm0KPaD29uqEJeS0p3JrGYe6xxRuYfPu1bevMwhoPMFogFRc0fk0kYPz9t/sTSCQlXKPeDnlSEYuJfdJCcsunJvwFK8HqRDs2GHdS9YKmVBqgZhHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmrVt0jE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so903179f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229391; x=1759834191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzjf28aA/CBR5p6C0Ctz5xuVDNFqrp8NRNfjKb6bWXo=;
        b=SmrVt0jE7Z5eVFm7CSf1gVzGtyQbvE9/IsmjbQcAPSDSgdc4nSyqeYrQt6nac+Q8Zr
         vB+MAvdaJAu+ynuV7Uepo+7Xy9DG8LpEHY1b4OiUVhkDewP/2HkgJAWzqUkgpHGNdKC+
         9rOghxWKJRsvO6oWGxnzmuiqKdfbsz4/lKsmNWM/Kctwb+JXtKxitHtt4ONzRKxlRoFO
         Uppr3iBR5zunh2GZxhTm3nUcQU0QSFs3nLMeoZ75gaufVFU2ORdE+ekvF0lCBPlqJePs
         uYAcfT3xhZblDTf4DhdsNQu1qA1pG3A+VFRiqUgLNIwcD6EpZE6vreO+opwOI7OAGMac
         cdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229391; x=1759834191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzjf28aA/CBR5p6C0Ctz5xuVDNFqrp8NRNfjKb6bWXo=;
        b=YK/qdhiJraF+qg9QVtoEX7H9NRMvs/HlfHf3xJ30M5BpaCwKuFonlcHKB/VRZj9HEA
         yNNk92WjyBWL5wNufdhsYX6WoEk1x8qTBufUIC2BgcTHCmWuinVyvc8Qp/UnO0sK057C
         YkZmsb16eHReWcWwq4E2dFAebNZG49CrGgDRUc1zMBlID/jhun832fBpp27SAB2a/GYd
         g8ujVXn6RQk5d4AkZnUrrcJb778bnTet8ym88Ym4v984Zx8wEX0ZX9up/ZTNj1sCKZYP
         2knJ5MGwLRmhRW3rL8q9gKiVKY4l342DjzV70gg6gReflDwkvKiJK3KutjUY0L7f707Y
         CwZQ==
X-Gm-Message-State: AOJu0Ywg4wvgJOojxNSwj99UoB2A1axj0jpOH13dGAWoOgG8vKPhskeQ
	kPZC0BtjbgPV787tNmibcF3Hm3fAu7DcCDwamyEuTkmtWDCaBU4I6aocgvhQlA==
X-Gm-Gg: ASbGncuxJuIH1aa3hvigXgwDWp43aNrGB9TumKk7o1VGuRX1xdgYyZppaZ/A8TKQM27
	QjRwswEFZQlKNFAkjVh6jxO9ug5MC/BSyloFCnV9XgEO8gmBYW8SDQhERlEop5keTnuImMLwKX/
	GRZ/uTE7W8KxOd6Zi8GvTksd4dfDBBm9E7GMIhT55w34BOgfDlSByOfSbuMA4H2sz5G59Gs3uVD
	bfq0ANHUsrwpfmLQevB/iaeF8QCPlnAUcaDjD7EoD73U3Ar0heWYjtae6MGSbe2Xy03SLw5qnc9
	7a2YLxwFA/+g/j5n6Vn++U9NZRs0P+36RviL7SQFdJ22vlhoKQnzRFuOQZVKBc0fXNDmPDm5lWT
	ete82fpXN+v+Jfw9oLwfcE/TMtWxLjYKR8OfONfFCcQMaJidpmgQlHQC0che2wm3E0/Qxwx2KVM
	qH
X-Google-Smtp-Source: AGHT+IF6uwQHDY8PZRYsgpN6IWkOWD2KSYwVpym5v+pAx9G9+S2CPzzU3lEr7N/NJQsb04Vm7FBTuw==
X-Received: by 2002:adf:e6c4:0:b0:424:2275:63b4 with SMTP id ffacd0b85a97d-424227564b6mr1388413f8f.61.1759229391346;
        Tue, 30 Sep 2025 03:49:51 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:50 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 08/15] bpf, x86: allow indirect jumps to r8...r15
Date: Tue, 30 Sep 2025 10:55:16 +0000
Message-Id: <20250930105523.1014140-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
index 8792d7f371d3..d0f6643a4025 100644
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
@@ -3517,7 +3531,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


