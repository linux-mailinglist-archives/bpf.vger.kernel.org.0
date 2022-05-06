Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2251DA30
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358221AbiEFOPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390335AbiEFOPK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 10:15:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA65F68
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 07:11:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba17so8861295edb.5
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline.eu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zSr/lX8dOyOPVqBcMuE2oz2egzgNdNj8XIfjCgQm6IY=;
        b=W2gm2Vu7N9nQMs5shaS/b6CgMT/FJ+aTf0vs1+YmnPn4bYDbhCo+igaPVuNAWf2mRp
         4y69wV481Kfpjk1pAfYc+VgOhxle6GA/fSa/nU4fR1xJSbOCs68un+uVoH6FiLQ+ZhG9
         BQs6GH6NRvhwFS0cuQaNqM7+vurW3fpSNv6MVrBEt4QsH+NNeeXC/RFYvD0Prfk6ZJAn
         RscXVfJevo71htb2NA9jPBHlN4dSSpuxf8ihFNu9MOoBRpcvQNXhLFpbsz0mekPxq8IC
         tJWoyHLlubLuRvK+xPEHpF5/uWbQcR+uA1OpbsJgWgyFpGBEesC8D55fHN7Tsc3XZdFq
         +uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zSr/lX8dOyOPVqBcMuE2oz2egzgNdNj8XIfjCgQm6IY=;
        b=G2ZhKJrxakVy8EBaWExaiJNsSdARGXz43xlRzJtqNTl0iCKL17JOPPWgjk9pUmv6zS
         lw5WSgd1weYSR/G39HvrksvIsxmGckcnsiLVBrVhwJZ2xUaIIaq/oR9EkJfawjyFjUJx
         k7q8hvQap7cSAIdGRFm/VpRAJhW6/ZVyJPn8WuiWyaFgzafr3u8sCR2m5+fHWMTFaDyY
         b3AW5qZH+FCQjukfKe5WepnaeP3McRPz368vn7/Ys5Bpgu9RSRZ/ufLaCcu+dG86tpXT
         NUllOscSdTdoVhKOh9AEa0ksyqBoVpsb0hyngxcsFDjlmrEXhOoOmTv/bIWt7a5syVN5
         v+jQ==
X-Gm-Message-State: AOAM530ScmBFPlRu81OqG3LTTsaIIpPwZhVX172bdQopdqzneqxg8VhD
        LSHzdteo+Ho/1b5pEyIf2BphvQ==
X-Google-Smtp-Source: ABdhPJwAFoDByHC1mnpn36tchauGEEdakKqIBmVAwvc7elWfFbrTyMyNW2dkOQqyxJjlipioaAJlHA==
X-Received: by 2002:a05:6402:17c7:b0:425:d52c:8907 with SMTP id s7-20020a05640217c700b00425d52c8907mr3594253edy.15.1651846284309;
        Fri, 06 May 2022 07:11:24 -0700 (PDT)
Received: from ?IPV6:2a02:1811:525:4ef0:d6e9:5e5a:76a1:b582? (ptr-7u327b4znttbosg92ma.18120a2.ip6.access.telenet.be. [2a02:1811:525:4ef0:d6e9:5e5a:76a1:b582])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7dc4a000000b0042617ba63basm2264839edu.68.2022.05.06.07.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 07:11:23 -0700 (PDT)
Message-ID: <a141fab8-d848-23bc-87c4-929eba183506@incline.eu>
Date:   Fri, 6 May 2022 16:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Vincent Li <vincent.mc.li@gmail.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
 <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
 <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
 <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com>
 <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
 <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com>
 <CAK3+h2zMRNKqA5k6FE4BG8RnJ2Tx1itVJiJGbhXaCu=v=0U47w@mail.gmail.com>
 <5bc02911-9ebf-6f4a-3804-d72c405326b6@fb.com>
 <a9afc769-5e6c-cdb9-7adf-90ed1a6c1974@fb.com>
 <CAK3+h2zD0NGjGoqK8rZqtp=-c4e7YV8OJEooun1XF8=y1kxo+A@mail.gmail.com>
 <CAK3+h2wNtitdBANw+qW+HoAkKfJynM9EH4xuom4Zi1UsrkiS6A@mail.gmail.com>
 <78c73411-690b-5cd0-d149-32009cacb9d9@fb.com>
 <CAK3+h2yVcFiLziO5+ti6T+Qs-Q-W9jQwK11fO6vmuZMy7hoHKg@mail.gmail.com>
