Return-Path: <bpf+bounces-42571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4549A5990
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 06:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F046B2116F
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 04:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A4E192D97;
	Mon, 21 Oct 2024 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K2SeJLW5"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED27634
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485187; cv=none; b=iADkV3itXIbUAeFmPOm76nH/Nzy3BTatcF67bpU8OlJ4iY6zX1qb2WC3B2gob5OHEggnyoAXl70jncRZT9bKd3V4oIGOq7z3P05rAcm3KaybgaW3OG0mp0UpFmFsB86ae2G1G0ojM//AqpHonzPPCcwl1YJylRs5ByB+4+J0W1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485187; c=relaxed/simple;
	bh=UmhGB7YiYlPlJ6mL/zOU/UU6wTii5WVUOSlomGfZwt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtneKcJF0jidGj3J+wzk6uSr0d8gWkqVl/YyVrPbdiGjf8M020T5Khc/As9c1SzZELaf4DT8F5jEQ/8Fne6cUQc2ATbjWyZEB1g7RPR+KZQDTlwz6OdiZyIHhr/Rb/12iN0eUMtxplhqgCYyjQoFdCukHRmbvHOLJ/spBzLTke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K2SeJLW5; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b304d79-80a7-4366-8267-7e3d724f6e86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729485180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eHudUFdQ83TQnoHkgpvhNmNSQr4K9ZnTtESnPFnJz8=;
	b=K2SeJLW5Ml7c3ecr6dVhmALuqVjLdMc0Ga8wB7izGJCWzZdvxOqZzd9f5hDSg/4BcJXArT
	5mtwB6MfEVL24X029Sz+KiVF9/Ze26PXzG3JO54/t1jTTowtnK2lUsPk0cJ5T+LL6rzsqf
	O24Ba8vbU/lcO47HkbYWWj9T+EVjvaw=
Date: Sun, 20 Oct 2024 21:32:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 8/9] selftests/bpf: Add tracing prog private
 stack tests
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191431.2108197-1-yonghong.song@linux.dev> <ZxV9KUHDcRPC5s9_@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZxV9KUHDcRPC5s9_@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/20/24 2:59 PM, Jiri Olsa wrote:
> On Sun, Oct 20, 2024 at 12:14:31PM -0700, Yonghong Song wrote:
>
> SNIP
>
>> +__naked __noinline __used
>> +static unsigned long loop_callback(void)
>> +{
>> +	asm volatile (
>> +	"call %[bpf_get_prandom_u32];"
>> +	"r1 = 42;"
>> +	"*(u64 *)(r10 - 512) = r1;"
>> +	"call cumulative_stack_depth_subprog;"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_common);
>> +}
>> +
>> +SEC("raw_tp")
>> +__description("Private stack, callback")
>> +__success
>> +__arch_x86_64
>> +/* for func loop_callback */
>> +__jited("func #1")
>> +__jited("	endbr64")
> this should fail if CONFIG_X86_KERNEL_IBT is not enabled, right?
>
> hm, but I can see that also in other tests, so I guess it's fine,
> should we add it to config.x86_64 ?

The CI has CONFIG_X86_KERNEL_IBT as well.

I checked x86 kconfig, I see

config CC_HAS_IBT
         # GCC >= 9 and binutils >= 2.29
         # Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
         # Clang/LLVM >= 14
         # https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d7f6aac00e0f
         # https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934a37c1f35332
         def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch -mindirect-branch-register)) || \
                   (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
                   $(as-instr,endbr64)

config X86_KERNEL_IBT
         prompt "Indirect Branch Tracking"
         def_bool y
         depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
         # https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
         depends on !LD_IS_LLD || LLD_VERSION >= 140000
         select OBJTOOL
         select X86_CET
         help
           Build the kernel with support for Indirect Branch Tracking, a
           hardware support course-grain forward-edge Control Flow Integrity
           protection. It enforces that all indirect calls must land on
           an ENDBR instruction, as such, the compiler will instrument the
           code with them to make this happen.
         
           In addition to building the kernel with IBT, seal all functions that
           are not indirect call targets, avoiding them ever becoming one.
           
           This requires LTO like objtool runs and will slow down the build. It
           does significantly reduce the number of ENDBR instructions in the
           kernel image.

So CONFIG_X86_KERNEL_IBT will be enabled if clang >= version_14 or newer gcc.
In my system, the gcc version is 13.1. So there is no need to explicitly add
CONFIG_X86_KERNEL_IBT to the selftests/bpf/config.x86_64 file.



>
> jirka

