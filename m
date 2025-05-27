Return-Path: <bpf+bounces-58962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA96AC4770
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 07:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25791773EE
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF541D6DDD;
	Tue, 27 May 2025 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D/YaKhfJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0B382
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748322951; cv=none; b=bF5XkA10Jjd+atnUFBJAumtBJ+I0jSMxAjVaNA1ji+MzmCv7b8jEusJPx9IjrCJQiRiTTI4mgNZDH4miZ6MC0kWn0Ac1daLezOwF4axeBH/SizD2xWkFkPX1G4/XS0kG7ESd6xeIlYcYSh0ZzPam1M/48FAvENWgvfLPQxo+/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748322951; c=relaxed/simple;
	bh=y1LolMH3zxT1arjdD9Ee2CBjdJRXImVZ9L6GaSXmM8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7to1LU0M1DTX2eyMpR8gEUbNoOPddQnjdOVHYp+PnQm2Dn2eiNVLwBjlBNJgdxQoY9M9JkJP4xQeZvhBLksXOktCYMemQ/QRiZNE1tQW8GrFZTwExmOMltl1Gjny0xd8Aop2EQXcTuicBxKkN2bpUqW1SYg0lGy+z4shJKg5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D/YaKhfJ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6192c51c-e800-4a89-a0b2-52abab33010a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748322945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0B8L8ndCev+xh3E/bxhcncVXrWpXLF8mJJHa0lk9r4=;
	b=D/YaKhfJNlQS8X/Aab9IjyUWhjo+aTsNyKOIVNMGKEOs22wtBYc9hzH8vHzvtwrT7jfwf2
	dhmkxSNLmn9dxKma5nAkKAErsxwnlhvuTCqCA9BTi+whGln8W4e+7QOW4OxpSuFyimmSnC
	XdeHyOuyidBQAmULyYpmA5oMLo18GAg=
Date: Mon, 26 May 2025 22:15:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused"
 warnings
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250508113804.304665-1-iii@linux.ibm.com>
 <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
 <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
 <7a242102eecdd17b4d35c1e4f7d01ea15cb8066a.camel@linux.ibm.com>
 <CAADnVQ+5h9UESAgNA58HEQ-0zwxn=c0+ibH++NF9farR5-JB8g@mail.gmail.com>
 <CAP01T74iix8HvmVYowFyrG98tDRw8JMOck7HQLD57nuo7SyuoA@mail.gmail.com>
 <a8b8b4c9b5485a605437448bd1c548a38dfd1d55.camel@linux.ibm.com>
 <b7517bd4-3e6a-4a74-99c8-bca0969aeb01@linux.dev>
 <CAP01T75hQ0SDAXY+w-nnRii_B9TkydCXahbC8ATrmuGAeQc+AQ@mail.gmail.com>
 <195a1fd78ebf029eba204982f5bbe0ec6ef025fb.camel@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <195a1fd78ebf029eba204982f5bbe0ec6ef025fb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/24/25 2:05 PM, Ilya Leoshkevich wrote:
