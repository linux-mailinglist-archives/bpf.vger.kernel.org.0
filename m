Return-Path: <bpf+bounces-20952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE5845833
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225C1B25332
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78C53393;
	Thu,  1 Feb 2024 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6xkZxgU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2125336D;
	Thu,  1 Feb 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791974; cv=none; b=RdtKd2t8nljArBPJjUzxUi9oWCckiDDLNQen0txWdLfq8J5f6wY7+MPGmtQjghYfkK50wktzC35LCLFge7tZ0X8UiIPdA/hKj7cpafEWZxlG7xU2u0wdjCipmV70XPnPaOxm17OUXfi5mhmqX8xJwUFE5av/0072h14eGYb6WHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791974; c=relaxed/simple;
	bh=msWUzFbKQmtmN43G+1njdNg1iOyozh3YckpeFjSq7QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMpSD0UoVS65U8B1IiY/wg1TChoHK41C5ombdoPmSuxOjn7INFHY19xi3RTzN2M4CDMNMXlRKVp9sMz0FhAvCc4ft9f7kl0e/I/B/pYf/P9mG52P3XKS3O2r9tGLWcCpFS1Pj7HmK/k+gnkhOIBaXpUDm5B/w+h5ubl7XLwb/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6xkZxgU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e80046246so4765955e9.1;
        Thu, 01 Feb 2024 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706791970; x=1707396770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLwU1mAjRk6tVu2Bx5aUYeeeXQpRVOBvWkTmhqcFn0M=;
        b=G6xkZxgU0yoMBSx03DL9LwHSXpAoM1bjWRjTXNm3IA0p+tHWiWhvLvegVIJZfsW2OL
         Cd/23rm7oz5xIXwwxHtnkLLnNXr4tPqspxm+121jIlzczz4NZ+sOhNByt+XfUuxHzU8A
         sEJfSfNL0/nw1MyVA/GLl0i4kJY85pyeEqLgvtYF0bzHVRnQqBBGJbvVJqqJ1ZnEI1zB
         x6Ubd1oRqyhtuMsQwRbTYp0WGyI5qdg8B/FePfql66oTV9xs8DbL9hL1H72gFXupcvnn
         AsHLELl0WSsyXmy9ngQq4DUYQK6ziChqcYxLdit8YmB3asCaqo+TTEk0gvm7h+JJpm4H
         Uavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791970; x=1707396770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLwU1mAjRk6tVu2Bx5aUYeeeXQpRVOBvWkTmhqcFn0M=;
        b=Ox3TGnn59r78BxNgonR3poW9yXsL+8TIr1Ygs6qGH6HxO3mb6VtzHD98Iog30N8W+N
         10N0NlA83r5LtNsDM40XnvVXEOUsRIES24GFKPY/qw77RbNBYNrV/itrVpIA2tNAVU5V
         vtY3sTFnHQ8ATvgVNhp5VhtqfyYjGfmtE4DAQyq/x6pbRNMNvziS7rt3KY1WFpap/Qok
         KR9JY9TN4KdTj/c6Aq6sB0xlRBgclVvitA92ePyxrk8RPh1QYVTb0BUesXPo9d6DBc36
         tgocSMsLcXxibIIT0AF+RhsYlhMrCvBq5ebWWWL/5TYFOu3LTQzn2Ec5c6R4fuMnYR/i
         Sswg==
X-Gm-Message-State: AOJu0YyeMK1pngvh5mBmuU4M/TJl5cTtiQMToJHX03cqRqbLhaL46oKo
	qJ0FlrLX6NTpH5roZLtGC91PlZECIbPOWoG7GkWW9Pe8Wn+IufC2
X-Google-Smtp-Source: AGHT+IFGz6afCU/24Gt4i46Ecnb88g6ZlJ+iaxfz/q3qWmZcs6vTMg4kJ8EW+MqV8A34TQ9ij7WoSg==
X-Received: by 2002:a05:600c:3b28:b0:40f:b76e:e261 with SMTP id m40-20020a05600c3b2800b0040fb76ee261mr2619886wms.9.1706791970527;
        Thu, 01 Feb 2024 04:52:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXC1Lt6JUZ+hdm9QD3AOAZ1hsC5ynhzSr/lhQzOhIQijFN6d734bRAmjeMLNUrAVXYs1z5PP8kzglCZRLX3mKwuFhQ9qsVE6M7p1F28XM8kDJYlmk8+tsAoJkCh22zzSanTqWFSLlAl2lfGbUd2oQg9EOVeYHDNxQR8xpj6T3sMaShhmd9G03GV9eNPjhNUzEYWkf3ppm+ExzdWxGkfrynxNSP6gyOkzY4z1YUNa+JVwYGNIDpV6KwBEbRKDd23Y77ICCRk2DcYYbw75RUr7e35DeuO9HbZATYZ6QfshRClTPwY9+hwQbc0J2b3DQEvS64oDWDfwzmvWKinmHYQ0v+tWjvQisZU1hKHZ+Hvs5zSAfKCFtveFCOWe0QAs0uNlYpxek7qtYnLnDRlL5afyvz7VmycJwu/CF7xTdntTdUe4J5kphK0F45fq1+HEiJSj8E9hhOv6XV91GgpGwrtRXJD0oo2kDUwm8SeZiIWlrwNOeJRjPcFvX2PDP43h/eFzjoX0X4RNl70wWyqwnp/RRpp95w2dGNr9RBQph2ndBqEcKVvAA==
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b0040ee4f38968sm4425715wmq.2.2024.02.01.04.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:52:50 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 2/2] bpf, arm64: support exceptions
Date: Thu,  1 Feb 2024 12:52:25 +0000
Message-Id: <20240201125225.72796-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201125225.72796-1-puranjay12@gmail.com>
References: <20240201125225.72796-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prologue generation code has been modified to make the callback
program use the stack of the program marked as exception boundary where
callee-saved registers are already pushed.

