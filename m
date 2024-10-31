Return-Path: <bpf+bounces-43646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A69B7D69
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9A1C2118C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC51A0BEC;
	Thu, 31 Oct 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR1dMOe/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75C19538A
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386723; cv=none; b=oFYUCMivi3I4dQtdqNLHMs5g2jcLMf4LakV5dAVK9+k8sle45j6XgYd0sq83zdb22fQk2H7XiT9utg/Ms/DCNi7JFiLyhXs3tVRYLxM9NUy+cFDX+AWu5dWkN3LTJpk/mNtspnwovAjccLRaPGLivGfRkKZMrK2fA64hLf1Zw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386723; c=relaxed/simple;
	bh=BlEWA1nNFt1WOLumZCYL5uHzFAT/wX+wd2+9lpf/Suk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gk8w7kUTlJlKlP8RFyoXpZGJ54jMWQrJpDmY04K/Yon1crTRQHBaz6oB5QfrZNT7p9reZGVICrbVh0SdAOHQ/uJORLNnT5i2MetNaQ/PhCEmotyzMaqS896NhZemy8Lk1mE5Vq8JxS7zJopjEEWMuZEyf6NYLCNmRtpF0Oiiwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR1dMOe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43601C4CED3;
	Thu, 31 Oct 2024 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730386723;
	bh=BlEWA1nNFt1WOLumZCYL5uHzFAT/wX+wd2+9lpf/Suk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QR1dMOe/MmE5veN+ejBHo1/Lkg2V5dL1vHmpKUuvb5X+xa/KqwHc7m2CHrEbx5aBO
	 5O/kz24PzTQ9UaPulZBTFJjxoy6CUVUVx1UAI5YmoDXFdKL1shfZNVpAicfT47bHGp
	 zmGbBjXNFrcXqgbJxY5pjUg/bD98JJUPahKTCjcqCDyi8TjWiqiChNsFpa4Eqf1BGe
	 WoEHMl/Ste91kCGiQhE+lTOZ1x7gzwyY3Y8FkmZ6AmK6j+f7IPEVPl9mewK7uwXHLj
	 KpZe/kI6h2JlyIEY+zBt+8sPysvXvGOttfunpxmkuot/tJzHimPBvrzXcf3Mi3EQZK
	 csBUbZ8HvSWhA==
Message-ID: <1a7799c6-cb75-4428-b872-4ead348de9e8@kernel.org>
Date: Thu, 31 Oct 2024 14:58:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
To: Leon Hwang <hffilwlqm@gmail.com>, Leon Hwang <leon.hwang@linux.dev>,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-patches-bot@fb.com, Stanislav Fomichev <stfomichev@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Gray Liang <gray.liang@isovalent.com>
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
 <1b492a6f-c7e8-4dba-84dd-35aafb6c2ede@kernel.org>
 <f9dd4ff7-116c-4bac-b007-4bc5f141e36d@linux.dev>
 <3c6decbc-5146-482a-9d85-bf281157f54b@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <3c6decbc-5146-482a-9d85-bf281157f54b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-10-31 13:36 UTC+0800 ~ Leon Hwang <hffilwlqm@gmail.com>
