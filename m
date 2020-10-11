Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E362C28A4F3
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 03:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgJKBgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 21:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgJKBgy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 21:36:54 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532DEC0613D0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 18:36:53 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x20so10450373ybs.8
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHdlrEHPYIyul5UqJ2/0ZwThO6tZnq3FG8T/GIcVWEU=;
        b=WBjiEs/wlfURdAW9IcHmxCHAXOU6FUCSATu4DvMVpsdR4YFY/OuvM/uLQE1jAVi+/n
         ADGBuByivhICIHFzkFUnLYdQhJzYP9ns8eK3zX4GFiC1kgYd4OLeqU4GkugjX+R1ZaoM
         uJgbXzJWDEcHxD+y9+St4OE/yLLslhbeGGl/IGeA7YqKipwjIPyY0xqLYrWTzSkAWJF2
         /ufcqrkwEZEYdl/GIIip/GsDQS76kAwkc6P/NJIE7yAfZSMJwlRK77iDEkbycCDlC/T+
         jIwOVZ4geeYHllmNMblYn+sowjqpolpqHPzYSsIIw/PugiEgs4BZBvG23nAIZini7XpD
         lISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHdlrEHPYIyul5UqJ2/0ZwThO6tZnq3FG8T/GIcVWEU=;
        b=QKbwyQgInJk5hulhzvqGk9MdVO1a7Z0Bl+ljtbSSn93XK/mlxlfVgPzv53BrTxMEZD
         2LXyLGob5LyyfznJ/rXelE2z/IbRdBTLf9GeX2VjDFEh2EJ3C+CCTDjIdMJ9cg5Mvjq/
         aeAurzrf9IScsQDr8x9ivpdHpDu/MTsRxdWf23vmGfCZGbbiJaX9+cuG0cy32GuqL6fI
         SYhIiYdhSQFajAs/YUNnz/md3r4HAtetqIcqXADSkBIosP9cZccGqSYIkCHjUg93gIOS
         dlmb/0QQfw/qkop2PjkrxyoATyN2zbRAxIVOOhAog7Nvj/SCgqs0O2pzWBjKUkJJq/BQ
         mcgA==
X-Gm-Message-State: AOAM530VXZ7pQbe8vE7Ysz/xpqmqTmBUFAM5Rf7y5xbcY3u7mdI2NeaM
        qVVL6vpvOl1DsMzEm5Vk6e3UMQEWcSPQNdk6hjV6cUiAlu8=
X-Google-Smtp-Source: ABdhPJydRviZF9cYxkmplnzui+N6X2mJwtPryxSy8122ncdyP/1duwyLtizu36jhoowjVe4+QmP2OXLwBnOlSZqv0KM=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr318227ybg.459.1602380212428;
 Sat, 10 Oct 2020 18:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
 <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
 <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
 <CAMOZA0LrxjP5dco35NRZeFpMZd7QhuGfvr_aqnZR3nAon_n8ng@mail.gmail.com>
 <CAEf4BzbnubBZwi3OVPkFigm-jMS_BV7yFLSwQwfGS09iwyhV5Q@mail.gmail.com> <CAMOZA0JWHuZBTcfbxWzworSaHwnoNj2TOcHzGF9F9fAKQqGuzw@mail.gmail.com>
In-Reply-To: <CAMOZA0JWHuZBTcfbxWzworSaHwnoNj2TOcHzGF9F9fAKQqGuzw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 10 Oct 2020 18:36:40 -0700
Message-ID: <CAEf4BzYZC-smsGD4ia1kVyjuvpZ6MBAfS=LT3TDuA5G6SVmA+A@mail.gmail.com>
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 10, 2020 at 5:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> On Sun, Oct 11, 2020 at 1:11 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Oct 10, 2020 at 3:49 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > >
> > > Coming back to .bss handling:
> > >
> > > On Wed, Oct 7, 2020 at 11:29 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > > >
> > > > On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > > > > >
> > > > > > TL;DR; there seems to be a compiler bug with clang-10 and -O2
> > > > > > when struct are in .data -- details below.
> > > > > >
> > > > > > On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > > > > > ...
> > > > > > > > 2. .bss overrides from userspace are not seen in bpf at runtime
> > > ...
> > > > > > >
> > > > > > > This is quite surprising, given we have explicit selftests validating
> > > > > > > that all this works. And it seems to work. Please check
> > > > > > > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > > > > > > it and confirm that it works in your setup?
> > > > > >
> > > > > > Ah, this was non intuitive but obvious in hindsight:
> > > > > >
> > > > > > .bss is zeroed by the kernel after load(), and since my program
> > > > > > changed the value before foo_bpf__load() , the memory was overwritten
> > > > > > with 0s. I could confirm this by printing the value after load.
> > > > > >
> > > > > > If I update obj->data-><something> after __load(),
> > > > > > or even after __attach() given that userspace mmaps .bss and .data,
> > > > > > everything works as expected both for scalars and structs.
> > > > >
> > > > > Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
> > > > > before the load. And checks that those values are preserved after
> > > > > load. So .bss, if you initialize it manually, shouldn't zero-out what
> > > > > you set.
> > >
> > > strace reveals that the .bss is initially created as anonymous memory:
> > >
> > >   mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
> > > 0) = 0x7fd074a5f000
> > >   write(2, "after open bss is at 0x7fd074a5f"..., 36after open bss is
> > > at 0x7fd074a5f000) = 36
> > >
> > > and then remapped after the map has been created:
> > >   bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
> > > value_size=144,  max_entries=1, map_flags=0x400 /* BPF_F_??? */,
> > > inner_map_fd=0, map_name="hstats_b.bss", map_ifindex=0, ...}, 120) = 6
> > >   ...
> > >   mmap(0x7fd074a5f000, 4096, PROT_READ|PROT_WRITE,
> > > MAP_SHARED|MAP_FIXED, 6, 0) = 0x7fd074a5f000
> > >
> > > so the original content is gone.
> >
> > not exactly, all of .bss, .rodata, .data and .kconfig are first
> > mmap()'ed as anonymous memory. I've modified test_skeleton.c to
> > increase .bss size to 8192 bytes size to distinguish it from other
> > maps:
> >
> > 1. mmap() anonymous memory (just allocating memory that would keep
> > initial values that you set with skel->bss->my_var = 123):
> >
> > mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
> > 0) = 0x7fb3b406f000
> >
> > 2. use that anonymous memory with initialized variables to update map
> > contents during bpf_object's load:
> >
> > bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffdab521d50,
> > value=0x7fb3b406f000, flags=BPF_ANY}, 120) = 0
>
> I do not see this BPF_MAP_UPDATE_ELEM for the .bss segment in my strace.
> What I see (repeated at the end) is that the .bss map is
> created and then just remapped as you indicate below in #3
>
> Maybe this was added in a more recent version of the library
> than the one I have?
>
> $ apt info libbpf-dev
> Package: libbpf-dev
> Version: 1:0.0.8-1

Your version is almost 3 full releases behind. Yes, this was fixed a
long time ago. Please update your libbpf.

> Priority: optional
> Section: libdevel
> Source: libbpf (0.0.8-1)
>
>
> cheers
> luigi
