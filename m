Return-Path: <bpf+bounces-60891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2CADE29F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 06:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB3217B8C8
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6801E51EF;
	Wed, 18 Jun 2025 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuGvWiEo"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4F1DE2A7
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221393; cv=none; b=oAJeGV8lqatBasEpsW6PwU25q8/0fOZ/SFEefX4qsfN5cwU1fuIOWmm9HAN6hKq4lU/3rwnXS38tCfBG+FqH+WHRr7eta9O11nDuTrNtaqCmpEd6gt+L0oRWBOnwg+v94L5Ow1KdBCivRCMwrui1LPSEHrTNmni2JSIFVHj8vL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221393; c=relaxed/simple;
	bh=w4pcOt+ScaAM5Jfr0CS430TwrL8pDBZeEekyT57w/QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY4BQpq4G2Y5l+1wmcrIwto3JOHACn4NfHNCWSMfQ9aYW3zZooVDaLJqkfc4G017K7/QAaC4w7BgAe5xPg4rJPnwrG28Hb1I7g/rrfNDaapub+aqTFgmzun9IUVGMe/rR2yIkx7PRzDgvUZ/7xJH+pZ0aiQsTRagc1fHgxXI33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuGvWiEo; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3ce39f0-c52b-4787-980c-973bd4228349@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750221387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMiBGwJIFsuwKorQA5fQy1QVopHhwCl6+KnXqj2rbSc=;
	b=WuGvWiEoIpWes/X3aCpDaHrlKnkMllDPN3RjE0i5YkO4ips96xJtiY3lLkgZQk3blVa+IB
	8JMArdIWra9aqciu6IMHPrRcJNPP1JwoCi76KXO7SI/uTo8CYzoQ/e/csc/Evm41szivCT
	QnM8Mnj2dEK6XoKIT47AWsJ6D1Nr34Y=
Date: Tue, 17 Jun 2025 21:36:15 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZmzrT7+nB0eyK-iLv+un68VtLY-TAq3G5Pti=sjM41TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/16/25 3:00 PM, Andrii Nakryiko wrote:
> On Sun, Jun 15, 2025 at 11:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> When building the selftest with arm64/clang20, the following test failed:
>>      ...
>>      ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
>>      subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
>>      subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xaaaad82a2a80
>>      #469/2   usdt/multispec:FAIL
>>      #469     usdt:FAIL
>>
>> The failed assertion
>>      subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xaaaad82a2a80
>> is caused by bpf_program__attach_usdt() which is expected to fail. But
>> with arm64/clang20 bpf_program__attach_usdt() actually succeeded.
> I think I missed that it's unexpected *success* that is causing
> issues. If that's so, then I think it might be more straightforward to
> just ensure that test is expectedly failing regardless of compiler
> code generation logic. Maybe something along the following lines:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c
> b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..fdd8642cfdff 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -190,11 +190,21 @@ static void __always_inline f300(int x)
>          STAP_PROBE1(test, usdt_300, x);
>   }
>
> +#define RP10(F, X)  F(*(X+0)); F(*(X+1));F(*(X+2)); F(*(X+3)); F(*(X+4)); \
> +                   F(*(X+5)); F(*(X+6)); F(*(X+7)); F(*(X+8)); F(*(X+9));
> +#define RP100(F, X) RP10(F,X+
> 0);RP10(F,X+10);RP10(F,X+20);RP10(F,X+30);RP10(F,X+40); \
> +
> RP10(F,X+50);RP10(F,X+60);RP10(F,X+70);RP10(F,X+80);RP10(F,X+90);
> +
>   __weak void trigger_300_usdts(void)
>   {
> -       R100(f300, 0);
> -       R100(f300, 100);
> -       R100(f300, 200);
> +       volatile int arr[300], i;
> +
> +       for (i = 0; i < 300; i++)
> +               arr[i] = 300;
> +
> +       RP100(f300, arr + 0);
> +       RP100(f300, arr + 100);
> +       RP100(f300, arr + 200);
>   }
>
>
> So basically force the compiler to use 300 different locations for
> each of 300 USDT instantiations? I didn't check how that will look
> like on arm64, but on x86 gcc it seems to generate what is expected of
> it.
>
> Can you please try it on arm64 and see if that works?

I tried the above on arm64 and it does not work. It has the same usdt arguments
as without this patch:

   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt_300
     Location: 0x00000000000009e0, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
     Arguments: -4@[x9]
   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt_300
     Location: 0x00000000000009f8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
     Arguments: -4@[x9]
   ...

But I found if we build usdt.c file with -O2 (RELEASE=1) on arm64, the test will be successful:

   stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt_300
     Location: 0x00000000000001a4, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
     Arguments: -4@0
   stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt_300
     Location: 0x00000000000001a8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
     Arguments: -4@1
   ...

But usdt.c with -O2 will have a problem with gcc14 on x86:

   stapsdt              0x00000087       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt12
     Location: 0x000000000000258f, Base: 0x0000000000000000, Semaphore: 0x0000000000000006
     Arguments: -4@$2 -4@$3 -8@$42 -8@$44 -4@$5 -8@$6 8@%rdx 8@%rsi -4@$-9 -2@%cx -2@nums(%rax,%rax) -1@t1+4(%rip)
   ...

You can see the above last two arguments which are not supported by libbpf.

So let us say usdt.c is compiled with -O2:
    x86:
      gcc14 built kernel/selftests: failed, see the above
      clang built kernel/selftests: good
    arm64:
      both gcc14/clang built kernel/selftrests: good

