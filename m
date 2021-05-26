Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181F5391D26
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhEZQiL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 12:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhEZQiL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 12:38:11 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65671C061756
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:36:39 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h15so1465031ilr.2
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Td9+0p4Vojc9Dz9FfJMVv114ms/+pAIzEskajURbPLU=;
        b=ns0kg/XcwBjjvtIGIyTFM1Do1CbtdOBm/MwnjV4ypsAEevazAdyU37NRQ49C3hMV4W
         UI8gkHLy3VKTMaNDH2ZuWXwZNOqs/qVLhY3jZOUYWtE0jefTmqfB3cj7HqO1ouonEKLm
         X4Z+QG/7fB5bn1S3N+sdvAPDH5qYD7VNjq8PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td9+0p4Vojc9Dz9FfJMVv114ms/+pAIzEskajURbPLU=;
        b=V4hGOb3APWllig4OGRwBlQaVZwFDg6mZU/NL2RJ8kw6gg0iYm3CG0nxp6rPdhPHgcx
         on3Sklr50exxF8mNbBAO5cYYlnUsMLCamcftm74AkaH+Uq+k/NzWAKM/VwoVRRXkovAf
         8BaWen9xhj39vvugbOYI4TFhDDd7o71D6wbdNyWRsU4FDKUTXHCQkHFrVkQgov3jsegh
         G4pViP2QdBtGOQuW93nYMApAGaF0jeMGORgSKAwhdw3PA05oeEdYhCQo9slRBH4N7act
         gCLDyqGLbNq+BJGV3uw3S2m5sxLdZ4vA19+hI0zVrEnZu7ORzSb0wuyezufFMRQKhKi8
         Ryrw==
X-Gm-Message-State: AOAM5303Bxkn3P27lHorOZSZRnq4jVh5Mm4AswVm2ztyt2zIPtu6gCWF
        I9AYk0i55EwMzW4Ecy0Ocaw7c/ndLJUo0y3pmM7d5A==
X-Google-Smtp-Source: ABdhPJzx8jlRhnOFYok53uz3oVH1uSS2dtpEyT/56EIa7SZ6EIqGsZyts/phJWZCGwDtDT4m+ykDVry3TBGATsEGvzM=
X-Received: by 2002:a92:c5aa:: with SMTP id r10mr29974174ilt.89.1622046998672;
 Wed, 26 May 2021 09:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201825.2729018-1-revest@chromium.org> <CAEf4BzaHDa5Kujq4S_=0tPvok_ELABp=rwnv_YB4PQvvdy=UnA@mail.gmail.com>
In-Reply-To: <CAEf4BzaHDa5Kujq4S_=0tPvok_ELABp=rwnv_YB4PQvvdy=UnA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 26 May 2021 18:36:27 +0200
Message-ID: <CABRcYm+PJpZZr1oWi1g-Y9hzH547ofRoWvFHU=AdegWUKT26og@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 6:34 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 1:18 PM Florent Revest <revest@chromium.org> wrote:
> >
> > These macros are convenient wrappers around the bpf_seq_printf and
> > bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> > targets low level tracing primitives. bpf_helpers.h is a better fit.
> >
> > The __bpf_narg and __bpf_apply macros are needed in both files so
> > provided twice and guarded by ifndefs.
> >
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  kernel/bpf/preload/iterators/iterators.bpf.c  |  1 -
> >  tools/lib/bpf/bpf_helpers.h                   | 70 +++++++++++++++++++
> >  tools/lib/bpf/bpf_tracing.h                   | 62 +++-------------
> >  .../bpf/progs/bpf_iter_bpf_hash_map.c         |  1 -
> >  .../selftests/bpf/progs/bpf_iter_bpf_map.c    |  1 -
> >  .../selftests/bpf/progs/bpf_iter_ipv6_route.c |  1 -
> >  .../selftests/bpf/progs/bpf_iter_netlink.c    |  1 -
> >  .../selftests/bpf/progs/bpf_iter_task.c       |  1 -
> >  .../selftests/bpf/progs/bpf_iter_task_btf.c   |  1 -
> >  .../selftests/bpf/progs/bpf_iter_task_file.c  |  1 -
> >  .../selftests/bpf/progs/bpf_iter_task_stack.c |  1 -
> >  .../selftests/bpf/progs/bpf_iter_task_vma.c   |  1 -
> >  .../selftests/bpf/progs/bpf_iter_tcp4.c       |  1 -
> >  .../selftests/bpf/progs/bpf_iter_tcp6.c       |  1 -
> >  .../selftests/bpf/progs/bpf_iter_udp4.c       |  1 -
> >  .../selftests/bpf/progs/bpf_iter_udp6.c       |  1 -
> >  .../selftests/bpf/progs/test_snprintf.c       |  1 -
> >  17 files changed, 80 insertions(+), 67 deletions(-)
> >
> > diff --git a/kernel/bpf/preload/iterators/iterators.bpf.c b/kernel/bpf/preload/iterators/iterators.bpf.c
> > index 52aa7b38e8b8..03af863314ea 100644
> > --- a/kernel/bpf/preload/iterators/iterators.bpf.c
> > +++ b/kernel/bpf/preload/iterators/iterators.bpf.c
> > @@ -2,7 +2,6 @@
> >  /* Copyright (c) 2020 Facebook */
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> > -#include <bpf/bpf_tracing.h>
> >  #include <bpf/bpf_core_read.h>
> >
> >  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 9720dc0b4605..68d992b30f26 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -158,4 +158,74 @@ enum libbpf_tristate {
> >  #define __kconfig __attribute__((section(".kconfig")))
> >  #define __ksym __attribute__((section(".ksyms")))
> >
> > +#ifndef ___bpf_concat
> > +#define ___bpf_concat(a, b) a ## b
> > +#endif
> > +#ifndef ___bpf_apply
> > +#define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
> > +#endif
> > +#ifndef ___bpf_nth
> > +#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
> > +#endif
> > +#ifndef ___bpf_narg
> > +#define ___bpf_narg(...) \
> > +       ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> > +#endif
> > +#ifndef ___bpf_empty
> > +#define ___bpf_empty(...) \
> > +       ___bpf_nth(_, ##__VA_ARGS__, N, N, N, N, N, N, N, N, N, N, 0)
> > +#endif
>
> ___bpf_empty doesn't seem to be used, let's remove it for now?
> Otherwise it looks good.

Yes it's never been used, I thought it was introduced "just in case"
so I kept it around but then I'll remove it from both bpf_helpers.h
and bpf_tracing.h
