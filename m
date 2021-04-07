Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BED356805
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350087AbhDGJ2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350073AbhDGJ2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 05:28:22 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D38C061756;
        Wed,  7 Apr 2021 02:28:13 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k8so16181441iop.12;
        Wed, 07 Apr 2021 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=x07JQQzpyci8GPomfCuTN51bSFqarBXOYtSQpxdVo3g=;
        b=P9p0EisvMC27CdoMRM2dIulWzPjBZW0Ego7WhIGxE/woUA5G8IVPzRbiMMJ8iN/HCf
         Z5xKCQ8/SDKuAeysbT8Km4SLiFhUCRemsdNkY2dTNToAiwFGoggwKf3MTIceXC15AoqZ
         kuKehMf6iNJVXumWIsjKdy+WIlhHLNC73kcEH2pnHGLUfGqLzSRUYRqHjR04caiD+2i9
         3pmhdRc2apVFkmtYZiFnVemTyhcSVTrIM6Liyvd5/p0eyA/TfSBXYd88oal5Z+EBUI0P
         fgMaLWhYqtOwbnXabD+2Pb2yEtsWn0uXQPbv4c6NK7ROvcPAmGI6cbykF+DXD4HDnURn
         j+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=x07JQQzpyci8GPomfCuTN51bSFqarBXOYtSQpxdVo3g=;
        b=FC8bQTollEP65afnD7eE6pIAV2QAsl0j5jJPIyI9zyGYqEjWSFaS6v+RkHaeRg5O7c
         AVyfnr7tvzdmSqdy2GBkG347wfcFwhaLe2UiH7OXg6taxc3cY2TPe5PydC1Q6Bz3YB0O
         lZLcqI/nPFH/T7WFDg3moTeQVi9XHhYta7VvjiRLoqvbDI4NCLsyww32cGfepMptraIo
         lH3aI9IxUTvis1QMpjZjdJGgBpT8Fy+ogUUkUI1UT3zy1Q3eW/9nqhXBfrw/MwqVedbZ
         1052ditatT9pCigCBvSmq3e4PayPw8VOidsDbsdJawS7mjRAVyjan1ujZTDnox5oi4qW
         tx/Q==
X-Gm-Message-State: AOAM532HtCH8Mpu/YrPQF6IiL2PdzHwiudwWmt9yRdvg2YNqFPYyZmh+
        T7JAdjaa3pbdW/4Pw3sNfe3d6P310V74FtlVg/I=
X-Google-Smtp-Source: ABdhPJxQbg1QBtIZc27wlsHKVKMZEWLX2uDpWcGJSFWyAs3SbsHg2/hV1pdczGrPthfIEX0n+C9O73whmG/0oLiPA8U=
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr1862701ioj.156.1617787693120;
 Wed, 07 Apr 2021 02:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401232723.3571287-1-yhs@fb.com> <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com> <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
 <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com>
In-Reply-To: <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 7 Apr 2021 11:27:45 +0200
Message-ID: <CA+icZUUC_rMUtMwMBXFrn1uWE5whrpjgtJJn1AHLhS1AcNQ0gw@mail.gmail.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 8:23 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/6/21 8:01 PM, Sedat Dilek wrote:
> > On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >> Masahiro and Michal,
> >>
> >> Friendly ping. Any comments on this patch?
> >>
> >> The addition LTO .notes information emitted by kernel is used by pahole
> >> in the following patch:
> >>      https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
> >>      (dwarf_loader: check .notes section for lto build info)
> >>
> >
> > Hi Yonghong,
> >
> > the above pahole patch has this define and comment:
> >
> > -static bool cus__merging_cu(Dwarf *dw)
> > +/* Match the define in linux:include/linux/elfnote.h */
> > +#define LINUX_ELFNOTE_BUILD_LTO 0x101
> >
> > ...and does not fit with the define and comment in this kernel patch:
> >
> > +#include <linux/elfnote.h>
> > +
> > +#define LINUX_ELFNOTE_LTO_INFO 0x101
>
> Thanks, Sedat. I am aware of this. I think we can wait in pahole
> to make a change until the kernel patch is finalized and merged.
> The kernel patch may still change as we haven't get
> maintainer's comment. This will avoid unnecessary churn's
> in pahole side.
>

I am OK with that.

- Sedat -

> >
> > Thanks.
> >
> > - Sedat -
> >
> >
> >> Thanks,
> >>
> >> Yonghong
> >>
> >> On 4/6/21 12:05 AM, Sedat Dilek wrote:
> >>> On Fri, Apr 2, 2021 at 8:07 PM 'Nick Desaulniers' via Clang Built
> >>> Linux <clang-built-linux@googlegroups.com> wrote:
> >>>>
> >>>> On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>>
> >>>>> Currently, clang LTO built vmlinux won't work with pahole.
> >>>>> LTO introduced cross-cu dwarf tag references and broke
> >>>>> current pahole model which handles one cu as a time.
> >>>>> The solution is to merge all cu's as one pahole cu as in [1].
> >>>>> We would like to do this merging only if cross-cu dwarf
> >>>>> references happens. The LTO build mode is a pretty good
> >>>>> indication for that.
> >>>>>
> >>>>> In earlier version of this patch ([2]), clang flag
> >>>>> -grecord-gcc-switches is proposed to add to compilation flags
> >>>>> so pahole could detect "-flto" and then merging cu's.
> >>>>> This will increate the binary size of 1% without LTO though.
> >>>>>
> >>>>> Arnaldo suggested to use a note to indicate the vmlinux
> >>>>> is built with LTO. Such a cheap way to get whether the vmlinux
> >>>>> is built with LTO or not helps pahole but is also useful
> >>>>> for tracing as LTO may inline/delete/demote global functions,
> >>>>> promote static functions, etc.
> >>>>>
> >>>>> So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
> >>>>> The owner of the note is "Linux".
> >>>>>
> >>>>> With gcc 8.4.1 and clang trunk, without LTO, I got
> >>>>>     $ readelf -n vmlinux
> >>>>>     Displaying notes found in: .notes
> >>>>>       Owner                Data size        Description
> >>>>>     ...
> >>>>>       Linux                0x00000004       func
> >>>>>        description data: 00 00 00 00
> >>>>>     ...
> >>>>> With "readelf -x ".notes" vmlinux", I can verify the above "func"
> >>>>> with type code 0x101.
> >>>>>
> >>>>> With clang thin-LTO, I got the same as above except the following:
> >>>>>        description data: 01 00 00 00
> >>>>> which indicates the vmlinux is built with LTO.
> >>>>>
> >>>>>     [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
> >>>>>     [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> >>>>>
> >>>>> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> >>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>>>
> >>>> LGTM thanks Yonghong!
> >>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >>>>
> >>>
> >>> Thanks for the patch.
> >>>
> >>> Feel free to add:
> >>>
> >>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc4 (x86-64)
> >>>
> >>> As a note for the pahole side:
> >>> Recent patches require an adaptation of the define and its comment.
> >>>
> >>> 1. LINUX_ELFNOTE_BUILD_LTO -> LINUX_ELFNOTE_LTO_INFO
> >>> 2. include/linux/elfnote.h -> include/linux/elfnote-lto.h
> >>>
> >>> - Sedat -
> >>>
> [...]
