Return-Path: <bpf+bounces-74690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 202CCC6247D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27F4D4E90F2
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 03:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D471A9FB5;
	Mon, 17 Nov 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL1u8HAd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FAA2E9EAA
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351379; cv=none; b=HlAYShSZY85qrjanbbgKO0jsVskYMCG82CclnkiPK6l6S6tfk8C39KA9EJZG9fhr+09gSa6csgdaId/7PhzeZzTQO8oNJY/XYiKE31TZ31BPStJiSkK9rtroUwkYY0n34Z8rYhyCPqudiAdkGlZfJftoeEWp2qZzK2xbvRzmaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351379; c=relaxed/simple;
	bh=6lH5TThLt0iLUPf10EryfpP2LJ24tamdXbqQbNSY8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6pA9Qd4fBzwiDz1pobxXx04cm0aKHUm8vDIhj5i5Bh6n+AjID5s3E6ggoiZueMFJk272CbzyayCHGcAlcorHyqo+bQS1UrzQnNTVz5+MAG3RwVa1ZkCgo23fVaZQ2ZVwngoZqfC3c3rSrMBM8exgHYyz/XlozTwyQwZHd311gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL1u8HAd; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3310988b3a.3
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351377; x=1763956177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og8VZW3HRIC9jFqJjaOXGmdza1e4WZ/zf5HErz8QF0g=;
        b=YL1u8HAdC+EmxxgcbAAHN6iUsh9SGoW76xQlpOkKwIsqAUNPfItWv6s1PeOJ2O4oFz
         bScm7+NOOcCeYGuF2fNbZaiuBLRzzdgVf4USojVjkXV7ARaauZtHOJuqS1lQvRinEDUN
         dl9OC7jg31HRBUP6PQ5+cYCCm919t90umGCpXqGKLw76bE4yWZGuXnFuEEsHtDIMecra
         E3xgGq2iu20aWcXDtO53FeCfyCvVcD7IxNoc8J2G3IWod9+tj0PGNi1EfIO7BEs7y2OL
         Wgfvp3Zq5Hj+NPvdpEABOEnUahotq0Fd9xs1R0AnbnIFwfY6bH67NsEEPU/EF6vXxKwm
         /zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351377; x=1763956177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Og8VZW3HRIC9jFqJjaOXGmdza1e4WZ/zf5HErz8QF0g=;
        b=QkAMSX0iHhPcyZDKMKk6PxbQP2CtCimc45c2NoKVogVJYxPRpOGsCqTtZzWBtNJgaY
         5izeBdtakI97Bzar8Z5CepJBfNqRqxgyUTxpreegsKNoeGQNdwCC4QkO1dg9msfp9oVz
         Ppt0pKuM+Ign/WGa5lxVPyRg6x2w6V3FvLqOQqfDaekl9OZT8VbcOCZq2zx0Lqnle1zM
         s9spQPEgqdvytKgTOFif45swdcCX7PnfapGhLLdd2D1OnRYp+nZuLdPTNcCgq8vwxc8f
         ZCsUG4fckhyEV2AEnyErB/DjM64k1XKsmhEC8zSoaNcXEupgIUyumizkKMUx1oNZKM7e
         9woA==
X-Forwarded-Encrypted: i=1; AJvYcCUoFZ10T+wzY8q/26U66a1IQK8OelIKqImbAQe2RRJKxRLjgXB8vR907Zi/RfsdfY8j33Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJH90BqW97JKU2GCTzCEwpkPMPS+SKRTUn9lYe0xxlKNu2yQY
	0eA/TjyPuOJV2lkkR4WvoGD4x91MYO75718xpVwtJc7GGATraSxg7i2y
