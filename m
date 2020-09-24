Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5784C2770FE
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgIXM3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgIXM3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:29:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745AC0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 05:29:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lo4so4174747ejb.8
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcT+pZ/PTUp9wa/y0kDn97OtjvB6CdX4Q+3kJBuVUCc=;
        b=Ti6cmqL3Ww4/dmp4GkFf//pZM1Cyddfmt3F68rkT3FctP4csEwJV1NJkB1tib9WozY
         oNc6naTBxuclc80J+TWCWbGJd8Fuf4AnFoG86p+ut3WbzBD2lCKKaYvNSLkPp+nC7IjM
         Qoh75X6YKrgeZuI2F6HmflLcxhevKrt2jbmwkdoUuKN2fFfeUW12Csre4b3NreUUbUOV
         OxmzFfkvFy1NN4fo100JLfgqLlNL1LDX6jPfiBgqOlQYhv0rAGiWjFOcE1Z4bg1rQR9Z
         FSprGO32fR+tUWM8L24aC4BCxXNI5RVcCZCQJE1wV7IG+4RhTsKhd09adZuNylejwzhE
         HLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcT+pZ/PTUp9wa/y0kDn97OtjvB6CdX4Q+3kJBuVUCc=;
        b=LVP2cHrjzthySmWpj+icE6/VhRqnWtg0z19Eqzs+gP7cU1RJInFKsz2WuZMgymIuiL
         WIUHAFHBYEwGmU9W6QeARFensaNqTRJYmgEqePJtTyCZQEUY/OYt93qIjwfNvKRgJ2Va
         +PjvwMKe1BaIiMLwFn89rHIuhGiNNwYZ9ou0J6+xQ6lNHGGJ1MpuK1YrfMayaghl2rNq
         1noqsO8iog2900cXQK3NQawEn9kpGmXK/cXXmgdYM+k32iUN1tlBOqAQna7PITS+mTvo
         4IxjE1qB365kBVdyBsJFq7iY4JOvY04e9U4wNXfmZCiNmK1Diy4lYSDMeUFaD8vEe9G1
         J2iw==
X-Gm-Message-State: AOAM531f2OOft5MZcSzXk1nLrgL5GX7oc6SLF2x6m0DrT6s+ybAun29d
        2FpduJcXVVq1LrKOrlpaJ+hgy9qEK1fZ8Fzdruy0Fw==
X-Google-Smtp-Source: ABdhPJzVIElaKJCI4zdj8cYNSfBnh9BAhAhJsfLpPV5HoCvPWPZDo23uHBETkF6O0WXqmjXFTB7SOota/0VckQIv1BM=
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr767066ejb.358.1600950538813;
 Thu, 24 Sep 2020 05:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org> <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
 <202009240018.A4D8274F@keescook>
In-Reply-To: <202009240018.A4D8274F@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 14:28:32 +0200
Message-ID: <CAG48ez1MWhrtkbWTNpc1v-WqWYiLM_JrCKvuE6DdH6vBY3MJzQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 9:37 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 24, 2020 at 02:25:03AM +0200, Jann Horn wrote:
> > On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
[...]
> > (However, a "which syscalls have a fixed result" bitmap might make
> > sense if we want to export the list of permitted syscalls as a text
> > file in procfs, as I mentioned over at
> > <https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/>.)
>
> I haven't found a data structure I'm happy with for this. It seemed like
> NR_syscalls * sizeof(u32) was rather a lot (i.e. to store the BPF_RET
> value). However, let me discuss that more in the "why in in thread?"
> below...
[...]
> > > +#endif
> > > +};
> > > +
> > >  struct seccomp_filter;
> > >  /**
> > >   * struct seccomp - the state of a seccomp'ed process
> > > @@ -45,6 +56,13 @@ struct seccomp {
> > >  #endif
> > >         atomic_t filter_count;
> > >         struct seccomp_filter *filter;
> > > +       struct seccomp_bitmaps native;
> > > +#ifdef CONFIG_COMPAT
> > > +       struct seccomp_bitmaps compat;
> > > +#endif
> > > +#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
> > > +       struct seccomp_bitmaps multiplex;
> > > +#endif
> >
> > Why do we have one bitmap per thread (in struct seccomp) instead of
> > putting the bitmap for a given filter and all its ancestors into the
> > seccomp_filter?
>
> I explicitly didn't want to add code that was run per-filter; I wanted
> O(1), not O(n) even if the n work was a small constant. There is
> obviously a memory/perf tradeoff here. I wonder if the middle ground
> would be to put a bitmap and "constant action" results in the filter....
> oh duh. The "top" filter is already going to be composed with its
> ancestors. That's all that needs to be checked.

Yeah - when adding a new filter, you can evaluate each syscall for the
newly added filter. For both the "accept" bitmap and the "constant
action" bitmap, you can AND the bitmap of the existing filter into the
new filter's bitmap.

Although actually, I think my "constant action" bitmap proposal was a
stupid idea... when someone asks for an analysis of the filter via
procfs (which shouldn't be a common action, so speed doesn't really
matter there), we can just dynamically evaluate the entire filter tree
using our filter-evaluation helper. Let's drop the "constant action"
bitmap idea.

> Then the tri-state can be:
>
> bitmap accept[NR_syscalls]: accept or check "known" bitmap
> bitmap filter[NR_syscalls]: run filter or return known action
> u32 known_action[NR_syscalls];

Actually, maybe we should just have an "accept" list, nothing else, to
keep it straightforward and with minimal memory usage...

> (times syscall numbering "architecture" counts)
>
> Though perhaps it would be just as fast as:
>
> bitmap run_filter[NR_syscalls]: run filter or return known_action
> u32 known_action[NR_syscalls];
>
> where accept isn't treated special...

Using a bitset for accepted syscalls instead of a big array would
probably have far less cache impact on the syscall entry path. If we
just have an "accept" bitmask, we can store information about 512
syscalls per cache line - that's almost the entire syscall table. In
contrast, a known_action list can only store information about 16
syscalls in a cache line, and we'd additionally still have to query
the "filter" bitmap.

I think our goal here should be that if a syscall is always allowed,
seccomp should execute the smallest amount of instructions we can get
away with, and touch the smallest amount of memory possible (and
preferably that memory should be shared between threads). The bitmap
fastpath should probably also avoid populate_seccomp_data().
