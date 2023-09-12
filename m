Return-Path: <bpf+bounces-9844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9879DCCA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E32816AF
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559AC14001;
	Tue, 12 Sep 2023 23:39:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099B1171C
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:39:47 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECD10C7;
	Tue, 12 Sep 2023 16:39:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401da71b7faso72640685e9.2;
        Tue, 12 Sep 2023 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561985; x=1695166785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47JCxEpmOHt+IYOipln8oCcMernu6aqap9oOr/OndIk=;
        b=cLtN96yP5f2dm+s8gcoe5re2PjsqYioQUgkM+79GeJGX3ev4m3FVbggCeUDj+Be8Qp
         6LDt0SVqDerQjI9qxDjo70lbVjsixWNcOOLZ3JYXdX8lD1/JC7kC+WyuCE/NU/2b357U
         vlyzIfb5JkVixjFlplYwFbH2Zd584/a9VDMwJOVSLFL7hEGz9ga8d2KVOiTxqdNU1f/9
         E/FPc64MGbawOZban7ZjtkSWpUhvCFFgauDayRcYoYlr8dgcyFtDd4XYDfezoLssuxZ0
         7rDVdCBV2MPCj+p6s/O3+HFQADPIXTFovZxWhnfE2waZGT7L92dFRYbuGdd+7kqW7weA
         slWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561985; x=1695166785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47JCxEpmOHt+IYOipln8oCcMernu6aqap9oOr/OndIk=;
        b=IkZRdA8GHNtPiIR7anTeptPt7lQQWav6endSD7UojBPOCGKYy2YqM9eoQXq2dBaPoe
         GrSWGAym7QfZLkYMnN+mBevRrFIqvmvStFuN41C26dfxHzTeKETrXDU2DRsykwHeojPU
         FSyy4mFM/qVqadCfHnWLmNG7AP4Mta0RCjLfgDkDXQfCvJQA/IQ90DxgiGmXv8tY1eFa
         VJG2ZzWYBtT19A2mNM7/1FybIStJMzUkZendn/f20x4ejT7e3ja9rsQHGoArRka1fWmw
         TtaxNZouUTbjlHityLj0VNB7Lgk4jykJr+igQE2/Us+i5RdGJPXDixE1k60fCma47mEY
         38cA==
X-Gm-Message-State: AOJu0YyRQnEtacDGxC9J1JuKYZfNtpFPxZJjsWzmi5xj1642z8dtbZPJ
	8rgy6nSWCdcyYK8mqOYFwKY=
X-Google-Smtp-Source: AGHT+IHRssuIi+GYl35N/nSiHnhTfP17pBIx0ZaT1Hz5N/UmlKhS2IXCBz4R8WQEEwKtue+vpPeqBA==
X-Received: by 2002:a05:600c:24c:b0:401:b2c7:34a4 with SMTP id 12-20020a05600c024c00b00401b2c734a4mr725612wmj.11.1694561984572;
        Tue, 12 Sep 2023 16:39:44 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b00402fa98abe3sm296641wmr.46.2023.09.12.16.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:39:44 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/1] bpf, arm64: support exceptions
Date: Tue, 12 Sep 2023 23:39:42 +0000
Message-Id: <20230912233942.6734-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912233942.6734-1-puranjay12@gmail.com>
References: <20230912233942.6734-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
by bpf_throw() to unwind till the program marked as exception boundary and
run the callback with the stack of the main program.

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

These extra instructions are only added if bpf_throw() used. Otherwise
the emitted prologue/epilogue remains unchanged.

[1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 98 ++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7d4af64e3982..fcc55e558863 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -21,6 +21,7 @@
 #include <asm/insn.h>
 #include <asm/patching.h>
 #include <asm/set_memory.h>
+#include <asm/stacktrace.h>
 
 #include "bpf_jit.h"
 
@@ -285,7 +286,7 @@ static bool is_lsi_offset(int offset, int scale)
 /* Tail call offset to jump into */
 #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
 
-static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
+static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf, bool is_exception_cb)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
@@ -333,19 +334,28 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
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
+		/* Exception callback receives FP of Main Program as third parameter */
+		emit(A64_MOV(1, A64_FP, A64_R(2)), ctx);
+		/*
+		 * Main Program already pushed the frame record and the callee-saved registers. The
+		 * exception callback will not push anything and re-use the main program's stack.
+		 */
+		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx); /* 10 registers are on the stack */
+	}
 
 	/* Set up BPF prog stack base register */
 	emit(A64_MOV(1, fp, A64_SP), ctx);
@@ -365,6 +375,13 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 		emit_bti(A64_BTI_J, ctx);
 	}
 
+	/*
+	 * Program acting as exception boundary should save all ARM64 Callee-saved registers as the
+	 * exception callback needs to recover all ARM64 Callee-saved registers in its epilogue.
+	 */
+	if (prog->aux->exception_boundary)
+		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
+
 	emit(A64_SUB_I(1, fpb, fp, ctx->fpb_offset), ctx);
 
 	/* Stack must be multiples of 16B */
@@ -653,7 +670,7 @@ static void build_plt(struct jit_ctx *ctx)
 		plt->target = (u64)&dummy_tramp;
 }
 
-static void build_epilogue(struct jit_ctx *ctx)
+static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 {
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 r6 = bpf2a64[BPF_REG_6];
@@ -666,6 +683,14 @@ static void build_epilogue(struct jit_ctx *ctx)
 	/* We're done with BPF stack */
 	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
+	/*
+	 * Program acting as exception boundary pushes R23 and R24 in addition to BPF callee-saved
+	 * registers. Exception callback uses the boundary program's stack frame, so recover these
+	 * extra registers in the above two cases.
+	 */
+	if (ctx->prog->aux->exception_boundary || is_exception_cb)
+		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
+
 	/* Restore x27 and x28 */
 	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
 	/* Restore fs (x25) and x26 */
@@ -1575,7 +1600,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic)) {
+	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1586,7 +1611,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, prog->aux->exception_cb);
 	build_plt(&ctx);
 
 	extable_align = __alignof__(struct exception_table_entry);
@@ -1614,7 +1639,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
-	build_prologue(&ctx, was_classic);
+	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
 
 	if (build_body(&ctx, extra_pass)) {
 		bpf_jit_binary_free(header);
@@ -1622,7 +1647,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, prog->aux->exception_cb);
 	build_plt(&ctx);
 
 	/* 3. Extra pass to validate JITed code. */
@@ -2286,3 +2311,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
 	return ret;
 }
+
+bool bpf_jit_supports_exceptions(void)
+{
+	/* We unwind through both kernel frames (starting from within bpf_throw call) and
+	 * BPF frames. Therefore we require FP unwinder to be enabled to walk kernel frames and
+	 * reach BPF frames in the stack trace.
+	 * ARM64 kernel is aways compiled with CONFIG_FRAME_POINTER=y
+	 */
+	return true;
+}
+
+void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
+{
+	struct stack_info stacks[] = {
+		stackinfo_get_task(current),
+	};
+
+	struct unwind_state state = {
+		.stacks = stacks,
+		.nr_stacks = ARRAY_SIZE(stacks),
+	};
+	unwind_init_common(&state, current);
+	state.fp = (unsigned long)__builtin_frame_address(1);
+	state.pc = (unsigned long)__builtin_return_address(0);
+
+	if (unwind_next_frame_record(&state))
+		return;
+	while (1) {
+		/* We only use the fp in the exception callback. Pass 0 for sp as it's unavailable*/
+		if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.fp))
+			break;
+		if (unwind_next_frame_record(&state))
+			break;
+	}
+}
-- 
2.40.1


