Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A343573DF
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbhDGSFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhDGSFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 14:05:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3345C06175F
        for <bpf@vger.kernel.org>; Wed,  7 Apr 2021 11:05:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x189so21095571ybg.5
        for <bpf@vger.kernel.org>; Wed, 07 Apr 2021 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NM8ZYVkriAK2fohi58rM7A/3lJ2W7ovbSCVrDIbsgNs=;
        b=EqsA8xJfrUS132KquxCyQ9Uf0CIKRav9wETHyLed2qI5CpiSNVZH5jRElxb22aVIYa
         2UZ1URcfo7rZQJbp4xtW+yRXUcIcBwiJfTuviGOG4OIQBmb8G8q+fKBPzEtIAk60bkUq
         foJSoD96u3dEWPjDnEHyDEPI3L3m4eJrBPf1arFpOFAX/5koApU8aYu/xjAK9WTcckJt
         hp9ZML2+2L0XLAggAOHc2KIxDKW2oeHRI2anpce2aQt+AhcVQ/qHF+3m9ozLnw+TSVo6
         g2c8N0QLb+cEhMJRXboKoaRl+kU85DgbBY7HISqKSKuKs+DFLOI92RIpqYgAB4SyvCRf
         RV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NM8ZYVkriAK2fohi58rM7A/3lJ2W7ovbSCVrDIbsgNs=;
        b=C0PHBxilxus5Cf3tNLsNFsYrNnzv6AfPLnktdAqYpCPYC/r/+aa3IcgOiH9+zDl9TQ
         DH7qHCj3k6TPGNdzp93EioEevm7aJllKxEC2JQqgcStKwMcHoeScb9KMD/kcYBTdNhgK
         bOHkI67RaCcL3x9u8rZwwjXGFT3noVwWSlSXwkQoEvCqyNxvULxgoMT5oIvAN2OPDbiU
         3tJrGDWc0XbzxLOcfGoyvaVQqAbqSuU3nKHqXdql1hGIZ8WbFarKr4DCo0Fo3GlihbM9
         6twoXq5rUrMARS1lbJdpIyAS7Y3GZpiBsEa1dqDeMAhBV+i11/HluV9eWgpoOlJgEMzq
         LSYw==
X-Gm-Message-State: AOAM533XQHDI9khd/j4vQS/9vrofNoXCGhq5PHKSQQD2tb3HG2oOp2W3
        Wr4zJIwp79VWEoVwDQZXW4VhkUySGoKks03+WIc=
X-Google-Smtp-Source: ABdhPJxFtSEIuSyPdLINL5v2yHs1LBs1s32lZSqxksgAn9mkqpTsyOkfEBi1ZgyA1Nzuw90WSPxMa5qon+It4pQMD2Q=
X-Received: by 2002:a25:d87:: with SMTP id 129mr6184481ybn.260.1617818730234;
 Wed, 07 Apr 2021 11:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
 <CAEf4BzaeB_M-95U4cOUccM00XitBaMPnpS7Wik4T9SLSfdixyg@mail.gmail.com> <CANoWswmZPW8uVOR-iEKTZ6rT3MqdVR_zg5p4D-7zH6xnZqGt7g@mail.gmail.com>
In-Reply-To: <CANoWswmZPW8uVOR-iEKTZ6rT3MqdVR_zg5p4D-7zH6xnZqGt7g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Apr 2021 11:05:19 -0700
Message-ID: <CAEf4BzZC1Ww75V5_PFsrC7mPjYejVeOF9Y_6RBtqFn0ZcP+0YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: ringbuf_multi: use runtime
 page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 9:36 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii!
