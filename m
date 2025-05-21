Return-Path: <bpf+bounces-58680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C6ABFE8F
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA3D170D88
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B628FAB2;
	Wed, 21 May 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rWosZUkF"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018A1A5B86
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861086; cv=none; b=SYZrWi0lTw90DEBk7V/VH5GoSVQf4ctVOdhpfSIAa1XXT8z3T3da9aHNhswlQSc4HxLQO8xF8xMPgKSYJkv/JxeaSitLGnkvMqCO7k9uey58xaoH39GzabLDdrw3i8xDscLdEnxCrwu2PmvbmAFLP1NfKjsHXjtAEIC1gsSSW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861086; c=relaxed/simple;
	bh=+9xJTd7U/z55I4S/zIWr//NBvKxNR3dAo9cDHltmqCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuEnDh17Hjx8tobNRem1kI0oDCZfkCZQmf6eR4KtpG2+OaBv+9suYPYBzSQ9rbKjoN3zr9NXeLXwMgvJNVr2GRq390rHBBy1/2/HTE0Jy2Q+IAUh6utgU7ZNRTj2zrKSy7MS4XiameENyxWxzVEnsMV7AdBNY5tgZ7JDlfFTy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rWosZUkF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5761ffe9-fc09-4f06-9311-0eed40a693fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747861080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDRV/tImM8rqlS9bKNuQqX5OXFxwDKDT+FJgK8TDF1E=;
	b=rWosZUkF0h4YUJoF9Y1t1Gz865p89XJcr+IorzS2Q1ZCgDSp1ogP+M00P1LjICAOLCeFGY
	lH3olfcM4SA0wOv3EcWnV0uvynC2JEDpmbcZY0N48NZ/BjzB2eJlZrje5h33xYDoPMmssC
	6b8ojZoOKUTFM7f8OS2FxjH7hSldZHc=
Date: Wed, 21 May 2025 13:57:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <20250521170414.2773034-1-yonghong.song@linux.dev>
 <6dd9752a-4bec-423d-8936-8757251f2b50@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6dd9752a-4bec-423d-8936-8757251f2b50@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/21/25 12:02 PM, Eduard Zingerman wrote:
>
> On 2025-05-21 10:04, Yonghong Song wrote:
>
> [...]
>
>> @@ -178,4 +178,57 @@ __naked int state_loop_first_last_equal(void)
>>       );
>>   }
>>   +__used __naked static void __bpf_cond_op_r10(void)
>> +{
>> +    asm volatile (
>> +    "r2 = 2314885393468386424 ll;"
>> +    "goto +0;"
>> +    "if r2 <= r10 goto +3;"
>> +    "if r1 >= -1835016 goto +0;"
>> +    "if r2 <= 8 goto +0;"
>> +    "if r3 <= 0 goto +0;"
>> +    "exit;"
>> +    ::: __clobber_all);
>> +}
>> +
>> +SEC("?raw_tp")
>> +__success __log_level(2)
>> +__msg("8: (bd) if r2 <= r10 goto pc+3")
>> +__msg("9: (35) if r1 >= 0xffe3fff8 goto pc+0")
>> +__msg("10: (b5) if r2 <= 0x8 goto pc+0")
>> +__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
>> +__msg("mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 
>> 0xffe3fff8 goto pc+0")
>> +__msg("mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= 
>> r10 goto pc+3")
>> +__msg("mark_precise: frame1: regs=r2 stack= before 7: (05) goto pc+0")
>> +__naked void bpf_cond_op_r10(void)
>> +{
>> +    asm volatile (
>> +    "r3 = 0 ll;"
>> +    "call __bpf_cond_op_r10;"
>> +    "r0 = 0;"
>> +    "exit;"
>> +    ::: __clobber_all);
>> +}
>
> This was probably a part of the repro, but I'm not sure
> this test adds much compared to test below.
> The changes do not interact with subprogram calls handling.

It does not interact with subprogram due the patch 1. Without patch 1,
the error will happen (see commit message of patch 1):

   0: (18) r3 = 0x0                      ; R3_w=0
   2: (85) call pc+2
   caller:
    R10=fp0
   callee:
    frame1: R1=ctx() R3_w=0 R10=fp0
   5: frame1: R1=ctx() R3_w=0 R10=fp0
   ; asm volatile ("                                 \ @ verifier_precision.c:184
   5: (18) r2 = 0x20202000256c6c78       ; frame1: R2_w=0x20202000256c6c78
   7: (05) goto pc+0
   8: (bd) if r2 <= r10 goto pc+3        ; frame1: R2_w=0x20202000256c6c78 R10=fp0
   9: (35) if r1 >= 0xffe3fff8 goto pc+0         ; frame1: R1=ctx()
   10: (b5) if r2 <= 0x8 goto pc+0
   mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
   mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0
   mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3
   mark_precise: frame1: regs=r2,r10 stack= before 7: (05) goto pc+0
   mark_precise: frame1: regs=r2,r10 stack= before 5: (18) r2 = 0x20202000256c6c78
   mark_precise: frame1: regs=r10 stack= before 2: (85) call pc+2
   BUG regs 400

>
>> +
>> +SEC("?raw_tp")
>> +__success __log_level(2)
>> +__msg("3: (bf) r3 = r10")
>> +__msg("4: (bd) if r3 <= r2 goto pc+1")
>> +__msg("5: (b5) if r2 <= 0x8 goto pc+2")
>> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
>> +__msg("mark_precise: frame0: regs=r2 stack= before 4: (bd) if r3 <= 
>> r2 goto pc+1")
>> +__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
>> +__naked void bpf_cond_op_not_r10(void)
>> +{
>> +    asm volatile (
>> +    "r0 = 0;"
>> +    "r2 = 2314885393468386424 ll;"
>> +    "r3 = r10;"
>> +    "if r3 <= r2 goto +1;"
>> +    "if r2 <= 8 goto +2;"
>
> I think it would be good to add two more cases here:
> - dst register is pointer to stack

The previous test "r2 <= r10" should already cover this since r10 is a pointer to stack.

> - both src and dst registers are pointers to stack

I actually thought about this as well, e.g.,
    r2 = r10
    r3 = r10
    if r2 <= r3 goto +0
    if r2 <= 8 goto +0

But since r2 is actually a stack pointer, then r2 does not need
backtracking. So r2 <= r3 won't be backtracked too.

But if you feel such an example still valuable, I can add it too.

>
>> +    "r0 = 2 ll;"
>> +    "exit;"
>> +    ::: __clobber_all);
>> +}
>> +
>>   char _license[] SEC("license") = "GPL";


