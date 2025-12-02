Return-Path: <bpf+bounces-75920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC9C9CB4F
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D52373446FB
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75602D2381;
	Tue,  2 Dec 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pBGZ7TaN"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADF204F93
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702070; cv=none; b=ZT2ceu3hdPiFG6cIud4GUjczMlf4hLEJqR2V/aqWzpPgrOQ8iQcqdplWt3PNfbaAampn+PEw4SFKT1IZ4WzhGMpiYyCh27KWip6pKt9FSSY3belMGfCn0GMeClKMMQWKU+jvRj3kKbIKTJZRjHeeDFdsI689t3+IaaH3JLkP/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702070; c=relaxed/simple;
	bh=iussvT3mNWzOL6PWOqhmNvZ+ZG4EXUPvaoYqFBw/Yis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYighCLrgCUZ2ZFWnWe95Buse0AVWFiiVz7UXh3R++stqx7UwMRB+idUv2nuHFqPjdqXc0cIhN1Xgj1/rHWcB/XCpinvFznTVREl+/yzIUY2fC6vNaRVaPyP89WNk0mmBIOosnvjziGLE0+CAhyggC5ZN2VcaFu774CFS9D/g74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pBGZ7TaN; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1175fe21-5c0b-4680-8fa7-55d22e4bcaca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764702065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2r1JVcNMS4GXLtYVa1eYaK6xRcAdItsZsBwTWSZySo=;
	b=pBGZ7TaNgWVsxmXU+HAhFstXCitqWiFLLIwEBj4QN8eqCGIcBf1ePB4FkfzpY6IJ3rvn0O
	KdaRskVRL/yjbWA9qxstbnw6EOu2eivII3C+jmbJVKLy9ESlFUZDI4WHfgTfLB6zEHmPiD
	u3HpeyRfJiRNc7WtFdBNadqwMaWVjYk=
Date: Tue, 2 Dec 2025 11:00:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
 <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
 <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev>
 <642f6b68-0691-44a1-844f-a8cddec41fd0@linux.dev>
 <CAErzpmsoeFJBhqXZF1ttUCDx5HSFVawdiVfsG2vWSOq4DBBruQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAErzpmsoeFJBhqXZF1ttUCDx5HSFVawdiVfsG2vWSOq4DBBruQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/1/25 6:01 PM, Donglin Peng wrote:
