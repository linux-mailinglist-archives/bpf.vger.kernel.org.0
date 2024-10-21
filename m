Return-Path: <bpf+bounces-42657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037D9A6F53
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE142837F7
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F81F8936;
	Mon, 21 Oct 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jFtZ20pQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287B1F4FC6
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527617; cv=none; b=lDKeRTCCpruXcq1mm2OCwShimi0gZFuNougKngw7qG6EN0xzMaZoeXAhfToWviQrfBZFmdE4UVDGRM3poOEwcNdU1ndEpuIvzQ/wjVbp2OLg2snwJJfDRuly6oEEdme8AFJyUSrkqbmfwoZvkQddxolqbeGBLvrBPMqkJXUqzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527617; c=relaxed/simple;
	bh=0mKZ8vje+kGS/8jjskgA+aeIOAyP769yY5w6qJ95a8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8W3tj7snp6RAmS8awltdsJB6ucac0HV6w1mIu3tEK5MpWMsZ5ea5onQeYeEVEBXxr7DoDndE1BhjKWzcl3NbHuZnDCkFUeaTqiUt+NL8t61LweIg2lxo86vavRb6BIu+dLluv/9lGnL5Iknh7nVmTECC4adgdiSCeIIoP/7RJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jFtZ20pQ; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72039787-a0a6-470c-8610-a813f12d2223@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729527612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7Sv5Ysy21jiCa6yv6D941X9HeEhprlo/fgvoMNFimE=;
	b=jFtZ20pQxKcKdp1n/v3L0rkfx/3DqoKBwgDn7cFBfS5fUcKoTOGwJHu6zIZ+9EWt/1+DSA
	MkeLYHzhV/kTjfyv7Dwx32+UK0M9M5QCPUUlfFJcC3I7vYFkRWoFYIQ2ZVaz3iHDN1rAlu
	Z6bIq2dQTjN1r5xr89AXbjW7kQN5CNw=
Date: Mon, 21 Oct 2024 09:19:57 -0700
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
 <2b304d79-80a7-4366-8267-7e3d724f6e86@linux.dev> <ZxYvkmP39zbCUGwd@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZxYvkmP39zbCUGwd@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/21/24 3:40 AM, Jiri Olsa wrote:
> On Sun, Oct 20, 2024 at 09:32:38PM -0700, Yonghong Song wrote:
>> On 10/20/24 2:59 PM, Jiri Olsa wrote:
>>> On Sun, Oct 20, 2024 at 12:14:31PM -0700, Yonghong Song wrote:
>>>
>>> SNIP
>>>
>>>> +__naked __noinline __used
>>>> +static unsigned long loop_callback(void)
>>>> +{
>>>> +	asm volatile (
>>>> +	"call %[bpf_get_prandom_u32];"
>>>> +	"r1 = 42;"
>>>> +	"*(u64 *)(r10 - 512) = r1;"
>>>> +	"call cumulative_stack_depth_subprog;"
>>>> +	"r0 = 0;"
>>>> +	"exit;"
>>>> +	:
>>>> +	: __imm(bpf_get_prandom_u32)
>>>> +	: __clobber_common);
>>>> +}
>>>> +
>>>> +SEC("raw_tp")
>>>> +__description("Private stack, callback")
>>>> +__success
>>>> +__arch_x86_64
>>>> +/* for func loop_callback */
>>>> +__jited("func #1")
>>>> +__jited("	endbr64")
>>> this should fail if CONFIG_X86_KERNEL_IBT is not enabled, right?
>>>
>>> hm, but I can see that also in other tests, so I guess it's fine,
>>> should we add it to config.x86_64 ?
>> The CI has CONFIG_X86_KERNEL_IBT as well.
>>
>> I checked x86 kconfig, I see
>>
>> config CC_HAS_IBT
>>          # GCC >= 9 and binutils >= 2.29
>>          # Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
>>          # Clang/LLVM >= 14
>>          # https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d7f6aac00e0f
>>          # https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934a37c1f35332
>>          def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch -mindirect-branch-register)) || \
>>                    (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
>>                    $(as-instr,endbr64)
>>
>> config X86_KERNEL_IBT
>>          prompt "Indirect Branch Tracking"
>>          def_bool y
>>          depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
>>          # https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
>>          depends on !LD_IS_LLD || LLD_VERSION >= 140000
>>          select OBJTOOL
>>          select X86_CET
>>          help
>>            Build the kernel with support for Indirect Branch Tracking, a
>>            hardware support course-grain forward-edge Control Flow Integrity
>>            protection. It enforces that all indirect calls must land on
>>            an ENDBR instruction, as such, the compiler will instrument the
>>            code with them to make this happen.
>>            In addition to building the kernel with IBT, seal all functions that
>>            are not indirect call targets, avoiding them ever becoming one.
>>            This requires LTO like objtool runs and will slow down the build. It
>>            does significantly reduce the number of ENDBR instructions in the
>>            kernel image.
>>
>> So CONFIG_X86_KERNEL_IBT will be enabled if clang >= version_14 or newer gcc.
> IIUC it's just dependency, no? doesn't mean it'll get enabled automatically
>
>> In my system, the gcc version is 13.1. So there is no need to explicitly add
>> CONFIG_X86_KERNEL_IBT to the selftests/bpf/config.x86_64 file.
> I had to enable it manualy for gcc 13.3.1

IIUC, the ci config is generated based on config + config.x86_64 + config.vm
in tools/testing/selftests/bpf directory.

In my case .config is generated from config + config.x86_64 + config.vm
With my local gcc 11.5, I did
    make olddefconfig
and I see CONFIG_X86_KERNEL_IBT=y is set.

Maybe your base config is a little bit different from what ci used.
My local config is based on ci config + some more e.g. enabling KASAN etc.

Could you debug a little more on why CONFIG_X86_KERNEL_IBT not enabled
by default in your case? For

config X86_KERNEL_IBT
         prompt "Indirect Branch Tracking"
         def_bool y
         depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
         # https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
         depends on !LD_IS_LLD || LLD_VERSION >= 140000
         select OBJTOOL
         select X86_CET

default is 'y' so if all dependencies are met, CONFIG_X86_KERNEL_IBT
is supposed to be on by default.

>
> jirka

