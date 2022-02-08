Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4E4AE0CA
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiBHS3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 13:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiBHS3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 13:29:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB5EC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 10:29:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id st12so294885ejc.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQ7ETPhFowJy5gbmxe8tao+bGKyuYJi8tAGsIEg/zsE=;
        b=cUMosPvwxokRyNK/6yylTo0k35rEwMimwkiFo8H43tS9g6j5CAKcCRUs3ivF/RFMwR
         McJe/6V8qKgB0gn/QhP/VbpZuCcShJusgqHNA9RKuSFrGmxb3dudbKcDxejgBaKPbQRi
         GOwcQZwU243PxahRNZhX0Tu2zNBmqc08kdGISLzo0ycCBzyCU1/cvOV25R/GKQNjVRw0
         Q0aTiego0KEbl86TJ1KfAi4/z3ookFc3fPFi3l8k15+9eJETD/fv18ouKdz+7Z+JvXU2
         q63wKXqm5Y/7s2GkmyOvnaYZH5pRv7qn0fgK/qe0kaerPi2rSAnr1aq0LcWwcKfXwX67
         z2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQ7ETPhFowJy5gbmxe8tao+bGKyuYJi8tAGsIEg/zsE=;
        b=Pj1W+wqs6D0vN0R/VnnfASOnsK2S6rdHDWnPQLEOTZHAKki39qo7fo+07Nm4fGKHuF
         sMfoj6PM8HxNFqpqWzDcbb77X16b1HMSZL/+Nzk3dmWrc61XTzZfimDeWMLwi8JONwkW
         Nr8n1UU0rcX1W31VnwceYsbn7wCaZblIV7ngCAqIcrboiTQ4pJgnHD/fJPpJ5vacK5B2
         msNhGcg23RbD6MjB1p+GfJSjU7FkNGbse1KaBXCS6G5Ou2Dfgw1LDuqCiUpekPRZctkq
         wb3sZtAV9/4FGzcolr2Rhms58cghkDfYaPEAvttrLioaga1Kaw9RQN3ONtXcWPNYASmm
         9W0w==
X-Gm-Message-State: AOAM530HgEJYN0TTy4tnohELNsa09FBWnKrLOQajhkcE/islkGu1gClD
        NrBzPGIn3dXTApYHnYZjpHgIzxjKcMe6JKkfqww=
X-Google-Smtp-Source: ABdhPJwBJuqe45bAcz0X18qZtb1l9kNo07Lvo3hJAEDtYjpXVsLrlTyf6PMMf9GvTYrm77NlKmudMSlAvG41ZZMY9h8=
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr4751560ejd.443.1644344938456;
 Tue, 08 Feb 2022 10:28:58 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com> <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com> <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
 <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com> <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
 <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com> <CAK3+h2zMRNKqA5k6FE4BG8RnJ2Tx1itVJiJGbhXaCu=v=0U47w@mail.gmail.com>
 <5bc02911-9ebf-6f4a-3804-d72c405326b6@fb.com> <a9afc769-5e6c-cdb9-7adf-90ed1a6c1974@fb.com>
