Return-Path: <bpf+bounces-71323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6187BEEC13
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D2C4E7871
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1C2EC572;
	Sun, 19 Oct 2025 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbsnrU5M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCD2EC0BB
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904934; cv=none; b=aRpdl6pKyTMoBHvl0C0NEKVqoFGTTbB/aBO5K30APYOfDoYI7NkEd3qPbCQNhosnD1osgyqrMxaKEgvLKFLi6m9pH5al5xQ3vNQKw7nyu1yAIcOlr3CtyfN54IdCynWn9Tl38X1/eVvERuSJ0mXC4IMPPjFT4BXv5TwEf3Lf+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904934; c=relaxed/simple;
	bh=nVmvTrl0B11Wv8bBU3jd6jIM12dZFcKhYf3aYLP/dxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISxc94rQIR9x9ASRZty3XdFK5Qw1DCa7ejPORq83G7d5O07M4imlb9655GiOOlkwldu+Zm+fPPF5bF9lAg9NRJquG5UKB5wHpH1NDDg+mcvW82dYxMHk9Luudjr0khZahda0SKLa56ogxAyLXUwy9bjOvrnK+Xgn51Bim1p0gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbsnrU5M; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso30742395e9.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904931; x=1761509731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5BQrWI9PfslovtOJnhbl7Xnkk8cb6Rf5mpObpUMQVc=;
        b=dbsnrU5MaF8hZ8Mui1eQ3ja/a50NlKPMZPrwFFDXvD9rPygB4AHGgbD4/bLkXHuRc2
         RTIfcuXaZyCYdm4S9Uk9mnGmId+BOMVGDhg4V5CmocfPLILwaF3E8/AqOZGJEB+iAOdK
         V+wQC24PigrlG1KQ7khAUqlEBLO1AekujQjk9ZjqR5HsSYWdiq0l8oJRsNrfJVIeno1L
         C0wTRLxj6DCrEOa7/0hwiZb8uOdHgaiutLqRuh2FmoNw8qLvpcuEuTywAKd4xmDYRkza
         fTnUKllJxuH1QdqQDw5PXbbgWNh9SDqcCqSgKHwEj0Nq0bwCQVnAjEC4dly+4d/Yn2kw
         bhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904931; x=1761509731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5BQrWI9PfslovtOJnhbl7Xnkk8cb6Rf5mpObpUMQVc=;
        b=LCv8CO7rL0pl+/Hh69pBPsj9hyHyfVLZsOHmEdGo2REQwTNPLLitAQW5QnqC56vtir
         Gtp/bZYGHMKYp5ETA7DnyZp/4cGQrC271bvNDI/gX9kLCipgyfUAOF5ppwh39K/jCklc
         mDOK3lPOuj1PN5wYkrdpvkWWRR2JlUZe2fSScX6bIiw9D+XCtDY1LHyRLPntg7NjQo9m
         YzWC+du45R4zSwGPVcK+bQICJq+AIKownFx8ZOeGAcM2ezwgc5hi6q7CIZyIsEDXb8sc
         Ja4eE1X7nt8Libqt72txFjZGdwnXeQuV4rtk/JAqDO5fMoBejDNf/KqmcHV4sGdv1Rdg
         SNFg==
X-Gm-Message-State: AOJu0YwkRvBaXGILQtMwKLrtqp4oA2Wscfk2V/i+B3D+IKrBWo5OO6aU
	jzwcZxBueAoWbaAABT3Ifv2LSb5JauZ9hxxoHx7VNwMeUwCX9ylyfWKTxsV9PQ==
X-Gm-Gg: ASbGncuOlDP4i5wkfjzrvUBKtxYsfghDPsPq4D3yLr7LtWMOkmd7SI6CsNCjYXlVavN
	pgFDujFK8Pp146aa32OKZgqtiBVrV5j6/IAYkxUGnu7FlMF8fSrweSAZz6YysKYC105X+eTQpe8
	BwO53+n2oOZ5Oio/hJCS89dh3+9JbHb5pw5jLQ+Zbs2++OUqVWqJTdEinWGV6XglFn+tagQjWOn
	2EkhzSeJeM8ZEcEhoNPAzAbqU7YDA+QyHMG/N0Xi6L/0B2D+lqCoPe183ilyBc6jiKj6S3dDch3
	JEQs+7vXlEA5pAlAihofgrz8YxdE2+1A1xTSh9jpR988F9igzZwCGPbFFmUCB0Ygmk3qLpfz41b
	dJ1YU3TJsvEni40cSQhwkozx/WGmway9NTDSsZLnKM3lAPLC5/WSZZOueLYguwE0pP+iRLDgEJX
	ql33Jv3SCF6Ze+U0+0dBSgw+Q5w3MaTA==
X-Google-Smtp-Source: AGHT+IEnLpzR/og/1CTW1cNv+Y+WJlut9RGKERAPsHD7g5EB09bqJfOeSLetwnwrCSguXEy7bPGWMQ==
X-Received: by 2002:a05:6000:4389:b0:3ee:1461:1654 with SMTP id ffacd0b85a97d-42704dc9aa1mr8026954f8f.50.1760904930619;
        Sun, 19 Oct 2025 13:15:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:30 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 08/17] bpf, x86: allow indirect jumps to r8...r15
Date: Sun, 19 Oct 2025 20:21:36 +0000
Message-Id: <20251019202145.3944697-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c8e628410d2c..7443465ce9a4 100644
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


