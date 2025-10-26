Return-Path: <bpf+bounces-72207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A60C0A20B
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FE03B23B1
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 03:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33251264F9C;
	Sun, 26 Oct 2025 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddii9cIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BE245012
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447731; cv=none; b=TWka2wDLcNyVEmBiSXMz4L8LU0M6iuAebcvzKDuiiF1Ee+onGwNVzZwJzvfKXep1NmDWbUxLeW15OsPGjQYBFynKxSALLaRn1029+dMoGA+NvUGng/hdq1vyoMOtnMmrs+98pT2lJIYDeqHDUMPiUdHvpmzQjA/O8XwfzuIs0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447731; c=relaxed/simple;
	bh=9b4O7RsmNlvQ7AzTjosqE9BdcokjGohATbeUFSkIzxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPpicrb6cqEhktWpqOj3LQRaPlpW+U3S4K4WBQjNmSNIe8Ql5mjhlNzpGS+mvczLltUVYBuJUmgmWeu9JabqMGxscnYPHwp/ltUI2Lb/rmkLYsExNHdrddYNWIRXQgl5b4kNgVdsBvlC87OXit7X6DY4jxddDZi5Pmz5+Xgzu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddii9cIp; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso3273333b3a.0
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447728; x=1762052528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWOtrv5GaHaiqIKPPW9jwT/KAew9UNx9hp0UFn6ftzQ=;
        b=ddii9cIpN2wCJ01aTrb0bMaPMDnfpLTOebBCzbLqybjW7JW4nQo2kCAVWlOB6R7VA/
         w9qykQIOTerZ4l5Qv4I+8Q83gF1C6wW0YpWx7r+gASiK5nZodMLEz3Rez5jWDq8FErdU
         JhHh9Pe+iA7jGkn7VWoVK2AgHbNNrV9+t77wPCn22ZeZIOO1Eo6SVZsjXh9juq+XGwzt
         F1zV5Tu4jIwj+Hm5P/9XpQOizogCTqu6fNVhE1OqsigvI8NpVwk1GkLwNsCLgoGGv88V
         Etwnz1XR+hmxs62RmQ/DBHTM9b9gcFZIjzo3bPulhCp9HhCC9zLDWIlrFpAgzLyzM6NY
         kA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447728; x=1762052528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWOtrv5GaHaiqIKPPW9jwT/KAew9UNx9hp0UFn6ftzQ=;
        b=LKfdN98+dCUqLnglGz/Rm9LKRtaOpcISdQOpbVOPinAcV7NahMqPl//Zpu0TBaIZon
         xzY0tCIgR3MyURkuHMBIGtRzYIAGM0BVkkwH6TGfyFhWBuDstk6lGIErwyLmanSi6OoH
         68UsNuV4HNyRAODY1F4LAAbUyAI5FXBVJ0B3AjTFBgvFiLOatU1mlfxKzCV49+/jZ2AL
         X94SnbOmK3zFsPLhY2U7nH9OK0AsypWI0twqMS0s6+qjOG+jNteeOxIdtrg5LGd49FsZ
         5v3piadLZ8CE7AA1bndSK7yNJiarc3PlyeW3/IMThQAvszvLhZmWESvSNwBlBlQszJGS
         Zjig==
X-Forwarded-Encrypted: i=1; AJvYcCUJu3uLWFLTv7LwdSv+wauR4mpfcAatT52v04F6ej1OycSxoE2pk2KTVp4i8aQ93/HZmjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dro/p4qObRSOPxrNySA9OC+MwIKTL7RKmHiVG4ozLsxi2KDI
	d8d5P3a1e4GoJaN7hnrCsr3dibpufTW6fv/ojsEYBII2wqHF5SDK7Dzn
X-Gm-Gg: ASbGncsZchXxwnlWrTcDMV+LFVYu6RTx5h2iueIzJsjoEDsLq46P3bVP+RxRgYQojrS
	h0EO7C4+LLVu/hbxqPSwOtRVTcnFLT9SvBNSKidvv+NpQ3uvqqFsCVVyw3IdCFxUfw1MVEwSV98
	JgiPRlRqQWtTLGKNQIENTR8Qj9NkMbKnZ/IyOa9l0MLPtP3MlCbGbcy0a3YmUjfM97UKKv4W5qb
	lqPO+q4PM7hP1W6QoxBpkzSd/8z++1Kp9/c1qudF7h0z6YF7hwjwzMWOcpI5Uo/b9SJGK6xP0jo
	BfRplDG+A/F0OOdxcMowaNJjUbNzNpAAVGm4BJdaOfW2krHnIUmY/bDQV7ZdeQ2wrkgU3TCraxu
	18UM0m311C8q+jHrZSoG51DHlNpAcNywr5P+SKyB5JhfAN4A2R16mBkAoXI3X/+0uSi6ZeaP7jr
	du
