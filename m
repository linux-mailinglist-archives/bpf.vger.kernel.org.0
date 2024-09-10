Return-Path: <bpf+bounces-39543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5BE974542
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0398283C45
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E31AAE2C;
	Tue, 10 Sep 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YPfPYNVj"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D018E36E
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005634; cv=none; b=tkfwW07EavgqcuD/QVaKAQ10mXg6H5Zn4ZL1o6diImKn2IxV6af0xuHEV5Wvmzc5hAKGRjUmCwIytsDxrJeDoXeWmpiaUt0SpGvFsVlOWJundLLEr1N8mZ17kgXSpI8Cb6Mm6Ou+pZmY9t1HpxLdGMarb9+BgPL4kqE+/F0K850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005634; c=relaxed/simple;
	bh=EbjnQOpeCjazkogx8n8h5c48TsSuT0LUOnaWcyxajoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVkdtNEXPKx67gLsyKI7FRX/E4t4KE1HCgUxMI689xJVOCLkCRBNcwsd8FPxfKPMuGw5N9PQMwg/ytmykuu0+liJGx0oIkF+YmNSmYHwhT4DqJu9aPW0R2Yhn8UN7A4osjFJBtCHfhF9E9QbrHwdAXouFjFi8K40qJ+AGVMulhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YPfPYNVj; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <269dc5c4-d867-45ff-974c-3cc8a5a30e77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726005630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1y81bRs1zzlMA0yM6s6bIEjf8SZqc4vzDKsXYzeWTk=;
	b=YPfPYNVjzf807/Xasf7jjJZrkAJh5L7iTLJeRm/mAtK5H90xCLVkSI8VoiGIWv96TNZUzr
	HWvMyewZPmUxD+IS56GFuqBBG0IIAlm3PdG9mPLCgFjSb4S2/5nzRg1KYU1zOVpEwA5rMN
	BFqr81M1g9QfOZsveRe0GbrKUBHGu3I=
Date: Tue, 10 Sep 2024 15:00:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel oops caused by signed divide
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
 <CAADnVQJPnCvttM+yitHbLRNoPUPs6EK+5VG=-SDP3LVdD70jyg@mail.gmail.com>
 <b1619bd1-807a-44b7-bfe7-fc053a8122eb@linux.dev>
 <CAADnVQLaOCrxqz7rBjeTJe0EUyAGwtjDKQugyKmFdMGT5=XN4g@mail.gmail.com>
 <6d0e66f9-db1c-444c-b899-1961b41de7c5@linux.dev>
 <CAADnVQLwZNQkViS-c=BA-2Y7+0pqEpo78Otx9SPjaScF0CGvEw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLwZNQkViS-c=BA-2Y7+0pqEpo78Otx9SPjaScF0CGvEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/10/24 2:53 PM, Alexei Starovoitov wrote:
