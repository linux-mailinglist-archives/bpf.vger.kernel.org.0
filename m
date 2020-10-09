Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAC2890AC
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbgJISVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:21:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:44028 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbgJISVQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:21:16 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kQx0z-0005jy-T6; Fri, 09 Oct 2020 20:21:13 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kQx0z-000XJl-OU; Fri, 09 Oct 2020 20:21:13 +0200
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
 <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net>
 <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
Date:   Fri, 9 Oct 2020 20:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25952/Fri Oct  9 15:52:40 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/9/20 8:09 PM, Yaniv Agman wrote:
> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-20:39 מאת ‪Daniel Borkmann‬‏
> <‪daniel@iogearbox.net‬‏>:‬
>>
>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
>>> ‫בתאריך יום ו׳, 9 באוק׳ 2020 ב-19:27 מאת ‪Daniel Borkmann‬‏
>>> <‪daniel@iogearbox.net‬‏>:‬
>>>>
>>>> [ Cc +Yonghong ]
>>>>
>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
>>>>> Pulling the latest changes of libbpf and compiling my application with it,
>>>>> I see the following error:
>>>>>
>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
>>>>> unknown register name 'r0' in asm
>>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5");
>>>>>
>>>>> The commit which introduced this change is:
>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
>>>>>
>>>>> I'm not sure if I'm doing something wrong (missing include?), or this
>>>>> is a genuine error
>>>>
>>>> Seems like your clang/llvm version might be too old.
>>>
>>> I'm using clang 10.0.1
>>
>> Ah, okay, I see. Would this diff do the trick for you?
> 
> Yes! Now it compiles without any problems!

Great, thx, I'll cook proper fix and check with clang6 as Yonghong mentioned.

>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 2bdb7d6dbad2..31e356831fcf 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -72,6 +72,7 @@
>>    /*
>>     * Helper function to perform a tail call with a constant/immediate map slot.
>>     */
>> +#if __clang_major__ >= 10 && defined(__bpf__)
>>    static __always_inline void
>>    bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>    {
>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>                       :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>>                       : "r0", "r1", "r2", "r3", "r4", "r5");
>>    }
>> +#else
>> +# define bpf_tail_call_static  bpf_tail_call
>> +#endif /* __clang_major__ >= 10 && __bpf__ */
>>
>>    /*
>>     * Helper structure used by eBPF C program

