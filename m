Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AF357410
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbhDGSRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344500AbhDGSRu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 14:17:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785CC06175F
        for <bpf@vger.kernel.org>; Wed,  7 Apr 2021 11:17:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 82so10566798yby.7
        for <bpf@vger.kernel.org>; Wed, 07 Apr 2021 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9yCoqUABnKlhwHYxi3mpxVfZoi/jIDJoQBdkbq4DlQ=;
        b=I0w8flZdRJMKFyJGgKZ/ixBUtA+fJyP07OXnr3JKM7Oo2hpTQbX+wwtGFwykp1Ozol
         l1b+nN/xSMCHTHv43SEmHCo1RY9DfQkXU5EnYulFEWhsQvgyCqWh7ccJQ8NgLGB034PN
         x7L3hCHjh8yZh1/tUPogvg2V2juBMrJMpr5wdqPsETxczc3wJ8+U2wM1ksDhnt07+61T
         uz8vrvx6Xweyu8bWG1e1aud0nbUIGzKMOsLOyM5bZQoQ4yXJC+LBStAJL+9FU3uiPSZB
         IUNvYOra5wFGvPddlPD5TNR8n6tyrRiXplcIOerwe9fnvjhFz4pUQjJ1pWJVpYcWUO1/
         kT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9yCoqUABnKlhwHYxi3mpxVfZoi/jIDJoQBdkbq4DlQ=;
        b=s44Yb5uXt6PbL94REqFTAVitzky/ieJZ/tZnPAuL4JqskRBxwhSjtE6S+heairmCRZ
         TTea6i9yCw5sSFME6MCjPQk/HdjKSrOFWqfscxtFwJtH3k/8j/ojgz7T87JpK4435VAk
         y2a8FfvdSslKeEitssKKYKBnsjLhTKC724Yg3XBOmoy84+Oj1Tuf8Rg+E9y0elTeGHTZ
         9I+Cn0YCQNaoX+EQpII+PrBPUDG6WEbCIHVbBqOhYiN7ENVZVh5ABTyZGcLNmE3FErOA
         FDdWrvObKIbm3sgy+85y7fQCk7KpJL7Sq83Z2fm+z3WSW2oCK4nKiXsyuuhcdC20e1H2
         OqjA==
X-Gm-Message-State: AOAM531tBkTFaxLI7JbjqLKiDTH9qCwLjO/NmV4cbSLAFP6TC3Bl50JX
        XHuhykAPqdCXRZdeoIoz60QSqzTAd5drvfjpo7I=
X-Google-Smtp-Source: ABdhPJzhHCAVVTBwLhXU4z5FbLXhrYbL6QgFGUUwgbd/w8vMR1QrWwizgrFfWazAcK7jZZCZx3CoZw3BfGcV1ADJnoo=
X-Received: by 2002:a25:6d83:: with SMTP id i125mr6001726ybc.27.1617819458522;
 Wed, 07 Apr 2021 11:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
 <CAEf4BzaeB_M-95U4cOUccM00XitBaMPnpS7Wik4T9SLSfdixyg@mail.gmail.com>
 <CANoWswmZPW8uVOR-iEKTZ6rT3MqdVR_zg5p4D-7zH6xnZqGt7g@mail.gmail.com> <CAEf4BzZC1Ww75V5_PFsrC7mPjYejVeOF9Y_6RBtqFn0ZcP+0YA@mail.gmail.com>
In-Reply-To: <CAEf4BzZC1Ww75V5_PFsrC7mPjYejVeOF9Y_6RBtqFn0ZcP+0YA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Apr 2021 11:17:27 -0700
Message-ID: <CAEf4BzbBva_5yJRv15G4egLGnsF722bOJMLMUKXSn7nQPOQfqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: ringbuf_multi: use runtime
 page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 11:05 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 7, 2021 at 9:36 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Hi, Andrii!
