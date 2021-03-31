Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E523504E1
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCaQnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232319AbhCaQne (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSJ6zJh8WaQIAHxuefYdvZ+kZTkl7PHi5/YiyQcyHWA=;
        b=i84AE6x6cHNadyqsCnc8CvbZUTeTF0W+HBcghCtFds8oWPvFKDbhfhFo527LddkIKkMydV
        uR7ufWMHQ2WjuxYiku9b+q7j8LC4pmVxQP/mePYn8Y/J7t/5nxE/TndwQIn1seS5JRszA3
        18axCg++cOXrvqiVyCMkni9fbBk64Uc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-R6oYGwOfNvG2J6ZP17NhEQ-1; Wed, 31 Mar 2021 12:43:31 -0400
X-MC-Unique: R6oYGwOfNvG2J6ZP17NhEQ-1
Received: by mail-wm1-f70.google.com with SMTP id b20-20020a7bc2540000b029010f7732a35fso2078471wmj.1
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 09:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSJ6zJh8WaQIAHxuefYdvZ+kZTkl7PHi5/YiyQcyHWA=;
        b=pp+UoLDlkUEuVN9cgBP2UUHmsn0HSxi8ywsQrQSOxpLkQa1ru6f7yifwSHhBa6VBLn
         Ct2j2mqqc3HUZVP2POoe2LUgNgN6jDU34Wj5AOV6ob1y25z7uDRGBwtLF1wEYA6lhyWC
         HDsI8WrkTOxOLWwDTJPDE7O+1r08C3IkUIZm/ePpXQcZ2wZg6zYiSRO5I//X6io5MSNj
         BPziSMThSOqN6OI6nEojsF6TPNkvUTVKzWeKHrIenqm6j4URFWZHzol1YRSVvW+zrky5
         9myKd0quOVbWULTYMRineDRrOf44toAIhM7ShmwxUgm+EGg16h/rkk1WnB6tbDrMYVu4
         XsfA==
X-Gm-Message-State: AOAM532IEayoGSaXYBBP+N3LgtOtUczgg4U0plllxCDO0Sl8yZWx8tSz
        C4MVLdtBeqOgSjGHwWMo9ut3t18vM7V0LXd7qFD9oWkTYAizVzwDHJt93BTTlXsoMWzTfjSaakx
        m/2bNXlXj/vN7jhqze6RimZ8NCT7Z
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr4832502wrw.53.1617209010529;
        Wed, 31 Mar 2021 09:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhdaLyiTJL4eo2BqEhztkRln8eDxnr3MNWjxh24k5N3B6hFQ+17ndwchg6bm9vDoXije8lZKBS4Hf6WOmK6U0=
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr4832484wrw.53.1617209010334;
 Wed, 31 Mar 2021 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
 <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com>
 <CANoWswmy1bHbU8hBkF2DiyW3oHr1wDxZU3CsyDHOJ+-fe5DBTA@mail.gmail.com>
 <CAEf4BzbKfz7if1ktSMiyK4TZYZF8n7mk34UQCi3ZuDZvobkZqQ@mail.gmail.com>
 <CANoWswkx1zNy1fbCkgC6h8f21EPKTg15oezjtLsZ3eN6pEf2Ng@mail.gmail.com> <CAEf4BzaVsoFu7+agFjW+=+0yJeerwStwKzQhruDGgGrkoSmACQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaVsoFu7+agFjW+=+0yJeerwStwKzQhruDGgGrkoSmACQ@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 31 Mar 2021 19:43:14 +0300
Message-ID: <CANoWswmbdFzCh9K66P5u_Nr+hcUuO3MBnXL_y7TRWWz6zu+S=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 9:26 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 30, 2021 at 11:11 PM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Hi, Andrii,
> >
> > On Wed, Mar 31, 2021 at 8:49 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 8:20 AM Yauheni Kaliuta
> > > <yauheni.kaliuta@redhat.com> wrote:
> > > >
> > > > On Sun, Mar 28, 2021 at 8:03 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > >  struct {
> > > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > > -       __uint(max_entries, 4096);
> > > > > > +       __uint(max_entries, PAGE_SIZE);
> > > > >
> > > > >
> > > > > so you can set map size at runtime before bpf_object__load (or
> > > > > skeleton's load) with bpf_map__set_max_entries. That way you don't
> > > > > have to do any assumptions. Just omit max_entries in BPF source code,
> > > > > and always set it in userspace.
> > > >
> > > > Will it work for ringbuf_multi? If I just set max_entries for ringbuf1
> > > > and ringbuf2 that way, it gives me
> > > >
> > > > libbpf: map 'ringbuf_arr': failed to create inner map: -22
> > > > libbpf: map 'ringbuf_arr': failed to create: Invalid argument(-22)
> > > > libbpf: failed to load object 'test_ringbuf_multi'
> > > > libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> > > > test_ringbuf_multi:FAIL:skel_load skeleton load failed
> > > >
> > >
> > > You are right, it won't work. We'd need to add something like
> > > bpf_map__inner_map() accessor to allow to adjust the inner map
> > > definition:
> > >
> > > bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
> >
> > Thanks!
> >
> > On top on that, for some reason simple ringbuf_multi (converted to use
> > dynamic size) does not work on my 64K page configuration too, haven't
> > investigated why. Works on x86 4K page.
> >
> > >
> > > And some more fixes. Here's minimal diff that made it work, but
> > > probably needs a bit more testing:
> >
> > Thanks again.
> > I could send the patchset with mmap only converted and just increase
> > ringbuf size since it's not selftests only change, but requires libbpf
> > improvements.
> >
> > Or you would prefer to change them all together?
>
> Try to figure out why the 64K case doesn't work.

It was not related to the tests actually.

> And then just post
> all the patches together, it doesn't have to be strictly only
> selftests. bpf_map__inner_map() and bpf_map__set_inner_map_fd()
> resetting inner map are both useful for some cases that need more
> manual control.

I took you libbpf patch as is, will post current version.

>
> >
> >
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 7aad78dbb4b4..ed5586cce227 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -2194,6 +2194,7 @@ static int parse_btf_map_def(struct bpf_object *obj,
> > >              map->inner_map = calloc(1, sizeof(*map->inner_map));
> > >              if (!map->inner_map)
> > >                  return -ENOMEM;
> > > +            map->inner_map->fd = -1;
> > >              map->inner_map->sec_idx = obj->efile.btf_maps_shndx;
> > >              map->inner_map->name = malloc(strlen(map->name) +
> > >                                sizeof(".inner") + 1);
> > > @@ -3845,6 +3846,14 @@ __u32 bpf_map__max_entries(const struct bpf_map *map)
> > >      return map->def.max_entries;
> > >  }
> > >
> > > +struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
> > > +{
> > > +    if (!bpf_map_type__is_map_in_map(map->def.type))
> > > +        return NULL;
> > > +
> > > +    return map->inner_map;
> > > +}
> > > +
> > >  int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
> > >  {
> > >      if (map->fd >= 0)
> > > @@ -9476,6 +9485,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
> > >          pr_warn("error: inner_map_fd already specified\n");
> > >          return -EINVAL;
> > >      }
> > > +    zfree(&map->inner_map);
> > >      map->inner_map_fd = fd;
> > >      return 0;
> > >  }
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index f500621d28e5..bec4e6a6e31d 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -480,6 +480,7 @@ LIBBPF_API int bpf_map__pin(struct bpf_map *map,
> > > const char *path);
> > >  LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
> > >
> > >  LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
> > > +LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
> > >
> > >  LIBBPF_API long libbpf_get_error(const void *ptr);
> > >
> > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > index f5990f7208ce..eeb6d5ebd1cc 100644
> > > --- a/tools/lib/bpf/libbpf.map
> > > +++ b/tools/lib/bpf/libbpf.map
> > > @@ -360,4 +360,5 @@ LIBBPF_0.4.0 {
> > >          bpf_linker__free;
> > >          bpf_linker__new;
> > >          bpf_object__set_kversion;
> > > +        bpf_map__inner_map;
> > >  } LIBBPF_0.3.0;
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > index d37161e59bb2..cdc9c9b1d0e1 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > > @@ -41,13 +41,23 @@ static int process_sample(void *ctx, void *data, size_t len)
> > >  void test_ringbuf_multi(void)
> > >  {
> > >      struct test_ringbuf_multi *skel;
> > > -    struct ring_buffer *ringbuf;
> > > +    struct ring_buffer *ringbuf = NULL;
> > >      int err;
> > >
> > > -    skel = test_ringbuf_multi__open_and_load();
> > > +    skel = test_ringbuf_multi__open();
> > >      if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> > >          return;
> > >
> > > +    bpf_map__set_max_entries(skel->maps.ringbuf1, 4096);
> > > +    bpf_map__set_max_entries(skel->maps.ringbuf2, 4096);
> > > +    bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), 4096);
> > > +
> > > +    err = test_ringbuf_multi__load(skel);
> > > +    if (!ASSERT_OK(err, "skel_load"))
> > > +        goto cleanup;
> > > +
> > >      /* only trigger BPF program for current process */
> > >      skel->bss->pid = getpid();
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > index edf3b6953533..055c10b2ff80 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > > @@ -15,7 +15,6 @@ struct sample {
> > >
> > >  struct ringbuf_map {
> > >      __uint(type, BPF_MAP_TYPE_RINGBUF);
> > > -    __uint(max_entries, 1 << 12);
> > >  } ringbuf1 SEC(".maps"),
> > >    ringbuf2 SEC(".maps");
> > >
> >
> >
> > --
> > WBR, Yauheni
> >
>


-- 
WBR, Yauheni

