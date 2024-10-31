Return-Path: <bpf+bounces-43628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811069B7421
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 06:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D4D1F24B41
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 05:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CFE13C9B8;
	Thu, 31 Oct 2024 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OcYh0j/j"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC2131BDD
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730352451; cv=none; b=E/XW0Nzrs+il0BXm/xe1TsRgVZII6/knvGH/tX0kwNPT4tHfAAVDYlC689RKNBgXi8U62ildjkpetlsHi6gdO03SSjv1Ne+LFX876KTtRv5WIXwVjwCLjpud8WJGAY9ONvcsCtnD5x/F5kxZBtJgGYtwUNnRXY8XioNip5qKS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730352451; c=relaxed/simple;
	bh=7G4Mzo3iB96zMi+5HCTVwzjdbbhW28GB2oQcs0wnwFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfhVoNuuJ8CKyCjWmsUOZBLhYInnIDrhFgB2Q7Yk587P0J4Yt8AjlpKQyS9LAe56rWidNtifqSuQYEMJcTUMpZ4We0jldYKR0T8olWUOc2eiEUz3u0TR1kZ5vdLsauLMo1QU+irSV9TzM56Batv9jatCaiCdaqWzwjCvDvjAF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OcYh0j/j; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f9dd4ff7-116c-4bac-b007-4bc5f141e36d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730352444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7GakDS8gXZDrITGXcw984pYrfx+sVRGojPXsl/D4XY=;
	b=OcYh0j/jj0ybNMxEg4z1Vj3mFE04UjLLc3VMNOW+0wrXcDP18Q9NrjTWP9hw0gXfGhDCMo
	cfxpHd76ynsFunn8w+3G1NLrnLQgcu0eRFgav5mt43xLVC0C90h91pJ0fHFxW3f/BscinI
	1pmP6vZPr1whWZv+I43GUL4MuELcCho=
Date: Thu, 31 Oct 2024 13:27:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
To: Quentin Monnet <qmo@kernel.org>, Leon Hwang <hffilwlqm@gmail.com>,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-patches-bot@fb.com, Stanislav Fomichev <stfomichev@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Gray Liang <gray.liang@isovalent.com>
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
 <1b492a6f-c7e8-4dba-84dd-35aafb6c2ede@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <1b492a6f-c7e8-4dba-84dd-35aafb6c2ede@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/31 08:27, Quentin Monnet wrote:
> 2024-10-30 17:47 UTC+0800 ~ Leon Hwang <hffilwlqm@gmail.com>
>> From: Leon Hwang <leon.hwang@linux.dev>
>>
>> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
>>
>> The issue stemmed from an incorrect program counter (PC) value used during
>> disassembly with LLVM or libbfd. To calculate the correct address for
>> relative calls, the PC argument must reflect the actual address in the
>> kernel.
>>
>> [0] https://github.com/libbpf/bpftool/issues/109
>>
>> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/bpf/bpftool/jit_disasm.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
>> index 7b8d9ec89ebd3..fe8fabba4b05f 100644
>> --- a/tools/bpf/bpftool/jit_disasm.c
>> +++ b/tools/bpf/bpftool/jit_disasm.c
>> @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
>>  	char buf[256];
>>  	int count;
>>  
>> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
>> -				      buf, sizeof(buf));
>> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
>>  	if (json_output)
>>  		printf_json(buf);
>>  	else
>> @@ -360,7 +359,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
>>  			printf("%4x:" DISASM_SPACER, pc);
>>  		}
>>  
>> -		count = disassemble_insn(&ctx, image, len, pc);
>> +		count = disassemble_insn(&ctx, image + pc, len - pc,
>> +					 func_ksym + pc);
> 
> Thanks a lot for looking into this! Your patch does solve the issue for
> the LLVM disassembler (nice!), but it breaks the libbfd one:
> 
> 
> 	$ ./bpftool version | grep features
> 	features: libbfd
> 	# ./bpftool prog dump j id 111 op
> 	int xdp_redirect_map_0(struct xdp_md * xdp):
> 	bpf_prog_a8f6f9c4be77b94c_xdp_redirect_map_0:
> 	; return bpf_redirect_map(&tx_port, 0, 0);
> 	   0:   Address 0xffffffffc01ae950 is out of bounds.
> 
> I don't think we can change the PC in the case of libbfd, as far as I
> can tell it needs to point to the first instruction to disassemble. Two
> of the arguments we pass to disassemble_insn(), image and len, are
> ignored by the libbfd disassembler; so it leaves only the ctx argument
> that we can maybe update to pass the func_ksym, but I haven't found how
> to do that yet (if possible at all).
> 
> Thanks,
> Quentin
> 

