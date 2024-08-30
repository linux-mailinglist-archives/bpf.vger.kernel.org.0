Return-Path: <bpf+bounces-38551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D470796615B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765312887C2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A3199952;
	Fri, 30 Aug 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIhr7AGG"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A9192D79
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019883; cv=none; b=SD+RvHMkhgYEyC8ZbMv7pJWYFqIY6g0SeGuknqKO3REAWY7O3kZ2MwIDCFy44oXM71d6ErNmhGp9lQRouX6EoWCOKIUmbf3nKg1Vvq/4MTNq0M0IyZnAbrmlB3WOmYAJZpFg6MfZ2Jb62cnf6V4Wk4YS+mkhxytbCSSdq9s/pKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019883; c=relaxed/simple;
	bh=rjkfd59zN6e7FWLZoPyTPJG3ZKhJX45kgRXciqKbvAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwfgTvmlLhAOV4AvuqF+gqvBnXF6W3mJ3FVvbpk7QApvqeOfgePuxItJiMi8FHCm8HVESQ6AZH+h2n4GWKwL1DM7bmZlmRF7UhY2rEcDdX21mWFR7236u0UoJ29YBrUL4DA4qC2B3PA3wgztAOcwW09b2ZVjQOWKsJvPpNVkZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIhr7AGG; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e74d96a-fb74-4ec7-8f9e-185fc39449ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725019878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7b9zz0PU8dm/vMOhTCugWIxDw45z8SAlmBvVRm5TDI=;
	b=qIhr7AGGn1EUqupUZwARQ/aH3NSGy0n1eY0ftMwskXknFMg3rYFpjYv+9u32h881OIiQfP
	PZ7+/KLufLRgLWGkoUTsgiBcfU/AS0nvBOezOZEQw4AjGqX4QXkEiNUtAMO7b2VT6qD1gS
	2JjoLoQy606/smlKTe7A9uUOLrClDdE=
Date: Fri, 30 Aug 2024 20:11:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
 <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
 <9968457f-f4c2-42a1-b45d-44bdf745497e@linux.dev>
 <d9d5cf5d-5137-484c-8c87-0853072385b7@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <d9d5cf5d-5137-484c-8c87-0853072385b7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/30 18:00, Xu Kuohai wrote:
> On 8/30/2024 5:08 PM, Leon Hwang wrote:
>>
>>
>> On 30/8/24 15:37, Xu Kuohai wrote:
>>> On 8/27/2024 10:23 AM, Leon Hwang wrote:
>>>>
>>

[...]

>>
>> This approach is really cool!
>>
>> I want an alike approach on x86. But I failed. Because, on x86, it's an
>> indirect call to "call *rdx", aka "bpf_func(ctx, insnsi)".
>>
>> Let us imagine the arch_run_bpf() on x86:
>>
>> unsigned int __naked arch_run_bpf(const void *ctx, const struct bpf_insn
>> *insnsi, bpf_func_t bpf_func)
>> {
>>     asm (
>>         "pushq %rbp\n\t"
>>         "movq %rsp, %rbp\n\t"
>>         "xor %rax, %rax\n\t"
>>         "pushq %rax\n\t"
>>         "movq %rsp, %rax\n\t"
>>         "callq *%rdx\n\t"
>>         "leave\n\t"
>>         "ret\n\t"
>>     );
>> }
>>
>> If we can change "callq *%rdx" to a direct call, it'll be really
>> wonderful to resolve this tailcall issue on x86.
>>
> 
> Right, so we need static call here, perhaps we can create a custom
> static call trampoline to setup tail call counter.
> 
>> How to introduce arch_bpf_run() for all JIT backends?
>>
> 
> Seems we can not avoid arch specific code. One approach could be
> to define a default __weak function to call bpf_func directly,
> and let each arch to provide its own overridden implementation.
> 

Hi Xu Kuohai,

Can you send a separate patch to fix this issue on arm64?

After you fixing it, I'll send the patch to fix it on x64.

Thanks,
Leon

