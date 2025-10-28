Return-Path: <bpf+bounces-72542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285FC1523A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68C81C25775
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501F336EC1;
	Tue, 28 Oct 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/EfFJM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D83335BB2
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660918; cv=none; b=NRqMFHp8Q9dgaVnUIcW2sZEzSIkQpM07sgoi+MKtwXWeJ3YB/Nk69mFPoksXuArJQV6dAhLxatGZOfb0rDbicGWxRNFVmmTkj8M+EPqEGFmfl0jMgmOpuxwjCaXS2d4f3GThOl08V357TNfUo/NBlRFd94MK2dTFrQqlSWrMrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660918; c=relaxed/simple;
	bh=doP756QTuHweKd/cU91JPqGEYdF4hmMrvSKrV41yIXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozBWAk9XWGC72EOESKBSFGT8x0Kii0bnPrGt7HGIeIGwmoV975S/aMCmT1LFyFIDi/pKK2/48SZ7/BbbBDtli2Mb1NHOVjECf9nDoWsn/Xt47B3S/hrizUPZ+JFAbiUYPQB/dvFwiuP1lv3ck37c/426p+tcUxoaTJH70WV3Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/EfFJM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427015003eeso5377116f8f.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660914; x=1762265714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgAvcf94fUi4jSUJxrb21q1oHNEINoTcRH+PjOtMAco=;
        b=H8/EfFJMRXQ42km6plhPzLvTzSuzTiaoqaG+4z5E6oZ43PjO4gzMwXDNWkjXqLD/S8
         Ll/6qCkBaL3BP2FW8QOpCKorbzs/1s8ox2Ey8EJtYqkqe4faLBGDbKpnLMvyFB5q283Y
         zc2kQTkKP2oZ79Wzldncimf1xTGvrQCi1YFBCPiCCBzrxNOp6TZEGqBhwAExTUur1yyx
         HTE3h2MeA+QHlxIJ7kkOeGunx8HxVYP0pgLJHONdHsDOGYI9r+qILrU62U436LJD8SV9
         6anDuxoJMgMbOgEb4ftHK1m35LOU39L5zzaCP/yjCd4fPpzRryclDPe+ZinKR1rMx7OC
         Izrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660914; x=1762265714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgAvcf94fUi4jSUJxrb21q1oHNEINoTcRH+PjOtMAco=;
        b=JgWec4PFKTeHbaTVesC9Fcx8NGUr+2xXJ3my9eZyB0q/E1A6TDJ4gt3hYD2w1b/rpT
         QhnZDZgJKcEmPF7k4wG11dc0EhnRRK44YsQ61mHsEdRz4JOZ20ivP2rDkDJ7SfUpF9wK
         jj/Ug0wBhGBVYXnWSvuYpyjdZ0Kbg7pOgIeG8OseDmrhgFUi3RrMB9f3KCHusk1W2gjE
         xxYqnth4tHEzqJz9UNyi88ej2UP7jdzG9hb+DHGUhEKyUUFBjdKmwr2WDF/a5AnGcGx7
         KMcah9SWFTdDX0Aaw8VNWfDz0veftqXvkn6gG3Nrpw9FiEpXgWC003EzhKcuKKHMCo+g
         +T7A==
X-Gm-Message-State: AOJu0Yy0ZZDR3mNJvqMZAqiuLB8R2Ccv1mX8SAE581UQpywW33H31Fgu
	VE7f4MepKrYp+1F6wwYek5YIFsH1kynqGrmHDD9RYw1yOm9vOVzNMTBlQcVDyQ==
X-Gm-Gg: ASbGncs3COaO5MqeI4r+tJ/J9ghSipgdr4rK2a2DXmxrF8WaKuH4ediCkwKsHkz1Ywb
	d3LhzHLTENP0CJQDaY5VWLy3/n+PpfsGBUIs4yGnJ2A5N3dbt/5ZDjF5TWwJPwwdUOZ2IwG1jqq
	SUaSQL5Rjt8V34XKzDSXVEl8PhAen6IzIKt9V1GdfaafVXw2iExy0DljoyUKcjnVcOUMcpmHzHQ
	vS43B7lilHR38+5V9/5O667RCZHVB2lieyHTEo//MOrzHjW9jRTwPbk1I8kJwYi5vfHEF+5z+LM
	8qd58rOjWmMdmgANpnTKoHeVDlPZLU2M6R/ZdJXmT0Yw7TPHaQ5QLc5XloMUq8494YtrA/nsG3i
	pv7x/uKoTTMOWv/4vClrBcoQzNpoSR8tlGc4PbdNvvWRdtiJHqr7t8lXL79+CSlCQZZS4GCE4V+
	orAnkTCYc7me1y+VA2Vok=
X-Google-Smtp-Source: AGHT+IGeFc8q5qqNsQiApCurjvgLOv/SBWzvCV7QThOV3bcuYkV5qsCDtBsXxmZPZNJZQFMO5cti/A==
X-Received: by 2002:a5d:5d13:0:b0:426:d81f:483c with SMTP id ffacd0b85a97d-429a7e81fefmr3223828f8f.33.1761660913566;
        Tue, 28 Oct 2025 07:15:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:13 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 05/11] bpf, x86: allow indirect jumps to r8...r15
Date: Tue, 28 Oct 2025 14:20:43 +0000
Message-Id: <20251028142049.1324520-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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
index 73a3055d59df..c1f686df6fbc 100644
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


