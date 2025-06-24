Return-Path: <bpf+bounces-61434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82876AE7091
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929F717D150
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A42EA47E;
	Tue, 24 Jun 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lppntoBU"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362E2ECE90
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796544; cv=none; b=KT4d/aLviIMzlr7klHlxxSeXtXUv+8qXz9hbyC2tOxTwUIZjM4NLn4jMD6o277jEbjYxHg9f27bq8Q98um40DNOWAwU7Fw4ujeqdJ2/bB2DGoynkcJA2gbLbtab1RTB2Hnwmak7/RaMDQWuISIlf2Tqg4ISOatUE3Gp6NkY0QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796544; c=relaxed/simple;
	bh=5aeTYn38xPzmNtHuBE+YF15atT6dfILgV6/W6ZR2CQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb6jdeq8fNdFxJ6zzz1G68y1k2ToM/nTALJ5TakkGsHB74ZqW9qDWJPjWhNnyXGr7CBNTO6Tful4e3vrvyvcqOFmWNuaUpE2Dx2brJHGe5NnbRttBg0fPEG1zDVH228sNTUbxYWDCKQuH/07LjPdsofqUN5A/aOpBN9Waot1xog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lppntoBU; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b51556ac-801a-4908-89a8-8432dd27cbe7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750796539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWqIFKeKBbLICEmFllS7sh1w6Qy/bhj6u6ElHK/ShfU=;
	b=lppntoBU0iFnaU6l6dDDOYxX3n4ioHuzNGC0B+iE++dPb3oL6qByHeCUhe2ftiDNoGvaFi
	UFeBi01FDN78bgY67H5EpeMGj0Ujc+bwOSOlSFdbS/BrBWwGbX5lnYDTs0YxO5yrK13iLK
	SYG1/W4r8knOddztwHobOyoAJxuHKy4=
Date: Tue, 24 Jun 2025 13:21:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed
 assertion to another subtest
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
 <20250615185351.2757391-1-yonghong.song@linux.dev>
 <CAEf4BzZmzrT7+nB0eyK-iLv+un68VtLY-TAq3G5Pti=sjM41TQ@mail.gmail.com>
 <b3ce39f0-c52b-4787-980c-973bd4228349@linux.dev>
 <CAEf4BzbWqj9a7zrocg5pLDKTG9aJgRK61=SFLzH=ANtAAs_bLA@mail.gmail.com>
 <cc78ac6b-6f87-4d85-ac3e-36bb06fdd3e3@linux.dev>
 <CAEf4BzanoB1D0s+9Tw8Pt0L_dsMUm92_H1cRi0yhkEe1JzWkHw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzanoB1D0s+9Tw8Pt0L_dsMUm92_H1cRi0yhkEe1JzWkHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/24/25 12:48 PM, Andrii Nakryiko wrote:
