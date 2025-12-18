Return-Path: <bpf+bounces-77057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF59ACCDE1F
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E603012BFC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4434313523;
	Thu, 18 Dec 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PIDqe7hk"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFC2594BD
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098311; cv=none; b=bUL8K7IzE7gKmjhJQceon0Pu8wBmdWnAbeG9ykeaS4GA503PTCqjH8YhoMv2wXDQKcGPAqC53xvG5XVwVqQgRganOgmRXNL5OB0bdpbQjh3yWexndeMbKpgOug50yXshwUIphXDkNgD0zMz/0ct3FytsqmkssnsWDcEnXj1XD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098311; c=relaxed/simple;
	bh=lSjRZ2SY0il4ctEkkPLVq88TlaFK2ViOJ7s+feALWaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUdbxjAeEbA+jJYL2ztj+3moxyw1zvFEszgH3nfhDzjuxlwg07qlC4tTjir1YCF2xLR8N3anHYu4my8+6I1RRbgMUfp7U2f/X6vQYihA+s7KxrnOiLmVzQ/Fb4v2n4/0q43vEGZgAfBzbGnG3/znWit0StjHkDh3zRMU18s3YTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PIDqe7hk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9e402939-40ea-4da2-aad1-43d2afb74a83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766098305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWoFoevjl2IZHBiJsZNYT4pM1ZD9eXdAhMjXrq6FV5k=;
	b=PIDqe7hkpU14K5verXOaIjWtB9nZvMKJ1t5ZAVbcJkyoea3CBtbBSVpEgrxywQ7NZKEqih
	vC2++It+TXdbYZAzGnTKsf5wiBIO8xk5vUc3P86ifaRSDdowmC0a4emBI/fZzXEk355VXW
	DArPwdaKm3JDXMg0zhAMVjT9DlqLblE=
Date: Thu, 18 Dec 2025 14:51:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Content-Language: en-GB
To: Matt Bobrowski <mattbobrowski@google.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 hust-os-kernel-patches@googlegroups.com, Yinhao Hu <dddddd@hust.edu.cn>,
 dzm91@hust.edu.cn, KP Singh <kpsingh@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com> <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
 <aS87V-zpo-ZHZzu0@google.com>
 <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
 <aS_5K_CJcB1rIEVj@google.com>
 <CAADnVQLf10J688CXFWg+=UaOv_zPTr3ViqNFcjbe5u4no2o_GA@mail.gmail.com>
 <aTlFKI2IeHQ2-TSE@google.com> <aTs6JTBrzEa0WJwd@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aTs6JTBrzEa0WJwd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/11/25 1:39 PM, Matt Bobrowski wrote:
> On Wed, Dec 10, 2025 at 10:02:16AM +0000, Matt Bobrowski wrote:
>> On Wed, Dec 03, 2025 at 10:23:43AM -0800, Alexei Starovoitov wrote:
>>> On Wed, Dec 3, 2025 at 12:47 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
>>>>> We can play tricks with __weak. Like:
>>>>>
>>>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
>>>>> index 7cb6e8d4282c..60d269a85bf1 100644
>>>>> --- a/kernel/bpf/bpf_lsm.c
>>>>> +++ b/kernel/bpf/bpf_lsm.c
>>>>> @@ -21,7 +21,7 @@
>>>>>    * function where a BPF program can be attached.
>>>>>    */
>>>>>   #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
>>>>> -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
>>>>> +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
>>>>>
>>>>> diff kernel/bpf/bpf_lsm_proto.c
>>>>>
>>>>> +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
>>>>> +                     unsigned long prot, unsigned long flags)
>>>>> +{
>>>>> +       return 0;
>>>>> +}
>>>>>
>>>>> and above one with __nullable will be in vmlinux BTF.
>>>>>
>>>>> afaik __weak functions are not removed by linker when in non-LTO,
>>>>> but it's still better than
>>>>> +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
>>>>> No need to change bpf_lsm.h either.
>>>> Annotating with a weak attribute would be quite nice, but the compiler
>>>> will complain about the redefinition of the symbol
>>>> bpf_lsm_mmap_file. To avoid this, we'd still need to rely on the
>>>> rename and ignore dance by using the aforementioned define, which at
>>>> that point would still result in both symbols being exposed in both
>>>> BTF and the .text section.
>>> Not quite. You missed this part in the above:
>>>
>>>>> diff kernel/bpf/bpf_lsm_proto.c
>>> it's a different file.
>> Yes, yes, this will work. However, as discussed, it's fundamentally
>> reliant on a small "hack" which I've implemented within
>> kernel/bpf/Makefile here [0] to workaround current pahole
>> deduplication logic.
>>
>> Andrii and Eduard,
>>
>> I’d like your input on a pahole BTF generation issue which I've
>> recently come across. In the series I just sent [0], I had to
>> implement a workaround to force pahole to process bpf_lsm_proto.o
>> before bpf_lsm.o.
>>
>> This was necessary to ensure pahole generates BTF for the strong
>> definition of bpf_lsm_mmap_file() (in bpf_lsm_proto.c) rather than the
>> weak definition (in bpf_lsm.c). Without this forced ordering, pahole
>> processed the weak definition first, resulting in a state array like
>> this:
>>
>> ```
>> btf_encoder.func_states.array[N] = bpf_lsm_mmap_file (weak
>> definition from bpf_lsm.o)
>>
>> btf_encoder.func_states.array[N+1] = bpf_lsm_mmap_file (strong
>> definition from bpf_lsm_proto.o)
>> ```
>>
>> Because the deduplication logic in btf_encoder__add_saved_funcs()
>> folds duplicates (those determined by saved_functions_combine()) into
>> the first occurrence, the resulting BTF was derived from the weak
>> definition. This is incorrect, as the strong definition is the one
>> actually linked into the final vmlinux image.
>>
>> An obvious fix that immediately came to mind here was to essentially
>> teach pahole about strong function prototype definitions, and prefer
>> to emit BTF for those instead of any weak defined counterparts?
> Thinking about this a little more. Perhaps whilst in
> btf_encoder__add_saved_funcs() we should only emit BTF for any
> duplicated function within a CU which happen to match the
> corresponding entry within the backing ELF symtab? We can do this by
> checking whether the virtual address stored within DW_AT_low_pc
> matches that of what's stored in the st_value field for the
> corresponding ELF symtab entry? For example, for bpf_lsm_mmap_file we