> >
> > On Wed, Mar 31, 2021 at 9:52 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
> > > <yauheni.kaliuta@redhat.com> wrote:
> > > >
> > > > Set bpf table sizes dynamically according to the runtime page size
> > > > value.
> > > >
> > > > Do not switch to ASSERT macros, keep CHECK, for consistency with the
> > > > rest of the test. Can be a separate cleanup patch.
> > > >
> > > > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++++++++++++---
> > > >  .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
> > > >  2 files changed, 20 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > > index d37161e59bb2..159de99621c7 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > > @@ -41,13 +41,30 @@ static int process_sample(void *ctx, void *data, size_t len)
> > > >  void test_ringbuf_multi(void)
> > > >  {
> > > >         struct test_ringbuf_multi *skel;
> > > > -       struct ring_buffer *ringbuf;
> > > > +       struct ring_buffer *ringbuf = NULL;
> > > >         int err;
> > > > +       int page_size = getpagesize();
> > > >
> > > > -       skel = test_ringbuf_multi__open_and_load();
> > > > -       if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> > > > +       skel = test_ringbuf_multi__open();
> > > > +       if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> > > >                 return;
> > > >
> > > > +       err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
> > > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > > +               goto cleanup;
> > > > +
> > > > +       err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
> > > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > > +               goto cleanup;
> > > > +
> > > > +       err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
> > > > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > > > +               goto cleanup;
> > > > +
> > > > +       err = test_ringbuf_multi__load(skel);
> > > > +       if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> > > > +               goto cleanup;
> > > > +
> > >
> > > To test bpf_map__set_inner_map_fd() interaction with map-in-map
> > > initialization, can you extend the test to have another map-in-map
> > > (could be HASHMAP, just for fun), which is initialized with either
> > > ringbuf1 or ringbuf2, but then from user-space use a different way to
> > > override inner map definition:
> > >
> > > int proto_fd = bpf_create_map(... RINGBUF of page_size ...);
> > > bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> > > close(proto_fd);
> > >
> > > /* perform load, it should succeed */
> > >
> > > Important is to use a different map-in-map from ringbuf_arr, so that
> > > load fails, unless set_inner_map_fd() properly updates internals of a
> > > map.
> >
> > Is that what you mean?
>
> yes
>
>
> > https://github.com/ykaliuta/linux/commit/59fedd3b00678023d04b74bac61581a04896602e
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > index 159de99621c7..5794317d05dd 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > @@ -44,6 +44,7 @@ void test_ringbuf_multi(void)
> >         struct ring_buffer *ringbuf = NULL;
> >         int err;
> >         int page_size = getpagesize();
> > +       int proto_fd;
> >
> >         skel = test_ringbuf_multi__open();
> >         if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> > @@ -61,6 +62,16 @@ void test_ringbuf_multi(void)
> >         if (CHECK(err != 0, "bpf_map__set_max_entries",
> > "bpf_map__set_max_entries failed\n"))
> >                 goto cleanup;
> >
> > +       proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
> > +       if (CHECK(proto_fd == -1, "bpf_create_map", "bpf_create_map failed\n"))
> > +               goto cleanup;
> > +
> > +       err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> > +       if (CHECK(err != 0, "bpf_map__set_inner_map_fd",
> > "bpf_map__set_inner_map_fd failed\n"))
> > +               goto cleanup;
> > +
> > +       close(proto_fd);

I think the problem is this, you are deleting that inner map too soon,
before the kernel can get it. Try moving close(proto_fd) after the
load step.

> > +
> >         err = test_ringbuf_multi__load(skel);
> >         if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> >                 goto cleanup;
> > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > index 055c10b2ff80..197b86546dca 100644
> > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > @@ -30,6 +30,17 @@ struct {
> >         },
> >  };
> >
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> > +       __uint(max_entries, 1);
> > +       __type(key, int);
> > +       __array(values, struct ringbuf_map);
> > +} ringbuf_hash SEC(".maps") = {
> > +       .values = {
> > +               [0] = &ringbuf1,
> > +       },
> > +};
> > +
> >
> >
> > I get with it:
> >
> > test_ringbuf_multi:PASS:bpf_map__set_inner_map_fd 0 nsec
> > libbpf: Error in bpf_create_map_xattr(ringbuf_arr):Invalid
> > argument(-22). Retrying without BTF.
> > libbpf: Error in bpf_create_map_xattr(ringbuf_hash):Invalid
> > argument(-22). Retrying without BTF.
> > libbpf: map 'ringbuf_hash': failed to create: Invalid argument(-22)
> > libbpf: failed to load object 'test_ringbuf_multi'
> > libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> > test_ringbuf_multi:FAIL:skel_load skeleton load failed
> > #90 ringbuf_multi:FAIL
>
> Did you try to investigate why it doesn't work?
>
> >
> >
> > >
> > > >         /* only trigger BPF program for current process */
> > > >         skel->bss->pid = getpid();
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > > index edf3b6953533..055c10b2ff80 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > > @@ -15,7 +15,6 @@ struct sample {
> > > >
> > > >  struct ringbuf_map {
> > > >         __uint(type, BPF_MAP_TYPE_RINGBUF);
> > > > -       __uint(max_entries, 1 << 12);
> > > >  } ringbuf1 SEC(".maps"),
> > > >    ringbuf2 SEC(".maps");
> > > >
> > > > --
> > > > 2.31.1
> > > >
> > >
> >
> >
> > --
> > WBR, Yauheni
> >
