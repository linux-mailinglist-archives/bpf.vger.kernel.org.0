Return-Path: <bpf+bounces-72262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BBC0B121
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0724EBB95
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982252F7ACC;
	Sun, 26 Oct 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY4OPv+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A72FE05F
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506446; cv=none; b=TtuJeR6CyDEhgj13sHG0eI7ajnCRTKpXjhMZwYx1E2fND2lHRCDVNIMAOY66ToL0uZnyJ3reVnlEjcZLSswZLFP9XgzZ7VySZ7o0itMlW/zqwtIjjqO4UayhQepKaMyMCsMZG4AuRExmpAhf2Ba/BDIltD+qbH+m0h6D+R1rOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506446; c=relaxed/simple;
	bh=NkCvQ+/IzcV4Y3Hv/Me0l0XPjVTq8HPF350pOe9F8yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NE4VJKdWNmXus4l5j4/aK0sWnWBIQNCaE6RsFtZ8iXuueVbCcU4DyJSDuu5AyoL/dj4pyZhdTbLQqqhwQ9fYdECeFLOG75wy8fFv4VzE0neRIki1GBePWnM83an5UTG8ZDedGpanuh3mmvmJ46WNdH6oKhbBb2iIrwrtv+njSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY4OPv+V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710683a644so31517715e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506442; x=1762111242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBH9VIuCTKsBO/EfhyVGe5LFsn1BpHeeo5svBZi0PjQ=;
        b=aY4OPv+VVxWozZ1gVZK9rEGNj/olWI/1RMOsUDGwu+OHUtMafcyp8iP8YZNxYDL7oL
         mL5ZjJ+W0tyI1HrbuLn9Q5JxTIhsBHvEhib80+lqUMPK9rIZPDdYoIWHeG9aLlrC8APm
         b2fv+oQVj1UKlcSD/UxippEQxJIG+BK+BtWVy4Nl14FvryuKFfRiv+uz2ILAdtaZqVvq
         JKPHBPChDY+AuSsEWOmp4RZ2m0QHi8voxvHeMGw94ArrBlzw8moPBjz4z7w2VbUxSgD1
         LzWtbPl4y50CNZTLF+oBeMc3mDJFYjjfVzUz5EPD+CvKzYWIX5VQrdXh2h81psXShvRZ
         B0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506442; x=1762111242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBH9VIuCTKsBO/EfhyVGe5LFsn1BpHeeo5svBZi0PjQ=;
        b=Smj+Rv0rIEC3wsY10rROyj96gIYv9P2zrkyTs8JjFxVoEGEVivNHjxayeZxywKKstA
         aqpEbFOTPg/H/XCDdVIzx1a6sCbIJA7/jZGwhRrzjnsa3YBRYVDsyKViO1Bx3JWPL6jU
         1TLkwUQ8/vHbhXXG3jpKSkrxBKlwWz55M2Muk+fvsI3OuE6DXztdLMxEdoju0DIqYOt3
         4yxa1TDpk4IXqxy+Wo3gJ1uj4288pBbhb4QvWcJenNfT7TULAZGx6VXUnLxY+kEHTYch
         Cnulgvbc+xEraaI/H0c6WuCiUbMBRpgazEHD+7Ndh37P+94sNFvoNuR3MtdEmLx0zEfm
         635g==
X-Gm-Message-State: AOJu0Yw0c9u8XlnKY77qsKSPg9BSyo9XQa0NRo96vjkOikOjoOb0tjCf
	ibQFOOoA4zTp6c+FyomHJdhsSsBUsTY2ePXvZc8vys4xc+PjqgipDWDr8DfOsA==
X-Gm-Gg: ASbGnct8ASaV2dR92ypD0zF37U07RWP5gDRMmZfRIAmDGun8yJbtt9FIqzW7DTJQQCh
	yUjeN7bCJ47jXD/ZooBAcQR5q3txLbcqtGqLpgWuj5in1bfubMFcbCw48FbB10Yy2Vi1Vkwtkmd
	Orhlml2vtdBNCl0ufvAyhnMJz//VAyKpr/RNMvYBp4WV2CqBd65aJV13i5hEAtgo+KIQSExtDMa
	0z60TK3ve9Xn1Tzz9OF8Yipt1co/AQSnyXffHVsLy0jdJ6tFi8u+M7mLo5woLfo45WBg8H61u3L
	qI/du5U08FMtex+Sw2icoiVKfMVlZWcI06iB3bV0Ytd5IR2Sy/yBHmYF0OWKtCGUdp0Rdphr6mp
	IDGa9tMGY7bGujlAIBJKij7goOu2XJ9EoqicPpUe9Pv89B8egzSS9Ke/X+YAucZstu69I0LcpdZ
	l9RgW36S33VzfAuJGvhEehIsXurHUImA==
X-Google-Smtp-Source: AGHT+IHLGsBuYB5cmLuGsbcUDaca0hiSfkPO1qguOvWSEA5ukUxnrBHSNe76Ls7W59dZnHDUpnx5BA==
X-Received: by 2002:a05:600c:34ce:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-475d91d2a50mr60807125e9.4.1761506440708;
        Sun, 26 Oct 2025 12:20:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:40 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 05/12] bpf, x86: allow indirect jumps to r8...r15
Date: Sun, 26 Oct 2025 19:27:02 +0000
Message-Id: <20251026192709.1964787-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
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
index d8ee0c4d9af8..3f59e8040447 100644
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


