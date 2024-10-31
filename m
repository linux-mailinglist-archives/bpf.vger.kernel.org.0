Return-Path: <bpf+bounces-43653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A89B7E86
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAE283A1B
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EED1BC07B;
	Thu, 31 Oct 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6KcBeA7"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3171BC9ED
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388633; cv=none; b=SsJ0xk5ThZfJ/6DNMryJ7zRYza0Dov/RJCs6RwIViSSU7rmYgnFaYWtg+OCgGAztYKqiIHfE1zLtnBB0NM/Z2v7b017Hl6oYKLv4ekG6pkmT0izLkD9zXEk5ybjhZj0Xbqc27PvEGsiF+snTk4uMUFN5cY5T3VJemY0dQnDfaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388633; c=relaxed/simple;
	bh=5zV2I1qRueWnpKMMW5GwmIIJlIp480xJHgrPEpi+fpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KndBiEkT0BlrHDvYcq3ip0LQZ9X2wtjQ+Bi9tbfJCTEk2r0ZcYPgJdrFOBeX4fSE4UlpwRHpLraAkICpzk7wtdNHqG5mVB44jJ/zhmAJ8l9o8G7EjE0xSPlX2NLAlCPXBiM81OBG7Hv5V/1bkz7sWmfCyIBVRVa5Ce5txOUhIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6KcBeA7; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730388628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J5subX4YaWX/lsgLirC6S9tT02i+bceOMTMUn/I3QnA=;
	b=K6KcBeA7sDJ7dEGt92F6sF1U8V7oCC1kNrwVh7N1XSAh9PS4hSW+cjlfjrL54yfiJBZ8TZ
	uiL58y0soDenWWjo8rld+6SZFtCL7fqkQs/tSmqGEU+yHmOzMN60sdw1+p60HP5VT753Ua
	J81cKgWkmDBTw55Y8gkMAnLtbIwQ0iQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	gray.liang@isovalent.com,
	stfomichev@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v3] bpf, bpftool: Fix incorrect disasm pc
Date: Thu, 31 Oct 2024 23:28:44 +0800
Message-ID: <20241031152844.68817-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch addresses the bpftool issue "Wrong callq address displayed"[0].

The issue stemmed from an incorrect program counter (PC) value used during
disassembly with LLVM or libbfd.

For LLVM: The PC argument must represent the actual address in the kernel
to compute the correct relative address.

For libbfd: The relative address can be adjusted by adding func_ksym within
the custom info->print_address_func to yield the correct address.

Links:
[0] https://github.com/libbpf/bpftool/issues/109

Changes:
v2 -> v3:
  * Address comment from Quentin:
    * Remove the typedef.

v1 -> v2:
  * Fix the broken libbfd disassembler.

Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/jit_disasm.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 7b8d9ec89..c032d2c6a 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -80,7 +80,8 @@ symbol_lookup_callback(__maybe_unused void *disasm_info,
 static int
 init_context(disasm_ctx_t *ctx, const char *arch,
 	     __maybe_unused const char *disassembler_options,
-	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
+	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len,
+	     __maybe_unused __u64 func_ksym)
 {
 	char *triple;
 
@@ -109,12 +110,13 @@ static void destroy_context(disasm_ctx_t *ctx)
 }
 
 static int
-disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
+disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc,
+		 __u64 func_ksym)
 {
 	char buf[256];
 	int count;
 
-	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
+	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, func_ksym + pc,
 				      buf, sizeof(buf));
 	if (json_output)
 		printf_json(buf);
@@ -136,8 +138,21 @@ int disasm_init(void)
 #ifdef HAVE_LIBBFD_SUPPORT
 #define DISASM_SPACER "\t"
 
+struct disasm_info {
+	struct disassemble_info info;
+	__u64 func_ksym;
+};
+
+static void disasm_print_addr(bfd_vma addr, struct disassemble_info *info)
+{
+	struct disasm_info *dinfo = container_of(info, struct disasm_info, info);
+
+	addr += dinfo->func_ksym;
+	generic_print_address(addr, info);
+}
+
 typedef struct {
-	struct disassemble_info *info;
+	struct disasm_info *info;
 	disassembler_ftype disassemble;
 	bfd *bfdf;
 } disasm_ctx_t;
@@ -215,7 +230,7 @@ static int fprintf_json_styled(void *out,
 
 static int init_context(disasm_ctx_t *ctx, const char *arch,
 			const char *disassembler_options,
-			unsigned char *image, ssize_t len)
+			unsigned char *image, ssize_t len, __u64 func_ksym)
 {
 	struct disassemble_info *info;
 	char tpath[PATH_MAX];
@@ -238,12 +253,13 @@ static int init_context(disasm_ctx_t *ctx, const char *arch,
 	}
 	bfdf = ctx->bfdf;
 
-	ctx->info = malloc(sizeof(struct disassemble_info));
+	ctx->info = malloc(sizeof(struct disasm_info));
 	if (!ctx->info) {
 		p_err("mem alloc failed");
 		goto err_close;
 	}
-	info = ctx->info;
+	ctx->info->func_ksym = func_ksym;
+	info = &ctx->info->info;
 
 	if (json_output)
 		init_disassemble_info_compat(info, stdout,
@@ -272,6 +288,7 @@ static int init_context(disasm_ctx_t *ctx, const char *arch,
 		info->disassembler_options = disassembler_options;
 	info->buffer = image;
 	info->buffer_length = len;
+	info->print_address_func = disasm_print_addr;
 
 	disassemble_init_for_target(info);
 
@@ -304,9 +321,10 @@ static void destroy_context(disasm_ctx_t *ctx)
 
 static int
 disassemble_insn(disasm_ctx_t *ctx, __maybe_unused unsigned char *image,
-		 __maybe_unused ssize_t len, int pc)
+		 __maybe_unused ssize_t len, int pc,
+		 __maybe_unused __u64 func_ksym)
 {
-	return ctx->disassemble(pc, ctx->info);
+	return ctx->disassemble(pc, &ctx->info->info);
 }
 
 int disasm_init(void)
@@ -331,7 +349,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	if (!len)
 		return -1;
 
-	if (init_context(&ctx, arch, disassembler_options, image, len))
+	if (init_context(&ctx, arch, disassembler_options, image, len, func_ksym))
 		return -1;
 
 	if (json_output)
@@ -360,7 +378,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			printf("%4x:" DISASM_SPACER, pc);
 		}
 
-		count = disassemble_insn(&ctx, image, len, pc);
+		count = disassemble_insn(&ctx, image, len, pc, func_ksym);
 
 		if (json_output) {
 			/* Operand array, was started in fprintf_json. Before
-- 
2.44.0


