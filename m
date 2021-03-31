Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA434F6E8
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 04:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhCaCkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 22:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhCaCjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 22:39:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA67C06175F
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 19:39:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y2so7151563plg.5
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ABi/1RQtTKGX0CM1QKK84G+1r8Xe7uaOR14Jy+a6M/s=;
        b=XTtAdm9EjuJsMyYVm0cn8BVSSC8GVe9AT4CX29ersKPyuA6YdzyYb+4e1oxEM4TPZb
         ZrlMeDNb5guhreeqdoPlzKpycXomFMTzQI4bQX0DuRV+1MjQZXnW2GnLcA1WLHgtZ7Uk
         FACtEHF/5tvfQDRRwZORIGSCgZzPRm5Ae3Uwmfh/KR/8mxvcSQEJtQ/zfIqh7UuJLBjA
         vJxNRm+GcQtKCDi+hrBOpXxVErf0Usaj0WhW8AVZJ9BnKe+JuNDa2737GDUjNeV3NaU0
         TDEN/edVZgEZeVKG3a3rBgMQ6ZuPiSXIC5ODJCMrojjgAcFm0KWBieGSUp+/EHfSGgZe
         aRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ABi/1RQtTKGX0CM1QKK84G+1r8Xe7uaOR14Jy+a6M/s=;
        b=gpdxUiEiyY1C87CuwP0wFToyNS5rafa8v0hXYzzKPxm/93+w9xFP4qxZScjgY62aJr
         voBTPhCtehAjvNusC88GNeGFa8UhGBJIAHz5qRFuCSeZr5aoe/+tgF2phT4sv/t1QMP2
         PjV7y2z9cBdR70DrGIKFUuWli/TGDuSC1IANMiVSd3PLKdT93YHWfeEYeKl8VzVuwPOv
         bpVQFIjHAsXBk0Xm5FGLQ+b8dtgYZZuUZZrpvjZVAZ6N5niMrxuWMUmfZBC62Ft+Dxx9
         fM3NSLE3zODaKG5vWQPTJpi6v6qxEIWSpAkEJbafBLiZU1Ae32fXB6yWVIiU5eNdcKKm
         S7dg==
X-Gm-Message-State: AOAM53050zfydtHoiHTcYDrurhpH83yTu+NQ/VO8hI05YQZRv0Je5PHh
        ewJbc5ZRZ9hXF8TIXjxErQxpme3OdUxcueQmBeaL9g==
X-Google-Smtp-Source: ABdhPJyaaL8BWzGbbUE/uZ3QHp+grRDbDohBivnntNoG3f/8E9lqMjRWDYV/iNx6MCLl0BhLIQ2OZCDHjfUAe4yej5o=
X-Received: by 2002:a17:90b:3550:: with SMTP id lt16mr1246796pjb.47.1617158390101;
 Tue, 30 Mar 2021 19:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210328064121.2062927-1-yhs@fb.com> <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com> <20210331002507.xv4sxe27dqirmxih@google.com>
 <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com>
In-Reply-To: <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Tue, 30 Mar 2021 19:39:38 -0700
Message-ID: <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Bill Wendling <morbo@google.com>,
        David Blaikie <dblaikie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 6:48 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/30/21 5:25 PM, Fangrui Song wrote:
> > On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
> >>
> >>
> >> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
> >>> (replying to
> >>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
> >>>
> >>> Thanks for the patch!
> >>>
> >>>> +# gcc emits compilation flags in dwarf DW_AT_producer by default
> >>>> +# while clang needs explicit flag. Add this flag explicitly.
> >>>> +ifdef CONFIG_CC_IS_CLANG
> >>>> +DEBUG_CFLAGS    +=3D -grecord-gcc-switches
> >>>> +endif
> >>>> +
> >
> > Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.
>
> Could you know why? dwarf size concern?
>
> >
> >>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clang.
> >>> Do we
> >>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we
> >>> don't have
> >>> to pay that cost if that config is not set?
> >>
> >> Since this patch is mostly motivated to detect whether the kernel is
> >> built with clang lto or not. Let me add the flag only if lto is
> >> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
> >> The smaller percentage is due to larger .debug_info section
> >> (almost double) for thinlto vs. no lto.
> >>
> >> ifdef CONFIG_LTO_CLANG
> >> DEBUG_CFLAGS   +=3D -grecord-gcc-switches
> >> endif
> >>
> >> This will make pahole with any clang built kernels, lto or non-lto.
> >
> > I share the same concern about sizes. Can't pahole know it is clang LTO
> > via other means? If pahole just needs to know the one-bit information
> > (clang LTO vs not), having every compile option seems unnecessary....
>
> This is v2 of the patch
>    https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> The flag will be guarded with CONFIG_LTO_CLANG.
>
> As mentioned in commit message of v2, the alternative is
> to go through every cu to find out whether DW_FORM_ref_addr is used
> or not. In other words, check every possible cross-cu references
> to find whether cross-cu reference actually happens or not. This
> is quite heavy for pahole...
>
> What we really want to know is whether cross-cu reference happens
> or not? If there is an easy way to get it, that will be great.

+David Blaikie

> >
> >> If the maintainer wants further restriction with CONFIG_DEBUG_INFO_BTF=
,
> >> I can do that in another revision.
> >>
> >> --
> >> You received this message because you are subscribed to the Google
> >> Groups "Clang Built Linux" group.
> >> To unsubscribe from this group and stop receiving emails from it, send
> >> an email to clang-built-linux+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit
> >> https://groups.google.com/d/msgid/clang-built-linux/0b8d17be-e015-83c3=
-88d8-7c218cd01536@fb.com
> >> .



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
