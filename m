Return-Path: <bpf+bounces-21886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E0D853C32
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911FE1F250CE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7204260B94;
	Tue, 13 Feb 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rMvb+u4i"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6981097D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855996; cv=none; b=SeCypgA+VQ1uwWfole0UX1zgLXggcOqBytsWCLsxWWF3wnCXL9WrvoZTpydTTUBPy+VieT2Et6zbRydJ9/UIdZhWn60+uNn2MInhjRzKSy3sHGdNr/C1tAXRZVQXwN0tFlU3x12XOsnJ7SfcXvy7jtLm49cPRABlS4wU2220Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855996; c=relaxed/simple;
	bh=si/sxDFfOsGui4LjZdL8LeEDzzuqxI2ju3rnUtzTXX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGxZNAnDvhjlykbn8Qd+9afJIFlO37IzWoUYfRPa7T0j3E07rh0SgjJ03jggWCKEURxnhkVvAc6n1x3UAXgL2MoiRe4q9QZkpmywp0z3NHD1NWOPVEK3ja08HHG8Idxw3xNFjJubL6FdkxQjxCMacq8zaH0IWll2HhouZRR3kjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rMvb+u4i; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d431099d-ca04-484b-a3ab-f9423293c51b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707855992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBu31IcAsVFUWYZ5kO1DNg3TlSujL94pzCUg2k9/1NU=;
	b=rMvb+u4imYvWMyYt6s5aOiJHLloAXN8vk746X95IyrubehZZ8tgPWHgRhvhVUKRe3H/WNJ
	rlTkur6tV6S8fWkohVbPGipcSjSo3lHXcrilpnYsbUd2QQRpUsKSHS5J8Dakg//8fnKWYP
	LMx5pRlrSmPASOpHWfxVm6E2Uq7lEcg=
Date: Tue, 13 Feb 2024 12:26:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix test
 verif_scale_strobemeta_subprogs failure due to llvm19
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240208215422.110920-1-yonghong.song@linux.dev>
 <CAEf4Bza9Z8v5ATLv0jctbP1rmQ0QOcWr6JHh4903cBW77GF0nQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza9Z8v5ATLv0jctbP1rmQ0QOcWr6JHh4903cBW77GF0nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/13/24 11:21 AM, Andrii Nakryiko wrote:
> On Thu, Feb 8, 2024 at 1:54 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>    - test_global_funcs/global_func1: adjusted to interpreter only since verification will
>>      succeed in jit mode. A new test will be added for jit mode later.
>>    - async_stack_depth/{pseudo_call_check, async_call_root_check}: since jit and interpreter
>>      will calculate different stack sizes, the failure msg is adjusted to omit those
>>      specific stack size numbers.
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
>> Changelogs:
>>    v2 -> v3:
>>      - fix async_stack_depth test failure if jit is turned off
>>    v1 -> v2:
>>      - fix some selftest failures
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
> Can we increase the amount of used stack size to make it fail
> regardless of JIT? That's what I was asking on v1, actually. We have
> those arbitrarily sized buf[256] and buf[300], what prevents us from
> making them a few bytes bigger to not be affected by 16 vs 32 byte
> rounding?

Yes, we can do this. Will do it in v4.

>
>
>> +
>>          RUN_TESTS(test_global_func2);
>>          RUN_TESTS(test_global_func3);
>>          RUN_TESTS(test_global_func4);
>> diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
>> index 3517c0e01206..36734683acbd 100644
>> --- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
>> +++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
>> @@ -30,7 +30,7 @@ static int bad_timer_cb(void *map, int *key, struct bpf_timer *timer)
>>   }
>>
>>   SEC("tc")
>> -__failure __msg("combined stack size of 2 calls is 576. Too large")
>> +__failure __msg("combined stack size of 2 calls is")
>>   int pseudo_call_check(struct __sk_buff *ctx)
>>   {
>>          struct hmap_elem *elem;
>> @@ -45,7 +45,7 @@ int pseudo_call_check(struct __sk_buff *ctx)
>>   }
>>
>>   SEC("tc")
>> -__failure __msg("combined stack size of 2 calls is 608. Too large")
>> +__failure __msg("combined stack size of 2 calls is")
>>   int async_call_root_check(struct __sk_buff *ctx)
>>   {
>>          struct hmap_elem *elem;
>> --
>> 2.39.3
>>

