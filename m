Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0528A2FC
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgJJXDT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 19:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390804AbgJJW7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 18:59:23 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750CC0613D2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 15:49:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so13160453edk.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBtoJ1BZAchgHbvbJREKQ05omredxeil2IJ7ue+fA0s=;
        b=GwG4U46Znj1OIvFksXZ5fzRYfodWYzuwzeWjx+8JD2rltPleV8zK5gZSJt9KdIEzso
         o4gJL7XtPB5Cf3jhWE+g8YbZIJl60rJJEcPthi/s42MwPXoXyYi8/biOcXnLFBu6AmkX
         d+GElrvzpg5kQkqvE5n06w6eM6ChcX158kxtRiy9jq5BH/INAAwMh9nkv2kv8Fuvsvji
         3bgnTy2NhYxRPcQsvK3Z/Enp66oeDP6hagS8PphqdEVVNaXIXjlJAeP6UV2zysO0iPE2
         +7eC3mEyqHRq7/YUqnsnxgi1RoaRRlQzsErc64elT3shiRiXgNb8Zml21gZNeQheos0W
         injQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBtoJ1BZAchgHbvbJREKQ05omredxeil2IJ7ue+fA0s=;
        b=mv9gGIcHKNhBnI4btB2hMiFcvwt2T+w2GrsWJNv7awVRpwH4LTo1OdoMhMRDPkiCx2
         qjY0MfOg3AgL8Sxsv57WykwA2YVyKk8+wm7rXFb4UHXy32ZO9UDDEVSI4Xg3ZLNHyXv8
         k02dZpEVGtI6Pawdtpkgah9BQ2bATbX8SeArYXaD0x0vaJ+lWsKaQ2jYBvOKQgfmfLzD
         jxBxkRKt9FW7G3sdKuNDnT6VnmvhrQYN7PLwzIozPJPL9aodC14Lz4R0Im0QikAI9Z/w
         3dD53MbKcXiQJFwq8xOLXA93d9qh0BlgM+UjMv5W5Pc8l3KLX7SZvHT6QOPPNwdY8y5d
         SPJA==
X-Gm-Message-State: AOAM5329BvP+zGjBYfXZSAmxZciTpX244sTrj5CrNSaE9gkPg8fZDXw6
        rcSmONuRMQB1iU5dspS+EaIeQ8Pt1x+q961u9nEziA==
X-Google-Smtp-Source: ABdhPJxz+rgga1whiufgqnDVbnErPEmlin6ruo799W7uwwf2YyoQy+zfitVqOJyQayS7l9z2513D31+fZX5lwZFjQTM=
X-Received: by 2002:a50:a6cf:: with SMTP id f15mr1328131edc.30.1602370162990;
 Sat, 10 Oct 2020 15:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
 <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com> <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
In-Reply-To: <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Sun, 11 Oct 2020 00:49:11 +0200
Message-ID: <CAMOZA0LrxjP5dco35NRZeFpMZd7QhuGfvr_aqnZR3nAon_n8ng@mail.gmail.com>
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

Coming back to .bss handling:

On Wed, Oct 7, 2020 at 11:29 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > >
> > > TL;DR; there seems to be a compiler bug with clang-10 and -O2
> > > when struct are in .data -- details below.
> > >
> > > On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > > ...
> > > > > 2. .bss overrides from userspace are not seen in bpf at runtime
...
> > > >
> > > > This is quite surprising, given we have explicit selftests validating
> > > > that all this works. And it seems to work. Please check
> > > > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > > > it and confirm that it works in your setup?
> > >
> > > Ah, this was non intuitive but obvious in hindsight:
> > >
> > > .bss is zeroed by the kernel after load(), and since my program
> > > changed the value before foo_bpf__load() , the memory was overwritten
> > > with 0s. I could confirm this by printing the value after load.
> > >
> > > If I update obj->data-><something> after __load(),
> > > or even after __attach() given that userspace mmaps .bss and .data,
> > > everything works as expected both for scalars and structs.
> >
> > Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
> > before the load. And checks that those values are preserved after
> > load. So .bss, if you initialize it manually, shouldn't zero-out what
> > you set.

strace reveals that the .bss is initially created as anonymous memory:

  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
0) = 0x7fd074a5f000
  write(2, "after open bss is at 0x7fd074a5f"..., 36after open bss is
at 0x7fd074a5f000) = 36

and then remapped after the map has been created:
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4,
value_size=144,  max_entries=1, map_flags=0x400 /* BPF_F_??? */,
inner_map_fd=0, map_name="hstats_b.bss", map_ifindex=0, ...}, 120) = 6
  ...
  mmap(0x7fd074a5f000, 4096, PROT_READ|PROT_WRITE,
MAP_SHARED|MAP_FIXED, 6, 0) = 0x7fd074a5f000

so the original content is gone.

cheers
luigi
