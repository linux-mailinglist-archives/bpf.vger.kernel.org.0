Return-Path: <bpf+bounces-65824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B186EB29000
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725B27B51D2
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572731F3B89;
	Sat, 16 Aug 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0h1Op22"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6151EBA14
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367329; cv=none; b=SDnHrQNskbplx1i4Xj2LUDBtab+yuHT2fRQ0lOUwqHbFP5IaZSMZACKv95biuuc4dmw9eDCHqlK5gBEeNeqyFfyy9opLs3dmrenEPw8it5QgYooK8t8KOXKbA1uJloI4BctU4G+sYMiKhbm+LrUnj9yiBm+7AmeunDELx3aq+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367329; c=relaxed/simple;
	bh=97z9aOs/g01JQL8vhfYfvAJzOxHGsLUuqWB9oYZK8Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zay9IW9g127McxKr9BucHau9HdR4QadSH27gFL+zHEYsvHTkuVp39DdJGyLMZL4iDh+qnsqXbydc/v3POfsMzlt8ku5Ok9tLA3WA2JEKSfwXbp8Uhzl/+NkjalvS8MX9irvcBy68QkYxojg8+656chjo7w3ZX9U9VM++4dowfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0h1Op22; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so18438905e9.0
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367326; x=1755972126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnypSg1fJUXvTnKvKtosIwI3NjWg6ClGReUlzhywPcM=;
        b=G0h1Op22QxFA7WoVMweoRfRmBNd+hTPH5WIa5fdSzI8IUJdvijW/klQMf2Xkbp64TA
         p3u7hsAU7pemXwBOT19u9LOKwwn7J2DvmZrFl4CctEykCAcG694t0e17lOdni+LRjvkJ
         17yCwoaJjkvD3z0Q7BW17uEiabvbSaSgWUcYjH5GsRrGOG9FtU5jF24oRoPjBLigrKcd
         LgTS+AjMY19MlHgwrcGqgWFtrsNvaKF8jHmuxfQ3E0txUSJzMmi+mph6e1/qiSMlCsSk
         zmFVIXVQV25qj+JsmYTrNjgr0WRb09HW32/3IytHTiYE/Nzxr3nxcZbg8+lq9Wgwjfcv
         Gxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367326; x=1755972126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnypSg1fJUXvTnKvKtosIwI3NjWg6ClGReUlzhywPcM=;
        b=Uw5myXu50vC8LyB0HeUVtn19sbFll0B0xdo1wRbiFP/8VqKvljD4yDwkqCNaMtKN+Z
         9phSA1qJYoQ0vmyNxVMB4OhbX5F3DnaEmIhBCiJQ/ApBrmVKHX6iPptVt1U10yKB7c4B
         8ad9Uguu0paW//Her6YfbtGqHL8XHa5JCM4/ZnawLEGn4Vm2z8iYhbcUCNPmhNpG34jH
         uNVTmNfepCKqEmG622fAC6HqaeUM6GB17M6dHgpxKeGaWTIk9y8b1ROS+TtXygc7GipU
         M9XfjrRXZRTyZOnJL2bTIgtbn/fW/nYfIycsGBdb9hzyQ4ISDBACHDbpRG37Xm7Q74tq
         6hPw==
X-Gm-Message-State: AOJu0YzD/b16DbfTlhSSNZgl3owcMojGkW4WtXSNdxxb25GhlXcRLLiM
	WE9dhQ1+M+hNBvIjz4o9lY+DAG6Yi1fbkWd5howz4GkjJvMNsi9Zq/dX2Oc31w==
X-Gm-Gg: ASbGncun6zmfvy2TEM1gyAH/tpgIkBdBjFld3UQ5pOipwTtcsJpxtqdV/86TFGmRg6b
	l8pYO40HmOggIV3dUnlyFdAYSYCcyzdWQ9wCTD2oxdEplBw/TVu1VoQvAiBlliVn2w03y8XrYtG
	hixP0U4Rsa/nBrXV0AbpfZmxio/GGPQLlvF0hjjqvOlqeS8iZkAp3JOp2qZbTjvMCeKZOceo8WK
	IXmjyi4zzFP2nED7Sln+MAw3Db6Ml9Egm48VUvKOUTgPYI80Wo2FS+SfIGdihUKzyMGdrKSrn/i
	rYPOPyAcTorN74ySzxQdBsHvu8cqpx+OxBFXPCWMvDajHJp9CNQRyOhRZhV1ABtJJI5ryQhBKuY
	/XhlXVPmAnhmTIUJQBXIMc5EeleAZkfOKIpZpOl+83yw=
X-Google-Smtp-Source: AGHT+IFINeXqm3NwWMSfwLtZjMSKTa6j/aO1QV7lOoiV8xwkRvFGF/al3Y70XXoHOZnaP9B+Tv3Gag==
X-Received: by 2002:a05:600c:1906:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-45a217f71b3mr39940905e9.7.1755367326071;
        Sat, 16 Aug 2025 11:02:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:05 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 07/11] bpf, x86: allow indirect jumps to r8...r15
Date: Sat, 16 Aug 2025 18:06:27 +0000
Message-Id: <20250816180631.952085-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the emit_indirect_jump() function only accepts one of the
RAX, RCX, ..., RBP registers as the destination. Prepare it to accept
R8, R9, ..., R15 as well. This is necessary to enable indirect jumps
support in eBPF.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 589c3d5119f9..4bfb4faab4d7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -659,7 +659,19 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
-static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
+{
+	u8 *prog = *pprog;
+
+	if (ereg)
+		EMIT1(0x41);
+
+	EMIT2(0xFF, 0xE0 + reg);
+
+	*pprog = prog;
+}
+
+static void emit_indirect_jump(u8 **pprog, int reg, bool ereg, u8 *ip)
 {
 	u8 *prog = *pprog;
 
@@ -668,15 +680,15 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
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
@@ -796,7 +808,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
+	emit_indirect_jump(&prog, 1 /* rcx */, false, ip + (prog - start));
 
 	/* out: */
 	ctx->tail_call_indirect_label = prog - start;
@@ -3442,7 +3454,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, 2 /* rdx */, false, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


