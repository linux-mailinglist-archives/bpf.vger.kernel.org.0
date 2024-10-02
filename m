Return-Path: <bpf+bounces-40763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD07798DED5
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21370281AC1
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C91D095D;
	Wed,  2 Oct 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6tJQhC/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41691D043E;
	Wed,  2 Oct 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882608; cv=none; b=pM7EvKY8zO0OAQ+ZAnBoBRgGpRJPa/xPaU089Dtjpqb0ql2ZLiqix3s6awxUYz3r4kC0ouqWXL6sj4Wa3821KGsRUZGBzfrvn++glfJi8J5zqqF01g74HCbgaE083ikQbuNir3g0dWhf5UJwwtO/oDPSllTwxZbeLQjtP8qDQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882608; c=relaxed/simple;
	bh=9QgEWSC9Cg8flSSZRMn33S16yR3aaX8xH79f+g2M03s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JODqFCfGRXZh795Q0DAOG8TPyOaIvlxt/CfCiCicTjDLx8Fq0iocEaPY8Ln6nf9BfH9Bwq4BCZ76hDX2wx0uG1LPhXwYDUPAP0qCIX4HjlJ2iJBM+Q3L0Pah01aFNRai0J+uXSdXKX9SBMM7CNAoSYveihqtnkeNPPdTf96qQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6tJQhC/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b4a0940e3so51329445ad.0;
        Wed, 02 Oct 2024 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882606; x=1728487406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NUXisVM/wT+DZeyGCacC+8atQ4U/vkD4j2oPHhfUC0=;
        b=j6tJQhC/L7aPLu0JE8FzXCGTYhmmXrpoqCaiZ0uJoY0/EcnfcYH8/boWuQgfEqT8E5
         EBdiqLLHPdflc4w8qcDwLEfaG3xELAdzv1T3VxNRuEEX3LTrCZGqu89eX9T8JZNa5Ibe
         /tl30pN0Pa3kt1QyQ7HdAUxjKFub8OoN/hv0/k915cLyUN6RDbY5JQ2gjRWwbZb3KFln
         NEUWXHGdH0tVJV2SuKpnmIdKdER0c6OHvOn+ED8fXU8h6cWDjDM5jSF6HYRZ00YpBt1R
         V5jMbqQH6Zy1Pgxjfprk3bJpQ+rwWqH9bVKTlzLt7gZZ3EGw0wQos2aYwiM2cDwLuN65
         i1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882606; x=1728487406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NUXisVM/wT+DZeyGCacC+8atQ4U/vkD4j2oPHhfUC0=;
        b=L8cdEaDq4Eqnq4U/uIFG4qLwBunHzjvF5G+cO4ZxXU+gQQODCXRV80uve+FH1UYghG
         h3Zgb1lYxJR3Vltass4p88KxVdGB7vmzOZYR71qDVrUOQsVVIGE2oYjc1DOdGA9AOKyQ
         AbCYAcMDJU2DKPHM53qtUyJr30Eo83ztjR7txHbWVfIdCLeEBqLeWSkg4QBZBEBqPMiN
         P3XZt3v/4ul6Wz0kz3qKp7d1MwOHC0F5//AwOPKuUZRIE2xY+konLlPIOv3QLJA+s4cw
         WG6qaaOaFNglGM1RMwe7tmmu6QxdhVXZGrcgoa5TtTDGaB6TuRVNG1XYZigQ5dIJgriA
         paKA==
X-Forwarded-Encrypted: i=1; AJvYcCUAeVR5UmwzMIkrsAC4nGFksOwhfJfc/n9fgDk3jjoiRN1H31br7VZrrOhXClDUqbxFtP2opowg0LvIQg==@vger.kernel.org, AJvYcCXS53xJRi/DMr/k5TG5iSoN4RSo5M4pYCs7QkSXk5icf9iGwzcKVDNzoZ47Zt12o2CdJdGGo0zh6GfXLFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSCy6/ei/H5o0OQ7322qGxH68NTblyLkiLWMa8OI9HopMQ+hm
	MUYD5G5536Tl4hV1ndlM8TjWH8DxunB9IZkYgYOjyc6LQYD4Q8uZ
X-Google-Smtp-Source: AGHT+IFbfDGXRUm2r3ukhbWnDtWidJGoMNUA4e0wogsxnZ31U5cqiP2sksQHU7YfX7khnE/NZHFNeQ==
X-Received: by 2002:a17:903:32cb:b0:20b:adec:2a26 with SMTP id d9443c01a7336-20bc5a0a81dmr59914895ad.15.1727882605978;
        Wed, 02 Oct 2024 08:23:25 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d8ccfcsm85991365ad.72.2024.10.02.08.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:23:25 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next 2/2 v2] bpf: Add BPF_CALL_FUNC to simplify code
Date: Wed,  2 Oct 2024 23:23:20 +0800
Message-Id: <20241002152320.388623-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changed, like macro BPF_CALL_IMM, add BPF_CALL_FUNC
to simplify code.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 2 +-
 arch/x86/net/bpf_jit_comp.c      | 2 +-
 arch/x86/net/bpf_jit_comp32.c    | 5 ++---
 include/linux/filter.h           | 2 ++
 kernel/bpf/core.c                | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

Change list:
- v2 -> v1:
    - fix compile error reported by kernel test robot

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 73bf0aea8baf..076b1f216360 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1213,7 +1213,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		u8 *func = ((u8 *)__bpf_call_base) + imm;
+		u8 *func = BPF_CALL_FUNC(imm);
 
 		ctx->saw_call = true;
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..052e5cc65fc0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2126,7 +2126,7 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
-			func = (u8 *) __bpf_call_base + imm32;
+			func = BPF_CALL_FUNC(imm32);
 			if (tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				ip += 7;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..f7277639bd2c 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1627,8 +1627,7 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 	/* mov dword ptr [ebp+off],eax */
 	if (fm->ret_size)
 		end_addr -= 3;
-
-	jmp_offset = (u8 *)__bpf_call_base + insn->imm - end_addr;
+	jmp_offset = BPF_CALL_FUNC(insn->imm) - end_addr;
 	if (!is_simm32(jmp_offset)) {
 		pr_err("unsupported BPF kernel function jmp_offset:%lld\n",
 		       jmp_offset);
@@ -2103,7 +2102,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 				break;
 			}
 
-			func = (u8 *) __bpf_call_base + imm32;
+			func = BPF_CALL_FUNC(imm32);
 			jmp_offset = func - (image + addrs[i]);
 
 			if (!imm32 || !is_simm32(jmp_offset)) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 99b6fc83825b..9924b581aa71 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -461,6 +461,8 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 
 #define BPF_CALL_IMM(x)	((void *)(x) - (void *)__bpf_call_base)
 
+#define BPF_CALL_FUNC(x)	((x) + (u8 *)__bpf_call_base)
+
 #define BPF_EMIT_CALL(FUNC)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP | BPF_CALL,			\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4e07cc057d6f..9832e878fbb3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1278,7 +1278,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 		 * and the helper with imm relative to it are both in core
 		 * kernel.
 		 */
-		addr = (u8 *)__bpf_call_base + imm;
+		addr = BPF_CALL_FUNC(imm);
 	}
 
 	*func_addr = (unsigned long)addr;
-- 
2.43.0