> On Sat, 2025-05-24 at 03:01 +0200, Kumar Kartikeya Dwivedi wrote:
>> On Sat, 24 May 2025 at 02:06, Yonghong Song <yonghong.song@linux.dev>
>> wrote:
>>>
>>>
>>> On 5/23/25 4:25 AM, Ilya Leoshkevich wrote:
>>>> On Mon, 2025-05-12 at 15:29 -0400, Kumar Kartikeya Dwivedi wrote:
>>>>> On Mon, 12 May 2025 at 12:41, Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>> On Mon, May 12, 2025 at 5:22 AM Ilya Leoshkevich
>>>>>> <iii@linux.ibm.com> wrote:
>>>>>>> On Fri, 2025-05-09 at 09:51 -0700, Alexei Starovoitov
>>>>>>> wrote:
>>>>>>>> On Thu, May 8, 2025 at 12:21 PM Ilya Leoshkevich
>>>>>>>> <iii@linux.ibm.com>
>>>>>>>> wrote:
>>>>>>>>> On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov
>>>>>>>>> wrote:
>>>>>>>>>> On Thu, May 8, 2025 at 4:38 AM Ilya Leoshkevich
>>>>>>>>>> <iii@linux.ibm.com>
>>>>>>>>>> wrote:
>>>>>>>>>>> clang-21 complains about unused expressions in a
>>>>>>>>>>> few
>>>>>>>>>>> progs.
>>>>>>>>>>> Fix by explicitly casting the respective
>>>>>>>>>>> expressions to
>>>>>>>>>>> void.
>>>>>>>>>> ...
>>>>>>>>>>>           if (val & _Q_LOCKED_MASK)
>>>>>>>>>>> -               smp_cond_load_acquire_label(&lock-
>>>>>>>>>>>> locked,
>>>>>>>>>>> !VAL,
>>>>>>>>>>> release_err);
>>>>>>>>>>> +
>>>>>>>>>>> (void)smp_cond_load_acquire_label(&lock-
>>>>>>>>>>>> locked,
>>>>>>>>>>> !VAL, release_err);
>>>>>>>>>> Hmm. I'm on clang-21 too and I don't see them.
>>>>>>>>>> What warnings do you see ?
>>>>>>>>> In file included from progs/arena_spin_lock.c:7:
>>>>>>>>> progs/bpf_arena_spin_lock.h:305:1756: error: expression
>>>>>>>>> result
>>>>>>>>> unused
>>>>>>>>> [-Werror,-Wunused-value]
>>>>>>>>>     305 |   ({ typeof(_Generic((*&lock->locked), char:
>>>>>>>>> (char)0,
>>>>>>>>> unsigned
>>>>>>>>> char : (unsigned char)0, signed char : (signed char)0,
>>>>>>>>> unsigned
>>>>>>>>> short :
>>>>>>>>> (unsigned short)0, signed short : (signed short)0,
>>>>>>>>> unsigned
>>>>>>>>> int :
>>>>>>>>> (unsigned int)0, signed int : (signed int)0, unsigned
>>>>>>>>> long :
>>>>>>>>> (unsigned
>>>>>>>>> long)0, signed long : (signed long)0, unsigned long
>>>>>>>>> long :
>>>>>>>>> (unsigned
>>>>>>>>> long long)0, signed long long : (signed long long)0,
>>>>>>>>> default:
>>>>>>>>> (typeof(*&lock->locked))0)) __val = ({ typeof(&lock-
>>>>>>>>>> locked)
>>>>>>>>> __ptr
>>>>>>>>> =
>>>>>>>>> (&lock->locked); typeof(_Generic((*(&lock->locked)),
>>>>>>>>> char:
>>>>>>>>> (char)0,
>>>>>>>>> unsigned char : (unsigned char)0, signed char : (signed
>>>>>>>>> char)0,
>>>>>>>>> unsigned short : (unsigned short)0, signed short :
>>>>>>>>> (signed
>>>>>>>>> short)0,
>>>>>>>>> unsigned int : (unsigned int)0, signed int : (signed
>>>>>>>>> int)0,
>>>>>>>>> unsigned
>>>>>>>>> long : (unsigned long)0, signed long : (signed long)0,
>>>>>>>>> unsigned
>>>>>>>>> long
>>>>>>>>> long : (unsigned long long)0, signed long long :
>>>>>>>>> (signed long
>>>>>>>>> long)0,
>>>>>>>>> default: (typeof(*(&lock->locked)))0)) VAL; for (;;) {
>>>>>>>>> VAL =
>>>>>>>>> (typeof(_Generic((*(&lock->locked)), char: (char)0,
>>>>>>>>> unsigned
>>>>>>>>> char :
>>>>>>>>> (unsigned char)0, signed char : (signed char)0,
>>>>>>>>> unsigned
>>>>>>>>> short :
>>>>>>>>> (unsigned short)0, signed short : (signed short)0,
>>>>>>>>> unsigned
>>>>>>>>> int :
>>>>>>>>> (unsigned int)0, signed int : (signed int)0, unsigned
>>>>>>>>> long :
>>>>>>>>> (unsigned
>>>>>>>>> long)0, signed long : (signed long)0, unsigned long
>>>>>>>>> long :
>>>>>>>>> (unsigned
>>>>>>>>> long long)0, signed long long : (signed long long)0,
>>>>>>>>> default:
>>>>>>>>> (typeof(*(&lock->locked)))0)))(*(volatile
>>>>>>>>> typeof(*__ptr)
>>>>>>>>> *)&(*__ptr));
>>>>>>>>> if (!VAL) break; ({ __label__ l_break, l_continue; asm
>>>>>>>>> volatile
>>>>>>>>> goto("may_goto %l[l_break]" :::: l_break); goto
>>>>>>>>> l_continue;
>>>>>>>>> l_break:
>>>>>>>>> goto release_err; l_continue:; }); ({}); }
>>>>>>>>> (typeof(*(&lock-
>>>>>>>>>> locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({
>>>>>>>>>> unsigned
>>>>>>>>>> long
>>>>>>>>>> __val;
>>>>>>>>> __sync_fetch_and_add(&__val, 0); }); else asm
>>>>>>>>> volatile("" :::
>>>>>>>>> "memory"); }); }); (typeof(*(&lock->locked)))__val; });
>>>>>>>>>         |
>>>>>>>>> ^                         ~~~~~
>>>>>>>>> 1 error generated.
>>>>>>>> hmm. The error is impossible to read.
>>>>>>>>
>>>>>>>> Kumar,
>>>>>>>>
>>>>>>>> Do you see a way to silence it differently ?
>>>>>>>>
>>>>>>>> Without adding (void)...
>>>>>>>>
>>>>>>>> Things like:
>>>>>>>> -       bpf_obj_new(..
>>>>>>>> +       (void)bpf_obj_new(..
>>>>>>>>
>>>>>>>> are good to fix, and if we could annotate
>>>>>>>> bpf_obj_new_impl kfunc with __must_check we would have
>>>>>>>> done it,
>>>>>>>>
>>>>>>>> but
>>>>>>>> -               arch_mcs_spin_lock...
>>>>>>>> +               (void)arch_mcs_spin_lock...
>>>>>>>>
>>>>>>>> is odd.
>>>>>>> What do you think about moving (void) to the definition of
>>>>>>> arch_mcs_spin_lock_contended_label()? I can send a v2 if
>>>>>>> this is
>>>>>>> better.
>>>>>> Kumar,
>>>>>>
>>>>>> thoughts?
>>>>> Sorry for the delay, I was afk.
>>>>>
>>>>> The warning seems a bit aggressive, in the kernel we have users
>>>>> which
>>>>> do and do not use the value and it's fine.
>>>>> I think moving (void) inside the macro is a problem since at
>>>>> least
>>>>> rqspinlock like algorithm would want to inspect the result of
>>>>> the
>>>>> locked bit.
>>>>> No such users exist for now, of course. So maybe we can silence
>>>>> it
>>>>> until we do end up depending on the value.
>>>>>
>>>>> I will give a try with clang-21, but I think probably (void) in
>>>>> the
>>>>> source is better if we do need to silence it.
>>>> Gentle ping.
>>>>
>>>> This is still an issue with clang version 21.0.0
>>>> (++20250522112647+491619a25003-1~exp1~20250522112819.1465).
>>>>
>>> I cannot reproduce the "unused expressions" error. What is the
>>> llvm cmake command line you are using?
>>>
>> Sorry for the delay. I tried just now with clang built from the
>> latest
>> git checkout but I don't see it either.
>> I built it following the steps at
>> https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst.
> I use the following make invocation:
>
> make CC="ccache gcc" LD=ld.lld-21 O="$PWD/../linux-build-s390x"
> CLANG="ccache clang-21" LLVM_STRIP=llvm-strip-21 LLC=llc-21 LLD=lld-21
> -j128 -C tools/testing/selftests/bpf BPF_GCC= V=1
>
> which results in the following clang invocation:
>
> ccache clang-21  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -
> I"$PWD/../../../../.."/linux-build-s390x//tools/include -
> I"$PWD/../../../../.."/linux/tools/testing/selftests/bpf -
> I"$PWD/../../../../.."/linux/tools/include/uapi -
> I"$PWD/../../../../.."/usr/include -std=gnu11 -fno-strict-aliasing -
> Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-
> 21/lib/clang/21/include -idirafter /usr/local/include -idirafter
> /usr/include/s390x-linux-gnu -idirafter /usr/include    -
> DENABLE_ATOMICS_TESTS   -O2 --target=bpfeb -c progs/arena_spin_lock.c -
> mcpu=v3 -o "$PWD/../../../../.."/linux-build-
> s390x//arena_spin_lock.bpf.o
>
> I tried dropping ccache, but it did not help.

Thanks, Ilya. It could be great if you can find out the
cmake command lines which eventually builds your clang-21.
Once cmake command lines are available, I can build
the compiler on x86_64 host and do some checking for it.