Hi Quentin,

After diving into the details of libbfd, I’ve found a way to correct the
callq address. By adjusting the relative addresses using func_ksym
within a custom info->print_addr_func, we can achieve accurate results.

Here’s the updated patch:

From 687f165fe79b67ba457672bb682bde3d916ce0cd Mon Sep 17 00:00:00 2001
From: Leon Hwang <leon.hwang@linux.dev>
Date: Thu, 31 Oct 2024 13:00:05 +0800
Subject: [PATCH bpf v2] bpf, bpftool: Fix incorrect disasm pc

This patch addresses the bpftool issue "Wrong callq address displayed"[0].

The issue stemmed from an incorrect program counter (PC) value used during
disassembly with LLVM or libbfd.

For LLVM: The PC argument must represent the actual address in the kernel
to compute the correct relative address.

For libbfd: The relative address can be adjusted by adding func_ksym within
the custom info->print_address_func to yield the correct address.

[0] https://github.com/libbpf/bpftool/issues/109

Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/jit_disasm.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 7b8d9ec89..f76d4bf0c 100644
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
-disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len,
int pc)
+disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len,
int pc,
+		 __u64 func_ksym)
 {
 	char buf[256];
 	int count;

-	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
+	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, func_ksym + pc,
 				      buf, sizeof(buf));
 	if (json_output)
 		printf_json(buf);
@@ -137,7 +139,20 @@ int disasm_init(void)
 #define DISASM_SPACER "\t"

 typedef struct {
-	struct disassemble_info *info;
+	struct disassemble_info info;
+	__u64 func_ksym;
+} disasm_info;
+
+static void disasm_print_addr(bfd_vma addr, struct disassemble_info *info)
+{
+	disasm_info *dinfo = container_of(info, disasm_info, info);
+
+	addr += dinfo->func_ksym;
+	generic_print_address(addr, info);
+}
+
+typedef struct {
+	disasm_info *info;
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
@@ -238,12 +253,13 @@ static int init_context(disasm_ctx_t *ctx, const
char *arch,
 	}
 	bfdf = ctx->bfdf;

-	ctx->info = malloc(sizeof(struct disassemble_info));
+	ctx->info = malloc(sizeof(disasm_info));
 	if (!ctx->info) {
 		p_err("mem alloc failed");
 		goto err_close;
 	}
-	info = ctx->info;
+	ctx->info->func_ksym = func_ksym;
+	info = &ctx->info->info;

 	if (json_output)
 		init_disassemble_info_compat(info, stdout,
@@ -272,6 +288,7 @@ static int init_context(disasm_ctx_t *ctx, const
char *arch,
 		info->disassembler_options = disassembler_options;
 	info->buffer = image;
 	info->buffer_length = len;
+	info->print_address_func = disasm_print_addr;

 	disassemble_init_for_target(info);

@@ -304,9 +321,10 @@ static void destroy_context(disasm_ctx_t *ctx)

 static int
 disassemble_insn(disasm_ctx_t *ctx, __maybe_unused unsigned char *image,
-		 __maybe_unused ssize_t len, int pc)
+		 __maybe_unused ssize_t len, __u64 pc,
+		 __maybe_unused __u64 func_ksym)
 {
-	return ctx->disassemble(pc, ctx->info);
+	return ctx->disassemble(pc, &ctx->info->info);
 }

 int disasm_init(void)
@@ -331,7 +349,7 @@ int disasm_print_insn(unsigned char *image, ssize_t
len, int opcodes,
 	if (!len)
 		return -1;

-	if (init_context(&ctx, arch, disassembler_options, image, len))
+	if (init_context(&ctx, arch, disassembler_options, image, len, func_ksym))
 		return -1;

 	if (json_output)
@@ -360,7 +378,7 @@ int disasm_print_insn(unsigned char *image, ssize_t
len, int opcodes,
 			printf("%4x:" DISASM_SPACER, pc);
 		}

-		count = disassemble_insn(&ctx, image, len, pc);
+		count = disassemble_insn(&ctx, image, len, pc, func_ksym);

 		if (json_output) {
 			/* Operand array, was started in fprintf_json. Before
-- 
2.44.0


Thanks,
Leon