From:   Timo Beckers <timo@incline.eu>
In-Reply-To: <CAK3+h2yVcFiLziO5+ti6T+Qs-Q-W9jQwK11fO6vmuZMy7hoHKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/22 20:53, Vincent Li wrote:
> On Wed, Feb 9, 2022 at 11:34 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/8/22 10:48 AM, Vincent Li wrote:
>>> On Tue, Feb 8, 2022 at 10:28 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>
>>>> On Mon, Feb 7, 2022 at 10:47 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/4/22 1:22 PM, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 2/4/22 11:39 AM, Vincent Li wrote:
>>>>>>> On Fri, Feb 4, 2022 at 10:04 AM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/4/22 3:11 AM, Timo Beckers wrote:
>>>>>>>>> On 2/3/22 03:11, Yonghong Song wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2/2/22 5:47 AM, Timo Beckers wrote:
>>>>>>>>>>> On 2/2/22 08:17, Yonghong Song wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>>>>>>>>>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li
>>>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li
>>>>>>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> this is macro I suspected in my implementation that could
>>>>>>>>>>>>>>>>> cause issue with BTF
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> #define ENABLE_VTEP 1
>>>>>>>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a,
>>>>>>>>>>>>>>>>> 0x1f48a90a,
>>>>>>>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>>>>>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>>>>>>>>>>>> #define VTEP_NUMS 4
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li
>>>>>>>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Hi
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>>>>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a
>>>>>>>>>>>>>>>>>> strange issue
>>>>>>>>>>>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>>>>>>>>>>>> implementation, the issue is described in
>>>>>>>>>>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know
>>>>>>>>>>>>>>>>>> much about
>>>>>>>>>>>>>>>>>> BTF and not sure if my implementation is seriously flawed
>>>>>>>>>>>>>>>>>> or just some
>>>>>>>>>>>>>>>>>> implementation bug or maybe not compatible with BTF.
>>>>>>>>>>>>>>>>>> Strangely, the
>>>>>>>>>>>>>>>>>> issue appears related to number of VTEPs I use, no problem
>>>>>>>>>>>>>>>>>> with 1 or 2
>>>>>>>>>>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance
>>>>>>>>>>>>>>>>>> from BTF
>>>>>>>>>>>>>>>>>> experts  are appreciated :-).
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Vincent
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Sorry for previous top post
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>>>>>>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>>>>>>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2
>>>>>>>>>>>>>>>> members
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a,
>>>>>>>>>>>>>>>> 0x1f48a90a,
>>>>>>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above
>>>>>>>>>>>>>>>> VTEP_ENDPOINT
>>>>>>>>>>>>>>>> member <=2. any reason why compiler would do that?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>>>>>>>>>>>> you have some 32-byte constants which needs to be saved
>>>>>>>>>>>>>>> somewhere.
>>>>>>>>>>>>>>> For example,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> $ cat t.c
>>>>>>>>>>>>>>> struct t {
>>>>>>>>>>>>>>>         long c[2];
>>>>>>>>>>>>>>>         int d[4];
>>>>>>>>>>>>>>> };
>>>>>>>>>>>>>>> struct t g;
>>>>>>>>>>>>>>> int test()
>>>>>>>>>>>>>>> {
>>>>>>>>>>>>>>>          struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>>>>>>>>>>>          g = tmp;
>>>>>>>>>>>>>>>          return 0;
>>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> $ clang -target bpf -O2 -c t.c
>>>>>>>>>>>>>>> $ llvm-readelf -S t.o
>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>         [ 4] .rodata.cst32     PROGBITS        0000000000000000
>>>>>>>>>>>>>>> 0000a8 000020
>>>>>>>>>>>>>>> 20  AM  0   0  8
>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In the above code, if you change the struct size, say from 32
>>>>>>>>>>>>>>> bytes to
>>>>>>>>>>>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize
>>>>>>>>>>>>>> rodata.cst32 then
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Yonghong,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux
>>>>>>>>>>>>> and
>>>>>>>>>>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object
>>>>>>>>>>>>> file
>>>>>>>>>>>>> provided by user may have section like rodata.cst32 generated by
>>>>>>>>>>>>> compiler that does not have accompanying BTF type info stored in
>>>>>>>>>>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>>>>>>>>>>>> guaranteed to  have every BTF type info from application/user
>>>>>>>>>>>>> provided
>>>>>>>>>>>>> elf object file ? I guess there is no guarantee.
>>>>>>>>>>>>
>>>>>>>>>>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>>>>>>>>>>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>>>>>>>>>>>> program BTF.
>>>>>>>>>>>>
>>>>>>>>>>>> Did you actually find an issue with .rodata.cst32 section? Such a
>>>>>>>>>>>> section is typically generated by the compiler for initial data
>>>>>>>>>>>> inside the function and llvm bpf backend tries to inline the
>>>>>>>>>>>> values through a bunch of load instructions. So even you see
>>>>>>>>>>>> .rodata.cst32, typically you can safely ignore it.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Vincent
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi Yonghong,
>>>>>>>>>>>
>>>>>>>>>>> Thanks for the reproducer. Couldn't figure out what to do with
>>>>>>>>>>> .rodata.cst32,
>>>>>>>>>>> since there are no symbols and no BTF info for that section.
>>>>>>>>>>>
>>>>>>>>>>> The values found in .rodata.cst32 are indeed inlined in the
>>>>>>>>>>> bytecode as you
>>>>>>>>>>> mentioned, so it seems like we can ignore it.
>>>>>>>>>>>
>>>>>>>>>>> Why does the compiler emit these sections? cilium/ebpf assumed up
>>>>>>>>>>> until now
>>>>>>>>>>> that all sections starting with '.rodata' are datasecs and must be
>>>>>>>>>>> loaded into
>>>>>>>>>>> the kernel, which of course needs accompanying BTF.
>>>>>>>>>>
>>>>>>>>>> The clang frontend emits these .rodata.* sections. In early days,
>>>>>>>>>> kernel
>>>>>>>>>> doesn't support global data so llvm bpf backend implements an
>>>>>>>>>> optimization to inline these values. But llvm bpf backend didn't
>>>>>>>>>> completely remove them as the backend doesn't have a global view
>>>>>>>>>> whether these .rodata.* are being used in other places or not.
>>>>>>>>>>
>>>>>>>>>> Now, llvm bpf backend has better infrastructure and we probably can
>>>>>>>>>> implement an IR pass to detect all uses of .rodata.*, inline these
>>>>>>>>>> uses, and remove the .rodata.* global variable.
>>>>>>>>>>
>>>>>>>>>> You can check relocation section of the program text. If the .rodata.*
>>>>>>>>>> section is referenced, you should preserve it. Otherwise, you can
>>>>>>>>>> ignore that .rodata.* section.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> What other .rodata.* should we expect?
>>>>>>>>>>
>>>>>>>>>> Glancing through llvm code, you may see .rodata.{4,8,16,32},
>>>>>>>>>> .rodata.str*.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>>
>>>>>>>>>>> Timo
>>>>>>>>>
>>>>>>>>> Thanks for the replies all, very insightful. We were already doing
>>>>>>>>> things mostly
>>>>>>>>> right wrt. .rodata.*, but found a few subtle bugs walking through
>>>>>>>>> the code again.
>>>>>>>>>
>>>>>>>>> I've gotten a hold of the ELF Vincent was trying to load, and I saw
>>>>>>>>> a few things
>>>>>>>>> that I found unusual. In his case, the values in cst32 are not
>>>>>>>>> inlined. Instead,
>>>>>>>>> this ELF has a .Lconstinit symbol pointing at the start of
>>>>>>>>> .rodata.cst32, and it's
>>>>>>>>> an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly
>>>>>>>>> strict and requires
>>>>>>>>> STT_OBJECTs to be global (for supporting non-static consts).
>>>>>>>>
>>>>>>>> There are two ways to resolve the issue. First, extend the loader
>>>>>>>> support to handle STB_LOCAL as well. Or Second, change the code like
>>>>>>>>        struct t v = {1, 5, 29, ...};
>>>>>>>> to
>>>>>>>>        struct t v;
>>>>>>>>        __builtin_memset(&v, 0, sizeof(struct t));
>>>>>>>>        v.field1 = ...;
>>>>>>>>        v.field2 = ...;
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> ~ llvm-readelf -ar bpf_lxc.o
>>>>>>>>>
>>>>>>>>> Symbol table '.symtab' contains 606 entries:
>>>>>>>>>       Num:    Value          Size Type    Bind   Vis       Ndx Name
>>>>>>>>>         2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21
>>>>>>>>> .Lconstinit
>>>>>>>>>
>>>>>>>>> Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
>>>>>>>>>        Offset             Info             Type
>>>>>>>>> Symbol's Value  Symbol's Name
>>>>>>>>> 0000000000007300  0000000200000001 R_BPF_64_64
>>>>>>>>> 0000000000000000 .Lconstinit
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
>>>>>>>>> warning: failed to compute relocation: R_BPF_64_64, Invalid data was
>>>>>>>>> encountered while parsing the file
>>>>>>>>> ... <2 more of these> ...
>>>>>>>>>
>>>>>>>>> Disassembly of section 2/7:
>>>>>>>>>
>>>>>>>>> 00000000000072f8 <LBB1_476>:
>>>>>>>>>        3679:       67 08 00 00 03 00 00 00 r8 <<= 3
>>>>>>>>>        3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2
>>>>>>>>> = 0 ll
>>>>>>>>>                    0000000000007300:  R_BPF_64_64  .Lconstinit
>>>>>>>>>        3682:       0f 82 00 00 00 00 00 00 r2 += r8
>>>>>>>>>        3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
>>>>>>>>>        3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
>>>>>>>>>
>>>>>>>>> Disassembly of section .rodata.cst32:
>>>>>>>>>
>>>>>>>>> 0000000000000000 <.Lconstinit>:
>>>>>>>>>           0:       82 36 4c 98 2e 56 00 00 <unknown>
>>>>>>>>>           1:       82 36 4c 98 2e 55 00 00 <unknown>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This symbol doesn't exist in the program. Worth noting is that the
>>>>>>>>> code that accesses
>>>>>>>>> this static data sits within a subscope, but not sure what the
>>>>>>>>> effect of this would be.
>>>>>>>>>
>>>>>>>>> Vincent, maybe try removing the enclosing {} to see if that changes
>>>>>>>>> anything?
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> static __always_inline int foo(struct __ctx_buff *ctx,
>>>>>>>>>
>>>>>>>>> ... <snip> ...
>>>>>>>>>
>>>>>>>>>         {
>>>>>>>>>                 int i;
>>>>>>>>>
>>>>>>>>>                 for (i = 0; i < VTEP_NUMS; i) {
>>>>>>>>>                         if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>>>>>>>>>                                 vtep_mac = VTEP_MAC[i];
>>>>>>>>>                                 break;
>>>>>>>>>                         }
>>>>>>>>>                 }
>>>>>>>>>         }
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Is this perhaps something that needs to be addressed in the compiler?
>>>>>>>>
>>>>>>>> If you can give a reproducible test (with .c or .i file), I can take a
>>>>>>>> look at what is missing in llvm compiler and improve it.
>>>>>>>>
>>>>>>>
>>>>>>> not sure if it would help, here is my step to generate the bpf_lxc.o
>>>>>>> object file with the .rodata.cst32
>>>>>>>
>>>>>>> git clone https://github.com/f5devcentral/cilium.git
>>>>>>> cd cilium; git checkout vli-vxlan; KERNEL=54 make -C bpf
>>>>>>> llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf/bpf_lxc.o
>>>>>>
>>>>>> Thanks. I can reproduce the issue now. Will take a look
>>>>>> and get back to you as soon as I got any concrete results.
>>>>>
>>>>> Okay, I found the reason.
>>>>>
>>>>> For the code,
>>>>>
>>>>>                   for (i = 0; i < VTEP_NUMS; i++) {
>>>>>                           if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>>>>>                                   vtep_mac = VTEP_MAC[i];
>>>>>                                   break;
>>>>>                           }
>>>>>                   }
>>>>>
>>>>> The compiler transformed to something like
>>>>>
>>>>> i = 0; if (tunnerl_endpoint == VTEP_ENDPOINT[0]) goto end;
>>>>> i = 1; if (tunnerl_endpoint == VTEP_ENDPOINT[1]) goto end;
>>>>> i = 2; if (tunnerl_endpoint == VTEP_ENDPOINT[2]) goto end;
>>>>> i = 3; if (tunnerl_endpoint == VTEP_ENDPOINT[3]) goto end;
>>>>>
>>>>> end:
>>>>>      vtep_mac = VTEP_MAC[i];
>>>>>
>>>>> The compiler cannot inline VTEP_MAC[i] since 'i' is not
>>>>> a constant. Hence later we have a memory load from
>>>>> a non-global .rodata section.
>>>>>
>>>>> As I mentioned earlier, there are two options to fix the issue.
>>>>> First is for cilium to track and handle non-global .rodata
>>>>> sections. And the second you can apply the below code change,
>>>>>
>>>>> diff --git a/bpf/node_config.h b/bpf/node_config.h
>>>>> index 9783e44548..b80dd2b27b 100644
>>>>> --- a/bpf/node_config.h
>>>>> +++ b/bpf/node_config.h
>>>>> @@ -176,15 +176,15 @@ DEFINE_IPV6(HOST_IP, 0xbe, 0xef, 0x0, 0x0, 0x0,
>>>>> 0x0, 0x0, 0x1, 0x0, 0x0, 0xa, 0x
>>>>>    #endif
>>>>>
>>>>>    #ifdef ENABLE_VTEP
>>>>> -#define VTEP_ENDPOINT (__u32[]){0xeb48a90a, 0xec48a90a, 0xed48a90a,
>>>>> 0xee48a90a, }
>>>>> +#define VTEP_NUMS 4
>>>>> +__u32 VTEP_ENDPOINT[VTEP_NUMS] = {0xeb48a90a, 0xec48a90a, 0xed48a90a,
>>>>> 0xee48a90a};
>>>>>    /* HEX representation of VTEP IP
>>>>>     * 10.169.72.235, 10.169.72.236, 10.169.72.237, 10.169.72.238
>>>>>     */
>>>>> -#define VTEP_MAC (__u64[]){0x562e984c3682, 0x552e984c3682,
>>>>> 0x542e984c3682, 0x532e984c3682}
>>>>> +__u64 VTEP_MAC[VTEP_NUMS] = {0x562e984c3682, 0x552e984c3682,
>>>>> 0x542e984c3682, 0x532e984c3682};
>>>>>    /* VTEP MAC address
>>>>>     * 82:36:4c:89:2e:56, 82:36:4c:89:2e:55, 82:36:4c:89:2e:54,
>>>>> 82:36:4c:89:2e:53
>>>>>     */
>>>>> -#define VTEP_NUMS 4
>>>>>    #endif
>>>>>
>>>>
>>>
>>> I may misunderstand you, I thought your suggestion would stop compiler
>>> generating .rodata.cst32, but it appears
>>>   the compiler still generated .rodata.cst32 after applying your changes
>>>
>>> readelf -e bpf/bpf_lxc.o | grep 'rodata'
>>>
>>>    [51] .rodata.cst32     PROGBITS         0000000000000000  00045f48
>>
>> In my case, I didn't have rodata section.
>> compiled with `KERNEL=54 make -C bpf`
>> clang is latest upstream:
>>    clang --version
>>    clang version 15.0.0 (https://github.com/llvm/llvm-project.git
>> 4f97aa7e1d70f1b259e5fddd85de05235b01b192)
>> But I think any recent compiler should have the same result.
>>    readelf -e bpf/bpf_lxc.o | grep 'rodata'
>>    <no output>
>>
> 
> I see, thanks for checking  again, my clang is 12.0.1, I guess it is
> not recent enough :).
> 
>>>
>>>> Thank you Yonghong for the suggestion, the original code is kind of
>>>> hack from me to work around some issue :). now we decided to abandon
>>>> above code and use BPF hash map for VTEP lookup in Cilium to avoid
>>>> this issue and to be more flexible, so it is up to cilium/ebpf to
>>>> decide to address the rodata or not.
>>>>
>>>>>    /* It appears that we can support around the below number of prefixes
>>>>> in an
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks again,
>>>>>>>>>
>>>>>>>>> Timo

Hi all,

Sorry to dig up this thread. I looked into this again last week, this time with
the help of Dylan Reimerink. We came up with a minimal repro:

---

#include <linux/bpf.h>

#define values (__u32[]){0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7}

int test(int ctx)
{
    __u32 out = 0;

    int i;
    for (i = 0; i < 2; i++) {
      if (ctx == values[i]) {
        out = values[i];
        break;
      }
    }

    return out;
}

---

I'm compiling with 13.0.1.

- Emits a .rodata.cst32 section, but only if there are exactly 8 elements in 'values'.
- Same result if 'values' is an array of 4 u64's, so the fact that it's related to initializing
  32-bit values somewhat confuses me.
- When changing 'values' to 7 or 9 entries, there's a .rodata BTF datasec of size=0 vlen=0 instead
  of a .rodata.cst32.
- If a .rodata.cst32 is emitted, it doesn't have a corresponding BTF datasec at all.
- The 'ctx == values[i]' comparisons are inlined, but 'out = values[i]' results in a datasec read.

Unfortunately, the resulting ELF does not contain a .Lconstinit symbol pointing at the start of
.rodata.cst32, but it can still be found in the IR:

---

.Ltmp11:
        r0 <<= 2
        r1 = .Lconstinit.1 ll
        r1 += r0
        r0 = *(u32 *)(r1 + 0)

---

In the initial repro Vincent posted, this symbol made it into the ELF, but that's with an older LLVM.

These are my takeaways for the loader side, please correct me if I'm wrong:

- As you've mentioned in this thread, it's not predictable which section 'values' will end up in,
  so userspace always needs to look for constants/globals in .(ro)data*, not just .(ro)data.
- A BTF datasec may not be present at all for ELF data sections that only contain anonymous vars.
- A BTF datasec may only partially describe a data section; e.g. some bytes in the section represent
  vars, but some bytes can be anonymous and are omitted from BTF info.

Then, what aboue accepting relo's against local symbols (like .Lconstinit)? I don't know why we
currently reject them, but it seems to be a good canary for subtle compiler bugs. Maybe that's
something that can be fixed in LLVM.

Thank you,

Timo
