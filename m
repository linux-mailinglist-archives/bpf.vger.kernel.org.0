Return-Path: <bpf+bounces-72208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425FC0A202
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A04EB405
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE98243367;
	Sun, 26 Oct 2025 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj9iIq5Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433C23EA90
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447736; cv=none; b=cksF8ALAEoJjPL6Nilthd6kU8cvJOWuK3li6XmBJbJXm70myrpy6kp/e3H+A/ErbYd/pJm4WMG/lkjpvve2qPYCwemeGaNUoo6eq1IKePM/yHCLODJQZIhzlXmeevKxqR/pE7acjaiZASn1y2yEs3VcNlacneUbsVABqmyftlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447736; c=relaxed/simple;
	bh=9WMnOBXpLJRUbH41wsToxqgSiyUE4tpopflMkrmjCnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzJMktcIGajjbeEUL1dfWsvvZ1HmLGLDI8nNWgVF1MT7UV+DuqdMyYhv/CTS8w5A4LHOUBAK3qxmhZ4kRyoT7PvWQrKrg2YM7ExdUT5WGYuT52ny+BN9K8q2OsYTvyEcuFP2cubAmh2LpL/JS+gPujpcm2Q6092m/bE4vRAplGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj9iIq5Y; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29292eca5dbso46182875ad.0
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447734; x=1762052534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYixTqYDGvNEVEGtkOphOlsWEmlpVEfnMBchHwjcsb8=;
        b=Rj9iIq5YKGQ+wcTV8RGE7PxqEkEFQWgu4/hO3iqzFm98XP05JDDS4BXnjf45/3ICDL
         UPYoAnx8otvVKrMQguB10qBB8yDS9uSmNuT2oki8xxbmgZmelcoGT1nBG/ljMJtbQGih
         bc4c2LoTyHUJtdlYhXtMf9uaKpCn3E18yUG8y+ZjGAafEvp/ArL7ga1hlVCZ6yVVoqbD
         99LmZGh3BLeLzLl5iBQzueNhoCGZippSt4GmgBUCWxuGtRq3X7jKPXVqqE3eLJFAJs97
         yTgsB9pl/1OsGg9NZaHbyedFhczm6IaeJA2Ex28VAIFDO52kRjvc3mv6pdU2gvL7ftRW
         9rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447734; x=1762052534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYixTqYDGvNEVEGtkOphOlsWEmlpVEfnMBchHwjcsb8=;
        b=KfIFTVvX+h8icuMrQPXG+wChCnFy0ij8by8pqjImWej8L8kYXmWFgJLKbrRK0eJH7f
         w8WekWW9Z+2ovd3kLsIsxN+zTQWLX2fzas4MAcsF6j2U8t5DUSibN2HKvjL2ktmE4Gb+
         L9hv17te73JwqmNEN4d4JElCXXdmexoxiYsd/csOxw9Gh2vyHMzWyyUq+gfNnqI1rLOX
         33/ompRwezt42la5iu6DHrhchmpLdcC+QYLafI9BW6SqP33L8jqTuFJjS/Qe4RjyR/Sz
         A50bDcSSxjMjaJaYxZ6X5fCjGD7TXLq2taq3bchVHzux9SYs8pVtSiVQJDPe6YX2blhB
         LdOA==
X-Forwarded-Encrypted: i=1; AJvYcCULMmPN7kfhqvekC8u1712IBw3Qj+urPSa8vFNR0tGCc5MNHTtywXeurxLJwDpYKZ7wHd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsfzxhq3uiEiELLdRMP3LBumj1ny3Vlt8Q74F86n19voRPRJi
	TfEdU+a+XsWdbAyLXGGRClIT6q9w1/t8CaKeAGR/cGfVphgIG5dNWY2g
X-Gm-Gg: ASbGncuHBD7f4GX69p0FYGfkLUhJS4wglj8VgrEU51YtCBt/migqH/NQ+bT/KTv2oNm
	/tuMAw2R/T8A3FU15CCqWafneejvMkNHs0+Z8YFC2WQaS1O7dpDigd7mJ/KRm/fP5csfKtD9V9v
	7EHrWRVxOBYY/vvlH+hdS7PA4kuQQ2LDA8ybht9pgi7S88fUHkYlshxdKMLgb4Y1PwurEjdMgeV
	wNDKeeBidn5G41M0fFNebB0KVKMOnhwljG23aXqSz5tv8V/z4u2Wr8gd9GEQV6oHmiQcdDfMCQP
	Snt8ljNe1ILtTm2rF213vZZpmxzqCmroqjTUnJVbG/47Qa2rO6oo96hZewzguZgKAH0KgUjHp8S
	WVtfeRhqRUHkzmGolabBgnWe04LMz7Ys3PHvNsyYIxbfKD5SFD/NDcdXn9gL8fy7Z36E7tTRyLF
	AOgYfzKOhM1P1QSfkHdZUHiw==
