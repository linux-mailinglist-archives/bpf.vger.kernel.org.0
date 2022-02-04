Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5614AA03D
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiBDTjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:39:55 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35630 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiBDTjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:39:55 -0500
Received: by mail-ed1-f47.google.com with SMTP id n10so15140597edv.2
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiQmT1tpWy+ktQizfZqpz2cKC3xsCmq5Yxr2vWqC0f8=;
        b=bRKVAE7ZIYokpDI2pVJ7q6Ny3ndlpy5QZEgmvSUDPPvpaBMwHpZKPblctqw1jKpyZA
         g2xKSaEYQs2dJahU2MRu4bHqUnMzOV/aLXgXVzd7D5BsovAYaTjgQ82VG3nivtb4uzwJ
         z25HF194CxU/08r0e8PiagJaet01fMlmvA4CzlZeU2dVL/m8zGsS8n8kdylh6Si4z/4O
         oDv6iAfDJ6xvbVGAOeePqy/EoC+V5u+dUt6Bfmm2GJ9aW4fnn9L5GDvaiS8qewumhv2Y
         cpl36lUFnqDeUNfQKKknVm3+diKeDTshaYebe9J/c5k5yL4aL7o2g5ZpkMNexrrvwnQV
         Aslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiQmT1tpWy+ktQizfZqpz2cKC3xsCmq5Yxr2vWqC0f8=;
        b=FurSPWn7L2EZ0JQB23IY6weixGjFD72u1kQGc8Slfki7VUWQYdOYeHHthvid5NmNpX
         tVmJziEvHYSE+/kkVQBDId6c739Xr5tOFlent3MYFpOIpDpKaM8fZdcwz20plP67Vj80
         vgUIua86nYaSqaZTpNRAe3GVtNmM0xeBIvuCSXOVnIe82M7OZdNFxuI9vVmzgxWCCtK0
         FtdUTQMed5M6xR790mB3xCFN6f6vtPfDeuBGIjSjMCyZs6wAsULfHCwAltnNq5M2JJBa
         w+yymDcyFIpRsaFDQigflSTL4A9NCt2aInA01u8Cjo3Mql4g/yNTu7+Hq4PL3Z7tkMwb
         SgZw==
X-Gm-Message-State: AOAM531TyKrA3gZBqJr4EU8/I4G4Gv5pYntzRninVceO30PL26SeBKxl
        ZH9KMPNLRgk8VFm7pXhb+1qDkwKZfU8BLsMGAa8z4luUrlvpKA==
X-Google-Smtp-Source: ABdhPJyzKsndJ9UhwMq4+Y/goXv754vv+HSXzgXRNv9hoJxmzxhKbr9x0+075MkiXXI7zNgC1x2tu+dJdLMd9en+M6E=
X-Received: by 2002:aa7:cdc6:: with SMTP id h6mr741080edw.140.1644003594097;
 Fri, 04 Feb 2022 11:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com> <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com> <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
 <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com> <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
 <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com>