In-Reply-To: <a9afc769-5e6c-cdb9-7adf-90ed1a6c1974@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 8 Feb 2022 10:28:46 -0800
Message-ID: <CAK3+h2zD0NGjGoqK8rZqtp=-c4e7YV8OJEooun1XF8=y1kxo+A@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     Yonghong Song <yhs@fb.com>
Cc:     Timo Beckers <timo@incline.eu>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 10:47 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/4/22 1:22 PM, Yonghong Song wrote:
> >
> >
> > On 2/4/22 11:39 AM, Vincent Li wrote:
> >> On Fri, Feb 4, 2022 at 10:04 AM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2/4/22 3:11 AM, Timo Beckers wrote:
> >>>> On 2/3/22 03:11, Yonghong Song wrote:
> >>>>>
> >>>>>
> >>>>> On 2/2/22 5:47 AM, Timo Beckers wrote:
> >>>>>> On 2/2/22 08:17, Yonghong Song wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2/1/22 10:07 AM, Vincent Li wrote:
> >>>>>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li
> >>>>>>>> <vincent.mc.li@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
> >>>>>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li
> >>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> this is macro I suspected in my implementation that could
> >>>>>>>>>>>> cause issue with BTF
> >>>>>>>>>>>>
> >>>>>>>>>>>> #define ENABLE_VTEP 1
> >>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a,
> >>>>>>>>>>>> 0x1f48a90a,
> >>>>>>>>>>>> 0x2048a90a, }
> >>>>>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
> >>>>>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
> >>>>>>>>>>>> #define VTEP_NUMS 4
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li
> >>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Hi
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> While developing Cilium VTEP integration feature
> >>>>>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a
> >>>>>>>>>>>>> strange issue
> >>>>>>>>>>>>> that seems related to BTF and probably caused by my specific
> >>>>>>>>>>>>> implementation, the issue is described in
> >>>>>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know
> >>>>>>>>>>>>> much about
> >>>>>>>>>>>>> BTF and not sure if my implementation is seriously flawed
> >>>>>>>>>>>>> or just some
> >>>>>>>>>>>>> implementation bug or maybe not compatible with BTF.
> >>>>>>>>>>>>> Strangely, the
> >>>>>>>>>>>>> issue appears related to number of VTEPs I use, no problem
> >>>>>>>>>>>>> with 1 or 2
> >>>>>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance
> >>>>>>>>>>>>> from BTF
> >>>>>>>>>>>>> experts  are appreciated :-).
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Vincent
> >>>>>>>>>>>
> >>>>>>>>>>> Sorry for previous top post
> >>>>>>>>>>>
> >>>>>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
> >>>>>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
> >>>>>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2
> >>>>>>>>>>> members
> >>>>>>>>>>>
> >>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a,
> >>>>>>>>>>> 0x1f48a90a,
> >>>>>>>>>>> 0x2048a90a, }
> >>>>>>>>>>>
> >>>>>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above
> >>>>>>>>>>> VTEP_ENDPOINT
> >>>>>>>>>>> member <=2. any reason why compiler would do that?
> >>>>>>>>>>
> >>>>>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
> >>>>>>>>>> you have some 32-byte constants which needs to be saved
> >>>>>>>>>> somewhere.
> >>>>>>>>>> For example,
> >>>>>>>>>>
> >>>>>>>>>> $ cat t.c
> >>>>>>>>>> struct t {
> >>>>>>>>>>        long c[2];
> >>>>>>>>>>        int d[4];
> >>>>>>>>>> };
> >>>>>>>>>> struct t g;
> >>>>>>>>>> int test()
> >>>>>>>>>> {
> >>>>>>>>>>         struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
> >>>>>>>>>>         g = tmp;
> >>>>>>>>>>         return 0;
> >>>>>>>>>> }
> >>>>>>>>>>
> >>>>>>>>>> $ clang -target bpf -O2 -c t.c
> >>>>>>>>>> $ llvm-readelf -S t.o
> >>>>>>>>>> ...
> >>>>>>>>>>        [ 4] .rodata.cst32     PROGBITS        0000000000000000
> >>>>>>>>>> 0000a8 000020
> >>>>>>>>>> 20  AM  0   0  8
> >>>>>>>>>> ...
> >>>>>>>>>>
> >>>>>>>>>> In the above code, if you change the struct size, say from 32
> >>>>>>>>>> bytes to
> >>>>>>>>>> 40 bytes, the rodata.cst32 will go away.
> >>>>>>>>>
> >>>>>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize
> >>>>>>>>> rodata.cst32 then
> >>>>>>>>
> >>>>>>>> Hi Yonghong,
> >>>>>>>>
> >>>>>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux
> >>>>>>>> and
> >>>>>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object
> >>>>>>>> file
> >>>>>>>> provided by user may have section like rodata.cst32 generated by
> >>>>>>>> compiler that does not have accompanying BTF type info stored in
> >>>>>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
> >>>>>>>> guaranteed to  have every BTF type info from application/user
> >>>>>>>> provided
> >>>>>>>> elf object file ? I guess there is no guarantee.
> >>>>>>>
> >>>>>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
> >>>>>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
> >>>>>>> program BTF.
> >>>>>>>
> >>>>>>> Did you actually find an issue with .rodata.cst32 section? Such a
> >>>>>>> section is typically generated by the compiler for initial data
> >>>>>>> inside the function and llvm bpf backend tries to inline the
> >>>>>>> values through a bunch of load instructions. So even you see
> >>>>>>> .rodata.cst32, typically you can safely ignore it.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Vincent
> >>>>>>>
> >>>>>>
> >>>>>> Hi Yonghong,
> >>>>>>
> >>>>>> Thanks for the reproducer. Couldn't figure out what to do with
> >>>>>> .rodata.cst32,
> >>>>>> since there are no symbols and no BTF info for that section.
> >>>>>>
> >>>>>> The values found in .rodata.cst32 are indeed inlined in the
> >>>>>> bytecode as you
> >>>>>> mentioned, so it seems like we can ignore it.
> >>>>>>
> >>>>>> Why does the compiler emit these sections? cilium/ebpf assumed up
> >>>>>> until now
> >>>>>> that all sections starting with '.rodata' are datasecs and must be
> >>>>>> loaded into
> >>>>>> the kernel, which of course needs accompanying BTF.
> >>>>>
> >>>>> The clang frontend emits these .rodata.* sections. In early days,
> >>>>> kernel
> >>>>> doesn't support global data so llvm bpf backend implements an
> >>>>> optimization to inline these values. But llvm bpf backend didn't
> >>>>> completely remove them as the backend doesn't have a global view
> >>>>> whether these .rodata.* are being used in other places or not.
> >>>>>
> >>>>> Now, llvm bpf backend has better infrastructure and we probably can
> >>>>> implement an IR pass to detect all uses of .rodata.*, inline these
> >>>>> uses, and remove the .rodata.* global variable.
> >>>>>
> >>>>> You can check relocation section of the program text. If the .rodata.*
> >>>>> section is referenced, you should preserve it. Otherwise, you can
> >>>>> ignore that .rodata.* section.
> >>>>>
> >>>>>>
> >>>>>> What other .rodata.* should we expect?
> >>>>>
> >>>>> Glancing through llvm code, you may see .rodata.{4,8,16,32},
> >>>>> .rodata.str*.
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>> Timo
> >>>>
> >>>> Thanks for the replies all, very insightful. We were already doing
> >>>> things mostly
> >>>> right wrt. .rodata.*, but found a few subtle bugs walking through
> >>>> the code again.
> >>>>
> >>>> I've gotten a hold of the ELF Vincent was trying to load, and I saw
> >>>> a few things
> >>>> that I found unusual. In his case, the values in cst32 are not
> >>>> inlined. Instead,
> >>>> this ELF has a .Lconstinit symbol pointing at the start of
> >>>> .rodata.cst32, and it's
> >>>> an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly
> >>>> strict and requires
> >>>> STT_OBJECTs to be global (for supporting non-static consts).
> >>>
> >>> There are two ways to resolve the issue. First, extend the loader
> >>> support to handle STB_LOCAL as well. Or Second, change the code like
> >>>       struct t v = {1, 5, 29, ...};
> >>> to
> >>>       struct t v;
> >>>       __builtin_memset(&v, 0, sizeof(struct t));
> >>>       v.field1 = ...;
> >>>       v.field2 = ...;
> >>>
> >>>
> >>>>
> >>>> ---
> >>>> ~ llvm-readelf -ar bpf_lxc.o
> >>>>
> >>>> Symbol table '.symtab' contains 606 entries:
> >>>>      Num:    Value          Size Type    Bind   Vis       Ndx Name
> >>>>        2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21
> >>>> .Lconstinit
> >>>>
> >>>> Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
> >>>>       Offset             Info             Type
> >>>> Symbol's Value  Symbol's Name
> >>>> 0000000000007300  0000000200000001 R_BPF_64_64
> >>>> 0000000000000000 .Lconstinit
> >>>> ---
> >>>>
> >>>> ---
> >>>> ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
> >>>> warning: failed to compute relocation: R_BPF_64_64, Invalid data was
> >>>> encountered while parsing the file
> >>>> ... <2 more of these> ...
> >>>>
> >>>> Disassembly of section 2/7:
> >>>>
> >>>> 00000000000072f8 <LBB1_476>:
> >>>>       3679:       67 08 00 00 03 00 00 00 r8 <<= 3
> >>>>       3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2
> >>>> = 0 ll
> >>>>                   0000000000007300:  R_BPF_64_64  .Lconstinit
> >>>>       3682:       0f 82 00 00 00 00 00 00 r2 += r8
> >>>>       3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
> >>>>       3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
> >>>>
> >>>> Disassembly of section .rodata.cst32:
> >>>>
> >>>> 0000000000000000 <.Lconstinit>:
> >>>>          0:       82 36 4c 98 2e 56 00 00 <unknown>
> >>>>          1:       82 36 4c 98 2e 55 00 00 <unknown>
> >>>> ---
> >>>>
> >>>>
> >>>> This symbol doesn't exist in the program. Worth noting is that the
> >>>> code that accesses
> >>>> this static data sits within a subscope, but not sure what the
> >>>> effect of this would be.
> >>>>
> >>>> Vincent, maybe try removing the enclosing {} to see if that changes
> >>>> anything?
> >>>>
> >>>> ---
> >>>> static __always_inline int foo(struct __ctx_buff *ctx,
> >>>>
> >>>> ... <snip> ...
> >>>>
> >>>>        {
> >>>>                int i;
> >>>>
> >>>>                for (i = 0; i < VTEP_NUMS; i) {
> >>>>                        if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
> >>>>                                vtep_mac = VTEP_MAC[i];
> >>>>                                break;
> >>>>                        }
> >>>>                }
> >>>>        }
> >>>> ---
> >>>>
> >>>> Is this perhaps something that needs to be addressed in the compiler?
> >>>
> >>> If you can give a reproducible test (with .c or .i file), I can take a
> >>> look at what is missing in llvm compiler and improve it.
> >>>
> >>
> >> not sure if it would help, here is my step to generate the bpf_lxc.o
> >> object file with the .rodata.cst32
> >>
> >> git clone https://github.com/f5devcentral/cilium.git
> >> cd cilium; git checkout vli-vxlan; KERNEL=54 make -C bpf
> >> llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf/bpf_lxc.o
> >
> > Thanks. I can reproduce the issue now. Will take a look
> > and get back to you as soon as I got any concrete results.
>
> Okay, I found the reason.
>
> For the code,
>
>                  for (i = 0; i < VTEP_NUMS; i++) {
>                          if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>                                  vtep_mac = VTEP_MAC[i];
>                                  break;
>                          }
>                  }
>
> The compiler transformed to something like
>
> i = 0; if (tunnerl_endpoint == VTEP_ENDPOINT[0]) goto end;
> i = 1; if (tunnerl_endpoint == VTEP_ENDPOINT[1]) goto end;
> i = 2; if (tunnerl_endpoint == VTEP_ENDPOINT[2]) goto end;
> i = 3; if (tunnerl_endpoint == VTEP_ENDPOINT[3]) goto end;
>
> end:
>     vtep_mac = VTEP_MAC[i];
>
> The compiler cannot inline VTEP_MAC[i] since 'i' is not
> a constant. Hence later we have a memory load from
> a non-global .rodata section.
>
> As I mentioned earlier, there are two options to fix the issue.
> First is for cilium to track and handle non-global .rodata
> sections. And the second you can apply the below code change,
>
> diff --git a/bpf/node_config.h b/bpf/node_config.h
> index 9783e44548..b80dd2b27b 100644
> --- a/bpf/node_config.h
> +++ b/bpf/node_config.h
> @@ -176,15 +176,15 @@ DEFINE_IPV6(HOST_IP, 0xbe, 0xef, 0x0, 0x0, 0x0,
> 0x0, 0x0, 0x1, 0x0, 0x0, 0xa, 0x
>   #endif
>
>   #ifdef ENABLE_VTEP
> -#define VTEP_ENDPOINT (__u32[]){0xeb48a90a, 0xec48a90a, 0xed48a90a,
> 0xee48a90a, }
> +#define VTEP_NUMS 4
> +__u32 VTEP_ENDPOINT[VTEP_NUMS] = {0xeb48a90a, 0xec48a90a, 0xed48a90a,
> 0xee48a90a};
>   /* HEX representation of VTEP IP
>    * 10.169.72.235, 10.169.72.236, 10.169.72.237, 10.169.72.238
>    */
> -#define VTEP_MAC (__u64[]){0x562e984c3682, 0x552e984c3682,
> 0x542e984c3682, 0x532e984c3682}
> +__u64 VTEP_MAC[VTEP_NUMS] = {0x562e984c3682, 0x552e984c3682,
> 0x542e984c3682, 0x532e984c3682};
>   /* VTEP MAC address
>    * 82:36:4c:89:2e:56, 82:36:4c:89:2e:55, 82:36:4c:89:2e:54,
> 82:36:4c:89:2e:53
>    */
> -#define VTEP_NUMS 4
>   #endif
>

Thank you Yonghong for the suggestion, the original code is kind of
hack from me to work around some issue :). now we decided to abandon
above code and use BPF hash map for VTEP lookup in Cilium to avoid
this issue and to be more flexible, so it is up to cilium/ebpf to
decide to address the rodata or not.

>   /* It appears that we can support around the below number of prefixes
> in an
>
> >
> >>
> >>>>
> >>>>
> >>>> Thanks again,
> >>>>
> >>>> Timo
