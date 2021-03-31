Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE234F8B7
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhCaG0V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhCaG0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 02:26:04 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E3C061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 23:26:03 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i144so20034851ybg.1
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUrePSh+r5bafBRT3kynd3dsKgBzKWuK6TLq5ErVQVA=;
        b=ope5kUt6jGnnlfolAVABNUqy8x283xUaDkVKgtCMXiQqmccEOdT+7Xr8YenauJ6qY8
         gAkElkTR+X/s2pmN2yOt71oZj8fCebumNfBTUVhy2gYgkw2EKyVrmr4X4qwGIjMUqUBp
         p37obsQKB7DyYa+nQ90fqXmpz5ffx2VrGjixoVbIobE4cOOG+G0YtvKYdId1MFEz81IJ
         fiLdErlIqcWcEaBbyCik4o+OaE11/2U5xqASp5qfPPwuep+S0CKKWxqLAh3+g5CKxgCm
         cGt07fOnkjxQeKabIu4pcaYrjBe045dvTbkyLbhDz+zJ0Y53zSb4gOfPtU7UPN67EIwi
         7c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUrePSh+r5bafBRT3kynd3dsKgBzKWuK6TLq5ErVQVA=;
        b=d0RiL3dV8X9rKnPNdTJAIDf9fnVI7seTbNQWSNK/mLxyigesMM4CBT73TZfonunhjy
         E0f9rWuM6XrDd9364mQdmZSRtPUSkg09Qhlja4a4H2Km6PGyYnxS9oQ7EM/LuzawBIsL
         +KHIlZCPtqUkXpYnFG6LE2QuBOL5PwC+Pfpya7Ly1C4FiT8y7XG5LwSNOH9n1p1+epwW
         684H0RSVXsEIH6TX76P9KZYBXzrpZ+y+v5vQTW118EkM55LqyaI5ZO38cN6HUzM9rXNY
         7mBfTzJttKu6kmPL8A3myswilmGElmBRQJNa/EnId6EZ8wOLCH3XQR8M6v7bhIucuxov
         BmLw==
X-Gm-Message-State: AOAM533tSuTn1Mul39slmB60uXSTHBoDbJqbLXLV1E8PKNn+jp6C807/
        KDdFOqdtMbC4Yvh1/qXSjmO20faw+OCzM0IJxAc3mgPy
X-Google-Smtp-Source: ABdhPJzY5OFcpLkA2qWR9Jl8x+/4UNFDqEJBTpzDTovhEM53jFkyaRdPV/I7NFNBp7N6q4ae0Iy4lSeXEAEMR3zkOJQ=
X-Received: by 2002:a25:874c:: with SMTP id e12mr2467089ybn.403.1617171963137;
 Tue, 30 Mar 2021 23:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
 <CAEf4BzZowiRKeLGw7JikKuMs+dy-=OTMbUb3eFJCq03Br7P30g@mail.gmail.com>
 <CANoWswmy1bHbU8hBkF2DiyW3oHr1wDxZU3CsyDHOJ+-fe5DBTA@mail.gmail.com>
 <CAEf4BzbKfz7if1ktSMiyK4TZYZF8n7mk34UQCi3ZuDZvobkZqQ@mail.gmail.com> <CANoWswkx1zNy1fbCkgC6h8f21EPKTg15oezjtLsZ3eN6pEf2Ng@mail.gmail.com>