X-Google-Smtp-Source: AGHT+IGn+lOrWPi9jnO8+VAyeqm62nJfG2lqyJ3NO9cm7pAXySURrwOZRT5Ja1F1QUdbn2Rx7CJ03A==
X-Received: by 2002:a17:902:ecc8:b0:290:c516:8c53 with SMTP id d9443c01a7336-290caf831d8mr413807945ad.40.1761447733650;
        Sat, 25 Oct 2025 20:02:13 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:13 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting for x86_64
Date: Sun, 26 Oct 2025 11:01:40 +0800
Message-ID: <20251026030143.23807-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026030143.23807-1-dongml2@chinatelecom.cn>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry and
invoke_bpf_session_exit is introduced for this purpose.

In invoke_bpf_session_entry(), we will check if the return value of the
fentry is 0, and set the corresponding session flag if not. And in
invoke_bpf_session_exit(), we will check if the corresponding flag is
set. If set, the fexit will be skipped.

As designed, the session flags and session cookie address is stored after
the return value, and the stack look like this:

  cookie ptr	-> 8 bytes
  session flags	-> 8 bytes
  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ...
  cookieN	-> 8 bytes
  cookie1	-> 8 bytes

In the entry of the session, we will clear the return value, so the fentry
will always get 0 with ctx[nr_args] or bpf_get_func_ret().

Before the execution of the BPF prog, the "cookie ptr" will be filled with
the corresponding cookie address, which is done in
invoke_bpf_session_entry() and invoke_bpf_session_exit().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v2:
- add session cookie support
- add the session stuff after return value, instead of before nr_args
---
 arch/x86/net/bpf_jit_comp.c | 185 +++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7a604ee9713f..2fffc530c88c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3109,6 +3109,148 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+static int invoke_bpf_session_entry(const struct btf_func_model *m, u8 **pprog,
+				    struct bpf_tramp_links *tl, int stack_size,
+				    int run_ctx_off, int ret_off, int sflags_off,
+				    int cookies_off, void *image, void *rw_image)
+{
+	int i, j = 0, cur_cookie_off;
+	u64 session_flags;
+	u8 *prog = *pprog;
+	u8 *jmp_insn;
+
+	/* clear the session flags:
+	 *   xor rax, rax
+	 *   mov QWORD PTR [rbp - sflags_off], rax
+	 */
+	EMIT3(0x48, 0x31, 0xC0);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -sflags_off);
+	/*
+	 * clear the return value to make sure bpf_get_func_ret() always
+	 * get 0 in fentry:
+	 *   mov QWORD PTR [rbp - 0x8], rax
+	 */
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
+	/* clear all the cookies in the cookie array */
+	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			cur_cookie_off = -cookies_off + j * 8;
+			/* mov QWORD PTR [rbp - sflags_off], rax */
+			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
+				 cur_cookie_off);
+			j++;
+		}
+	}
+
+	j = 0;
+	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			cur_cookie_off = -cookies_off + j * 8;
+			/*
+			 * save the cookie address to rbp - sflags_off + 8:
+			 *   lea rax, [rbp - cur_cookie_off]
+			 *   mov QWORD PTR [rbp - sflags_off + 8], rax
+			 */
+			if (!is_imm8(cur_cookie_off))
+				EMIT3_off32(0x48, 0x8D, 0x85, cur_cookie_off);
+			else
+				EMIT4(0x48, 0x8D, 0x45, cur_cookie_off);
+			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -sflags_off + 8);
+			j++;
+		}
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
+				    ret_off, image, rw_image))
+			return -EINVAL;
+
+		/* fentry prog stored return value into [rbp - 8]. Emit:
+		 * if (*(u64 *)(rbp - ret_off) !=  0) {
+		 *	*(u64 *)(rbp - sflags_off) |= (1 << (i + 1));
+		 *	*(u64 *)(rbp - ret_off) = 0;
+		 * }
+		 */
+		/* cmp QWORD PTR [rbp - ret_off], 0x0 */
+		EMIT4(0x48, 0x83, 0x7d, -ret_off); EMIT1(0x00);
+		/* emit 2 nops that will be replaced with JE insn */
+		jmp_insn = prog;
+		emit_nops(&prog, 2);
+
+		session_flags = (1ULL << (i + 1));
+		/* mov rax, $session_flags */
+		emit_mov_imm64(&prog, BPF_REG_0, session_flags >> 32, (u32) session_flags);
+		/* or QWORD PTR [rbp - sflags_off], rax */
+		EMIT2(0x48, 0x09);
+		emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -sflags_off);
+
+		/* mov QWORD PTR [rbp - ret_off], 0x0 */
+		EMIT4(0x48, 0xC7, 0x45, -ret_off); EMIT4(0x00, 0x00, 0x00, 0x00);
+
+		jmp_insn[0] = X86_JE;
+		jmp_insn[1] = prog - jmp_insn - 2;
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
+static int invoke_bpf_session_exit(const struct btf_func_model *m, u8 **pprog,
+				   struct bpf_tramp_links *tl, int stack_size,
+				   int run_ctx_off, int ret_off, int sflags_off,
+				   int cookies_off, void *image, void *rw_image)
+{
+	int i, j = 0, cur_cookie_off;
+	u64 session_flags;
+	u8 *prog = *pprog;
+	u8 *jmp_insn;
+
+	/*
+	 * set the bpf_trace_is_exit flag to the session flags:
+	 *   mov rax, 1
+	 *   or QWORD PTR [rbp - sflags_off], rax
+	 */
+	emit_mov_imm32(&prog, false, BPF_REG_0, 1);
+	EMIT2(0x48, 0x09);
+	emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -sflags_off);
+
+	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			cur_cookie_off = -cookies_off + j * 8;
+			/*
+			 * save the cookie address to rbp - sflags_off + 8:
+			 *   lea rax, [rbp - cur_cookie_off]
+			 *   mov QWORD PTR [rbp - sflags_off + 8], rax
+			 */
+			if (!is_imm8(cur_cookie_off))
+				EMIT3_off32(0x48, 0x8D, 0x85, cur_cookie_off);
+			else
+				EMIT4(0x48, 0x8D, 0x45, cur_cookie_off);
+			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -sflags_off + 8);
+			j++;
+		}
+		/* check if (1 << (i+1)) is set in the session flags, and
+		 * skip the execution of the fexit program if it is.
+		 */
+		session_flags = 1ULL << (i + 1);
+		/* mov rax, $session_flags */
+		emit_mov_imm64(&prog, BPF_REG_0, session_flags >> 32, (u32) session_flags);
+		/* test QWORD PTR [rbp - sflags_off], rax */
+		EMIT2(0x48, 0x85);
+		emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -sflags_off);
+		/* emit 2 nops that will be replaced with JE insn */
+		jmp_insn = prog;
+		emit_nops(&prog, 2);
+
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, false,
+				    ret_off, image, rw_image))
+			return -EINVAL;
+
+		jmp_insn[0] = X86_JNE;
+		jmp_insn[1] = prog - jmp_insn - 2;
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
 	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
