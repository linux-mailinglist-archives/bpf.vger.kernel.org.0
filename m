Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9C357C06
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 07:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhDHF5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 01:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhDHF5F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 01:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617861414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWjUl9+NPZwT+XeLn4M2Kujim8C9XAhqvljsGLk+Q9I=;
        b=jCARDanQDQFWWprW6N4VFIml7VLx/r6dokPe1haqHKCw16stg7d5woxI0aad132LWkH7Vn
        kep7e53tJtq4L/j+h5E7Uuqn2Y4ZO4Af2GSqdsvKfKfG2p/S2YGR+N1wmMa8lEarAwWcnN
        BrqKpSP6Pw77SMF9E0RxbPYDGxKEtQg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-1w2LZ20nODilcF60y_X_gQ-1; Thu, 08 Apr 2021 01:56:52 -0400
X-MC-Unique: 1w2LZ20nODilcF60y_X_gQ-1
Received: by mail-wm1-f70.google.com with SMTP id c195-20020a1c9acc0000b029011b91a22942so2909159wme.0
        for <bpf@vger.kernel.org>; Wed, 07 Apr 2021 22:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWjUl9+NPZwT+XeLn4M2Kujim8C9XAhqvljsGLk+Q9I=;
        b=ByAro+mMo8fHlRGm0IcLLHhKbjYGMknKWWvGNVFKu8XHiJrg9UMnBQVy6wiYQc2FiD
         RId7KKUR4VnhYs3s+yTeKqGZBT8gceMG3NagRGQLX5LDP/7ZyT3L6GMyCOgIruN71rfP
         NHagEEDi3A8vEYKakori+n/+PN01vm98+NtwtHI4UiA5qhx9jxH/CrXrQEy/QuHoO6SI
         O3oP7fEX8WjFZ63zYGqCS81zzq5Ng77c4umdvDXhPenjcVZY3ffHAVFbtJgTod/jeAQw
         nX4Uqz2WoULJUAoOCfxELgJQ+E5APvFk1FbTD9UwnqJXHN8/mRGO7sUQq+1Bt8h0gWt0
         olBA==
X-Gm-Message-State: AOAM531rqXnKjiVIihHQpqfbEyDrTzFP/MwUIUDkfYZEJsW6/Gw6rTge
        5cA/3pis1TK0wl6Lf+JvvKBWajeeXlt7rhWthjN3fCyXugGpmMw+jkaL5gccvSa/JkuFZTd5MbB
        xF2ayAAyYluj6XOlWk+wEq2e/mdEF
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr1150701wru.57.1617861410670;
        Wed, 07 Apr 2021 22:56:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPgac//Kj4r2KRlbkd908Vy546w6bKEQpJyNtBqrZJAbG67//s17kEdS62XvH7GtjGwvMLdJdfSaRoC5Nq1ZM=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr1150685wru.57.1617861410465;
 Wed, 07 Apr 2021 22:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
 <CAEf4BzaeB_M-95U4cOUccM00XitBaMPnpS7Wik4T9SLSfdixyg@mail.gmail.com>
 <CANoWswmZPW8uVOR-iEKTZ6rT3MqdVR_zg5p4D-7zH6xnZqGt7g@mail.gmail.com>
 <CAEf4BzZC1Ww75V5_PFsrC7mPjYejVeOF9Y_6RBtqFn0ZcP+0YA@mail.gmail.com> <CAEf4BzbBva_5yJRv15G4egLGnsF722bOJMLMUKXSn7nQPOQfqA@mail.gmail.com>
In-Reply-To: <CAEf4BzbBva_5yJRv15G4egLGnsF722bOJMLMUKXSn7nQPOQfqA@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 8 Apr 2021 08:56:34 +0300
Message-ID: <CANoWswnq0Z4BiiEMi0O5VETK7wSVm+r5ZL9DUbxT6_Ug_13zyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: ringbuf_multi: use runtime
 page size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 9:17 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 7, 2021 at 11:05 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 7, 2021 at 9:36 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > Hi, Andrii!