> 
> 
> On 2024/10/31 13:27, Leon Hwang wrote:
>>
>>
>> On 2024/10/31 08:27, Quentin Monnet wrote:
>>> 2024-10-30 17:47 UTC+0800 ~ Leon Hwang <hffilwlqm@gmail.com>
>>>> From: Leon Hwang <leon.hwang@linux.dev>
>>>>
>>>> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
>>>>
>>>> The issue stemmed from an incorrect program counter (PC) value used during
>>>> disassembly with LLVM or libbfd. To calculate the correct address for
>>>> relative calls, the PC argument must reflect the actual address in the
>>>> kernel.
>>>>
>>>> [0] https://github.com/libbpf/bpftool/issues/109
>>>>
>>>> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>>  tools/bpf/bpftool/jit_disasm.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
>>>> index 7b8d9ec89ebd3..fe8fabba4b05f 100644
>>>> --- a/tools/bpf/bpftool/jit_disasm.c
>>>> +++ b/tools/bpf/bpftool/jit_disasm.c
>>>> @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
>>>>  	char buf[256];
>>>>  	int count;
>>>>  
>>>> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
>>>> -				      buf, sizeof(buf));
>>>> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
>>>>  	if (json_output)
>>>>  		printf_json(buf);
>>>>  	else
>>>> @@ -360,7 +359,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
>>>>  			printf("%4x:" DISASM_SPACER, pc);
>>>>  		}
>>>>  
>>>> -		count = disassemble_insn(&ctx, image, len, pc);
>>>> +		count = disassemble_insn(&ctx, image + pc, len - pc,
>>>> +					 func_ksym + pc);
>>>
>>> Thanks a lot for looking into this! Your patch does solve the issue for
>>> the LLVM disassembler (nice!), but it breaks the libbfd one:
>>>
>>>
>>> 	$ ./bpftool version | grep features
>>> 	features: libbfd
>>> 	# ./bpftool prog dump j id 111 op
>>> 	int xdp_redirect_map_0(struct xdp_md * xdp):
>>> 	bpf_prog_a8f6f9c4be77b94c_xdp_redirect_map_0:
>>> 	; return bpf_redirect_map(&tx_port, 0, 0);
>>> 	   0:   Address 0xffffffffc01ae950 is out of bounds.
>>>
>>> I don't think we can change the PC in the case of libbfd, as far as I
>>> can tell it needs to point to the first instruction to disassemble. Two
>>> of the arguments we pass to disassemble_insn(), image and len, are
>>> ignored by the libbfd disassembler; so it leaves only the ctx argument
>>> that we can maybe update to pass the func_ksym, but I haven't found how
>>> to do that yet (if possible at all).
>>>
>>> Thanks,
>>> Quentin
>>>
>>
>> Hi Quentin,
>>
>> After diving into the details of libbfd, I’ve found a way to correct the
>> callq address. By adjusting the relative addresses using func_ksym
>> within a custom info->print_addr_func, we can achieve accurate results.
>>
>> Here’s the updated patch:
>>
>> From 687f165fe79b67ba457672bb682bde3d916ce0cd Mon Sep 17 00:00:00 2001
>> From: Leon Hwang <leon.hwang@linux.dev>
>> Date: Thu, 31 Oct 2024 13:00:05 +0800
>> Subject: [PATCH bpf v2] bpf, bpftool: Fix incorrect disasm pc
>>
>> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
>>
>> The issue stemmed from an incorrect program counter (PC) value used during
>> disassembly with LLVM or libbfd.
>>
>> For LLVM: The PC argument must represent the actual address in the kernel
>> to compute the correct relative address.
>>
>> For libbfd: The relative address can be adjusted by adding func_ksym within
>> the custom info->print_address_func to yield the correct address.
>>
>> [0] https://github.com/libbpf/bpftool/issues/109
>>
>> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/bpf/bpftool/jit_disasm.c | 40 ++++++++++++++++++++++++----------
>>  1 file changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
>> index 7b8d9ec89..f76d4bf0c 100644
>> --- a/tools/bpf/bpftool/jit_disasm.c
>> +++ b/tools/bpf/bpftool/jit_disasm.c
>> @@ -80,7 +80,8 @@ symbol_lookup_callback(__maybe_unused void *disasm_info,
>>  static int
>>  init_context(disasm_ctx_t *ctx, const char *arch,
>>  	     __maybe_unused const char *disassembler_options,
>> -	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
>> +	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len,
>> +	     __maybe_unused __u64 func_ksym)
>>  {
>>  	char *triple;
>>
>> @@ -109,12 +110,13 @@ static void destroy_context(disasm_ctx_t *ctx)
>>  }
>>
>>  static int
>> -disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len,
>> int pc)
>> +disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len,
>> int pc,
>> +		 __u64 func_ksym)
>>  {
>>  	char buf[256];
>>  	int count;
>>
>> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
>> +	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, func_ksym + pc,
>>  				      buf, sizeof(buf));
>>  	if (json_output)
>>  		printf_json(buf);
>> @@ -137,7 +139,20 @@ int disasm_init(void)
>>  #define DISASM_SPACER "\t"
>>
>>  typedef struct {
>> -	struct disassemble_info *info;
>> +	struct disassemble_info info;
>> +	__u64 func_ksym;
>> +} disasm_info;


I don't think we need a typdef for this one?


>> +
>> +static void disasm_print_addr(bfd_vma addr, struct disassemble_info *info)
>> +{
>> +	disasm_info *dinfo = container_of(info, disasm_info, info);
>> +
>> +	addr += dinfo->func_ksym;
>> +	generic_print_address(addr, info);
>> +}
>> +
>> +typedef struct {
>> +	disasm_info *info;
>>  	disassembler_ftype disassemble;
>>  	bfd *bfdf;
>>  } disasm_ctx_t;
>> @@ -215,7 +230,7 @@ static int fprintf_json_styled(void *out,
>>
>>  static int init_context(disasm_ctx_t *ctx, const char *arch,
>>  			const char *disassembler_options,
>> -			unsigned char *image, ssize_t len)
>> +			unsigned char *image, ssize_t len, __u64 func_ksym)
>>  {
>>  	struct disassemble_info *info;
>>  	char tpath[PATH_MAX];
>> @@ -238,12 +253,13 @@ static int init_context(disasm_ctx_t *ctx, const
>> char *arch,
>>  	}
>>  	bfdf = ctx->bfdf;
>>
>> -	ctx->info = malloc(sizeof(struct disassemble_info));
>> +	ctx->info = malloc(sizeof(disasm_info));
>>  	if (!ctx->info) {
>>  		p_err("mem alloc failed");
>>  		goto err_close;
>>  	}
>> -	info = ctx->info;
>> +	ctx->info->func_ksym = func_ksym;
>> +	info = &ctx->info->info;
>>
>>  	if (json_output)
>>  		init_disassemble_info_compat(info, stdout,
>> @@ -272,6 +288,7 @@ static int init_context(disasm_ctx_t *ctx, const
>> char *arch,
>>  		info->disassembler_options = disassembler_options;
>>  	info->buffer = image;
>>  	info->buffer_length = len;
>> +	info->print_address_func = disasm_print_addr;
>>
>>  	disassemble_init_for_target(info);
>>
>> @@ -304,9 +321,10 @@ static void destroy_context(disasm_ctx_t *ctx)
>>
>>  static int
>>  disassemble_insn(disasm_ctx_t *ctx, __maybe_unused unsigned char *image,
>> -		 __maybe_unused ssize_t len, int pc)
>> +		 __maybe_unused ssize_t len, __u64 pc,
> 
> NIT: type of pc should keep int


Yep. Can you please send a v3 with this fix? So that patchwork can pick
it up properly.

I tested your v2 and it works for both disassemblers, thanks a lot!

Quentin


