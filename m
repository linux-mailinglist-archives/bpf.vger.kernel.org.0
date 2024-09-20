Return-Path: <bpf+bounces-40138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3197D791
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411BC2846C5
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0D17C22B;
	Fri, 20 Sep 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmf7IF0k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D691F4ED;
	Fri, 20 Sep 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846663; cv=none; b=eGuAfpk2XxhGAvYRHR5cbxi8xXz9mRWw13ghADwmjDJgOwKl/dpt46qyqarIs27kODIWFhITZp4Fr5w7IzeqALSp+M6akpCoAC8OTuFojzNtWtixafs2wZzGZQYrhZJlu3x1ob73OobTP0YHuEO0ypmpCBlCR3e7GCY8BIEfDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846663; c=relaxed/simple;
	bh=IBNi5+etZxBxaJtA4MvHJd8EcTOHUlXwvzlgxQMIVZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nMEsYXyfH71aVKAKUYPQ/qKelCMfkMHiuDwpdSupRLabXmLoJC1j8gUhtI+8Z7Obbg2oMJ2HpLCCTGxoVnbSFZJGGpDflxenBt1a8iIoz/mmH0QtuzjxIVXrZyDvYjSNZWZ88AH3zHqvniOEPvMDFMvWvc2E80i7fNCMzZpiFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmf7IF0k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2053525bd90so22108685ad.0;
        Fri, 20 Sep 2024 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726846661; x=1727451461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZPEWZoZN6gyioYEDJsWWtC09rzdzpFL6+7dviCo3C8=;
        b=nmf7IF0kWlXHbCbay3kjoBkYO18pg0nz0C2Ta62e6yDxF7lm3IwU7paR1gdBGC8tBd
         ckGk1sGiqNlSFpmNMH9hWUuepTtRvQcmHQ7bxFzhJ6rTNGfg0OewXID0QZXf5fW/ozsd
         R8TAemCwUb5NGeRE+UythzrBp3QudvSWxPW3bw8TzkphOs8e1lauJEIuKgn4QKmZv4ln
         CVfZljwpp9XDRgB/8E3TnZpvp/HvFWSsFCb23ok+6eXs+IdqUCqQpaT1lyZ0mm0Lhyff
         oRDX/K0uVuw6n1vMXiYjOKyoAvTPhSS9Jule1Q1pnL2Ly3kwdGtKovXs8L5MWqJUxKT3
         PP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846661; x=1727451461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZPEWZoZN6gyioYEDJsWWtC09rzdzpFL6+7dviCo3C8=;
        b=gi1tFA7SzO3F/6m/BxqB5zNfq0Hb3x4MhHEEjSNAdBH1cxjOAT0XXWXdl1jDalLS0C
         AXhjyP2GouGe5+Uje0l2t44VGjg9RDY3ukhqTE8nk4wykDlLQGk+F1RiRK27F7zJ5pxL
         0gGIw0qtRxUFKJ1WLoLhu8ze/lpGHE44CeTnEAASy+yt5p7Pjsn7c3bJXvIWL6UNpsMh
         WBWdM0QWyizPOlZlYBOfjzKkuNxvgOMBufssTWXyRww71krqQIHHT82qDyBrz48U5bky
         nQUKO3Dv7lJdFj8692M6hNXFxBYuCJMSIQAGkWp90hjzsIVH5f8p//ec0GPptccSCVmD
         g2+g==
X-Forwarded-Encrypted: i=1; AJvYcCUad4OiGRFbBbYs2tFyOtC3L0KZ08TqyNkwUOiaGFODC4TRXJo+nOgK1vh5fFyHv9CyHraDlhTaPLyq+9E=@vger.kernel.org, AJvYcCV3/hz7Vyzj75xuQZoQbZo4ZP3pyO10fA7vPNvp1fLv2lWBva1z5+T7w/+VLHB05bOsu0PELmWmZitMxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy154+7n5Agnf5HblGja1bW8oUvpdYUcI7Ubo3ADq+w+7SpUAnb
	H2Bt1ioKnX/PeYZeZkgmd0M/Epxkwm1RYQy+zH8iR8V6WJl6x9WJ
X-Google-Smtp-Source: AGHT+IGPosCOh7nMMAoZzPbV+Z8FF/maBKEqdN9fsZINhjrwcKMd3EXETF6KUBqarQWAqD8AXU9C9A==
X-Received: by 2002:a17:903:2c8:b0:207:625:cf04 with SMTP id d9443c01a7336-208d8565119mr52721765ad.52.1726846661158;
        Fri, 20 Sep 2024 08:37:41 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da8a3sm95990985ad.56.2024.09.20.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:37:40 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
Date: Fri, 20 Sep 2024 23:37:06 +0800
Message-Id: <20240920153706.919154-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changed, like macro BPF_CALL_IMM, add BPF_CALL_FUNC/_FUNC_ARGS
to simplify code.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 2 +-
 arch/x86/net/bpf_jit_comp.c      | 2 +-
 arch/x86/net/bpf_jit_comp32.c    | 5 ++---
 include/linux/filter.h           | 4 ++++
 kernel/bpf/core.c                | 6 +++---
 5 files changed, 11 insertions(+), 8 deletions(-)

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
index 99b6fc83825b..d06526decc6d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -461,6 +461,10 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 
 #define BPF_CALL_IMM(x)	((void *)(x) - (void *)__bpf_call_base)
 
+#define BPF_CALL_FUNC(x)	((x) + (u8 *)__bpf_call_base)
+
+#define BPF_CALL_FUNC_ARGS(x)	((x) + (u8 *)__bpf_call_base_args)
+
 #define BPF_EMIT_CALL(FUNC)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP | BPF_CALL,			\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4e07cc057d6f..f965f0d586f3 100644
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
@@ -2007,12 +2007,12 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		 * preserves BPF_R6-BPF_R9, and stores return value
 		 * into BPF_R0.
 		 */
-		BPF_R0 = (__bpf_call_base + insn->imm)(BPF_R1, BPF_R2, BPF_R3,
+		BPF_R0 = BPF_CALL_FUNC(insn->imm)(BPF_R1, BPF_R2, BPF_R3,
 						       BPF_R4, BPF_R5);
 		CONT;
 
 	JMP_CALL_ARGS:
-		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
+		BPF_R0 = BPF_CALL_FUNC_ARGS(insn->imm)(BPF_R1, BPF_R2,
 							    BPF_R3, BPF_R4,
 							    BPF_R5,
 							    insn + insn->off + 1);
-- 
2.43.0


