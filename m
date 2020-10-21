Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0648295167
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408844AbgJURSQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 13:18:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:59586 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389946AbgJURSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 13:18:15 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kVHka-0001FC-6b; Wed, 21 Oct 2020 19:18:12 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kVHka-000UFF-1u; Wed, 21 Oct 2020 19:18:12 +0200
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
 <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net>
 <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
 <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
 <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net>
 <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
 <231e3e6b-0118-f600-05c5-f4e2f2c76129@fb.com>
 <CAMy7=ZWYn9MnmQJU7S_FUz5PArkGtVUcS1czn3oVCqa1aEniXw@mail.gmail.com>
 <322077f3-efea-8bd0-0b67-b4636428fc5a@iogearbox.net>
 <CAMy7=ZVjYvMz2aFJxcPK5nK4L3AXZJPuVpQvPVk98ph8scpYEA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b18125f2-ae98-9ca1-a9c9-099262b8a388@iogearbox.net>
Date:   Wed, 21 Oct 2020 19:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAMy7=ZVjYvMz2aFJxcPK5nK4L3AXZJPuVpQvPVk98ph8scpYEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25512/Tue Jul 16 10:09:55 2019)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/21/20 11:43 AM, Yaniv Agman wrote:
> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-22:58 מאת ‪Daniel Borkmann‬‏
> <‪daniel@iogearbox.net‬‏>:‬
>> On 10/9/20 9:33 PM, Yaniv Agman wrote:
>>> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-22:08 מאת ‪Yonghong Song‬‏ <‪yhs@fb.com‬‏>:‬
>>>> On 10/9/20 11:59 AM, Andrii Nakryiko wrote:
>>>>> On Fri, Oct 9, 2020 at 11:41 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>> On 10/9/20 8:35 PM, Andrii Nakryiko wrote:
>>>>>>> On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>>>> On 10/9/20 8:09 PM, Yaniv Agman wrote:
>>>>>>>>> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-20:39 מאת ‪Daniel Borkmann‬‏
>>>>>>>>> <‪daniel@iogearbox.net‬‏>:‬
>>>>>>>>>>
>>>>>>>>>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
>>>>>>>>>>> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-19:27 מאת ‪Daniel Borkmann‬‏
>>>>>>>>>>> <‪daniel@iogearbox.net‬‏>:‬
>>>>>>>>>>>>
>>>>>>>>>>>> [ Cc +Yonghong ]
>>>>>>>>>>>>
>>>>>>>>>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
>>>>>>>>>>>>> Pulling the latest changes of libbpf and compiling my application with it,
>>>>>>>>>>>>> I see the following error:
>>>>>>>>>>>>>
>>>>>>>>>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
>>>>>>>>>>>>> unknown register name 'r0' in asm
>>>>>>>>>>>>>                             : "r0", "r1", "r2", "r3", "r4", "r5");
>>>>>>>>>>>>>
>>>>>>>>>>>>> The commit which introduced this change is:
>>>>>>>>>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm not sure if I'm doing something wrong (missing include?), or this
>>>>>>>>>>>>> is a genuine error
>>>>>>>>>>>>
>>>>>>>>>>>> Seems like your clang/llvm version might be too old.
>>>>>>>>>>>
>>>>>>>>>>> I'm using clang 10.0.1
>>>>>>>>>>
>>>>>>>>>> Ah, okay, I see. Would this diff do the trick for you?
>>>>>>>>>
>>>>>>>>> Yes! Now it compiles without any problems!
>>>>>>>>
>>>>>>>> Great, thx, I'll cook proper fix and check with clang6 as Yonghong mentioned.
>>>>>>>
>>>>>>> Am I the only one confused here?... Yonghong said it should be
>>>>>>> supported as early as clang 6, Yaniv is using Clang 10 and is still
>>>>>>> getting this error. Let's figure out what's the problem before adding
>>>>>>> unnecessary checks.
>>>>>>>
>>>>>>> I think it's not the clang_major check that helped, rather __bpf__
>>>>>>> check. So please hold off on the fix, let's get to the bottom of this
>>>>>>> first.
>>>>>>
>>>>>> I don't see confusion here (maybe other than which minimal clang/llvm version
>>>>>> libbpf should support). If we do `#if __clang_major__ >= 6 && defined(__bpf__)`
>>>>>> for the final patch, then this means that user passed clang -target bpf and
>>>>>> the min supported version for inline assembly was there, otherwise we fall back
>>>>>> to bpf_tail_call. In Yaniv's case, he probably had native target with -emit-llvm
>>>>>> and then used llc invocation.
>>>>>
>>>>> The "-emit-llvm" was the part that we were missing and had to figure
>>>>> it out, before we could discuss the fix.
>>>>
>>>> Maybe Yaniv can confirm. I think the following properly happens.
>>>>       - clang10 -O2 -g -S -emit-llvm t.c  // This is native compilation
>>>> becasue some header files. Maybe some thing is guarded with x86 specific
>>>> config's which is not available to -target bpf. This is mostly for
>>>> tracing programs and Yanic mentions pt_regs which should be related
>>>> to tracing.
>>>>       - llc -march=bpf t.ll
>>>
>>> Yes, like I said,  I do use --emit-llvm, and indeed have a tracing program
>>>
>>>> So guarding the function with __bpf__ should be the one fixing this issue.
>>>>
>>>> guard with clang version >=6 should not hurt and may prevent
>>>> compilation failures if people use < 6 llvm with clang -target bpf.
>>>> I think most people should already use newer llvm, but who knows.
>>
>> Yeah that was my thinking for those stuck for whatever reason on old LLVM.
>>
>>>>>>>>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>>>>>>>>>> index 2bdb7d6dbad2..31e356831fcf 100644
>>>>>>>>>> --- a/tools/lib/bpf/bpf_helpers.h
>>>>>>>>>> +++ b/tools/lib/bpf/bpf_helpers.h
>>>>>>>>>> @@ -72,6 +72,7 @@
>>>>>>>>>>        /*
>>>>>>>>>>         * Helper function to perform a tail call with a constant/immediate map slot.
>>>>>>>>>>         */
>>>>>>>>>> +#if __clang_major__ >= 10 && defined(__bpf__)
>>>>>>>>>>        static __always_inline void
>>>>>>>>>>        bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>>>>>>>>>        {
>>>>>>>>>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>>>>>>>>>                           :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>>>>>>>>>>                           : "r0", "r1", "r2", "r3", "r4", "r5");
>>>>>>>>>>        }
>>>>>>>>>> +#else
>>>>>>>>>> +# define bpf_tail_call_static  bpf_tail_call
>>>>>
>>>>> bpf_tail_call_static has very specific guarantees, so in cases where
>>>>> we can't use inline assembly to satisfy those guarantees, I think we
>>>>> should not just silently redefine bpf_tail_call_static as
>>>>> bpf_tail_call, rather make compilation fail if someone is attempting
>>>>> to use bpf_tail_call_static. _Static_assert could be used to provide a
>>>>> better error message here, probably.
>>
>> Makes sense as well, I was mainly thinking if people include header files in
>> their project which are shared between tracing & non-tracing, so they compile
>> just fine, but I can see the point that wrt very specific guarantees, fully
>> agree. In that sense we should just have it defined with the clang + __bpf__
>> constraints mentioned earlier.
> 
> Is this change going to happen?
> I'm still having a compilation error when using master branch

Yeah, I'll submit something tonight.

Thanks,
Daniel
