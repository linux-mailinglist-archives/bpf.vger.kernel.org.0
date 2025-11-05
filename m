Return-Path: <bpf+bounces-73594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74080C34A97
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D00014FB923
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14E12F0690;
	Wed,  5 Nov 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/MKrGeF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A72EB871
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333088; cv=none; b=rmOaZ6XMqJO30k8eQcUtdYhRXVZGE73UEuJM08/PIaOtrqVELj1nGxoqsThDYwTtXKqwWXRaZEqBs4W0Z3qBnN4kp+O0prJoaWXvYPU0flPdOksYKpe/QQanYl5RPUKZQJy0m4/iPBVpdYyqVT+zxavOpM/5xoT7Yyt0l0zPhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333088; c=relaxed/simple;
	bh=kE6IsFONuWbOUlzWP6MHQNEdo6ze14CWOvuMYUWl/Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3mbNB+ArQXFtyJbI76OUFAVErfI9KQnRjVbh/xqyNbEZSLjfCN1R0hqwhz7FdfIven0Gk4lkCZHI9AQq4+KewML68MTWBcIyY9A1lih/F/btXvDxP9pnIIL0eni9suficRsXrRv03js8pQfODcE2sQOlyMmu5384JAvMCP8vOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/MKrGeF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so5940111a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333084; x=1762937884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c86Fh/7bS4S9gGEm6IsZNdJ6Jvh5MfrOorvayHjy+tg=;
        b=X/MKrGeFf9J4M3W/8rJII6U+acaBykKvUSOPJI5OLrg7l6XUDhkBYPv/i4zDaWWtkr
         7C2zJ4jQsEzoZ0cLdOzYCRpQ8AguZbRvvnhXT1/IA3oBsprgdGHIiH2hIMqVXwIZcQld
         XkehW+GFvfj/3HRMyH2bHvfKDCLhArkLhEBIr0pLNqj6R4L7g8jQzXf9ENutBaE17ykM
         cEPGwVsHsX26PkCEv1J5/4hnMKjxRd5efMOpGqkmXoBDWR4vnfBwCRinhUIYf+UuAyKx
         buFTnrMBoHhWBkdrIo9MZqw34F04tsVZaxjrJUIAXPrA4kDliAg3+EpA8swnCDQKryUv
         JGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333084; x=1762937884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c86Fh/7bS4S9gGEm6IsZNdJ6Jvh5MfrOorvayHjy+tg=;
        b=W3eadwA+fY75UbGXkP1Wa4uAwsIlfVUiFmCuMGEoz4pDVBAmKALXbqHGBNY41iI3Fx
         gW7mTf1i46nRdG7mdAUG7EFXdBLQkx/vBkvU6TUPxQcMB+WOg3CPHFdCkgMMu4c+zp9N
         hS9y/ArN9xL67xU6ulOwf+bfaKb6K2KcVeI5FyoOGck8r2T1ypsg5D24dDaZsGxaOX9I
         H+nNXDegPWBruUmVGxQCnHYOx0pv1+m5FH5ek2XwdqSRXdKMU8qzAKq7lJkaOuPICq72
         VirZ+r9V8b8Id7JCqNkmwcEAUZqOqwYTe/HYssnfmgZVGZ1phxlsE0dZmsH2pvGoSTPX
         2pyw==
X-Gm-Message-State: AOJu0Yw/1US0V2gadn/+CM+4jpjptLpLcVvyhgbl3JumQOMxcb/xZcD9
	DcHDB30u+t0U33gKhj5KiYKppSPwtygPVuFyDAlpwdo3jgZkujMU0IUlOKQS1Q==
X-Gm-Gg: ASbGncsAfJPr2xo5SaJW6v24ME3YWDhLOCuuxRVAqtcEeDpf1O8oyjdMS43f+brkjZM
	47Nvcu3Y3ZxAAghDCMYzeDac4PgI/chz5cGvHFlbSVDWdfCUW2uknpXcyKzfDpwoPMYtcDl4lDX
	XZVTuWgZdptG3cT6sCWbvP5EYtyd5Ec91GdqXmGELlkQucByI7ppxyM4+6Qr6TLzGLIcnM49ZCy
	IIrz2mzrqgVr7LABZxVU2/RRRUgysgkIQRhEf0ql00INLGgpEY6Z5uwCHH4GnhJym/5Tfggj3IY
	EnoUh9M0cPqclY1lOLMA8F6qe0x4bmTbwgukk2hkAWl1Pd2vqXb6184dxt8nYapQcmfLReoIaNN
	7uPfVTOO0ufvy4+x3lRJOZRin+ugDH1x4EDJzmr5nU0HTN0YOIt38d+GDEss+rAPOf+vi30TVrj
	6R1nlMeOsbOqs7bBMiGg8=
X-Google-Smtp-Source: AGHT+IFxOlqhZyiMjWOFmNf/LNMpACCvpSdngZNXAXoIFhE3uYTUQFJAFdJvdD6F9i1ondxTLprU3w==
X-Received: by 2002:a17:907:c13:b0:b71:ea7c:e509 with SMTP id a640c23a62f3a-b72655097ddmr211602966b.41.1762333084348;
        Wed, 05 Nov 2025 00:58:04 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:04 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 07/12] bpf, x86: allow indirect jumps to r8...r15
Date: Wed,  5 Nov 2025 09:04:05 +0000
Message-Id: <20251105090410.1250500-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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
 arch/x86/net/bpf_jit_comp.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 91f92d65ae83..bbd2b03d2b74 100644
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
-		emit_jump(&prog, its_static_thunk(reg), ip);
+		emit_jump(&prog, its_static_thunk(reg + 8*ereg), ip);
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
@@ -3543,7 +3557,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