>
> On Wed, Mar 31, 2021 at 9:52 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > Set bpf table sizes dynamically according to the runtime page size
> > > value.
> > >
> > > Do not switch to ASSERT macros, keep CHECK, for consistency with the
> > > rest of the test. Can be a separate cleanup patch.
> > >
> > > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++++++++++++---
> > >  .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
> > >  2 files changed, 20 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > index d37161e59bb2..159de99621c7 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > @@ -41,13 +41,30 @@ static int process_sample(void *ctx, void *data, size_t len)
> > >  void test_ringbuf_multi(void)
> > >  {
> > >         struct test_ringbuf_multi *skel;
> > > -       struct ring_buffer *ringbuf;
> > > +       struct ring_buffer *ringbuf = NULL;
> > >         int err;
> > > +       int page_size = getpagesize();
> > >
> > > -       skel = test_ringbuf_multi__open_and_load();
> > > -       if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> > > +       skel = test_ringbuf_multi__open();
> > > +       if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> > >                 return;
> > >
> > > +       err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
> > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > +               goto cleanup;
> > > +
> > > +       err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
> > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > +               goto cleanup;
> > > +
> > > +       err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
> > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > +               goto cleanup;
> > > +
> > > +       err = test_ringbuf_multi__load(skel);
> > > +       if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> > > +               goto cleanup;
> > > +
> >
> > To test bpf_map__set_inner_map_fd() interaction with map-in-map
> > initialization, can you extend the test to have another map-in-map
> > (could be HASHMAP, just for fun), which is initialized with either
> > ringbuf1 or ringbuf2, but then from user-space use a different way to
> > override inner map definition:
> >
> > int proto_fd = bpf_create_map(... RINGBUF of page_size ...);
> > bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> > close(proto_fd);
> >
> > /* perform load, it should succeed */
> >
> > Important is to use a different map-in-map from ringbuf_arr, so that
> > load fails, unless set_inner_map_fd() properly updates internals of a
> > map.
>
> Is that what you mean?

yes


> https://github.com/ykaliuta/linux/commit/59fedd3b00678023d04b74bac61581a04896602e
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> index 159de99621c7..5794317d05dd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> @@ -44,6 +44,7 @@ void test_ringbuf_multi(void)
>         struct ring_buffer *ringbuf = NULL;
>         int err;
>         int page_size = getpagesize();
> +       int proto_fd;
>
>         skel = test_ringbuf_multi__open();
>         if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> @@ -61,6 +62,16 @@ void test_ringbuf_multi(void)
>         if (CHECK(err != 0, "bpf_map__set_max_entries",
> "bpf_map__set_max_entries failed\n"))
>                 goto cleanup;
>
> +       proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
> +       if (CHECK(proto_fd == -1, "bpf_create_map", "bpf_create_map failed\n"))
> +               goto cleanup;
> +
> +       err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> +       if (CHECK(err != 0, "bpf_map__set_inner_map_fd",
> "bpf_map__set_inner_map_fd failed\n"))
> +               goto cleanup;
> +
> +       close(proto_fd);
> +
>         err = test_ringbuf_multi__load(skel);
>         if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
>                 goto cleanup;
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> index 055c10b2ff80..197b86546dca 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> @@ -30,6 +30,17 @@ struct {
>         },
>  };
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __array(values, struct ringbuf_map);
> +} ringbuf_hash SEC(".maps") = {
> +       .values = {
> +               [0] = &ringbuf1,
> +       },
> +};
> +
>
>
> I get with it:
>
> test_ringbuf_multi:PASS:bpf_map__set_inner_map_fd 0 nsec
> libbpf: Error in bpf_create_map_xattr(ringbuf_arr):Invalid
> argument(-22). Retrying without BTF.
> libbpf: Error in bpf_create_map_xattr(ringbuf_hash):Invalid
> argument(-22). Retrying without BTF.
> libbpf: map 'ringbuf_hash': failed to create: Invalid argument(-22)
> libbpf: failed to load object 'test_ringbuf_multi'
> libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> test_ringbuf_multi:FAIL:skel_load skeleton load failed
> #90 ringbuf_multi:FAIL

Did you try to investigate why it doesn't work?

>
>
> >
> > >         /* only trigger BPF program for current process */
> > >         skel->bss->pid = getpid();
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > index edf3b6953533..055c10b2ff80 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > @@ -15,7 +15,6 @@ struct sample {
> > >
> > >  struct ringbuf_map {
> > >         __uint(type, BPF_MAP_TYPE_RINGBUF);
> > > -       __uint(max_entries, 1 << 12);
> > >  } ringbuf1 SEC(".maps"),
> > >    ringbuf2 SEC(".maps");
> > >
> > > --
> > > 2.31.1
> > >
> >
>
>
> --
> WBR, Yauheni
>
