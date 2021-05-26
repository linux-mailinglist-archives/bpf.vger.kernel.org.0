Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC91391D79
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhEZRDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhEZRDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 13:03:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB1C061574;
        Wed, 26 May 2021 10:02:11 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v77so3036290ybi.3;
        Wed, 26 May 2021 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osSg7tQ6oOAJAsbfd3HS1OAYAJThO8CCxq+Q0FnEz0A=;
        b=IaTs+0jAwhIBIqFYinAvBuP99T3WSQglAHlSq1achWYlq2qghhTrkCaj/SMPN+AfvT
         57a60Aakd1Zomt4OVqsy9j0azlU8wP8XKX2OIp++DV6lAaQSELysE5GD970uR/fSXONM
         0dZOIO4XnXSSqZVe4REQEYcnZ/kwp5SwgyJl0vuj7Inj/IqkZFPFWQcXJcAT3AWGBe1s
         IHaYWllzkOZ/F/L/olU5im+9yTfl3Y/ep1KbsIs6NQXtzKMl2yLWpBODZDoUMedVGX3k
         9IID4uTG0z5C5TxEusLT8q1MUBsxSGRw1bzTrae0xxXhBsi78Sz95/EphrjDGw8HevLL
         cCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osSg7tQ6oOAJAsbfd3HS1OAYAJThO8CCxq+Q0FnEz0A=;
        b=l9hMEf7UUNC5wEe/Vy14qH1LD234S9Gm0n7Sxs4pFyHb3w46oEiMwqEx/0bcydvjue
         0HV88DywiytZc+2S+wxkUelnoGNyPbYJais/uReQbwKQRW0OSPJYP+wlXIKAsFkkbBEd
         Kvr87cH64SYk48yV8ccFMEK3SOHr+GrDEG5soNOBF2QRhLm457pOzItpmhkQhWEFbIuN
         sttfYbA0tY/bhfhG9Yjtd6j4tbXcHS2LZNkjhoQM8Rol/MNLekVEoeDwTxvOpFf5RsOw
         bC/ASi5bBMJijMyXgLr5vaH2mYTqAC8A46kaWrkM4/wr5O9xXNB3R8derNij5+xSbcYO
         FGLQ==
X-Gm-Message-State: AOAM533XdoSUTyWLR0eEKx6uB+xVs8H2MJprDkE0TPbGpVKetBgsYdDL
        EDnS867/Xw3EvtzG2TgfAwKHubjM64tpjr+oNy4=
X-Google-Smtp-Source: ABdhPJwfoCpphJeOYWlfLdMkYpIBkkCtxqdTKDt0VrO5D8geeeEQwgQpURbdRzSQefNELAWUgrVLK+plC6hA4d3bZR8=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr50287927ybr.425.1622048530490;
 Wed, 26 May 2021 10:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201825.2729018-1-revest@chromium.org> <CAEf4BzaHDa5Kujq4S_=0tPvok_ELABp=rwnv_YB4PQvvdy=UnA@mail.gmail.com>
 <CABRcYm+PJpZZr1oWi1g-Y9hzH547ofRoWvFHU=AdegWUKT26og@mail.gmail.com>
In-Reply-To: <CABRcYm+PJpZZr1oWi1g-Y9hzH547ofRoWvFHU=AdegWUKT26og@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 10:01:59 -0700
Message-ID: <CAEf4BzZ_4fDa-AdQWtSCQXrnOsLnKhz5SBqY0Ayuv9LUGh-bNg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Florent Revest <revest@chromium.org>
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

On Wed, May 26, 2021 at 9:36 AM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, May 26, 2021 at 6:34 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 25, 2021 at 1:18 PM Florent Revest <revest@chromium.org> wrote:
> > >
> > > These macros are convenient wrappers around the bpf_seq_printf and
> > > bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> > > targets low level tracing primitives. bpf_helpers.h is a better fit.
> > >
> > > The __bpf_narg and __bpf_apply macros are needed in both files so
> > > provided twice and guarded by ifndefs.
> > >
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > ---
> > >  kernel/bpf/preload/iterators/iterators.bpf.c  |  1 -
> > >  tools/lib/bpf/bpf_helpers.h                   | 70 +++++++++++++++++++
> > >  tools/lib/bpf/bpf_tracing.h                   | 62 +++-------------
> > >  .../bpf/progs/bpf_iter_bpf_hash_map.c         |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_bpf_map.c    |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_ipv6_route.c |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_netlink.c    |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_task.c       |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_task_btf.c   |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_task_file.c  |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_task_stack.c |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_task_vma.c   |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_tcp4.c       |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_tcp6.c       |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_udp4.c       |  1 -
> > >  .../selftests/bpf/progs/bpf_iter_udp6.c       |  1 -
> > >  .../selftests/bpf/progs/test_snprintf.c       |  1 -
> > >  17 files changed, 80 insertions(+), 67 deletions(-)
> > >
> > > diff --git a/kernel/bpf/preload/iterators/iterators.bpf.c b/kernel/bpf/preload/iterators/iterators.bpf.c
> > > index 52aa7b38e8b8..03af863314ea 100644
> > > --- a/kernel/bpf/preload/iterators/iterators.bpf.c
> > > +++ b/kernel/bpf/preload/iterators/iterators.bpf.c
> > > @@ -2,7 +2,6 @@
> > >  /* Copyright (c) 2020 Facebook */
> > >  #include <linux/bpf.h>
> > >  #include <bpf/bpf_helpers.h>
> > > -#include <bpf/bpf_tracing.h>
> > >  #include <bpf/bpf_core_read.h>
> > >
> > >  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
> > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > > index 9720dc0b4605..68d992b30f26 100644
> > > --- a/tools/lib/bpf/bpf_helpers.h
> > > +++ b/tools/lib/bpf/bpf_helpers.h
> > > @@ -158,4 +158,74 @@ enum libbpf_tristate {
> > >  #define __kconfig __attribute__((section(".kconfig")))
> > >  #define __ksym __attribute__((section(".ksyms")))
> > >
> > > +#ifndef ___bpf_concat
> > > +#define ___bpf_concat(a, b) a ## b
> > > +#endif
> > > +#ifndef ___bpf_apply
> > > +#define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
> > > +#endif
> > > +#ifndef ___bpf_nth
> > > +#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
> > > +#endif
> > > +#ifndef ___bpf_narg
> > > +#define ___bpf_narg(...) \
> > > +       ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> > > +#endif
> > > +#ifndef ___bpf_empty
> > > +#define ___bpf_empty(...) \
> > > +       ___bpf_nth(_, ##__VA_ARGS__, N, N, N, N, N, N, N, N, N, N, 0)
> > > +#endif
> >
> > ___bpf_empty doesn't seem to be used, let's remove it for now?
> > Otherwise it looks good.
>
> Yes it's never been used, I thought it was introduced "just in case"
> so I kept it around but then I'll remove it from both bpf_helpers.h
> and bpf_tracing.h

Oh, I didn't realize it's not used in bpf_tracing.h as well. I think
it was used at some point, but probably some subsequent macro
refactorings got rid of it.
