Return-Path: <bpf+bounces-43629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F09B7428
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 06:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A63F1C21A30
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 05:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7513C8F4;
	Thu, 31 Oct 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8FcLqUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2328E8
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730352998; cv=none; b=ZnT7MiRdgOTRVpvaCGApZNyTfoUr3QpoL8tq2sdXzUzWsoEXP1XAWNZPZ4S/OJVRJM5FsD71NGvVcObisbj+OJTbiH5Pf75q7h2xic+g18D5RGWENcHqFo0T+GN5tzaQ77/t+uXeWN/Z9sarUBpbDusam0qlV4ML4eIk1Egthc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730352998; c=relaxed/simple;
	bh=SA4xEqZB4d4REsH/+XWP6VcVl0Ji6B9b40QucTiShi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9aehK145GKiTnT2K5Lo2pHvL6x5VIy55En1pDPXxs0qa8dOuP/HoWB/b3gRrhSOAWxEFc287nHANp7WdtDphB8B/68zixdTA7WzdEOo/xLqE4Ulp61ldSjnMsL732o7psSk2N3anUpLi2+xJHS7SAWCMWnMKLpqbgTFBnrbUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8FcLqUd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca388d242so5772135ad.2
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 22:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730352996; x=1730957796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEL9ROgJ6eIBTqwcPJI+h10arWenCX5ZkdyZVHvefe8=;
        b=l8FcLqUdyxtgPkCRqGWQKvxhr2z3Xd7j5umIWbdEIoUccLyP/wiI8wOyXNJOkZ3h3u
         s7YDUVhLyke1lJa0wafXy4BJI0XA20KBYe282JZylnA0ExDsHjB9aVfHFhVurBNY2RFk
         elFZgMCXyC6ceupujf/be+PsRgmm9tDHFx+MOB9hJapVdv46ZtzJmsWzxR0VbU3E0YYA
         gJmYqjEIAFx4UGWPgobY28fbFHg7zktZ6B8XcTwc4jUrl1Mu/Fs+ATAiSCFHn9E13kat
         i6rvOiwL3cWs7yIZQGkPODpvHNOwOiTNFLq+wMbfg7TMb47vIv5DIJBit7aWSQmHu+IA
         uxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730352996; x=1730957796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEL9ROgJ6eIBTqwcPJI+h10arWenCX5ZkdyZVHvefe8=;
        b=oNICiZco1dNCrpcNaXP6zDREpHa3lOqHcwjoFS3/FFbLRGhvIg9gQAyvh6HoUommyp
         NZxjn9EaCgFo6Dte9P2BWGRyWOTinsT8cbmqSIQ2FHe22ccsPZ+ZJpup1vZAB0sfS6u2
         obTnnf+ARs6sWA7ptAJExI35pFCRP/rTHLmW/nmw1GGJOp9XRzeZ9iS4H4UwW3QDqJ6B
         LzSbHJWFFWeTTZft8MV9WdmkH4UhPV516pp3QA2ezSxw1gzThjZkJcNYIot0bJnZYNG1
         1MSXsUzbmdUEhbNYjWfC2Jubhm/YaWdIRtMe2cT8CGMIgIteyabNxShYJ//WVNPoEJbx
         AP+A==
X-Forwarded-Encrypted: i=1; AJvYcCUnn/NUNVJ9XbJOLr1IaE3w2dsr/Owlzb3hzp0H67UeqoSZeCUF+RfK7JMbt3+UMTx/0NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQePHSVF6+4+zjWPXAMy2gpjzjt43Kzf/VZhsfjfadId4RjLT
	ybH30DKck2zf4OoGHD++XMWa7pqbmbq4d+DIzvXL6SlEypFdlt4B
X-Google-Smtp-Source: AGHT+IGO3M5+e+a6QjfyvK22ZviT0ji+PiuGbExr/SisEuLrhad5fKQ5pSxcO/hCBIZslQfwXg/pcQ==
X-Received: by 2002:a17:902:e74d:b0:20c:637e:b28 with SMTP id d9443c01a7336-210c6c3e224mr279037285ad.39.1730352995561;
        Wed, 30 Oct 2024 22:36:35 -0700 (PDT)
