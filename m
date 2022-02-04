Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7864A983A
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbiBDLLm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 06:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbiBDLLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 06:11:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCBC061714
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 03:11:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p15so18282281ejc.7
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline.eu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RCffiy2omlFTVaMj6hNESR+KX00YnRkUsIIxEyHnARI=;
        b=WOi55GVH8qL+6l/Vs/NVc7G4bI6fM6mR2DnnF8AE9DFdCylYiTWJ5Rth9f1I/GfMCt
         rutv1IK07TT2jKWLdvitd9lgGolNGcqrzlKkZEitKQnm1RIIX6cj0e5cfAQg6tM4Zfpl
         okzfxmAMlVRK+dfoNgP+JHHEnNOPfeBQO7gc7B33NN2YreACKItGf28Z3sNtKw3JM4E8
         9MhrdmUQE6jYKzp9VVjahW+Yso9H68Ou2glI5VZykbMvqp80Qy7uTw+gVYtFBb9BaNs0
         qzyULygyLpNx4Wfp+pGfSbn/w7DolyNUrMQIZKuB5pwKSn9CliS2AOa89ZTJNEB/KEPA
         YWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RCffiy2omlFTVaMj6hNESR+KX00YnRkUsIIxEyHnARI=;
        b=dzWI6HuvyKPcl83QnHL6O+IZXeDTV/r9PsTHgxXzKzbpEYXxP8nnpST44j2m8DNsry
         vbntqeWodbfccrtCXMpb9QBbg2/QXh/pHzD/efGP27cn6qtk/BX5UqjK3RO/7NrLUp6H
         7b0ioASlPRTrn9OoWkA368iqSNU1IqWCKCKbv/INcxAs9lTC+JfDmD56gg8ag7y3nQiT
         KHsDVTMdGq7OdMiaT9DNjNbRn75BUzzRNqEQWSl9AbqtVgvB96uOIWP+i1uoTqQ+OV9p
         5NNe10qUyNzJPJipW2w21cqry6FeWrmRALlQ1M25ZVl3u4PfTel8W2+qdEjgUrHCtJve
         owXA==
X-Gm-Message-State: AOAM533br93xSvxk9dIN2AbAUhlVH+qUrXPBLdyAJrstTGoIOOnnwmlh
        DOOfqdeyUI7VO6W05tDlJT5nW7NjaUd+htuO
X-Google-Smtp-Source: ABdhPJxx6PuvN2GM+d82eQCJucLmDg2CjnR0yX+qjXsgQibvfIM3fgloJYafx1HUWBpNRXZyQbHK7A==
X-Received: by 2002:a17:907:8a0a:: with SMTP id sc10mr2117854ejc.332.1643973098497;
        Fri, 04 Feb 2022 03:11:38 -0800 (PST)
Received: from ?IPV6:2a02:1811:58c:8ef0:aefe:f260:1157:991c? (ptr-7uiqtft3gi3iq2kkizg.18120a2.ip6.access.telenet.be. [2a02:1811:58c:8ef0:aefe:f260:1157:991c])
        by smtp.gmail.com with ESMTPSA id p23sm696621edx.86.2022.02.04.03.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 03:11:38 -0800 (PST)
Message-ID: <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
Date:   Fri, 4 Feb 2022 12:11:36 +0100
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
 <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
 <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com>
