Return-Path: <bpf+bounces-43563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517A9B6716
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968361C215B9
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75569213ED8;
	Wed, 30 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NfxFTV52"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AC2139DB
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301200; cv=none; b=tWlK25eYRQ+zKqCEP9qkOrBLnLeAMOmmPayE9sNMBtDibdYUV/2v9/z2Nj6L+wVrfacbnI92+hfc1wwxm+ta7c0lEsZ33w2dnUX8ERSUfYkqk36Cj8Gu704gqsSuXhMgEpWG6A4ubm0tfP7BXGXsgErZenXzYH8tYj0kPxbz/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301200; c=relaxed/simple;
	bh=kSCuosMoh/EsryNx/qxA9cuEFFgOU5QXVz0U3mGFFr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6i7dYlpy3LTCJU4VI7usXObpsRy63AMuZI4kh2OGLk0Nc/Eheq4UZYM4LS2TjsjrqzIAQPcBJdRh0Y+hthJ28djNwAFR1JYNXDuEQ9OzgleK3lgSzLVkmGXWQrYT99rC/+dM7QK54Q8Q6cfIECZHFGMm0cSJn5Io1NIi3dtGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NfxFTV52; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b3b1af1-3546-4916-9084-3f10b276998b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730301195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyTTItLA9Y+ymZ8Jbqo5EF/79cLtqI4sQc18+msbzxQ=;
	b=NfxFTV52MKtVGPccINtJ31tiSZQToTJaK7s6yWmaitXUI1SUwIxAu/PKIwAC9/FeNjf3zC
	FvC6lwzZ2PbQV4ItDDIdktegAn5XL9UO0vanJ6P+kHR1rml1MM4mJGP2hHHdn2wG15TYEL
	cNtwyQS6z1w+IYUAv63C8u5YdHS/9vY=
Date: Wed, 30 Oct 2024 23:13:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org, qmo@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-patches-bot@fb.com
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
 <e404d1cd-cf40-48dd-8a49-82c03c3b641e@linux.dev> <ZyJJJlt1gvsi2Wu0@mini-arch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <ZyJJJlt1gvsi2Wu0@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/30 22:56, Stanislav Fomichev wrote:
> On 10/30, Leon Hwang wrote:
>>
>>
>> On 2024/10/30 17:47, Leon Hwang wrote:
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
>>
>> It seems we should update the type of pc from int to __u64, as the type
>> of func_ksym is __u64 and the type of pc argument in disassemble
>> function of LLVM and libbfd is __u64 for 64 bit arch.
> 
> I'm assuming u32 is fine as long as the prog size is under 4G?
> 

It works well with int. So it's unnecessary to update its type.

>>>  	char buf[256];
>>>  	int count;
>>>  
> 
> [..]
> 
>>> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
>>> -				      buf, sizeof(buf));
>>> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
> 
> For my understanding, another way to fix it would be:
> 	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, 0,
> 				      buf, sizeof(buf));
> 
> IOW, in the original code, using 0 instead of pc should fix it as well?
> Or am I missing something?

No. It does not work when using 0. I just tried it.

I think it's because LLVM is unable to infer the actual address of the
disassembling insn when we do not provide func_ksym to LLVM.

Thanks,
Leon