Received: from [172.20.10.5] ([117.20.154.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105708354sm4018105ad.98.2024.10.30.22.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 22:36:34 -0700 (PDT)
Message-ID: <3c6decbc-5146-482a-9d85-bf281157f54b@gmail.com>
Date: Thu, 31 Oct 2024 13:36:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
To: Leon Hwang <leon.hwang@linux.dev>, Quentin Monnet <qmo@kernel.org>,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-patches-bot@fb.com, Stanislav Fomichev <stfomichev@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Gray Liang <gray.liang@isovalent.com>
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
 <1b492a6f-c7e8-4dba-84dd-35aafb6c2ede@kernel.org>
 <f9dd4ff7-116c-4bac-b007-4bc5f141e36d@linux.dev>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <f9dd4ff7-116c-4bac-b007-4bc5f141e36d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/10/31 13:27, Leon Hwang wrote:
> 
> 
> On 2024/10/31 08:27, Quentin Monnet wrote:
>> 2024-10-30 17:47 UTC+0800 ~ Leon Hwang <hffilwlqm@gmail.com>
>>> From: Leon Hwang <leon.hwang@linux.dev>
>>>
>>> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
>>>
>>> The issue stemmed from an incorrect program counter (PC) value used during
>>> disassembly with LLVM or libbfd. To calculate the correct address for
>>> relative calls, the PC argument must reflect the actual address in the
>>> kernel.
>>>
>>> [0] https://github.com/libbpf/bpftool/issues/109
>>>
>>> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>  tools/bpf/bpftool/jit_disasm.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
>>> index 7b8d9ec89ebd3..fe8fabba4b05f 100644
>>> --- a/tools/bpf/bpftool/jit_disasm.c
>>> +++ b/tools/bpf/bpftool/jit_disasm.c
>>> @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
>>>  	char buf[256];
>>>  	int count;
>>>  
>>> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
>>> -				      buf, sizeof(buf));
>>> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
>>>  	if (json_output)
>>>  		printf_json(buf);
>>>  	else
>>> @@ -360,7 +359,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
>>>  			printf("%4x:" DISASM_SPACER, pc);
>>>  		}
>>>  
>>> -		count = disassemble_insn(&ctx, image, len, pc);
>>> +		count = disassemble_insn(&ctx, image + pc, len - pc,
>>> +					 func_ksym + pc);
>>
>> Thanks a lot for looking into this! Your patch does solve the issue for
>> the LLVM disassembler (nice!), but it breaks the libbfd one:
>>
>>
>> 	$ ./bpftool version | grep features
>> 	features: libbfd
>> 	# ./bpftool prog dump j id 111 op
>> 	int xdp_redirect_map_0(struct xdp_md * xdp):
>> 	bpf_prog_a8f6f9c4be77b94c_xdp_redirect_map_0:
>> 	; return bpf_redirect_map(&tx_port, 0, 0);
>> 	   0:   Address 0xffffffffc01ae950 is out of bounds.
>>
>> I don't think we can change the PC in the case of libbfd, as far as I
>> can tell it needs to point to the first instruction to disassemble. Two
>> of the arguments we pass to disassemble_insn(), image and len, are
>> ignored by the libbfd disassembler; so it leaves only the ctx argument
>> that we can maybe update to pass the func_ksym, but I haven't found how
>> to do that yet (if possible at all).
>>
>> Thanks,
>> Quentin
>>
> 
> Hi Quentin,
> 
> After diving into the details of libbfd, I’ve found a way to correct the
> callq address. By adjusting the relative addresses using func_ksym
> within a custom info->print_addr_func, we can achieve accurate results.
> 
> Here’s the updated patch:
> 
> From 687f165fe79b67ba457672bb682bde3d916ce0cd Mon Sep 17 00:00:00 2001
> From: Leon Hwang <leon.hwang@linux.dev>
> Date: Thu, 31 Oct 2024 13:00:05 +0800
> Subject: [PATCH bpf v2] bpf, bpftool: Fix incorrect disasm pc
> 
> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
> 
> The issue stemmed from an incorrect program counter (PC) value used during
> disassembly with LLVM or libbfd.
> 
> For LLVM: The PC argument must represent the actual address in the kernel
> to compute the correct relative address.
> 
> For libbfd: The relative address can be adjusted by adding func_ksym within
> the custom info->print_address_func to yield the correct address.
> 
> [0] https://github.com/libbpf/bpftool/issues/109
> 
> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/jit_disasm.c | 40 ++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index 7b8d9ec89..f76d4bf0c 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -80,7 +80,8 @@ symbol_lookup_callback(__maybe_unused void *disasm_info,
>  static int
>  init_context(disasm_ctx_t *ctx, const char *arch,
>  	     __maybe_unused const char *disassembler_options,
> -	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
> +	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len,
> +	     __maybe_unused __u64 func_ksym)
>  {
>  	char *triple;
> 
> @@ -109,12 +110,13 @@ static void destroy_context(disasm_ctx_t *ctx)
>  }
> 
>  static int
> -disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len,
> int pc)
> +disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len,
> int pc,
> +		 __u64 func_ksym)
>  {
>  	char buf[256];
>  	int count;
> 
> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
> +	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, func_ksym + pc,
>  				      buf, sizeof(buf));
>  	if (json_output)
>  		printf_json(buf);
> @@ -137,7 +139,20 @@ int disasm_init(void)
>  #define DISASM_SPACER "\t"
> 
>  typedef struct {
> -	struct disassemble_info *info;
> +	struct disassemble_info info;
> +	__u64 func_ksym;
> +} disasm_info;
> +
> +static void disasm_print_addr(bfd_vma addr, struct disassemble_info *info)
> +{
> +	disasm_info *dinfo = container_of(info, disasm_info, info);
> +
> +	addr += dinfo->func_ksym;
> +	generic_print_address(addr, info);
> +}
> +
> +typedef struct {
> +	disasm_info *info;
>  	disassembler_ftype disassemble;
>  	bfd *bfdf;
>  } disasm_ctx_t;
> @@ -215,7 +230,7 @@ static int fprintf_json_styled(void *out,
> 
>  static int init_context(disasm_ctx_t *ctx, const char *arch,
>  			const char *disassembler_options,
> -			unsigned char *image, ssize_t len)
> +			unsigned char *image, ssize_t len, __u64 func_ksym)
>  {
>  	struct disassemble_info *info;
>  	char tpath[PATH_MAX];
> @@ -238,12 +253,13 @@ static int init_context(disasm_ctx_t *ctx, const
> char *arch,
>  	}
>  	bfdf = ctx->bfdf;
> 
> -	ctx->info = malloc(sizeof(struct disassemble_info));
> +	ctx->info = malloc(sizeof(disasm_info));
>  	if (!ctx->info) {
>  		p_err("mem alloc failed");
>  		goto err_close;
>  	}
> -	info = ctx->info;
> +	ctx->info->func_ksym = func_ksym;
> +	info = &ctx->info->info;
> 
>  	if (json_output)
>  		init_disassemble_info_compat(info, stdout,
> @@ -272,6 +288,7 @@ static int init_context(disasm_ctx_t *ctx, const
> char *arch,
>  		info->disassembler_options = disassembler_options;
>  	info->buffer = image;
>  	info->buffer_length = len;
> +	info->print_address_func = disasm_print_addr;
> 
>  	disassemble_init_for_target(info);
> 
> @@ -304,9 +321,10 @@ static void destroy_context(disasm_ctx_t *ctx)
> 
>  static int
>  disassemble_insn(disasm_ctx_t *ctx, __maybe_unused unsigned char *image,
> -		 __maybe_unused ssize_t len, int pc)
> +		 __maybe_unused ssize_t len, __u64 pc,

NIT: type of pc should keep int

Thanks,
Leon

> +		 __maybe_unused __u64 func_ksym)
>  {
> -	return ctx->disassemble(pc, ctx->info);
> +	return ctx->disassemble(pc, &ctx->info->info);
>  }
> 
>  int disasm_init(void)
> @@ -331,7 +349,7 @@ int disasm_print_insn(unsigned char *image, ssize_t
> len, int opcodes,
>  	if (!len)
>  		return -1;
> 
> -	if (init_context(&ctx, arch, disassembler_options, image, len))
> +	if (init_context(&ctx, arch, disassembler_options, image, len, func_ksym))
>  		return -1;
> 
>  	if (json_output)
> @@ -360,7 +378,7 @@ int disasm_print_insn(unsigned char *image, ssize_t
> len, int opcodes,
>  			printf("%4x:" DISASM_SPACER, pc);
>  		}
> 
> -		count = disassemble_insn(&ctx, image, len, pc);
> +		count = disassemble_insn(&ctx, image, len, pc, func_ksym);
> 
>  		if (json_output) {
>  			/* Operand array, was started in fprintf_json. Before


