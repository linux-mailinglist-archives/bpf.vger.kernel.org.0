Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3534F77D
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 05:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhCaD3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhCaD2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 23:28:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B46C061574;
        Tue, 30 Mar 2021 20:28:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h8so7203734plt.7;
        Tue, 30 Mar 2021 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N2Ay2yW9Gv/JT4ajx/UMq3XMlPy4mHOsCh9hdgJxm/Q=;
        b=tXbauTvV4y9GzFQl8nYGgKSPLuHCg/XvsIamCI9KhJ7F3ylNaL/yUZ2DzMDucx9Dvs
         ngvlr/fNcBIHAwXAckqXeEexSdizx0dS3UlHEKrWxnrw/beZSLtg+OMSrZB+R+nfnaSy
         Brijpraiqn2TzWdz50QaOOrID99TJfXB7dfmPT44vDg7LGCb2sZBW/2kDMiWJQ/apOeA
         i7FtqyYMVVHNRX7rs12ZzXeQiIhzwJk7dcctvBib632g5jpgfG4EIA8NUybYPGSEV99c
         awL2hR2jxK29spoBm2gWWiNm4RbYnokjT69DbSCtPdz9cW5vSGGDQuspcba/QWXfSihG
         k5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N2Ay2yW9Gv/JT4ajx/UMq3XMlPy4mHOsCh9hdgJxm/Q=;
        b=uhNEH0fuRKQOslSpfMnsmLx+38u3/hxWF8uW3+YkmvqAGu/K4H3yV1bIkjHvaZq2f6
         aur6CbBM1EjA7/V9MZUXkRnqe5c/8g8B2XFj4mF7IDUajXpMw3N6P6QQBTmuQEVwOmqH
         SvX/nWbKZOkkM6LFunRPCxThyi9gWkJUh9xRC2qauGPDFQvuCtUq9NGcGg0z3KSnv+dy
         U6BgKfcbseBnpELHKPWBUcRYtF3AaA6ivl54tUj8DicjDgx/QBmllBMyzqMwbL7sSxN2
         ZcR/ynMAf8FLIIih0CR2QLMXYyT1XZK1idwhA8HYPtOkpAQT+D4XWsv2AlxZf2/jPxYo
         mIHg==
X-Gm-Message-State: AOAM530NhOraX3hXjsSI8k8o+D6llXAu5huZ0n7SIcroO+h59vjEJJfa
        TMNEQnpOmZ4yh9Xj0FjqkcLEq0Avp8ppFui6vMo=
X-Google-Smtp-Source: ABdhPJyGJRN88OepZMri2wRJMeefc/1MjnKYVGA/NaUs5L79DwiQBPAn6htEKRLJc34GXrY6XRyuzkEjktQXh5WVOC8=
X-Received: by 2002:a17:90a:c289:: with SMTP id f9mr1423373pjt.105.1617161318220;
 Tue, 30 Mar 2021 20:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210328064121.2062927-1-yhs@fb.com> <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com> <20210331002507.xv4sxe27dqirmxih@google.com>
 <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com> <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
 <CAENS6EuKv9iWLy24Gp=7dyA0RHNo9sjORASAph4UWLXvDWB+oQ@mail.gmail.com>
 <d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com> <CAENS6EuGOHcBURjR2ee2tPz3VdEu3EssCM3rFcyQqAM5MjeyQg@mail.gmail.com>
 <121fdb24-4ec2-20bf-3c2e-3b0f68b2297a@fb.com>
In-Reply-To: <121fdb24-4ec2-20bf-3c2e-3b0f68b2297a@fb.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Tue, 30 Mar 2021 20:28:27 -0700
Message-ID: <CAENS6EuPxHppEjRq2AL824nJ1=oH+rDREQGaQM7_LpC=8aUrKA@mail.gmail.com>
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     Yonghong Song <yhs@fb.com>
Cc:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 8:27 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/30/21 8:16 PM, David Blaikie wrote:
> > On Tue, Mar 30, 2021 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 3/30/21 7:51 PM, David Blaikie wrote:
> >>> On Tue, Mar 30, 2021 at 7:39 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray=
@google.com> wrote:
> >>>>
> >>>> On Tue, Mar 30, 2021 at 6:48 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 3/30/21 5:25 PM, Fangrui Song wrote:
> >>>>>> On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
> >>>>>>>> (replying to
> >>>>>>>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/=
)
> >>>>>>>>
> >>>>>>>> Thanks for the patch!
> >>>>>>>>
> >>>>>>>>> +# gcc emits compilation flags in dwarf DW_AT_producer by defau=
lt
> >>>>>>>>> +# while clang needs explicit flag. Add this flag explicitly.
> >>>>>>>>> +ifdef CONFIG_CC_IS_CLANG
> >>>>>>>>> +DEBUG_CFLAGS    +=3D -grecord-gcc-switches
> >>>>>>>>> +endif
> >>>>>>>>> +
> >>>>>>
> >>>>>> Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.
> >>>>>
> >>>>> Could you know why? dwarf size concern?
> >>>>>
> >>>>>>
> >>>>>>>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with c=
lang.
> >>>>>>>> Do we
> >>>>>>>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that=
 we
