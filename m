Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D487C34F88E
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhCaGMY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 02:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231315AbhCaGLz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 02:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617171114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FE/Uu9OdEgvNJJ5WkIjTkjZZpIGeqj+IVUkWfKoqNxU=;
        b=QNX4yHrdd1DoDNWTzv6yMLunE0A1gWV6yJmOZYitsunWhB4f+yHIOGcu5W+hFb8nJ4K22E
        s5L+COOQShMyCu90HgLb7zavjpmWqI4zAXBdKDjPxhd/rif2ebjRaEyAapy1FRGzENXaiN
        tHQi5lwqDVZm9J6yxET3pXZLAz7oAhQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-16ScIzLAMEmfz8MKt12lrA-1; Wed, 31 Mar 2021 02:11:51 -0400
X-MC-Unique: 16ScIzLAMEmfz8MKt12lrA-1
Received: by mail-wr1-f70.google.com with SMTP id n17so447195wrq.5
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 23:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FE/Uu9OdEgvNJJ5WkIjTkjZZpIGeqj+IVUkWfKoqNxU=;
        b=pEXJVfu0ijV1SpdlH0jlNEFAiXxR0KRvjwyDfD0ng0W9pJ/UhJ0LK6BFzLArIy/yPE
         hT4sI9Y/J5OmjcVo3PvBqmmqptbWVydgc/x2z4+SPPHRTeOv6jWEk5LXLThUOhpKdSKM
         Cw29w0SS6A5+LzLzz1QJm6ue+HUDDOI+iYH0KBicBjyDs0hINYe6uOqBEfYGMMtqyMra
         fyzTnwdUojj52bu5LaAH5Y+ahUMo0vkvs9ZFlk713/iSftdxbrgn1S9IRm59wGteoSqC
         FHPlQrg7Wv5nNKxkcmh/LLTWvNOeZF+2dUbieHB5NqPNZJLGnCOHmdQhi2y6+6jRd8dP
         09fw==
X-Gm-Message-State: AOAM530waZKIXDV0nw0XwHmc2YcRvQOqDMPLYvh//IhQiPYsrOoQT9ez
        h/OCRuMtZmADm7TFNJ7jRX6bocZu5dK411tPLeMiEg0HiUnlqzBXD5YyA42zqZwh2l5wg1vgFos
        65vTdcwmp14VskGc/PlRIQON4koeV
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr1509939wmf.6.1617171110551;
        Tue, 30 Mar 2021 23:11:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze27AUkir+KGteM/afHioDAoV1j1RQFtkXoljyFf34Xf8Xb+fC1/poDuKoGPvzkuYoo45WfNUFV6GM9EhZKCA=
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr1509914wmf.6.1617171110306;
 Tue, 30 Mar 2021 23:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
 <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com>
 <CANoWswmy1bHbU8hBkF2DiyW3oHr1wDxZU3CsyDHOJ+-fe5DBTA@mail.gmail.com> <CAEf4BzbKfz7if1ktSMiyK4TZYZF8n7mk34UQCi3ZuDZvobkZqQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbKfz7if1ktSMiyK4TZYZF8n7mk34UQCi3ZuDZvobkZqQ@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 31 Mar 2021 09:11:34 +0300
Message-ID: <CANoWswkx1zNy1fbCkgC6h8f21EPKTg15oezjtLsZ3eN6pEf2Ng@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii,

