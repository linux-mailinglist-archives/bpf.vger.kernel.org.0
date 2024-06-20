Return-Path: <bpf+bounces-32630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2B9111D1
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161DD1C217EB
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0E1B47AF;
	Thu, 20 Jun 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSk2QqIL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8F24B26;
	Thu, 20 Jun 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910582; cv=none; b=p2gQjokz9OuLHVSlOMk0g7iai0G38Zk+xgZ5q5mGATXxbqAnONrG39b1pesSs+XtG/XlbOVpFv6IUXH6ubnzFk+EJBYjFaRPqJHfCpNkzzFSvGcGLVuDYxJ9Gjo+DHVh24/xOqOoJDburOUh4U2vCW/10r+zLWubQUziKyXRfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910582; c=relaxed/simple;
	bh=H8nf7tfD5oT/6PWOmbgyxWoLMQxlwQFGYGkHr7dxa64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUp5dRI7lDUf2ne1F0COrhWG6V+scuNsPVMWj6cJh5oFYSManvis1py6dgrgVO8o8KNcpqthgtUL+lCIEdzY5x2A9BkP+f7VV/thAar3h6LJNDTvPS24HLs5Qywi7jKH5sa8LhltNLr7uCwzwxn9AxFeXrqGVgS2Xhwwz57Tve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSk2QqIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80241C2BD10;
	Thu, 20 Jun 2024 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718910582;
	bh=H8nf7tfD5oT/6PWOmbgyxWoLMQxlwQFGYGkHr7dxa64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSk2QqILNZieTS1eCmaJ9OksCEvdPA04YDPLi+lJY/yhtYNoJ3bYo2pdhR9R5ZlOh
	 x0FJHikNVELPugwWcYaLfjeGz7EB2L5H/FUkCdkqhOq/sF4ddkoT5n+PiGyz43I55F
	 sSU45m3FVxC8vHbPG1rzmDr1NdXtmr2XJMjXKA6rL0FBlDA6mmhps1rPy1vJd/ptYz
	 nDh1MyXmwGBXhI265C7jFthCckzyLDAcXZk/rKz2SGNZEraQmWs2Y7ZsJV90GD8DGH
	 QRtAzWGMMTmOAGxNdGF0q0T8sey+MWgG3Dr2e1214VzLYxVpUJjJy+jPwjXSCV1n7s
	 3E8/rWhHB8PnQ==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFC PATCH v3 10/11] powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into bpf_jit_emit_func_call_rel()
Date: Fri, 21 Jun 2024 00:39:10 +0530
Message-ID: <ccd119e39602ff4eb331b83291b214073f3db0e0.1718908016.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718908016.git.naveen@kernel.org>
References: <cover.1718908016.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 61688a82e047 ("powerpc/bpf: enable kfunc call") enhanced
bpf_jit_emit_func_call_hlp() to handle calls out to module region, where
bpf progs are generated. The only difference now between
bpf_jit_emit_func_call_hlp() and bpf_jit_emit_func_call_rel() is in
handling of the initial pass where target function address is not known.
Fold that logic into bpf_jit_emit_func_call_hlp() and rename it to
bpf_jit_emit_func_call_rel() to simplify bpf function call JIT code.

We don't actually need to load/restore TOC across a call out to a
different kernel helper or to a different bpf program since they all
work with the kernel TOC. We only need to do it if we have to call out
to a module function. So, guard TOC load/restore with appropriate
conditions.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/net/bpf_jit_comp64.c | 61 +++++++++----------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 7703dcf48be8..288ff32d676f 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -202,14 +202,22 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	EMIT(PPC_RAW_BLR());
 }
 
-static int
-bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
+int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
 	long reladdr;
 
-	if (WARN_ON_ONCE(!kernel_text_address(func_addr)))
-		return -EINVAL;
+	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
+	if (!func) {
+		for (int i = 0; i < 5; i++)
+			EMIT(PPC_RAW_NOP());
+		/* elfv1 needs an additional instruction to load addr from descriptor */
+		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))
+			EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_MTCTR(_R12));
+		EMIT(PPC_RAW_BCTRL());
+		return 0;
+	}
 
 #ifdef CONFIG_PPC_KERNEL_PCREL
 	reladdr = func_addr - local_paca->kernelbase;
@@ -266,7 +274,8 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 			 * We can clobber r2 since we get called through a
 			 * function pointer (so caller will save/restore r2).
 			 */
-			EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
+			if (is_module_text_address(func_addr))
+				EMIT(PPC_RAW_LD(_R2, bpf_to_ppc(TMP_REG_2), 8));
 		} else {
 			PPC_LI64(_R12, func);
 			EMIT(PPC_RAW_MTCTR(_R12));
@@ -276,46 +285,14 @@ bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx,
 		 * Load r2 with kernel TOC as kernel TOC is used if function address falls
 		 * within core kernel text.
 		 */
-		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
+		if (is_module_text_address(func_addr))
+			EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
 	}
 #endif
 
 	return 0;
 }
 
-int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
-{
-	unsigned int i, ctx_idx = ctx->idx;
-
-	if (WARN_ON_ONCE(func && is_module_text_address(func)))
-		return -EINVAL;
-
-	/* skip past descriptor if elf v1 */
-	func += FUNCTION_DESCR_SIZE;
-
-	/* Load function address into r12 */
-	PPC_LI64(_R12, func);
-
-	/* For bpf-to-bpf function calls, the callee's address is unknown
-	 * until the last extra pass. As seen above, we use PPC_LI64() to
-	 * load the callee's address, but this may optimize the number of
-	 * instructions required based on the nature of the address.
-	 *
-	 * Since we don't want the number of instructions emitted to increase,
-	 * we pad the optimized PPC_LI64() call with NOPs to guarantee that
-	 * we always have a five-instruction sequence, which is the maximum
-	 * that PPC_LI64() can emit.
-	 */
-	if (!image)
-		for (i = ctx->idx - ctx_idx; i < 5; i++)
-			EMIT(PPC_RAW_NOP());
-
-	EMIT(PPC_RAW_MTCTR(_R12));
-	EMIT(PPC_RAW_BCTRL());
-
-	return 0;
-}
-
 static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
 {
 	/*
@@ -1047,11 +1024,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
-			if (func_addr_fixed)
-				ret = bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
-			else
-				ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
-
+			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
 			if (ret)
 				return ret;
 
-- 
2.45.2


