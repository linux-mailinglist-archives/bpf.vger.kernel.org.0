Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6328731200F
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBFUrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFUrC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 15:47:02 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A4C06174A;
        Sat,  6 Feb 2021 12:46:22 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y5so9196609ilg.4;
        Sat, 06 Feb 2021 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=wblMFryEfE03I8+svoYntwq6BTYoS+a2cimbwYQJhT0=;
        b=skDU450bdBV23wbanIhwI2wQmzmWmPlmbcaSIkgYVwsjb8ksnnsqHqn+e28Nz9Vnb2
         6jVIiLc16GnYpT741gOiOz/wAOaBwBju4uegD9aSzzvhhCkXJRyI9tFuGzD1fhFt2UMv
         j2XcQdtXInLh/4XtLgRfGGytJfR2O//p+eZlvP0QqgkHsbHO2GMV0Ni3u+HC9gPyiczE
         Owq/Riruq+pA2Z6ndpTMX1MRfr05d47V2H7zdCCqk9E9qCuLCJuYJrWb10/uzmqiI1NB
         i3/lAmc6Gm33BvTBtJiL75ZF/SGJjyuXcRtCS5j6RxcMZO4j57337XYyqfC0Elu+kK7M
         /nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wblMFryEfE03I8+svoYntwq6BTYoS+a2cimbwYQJhT0=;
        b=EZlX9I3lvtoZbLaXADftMkofCMHRcjXt/fgG7xMZb2XzOENjnRwY1zzQ/Fw5ZQJWTp
         CefwtSFGKP050mhTrZd9Z1V5ZXd0jMqtRkifHapZLR2LN/lWVB7lgqWDBULl398CsLaq
         lYhgBZsETPwsHTtnl7Y9SDx7BwRruXdY+vhTz78szX8OiBbclDrsnTPgpE3Pnk4XoROs
         ngK7iYibGOiCV6sIT0JBSTeBrcW32UVcDic+uNqNf56LVBGpGldYCYPALncKw52fI/cm
         EZkDGELi8CUSNK8kilea6YChlkI+rOnKM5Jixrp6WCLwA8kWorbh4JbHDrP/khIPgoXa
         V4Ng==
X-Gm-Message-State: AOAM533l2MdvNImmt0ImYx6oFXiP4ovMiWraMakhLs0NsGscFzLILRno
        l444hYFhRi8F9v3yvJP5qgP6+HCHNcJsAZiA0Hs=
X-Google-Smtp-Source: ABdhPJxg7P2qmy5kv7AuaOobkLPQNB1SW4PTuTVwi47B8Kj3OhXa90+5meJpJ8DM3PzewA5aGJJf5ua69XaUdJl3xmk=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr9748959ilr.10.1612644381687;
 Sat, 06 Feb 2021 12:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20210205192446.GH920417@kernel.org> <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
 <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com> <20210206162419.GC2851@wildebeest.org>
 <3f5a00ef-1c71-d0da-e9fd-c7f707760f5c@fb.com> <CA+icZUVfTH=yONintyJ+T8kvTrR4Q0gumJYNUCs6Ybraff5Kpg@mail.gmail.com>
 <64206fbc-656a-5ffd-6e9d-739c8c6f7410@fb.com> <CA+icZUUZVYN97wKiR9-LOwhQmxMSxggvm4MS4z9nLCvZOB8FLQ@mail.gmail.com>
 <CA+icZUV=-NmFtF9RQTRnbwBUiaPnroiSwyv-9RxA-3-nrgQ_rQ@mail.gmail.com>
 <89f15151-6843-b260-c8f4-88deefd7d569@fb.com> <CA+icZUVHtbOuXWh=9XMqVr6=Lo_YMPLhZa6XRN3pLTt=btRmpg@mail.gmail.com>
 <8b8e31bc-3deb-dcc4-8c51-4bd820855af6@fb.com>