> > >
> > > On Wed, Mar 31, 2021 at 9:52 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
> > > > <yauheni.kaliuta@redhat.com> wrote:
> > > > >
> > > > > Set bpf table sizes dynamically according to the runtime page size
> > > > > value.
> > > > >
> > > > > Do not switch to ASSERT macros, keep CHECK, for consistency with the
> > > > > rest of the test. Can be a separate cleanup patch.
> > > > >
> > > > > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > > > > ---
> > > > >  .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++++++++++++---
> > > > >  .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
> > > > >  2 files changed, 20 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > > > index d37161e59bb2..159de99621c7 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > > > @@ -41,13 +41,30 @@ static int process_sample(void *ctx, void *data, size_t len)
> > > > >  void test_ringbuf_multi(void)
> > > > >  {
> > > > >         struct test_ringbuf_multi *skel;
> > > > > -       struct ring_buffer *ringbuf;
> > > > > +       struct ring_buffer *ringbuf = NULL;
> > > > >         int err;
> > > > > +       int page_size = getpagesize();
> > > > >
> > > > > -       skel = test_ringbuf_multi__open_and_load();
> > > > > -       if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> > > > > +       skel = test_ringbuf_multi__open();
> > > > > +       if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> > > > >                 return;
> > > > >
> > > > > +       err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
> > > > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
> > > > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
> > > > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       err = test_ringbuf_multi__load(skel);
> > > > > +       if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> > > > > +               goto cleanup;
> > > > > +
> > > >
> > > > To test bpf_map__set_inner_map_fd() interaction with map-in-map
> > > > initialization, can you extend the test to have another map-in-map
> > > > (could be HASHMAP, just for fun), which is initialized with either
> > > > ringbuf1 or ringbuf2, but then from user-space use a different way to
> > > > override inner map definition:
> > > >
> > > > int proto_fd = bpf_create_map(... RINGBUF of page_size ...);
> > > > bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> > > > close(proto_fd);
> > > >
> > > > /* perform load, it should succeed */
> > > >
> > > > Important is to use a different map-in-map from ringbuf_arr, so that
> > > > load fails, unless set_inner_map_fd() properly updates internals of a
> > > > map.
> > >
> > > Is that what you mean?
> >
> > yes
> >
> >
> > > https://github.com/ykaliuta/linux/commit/59fedd3b00678023d04b74bac61581a04896602e
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > index 159de99621c7..5794317d05dd 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > @@ -44,6 +44,7 @@ void test_ringbuf_multi(void)
> > >         struct ring_buffer *ringbuf = NULL;
> > >         int err;
> > >         int page_size = getpagesize();
> > > +       int proto_fd;
> > >
> > >         skel = test_ringbuf_multi__open();
> > >         if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> > > @@ -61,6 +62,16 @@ void test_ringbuf_multi(void)
> > >         if (CHECK(err != 0, "bpf_map__set_max_entries",
> > > "bpf_map__set_max_entries failed\n"))
> > >                 goto cleanup;
> > >
> > > +       proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
> > > +       if (CHECK(proto_fd == -1, "bpf_create_map", "bpf_create_map failed\n"))
> > > +               goto cleanup;
> > > +
> > > +       err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> > > +       if (CHECK(err != 0, "bpf_map__set_inner_map_fd",
> > > "bpf_map__set_inner_map_fd failed\n"))
> > > +               goto cleanup;
> > > +
> > > +       close(proto_fd);
>
> I think the problem is this, you are deleting that inner map too soon,
> before the kernel can get it. Try moving close(proto_fd) after the
> load step.

Ah, of course, stupid me :) Thanks, it works!

>
> > > +
> > >         err = test_ringbuf_multi__load(skel);
> > >         if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> > >                 goto cleanup;
> > > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > index 055c10b2ff80..197b86546dca 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > @@ -30,6 +30,17 @@ struct {
> > >         },
> > >  };
> > >
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> > > +       __uint(max_entries, 1);
> > > +       __type(key, int);
> > > +       __array(values, struct ringbuf_map);
> > > +} ringbuf_hash SEC(".maps") = {
> > > +       .values = {
> > > +               [0] = &ringbuf1,
> > > +       },
> > > +};
> > > +
> > >
> > >
> > > I get with it:
> > >
> > > test_ringbuf_multi:PASS:bpf_map__set_inner_map_fd 0 nsec
> > > libbpf: Error in bpf_create_map_xattr(ringbuf_arr):Invalid
> > > argument(-22). Retrying without BTF.
> > > libbpf: Error in bpf_create_map_xattr(ringbuf_hash):Invalid
> > > argument(-22). Retrying without BTF.
> > > libbpf: map 'ringbuf_hash': failed to create: Invalid argument(-22)
> > > libbpf: failed to load object 'test_ringbuf_multi'
> > > libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> > > test_ringbuf_multi:FAIL:skel_load skeleton load failed
> > > #90 ringbuf_multi:FAIL
> >
> > Did you try to investigate why it doesn't work?
> >
> > >
> > >
> > > >
> > > > >         /* only trigger BPF program for current process */
> > > > >         skel->bss->pid = getpid();
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > > > index edf3b6953533..055c10b2ff80 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > > > @@ -15,7 +15,6 @@ struct sample {
> > > > >
> > > > >  struct ringbuf_map {
> > > > >         __uint(type, BPF_MAP_TYPE_RINGBUF);
> > > > > -       __uint(max_entries, 1 << 12);
> > > > >  } ringbuf1 SEC(".maps"),
> > > > >    ringbuf2 SEC(".maps");
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> > > >
> > >
> > >
> > > --
> > > WBR, Yauheni
> > >
>


-- 
WBR, Yauheni