> On Tue, Sep 10, 2024 at 12:32 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 9/10/24 11:25 AM, Alexei Starovoitov wrote:
>>> On Tue, Sep 10, 2024 at 11:02 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> On 9/10/24 8:21 AM, Alexei Starovoitov wrote:
>>>>> On Tue, Sep 10, 2024 at 7:21 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>>> On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
>>>>>>> On Mon, Sep 9, 2024 at 10:21 AM Zac Ecob <zacecob@protonmail.com> wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I recently received a kernel 'oops' about a divide error.
>>>>>>>> After some research, it seems that the 'div64_s64' function used for the 'MOD'/'REM' instructions boils down to an 'idiv'.
>>>>>>>>
>>>>>>>> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then because of two's complement, there is no corresponding positive value, causing the error (at least to my understanding).
>>>>>>>>
>>>>>>>>
>>>>>>>> Apologies if this is already known / not a relevant concern.
>>>>>>> Thanks for the report. This is a new issue.
>>>>>>>
>>>>>>> Yonghong,
>>>>>>>
>>>>>>> it's related to the new signed div insn.
>>>>>>> It sounds like we need to update chk_and_div[] part of
>>>>>>> the verifier to account for signed div differently.
>>>>>> In verifier, we have
>>>>>>       /* [R,W]x div 0 -> 0 */
>>>>>>       /* [R,W]x mod 0 -> [R,W]x */
>>>>> the verifier is doing what hw does. In this case this is arm64 behavior.
>>>> Okay, I see. I tried on a arm64 machine it indeed hehaves like the above.
>>>>
>>>> # uname -a
>>>> Linux ... #1 SMP PREEMPT_DYNAMIC Thu Aug  1 06:58:32 PDT 2024 aarch64 aarch64 aarch64 GNU/Linux
>>>> # cat t2.c
>>>> #include <stdio.h>
>>>> #include <limits.h>
>>>> int main(void) {
>>>>      volatile long long a = 5;
>>>>      volatile long long b = 0;
>>>>      printf("a/b = %lld\n", a/b);
>>>>      return 0;
>>>> }
>>>> # cat t3.c
>>>> #include <stdio.h>
>>>> #include <limits.h>
>>>> int main(void) {
>>>>      volatile long long a = 5;
>>>>      volatile long long b = 0;
>>>>      printf("a%%b = %lld\n", a%b);
>>>>      return 0;
>>>> }
>>>> # gcc -O2 t2.c && ./a.out
>>>> a/b = 0
>>>> # gcc -O2 t3.c && ./a.out
>>>> a%b = 5
>>>>
>>>> on arm64, clang18 compiled binary has the same result
>>>>
>>>> # clang -O2 t2.c && ./a.out
>>>> a/b = 0
>>>> # clang -O2 t3.c && ./a.out
>>>> a%b = 5
>>>>
>>>> The same source code, compiled on x86_64 with -O2 as well,
>>>> it generates:
>>>>      Floating point exception (core dumped)
>>>>
>>>>>> What the value for
>>>>>>       Rx_a sdiv Rx_b -> ?
>>>>>> where Rx_a = INT64_MIN and Rx_b = -1?
>>>>> Why does it matter what Rx_a contains ?
>>>> It does matter. See below:
>>>>
>>>> on arm64:
>>>>
>>>> # cat t1.c
>>>> #include <stdio.h>
>>>> #include <limits.h>
>>>> int main(void) {
>>>>      volatile long long a = LLONG_MIN;
>>>>      volatile long long b = -1;
>>>>      printf("a/b = %lld\n", a/b);
>>>>      return 0;
>>>> }
>>>> # clang -O2 t1.c && ./a.out
>>>> a/b = -9223372036854775808
>>>> # gcc -O2 t1.c && ./a.out
>>>> a/b = -9223372036854775808
>>>>
>>>> So the result of a/b is LLONG_MIN
>>>>
>>>> The same code will cause exception on x86_64:
>>>>
>>>> $ uname -a
>>>> Linux ... #1 SMP Wed Jun  5 06:21:21 PDT 2024 x86_64 x86_64 x86_64 GNU/Linux
>>>> [yhs@devvm1513.prn0 ~]$ gcc -O2 t1.c && ./a.out
>>>> Floating point exception (core dumped)
>>>> [yhs@devvm1513.prn0 ~]$ clang -O2 t1.c && ./a.out
>>>> Floating point exception (core dumped)
>>>>
>>>> So this is what we care about.
>>>>
>>>> So I guess we can follow arm64 result too.
>>>>
>>>>> What cpus do in this case?
>>>> See above. arm64 produces *some* result while x64 cause exception.
>>>> We do need to special handle for LLONG_MIN/(-1) case.
>>> My point about Rx_a that idiv will cause out-of-range exception
>>> for many other values than Rx_a == INT64_MIN.
>>> I'm not sure that divisor -1 is the only such case either.
>>> Probably is, since intuitively -2 and all other divisors should fit fine.
>>> So the check likely needs Rx_b == -1 and a check for high bit in Rx_a ?
>> Looks like only Rx_a == INT64_MIN may cause the problem.
>> All other Rx_a numbers (from INT64_MIN+1 to INT64_MAX)
>> should be okay. Some selective testing below on x64 host:
>>
>> $ cat t5.c
>> #include <stdio.h>
>> #include <limits.h>
>>
>> unsigned long long res;
>> int main(void) {
>>     volatile long long a;
>>     long long i;
>>     for (i = LLONG_MIN + 1; i <= LLONG_MIN + 100; i++) {
>>       volatile long long b = -1;
>>       a = i;
>>       res += (unsigned long long)(a/b);
>>     }
>>     for (i = LLONG_MAX - 100; i <= LLONG_MAX - 1; i++) {
> Changing this test to i <= LLONG_MAX
> and compiling with gcc -O0 or clang -O2 or clang -O0
> is causing an exception,
> because 'a' becomes LLONG_MIN.

This is my theory.
If change to i <= LLONG_MAX, then after
i = LLONG_MAX, it will do 'i++' and then
it will become tricky since then undefined
behavior will pick in as 'i++' will become
out of range.

> Compilers are doing some odd code gen.
> I don't understand how 'i' can wrap this way.
>
>>       volatile long long b = -1;
>>       a = i;
>>       res += (unsigned long long)(a/b);
>>     }
>>     printf("res = %llx\n", res);
>>     return 0;
>> }
>> $ gcc -O2 t5.c && ./a.out
>> res = 64
>>
>> So I think it should be okay if the range is from LLONG_MIN + 1
>> to LLONG_MAX - 1.
>>
>> Now for LLONG_MAX/(-1)
>>
>> $ cat t6.c
>> #include <stdio.h>
>> #include <limits.h>
>> int main(void) {
>>     volatile long long a = LLONG_MAX;
>>     volatile long long b = -1;
>>     printf("a/b = %lld\n", a/b);
>>     return 0;
>> }
>> $ gcc -O2 t6.c && ./a.out
>> a/b = -9223372036854775807
>>
>> It is okay too. So I think LLONG_MIN/(-1) is the only case
>> we should take care of.
> The test shows that that's the case, but I still can wrap
> my head around that only LLONG_MIN/(-1) is a problem.
>
> Any math experts can explain this?

