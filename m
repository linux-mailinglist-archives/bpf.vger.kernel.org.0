Return-Path: <bpf+bounces-21530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD484E8B5
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975651F2FAB4
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057542577E;
	Thu,  8 Feb 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i/dvFLfW"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4E25765
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419266; cv=none; b=u5r1nyR4yZpT2W8SZtqhffT2Ct/AMvSCbP4kh2Yx6xpIfen6JKn4K7tTvOg6RicekGIBrk+X3JSSbdLmGYGQj8odJFjXroV+cvyDOTpBiNGkdRtfSsHyv7b1OaDVs9OWfx8OOWjS2yBlaicMe+XcZDww9qr1a9QZscbtAGep+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419266; c=relaxed/simple;
	bh=R4J4xcCmVHDelDa9M1sbr0PncLiAOX9cID4iYefmz5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7sLzGDhraeCjXuTD58T8chDwDstZmveoJyBvfXELDopOo5XY6IiTaBOUQbObf6xhlKoQn/V7nyAGOm4AEILc3rwNVpu8jBuv/JWzP96ApgxEOZzOXuoCuTHCoe7Et3SJtX4j1s209YworPqKLDaO7VBjZI/75FspF6t++Iena4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i/dvFLfW; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <30b4ade5-2874-4389-8eea-77f4122873b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707419262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlWxgwJm5dZOail0LetA+31JDFK7s+qFhmDpecu4lF4=;
	b=i/dvFLfWLkvUkdrK2fRtrCQv4HDaiBeuFIgvZAlck6dXI1rSemzEHyFLaIl56w8z3b6wg6
	7QFpWgfOiieFbMO+hhuNDY4CAqOxbZv1AoAYCgkCUM4I0j8VqrzOoI6qaVBa12kbTwdAgw
	bKwG4FUEsBcK2E5VoS0mJfsFfEa0ppI=
Date: Thu, 8 Feb 2024 11:07:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix test
 verif_scale_strobemeta_subprogs failure due to llvm19
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240208063015.3893418-1-yonghong.song@linux.dev>
 <CAEf4BzbV6oEn80DyNwHqz6SH=zE1M5fXSako4x_O-N8O7PV+1A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbV6oEn80DyNwHqz6SH=zE1M5fXSako4x_O-N8O7PV+1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 10:14 AM, Andrii Nakryiko wrote:
> On Wed, Feb 7, 2024 at 10:30 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>> The verifier change caused three test failures as these tests compared messages
>> with stack size. More specifically,
>>    - test_global_funcs/global_func1, adjusted to interpreter only since verification will
>>      succeed in jit mode. A new test will be added for jit mode later.
>>    - async_stack_depth/{pseudo_call_check, async_call_root_check}, adjusted based on
>>      new stack size calculation.
>>
>>    [1] https://lore.kernel.org/bpf/32bde0f0-1881-46c9-931a-673be566c61d@linux.dev/
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c                          | 18 +++++++++++++-----
>>   .../bpf/prog_tests/test_global_funcs.c         |  5 ++++-
>>   .../selftests/bpf/progs/async_stack_depth.c    |  4 ++--
>>   3 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ddaf09db1175..6441a540904b 100644
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
>>   /* starting from main bpf function walk all instructions of the function
>>    * and recursively walk all callees that given function can call.
>>    * Ignore jump and exit insns.
>> @@ -5855,10 +5866,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>                          depth);
>>                  return -EACCES;
>>          }
>> -       /* round up to 32-bytes, since this is granularity
>> -        * of interpreter stack size
>> -        */
>> -       depth += round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
>> +       depth += round_up_stack_depth(env, subprog[idx].stack_depth);
>>          if (depth > MAX_BPF_STACK) {
>>                  verbose(env, "combined stack size of %d calls is %d. Too large\n",
>>                          frame + 1, depth);
>> @@ -5952,7 +5960,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>           */
>>          if (frame == 0)
>>                  return 0;
>> -       depth -= round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
>> +       depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
>>          frame--;
>>          i = ret_insn[frame];
>>          idx = ret_prog[frame];
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>> index e905cbaf6b3d..a3a41680b38e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>> @@ -138,7 +138,10 @@ static void subtest_ctx_arg_rewrite(void)
>>
>>   void test_test_global_funcs(void)
>>   {
>> -       RUN_TESTS(test_global_func1);
>> +       if (!env.jit_enabled) {
>> +               RUN_TESTS(test_global_func1);
>> +       }
>> +
>>          RUN_TESTS(test_global_func2);
>>          RUN_TESTS(test_global_func3);
>>          RUN_TESTS(test_global_func4);
>> diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
>> index 3517c0e01206..a03f313b7482 100644
>> --- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
>> +++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
>> @@ -30,7 +30,7 @@ static int bad_timer_cb(void *map, int *key, struct bpf_timer *timer)
>>   }
>>
>>   SEC("tc")
>> -__failure __msg("combined stack size of 2 calls is 576. Too large")
>> +__failure __msg("combined stack size of 2 calls is 544. Too large")
> maybe it's better to adjust existing test to fail in both JIT and !JIT
> modes, just not expect exact size in message. I.e., truncate the
> message to just "combined stack size of 2 calls is") and be done with
> it?

Originally I did not add support for no-jit since interpreter does not
support callback functions, so we have smaller combined stack size, jit mode
will succeed and interpreter mode will fail.

But in this particular case, verifier will fail before jit is involved.
So for no-jit mode, verifier will still emit an error complaining the stack
size.

Will do what you suggested in the next version.

>
>>   int pseudo_call_check(struct __sk_buff *ctx)
>>   {
>>          struct hmap_elem *elem;
>> @@ -45,7 +45,7 @@ int pseudo_call_check(struct __sk_buff *ctx)
>>   }
>>
>>   SEC("tc")
>> -__failure __msg("combined stack size of 2 calls is 608. Too large")
>> +__failure __msg("combined stack size of 2 calls is 576. Too large")
>>   int async_call_root_check(struct __sk_buff *ctx)
>>   {
>>          struct hmap_elem *elem;
>> --
>> 2.39.3
>>