> On Tue, Dec 2, 2025 at 3:46 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 11/27/25 9:52 PM, Ihor Solodrai wrote:
>>> On 11/27/25 7:20 PM, Donglin Peng wrote:
>>>> On Fri, Nov 28, 2025 at 2:53 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>>> index bac22265e7ff..ec7e2a7721c7 100644
>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>>>>>  include ../../../scripts/Makefile.include
>>>>>
>>>>>  CXX ?= $(CROSS_COMPILE)g++
>>>>> +OBJCOPY ?= $(CROSS_COMPILE)objcopy
>>>>>
>>>>>  CURDIR := $(abspath .)
>>>>>  TOOLSDIR := $(abspath ../../..)
>>>>> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                  \
>>>>>         $$(call msg,BINARY,,$$@)
>>>>>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
>>>>>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>>>>> +       $(Q)if [ -f $$@.btf_ids ]; then \
>>>>> +               $(OBJCOPY) --update-section .BTF_ids=$$@.btf_ids $$@; \
>>>>
>>>> I encountered a resolve_btfids self-test failure when enabling the
>>>> BTF sorting feature, with the following error output:
>>>>
>>>> All error logs:
>>>> resolve_symbols:PASS:resolve 0 nsec
>>>> test_resolve_btfids:PASS:id_check 0 nsec
>>>> test_resolve_btfids:PASS:id_check 0 nsec
>>>> test_resolve_btfids:FAIL:id_check wrong ID for T (7 != 5)
>>>> #369     resolve_btfids:FAIL
>>>>
>>>> The root cause is that prog_tests/resolve_btfids.c retrieves type IDs
>>>> from btf_data.bpf.o and compares them against the IDs in test_progs.
>>>> However, while the IDs in test_progs are sorted, those in btf_data.bpf.o
>>>> remain in their original unsorted state, causing the validation to fail.
>>>>
>>>> This presents two potential solutions:
>>>> 1. Update the relevant .BTF.* section datas in btf_data.bpf.o, including
>>>>     the .BTF and .BTF.ext sections
>>>> 2. Modify prog_tests/resolve_btfids.c to retrieve IDs from test_progs.btf
>>>>     instead. However, I discovered that test_progs.btf is deleted in the
>>>>     subsequent code section.
>>>>
>>>> What do you think of it?
>>>
>>> Within resolve_btfids it's clear that we have to update (sort in this
>>> case) BTF first, and then resolve the ids based on the changed BTF.
>>>
>>> As for the test, we should probably change it to become closer to an
>>> actual resolve_btfids use-case. Maybe even replace or remove it.
>>>
>>> resolve_btfids operates on BTF generated by pahole for
>>> kernel/module. And the .BTF_ids section makes sense only in kernel
>>> space AFAIU (might be wrong, let me know if I am).
>>>
>>> And in this test we are using BTF produced by LLVM for a BPF program,
>>> and then create a .BTF_ids section in a user-space app (test_progs /
>>> resolve_btfids.test.o), although using proper kernel macros.
>>>
>>> By the way, the test was written more than 5y ago [1], so it might be
>>> outdated too.
>>>
>>> I think the behavior that we care about is already indirectly tested
>>> by bpf_testmod module tests, with custom BPF kfuncs and BTF_ID_*
>>> declarations etc. If resolve_btfids is broken, those tests will fail.
>>>
>>> But it's also reasonable to have some tests targeting resolve_btfids
>>> app itself, of course. This one doesn't fit though IMO.
>>>
>>> I'll try to think of something.
>>
>> Hi Donglin,
>>
>> I discussed this off-list with Andrii, and we agreed that the selftest
>> itself is reasonable with respect to testing resolve_btfids output.
>>
>> In this series, I only have to change the test_progs build recipe.
>>
>> The problem that you've encountered I think can be fixed in the test,
>> which is basically what you suggested as option 2:
>>
>>   static int resolve_symbols(void)
>>   {
>>         struct btf *btf;
>>         int type_id;
>>         __u32 nr;
>>
>>         btf = btf__parse_elf("btf_data.bpf.o", NULL); /* <--- this */
>>
>>         [...]
>>
>> Instead of reading in the source BTF, we have to load .btf produced by
>> resolve_btfids. A complication is that it's going to be a different
>> file for every TRUNNER_BINARY, which has to be accounted for, although
>> the BTF itself would be identical between relevant runners.
>>
>> If go this route, I think we should add .btf cleanup to the Makefile
>> and update local .gitignore
> 
> Thanks, could the following modification be accepted?
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore
> b/tools/testing/selftests/bpf/.gitignore
> index be1ee7ba7ce0..38ac369cd701 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -45,3 +45,4 @@ xdp_synproxy
>  xdp_hw_metadata
>  xdp_features
>  verification_cert.h
> +*.btf
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 2a027ff9ceaf..a1188129229f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -720,7 +720,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
>                  \
>         $(Q)if [ -f $$@.btf_ids ]; then \
>                 $(OBJCOPY) --update-section .BTF_ids=$$@.btf_ids $$@; \
>         fi
> -       $(Q)rm -f $$@.btf_ids $$@.btf
> +       $(Q)rm -f $$@.btf_ids
>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>                    $(OUTPUT)/$(if $2,$2/)bpftool
> 
> @@ -908,7 +908,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
>                  \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool $(TEST_KMOD_TARGETS)                            \
>         $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h   \
> -                              no_alu32 cpuv4 bpf_gcc                   \
> +                              *.btf no_alu32 cpuv4 bpf_gcc             \
>                                liburandom_read.so)                      \
>         $(OUTPUT)/FEATURE-DUMP.selftests
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 51544372f52e..00883ff16569 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -101,7 +101,7 @@ static int resolve_symbols(void)
>         int type_id;
>         __u32 nr;
> 
> -       btf = btf__parse_elf("btf_data.bpf.o", NULL);
> +       btf = btf__parse_raw("test_progs.btf");

We can't hardcode a filename here, because $(OUTPUT)/$(TRUNNER_BINARY)
is a generic rule for a number of different binaries (test_progs,
test_maps, test_progs-no_alu32 and others).

I think there are a few options how to deal with this:
- generate .btf and .btf_ids not for the final TRUNNER_BINARY, but for
  a specific test object (resolve_btfids.test.o in this case); then we
  could load "resolve_btfids.test.o.btf"
- implement an --output-btf option in resolve_btfids
- somehow (env var?) determine what binary is running in the test
- (a hack) in the makefile, copy $@.btf to "test.btf" or similar

IMO the first option is the best, as this makefile code exists because
of that specific test.

The --output-btf is okay in principle, but I don't like the idea of
adding a cli option that would be used only for one selftest.

>         if (CHECK(libbpf_get_error(btf), "resolve",
>                   "Failed to load BTF from btf_data.bpf.o\n"))
>                 return -1;
> 
> Thanks,
> Donglin
> 
>>
>> This change is not strictly necessary in this series, but it is for
>> the BTF sorting series. Let me know if you would like to take this on,
>> so we don't do the same work twice.
> 
> Thanks, I will take it on.

Thank you. I think that'll be a patch in the BTF sorting series.
You can work on top of this (v2) series for now. The feedback so far has
been mostly nits, and I don't expect overall approach to change in v3.

> 
>>
>>>
>>> [1] https://lore.kernel.org/bpf/20200703095111.3268961-10-jolsa@kernel.org/
>>>
>>>
>>>>
>>>> Thanks,
>>>> Donglin
>>>>
>>>>> +       fi
>>>>> +       $(Q)rm -f $$@.btf_ids $$@.btf
>>>>>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>>>>>                    $(OUTPUT)/$(if $2,$2/)bpftool
>>>>>
>>>>> --
>>>>> 2.52.0
>>>>>
>>>
>>