From:   Timo Beckers <timo@incline.eu>
In-Reply-To: <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/22 03:11, Yonghong Song wrote:
> 
> 
> On 2/2/22 5:47 AM, Timo Beckers wrote:
>> On 2/2/22 08:17, Yonghong Song wrote:
>>>
>>>
>>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>
>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>
>>>>>>>> this is macro I suspected in my implementation that could cause issue with BTF
>>>>>>>>
>>>>>>>> #define ENABLE_VTEP 1
>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>>> 0x2048a90a, }
>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>>> #define VTEP_NUMS 4
>>>>>>>>
>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi
>>>>>>>>>
>>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>>> implementation, the issue is described in
>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>>>>>>>> BTF and not sure if my implementation is seriously flawed or just some
>>>>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>>>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>>>>>>>> experts  are appreciated :-).
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>> Vincent
>>>>>>>
>>>>>>> Sorry for previous top post
>>>>>>>
>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
>>>>>>>
>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>> 0x2048a90a, }
>>>>>>>
>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
>>>>>>> member <=2. any reason why compiler would do that?
>>>>>>
>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>>> you have some 32-byte constants which needs to be saved somewhere.
>>>>>> For example,
>>>>>>
>>>>>> $ cat t.c
>>>>>> struct t {
>>>>>>      long c[2];
>>>>>>      int d[4];
>>>>>> };
>>>>>> struct t g;
>>>>>> int test()
>>>>>> {
>>>>>>       struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>>       g = tmp;
>>>>>>       return 0;
>>>>>> }
>>>>>>
>>>>>> $ clang -target bpf -O2 -c t.c
>>>>>> $ llvm-readelf -S t.o
>>>>>> ...
>>>>>>      [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
>>>>>> 20  AM  0   0  8
>>>>>> ...
>>>>>>
>>>>>> In the above code, if you change the struct size, say from 32 bytes to
>>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>>
>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
>>>>
>>>> Hi Yonghong,
>>>>
>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object file
>>>> provided by user may have section like rodata.cst32 generated by
>>>> compiler that does not have accompanying BTF type info stored in
>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>>> guaranteed to  have every BTF type info from application/user provided
>>>> elf object file ? I guess there is no guarantee.
>>>
>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>>> program BTF.
>>>
>>> Did you actually find an issue with .rodata.cst32 section? Such a
>>> section is typically generated by the compiler for initial data
>>> inside the function and llvm bpf backend tries to inline the
>>> values through a bunch of load instructions. So even you see
>>> .rodata.cst32, typically you can safely ignore it.
>>>
>>>>
>>>> Vincent
>>>
>>
>> Hi Yonghong,
>>
>> Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
>> since there are no symbols and no BTF info for that section.
>>
>> The values found in .rodata.cst32 are indeed inlined in the bytecode as you
>> mentioned, so it seems like we can ignore it.
>>
>> Why does the compiler emit these sections? cilium/ebpf assumed up until now
>> that all sections starting with '.rodata' are datasecs and must be loaded into
>> the kernel, which of course needs accompanying BTF.
> 
> The clang frontend emits these .rodata.* sections. In early days, kernel
> doesn't support global data so llvm bpf backend implements an
> optimization to inline these values. But llvm bpf backend didn't completely remove them as the backend doesn't have a global view
> whether these .rodata.* are being used in other places or not.
> 
> Now, llvm bpf backend has better infrastructure and we probably can
> implement an IR pass to detect all uses of .rodata.*, inline these
> uses, and remove the .rodata.* global variable.
> 
> You can check relocation section of the program text. If the .rodata.*
> section is referenced, you should preserve it. Otherwise, you can
> ignore that .rodata.* section.
> 
>>
>> What other .rodata.* should we expect?
> 
> Glancing through llvm code, you may see .rodata.{4,8,16,32},
> .rodata.str*.
> 
>>
>> Thanks,
>>
>> Timo

Thanks for the replies all, very insightful. We were already doing things mostly
right wrt. .rodata.*, but found a few subtle bugs walking through the code again.

I've gotten a hold of the ELF Vincent was trying to load, and I saw a few things
that I found unusual. In his case, the values in cst32 are not inlined. Instead,
this ELF has a .Lconstinit symbol pointing at the start of .rodata.cst32, and it's
an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly strict and requires
STT_OBJECTs to be global (for supporting non-static consts).

---
~ llvm-readelf -ar bpf_lxc.o

Symbol table '.symtab' contains 606 entries:
   Num:    Value          Size Type    Bind   Vis       Ndx Name
     2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21 .Lconstinit

Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name
0000000000007300  0000000200000001 R_BPF_64_64            0000000000000000 .Lconstinit
---

---
~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
warning: failed to compute relocation: R_BPF_64_64, Invalid data was encountered while parsing the file
... <2 more of these> ...

Disassembly of section 2/7:

00000000000072f8 <LBB1_476>:
    3679:       67 08 00 00 03 00 00 00 r8 <<= 3
    3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
                0000000000007300:  R_BPF_64_64  .Lconstinit
    3682:       0f 82 00 00 00 00 00 00 r2 += r8
    3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
    3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2

Disassembly of section .rodata.cst32:

0000000000000000 <.Lconstinit>:
       0:       82 36 4c 98 2e 56 00 00 <unknown>
       1:       82 36 4c 98 2e 55 00 00 <unknown>
---


This symbol doesn't exist in the program. Worth noting is that the code that accesses
this static data sits within a subscope, but not sure what the effect of this would be.

Vincent, maybe try removing the enclosing {} to see if that changes anything?

---
static __always_inline int foo(struct __ctx_buff *ctx,

... <snip> ...

	{
		int i;

		for (i = 0; i < VTEP_NUMS; i) {
			if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
				vtep_mac = VTEP_MAC[i];
				break;
			}
		}
	}
---

Is this perhaps something that needs to be addressed in the compiler?


Thanks again,

Timo