X-Google-Smtp-Source: AGHT+IGQ+4VLwk5Iv+/D5dAxlk6gGGm5Qf5IpkHeKj11DFxP9amuqpca575LSiEGdLR7xHA60JPV+A==
X-Received: by 2002:a17:903:1252:b0:24b:270e:56cb with SMTP id d9443c01a7336-2948b9a660amr90938695ad.27.1761447728242;
        Sat, 25 Oct 2025 20:02:08 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] bpf,x86: add ret_off to invoke_bpf()
Date: Sun, 26 Oct 2025 11:01:39 +0800
Message-ID: <20251026030143.23807-4-dongml2@chinatelecom.cn>
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

For now, the offset of the return value in trampoline is fixed 8-bytes.
In this commit, we introduce the variable "ret_off" to represent the
offset of the return value. For now, the "ret_off" is just 8. And in the
following patch, we will make it something else to use the room after it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 41 +++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 389c3a96e2b8..7a604ee9713f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2940,7 +2940,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
-			   int run_ctx_off, bool save_ret,
+			   int run_ctx_off, bool save_ret, int ret_off,
 			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
@@ -3005,7 +3005,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	 * value of BPF_PROG_TYPE_STRUCT_OPS prog.
 	 */
 	if (save_ret)
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
 
 	/* replace 2 nops with JE insn, since jmp target is known */
 	jmp_insn[0] = X86_JE;
@@ -3055,7 +3055,7 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret,
+		      int run_ctx_off, bool save_ret, int ret_off,
 		      void *image, void *rw_image)
 {
 	int i;
@@ -3063,7 +3063,8 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 
 	for (i = 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
-				    run_ctx_off, save_ret, image, rw_image))
+				    run_ctx_off, save_ret, ret_off, image,
+				    rw_image))
 			return -EINVAL;
 	}
 	*pprog = prog;
@@ -3072,7 +3073,7 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 			      struct bpf_tramp_links *tl, int stack_size,
-			      int run_ctx_off, u8 **branches,
+			      int run_ctx_off, int ret_off, u8 **branches,
 			      void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
@@ -3082,18 +3083,18 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	 * Set this to 0 to avoid confusing the program.
 	 */
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
 	for (i = 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
-				    image, rw_image))
+				    ret_off, image, rw_image))
 			return -EINVAL;
 
-		/* mod_ret prog stored return value into [rbp - 8]. Emit:
-		 * if (*(u64 *)(rbp - 8) !=  0)
+		/* mod_ret prog stored return value into [rbp - ret_off]. Emit:
+		 * if (*(u64 *)(rbp - ret_off) !=  0)
 		 *	goto do_fexit;
 		 */
-		/* cmp QWORD PTR [rbp - 0x8], 0x0 */
-		EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);
+		/* cmp QWORD PTR [rbp - ret_off], 0x0 */
+		EMIT4(0x48, 0x83, 0x7d, -ret_off); EMIT1(0x00);
 
 		/* Save the location of the branch and Generate 6 nops
 		 * (4 bytes for an offset and 2 bytes for the jump) These nops
@@ -3179,7 +3180,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int ret_off, regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off,
+	    rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -3213,7 +3215,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 * RBP + 8         [ return address  ]
 	 * RBP + 0         [ RBP             ]
 	 *
-	 * RBP - 8         [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
+	 * RBP - ret_off   [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
 	 *                                      BPF_TRAMP_F_RET_FENTRY_RET flags
 	 *
 	 *                 [ reg_argN        ]  always
@@ -3239,6 +3241,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret)
 		stack_size += 8;
+	ret_off = stack_size;
 
 	stack_size += nr_regs * 8;
 	regs_off = stack_size;
@@ -3341,7 +3344,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, ret_off,
+			       image, rw_image))
 			return -EINVAL;
 	}
 
@@ -3352,7 +3356,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			return -ENOMEM;
 
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
-				       run_ctx_off, branches, image, rw_image)) {
+				       run_ctx_off, ret_off, branches,
+				       image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -3380,7 +3385,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			}
 		}
 		/* remember return value in a stack for bpf prog to access */
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
 		im->ip_after_call = image + (prog - (u8 *)rw_image);
 		emit_nops(&prog, X86_PATCH_SIZE);
 	}
@@ -3403,7 +3408,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+			       false, ret_off, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -3433,7 +3438,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
-		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
+		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -ret_off);
 
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
-- 
2.51.1


