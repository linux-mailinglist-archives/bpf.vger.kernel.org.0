Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A946134F6FE
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhCaCwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 22:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCaCvu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 22:51:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EFC061574;
        Tue, 30 Mar 2021 19:51:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so469631pjv.1;
        Tue, 30 Mar 2021 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcqpDQK97dsfA3EbdumC6QR8llGHLFb5JyZPdcyEhT0=;
        b=Yqe1HVmNPyNP27Rfrrzqh6JLyGCXNvDZJra72e2Ar58PKfcRAG3to1GRLiOjdVsdOy
         aM4AhT4NPPiD8eh+ysZIQPSmf6Aqbzu2DKRUQ2Ja3SmqFj/dBgJzMJ6vH+9RgrBP/iSO
         gFsL9fk9NuSVjVPHT+Wl0Rr7422Vf52aIVVbfk46sNRzbxwP7JPn3kVk4WoXOWXSFoUT
         e8UOMAq6vp+JODfHp7y/l8sfrQHsu8wNWxDGwt8R4HDVo5CqmOoncmyO+mlSX/lXIqru
         gY/CDIlaqJvxondH4UUbXNXpbwW+t8n3+KFvE0q9EbAItAaEhh16kaHzSO4MUxBPfbim
         uNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcqpDQK97dsfA3EbdumC6QR8llGHLFb5JyZPdcyEhT0=;
        b=f2SM6Dj2uYS4tUSYhP0qMRYuhV8czIg16VorLO7kWpldV4tgI0IXwDMeoW9BFEfBeD
         n0gzgLMDE911bjzFpJX+iAPXFjnThTtrK5K0Xv5zfm80Y/BBYXRpdo9NFWpOYS9r16cN
         Ygk7IQcQR0q1nFK4RTBxsw58XWf67cZzN/YxovfVa/JSGuv4qyRNwKpOh8ofJjKnVnSI
         8w/0uFnv8LfLbcYUkKwSmwojqsZ9QI9OKj1kGWEpiY7pc4Sdq2aL0bwTewWFg3rXh7Q9
         AUiF0/adtkSkXLqLv3fhT7t4UtJeVmHc9L4RncwdSBySe+RN0eLwf6RJXh8voDffhd3Y
         zLYA==
X-Gm-Message-State: AOAM533bd9ZrvairqUWmV6KbWnIfou85L9HqjFD39QUuPevZYe7D/MxQ
        Bt26elDO2KHw4jBh29TzPDbmS9kaBsl6ibBXT3g=
X-Google-Smtp-Source: ABdhPJwIvk5uciCb5RmRxo6ZcAMVHPa/KWOmZSnTG2Rc1yAokveEpbjA0ftKHdfDUtaimQJ3DuX1+yVbNZqM4ObI2BE=
X-Received: by 2002:a17:90a:c289:: with SMTP id f9mr1306686pjt.105.1617159109993;
 Tue, 30 Mar 2021 19:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210328064121.2062927-1-yhs@fb.com> <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com> <20210331002507.xv4sxe27dqirmxih@google.com>
 <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com> <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
In-Reply-To: <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Tue, 30 Mar 2021 19:51:39 -0700
Message-ID: <CAENS6EuKv9iWLy24Gp=7dyA0RHNo9sjORASAph4UWLXvDWB+oQ@mail.gmail.com>
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
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

On Tue, Mar 30, 2021 at 7:39 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
> On Tue, Mar 30, 2021 at 6:48 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 3/30/21 5:25 PM, Fangrui Song wrote:
> > > On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
> > >>
> > >>
> > >> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
> > >>> (replying to
> > >>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
> > >>>
> > >>> Thanks for the patch!
> > >>>
> > >>>> +# gcc emits compilation flags in dwarf DW_AT_producer by default
> > >>>> +# while clang needs explicit flag. Add this flag explicitly.
> > >>>> +ifdef CONFIG_CC_IS_CLANG
> > >>>> +DEBUG_CFLAGS    +=3D -grecord-gcc-switches
> > >>>> +endif
> > >>>> +
> > >
> > > Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.
> >
> > Could you know why? dwarf size concern?
> >
> > >
> > >>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with clan=
g.
> > >>> Do we
> > >>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that we
> > >>> don't have
> > >>> to pay that cost if that config is not set?
> > >>
> > >> Since this patch is mostly motivated to detect whether the kernel is
> > >> built with clang lto or not. Let me add the flag only if lto is
> > >> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
> > >> The smaller percentage is due to larger .debug_info section
> > >> (almost double) for thinlto vs. no lto.
> > >>
> > >> ifdef CONFIG_LTO_CLANG
> > >> DEBUG_CFLAGS   +=3D -grecord-gcc-switches
> > >> endif
> > >>
> > >> This will make pahole with any clang built kernels, lto or non-lto.
> > >
> > > I share the same concern about sizes. Can't pahole know it is clang L=
TO
> > > via other means? If pahole just needs to know the one-bit information
> > > (clang LTO vs not), having every compile option seems unnecessary....
> >
> > This is v2 of the patch
> >    https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> > The flag will be guarded with CONFIG_LTO_CLANG.
> >
> > As mentioned in commit message of v2, the alternative is
> > to go through every cu to find out whether DW_FORM_ref_addr is used
> > or not. In other words, check every possible cross-cu references
> > to find whether cross-cu reference actually happens or not. This
> > is quite heavy for pahole...
> >
> > What we really want to know is whether cross-cu reference happens
> > or not? If there is an easy way to get it, that will be great.
>
> +David Blaikie

Yep, that shouldn't be too hard to test for more directly - scanning
.debug_abbrev for DW_FORM_ref_addr should be what you need. Would that
be workable rather than relying on detecting clang/lto from command
line parameters? (GCC can produce these cross-CU references too, when
using lto - so this approach would help make the solution generalize
over GCC's behavior too)
