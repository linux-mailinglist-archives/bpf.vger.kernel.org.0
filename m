Return-Path: <bpf+bounces-71688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D1BFAC39
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F1918848B2
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185030148B;
	Wed, 22 Oct 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBHp6OZf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA692302175
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120160; cv=none; b=kiQ+aLFHJ/T+buhDD5zmj6ZenX6wXDzwP5gQiLnivlSVVgSSP7LU7K0pihe+oUkj/t2tsk+1qTmLSZea6SXIPeYYgesA5pFVqD2BxxSmJiDX8ri4IN2yoiILY3OWeyBf3FhOPRX/q+1dfx7KgB9YfDfB9GcvHE/9tO8mOP5s6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120160; c=relaxed/simple;
	bh=bqfVbja0VNnOyuSYJF8PhCHlRdzOy0u/yn5ln/BCKWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l87f/+6ci9tVgJsl9PdCKK10j0qEroEFg+jXdB7pEFCbcMVCBuwQKgzlIUsFnO9Bk8xo+D+mqgISYSNSAZWfqmM7/9ATqcsh0FPbo1Bf51RRK0Yi+hFUEjYZPGnr4iLq0h5cDpg0F2rg29rrgAyOprtNGBQqr+jW9nA2lGI/nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBHp6OZf; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-290dc63fabbso50945225ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120157; x=1761724957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrXOn6lIq+tpNpQh9rHuEsq8vsYm+5ta2KXHbspyhgI=;
        b=TBHp6OZfTKy3UdDtKk0nO+6xAhN/3Ryqw8bCo25Se7Uce8F3/oSR84QnBnYJ740Wv5
         yFAoT02kpU2FQ4O66DdaVkU0sCfjYf8dIixIXoOn6jaTG2hesTd72EyKyxcdlkv7P1nU
         bGdxOCgbRDlhhsJ1GMOfTLDN5ThZw4G2PDbTLfvQ+h5gM53Q1j/rgNNQJLjFlH5xWltf
         Cg+AwkZLa3S63lvX5QtYBHomJTAEwygjFYmo9ezGxhvhRaiEX0D7LbOi5PTUp3rMFgPg
         kzEEDrcxtftPayf9wib2bYo5qmac1E3xCWfhSdJp3ss+gs3BB7qgjfQ5t7YYur+wPlMq
         Cdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120157; x=1761724957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrXOn6lIq+tpNpQh9rHuEsq8vsYm+5ta2KXHbspyhgI=;
        b=wtzfRhZHBvALgLV6Hv/AVtGuN7OcUifTCCaX5Q+a4R+1JQYuX34SifEou1WnSV5vtc
         45e2+r8R9vytIWh69YdP2dtEwc9XURq9pVnxDYGWm5pHEAaxafqaMdnqyh4rSVjinzo/
         /KILZxB8D8EON3ztyhzgNpIZ9bh0t6Ga2aEKRP5Vph3kckr/NpCunQFLIJ/MS0JNm62y
         MIQusTVkYYypXekxKqM3lzaw55OqgnXZT2NcGz5MOMfu/D+cnVlv1k2hqRYWzDitVEny
         2kIpHXyoltm8q75VbD9JemIUe9OdTRqksaUEUVUGbyBtIfrM/2I2+W3JCAYQsx+LIXac
         pOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzzPDPEE2IeYfInWNz3o5qE20hCjZtjChjebZ9QV8ZRtVm0A3ZQSaRr6SLDnzeSOZ0U/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWOhE6kkxSDCzdJO+yU9YXd9W0uiW9fNKijFvlSQRE2jMxOXH
	b6GtnqWPXqa3BSdT+DfmE5dyEMb7q9gAkl9uCNkSI4awA0pmg00UCtGi
X-Gm-Gg: ASbGncsAjI+C+wukTK7Am9Tr22mxg40WfHvAMOLBRpCwNO49RQpkmdXDg98Y63wvur/
	qpLCYR1509vcUvlqOyPI3Men4/r/ufWUpFGBso5BlrmZSizbB/kNw6McUHyHOSkBPlWzHKoo7VT
	VPoF5/as8YuBtGwCJ1/QyZvQPZL1MLtzSgimovt/zI5DLfYDdpl62fqD24f1GOWdDKb5OfcCuFU
	uSTTGPz/7J3g+XcEg0LwL4eGzE2ETkkswSjI2rLRo3yDy5xepGiG+bjwOEcUUHiT3xWfeXEa+xP
	eTFoMLCoIUQtYtiIVhL3rrViDgqgynD8HdGTM6QufssvlBQtydyh/W6YUu5WGHB8C+biI4YFext
	mvCuAC6o41klecQBzFGPXFv4Cklz/emF7qJessdrxPGrJXJGQfKxSRaK1wkeIu83TOZHOG95rB4
	h8MNd7KG4=
X-Google-Smtp-Source: AGHT+IFzpfjVMAlQCHKDsKDEYiShXChsSjSWT2s+eZeyRkcyRqv6V5BMOsRGohtVS0jRyo6zkamilw==
X-Received: by 2002:a17:902:e5cf:b0:290:9576:d6ef with SMTP id d9443c01a7336-290cba423b1mr276093185ad.54.1761120156885;
        Wed, 22 Oct 2025 01:02:36 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:36 -0700 (PDT)
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
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 05/10] bpf,x86: add tracing session supporting for x86_64
Date: Wed, 22 Oct 2025 16:01:54 +0800
Message-ID: <20251022080159.553805-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
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
2.51.1.dirty


