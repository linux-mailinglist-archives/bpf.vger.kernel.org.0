Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3442357239
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354324AbhDGQgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 12:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236269AbhDGQgg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 12:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617813386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zOmfaVEuTOpvO86TufmfDM07NVj9sUKpNjYPeznMuU=;
        b=cF6/49tmetab8e2+UoHjHoBP9oXia/BPrO6mXBqayvuxHjIl4PTzUYMB2HAt8MKfPk0zW6
        Gc2sQzGjxpKx3GtmUzQ1DCGmYzLBZpXEagL21QQkKCN3n6nUfQbM5LxdhjP0x3iJ2GmuDz
        LpJC1W9h2Cdy3zmeBx8yHFE1kT8xDeY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-6RkKWtXHOByv16qhSDkWlQ-1; Wed, 07 Apr 2021 12:36:21 -0400
X-MC-Unique: 6RkKWtXHOByv16qhSDkWlQ-1
Received: by mail-wm1-f72.google.com with SMTP id v8so1282573wmg.8
        for <bpf@vger.kernel.org>; Wed, 07 Apr 2021 09:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zOmfaVEuTOpvO86TufmfDM07NVj9sUKpNjYPeznMuU=;
        b=FK2o4JKcsMo5hK+bbaraRwgBuglMb7Q1fpMbaF0wF/hbNUQZEvMKMVr+18qUruvxe8
         oSifNDubJJrbbGiN8Udpz0txrhnev8nE9p4UHmvyyZi4d6JneJH9vZKpOkKthVIsRvkW
         tGWOuIi9JoZbUF3/u/da1n6Hmo+z7mgN4EyK14FiDyjR18GhvQaAqXJe81LnnaKtuDiW
         7WLOchmKlqHSL4juL1kaPM9q3z2TJ1BNllfKe2X5NXR8IhHZv/ZGuWd5JXDYNU85vIeM
         6MIdvU2V9b/QVbZa7GK0LAAqmFwJJUplEwVYHqKr3yMqRhWb8BM+cY77zjAlNEjhACtc
         EzXg==
X-Gm-Message-State: AOAM5328G8gmgIZjCBO/T5YDKwBJyX9sdpDofg5Wf2HxwHBaqjAvuq72
        o2ILRGCJRJYWzSZXH9uHzQDM09lsKeDSOKGBtCizm54QmEF2US8CmfXKDrgv+8XZHjzdJVUyjac
        Um9jkcWJwtdPAfkjU97Ejgyf2wtlE
X-Received: by 2002:a1c:1f94:: with SMTP id f142mr3953511wmf.180.1617813380398;
        Wed, 07 Apr 2021 09:36:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqdrSzW6wAKUQ2XnWd5Nta8pOBMY4cJ3bgjsj7RKNVtqZJBpxZvE8ZIpBgNpBs+GxQafmAKBnJ/A83AteHttw=
X-Received: by 2002:a1c:1f94:: with SMTP id f142mr3953495wmf.180.1617813380188;
 Wed, 07 Apr 2021 09:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
 <CAEf4BzaeB_M-95U4cOUccM00XitBaMPnpS7Wik4T9SLSfdixyg@mail.gmail.com>
In-Reply-To: <CAEf4BzaeB_M-95U4cOUccM00XitBaMPnpS7Wik4T9SLSfdixyg@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 7 Apr 2021 19:36:04 +0300
Message-ID: <CANoWswmZPW8uVOR-iEKTZ6rT3MqdVR_zg5p4D-7zH6xnZqGt7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: ringbuf_multi: use runtime
 page size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