> >>>>>>>> don't have
> >>>>>>>> to pay that cost if that config is not set?
> >>>>>>>
> >>>>>>> Since this patch is mostly motivated to detect whether the kernel=
 is
> >>>>>>> built with clang lto or not. Let me add the flag only if lto is
> >>>>>>> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
> >>>>>>> The smaller percentage is due to larger .debug_info section
> >>>>>>> (almost double) for thinlto vs. no lto.
> >>>>>>>
> >>>>>>> ifdef CONFIG_LTO_CLANG
> >>>>>>> DEBUG_CFLAGS   +=3D -grecord-gcc-switches
> >>>>>>> endif
> >>>>>>>
> >>>>>>> This will make pahole with any clang built kernels, lto or non-lt=
o.
> >>>>>>
> >>>>>> I share the same concern about sizes. Can't pahole know it is clan=
g LTO
> >>>>>> via other means? If pahole just needs to know the one-bit informat=
ion
> >>>>>> (clang LTO vs not), having every compile option seems unnecessary.=
...
> >>>>>
> >>>>> This is v2 of the patch
> >>>>>      https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.co=
m/
> >>>>> The flag will be guarded with CONFIG_LTO_CLANG.
> >>>>>
> >>>>> As mentioned in commit message of v2, the alternative is
> >>>>> to go through every cu to find out whether DW_FORM_ref_addr is used
> >>>>> or not. In other words, check every possible cross-cu references
> >>>>> to find whether cross-cu reference actually happens or not. This
> >>>>> is quite heavy for pahole...
> >>>>>
> >>>>> What we really want to know is whether cross-cu reference happens
> >>>>> or not? If there is an easy way to get it, that will be great.
> >>>>
> >>>> +David Blaikie
> >>>
> >>> Yep, that shouldn't be too hard to test for more directly - scanning
> >>> .debug_abbrev for DW_FORM_ref_addr should be what you need. Would tha=
t
> >>> be workable rather than relying on detecting clang/lto from command
> >>> line parameters? (GCC can produce these cross-CU references too, when
> >>> using lto - so this approach would help make the solution generalize
> >>> over GCC's behavior too)
> >>
> >> Thanks, David. This should be better. I tried with a non-lto vmlinux.
> >> Did "llvm-dwarfdump --debug-abbrev vmlinux > log" and then
> >> "grep "DW_CHILDREN_no" log | wc -l" and get 231676 records.
> >
> > What conclusions are you drawing from this number/data? (I'm not
> > following how DW_CHILDREN_no relates to the topic - perhaps I'm
> > missing something)
>
> Approximation of the number of tags to visit:
>
> ...
> [10] DW_TAG_array_type  DW_CHILDREN_yes
>          DW_AT_type      DW_FORM_ref4
>          DW_AT_sibling   DW_FORM_ref4
>
> [11] DW_TAG_variable    DW_CHILDREN_no
>          DW_AT_name      DW_FORM_strp
>          DW_AT_decl_file DW_FORM_data1
>          DW_AT_decl_line DW_FORM_data2
>          DW_AT_decl_column       DW_FORM_data1
>          DW_AT_type      DW_FORM_ref4
>          DW_AT_external  DW_FORM_flag_present
>          DW_AT_declaration       DW_FORM_flag_present
>
> [12] DW_TAG_member      DW_CHILDREN_no
>          DW_AT_name      DW_FORM_string
>          DW_AT_decl_file DW_FORM_data1
>          DW_AT_decl_line DW_FORM_data1
>          DW_AT_decl_column       DW_FORM_data1
>          DW_AT_type      DW_FORM_ref4
>          DW_AT_data_member_location      DW_FORM_data1
>
> [13] DW_TAG_subrange_type       DW_CHILDREN_no
>          DW_AT_type      DW_FORM_ref4
>          DW_AT_upper_bound       DW_FORM_data1
> ...
> The bigger number means more tags to visit and will consume more time.
> For a binary not compiled with lto, all these tags will be visited
> before declaring that the dwarf does not have cross-cu reference.
> So the number is just a relative guess on the cpu cost. But ya,
> have to have real implementation first...

Ah, sounds good, yeah.
