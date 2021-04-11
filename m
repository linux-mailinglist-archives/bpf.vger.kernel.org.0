Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A1A35B452
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhDKMlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 08:41:22 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:41302 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKMlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 08:41:20 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 08:41:20 EDT
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-03.nifty.com with ESMTP id 13BCWAcB030085
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 21:32:10 +0900
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 13BCVo9I011089;
        Sun, 11 Apr 2021 21:31:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 13BCVo9I011089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618144310;
        bh=VQqVdAWK8Pqez30x2LecQTS0wUneVPy4UK/xjpuKRhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dlJxX5md6cBGwve6tR1EH/uHoauG9CTzmIoEncq+sudQTUqQctx3FeP7WeF3jMp2N
         igrffyLspJFz/rxOoe3T9Lu5UqImuuef5qSWQxZVsFKNrB2mkAQbJPuZQdJQfmJrfC
         HtRH9bILqNeMMtC/ZNmnPhfGIuhCea7GKkguismm5WQvdqetQkr9u3zxuD+NOK/b/v
         nTISl2//ZaxGOhs4YN1CTLvIYRpBRA7qylC9y149Ju0J8K9v8ORe9StN46Wr8Y+8TZ
         2Br2vcNNU+8k6c6LXyNkXrVFTp9lN+vJnaJwhRrF6nga+Zu0VlzH3K+pKWG9+DGhlg
         s1OWv2fK5Sd0g==
X-Nifty-SrcIP: [209.85.215.180]
Received: by mail-pg1-f180.google.com with SMTP id w10so7261440pgh.5;
        Sun, 11 Apr 2021 05:31:50 -0700 (PDT)
X-Gm-Message-State: AOAM530QI2/FyFJkia8gBO/ztaENT55WrWGIVJun6hdxFlIMfHz3bhcF
        +wCDcJR3MWXppHaIvOUcYuN/Jlh1Ug1W1ZOQb6c=
X-Google-Smtp-Source: ABdhPJyuvJKYnZEFKbx4hTsMPhv+Nq9PD6+/fr+8zr0KW4MwPt9LoT/prIFsQhfFF/fCCCMZCkPStBcuoHUTHqTUm14=
X-Received: by 2002:a63:181c:: with SMTP id y28mr22732100pgl.175.1618144309497;
 Sun, 11 Apr 2021 05:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210401232723.3571287-1-yhs@fb.com> <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com> <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
 <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com> <YG23xiRqJLYRtZgQ@kernel.org> <08f2eda5-2226-d551-d660-dba981b6ced8@fb.com>
In-Reply-To: <08f2eda5-2226-d551-d660-dba981b6ced8@fb.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Apr 2021 21:31:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUkLi4gu-9TY7p7kaLFKtEFA1qA0kc3VtOcgH9xJgsfA@mail.gmail.com>
Message-ID: <CAK7LNASUkLi4gu-9TY7p7kaLFKtEFA1qA0kc3VtOcgH9xJgsfA@mail.gmail.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 11:49 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/7/21 6:46 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Apr 06, 2021 at 11:23:27PM -0700, Yonghong Song escreveu:
> >> On 4/6/21 8:01 PM, Sedat Dilek wrote:
> >>> On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
> >>>> Masahiro and Michal,
> >
> >>>> Friendly ping. Any comments on this patch?
> >
> >>>> The addition LTO .notes information emitted by kernel is used by pahole
> >>>> in the following patch:
> >>>>       https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
> >>>>       (dwarf_loader: check .notes section for lto build info)
> >
> >>> the above pahole patch has this define and comment:
> >
> >>> -static bool cus__merging_cu(Dwarf *dw)
> >>> +/* Match the define in linux:include/linux/elfnote.h */
> >>> +#define LINUX_ELFNOTE_BUILD_LTO 0x101
> >
> >>> ...and does not fit with the define and comment in this kernel patch:
> >
> >>> +#include <linux/elfnote.h>
> >>> +
> >>> +#define LINUX_ELFNOTE_LTO_INFO 0x101
> >
> >> Thanks, Sedat. I am aware of this. I think we can wait in pahole
> >> to make a change until the kernel patch is finalized and merged.
> >> The kernel patch may still change as we haven't get
> >> maintainer's comment. This will avoid unnecessary churn's
> >> in pahole side.
> >
> > So, I tested with clang 12 on fedora rawhide as well on fedora 33, and
> > I'm satisfied with the current state to release v1.21, Masahiro, have
> > you had the time to look at this?
> >
> > Yonghong, as we have a fallback in case the ELF note isn't available, I
> > think we're safe even if the notes patch merge gets delayed, right?
>
> Right. That is why I separated the notes patch from other patches.
> We can revisit it once the kernel patch is settled.
>
> >
> > - Arnaldo
> >


Applied to linux-kbuild. Thanks.


-- 
Best Regards
Masahiro Yamada
