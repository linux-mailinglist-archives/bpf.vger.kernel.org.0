Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7149F28A3D3
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 01:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgJJXLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgJJXLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 19:11:19 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E3C0613D0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 16:11:18 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h6so10271903ybi.11
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRNHFyGRzfLbPL19jphhyoqUbLjJItaO8qvViF4olUs=;
        b=JFEzbmdQp4N1tumBBNRoHwBIEJmcveQSIjsD+fx6N77UHSgGGcm//W54J/6HlhWOP4
         RrCx4cj5s/36DPgZKe/J15YLiI8m/rn0VpUoiirlM5MhsVyvG2hXbYKXiv6sNN2f8Z6o
         An+4oPt9Df2t2qbwqaG71KR2CoWc96aztdsjeHrNNMZu13a4kMhfusHNV58BMpxmGSK8
         7AJgipLm/z5po0FJ19tGikWc3U+K77wJ1TXg3I4wyRC81h3+JL2+Zf8MC87ywEIVwIKm
         RYlGeSbZbuR9cUmWlel+iDEtjvQlNkB0WhET34RoMteaWHswrKv8J4NX23K/lh7Da4Bo
         fYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRNHFyGRzfLbPL19jphhyoqUbLjJItaO8qvViF4olUs=;
        b=fOvJH7bQ1j6g+AXJIVf7lPnd5Npq6vr1oiHIk5BpHig92M51gtf5cjpWB4pIJx5PY1
         072vGVBGwH16hrRlHePALuMulrXFpzfbTPoyxzNKp0mRmxqqkIbeRR1OsARmok2sexGS
         AvLqIC7byedoG8qNlEXZ718dGIe1KK/QMor2Ha2B3s3cUxXaXvLrRtwvVXKvtRWdQ7ni
         xjyjDVzGRCh0eEVmbCM1Pda7e/9h9aZbGDbJMZQ9ZslykGuDuI0cFvVxQ41e0eo5HKra
         tFVyI8z5TBsnE+tPBDNqx9BFTzbTVLdP+O3l2fAHDD3ekigXwnj95qU+5vBdoZJVvPBt
         v7Dg==
X-Gm-Message-State: AOAM531JSw751lciUOCZTtdOTpsOF+tx3aemZ3idAdL2tvEEC8Kn7+uc
        oss/WR4eweREAIvzsBGGim/753lC9sVdtR5wWCDWkvX71NThCg==
X-Google-Smtp-Source: ABdhPJzE4D7wQLYSEi6TUX7PW6CB8EnptVzoainvkU56jx2YUxhEk2cSC8yjQ8ziz7JOSM0Bnkbu0SLzDyH/sSobSWE=
X-Received: by 2002:a25:2d41:: with SMTP id s1mr24264164ybe.459.1602371477402;
 Sat, 10 Oct 2020 16:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
 <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
 <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com> <CAMOZA0LrxjP5dco35NRZeFpMZd7QhuGfvr_aqnZR3nAon_n8ng@mail.gmail.com>
In-Reply-To: <CAMOZA0LrxjP5dco35NRZeFpMZd7QhuGfvr_aqnZR3nAon_n8ng@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 10 Oct 2020 16:11:05 -0700
Message-ID: <CAEf4BzbnubBZwi3OVPkFigm-jMS_BV7yFLSwQwfGS09iwyhV5Q@mail.gmail.com>
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

On Sat, Oct 10, 2020 at 3:49 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> Coming back to .bss handling:
>
> On Wed, Oct 7, 2020 at 11:29 PM Luigi Rizzo <lrizzo@google.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > > >
> > > > TL;DR; there seems to be a compiler bug with clang-10 and -O2
> > > > when struct are in .data -- details below.
> > > >
> > > > On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > > > ...
> > > > > > 2. .bss overrides from userspace are not seen in bpf at runtime
> ...
> > > > >
> > > > > This is quite surprising, given we have explicit selftests validating
> > > > > that all this works. And it seems to work. Please check
> > > > > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > > > > it and confirm that it works in your setup?
> > > >
> > > > Ah, this was non intuitive but obvious in hindsight:
> > > >
> > > > .bss is zeroed by the kernel after load(), and since my program
> > > > changed the value before foo_bpf__load() , the memory was overwritten
> > > > with 0s. I could confirm this by printing the value after load.
> > > >
> > > > If I update obj->data-><something> after __load(),
> > > > or even after __attach() given that userspace mmaps .bss and .data,
> > > > everything works as expected both for scalars and structs.
> > >
> > > Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
> > > before the load. And checks that those values are preserved after
> > > load. So .bss, if you initialize it manually, shouldn't zero-out what
> > > you set.
>
> strace reveals that the .bss is initially created as anonymous memory:
>
>   mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
> 0) = 0x7fd074a5f000
>   write(2, "after open bss is at 0x7fd074a5f"..., 36after open bss is
> at 0x7fd074a5f000) = 36
>
> and then remapped after the map has been created:
>   bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
> value_size=144,  max_entries=1, map_flags=0x400 /* BPF_F_??? */,
> inner_map_fd=0, map_name="hstats_b.bss", map_ifindex=0, ...}, 120) = 6
>   ...
>   mmap(0x7fd074a5f000, 4096, PROT_READ|PROT_WRITE,
> MAP_SHARED|MAP_FIXED, 6, 0) = 0x7fd074a5f000
>
> so the original content is gone.

not exactly, all of .bss, .rodata, .data and .kconfig are first
mmap()'ed as anonymous memory. I've modified test_skeleton.c to
increase .bss size to 8192 bytes size to distinguish it from other
maps:

1. mmap() anonymous memory (just allocating memory that would keep
initial values that you set with skel->bss->my_var = 123):

mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
0) = 0x7fb3b406f000

2. use that anonymous memory with initialized variables to update map
contents during bpf_object's load:

bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffdab521d50,
value=0x7fb3b406f000, flags=BPF_ANY}, 120) = 0

3. now re-mmap() it with MAP_FIXED, so the same memory address is
pointing to ARRAY's content in the kernel. Because of
BPF_MAP_UPDATE_ELEM above, contents should be identical:

mmap(0x7fb3b406f000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED,
7, 0) = 0x7fb3b406f000

4. later we are done with it:

munmap(0x7fb3b406f000, 8192)            = 0

>
> cheers
> luigi