> On Tue, Jun 24, 2025 at 9:15 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 6/24/25 8:36 AM, Andrii Nakryiko wrote:
>>> On Tue, Jun 17, 2025 at 9:36 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>
>>>> On 6/16/25 3:00 PM, Andrii Nakryiko wrote:
>>>>> On Sun, Jun 15, 2025 at 11:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>>> When building the selftest with arm64/clang20, the following test failed:
>>>>>>        ...
>>>>>>        ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
>>>>>>        subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
>>>>>>        subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xaaaad82a2a80
>>>>>>        #469/2   usdt/multispec:FAIL
>>>>>>        #469     usdt:FAIL
>>>>>>
>>>>>> The failed assertion
>>>>>>        subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xaaaad82a2a80
>>>>>> is caused by bpf_program__attach_usdt() which is expected to fail. But
>>>>>> with arm64/clang20 bpf_program__attach_usdt() actually succeeded.
>>>>> I think I missed that it's unexpected *success* that is causing
>>>>> issues. If that's so, then I think it might be more straightforward to
>>>>> just ensure that test is expectedly failing regardless of compiler
>>>>> code generation logic. Maybe something along the following lines:
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/usdt.c
>>>>> index 495d66414b57..fdd8642cfdff 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
>>>>> @@ -190,11 +190,21 @@ static void __always_inline f300(int x)
>>>>>            STAP_PROBE1(test, usdt_300, x);
>>>>>     }
>>>>>
>>>>> +#define RP10(F, X)  F(*(X+0)); F(*(X+1));F(*(X+2)); F(*(X+3)); F(*(X+4)); \
>>>>> +                   F(*(X+5)); F(*(X+6)); F(*(X+7)); F(*(X+8)); F(*(X+9));
>>>>> +#define RP100(F, X) RP10(F,X+
>>>>> 0);RP10(F,X+10);RP10(F,X+20);RP10(F,X+30);RP10(F,X+40); \
>>>>> +
>>>>> RP10(F,X+50);RP10(F,X+60);RP10(F,X+70);RP10(F,X+80);RP10(F,X+90);
>>>>> +
>>>>>     __weak void trigger_300_usdts(void)
>>>>>     {
>>>>> -       R100(f300, 0);
>>>>> -       R100(f300, 100);
>>>>> -       R100(f300, 200);
>>>>> +       volatile int arr[300], i;
>>>>> +
>>>>> +       for (i = 0; i < 300; i++)
>>>>> +               arr[i] = 300;
>>>>> +
>>>>> +       RP100(f300, arr + 0);
>>>>> +       RP100(f300, arr + 100);
>>>>> +       RP100(f300, arr + 200);
>>>>>     }
>>>>>
>>>>>
>>>>> So basically force the compiler to use 300 different locations for
>>>>> each of 300 USDT instantiations? I didn't check how that will look
>>>>> like on arm64, but on x86 gcc it seems to generate what is expected of
>>>>> it.
>>>>>
>>>>> Can you please try it on arm64 and see if that works?
>>>> I tried the above on arm64 and it does not work. It has the same usdt arguments
>>>> as without this patch:
>>>>
>>>>      stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>>>        Provider: test
>>>>        Name: usdt_300
>>>>        Location: 0x00000000000009e0, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>>>        Arguments: -4@[x9]
>>>>      stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>>>        Provider: test
>>>>        Name: usdt_300
>>>>        Location: 0x00000000000009f8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>>>        Arguments: -4@[x9]
>>>>      ...
>>>>
>>>> But I found if we build usdt.c file with -O2 (RELEASE=1) on arm64, the test will be successful:
>>>>
>>>>      stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe descriptors)
>>>>        Provider: test
>>>>        Name: usdt_300
>>>>        Location: 0x00000000000001a4, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>>>        Arguments: -4@0
>>>>      stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe descriptors)
>>>>        Provider: test
>>>>        Name: usdt_300
>>>>        Location: 0x00000000000001a8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>>>        Arguments: -4@1
>>>>      ...
>>>>
>>>> But usdt.c with -O2 will have a problem with gcc14 on x86:
>>>>
>>>>      stapsdt              0x00000087       NT_STAPSDT (SystemTap probe descriptors)
>>>>        Provider: test
>>>>        Name: usdt12
>>>>        Location: 0x000000000000258f, Base: 0x0000000000000000, Semaphore: 0x0000000000000006
>>>>        Arguments: -4@$2 -4@$3 -8@$42 -8@$44 -4@$5 -8@$6 8@%rdx 8@%rsi -4@$-9 -2@%cx -2@nums(%rax,%rax) -1@t1+4(%rip)
>>>>      ...
>>>>
>>>> You can see the above last two arguments which are not supported by libbpf.
>>>>
>>>> So let us say usdt.c is compiled with -O2:
>>>>       x86:
>>>>         gcc14 built kernel/selftests: failed, see the above
>>>>         clang built kernel/selftests: good
>>>>       arm64:
>>>>         both gcc14/clang built kernel/selftrests: good
>>>>
>>>> arm64 has more reigsters so it is likely to have better argument representation, e.g.,
>>>> for arm64/gcc with -O2, we have
>>>>
>>>>      stapsdt              0x00000071       NT_STAPSDT (SystemTap probe descriptors)
>>>>        Provider: test
>>>>        Name: usdt12
>>>>        Location: 0x0000000000002e74, Base: 0x0000000000000000, Semaphore: 0x000000000000000a
>>>>        Arguments: -4@2 -4@3 -8@42 -8@44 -4@5 -8@6 8@x1 8@x3 -4@-9 -2@x2 -2@[x0, 8] -1@[x3, 28]
>>>>
>>>> Eduard helped me to figure out how to compile prog_tests/usdt.c with -O2 alone.
>>>> The following patch resolved the issue and usdt test will be happy for both x86 and arm64:
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>> index 97013c49920b..05fc9149bc4f 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>> @@ -760,6 +760,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>>>>     TRUNNER_BPF_CFLAGS :=
>>>>     $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>>>>
>>>> +# Compiler prog_tests/usdt.c with -O2 with clang compiler.
>>>> +# Otherwise, with -O0 on arm64, the usdt test will fail.
>>>> +ifneq ($(LLVM),)
>>>> +$(OUTPUT)/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
>>>> +$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
>>>> +$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
>>>> +endif
>>>> +
>>>>     # Define test_verifier test runner.
>>>>     # It is much simpler than test_maps/test_progs and sufficiently different from
>>>>     # them (e.g., test.h is using completely pattern), that it's worth just
>>>>
>>>> Another choice is to support argument like `-2@nums(%rax,%rax)` and `-1@t1+4(%rip)`.
>>>> But I am not sure whether we should do it or not as typically a usdt probe
>>>> probably won't have lots of diverse arguments.
>>>>
>>>> WDYT?
>>> Can we just make that part of the test x86-64 specific for now? All
>>> other alternatives seem worse, tbh.
>> So something like below?
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> index 495d66414b57..1e7e222034f7 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> @@ -270,8 +270,16 @@ static void subtest_multispec_usdt(void)
>>            */
>>           trigger_300_usdts();
>>
>> -       /* we'll reuse usdt_100 BPF program for usdt_300 test */
>>           bpf_link__destroy(skel->links.usdt_100);
>> +
>> +       /* If built with clang with arm64 target, there will be much less
>> +        * number of specs for usdt_300 call sites.
>> +        */
>> +#if defined(__clang__) && defined(__aarch64__)
>> +       bss->usdt_100_called = 0;
>> +       bss->usdt_100_sum = 0;
> I'd add this right before usdt_400 attachment unconditionally and
> avoid #if/#else/#endif branching. But other than that, yeah, something
> like that.

Sounds good to me!

>
>> +#else
>> +       /* we'll reuse usdt_100 BPF program for usdt_300 test */
>>           skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
>>                                                           "test", "usdt_300", NULL);
>>           err = -errno;
>> @@ -289,6 +297,7 @@ static void subtest_multispec_usdt(void)
>>
>>           ASSERT_EQ(bss->usdt_100_called, 0, "usdt_301_called");
>>           ASSERT_EQ(bss->usdt_100_sum, 0, "usdt_301_sum");
>> +#endif
>>
>>           /* This time we have USDT with 400 inlined invocations, but arg specs
>>            * should be the same across all sites, so libbpf will only need to
>>