On Wed, Mar 31, 2021 at 9:52 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Set bpf table sizes dynamically according to the runtime page size
> > value.
> >
> > Do not switch to ASSERT macros, keep CHECK, for consistency with the
> > rest of the test. Can be a separate cleanup patch.
> >
> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > ---
> >  .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++++++++++++---
> >  .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
> >  2 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > index d37161e59bb2..159de99621c7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > @@ -41,13 +41,30 @@ static int process_sample(void *ctx, void *data, size_t len)
> >  void test_ringbuf_multi(void)
> >  {
> >         struct test_ringbuf_multi *skel;
> > -       struct ring_buffer *ringbuf;
> > +       struct ring_buffer *ringbuf = NULL;
> >         int err;
> > +       int page_size = getpagesize();
> >
> > -       skel = test_ringbuf_multi__open_and_load();
> > -       if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> > +       skel = test_ringbuf_multi__open();
> > +       if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> >                 return;
> >
> > +       err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
> > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > +               goto cleanup;
> > +
> > +       err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
> > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > +               goto cleanup;
> > +
> > +       err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
> > +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> > +               goto cleanup;
> > +
> > +       err = test_ringbuf_multi__load(skel);
> > +       if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> > +               goto cleanup;
> > +
>
> To test bpf_map__set_inner_map_fd() interaction with map-in-map
> initialization, can you extend the test to have another map-in-map
> (could be HASHMAP, just for fun), which is initialized with either
> ringbuf1 or ringbuf2, but then from user-space use a different way to
> override inner map definition:
>
> int proto_fd = bpf_create_map(... RINGBUF of page_size ...);
> bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> close(proto_fd);
>
> /* perform load, it should succeed */
>
> Important is to use a different map-in-map from ringbuf_arr, so that
> load fails, unless set_inner_map_fd() properly updates internals of a
> map.

Is that what you mean?
https://github.com/ykaliuta/linux/commit/59fedd3b00678023d04b74bac61581a04896602e

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 159de99621c7..5794317d05dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -44,6 +44,7 @@ void test_ringbuf_multi(void)
        struct ring_buffer *ringbuf = NULL;
        int err;
        int page_size = getpagesize();
+       int proto_fd;

        skel = test_ringbuf_multi__open();
        if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -61,6 +62,16 @@ void test_ringbuf_multi(void)
        if (CHECK(err != 0, "bpf_map__set_max_entries",
"bpf_map__set_max_entries failed\n"))
                goto cleanup;

+       proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
+       if (CHECK(proto_fd == -1, "bpf_create_map", "bpf_create_map failed\n"))
+               goto cleanup;
+
+       err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
+       if (CHECK(err != 0, "bpf_map__set_inner_map_fd",
"bpf_map__set_inner_map_fd failed\n"))
+               goto cleanup;
+
+       close(proto_fd);
+
        err = test_ringbuf_multi__load(skel);
        if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
                goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index 055c10b2ff80..197b86546dca 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -30,6 +30,17 @@ struct {
        },
 };

+struct {
+       __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+       __uint(max_entries, 1);
+       __type(key, int);
+       __array(values, struct ringbuf_map);
+} ringbuf_hash SEC(".maps") = {
+       .values = {
+               [0] = &ringbuf1,
+       },
+};
+


I get with it:

test_ringbuf_multi:PASS:bpf_map__set_inner_map_fd 0 nsec
libbpf: Error in bpf_create_map_xattr(ringbuf_arr):Invalid
argument(-22). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr(ringbuf_hash):Invalid
argument(-22). Retrying without BTF.
libbpf: map 'ringbuf_hash': failed to create: Invalid argument(-22)
libbpf: failed to load object 'test_ringbuf_multi'
libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
test_ringbuf_multi:FAIL:skel_load skeleton load failed
#90 ringbuf_multi:FAIL


>
> >         /* only trigger BPF program for current process */
> >         skel->bss->pid = getpid();
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > index edf3b6953533..055c10b2ff80 100644
> > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > @@ -15,7 +15,6 @@ struct sample {
> >
> >  struct ringbuf_map {
> >         __uint(type, BPF_MAP_TYPE_RINGBUF);
> > -       __uint(max_entries, 1 << 12);
> >  } ringbuf1 SEC(".maps"),
> >    ringbuf2 SEC(".maps");
> >
> > --
> > 2.31.1
> >
>


-- 
WBR, Yauheni