X-Gm-Gg: ASbGncv/hYidKZ41t7f/M8v8PGFYmQ8zgU1ph+2Qa94lL1sLMiVQrxI/+Qf+vZvKHbH
	bVqZIVVDWiNWhgK+KVQ6qfvdo8PjwlfPW6SfQ64yxNVgPSWszL0e9h1rIu1vzzT17Fwd9YRUIX6
	7beptb6RzjnLNBsexjIFxAVXOMSd4yvIuypBP4H2mDl+zkPad2JOD62Fd41OrvjPVGXc+YEMRFK
	R6I2UcGE645TYwD+HbmOg+GqoY4al+crQ79J2WaEzPq8+uTHJAgJ7EKlVJ7TNP0uAnYGv05LTpA
	fIkasboelAu18jTsKrTeah1rMiuPiHFjBWAhiyqELXdiDIF5gBppEBmzQHCDuouQuaU90rkIBif
	aCkxjj7AL2JGnsE9C1L2Dilr8i5Sb6O67pNURf6D3/2J3XjaLsqIbuZB3nLRYJZLHiu5Fx0hgNb
	msJCkzz2SPyn8=
X-Google-Smtp-Source: AGHT+IEUOmv/ReRY/yBeh3xXoJkne3X/8LUXnfbP2zr6UY7lHFdyFxyv4QbxObXeKQfZgd/S48fgrQ==
X-Received: by 2002:a05:6a20:7349:b0:35d:58d3:2904 with SMTP id adf61e73a8af0-35d58d33edcmr7364200637.31.1763351376830;
        Sun, 16 Nov 2025 19:49:36 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:36 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/6] bpf,x86: adjust the "jmp" mode for bpf trampoline
Date: Mon, 17 Nov 2025 11:49:04 +0800
Message-ID: <20251117034906.32036-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
that the trampoline is not called, but "jmp".

Introduce the function bpf_trampoline_use_jmp() to check if the trampoline
is in "jmp" mode.

Do some adjustment on the "jmp" mode for the x86_64. The main adjustment
that we make is for the stack parameter passing case, as the stack
alignment logic changes in the "jmp" mode without the "rip". What's more,
the location of the parameters on the stack also changes.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- rename bpf_trampoline_need_jmp() to bpf_trampoline_use_jmp()
---
 arch/x86/net/bpf_jit_comp.c | 16 +++++++++++-----
 include/linux/bpf.h         | 12 ++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 808d4343f6cf..632a83381c2d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2847,9 +2847,10 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 }
 
 static void save_args(const struct btf_func_model *m, u8 **prog,
-		      int stack_size, bool for_call_origin)
+		      int stack_size, bool for_call_origin, u32 flags)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
+	bool use_jmp = bpf_trampoline_use_jmp(flags);
 	int i, j;
 
 	/* Store function arguments to stack.
@@ -2890,7 +2891,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			 */
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
-					 nr_stack_slots * 8 + 0x18);
+					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3284,7 +3285,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * should be 16-byte aligned. Following code depend on
 		 * that stack_size is already 8-byte aligned.
 		 */
-		stack_size += (stack_size % 16) ? 0 : 8;
+		if (bpf_trampoline_use_jmp(flags)) {
+			/* no rip in the "jmp" case */
+			stack_size += (stack_size % 16) ? 8 : 0;
+		} else {
+			stack_size += (stack_size % 16) ? 0 : 8;
+		}
 	}
 
 	arg_stack_off = stack_size;
@@ -3344,7 +3350,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
 
-	save_args(m, &prog, regs_off, false);
+	save_args(m, &prog, regs_off, false, flags);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3377,7 +3383,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true);
+		save_args(m, &prog, arg_stack_off, true, flags);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09d5dc541d1c..4187b7578580 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1264,6 +1264,18 @@ typedef void (*bpf_trampoline_exit_t)(struct bpf_prog *prog, u64 start,
 bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog);
 bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+static inline bool bpf_trampoline_use_jmp(u64 flags)
+{
+	return flags & BPF_TRAMP_F_CALL_ORIG && !(flags & BPF_TRAMP_F_SKIP_FRAME);
+}
+#else
+static inline bool bpf_trampoline_use_jmp(u64 flags)
+{
+	return false;
+}
+#endif
+
 struct bpf_ksym {
 	unsigned long		 start;
 	unsigned long		 end;
-- 
2.51.2