arm64 has more reigsters so it is likely to have better argument representation, e.g.,
for arm64/gcc with -O2, we have

   stapsdt              0x00000071       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt12
     Location: 0x0000000000002e74, Base: 0x0000000000000000, Semaphore: 0x000000000000000a
     Arguments: -4@2 -4@3 -8@42 -8@44 -4@5 -8@6 8@x1 8@x3 -4@-9 -2@x2 -2@[x0, 8] -1@[x3, 28]

Eduard helped me to figure out how to compile prog_tests/usdt.c with -O2 alone.
The following patch resolved the issue and usdt test will be happy for both x86 and arm64:

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 97013c49920b..05fc9149bc4f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -760,6 +760,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
  TRUNNER_BPF_CFLAGS :=
  $(eval $(call DEFINE_TEST_RUNNER,test_maps))
  
+# Compiler prog_tests/usdt.c with -O2 with clang compiler.
+# Otherwise, with -O0 on arm64, the usdt test will fail.
+ifneq ($(LLVM),)
+$(OUTPUT)/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+endif
+
  # Define test_verifier test runner.
  # It is much simpler than test_maps/test_progs and sufficiently different from
  # them (e.g., test.h is using completely pattern), that it's worth just

Another choice is to support argument like `-2@nums(%rax,%rax)` and `-1@t1+4(%rip)`.
But I am not sure whether we should do it or not as typically a usdt probe
probably won't have lots of diverse arguments.

WDYT?


>
>> Checking usdt probes with usdt.test.o,
>>
>> with gcc11 build binary:
>>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x00000000000054f8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[sp]
>>    stapsdt              0x00000031       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x0000000000005510, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[sp, 4]
>>    ...
>>    stapsdt              0x00000032       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x0000000000005660, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[sp, 60]
>>    ...
>>    stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x00000000000070e8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[sp, 1192]
>>    stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x0000000000007100, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[sp, 1196]
>>    ...
>>    stapsdt              0x00000032       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x0000000000009ec4, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[sp, 60]
>>
>> with clang20 build binary:
>>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x00000000000009a0, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[x9]
>>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x00000000000009b8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[x9]
>>    ...
>>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x0000000000002590, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[x9]
>>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x00000000000025a8, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[x8]
>>    ...
>>    stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descriptors)
>>      Provider: test
>>      Name: usdt_300
>>      Location: 0x0000000000007fdc, Base: 0x0000000000000000, Semaphore: 0x0000000000000008
>>      Arguments: -4@[x10]
>>
>> There are total 301 locations for usdt_300. For gcc11 built binary, there are
>> 300 spec's. But for clang20 built binary, there are 3 spec's. The libbpf default
>> BPF_USDT_MAX_SPEC_CNT is 256. So for gcc11, the above bpf_program__attach_usdt() will
>> fail, but the function will succeed for clang20.
>>
>> Note that we cannot just change BPF_USDT_MAX_SPEC_CNT from 256 to 2 (through overwriting
>> BPF_USDT_MAX_SPEC_CNT before usdt.bpf.h) since it will cause other test failures.
>> We cannot just set BPF_USDT_MAX_SPEC_CNT to 2 for test_usdt_multispec.c since we
>> have below in the Makefile:
>>    test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
>> and the linker will enforce that BPF_USDT_MAX_SPEC_CNT values for both progs must
>> be the same.
>>
>> The refactoring does not change existing test result. But the future change will
>> allow to set BPF_USDT_MAX_SPEC_CNT to be 2 for arm64/clang20 case, which will have
>> the same attachment failure as in gcc11.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/usdt.c | 35 +++++++++++++------
>>   1 file changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> index 495d66414b57..dc29ef94312a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> @@ -270,18 +270,8 @@ static void subtest_multispec_usdt(void)
>>           */
>>          trigger_300_usdts();
>>
>> -       /* we'll reuse usdt_100 BPF program for usdt_300 test */
>>          bpf_link__destroy(skel->links.usdt_100);
>> -       skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
>> -                                                       "test", "usdt_300", NULL);
>> -       err = -errno;
>> -       if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
>> -               goto cleanup;
>> -       ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
>>
>> -       /* let's check that there are no "dangling" BPF programs attached due
>> -        * to partial success of the above test:usdt_300 attachment
>> -        */
>>          bss->usdt_100_called = 0;
>>          bss->usdt_100_sum = 0;
>>
>> @@ -312,6 +302,29 @@ static void subtest_multispec_usdt(void)
>>          test_usdt__destroy(skel);
>>   }
>>
>> +static void subtest_multispec_fail_usdt(void)
>> +{
>> +       LIBBPF_OPTS(bpf_usdt_opts, opts);
>> +       struct test_usdt *skel;
>> +       int err;
>> +
>> +       skel = test_usdt__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +               return;
>> +
>> +       skel->bss->my_pid = getpid();
>> +
>> +       skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
>> +                                                       "test", "usdt_300", NULL);
>> +       err = -errno;
>> +       if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
>> +               goto cleanup;
>> +       ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
>> +
>> +cleanup:
>> +       test_usdt__destroy(skel);
>> +}
>> +
>>   static FILE *urand_spawn(int *pid)
>>   {
>>          FILE *f;
>> @@ -422,6 +435,8 @@ void test_usdt(void)
>>                  subtest_basic_usdt();
>>          if (test__start_subtest("multispec"))
>>                  subtest_multispec_usdt();
>> +       if (test__start_subtest("multispec_fail"))
>> +               subtest_multispec_fail_usdt();
>>          if (test__start_subtest("urand_auto_attach"))
>>                  subtest_urandom_usdt(true /* auto_attach */);
>>          if (test__start_subtest("urand_pid_attach"))
>> --
>> 2.47.1
>>


