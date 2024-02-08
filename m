Return-Path: <bpf+bounces-21469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8584D7A5
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DD21C23960
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34071D6AA;
	Thu,  8 Feb 2024 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g0T60TH7"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1D11737
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356678; cv=none; b=m3956GJ0WAwyp6feU2pVqRltsRPVz1nYF0yIGKCv/2W21OwE0tVVzIXfX89S3n/guYEMeOVdl8oxKwk2y7DGQUuQFtzrbJDU/pZjgY7gwwLuyqO+JhP9sSi+dCrdM+X6NDuJTCUFrQ8v5CWGo7L2KJKKcgbZEDJE1O2sTAtLwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356678; c=relaxed/simple;
	bh=oekdPKENXN4/CNuq/BgxIiQRCeMhcTW4imcOwWaOCnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T74P6i6zX+bR0HbcgnDxtHRr2qJKBT6NL/eb5m9sMkkawEUx+gqwBKpySBOAPwf4el3os7haFHx4iW0Frk3i0vbk57sklJKUWTcXr/YAOwUtG8L6AJ5PQwDWb87EEGGuMbdZN3rR+7i0gTx+JvlDiZzj4rt2UBybp7CFjjjuh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g0T60TH7; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <885e39ab-603f-42c9-87e2-d8aa390621a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707356673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7GKzA6ZW4J7/3Tre85hXMYLe3DIr1GjeACZL2adihnI=;
	b=g0T60TH7Noe5PR9kYCVg40Jfd/YwsrXlk5HdiNWmK40r7Ul6ED+Ql96oklmnlvWy0O5sQ7
	HU/DYDXhgMpxhFA4rQJsA0HJm7LpNSOTDzc1qCExMxqC+UC+wsh20CKyzJ5AUJY+GRBzou
	QylgPYORKcPVAu4zp1JjwbMP+/vcMOA=
Date: Wed, 7 Feb 2024 17:43:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test
 verif_scale_strobemeta_subprogs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240206063010.1352503-1-yonghong.song@linux.dev>
 <CAEf4Bzbg7Yzt7JdVWSPKnC6O3nhtOB6MqyfW5LOxqA+g6PStDA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzbg7Yzt7JdVWSPKnC6O3nhtOB6MqyfW5LOxqA+g6PStDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/7/24 4:10 PM, Andrii Nakryiko wrote:
> On Mon, Feb 5, 2024 at 10:30 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest llvm19, I hit the following selftest failures with
>>
>>    $ ./test_progs -j
>>    libbpf: prog 'on_event': BPF program load failed: Permission denied
>>    libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>>    combined stack size of 4 calls is 544. Too large
>>    verification time 1344153 usec
>>    stack depth 24+440+0+32
>>    processed 51008 insns (limit 1000000) max_states_per_insn 19 total_states 1467 peak_states 303 mark_read 146
>>    -- END PROG LOAD LOG --
>>    libbpf: prog 'on_event': failed to load: -13
>>    libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
>>    scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
>>    #498     verif_scale_strobemeta_subprogs:FAIL
>>
>> The verifier complains too big of the combined stack size (544 bytes) which
>> exceeds the maximum stack limit 512. This is a regression from llvm19 ([1]).
>>
>> In the above error log, the original stack depth is 24+440+0+32.
>> To satisfy interpreter's need, in verifier the stack depth is adjusted to
>> 32+448+32+32=544 which exceeds 512, hence the error. The same adjusted
>> stack size is also used for jit case.
>>
>> But the jitted codes could use smaller stack size.
>>
>>    $ egrep -r stack_depth | grep round_up
>>    arm64/net/bpf_jit_comp.c:       ctx->stack_size = round_up(prog->aux->stack_depth, 16);
>>    loongarch/net/bpf_jit.c:        bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
>>    powerpc/net/bpf_jit_comp.c:     cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
>>    riscv/net/bpf_jit_comp32.c:             round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
>>    riscv/net/bpf_jit_comp64.c:     bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
>>    s390/net/bpf_jit_comp.c:        u32 stack_depth = round_up(fp->aux->stack_depth, 8);
>>    sparc/net/bpf_jit_comp_64.c:            stack_needed += round_up(stack_depth, 16);
>>    x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>>    x86/net/bpf_jit_comp.c: int tcc_off = -4 - round_up(stack_depth, 8);
>>    x86/net/bpf_jit_comp.c:                     round_up(stack_depth, 8));
>>    x86/net/bpf_jit_comp.c: int tcc_off = -4 - round_up(stack_depth, 8);
>>    x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
>>
>> In the above, STACK_ALIGN in riscv/net/bpf_jit_comp32.c is defined as 16.
>> So stack is aligned in either 8 or 16, x86/s390 having 8-byte stack alignment and
>> the rest having 16-byte alignment.
>>
>> This patch calculates total stack depth based on 16-byte alignment if jit is requested.
>> For the above failing case, the new stack size will be 32+448+0+32=512 and no verification
>> failure. llvm19 regression will be discussed separately in llvm upstream.
>>
>>    [1] https://lore.kernel.org/bpf/32bde0f0-1881-46c9-931a-673be566c61d@linux.dev/
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Seems like a few selftests have to be adjusted, current BPF CI is unhappy ([0])
>
>    [0] https://github.com/kernel-patches/bpf/actions/runs/7795686155/job/21259132248
>
> pw-bot: cr

Thanks for reminder! Will take a look soon.

>
>>   kernel/bpf/verifier.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ddaf09db1175..10e33d49ca21 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5812,6 +5812,17 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
>>                                             strict);
>>   }
>>
>> +static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>> +{
>> +       if (env->prog->jit_requested)
>> +               return round_up(stack_depth, 16);
>> +
>> +       /* round up to 32-bytes, since this is granularity
>> +        * of interpreter stack size
>> +        */
>> +       return round_up(max_t(u32, stack_depth, 1), 32);
>> +}
>> +
[...]