In-Reply-To: <8b8e31bc-3deb-dcc4-8c51-4bd820855af6@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 21:46:10 +0100
Message-ID: <CA+icZUVDVchAbxxnpYK3Qcg4aLk_diF=wgrqj5xXuKOp95Zv-w@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>
Cc:     Mark Wieelard <mark@klomp.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:13 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/6/21 11:44 AM, Sedat Dilek wrote:
> > On Sat, Feb 6, 2021 at 8:33 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 2/6/21 11:28 AM, Sedat Dilek wrote:
> >>> On Sat, Feb 6, 2021 at 8:22 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>
> >>>> On Sat, Feb 6, 2021 at 8:17 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2/6/21 10:10 AM, Sedat Dilek wrote:
> >>>>>> On Sat, Feb 6, 2021 at 6:53 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2/6/21 8:24 AM, Mark Wieelard wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
> >>>>>>>>> With the above vmlinux, the issue appears to be handling
> >>>>>>>>> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
> >>>>>>>>>
> >>>>>>>>> The following patch should fix the issue:
> >>>>>>>>
> >>>>>>>> That doesn't really make sense to me. Why is the compiler emitting a
> >>>>>>>> DW_TAG_base_type that needs to be interpreted according to the
> >>>>>>>> DW_AT_name attribute?
> >>>>>>>>
> >>>>>>>> If the issue is that the size of the base type cannot be expressed in
> >>>>>>>> bytes then the DWARF spec provides the following option:
> >>>>>>>>
> >>>>>>>>         If the value of an object of the given type does not fully occupy
> >>>>>>>>         the storage described by a byte size attribute, the base type
> >>>>>>>>         entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
> >>>>>>>>         attribute, both of whose values are integer constant values (see
> >>>>>>>>         Section 2.19 on page 55). The bit size attribute describes the
> >>>>>>>>         actual size in bits used to represent values of the given
> >>>>>>>>         type. The data bit offset attribute is the offset in bits from the
> >>>>>>>>         beginning of the containing storage to the beginning of the
> >>>>>>>>         value. Bits that are part of the offset are padding.  If this
> >>>>>>>>         attribute is omitted a default data bit offset of zero is assumed.
> >>>>>>>>
> >>>>>>>> Would it be possible to use that encoding of those special types?  If
> >>>>>>>
> >>>>>>> I agree with you. I do not like comparing me as well. Unfortunately,
> >>>>>>> there is no enough information in dwarf to find out actual information.
> >>>>>>> The following is the dwarf dump with vmlinux (Sedat provided) for
> >>>>>>> DW_ATE_unsigned_1.
> >>>>>>>
> >>>>>>> 0x000e97e9:   DW_TAG_base_type
> >>>>>>>                     DW_AT_name      ("DW_ATE_unsigned_1")
> >>>>>>>                     DW_AT_encoding  (DW_ATE_unsigned)
> >>>>>>>                     DW_AT_byte_size (0x00)
> >>>>>>>
> >>>>>>> There is no DW_AT_bit_size and DW_AT_bit_offset for base type.
> >>>>>>> AFAIK, these two attributes typically appear in struct/union members
> >>>>>>> together with DW_AT_byte_size.
> >>>>>>>
> >>>>>>> Maybe compilers (clang in this case) can emit DW_AT_bit_size = 1
> >>>>>>> and DW_AT_bit_offset = 0/7 (depending on big/little endian) and
> >>>>>>> this case, we just test and get DW_AT_bit_size and it should work.
> >>>>>>>
> >>>>>>> But I think BTF does not need this (DW_ATE_unsigned_1) for now.
> >>>>>>> I checked dwarf dump and it is mostly used for some arith operation
> >>>>>>> encoded in dump (in this case, e.g., shift by 1 bit)
> >>>>>>>
> >>>>>>> 0x000015cf:   DW_TAG_base_type
> >>>>>>>                     DW_AT_name      ("DW_ATE_unsigned_1")
> >>>>>>>                     DW_AT_encoding  (DW_ATE_unsigned)
> >>>>>>>                     DW_AT_byte_size (0x00)
> >>>>>>>
> >>>>>>> 0x00010ed9:         DW_TAG_formal_parameter
> >>>>>>>                           DW_AT_location    (DW_OP_lit0, DW_OP_not,
> >>>>>>> DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1", DW_OP_convert
> >>>>>>> (0x000015d4) "DW_ATE_unsigned_8", DW_OP_stack_value)
> >>>>>>>                           DW_AT_abstract_origin     (0x00013984 "branch")
> >>>>>>>
> >>>>>>> Look at clang frontend, only the following types are encoded with
> >>>>>>> unsigned dwarf type.
> >>>>>>>
> >>>>>>>       case BuiltinType::UShort:
> >>>>>>>       case BuiltinType::UInt:
> >>>>>>>       case BuiltinType::UInt128:
> >>>>>>>       case BuiltinType::ULong:
> >>>>>>>       case BuiltinType::WChar_U:
> >>>>>>>       case BuiltinType::ULongLong:
> >>>>>>>         Encoding = llvm::dwarf::DW_ATE_unsigned;
> >>>>>>>         break;
> >>>>>>>
> >>>>>>>
> >>>>>>>> not, can we try to come up with some extension that doesn't require
> >>>>>>>> consumers to match magic names?
> >>>>>>>>
> >>>>>>
> >>>>>> You want me to upload mlx5_core.ko?
> >>>>>
> >>>>> I just sent out a patch. You are cc'ed. I also attached in this email.
> >>>>> Yes, it would be great if you can upload mlx5_core.ko so I can
> >>>>> double check with this DW_ATE_unsigned_160 which is really usual.
> >>>>>
> >>>>
> >>>> Yupp, just built a new pahole :-).
> >>>> Re-building linux-kernel...
> >>>>
> >>>> Will upload mlx5_core.ko - need zstd-ed it before.
> >>>>
> >>>
> >>> Hmm, I guess you want a mlx5_core.ko with your patch applied-to-pahole-1.20 :-)?
> >>
> >> this should work too. I want to check dwarf data. My patch won't impact
> >> dwarf generation.
> >>
> >
> > Usual Dropbox-Link:
> >
> > https://www.dropbox.com/sh/kvyh8ps7na0r1h5/AABfyNfDZ2bESse_bo4h05fFa?dl=0
> >
> > See "for-yhs" directory:
> >
> > 1. mlx5-module_yhs-v1 ("[PATCH dwarves] btf_encoder: sanitize
> > non-regular int base type")
> > 2. mlx5-module_yhs-dileks-v4 (with the last diff-v4 I tried successfully)
>
> Thanks, with llvm-dwarfdump, I can see
>
> 0x00d65616:   DW_TAG_base_type
>                  DW_AT_name      ("DW_ATE_unsigned_160")
>                  DW_AT_encoding  (DW_ATE_unsigned)
>                  DW_AT_byte_size (0x14)
>
> 0x00d88e81:         DW_TAG_variable
>                        DW_AT_location    (indexed (0xad) loclist =
> 0x0005df42:
>                           [0x0000000000088c8e, 0x0000000000088c97):
> DW_OP_breg9 R9+0, DW_OP_convert (0x00d65616) "DW_ATE_unsigned_160",
> DW_OP_convert (0x00d65607) "DW_ATE_unsigned_32", DW_OP_stack_value,
> DW_OP_piece 0x4)
>                        DW_AT_abstract_origin     (0x00d88d37 "_v")
>
>
> 0x00d88d37:       DW_TAG_variable
>                      DW_AT_name  ("_v")
>                      DW_AT_decl_file
> ("/home/dileks/src/linux-kernel/git/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c")
>                      DW_AT_decl_line     (1198)
>                      DW_AT_type  (0x00d68835 "u32")
>
> The source code at line 1198.
> 1198         DR_STE_SET_MASK_V(eth_l3_ipv4_5_tuple, bit_mask,
> 1199                           source_port, mask, udp_sport);
>
> This is for struct mlx5dr_match_spec.
>
> struct mlx5dr_match_spec {
>          u32 smac_47_16;         /* Source MAC address of incoming packet */
>          /* Incoming packet Ethertype - this is the Ethertype
>           * following the last VLAN tag of the packet
>           */
>          u32 ethertype:16;
>          u32 smac_15_0:16;
> ...
>          u32 tcp_dport:16;
>          /* TCP source port.;tcp and udp sport/dport are mutually
> exclusive */
>          u32 tcp_sport:16;
>          u32 ttl_hoplimit:8;
>          u32 reserved:24;
>          /* UDP destination port.;tcp and udp sport/dport are mutually
> exclusive */
>          u32 udp_dport:16;
>          /* UDP source port.;tcp and udp sport/dport are mutually
> exclusive */
>          u32 udp_sport:16;
>          /* IPv6 source address of incoming packets
>           * For IPv4 address use bits 31:0 (rest of the bits are reserved)
>           * This field should be qualified by an appropriate ethertype
>           */
>          u32 src_ip_127_96;
> ...
> }
>
> which includes a bunch of bit fields and non-bit fields.
>
> I have no idea why clang will generate
>     DW_OP_convert (0x00d65616) "DW_ATE_unsigned_160"
> and possibly try to capture more semantic information?
> But BTF should be able to safely ignore this as described
> in my patch.
>
> Thanks.
>

[ CC Fangrui - the only guy I know who might comment on this ]

Fangrui, feel free to comment?

Get the patch "[PATCH dwarves] btf_encoder: sanitize non-regular int
base type" from Yonghong Son:

link="https://lore.kernel.org/r/20210206191350.830616-1-yhs@fb.com"
b4 -d am $link

I commented the success in the other thread.
Sorry for cross-posting.

Big Thank-You Yonghong!

- Sedat -


- Sedat -

> >
> > - Sedat -
> >
> >>>
> >>>> - Sedat -
> >>>>
> >>>>>>
> >>>>>> When looking with llvm-dwarf for DW_ATE_unsigned_160:
> >>>>>>
> >>>>>> 0x00d65616:   DW_TAG_base_type
> >>>>>>                   DW_AT_name      ("DW_ATE_unsigned_160")
> >>>>>>                   DW_AT_encoding  (DW_ATE_unsigned)
> >>>>>>                   DW_AT_byte_size (0x14)
> >>>>>>
> >>>>>> If you need further information, please let me know.
> >>>>>>
> >>>>>> Thanks.
> >>>>>>
> >>>>>> - Sedat -
> >>>>>>