I think this is the correct way to do it. Basically we should
pick the dwarf subprogram entry whose DW_AT_low_pc should match
same-name same-low_pc ksym entry.

> have:
>
> Output from reading the vmlinux symbol table:
> ```
> $ readelf -s <input> | grep bpf_lsm_mmap_file
> 165360: ffffffff8152f9b0    16 FUNC    GLOBAL DEFAULT    1 bpf_lsm_mmap_file
> ```
> Output from reading the vmlinux DWARF debugging information:
> ```
> <2a40982>   DW_AT_name        : (indirect string, offset: 0x1352ea): bpf_lsm_mmap_file
> <2a40986>   DW_AT_decl_file   : 4
> <2a40987>   DW_AT_decl_line   : 199
> <2a40988>   DW_AT_decl_column : 1
> <2a40989>   DW_AT_prototyped  : 1
> <2a40989>   DW_AT_type        : <0x2a1b010>
> <2a4098d>   DW_AT_low_pc      : 0xffffffff8152e260
> <2a40995>   DW_AT_high_pc     : 0x10
> <2a4099d>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
> <2a4099f>   DW_AT_call_all_calls: 1
> <2a4099f>   DW_AT_sibling     : <0x2a409d8>
> <2><2a409a3>: Abbrev Number: 10 (DW_TAG_formal_parameter)
> <2a409a4>   DW_AT_name        : (indirect string, offset: 0x3623df): file
> <2a409a8>   DW_AT_decl_file   : 4
> <2a409a9>   DW_AT_decl_line   : 199
> <2a409aa>   DW_AT_decl_column : 1
> <2a409aa>   DW_AT_type        : <0x2a234ef>
> <2a409ae>   DW_AT_location    : 1 byte block: 55    (DW_OP_reg5 (rdi))
> <2><2a409b0>: Abbrev Number: 10 (DW_TAG_formal_parameter)
> <2a409b1>   DW_AT_name        : (indirect string, offset: 0x23a09d): reqprot
> <2a409b5>   DW_AT_decl_file   : 4
> --
> <2a60e0a>   DW_AT_name        : (indirect string, offset: 0x1352ea): bpf_lsm_mmap_file
> <2a60e0e>   DW_AT_decl_file   : 1
> <2a60e0f>   DW_AT_decl_line   : 15
> <2a60e10>   DW_AT_decl_column : 5
> <2a60e11>   DW_AT_prototyped  : 1
> <2a60e11>   DW_AT_type        : <0x2a42713>
> <2a60e15>   DW_AT_low_pc      : 0xffffffff8152f9b0
> <2a60e1d>   DW_AT_high_pc     : 0x10
> <2a60e25>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
> <2a60e27>   DW_AT_call_all_calls: 1
> <2><2a60e27>: Abbrev Number: 82 (DW_TAG_formal_parameter)
> <2a60e28>   DW_AT_name        : (indirect string, offset: 0x135ede): file__nullable
> <2a60e2c>   DW_AT_decl_file   : 1
> <2a60e2c>   DW_AT_decl_line   : 15
> <2a60e2d>   DW_AT_decl_column : 36
> <2a60e2e>   DW_AT_type        : <0x2a49f59>
> <2a60e32>   DW_AT_location    : 1 byte block: 55    (DW_OP_reg5 (rdi))
> ```
>
>> [0] https://lore.kernel.org/bpf/20251210090701.2753545-1-mattbobrowski@google.com/T/#me14d534fb559a349c46e094f18c63d477644d511