In-Reply-To: <CANoWswkx1zNy1fbCkgC6h8f21EPKTg15oezjtLsZ3eN6pEf2Ng@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Mar 2021 23:25:52 -0700
Message-ID: <CAEf4BzaVsoFu7+agFjW+=+0yJeerwStwKzQhruDGgGrkoSmACQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 11:11 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii,
>
> On Wed, Mar 31, 2021 at 8:49 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 29, 2021 at 8:20 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > On Sun, Mar 28, 2021 at 8:03 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > [...]
> > >
> > > > >
> > > > >  struct {
> > > > >         __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > > -       __uint(max_entries, 4096);
> > > > > +       __uint(max_entries, PAGE_SIZE);
> > > >
> > > >
> > > > so you can set map size at runtime before bpf_object__load (or
> > > > skeleton's load) with bpf_map__set_max_entries. That way you don't
> > > > have to do any assumptions. Just omit max_entries in BPF source code,
> > > > and always set it in userspace.
> > >
> > > Will it work for ringbuf_multi? If I just set max_entries for ringbuf1
> > > and ringbuf2 that way, it gives me
> > >
> > > libbpf: map 'ringbuf_arr': failed to create inner map: -22
> > > libbpf: map 'ringbuf_arr': failed to create: Invalid argument(-22)
> > > libbpf: failed to load object 'test_ringbuf_multi'
> > > libbpf: failed to load BPF skeleton 'test_ringbuf_multi': -22
> > > test_ringbuf_multi:FAIL:skel_load skeleton load failed
> > >
> >
> > You are right, it won't work. We'd need to add something like
> > bpf_map__inner_map() accessor to allow to adjust the inner map
> > definition:
> >
> > bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
>
> Thanks!
>
> On top on that, for some reason simple ringbuf_multi (converted to use
> dynamic size) does not work on my 64K page configuration too, haven't
> investigated why. Works on x86 4K page.
>
> >
> > And some more fixes. Here's minimal diff that made it work, but
> > probably needs a bit more testing:
>
> Thanks again.
> I could send the patchset with mmap only converted and just increase
> ringbuf size since it's not selftests only change, but requires libbpf
> improvements.
>
> Or you would prefer to change them all together?

Try to figure out why the 64K case doesn't work. And then just post
all the patches together, it doesn't have to be strictly only
selftests. bpf_map__inner_map() and bpf_map__set_inner_map_fd()
resetting inner map are both useful for some cases that need more
manual control.

>
>
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 7aad78dbb4b4..ed5586cce227 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2194,6 +2194,7 @@ static int parse_btf_map_def(struct bpf_object *obj,
> >              map->inner_map = calloc(1, sizeof(*map->inner_map));
> >              if (!map->inner_map)
> >                  return -ENOMEM;
> > +            map->inner_map->fd = -1;
> >              map->inner_map->sec_idx = obj->efile.btf_maps_shndx;
> >              map->inner_map->name = malloc(strlen(map->name) +
> >                                sizeof(".inner") + 1);
> > @@ -3845,6 +3846,14 @@ __u32 bpf_map__max_entries(const struct bpf_map *map)
> >      return map->def.max_entries;
> >  }
> >
> > +struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
> > +{
> > +    if (!bpf_map_type__is_map_in_map(map->def.type))
> > +        return NULL;
> > +
> > +    return map->inner_map;
> > +}
> > +
> >  int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
> >  {
> >      if (map->fd >= 0)
> > @@ -9476,6 +9485,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
> >          pr_warn("error: inner_map_fd already specified\n");
> >          return -EINVAL;
> >      }
> > +    zfree(&map->inner_map);
> >      map->inner_map_fd = fd;
> >      return 0;
> >  }
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index f500621d28e5..bec4e6a6e31d 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -480,6 +480,7 @@ LIBBPF_API int bpf_map__pin(struct bpf_map *map,
> > const char *path);
> >  LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
> >
> >  LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
> > +LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
> >
> >  LIBBPF_API long libbpf_get_error(const void *ptr);
> >
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index f5990f7208ce..eeb6d5ebd1cc 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -360,4 +360,5 @@ LIBBPF_0.4.0 {
> >          bpf_linker__free;
> >          bpf_linker__new;
> >          bpf_object__set_kversion;
> > +        bpf_map__inner_map;
> >  } LIBBPF_0.3.0;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > index d37161e59bb2..cdc9c9b1d0e1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> > @@ -41,13 +41,23 @@ static int process_sample(void *ctx, void *data, size_t len)
> >  void test_ringbuf_multi(void)
> >  {
> >      struct test_ringbuf_multi *skel;
> > -    struct ring_buffer *ringbuf;
> > +    struct ring_buffer *ringbuf = NULL;
> >      int err;
> >
> > -    skel = test_ringbuf_multi__open_and_load();
> > +    skel = test_ringbuf_multi__open();
> >      if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> >          return;
> >
> > +    bpf_map__set_max_entries(skel->maps.ringbuf1, 4096);
> > +    bpf_map__set_max_entries(skel->maps.ringbuf2, 4096);
> > +    bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), 4096);
> > +
> > +    err = test_ringbuf_multi__load(skel);
> > +    if (!ASSERT_OK(err, "skel_load"))
> > +        goto cleanup;
> > +
> >      /* only trigger BPF program for current process */
> >      skel->bss->pid = getpid();
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > index edf3b6953533..055c10b2ff80 100644
> > --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> > @@ -15,7 +15,6 @@ struct sample {
> >
> >  struct ringbuf_map {
> >      __uint(type, BPF_MAP_TYPE_RINGBUF);
> > -    __uint(max_entries, 1 << 12);
> >  } ringbuf1 SEC(".maps"),
> >    ringbuf2 SEC(".maps");
> >
>
>
> --
> WBR, Yauheni
>
