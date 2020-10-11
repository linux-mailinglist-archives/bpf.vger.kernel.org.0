Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68AD28A4D1
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 02:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgJKAbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgJKAbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 20:31:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C3C0613D0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 17:31:50 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e22so18357759ejr.4
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZe92AxHa1ux/aSzsaNoNVqnhZlr0VjAj7QM3jswCvI=;
        b=NSmbabvJDMLIfG7VA0EgKB+1VjzOQklfjyZTOMEB9+ZQLWPjFQR5ItRHAz21OcGPCn
         7EQp3xw0KTB/cDGVy6iYDvTl0Vv7+/V6abcPwTwmd6LR7meCBaX9wk73+XS9F8rWpiOb
         hfpvSYSuVlru5HIZeWehauDjc5L7A7gEebX8xXWJLu+IdlW3ds5K7G3cV0GMGAjoM1dr
         a4A6pWrpAZM2n5aEIQJ5qP7Dcc73AKffBx0ZtUide3DjLyvUIkM+II9FoYbjAKeXIcxz
         xDtNAnhNTB3v9LTzRtAwmYMA3Lw5xGb+Kry1x57LE7PwEkoacOoEF9kuHa0OX8jLId0Y
         WX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZe92AxHa1ux/aSzsaNoNVqnhZlr0VjAj7QM3jswCvI=;
        b=mk1hDThmuv+DBRdWDGVRqxHQFpBiOOuucjo2pb6apuo6y3X0Tsoi/pLl9C8ptHRWh0
         Xiq05Y5qWvqTjszc/txYzRwZvrZVdaKrVhNvyvt/fprxTlZnPdAxeC2Lq+Lo8MQNfYMO
         sZT9c/daYn2nrVypoLmwVszAOQufrzDY5v0IRJhkrmEAhCRG87SqS8jIiKAcRuNoCBYN
         /ayrHN8fYdSm+NcmU5oe/zTgc+RvfeShSDqoINaGrMFyEFlulEla+DNBXRJZmlwugUph
         jSgy6knac7GlKHZA3rZGtBI+G4nUDgJeCNdeghwlIc4GFBvLj7LuLo7bT4thGiTgruqO
         NbBw==
X-Gm-Message-State: AOAM530e3O26tkxyKoMA1edHWpIgkBMluhGXxF3fQVxO9rM1r0tah7nz
        IgI0DweOh4hEq8Ozw55E86FzzPvO3Vsjp84cNvlAxg==
X-Google-Smtp-Source: ABdhPJx8yUSMjXshtz3CA084Xo91rUhL6IxixfrksoXgdzpdry6qy06QqtdppQynb4F7XfpAO1GOdBOVdfVr+weJsMU=
X-Received: by 2002:a17:906:190b:: with SMTP id a11mr21260104eje.260.1602376308645;
 Sat, 10 Oct 2020 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
 <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
 <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
 <CAMOZA0LrxjP5dco35NRZeFpMZd7QhuGfvr_aqnZR3nAon_n8ng@mail.gmail.com> <CAEf4BzbnubBZwi3OVPkFigm-jMS_BV7yFLSwQwfGS09iwyhV5Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbnubBZwi3OVPkFigm-jMS_BV7yFLSwQwfGS09iwyhV5Q@mail.gmail.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Sun, 11 Oct 2020 02:31:37 +0200
Message-ID: <CAMOZA0JWHuZBTcfbxWzworSaHwnoNj2TOcHzGF9F9fAKQqGuzw@mail.gmail.com>
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 11, 2020 at 1:11 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Oct 10, 2020 at 3:49 PM Luigi Rizzo <lrizzo@google.com> wrote:
> >
> > Coming back to .bss handling:
> >
> > On Wed, Oct 7, 2020 at 11:29 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > >
> > > On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > > > >
> > > > > TL;DR; there seems to be a compiler bug with clang-10 and -O2
> > > > > when struct are in .data -- details below.
> > > > >
> > > > > On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > > > > ...
> > > > > > > 2. .bss overrides from userspace are not seen in bpf at runtime
> > ...
> > > > > >
> > > > > > This is quite surprising, given we have explicit selftests validating
> > > > > > that all this works. And it seems to work. Please check
> > > > > > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > > > > > it and confirm that it works in your setup?
> > > > >
> > > > > Ah, this was non intuitive but obvious in hindsight:
> > > > >
> > > > > .bss is zeroed by the kernel after load(), and since my program
> > > > > changed the value before foo_bpf__load() , the memory was overwritten
> > > > > with 0s. I could confirm this by printing the value after load.
> > > > >
> > > > > If I update obj->data-><something> after __load(),
> > > > > or even after __attach() given that userspace mmaps .bss and .data,
> > > > > everything works as expected both for scalars and structs.
> > > >
> > > > Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
> > > > before the load. And checks that those values are preserved after
> > > > load. So .bss, if you initialize it manually, shouldn't zero-out what
> > > > you set.
> >
> > strace reveals that the .bss is initially created as anonymous memory:
> >
> >   mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
> > 0) = 0x7fd074a5f000
> >   write(2, "after open bss is at 0x7fd074a5f"..., 36after open bss is
> > at 0x7fd074a5f000) = 36
> >
> > and then remapped after the map has been created:
> >   bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
> > value_size=144,  max_entries=1, map_flags=0x400 /* BPF_F_??? */,
> > inner_map_fd=0, map_name="hstats_b.bss", map_ifindex=0, ...}, 120) = 6
> >   ...
> >   mmap(0x7fd074a5f000, 4096, PROT_READ|PROT_WRITE,
> > MAP_SHARED|MAP_FIXED, 6, 0) = 0x7fd074a5f000
> >
> > so the original content is gone.
>
> not exactly, all of .bss, .rodata, .data and .kconfig are first
> mmap()'ed as anonymous memory. I've modified test_skeleton.c to
> increase .bss size to 8192 bytes size to distinguish it from other
> maps:
>
> 1. mmap() anonymous memory (just allocating memory that would keep
> initial values that you set with skel->bss->my_var = 123):
>
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
> 0) = 0x7fb3b406f000
>
> 2. use that anonymous memory with initialized variables to update map
> contents during bpf_object's load:
>
> bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffdab521d50,
> value=0x7fb3b406f000, flags=BPF_ANY}, 120) = 0

I do not see this BPF_MAP_UPDATE_ELEM for the .bss segment in my strace.
What I see (repeated at the end) is that the .bss map is
created and then just remapped as you indicate below in #3

Maybe this was added in a more recent version of the library
than the one I have?

$ apt info libbpf-dev
Package: libbpf-dev
Version: 1:0.0.8-1
Priority: optional
Section: libdevel
Source: libbpf (0.0.8-1)


cheers
luigi
