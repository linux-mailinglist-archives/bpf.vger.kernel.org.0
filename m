Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4794A71E6
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 14:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiBBNrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBBNrs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 08:47:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B06C061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 05:47:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id me13so65908338ejb.12
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline.eu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Av4x9n+1kUCvPGJQE9D2nE/DFTlhLNvTb49np/4YWI=;
        b=BdQK8tw1RtboaLP9qU9A5niLHurUv9UG9dSRfAt30UjziMNl2AIXOl5ZnSV1HHVkvH
         zGCRQZObqgOPGvEhL/YwGgeVxLjI3OAk4ma/s1E68OzYP3n4HZYLSG2doECR55oY2TS0
         nB0Gmfp2Bzw3T2pEWHL5iUzvUg2M6j/JaYzqjHdwqyV7SHhu/VA7jKJ7zTqq2z1dRY6I
         AfaniA01f5GDEJpv/rkFoN6mWiqNZiZyrtj20VIKCOBOz+ncWjsMuaHvm3P95Roow3gy
         rbFLh2E1QqHKn9QnTirWqea4jgIPvw3wm6fyASn3GQz5xOza/NOQJSv3Thxta2u9LH5o
         Rp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Av4x9n+1kUCvPGJQE9D2nE/DFTlhLNvTb49np/4YWI=;
        b=JdUDYKPv6DW+7Rcc/QXtQRPsMxAlLFtyyBBXQTbmYgFoHA9vhX3ldIKjDZR5MXTjdC
         GHxEUGFKCwxGD0qi/owiN8ba78yoT9ors40OI/FkC8hElDVD+QO484N96tfOV5S9NVRO
         ytMKUstQG2qrU6/dEzsYsHSZVfzfetKDa/ciAIvtS9baHpyO3xoxotsxBEtafyn1Grt3
         sXzuwuf/KN6tEKbS6b1VUbbRcoaOp1E7zu3M+6mYn2wuZthNZl97ESsBrixIsvOgKX5z
         Ha4T1vXsLZGYe1JBVhRKUjBHg+f5G5dwN3Vk6uLHlVx3C6ZYDqOPYOnSEAHs953RbZVV
         CZZA==
X-Gm-Message-State: AOAM533uccWiBBiHc4MzkzEQJ+uHciZOPTRSGh/58HC+58eZvVDnGpIW
        8b0d/sRHOekWLpQ9l+SjVxhwtihm6+qvDL4P
X-Google-Smtp-Source: ABdhPJxrJ7l9tl+SkBgTy8gabcqxPFM+NROf7mk/E7lsBVOjzAKLXwy2JTsLCEGrG44uBJpRbWYe3A==
X-Received: by 2002:a17:906:9743:: with SMTP id o3mr26060347ejy.256.1643809666915;
        Wed, 02 Feb 2022 05:47:46 -0800 (PST)
Received: from ?IPV6:2a02:1811:58c:8ef0:2c75:d3cf:ecb6:ad3? (ptr-7uiqtfr3zu1eqo2fumr.18120a2.ip6.access.telenet.be. [2a02:1811:58c:8ef0:2c75:d3cf:ecb6:ad3])
        by smtp.gmail.com with ESMTPSA id f19sm16105468edu.22.2022.02.02.05.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 05:47:46 -0800 (PST)
Message-ID: <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
Date:   Wed, 2 Feb 2022 14:47:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
 <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
From:   Timo Beckers <timo@incline.eu>
In-Reply-To: <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/2/22 08:17, Yonghong Song wrote:
> 
> 
> On 2/1/22 10:07 AM, Vincent Li wrote:
>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>
>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>
>>>>>> this is macro I suspected in my implementation that could cause issue with BTF
>>>>>>
>>>>>> #define ENABLE_VTEP 1
>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>> 0x2048a90a, }
>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>> #define VTEP_NUMS 4
>>>>>>
>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi
>>>>>>>
>>>>>>> While developing Cilium VTEP integration feature
>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>> implementation, the issue is described in
>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>>>>>> BTF and not sure if my implementation is seriously flawed or just some
>>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>>>>>> experts  are appreciated :-).
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Vincent
>>>>>
>>>>> Sorry for previous top post
>>>>>
>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
>>>>>
>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>> 0x2048a90a, }
>>>>>
>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
>>>>> member <=2. any reason why compiler would do that?
>>>>
>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>> you have some 32-byte constants which needs to be saved somewhere.
>>>> For example,
>>>>
>>>> $ cat t.c
>>>> struct t {
>>>>     long c[2];
>>>>     int d[4];
>>>> };
>>>> struct t g;
>>>> int test()
>>>> {
>>>>      struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>      g = tmp;
>>>>      return 0;
>>>> }
>>>>
>>>> $ clang -target bpf -O2 -c t.c
>>>> $ llvm-readelf -S t.o
>>>> ...
>>>>     [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
>>>> 20  AM  0   0  8
>>>> ...
>>>>
>>>> In the above code, if you change the struct size, say from 32 bytes to
>>>> 40 bytes, the rodata.cst32 will go away.
>>>
>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
>>
>> Hi Yonghong,
>>
>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
>> stores BTF type info in btf.Spec.namedTypes, but the elf object file
>> provided by user may have section like rodata.cst32 generated by
>> compiler that does not have accompanying BTF type info stored in
>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>> guaranteed to  have every BTF type info from application/user provided
>> elf object file ? I guess there is no guarantee.
> 
> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
> rodata.cst32 needs to be emitted, the type will be encoded in bpf
> program BTF.
> 
> Did you actually find an issue with .rodata.cst32 section? Such a
> section is typically generated by the compiler for initial data
> inside the function and llvm bpf backend tries to inline the
> values through a bunch of load instructions. So even you see
> .rodata.cst32, typically you can safely ignore it.
> 
>>
>> Vincent
> 

Hi Yonghong,

Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
since there are no symbols and no BTF info for that section.

The values found in .rodata.cst32 are indeed inlined in the bytecode as you
mentioned, so it seems like we can ignore it.

Why does the compiler emit these sections? cilium/ebpf assumed up until now
that all sections starting with '.rodata' are datasecs and must be loaded into
the kernel, which of course needs accompanying BTF.

What other .rodata.* should we expect?

Thanks,

Timo
