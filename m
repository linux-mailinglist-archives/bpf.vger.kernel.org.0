Return-Path: <bpf+bounces-73231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C19C27C55
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F82B3BC01A
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9F2F1FFA;
	Sat,  1 Nov 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEHDMFoT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B122F2606
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994873; cv=none; b=TJOr9bkbHZlvAQ3QqQf9HdktEPhGoW/tubqICHJ1kmfr1rgfFM8JeVV83ypuwGdJ0wYlNnEkeH0KBIkK0tke80a0CWG/fikryh8f/kGYTrm3EJEwtKie0Wk6QAENzLRDotdTXoeCtOVfR14q31AK8ypXxsqOj5mxJPSTePE/Osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994873; c=relaxed/simple;
	bh=r/zO0xVYZl17IQrjoREO/eXyaHGPfl38DxWwAceYxFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozKlLW/Aj0qpSzPqcwr1C71f1RLdgcuBaj01zG/t4M4cvBJ3s4ZwswMdvpAcxxJZaoSJO8YaVvdbSDTbN63P0eVkzVClU8iz2XUQ208Z3ucZQN+oleo/Y1PNX+5BeZg+MVgwrI9gB2fCe9/cXPCfSxS9gERtFXIFaNv/LFX6+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEHDMFoT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso13930335e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994868; x=1762599668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRJmLQcgvdkl4a8jsXEPMADo/+2a91riwUAx70XcEpA=;
        b=GEHDMFoTM/WLDzi2Tnd0SVp/bDHJOZ3swDnN1DSBKhf7+/cMv6bdMjueHvBq44Kcs6
         bCHyQwGD9TIKoCmfmdcS6RQvLuyaPh/6jxpOgKL6ec9b9BFcRtgwnX0Hy/9m4hzMeD84
         waDeDXG1nw6nv+4xprR2F1UCkVkQ31UdvZtAPeIc0lkzBFITfQ+R+Q6BP+ZOhz2nWkTZ
         v63vtKODSWtiO9SKo/DuI5+Sd1pkyaG7glThHzwlCiBZ8MloQV2dM3l2fnuC+s//ZnBW
         E0Zxsoy+3uJzPrGJnh0NwuIi6PBQOvly2qZ19tOiia9w+2Ub97mIXbYX0tAJeVyIuKqB
         mPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994868; x=1762599668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRJmLQcgvdkl4a8jsXEPMADo/+2a91riwUAx70XcEpA=;
        b=OkM4//sy8F+/1wH3TJeskc61q5yf2Qt8hNuk8qZmRmBdZUPOtUCLdwDV+KKwIEXhFo
         wfL98/Rmj0HQKq3tie3eHD8TPoSw7wvXI9R2p0gKRpz6ipxnStbqm8OFr7gyRye+4IQf
         AqI/uq6oPZQ/1XrdHXLnsHf2x4gML9J5YbPQBPHQr4YVyBhiNk5zTjsV7bHuXjzZtuoN
         avmaLdckd5uG96uAV/kPE2jzV758EfQtDNJeKK1WTqON0o2+T2Btsw07YsgT5/0zD/zt
         E4NTME38aFASyZ93/dnvvVIzHPmBSo7/NeOqMrkAjeXMBu5cbUxugWABPjl8s+crAMdV
         SDqw==
X-Gm-Message-State: AOJu0Yw+J4NHYspXUm5jkWHEyr1XRA+BPkE+ZSc1UkSAsiyzhlLbwm98
	yYguqgSTpBegU9By/UrXaHMczhR7uxxCEvHEw4+2F6Efx1aOHIyUKibUrhaB1Q==
X-Gm-Gg: ASbGncuzIIYgYnMBziSqwhS0No573A/jEZoHe8TXbjmdiVXQTn9JLMvqmNU0evgiSJ/
	jzAv333kKBXjI/LtM65yB7QiUY3L9boxYBATESSLoetPrnNRVxY1tF5KLg8kR9y5Pp3gWyQVez8
	MOMMtM8B6HR8/ig/NQfnberMpJXaZF+YHoAI9rRDOfVwLWf0+HXO2uyU4fDjDFITtaNWq2U7YCj
	1xVgJ5w1sYgvTiSzUpbTA0FSRM+FwaudXzru59+AMfkvIdqBPL8ZfVLrSsF050Yir9CCDG36jRK
	i1QtMazdhid06c3zzaXDOL/3/j6z+mmROz+MC9fXA8vaY+V9MVP4LDVwGRHFB0wiY5zb6SpzXaQ
	kPickNmsQpJIP3agKUPzStw3z4qy8YBfcfgjdqDJ+Y/rj69WgUtaCovHcOH6IWbchoCpH2pVox3
	OBBEiRCLRmIOkKaTaQ+jrhFpfypyVF4w==
X-Google-Smtp-Source: AGHT+IFE7yexOZNDOBb4zczU4mGHve9mn+zWi5zpcJ/yTimHbVH+QpRtrF3cUp48/W33U5nDKrejMA==
X-Received: by 2002:a05:600c:8718:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-477308aa6aemr50718115e9.26.1761994868078;
        Sat, 01 Nov 2025 04:01:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:07 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 05/11] bpf, x86: allow indirect jumps to r8...r15
Date: Sat,  1 Nov 2025 11:07:11 +0000
Message-Id: <20251101110717.2860949-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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
index 6e3574033473..e7123f0f2e66 100644
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