@@ -3181,8 +3323,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
 	int ret_off, regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off,
-	    rbx_off;
+	    rbx_off, sflags_off = 0, cookies_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_links *session = &tlinks[BPF_TRAMP_SESSION];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
@@ -3215,6 +3358,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 * RBP + 8         [ return address  ]
 	 * RBP + 0         [ RBP             ]
 	 *
+	 *                  [ cookie ptr ] tracing session
+	 * RBP - sflags_off [ session flags ] tracing session
+	 *
 	 * RBP - ret_off   [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
 	 *                                      BPF_TRAMP_F_RET_FENTRY_RET flags
 	 *
@@ -3230,6 +3376,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *
 	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
 	 *
+	 *                   [ session cookieN ]
+	 *                   [ ... ]
+	 * RBP - cookies_off [ session cookie1 ] tracing session
+	 *
 	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
@@ -3237,6 +3387,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
+	/* room for session flags and cookie ptr */
+	if (session->nr_links) {
+		stack_size += 8 + 8;
+		sflags_off = stack_size;
+	}
+
 	/* room for return value of orig_call or fentry prog */
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret)
@@ -3261,6 +3417,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off = stack_size;
 
+	if (session->nr_links) {
+		for (i = 0; i < session->nr_links; i++) {
+			if (session->links[i]->link.prog->call_session_cookie)
+				stack_size += 8;
+		}
+	}
+	cookies_off = stack_size;
+
 	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
 		/* the space that used to pass arguments on-stack */
 		stack_size += (nr_regs - get_nr_used_regs(m)) * 8;
@@ -3349,6 +3513,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			return -EINVAL;
 	}
 
+	if (session->nr_links) {
+		if (invoke_bpf_session_entry(m, &prog, session, regs_off,
+					     run_ctx_off, ret_off, sflags_off,
+					     cookies_off, image, rw_image))
+			return -EINVAL;
+	}
+
 	if (fmod_ret->nr_links) {
 		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
 				   GFP_KERNEL);
@@ -3414,6 +3585,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (session->nr_links) {
+		if (invoke_bpf_session_exit(m, &prog, session, regs_off,
+					    run_ctx_off, ret_off, sflags_off,
+					    cookies_off, image, rw_image)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, regs_off);
 
@@ -3483,9 +3663,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	int ret;
 	u32 size = image_end - image;
 
-	if (tlinks[BPF_TRAMP_SESSION].nr_links)
-		return -EOPNOTSUPP;
-
 	/* rw_image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
 	 */
-- 
2.51.1