In-Reply-To: <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Fri, 4 Feb 2022 11:39:42 -0800
Message-ID: <CAK3+h2zMRNKqA5k6FE4BG8RnJ2Tx1itVJiJGbhXaCu=v=0U47w@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     Yonghong Song <yhs@fb.com>
Cc:     Timo Beckers <timo@incline.eu>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 10:04 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/4/22 3:11 AM, Timo Beckers wrote:
> > On 2/3/22 03:11, Yonghong Song wrote:
> >>
> >>
> >> On 2/2/22 5:47 AM, Timo Beckers wrote:
> >>> On 2/2/22 08:17, Yonghong Song wrote:
> >>>>
> >>>>
> >>>> On 2/1/22 10:07 AM, Vincent Li wrote:
> >>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>>>
> >>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
> >>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> this is macro I suspected in my implementation that could cause issue with BTF
> >>>>>>>>>
> >>>>>>>>> #define ENABLE_VTEP 1
> >>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> >>>>>>>>> 0x2048a90a, }
> >>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
> >>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
> >>>>>>>>> #define VTEP_NUMS 4
> >>>>>>>>>
> >>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi
> >>>>>>>>>>
> >>>>>>>>>> While developing Cilium VTEP integration feature
> >>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
> >>>>>>>>>> that seems related to BTF and probably caused by my specific
> >>>>>>>>>> implementation, the issue is described in
> >>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
> >>>>>>>>>> BTF and not sure if my implementation is seriously flawed or just some
> >>>>>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
> >>>>>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
> >>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
> >>>>>>>>>> experts  are appreciated :-).
> >>>>>>>>>>
> >>>>>>>>>> Thanks
> >>>>>>>>>>
> >>>>>>>>>> Vincent
> >>>>>>>>
> >>>>>>>> Sorry for previous top post
> >>>>>>>>
> >>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
> >>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
> >>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
> >>>>>>>>
> >>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> >>>>>>>> 0x2048a90a, }
> >>>>>>>>
> >>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
> >>>>>>>> member <=2. any reason why compiler would do that?
> >>>>>>>
> >>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
> >>>>>>> you have some 32-byte constants which needs to be saved somewhere.
> >>>>>>> For example,
> >>>>>>>
> >>>>>>> $ cat t.c
> >>>>>>> struct t {
> >>>>>>>       long c[2];
> >>>>>>>       int d[4];
> >>>>>>> };
> >>>>>>> struct t g;
> >>>>>>> int test()
> >>>>>>> {
> >>>>>>>        struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
> >>>>>>>        g = tmp;
> >>>>>>>        return 0;
> >>>>>>> }
> >>>>>>>
> >>>>>>> $ clang -target bpf -O2 -c t.c
> >>>>>>> $ llvm-readelf -S t.o
> >>>>>>> ...
> >>>>>>>       [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
> >>>>>>> 20  AM  0   0  8
> >>>>>>> ...
> >>>>>>>
> >>>>>>> In the above code, if you change the struct size, say from 32 bytes to
> >>>>>>> 40 bytes, the rodata.cst32 will go away.
> >>>>>>
> >>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
> >>>>>
> >>>>> Hi Yonghong,
> >>>>>
> >>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
> >>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object file
> >>>>> provided by user may have section like rodata.cst32 generated by
> >>>>> compiler that does not have accompanying BTF type info stored in
> >>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
> >>>>> guaranteed to  have every BTF type info from application/user provided
> >>>>> elf object file ? I guess there is no guarantee.
> >>>>
> >>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
> >>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
> >>>> program BTF.
> >>>>
> >>>> Did you actually find an issue with .rodata.cst32 section? Such a
> >>>> section is typically generated by the compiler for initial data
> >>>> inside the function and llvm bpf backend tries to inline the
> >>>> values through a bunch of load instructions. So even you see
> >>>> .rodata.cst32, typically you can safely ignore it.
> >>>>
> >>>>>
> >>>>> Vincent
> >>>>
> >>>
> >>> Hi Yonghong,
> >>>
> >>> Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
> >>> since there are no symbols and no BTF info for that section.
> >>>
> >>> The values found in .rodata.cst32 are indeed inlined in the bytecode as you
> >>> mentioned, so it seems like we can ignore it.
> >>>
> >>> Why does the compiler emit these sections? cilium/ebpf assumed up until now
> >>> that all sections starting with '.rodata' are datasecs and must be loaded into
> >>> the kernel, which of course needs accompanying BTF.
> >>
> >> The clang frontend emits these .rodata.* sections. In early days, kernel
> >> doesn't support global data so llvm bpf backend implements an
> >> optimization to inline these values. But llvm bpf backend didn't completely remove them as the backend doesn't have a global view
> >> whether these .rodata.* are being used in other places or not.
> >>
> >> Now, llvm bpf backend has better infrastructure and we probably can
> >> implement an IR pass to detect all uses of .rodata.*, inline these
> >> uses, and remove the .rodata.* global variable.
> >>
> >> You can check relocation section of the program text. If the .rodata.*
> >> section is referenced, you should preserve it. Otherwise, you can
> >> ignore that .rodata.* section.
> >>
> >>>
> >>> What other .rodata.* should we expect?
> >>
> >> Glancing through llvm code, you may see .rodata.{4,8,16,32},
> >> .rodata.str*.
> >>
> >>>
> >>> Thanks,
> >>>
> >>> Timo
> >
> > Thanks for the replies all, very insightful. We were already doing things mostly
> > right wrt. .rodata.*, but found a few subtle bugs walking through the code again.
> >
> > I've gotten a hold of the ELF Vincent was trying to load, and I saw a few things
> > that I found unusual. In his case, the values in cst32 are not inlined. Instead,
> > this ELF has a .Lconstinit symbol pointing at the start of .rodata.cst32, and it's
> > an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly strict and requires
> > STT_OBJECTs to be global (for supporting non-static consts).
>
> There are two ways to resolve the issue. First, extend the loader
> support to handle STB_LOCAL as well. Or Second, change the code like
>      struct t v = {1, 5, 29, ...};
> to
>      struct t v;
>      __builtin_memset(&v, 0, sizeof(struct t));
>      v.field1 = ...;
>      v.field2 = ...;
>
>
> >
> > ---
> > ~ llvm-readelf -ar bpf_lxc.o
> >
> > Symbol table '.symtab' contains 606 entries:
> >     Num:    Value          Size Type    Bind   Vis       Ndx Name
> >       2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21 .Lconstinit
> >
> > Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
> >      Offset             Info             Type               Symbol's Value  Symbol's Name
> > 0000000000007300  0000000200000001 R_BPF_64_64            0000000000000000 .Lconstinit
> > ---
> >
> > ---
> > ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
> > warning: failed to compute relocation: R_BPF_64_64, Invalid data was encountered while parsing the file
> > ... <2 more of these> ...
> >
> > Disassembly of section 2/7:
> >
> > 00000000000072f8 <LBB1_476>:
> >      3679:       67 08 00 00 03 00 00 00 r8 <<= 3
> >      3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
> >                  0000000000007300:  R_BPF_64_64  .Lconstinit
> >      3682:       0f 82 00 00 00 00 00 00 r2 += r8
> >      3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
> >      3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
> >
> > Disassembly of section .rodata.cst32:
> >
> > 0000000000000000 <.Lconstinit>:
> >         0:       82 36 4c 98 2e 56 00 00 <unknown>
> >         1:       82 36 4c 98 2e 55 00 00 <unknown>
> > ---
> >
> >
> > This symbol doesn't exist in the program. Worth noting is that the code that accesses
> > this static data sits within a subscope, but not sure what the effect of this would be.
> >
> > Vincent, maybe try removing the enclosing {} to see if that changes anything?
> >
> > ---
> > static __always_inline int foo(struct __ctx_buff *ctx,
> >
> > ... <snip> ...
> >
> >       {
> >               int i;
> >
> >               for (i = 0; i < VTEP_NUMS; i) {
> >                       if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
> >                               vtep_mac = VTEP_MAC[i];
> >                               break;
> >                       }
> >               }
> >       }
> > ---
> >
> > Is this perhaps something that needs to be addressed in the compiler?
>
> If you can give a reproducible test (with .c or .i file), I can take a
> look at what is missing in llvm compiler and improve it.
>

not sure if it would help, here is my step to generate the bpf_lxc.o
object file with the .rodata.cst32

git clone https://github.com/f5devcentral/cilium.git
cd cilium; git checkout vli-vxlan; KERNEL=54 make -C bpf
llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf/bpf_lxc.o

> >
> >
> > Thanks again,
> >
> > Timo
