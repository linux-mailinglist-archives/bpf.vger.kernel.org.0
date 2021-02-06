Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD8311FA8
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBFTXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 14:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFTXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 14:23:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2602C061756;
        Sat,  6 Feb 2021 11:22:56 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id f6so10886059ioz.5;
        Sat, 06 Feb 2021 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DQmO3mg80r3OKtyPli4oz6o3zmfNJdQV7vSPc1cuY68=;
        b=e7ewS050yrjZeiXDn3mqTzd+57//bg37iZZAUce3lQfHifJaZPiK2DwnMjbaRZ5IAa
         YVEO8d0ji0TyvDmGq6ZFyXtQyen0u88amsJJqZjF1fUF2Wq+/DFCWpAEar2vlyVspDPT
         A4eEwl1TUwZqLQwn5kJWI/96L7UeaHkOSiMMMZxuMKWRbA7i2UA/SfhVToH9rPRo8lrl
         UTukFvhgXyS1nRH/4iUy1OnupxetgdqsnoIofkTBKVU7vOJaKG4zOEyM82CUSl3NrqD5
         UOtinAi+kjJ0eW1eCqzL2UjWGB/6xUZ4FI6MHQVvNon34vPt23FrcqS8Qxb69dl0gMeP
         Aa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DQmO3mg80r3OKtyPli4oz6o3zmfNJdQV7vSPc1cuY68=;
        b=H7ckcjFzb3jfaB2PFTrIcaA26PpVhOwBBptXSCqvBnZ7iFhIFzuN+sSVb4xDtQAMQQ
         jPGy8j7gWY/Cq1GPtzxUe3G0n3f5jF6Gb6vQw9PnvKv38J5SFtLhxXtxO+Mn6544DpwE
         N90USTzFGaosxcH70sWofcrWGQWZktNVZkssEqs+veWPCO/TUJQRSmEBOfiyypPGbIkL
         6MT1RkkklM1vmBqk07S+JNH2ou2jSufsgxwW/tY3D0heeob24D/wx97DrnKUJG71e2Vk
         FeU1zzN7sgr9G1Nx4tH004ILuSygjg7QTfmUwUvxp1BqKtILH5yb9vfqrCacbOavfbI+
         URQw==
X-Gm-Message-State: AOAM530JXKWbK1nGamXVCzDB1FFEvDjaowmqb6W6t4+6L5oO7axekwcw
        GXwReOPPkPkdoLQxNh9bgr+zftuM7+o167yqRqW73acNfPNOaJzc
X-Google-Smtp-Source: ABdhPJwjg/oPjI1w4G3lKA1nEWy7jITlyR1UosjJLGN3E2ASZ/mpX+f1fLWZWzGIChESEHMfoo9gEIcGX/lxBkmF1lg=
X-Received: by 2002:a6b:e006:: with SMTP id z6mr9578836iog.110.1612639376253;
 Sat, 06 Feb 2021 11:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20210205192446.GH920417@kernel.org> <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
 <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com> <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com> <20210206162419.GC2851@wildebeest.org>
 <3f5a00ef-1c71-d0da-e9fd-c7f707760f5c@fb.com> <CA+icZUVfTH=yONintyJ+T8kvTrR4Q0gumJYNUCs6Ybraff5Kpg@mail.gmail.com>
 <64206fbc-656a-5ffd-6e9d-739c8c6f7410@fb.com>