On Wed, Mar 31, 2021 at 8:49 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 8:20 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > On Sun, Mar 28, 2021 at 8:03 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >
> > [...]
> >
> > > >
> > > >  struct {
> > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > -       __uint(max_entries, 4096);
> > > > +       __uint(max_entries, PAGE_SIZE);
> > >
> > >
> > > so you can set map size at runtime before bpf_object__load (or
> > > skeleton's load) with bpf_map__set_max_entries. That way you don't
> > > have to do any assumptions. Just omit max_entries in BPF source code,
> > > and always set it in userspace.
> >
> > Will it work for ringbuf_multi? If I just set max_entries for ringbuf1
> > and ringbuf2 that way, it gives me
> >
> > libbpf: map 'ringbuf_arr': failed to create inner map: -22
> > libbpf: map 'ringbuf_arr': failed to create: Invalid argument(-22)
> > libbpf: failed to load object 'test_ringbuf_multi'
> > libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> > test_ringbuf_multi:FAIL:skel_load skeleton load failed
> >
>
> You are right, it won't work. We'd need to add something like
> bpf_map__inner_map() accessor to allow to adjust the inner map
> definition:
>
> bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);

Thanks!

On top on that, for some reason simple ringbuf_multi (converted to use
dynamic size) does not work on my 64K page configuration too, haven't
investigated why. Works on x86 4K page.

>
> And some more fixes. Here's minimal diff that made it work, but
> probably needs a bit more testing:

Thanks again.
I could send the patchset with mmap only converted and just increase
ringbuf size since it's not selftests only change, but requires libbpf
improvements.

Or you would prefer to change them all together?



> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7aad78dbb4b4..ed5586cce227 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2194,6 +2194,7 @@ static int parse_btf_map_def(struct bpf_object *obj,
>              map->inner_map = calloc(1, sizeof(*map->inner_map));
>              if (!map->inner_map)
>                  return -ENOMEM;
> +            map->inner_map->fd = -1;
>              map->inner_map->sec_idx = obj->efile.btf_maps_shndx;
>              map->inner_map->name = malloc(strlen(map->name) +
>                                sizeof(".inner") + 1);
> @@ -3845,6 +3846,14 @@ __u32 bpf_map__max_entries(const struct bpf_map *map)
>      return map->def.max_entries;
>  }
>
> +struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
> +{
> +    if (!bpf_map_type__is_map_in_map(map->def.type))
> +        return NULL;
> +
> +    return map->inner_map;
> +}
> +
>  int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
>  {
>      if (map->fd >= 0)
> @@ -9476,6 +9485,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
>          pr_warn("error: inner_map_fd already specified\n");
>          return -EINVAL;
>      }
> +    zfree(&map->inner_map);
>      map->inner_map_fd = fd;
>      return 0;
>  }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f500621d28e5..bec4e6a6e31d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -480,6 +480,7 @@ LIBBPF_API int bpf_map__pin(struct bpf_map *map,
> const char *path);
>  LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
>
>  LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
> +LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
>
>  LIBBPF_API long libbpf_get_error(const void *ptr);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f5990f7208ce..eeb6d5ebd1cc 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -360,4 +360,5 @@ LIBBPF_0.4.0 {
>          bpf_linker__free;
>          bpf_linker__new;
>          bpf_object__set_kversion;
> +        bpf_map__inner_map;
>  } LIBBPF_0.3.0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> index d37161e59bb2..cdc9c9b1d0e1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> @@ -41,13 +41,23 @@ static int process_sample(void *ctx, void *data, size_t len)
>  void test_ringbuf_multi(void)
>  {
>      struct test_ringbuf_multi *skel;
> -    struct ring_buffer *ringbuf;
> +    struct ring_buffer *ringbuf = NULL;
>      int err;
>
> -    skel = test_ringbuf_multi__open_and_load();
> +    skel = test_ringbuf_multi__open();
>      if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
>          return;
>
> +    bpf_map__set_max_entries(skel->maps.ringbuf1, 4096);
> +    bpf_map__set_max_entries(skel->maps.ringbuf2, 4096);
> +    bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), 4096);
> +
> +    err = test_ringbuf_multi__load(skel);
> +    if (!ASSERT_OK(err, "skel_load"))
> +        goto cleanup;
> +
>      /* only trigger BPF program for current process */
>      skel->bss->pid = getpid();
>
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> index edf3b6953533..055c10b2ff80 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> @@ -15,7 +15,6 @@ struct sample {
>
>  struct ringbuf_map {
>      __uint(type, BPF_MAP_TYPE_RINGBUF);
> -    __uint(max_entries, 1 << 12);
>  } ringbuf1 SEC(".maps"),
>    ringbuf2 SEC(".maps");
>


-- 
WBR, Yauheni