As the bpf_throw function never returns, if it clobbers any callee-saved
registers, they would remain clobbered. So, the prologue of the
exception-boundary program is modified to push R23 and R24 as well,
which the callback will then recover in its epilogue.

The Procedure Call Standard for the Arm 64-bit Architecture[1] states
that registers r19 to r28 should be saved by the callee. BPF programs on
ARM64 already save all callee-saved registers except r23 and r24. This
patch adds an instruction in prologue of the  program to save these
two registers and another instruction in the epilogue to recover them.

These extra instructions are only added if bpf_throw() is used. Otherwise
the emitted prologue/epilogue remains unchanged.

[1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c                | 87 +++++++++++++++-----
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
 2 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cfd5434de483..20720ec346b8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -285,7 +285,8 @@ static bool is_lsi_offset(int offset, int scale)
 /* Tail call offset to jump into */
 #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
 
-static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
+static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
+			  bool is_exception_cb)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
@@ -333,19 +334,34 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
 	emit(A64_NOP, ctx);
 
-	/* Sign lr */
-	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
-		emit(A64_PACIASP, ctx);
-
-	/* Save FP and LR registers to stay align with ARM64 AAPCS */
-	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
-	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
-
-	/* Save callee-saved registers */
-	emit(A64_PUSH(r6, r7, A64_SP), ctx);
-	emit(A64_PUSH(r8, r9, A64_SP), ctx);
-	emit(A64_PUSH(fp, tcc, A64_SP), ctx);
-	emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
+	if (!is_exception_cb) {
+		/* Sign lr */
+		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
+			emit(A64_PACIASP, ctx);
+		/* Save FP and LR registers to stay align with ARM64 AAPCS */
+		emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
+		emit(A64_MOV(1, A64_FP, A64_SP), ctx);
+
+		/* Save callee-saved registers */
+		emit(A64_PUSH(r6, r7, A64_SP), ctx);
+		emit(A64_PUSH(r8, r9, A64_SP), ctx);
+		emit(A64_PUSH(fp, tcc, A64_SP), ctx);
+		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
+	} else {
+		/*
+		 * Exception callback receives FP of Main Program as third
+		 * parameter
+		 */
+		emit(A64_MOV(1, A64_FP, A64_R(2)), ctx);
+		/*
+		 * Main Program already pushed the frame record and the
+		 * callee-saved registers. The exception callback will not push
+		 * anything and re-use the main program's stack.
+		 *
+		 * 10 registers are on the stack
+		 */
+		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx);
+	}
 
 	/* Set up BPF prog stack base register */
 	emit(A64_MOV(1, fp, A64_SP), ctx);
@@ -365,6 +381,20 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 		emit_bti(A64_BTI_J, ctx);
 	}
 
+	/*
+	 * Program acting as exception boundary should save all ARM64
+	 * Callee-saved registers as the exception callback needs to recover
+	 * all ARM64 Callee-saved registers in its epilogue.
+	 */
+	if (prog->aux->exception_boundary) {
+		/*
+		 * As we are pushing two more registers, BPF_FP should be moved
+		 * 16 bytes
+		 */
+		emit(A64_SUB_I(1, fp, fp, 16), ctx);
+		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
+	}
+
 	emit(A64_SUB_I(1, fpb, fp, ctx->fpb_offset), ctx);
 
 	/* Stack must be multiples of 16B */
@@ -653,7 +683,7 @@ static void build_plt(struct jit_ctx *ctx)
 		plt->target = (u64)&dummy_tramp;
 }
 
-static void build_epilogue(struct jit_ctx *ctx)
+static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 {
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 r6 = bpf2a64[BPF_REG_6];
@@ -666,6 +696,15 @@ static void build_epilogue(struct jit_ctx *ctx)
 	/* We're done with BPF stack */
 	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
+	/*
+	 * Program acting as exception boundary pushes R23 and R24 in addition
+	 * to BPF callee-saved registers. Exception callback uses the boundary
+	 * program's stack frame, so recover these extra registers in the above
+	 * two cases.
+	 */
+	if (ctx->prog->aux->exception_boundary || is_exception_cb)
+		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
+
 	/* Restore x27 and x28 */
 	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
 	/* Restore fs (x25) and x26 */
@@ -1575,7 +1614,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic)) {
+	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1586,7 +1625,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, prog->aux->exception_cb);
 	build_plt(&ctx);
 
 	extable_align = __alignof__(struct exception_table_entry);
@@ -1614,7 +1653,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
-	build_prologue(&ctx, was_classic);
+	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
 
 	if (build_body(&ctx, extra_pass)) {
 		bpf_jit_binary_free(header);
@@ -1622,7 +1661,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, prog->aux->exception_cb);
 	build_plt(&ctx);
 
 	/* 3. Extra pass to validate JITed code. */
@@ -2310,3 +2349,13 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_exceptions(void)
+{
+	/* We unwind through both kernel frames starting from within bpf_throw
+	 * call and BPF frames. Therefore we require FP unwinder to be enabled
+	 * to walk kernel frames and reach BPF frames in the stack trace.
+	 * ARM64 kernel is aways compiled with CONFIG_FRAME_POINTER=y
+	 */
+	return true;
+}
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 5c2cc7e8c5d0..0445ac38bc07 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,6 +1,5 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
-exceptions					 # JIT does not support calling kfunc bpf_throw: -524
 fexit_sleep                                      # The test never returns. The remaining tests cannot start.
 kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
 kprobe_multi_test                                # needs CONFIG_FPROBE
-- 
2.40.1