In-Reply-To: <64206fbc-656a-5ffd-6e9d-739c8c6f7410@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 20:22:44 +0100
Message-ID: <CA+icZUUZVYN97wKiR9-LOwhQmxMSxggvm4MS4z9nLCvZOB8FLQ@mail.gmail.com>
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
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 8:17 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/6/21 10:10 AM, Sedat Dilek wrote:
> > On Sat, Feb 6, 2021 at 6:53 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 2/6/21 8:24 AM, Mark Wieelard wrote:
> >>> Hi,
> >>>
> >>> On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
> >>>> With the above vmlinux, the issue appears to be handling
> >>>> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
> >>>>
> >>>> The following patch should fix the issue:
> >>>
> >>> That doesn't really make sense to me. Why is the compiler emitting a
> >>> DW_TAG_base_type that needs to be interpreted according to the
> >>> DW_AT_name attribute?
> >>>
> >>> If the issue is that the size of the base type cannot be expressed in
> >>> bytes then the DWARF spec provides the following option:
> >>>
> >>>       If the value of an object of the given type does not fully occupy
> >>>       the storage described by a byte size attribute, the base type
> >>>       entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
> >>>       attribute, both of whose values are integer constant values (see
> >>>       Section 2.19 on page 55). The bit size attribute describes the
> >>>       actual size in bits used to represent values of the given
> >>>       type. The data bit offset attribute is the offset in bits from the
> >>>       beginning of the containing storage to the beginning of the
> >>>       value. Bits that are part of the offset are padding.  If this
> >>>       attribute is omitted a default data bit offset of zero is assumed.
> >>>
> >>> Would it be possible to use that encoding of those special types?  If
> >>
> >> I agree with you. I do not like comparing me as well. Unfortunately,
> >> there is no enough information in dwarf to find out actual information.
> >> The following is the dwarf dump with vmlinux (Sedat provided) for
> >> DW_ATE_unsigned_1.
> >>
> >> 0x000e97e9:   DW_TAG_base_type
> >>                   DW_AT_name      ("DW_ATE_unsigned_1")
> >>                   DW_AT_encoding  (DW_ATE_unsigned)
> >>                   DW_AT_byte_size (0x00)
> >>
> >> There is no DW_AT_bit_size and DW_AT_bit_offset for base type.
> >> AFAIK, these two attributes typically appear in struct/union members
> >> together with DW_AT_byte_size.
> >>
> >> Maybe compilers (clang in this case) can emit DW_AT_bit_size = 1
> >> and DW_AT_bit_offset = 0/7 (depending on big/little endian) and
> >> this case, we just test and get DW_AT_bit_size and it should work.
> >>
> >> But I think BTF does not need this (DW_ATE_unsigned_1) for now.
> >> I checked dwarf dump and it is mostly used for some arith operation
> >> encoded in dump (in this case, e.g., shift by 1 bit)
> >>
> >> 0x000015cf:   DW_TAG_base_type
> >>                   DW_AT_name      ("DW_ATE_unsigned_1")
> >>                   DW_AT_encoding  (DW_ATE_unsigned)
> >>                   DW_AT_byte_size (0x00)
> >>
> >> 0x00010ed9:         DW_TAG_formal_parameter
> >>                         DW_AT_location    (DW_OP_lit0, DW_OP_not,
> >> DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1", DW_OP_convert
> >> (0x000015d4) "DW_ATE_unsigned_8", DW_OP_stack_value)
> >>                         DW_AT_abstract_origin     (0x00013984 "branch")
> >>
> >> Look at clang frontend, only the following types are encoded with
> >> unsigned dwarf type.
> >>
> >>     case BuiltinType::UShort:
> >>     case BuiltinType::UInt:
> >>     case BuiltinType::UInt128:
> >>     case BuiltinType::ULong:
> >>     case BuiltinType::WChar_U:
> >>     case BuiltinType::ULongLong:
> >>       Encoding = llvm::dwarf::DW_ATE_unsigned;
> >>       break;
> >>
> >>
> >>> not, can we try to come up with some extension that doesn't require
> >>> consumers to match magic names?
> >>>
> >
> > You want me to upload mlx5_core.ko?
>
> I just sent out a patch. You are cc'ed. I also attached in this email.
> Yes, it would be great if you can upload mlx5_core.ko so I can
> double check with this DW_ATE_unsigned_160 which is really usual.
>

Yupp, just built a new pahole :-).
Re-building linux-kernel...

Will upload mlx5_core.ko - need zstd-ed it before.

- Sedat -

> >
> > When looking with llvm-dwarf for DW_ATE_unsigned_160:
> >
> > 0x00d65616:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_160")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x14)
> >
> > If you need further information, please let me know.
> >
> > Thanks.
> >
> > - Sedat -
> >
