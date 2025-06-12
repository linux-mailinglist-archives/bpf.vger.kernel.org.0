Return-Path: <bpf+bounces-60513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A2AD7B03
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0EC18937EB
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A92D322C;
	Thu, 12 Jun 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WlBCSKTP"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD647263C
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756165; cv=none; b=sVJk1G5Qt7FqFzQInuvPrS2M7jlgJZyoJJWuwHUrltEOFeLHJJZAbiN971FrZUb9pkHO0D7lzaV0gmjrQkDJkOkPfgDywMOMJAtDHsRW6/cQMr0v9Zx05oUTfUGed8z0sOw6kol4x9JKGXC6MpED4Gtg7lCWtJQdU8EN3fu/+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756165; c=relaxed/simple;
	bh=sMGLs4ntiDAX9SSuSGDqbc2s3mXp8MZFv8PJpx5FypA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD8qn4azkmvpvaeNP99jNqgNBju9sIxOvFEpBLh5e6G1HbNNwc5NnYfIdmPcXN0f0g7nv+HFNvpR/o1Muudc2mWFPd++LBFepV11TeZ3x8iSGK0188tDD35AXv8NBRnd14TOnYIwqq2bVR2MWr3ClYZ71Pr3T5emMW/MA32LAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WlBCSKTP; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40f68a53-a358-41a3-8cf4-cb0d61d43842@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749756160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ufg4wIx98iW4eFIlHDEGkNLJscHA19UuEiGZJqMAwr8=;
	b=WlBCSKTP7oXieCdTo97ru0898xfj2PRe0civCf46C18iEVgaxU/WvFKYijknYCNsgjLUC0
	gHnE76S0HOkrC9a0xnTY2njwkJqBXnhr8toPCOPju+rCPkEKwZO/NWlUwnb8jK5KOatS6T
	91G4lMTsqF/6AVYNGNPy2CArY/TvxPE=
Date: Thu, 12 Jun 2025 12:22:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/12/25 12:10 PM, Eduard Zingerman wrote:
> On Thu, 2025-06-12 at 10:19 -0700, Yonghong Song wrote:
>> In one of upstream thread ([1]), there is a discussion about
>> the below inline asm code:
>>
>>    if r1 == 0xdeadbeef goto +2;
>>    ...
>>
>> In actual llvm backend, the above 0xdeadbeef will actually do
>> sign extension to 64bit value and then compare to register r1.
>>
>> But the code itself does not imply the above semantics. It looks
>> like the comparision is between r1 and 0xdeadbeef. For example,
>> let us at a simple C code:
>>    $ cat t1.c
>>    int foo(long a) { return a == 0xdeadbeef ? 2 : 3; }
>>    $ clang --target=bpf -O2 -c t1.c && llvm-objdump -d t1.o
>>      ...
>>      w0 = 0x2
>>      r2 = 0xdeadbeef ll
>>      if r1 == r2 goto +0x1
>>      w0 = 0x3
>>      exit
>> It does try to compare r1 and 0xdeadbeef.
>>
>> To address the above confusing inline asm issue, llvm backend ([2])
>> added some range checking for such insns and beyond. For the above
>> insn asm, the warning like below
>>    warning: immediate out of range, shall fit in int range
>> will be issued. If -Werror is in the compilation flags, the
>> error will be issued.
>>
>> To avoid the above warning/error, the afore-mentioned inline asm
>> should be rewritten to
>>
>>    if r1 == -559038737 goto +2;
>>    ...
>>
>> Fix a few selftest cases like the above based on insn range checking
>> requirement in [2].
>>
>>    [1] https://lore.kernel.org/bpf/70affb12-327b-4882-bd1d-afda8b8c6f56@linux.dev/
>>    [2] https://github.com/llvm/llvm-project/pull/142989
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Changes like 0xffffffff -> -1 and 0xfffffffe -> -2 look fine,
> but changes like 0xffff1234 -> -60876 are an unnecessary obfuscation,
> maybe we need to reconsider.

Another option is to generate below in inline asm:
     r2 = 0xffffFFFFffff1234  /* or r2 = 0xffff1234, depending on the actual user expectation */
     if (r1 == r2) ...

>
> [...]


