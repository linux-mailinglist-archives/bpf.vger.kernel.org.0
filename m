Return-Path: <bpf+bounces-41773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229799AAC8
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323701C21CDD
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE51BFDFE;
	Fri, 11 Oct 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtUgfsCv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455B804;
	Fri, 11 Oct 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669670; cv=none; b=RyiPKZ/bUmYHqB+Io26Xpl/QHg/90HWLrZOP4OgmZ0MR4ht2uxQkcacfZSewtvzfA4shiRr7fgsbKuTF5hYxkcp5t2qRPYxB7Nf706JEf2gYcwQWdh+TzIvtvt+g49eHkPHITNsLMlmETCZy4faADOf7zBmO6GTppwMvZCuOcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669670; c=relaxed/simple;
	bh=8mynNEaZ0hT0/RcT9aLr8SxrUuLtirPGnkOXC5pPXZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMYUxt+Qfazc1LiUQEnwgCzUBBIp+xw//QEcliOre7K1zcM6e8foop7Bea8+wj5RgIrhq1GqLvpgORFrP7UM5UkYxk6kczJhiQn9iMw2rweibFGmPHKuJZ1y6xWi95U7B+GsmcZ6TIuQKT3Ffy7JwRlnzFm91KV8s7SbmMJZqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtUgfsCv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9f998e1e4so1925641a12.1;
        Fri, 11 Oct 2024 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728669668; x=1729274468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiirbpxLNm5AT7dufmX+S9DrEak7ySZgLvcNmiXZ6fA=;
        b=mtUgfsCv+UaHunvixEC4t2mPzW8aR4GlNdx8dPEk2oVJX46f2+O+XogiYhij/IGmHk
         tCZ6oLve79pZsUxBOXq9qYCPgAraSCf/EY37rNG2U+bXI+xXhrUt1xSBOwwUVXB/Uh0t
         DnStDYK/iXjecpCutn+/RORdi5TrUSIv3BG0OTxj/lCBbh/TRclgR0WElRHpW6VTOmAC
         1EYGPkevJzEleo8yMpN4m3e8Dvv08tvIVmM7MlPwS9OsKMqkxTqK+i60/dExepFKgHPN
         Li8FHPVjJW9oQzn78s/Vx6FtfnAt4Y2hbm68UyQEhGPFKHRzeVzykExz05a28AAXeahW
         1eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669668; x=1729274468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiirbpxLNm5AT7dufmX+S9DrEak7ySZgLvcNmiXZ6fA=;
        b=PbHdmmNzSrjHqQT8zSkGRim7Hhmnt+oR8dn/6oHytxvY4nsXE+m6onSXhK9/si8bKZ
         FD5wsLrp/baqRDExaZmDvoXc2SjO7JTUzhFESvHpoVV/GVh6BazSvvi4XH+2fJGfBH0R
         iJs63z8zhKomzB/dtIW2VFhuYUlZGFYEF048RBZeO1S8CtPX+eIffvdhrCbmnvC/7UkI
         ranKUyXuSLUAIYYEv9dYQwL8vr1dgf83Li34CPbnz03yGA1rbGcCO57kPjtS3x1HvkaR
         3eCYyCJltbZXn1f9s05QTfo9J6OawTdrde9WWZThr61dOcq1Kkh8RhGiqwEfm7JApq1W
         6FgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXFqldNenHnMwx2ZiWMHKfUzAYOyzCwwKz1Q9PXL4CFZWyuioLsSQ+oMKY//B5GADlisTmyo0w46x8v7OIlmx4lg==@vger.kernel.org, AJvYcCUYmhrQT6Gomp5uAapW9oonxYZc7DUpM7i/yg66bsWXSy1FgJ0K3Tp6qVujtBOuVg4pE+uMqrBG4JgqLKYG@vger.kernel.org, AJvYcCW8kFHEoRpMhnNyxFJHH38Y8x9N4q8+ROpBhSAbUhIDSEgUA5Hdp5ABA6vTsfThOcHsf9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJa7o7HEaXDI2BN655YdafdWYDX3dmkmHSI5Ld8+CTpm+zkdzM
	i4lzyJNpq+QlYUXJt6BkQu/ak7b6LxNo8cusywXyx1/xMdHeZ+cVpPwy+19kETzQDz0BHfmc109
	DiKNJsiSCi6aBbbJLEcqoq0AzTj4=
X-Google-Smtp-Source: AGHT+IFGHxaG21IMv7iEP3SE8KaKMBe64K46Ft7YZJkhgIaY+f0QaOj4Dx2iMXApt5FONI7nU1z2OdE0XhG0MaaJkkk=
X-Received: by 2002:a17:90a:688b:b0:2e2:eb2d:2352 with SMTP id
 98e67ed59e1d1-2e2f0dc3494mr4221733a91.37.1728669668007; Fri, 11 Oct 2024
 11:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009202009.884884-1-namhyung@kernel.org> <CAEf4BzYQenNtKPmWV=P3EsnqBsjNuAeXpC5ypL1k2z-H60i0=w@mail.gmail.com>
 <ZwlV_jyx3OjfQxwS@google.com>
In-Reply-To: <ZwlV_jyx3OjfQxwS@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Oct 2024 11:00:56 -0700
Message-ID: <CAEf4BzYCOpwnTVGKs8rHE4CdcQHDU0ButEKHnJE5cqcWpdZwWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Fix possible compiler warnings in hashmap
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 10, 2024 at 06:48:26PM -0700, Andrii Nakryiko wrote:
> > On Wed, Oct 9, 2024 at 1:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > The hashmap__for_each_entry[_safe] is accessing 'map' as if it's a
> > > pointer.  But it does without parentheses so passing a static hash ma=
p
> > > with an ampersand (like &slab_hash below) caused compiler warnings du=
e
> > > to unmatched types.
> > >
> > >   In file included from util/bpf_lock_contention.c:5:
> > >   util/bpf_lock_contention.c: In function =E2=80=98exit_slab_cache_it=
er=E2=80=99:
> > >   linux/tools/perf/util/hashmap.h:169:32: error: invalid type argumen=
t of =E2=80=98->=E2=80=99 (have =E2=80=98struct hashmap=E2=80=99)
> > >     169 |         for (bkt =3D 0; bkt < map->cap; bkt++)             =
                   \
> > >         |                                ^~
> > >   util/bpf_lock_contention.c:105:9: note: in expansion of macro =E2=
=80=98hashmap__for_each_entry=E2=80=99
> > >     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
> > >         |         ^~~~~~~~~~~~~~~~~~~~~~~
> > >   /home/namhyung/project/linux/tools/perf/util/hashmap.h:170:31: erro=
r: invalid type argument of =E2=80=98->=E2=80=99 (have =E2=80=98struct hash=
map=E2=80=99)
> > >     170 |                 for (cur =3D map->buckets[bkt]; cur; cur =
=3D cur->next)
> > >         |                               ^~
> > >   util/bpf_lock_contention.c:105:9: note: in expansion of macro =E2=
=80=98hashmap__for_each_entry=E2=80=99
> > >     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
> > >         |         ^~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Cc: bpf@vger.kernel.org
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > I've discovered this while prototyping the slab symbolization for per=
f
> > > lock contention.  So this code is not available yet but I'd like to f=
ix
> > > the problem first.
> > >
> > > Also noticed bpf has the same code and the same problem.  I'll send a
> > > separate patch for them.
> > >
> >
> > Yep, please do. Fixes look good, thanks.
>
> Sure will do, can I get your Acked-by for this patch?
>

Sure:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Thanks,
> Namhyung
>
> >
> > >  tools/perf/util/hashmap.h | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> > > index c12f8320e6682d50..0c4f155e8eb745d9 100644
> > > --- a/tools/perf/util/hashmap.h
> > > +++ b/tools/perf/util/hashmap.h
> > > @@ -166,8 +166,8 @@ bool hashmap_find(const struct hashmap *map, long=
 key, long *value);
> > >   * @bkt: integer used as a bucket loop cursor
> > >   */
> > >  #define hashmap__for_each_entry(map, cur, bkt)                      =
       \
> > > -       for (bkt =3D 0; bkt < map->cap; bkt++)                       =
         \
> > > -               for (cur =3D map->buckets[bkt]; cur; cur =3D cur->nex=
t)
> > > +       for (bkt =3D 0; bkt < (map)->cap; bkt++)                     =
         \
> > > +               for (cur =3D (map)->buckets[bkt]; cur; cur =3D cur->n=
ext)
> > >
> > >  /*
> > >   * hashmap__for_each_entry_safe - iterate over all entries in hashma=
p, safe
> > > @@ -178,8 +178,8 @@ bool hashmap_find(const struct hashmap *map, long=
 key, long *value);
> > >   * @bkt: integer used as a bucket loop cursor
> > >   */
> > >  #define hashmap__for_each_entry_safe(map, cur, tmp, bkt)            =
       \
> > > -       for (bkt =3D 0; bkt < map->cap; bkt++)                       =
         \
> > > -               for (cur =3D map->buckets[bkt];                      =
         \
> > > +       for (bkt =3D 0; bkt < (map)->cap; bkt++)                     =
         \
> > > +               for (cur =3D (map)->buckets[bkt];                    =
         \
> > >                      cur && ({tmp =3D cur->next; true; });           =
         \
> > >                      cur =3D tmp)
> > >
> > > @@ -190,19 +190,19 @@ bool hashmap_find(const struct hashmap *map, lo=
ng key, long *value);
> > >   * @key: key to iterate entries for
> > >   */
> > >  #define hashmap__for_each_key_entry(map, cur, _key)                 =
       \
> > > -       for (cur =3D map->buckets                                    =
         \
> > > -                    ? map->buckets[hash_bits(map->hash_fn((_key), ma=
p->ctx), map->cap_bits)] \
> > > +       for (cur =3D (map)->buckets                                  =
         \
> > > +                    ? (map)->buckets[hash_bits((map)->hash_fn((_key)=
, (map)->ctx), (map)->cap_bits)] \
> > >                      : NULL;                                         =
       \
> > >              cur;                                                    =
       \
> > >              cur =3D cur->next)                                      =
         \
> > > -               if (map->equal_fn(cur->key, (_key), map->ctx))
> > > +               if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
> > >
> > >  #define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)       =
       \
> > > -       for (cur =3D map->buckets                                    =
         \
> > > -                    ? map->buckets[hash_bits(map->hash_fn((_key), ma=
p->ctx), map->cap_bits)] \
> > > +       for (cur =3D (map)->buckets                                  =
         \
> > > +                    ? (map)->buckets[hash_bits((map)->hash_fn((_key)=
, (map)->ctx), (map)->cap_bits)] \
> > >                      : NULL;                                         =
       \
> > >              cur && ({ tmp =3D cur->next; true; });                  =
         \
> > >              cur =3D tmp)                                            =
         \
> > > -               if (map->equal_fn(cur->key, (_key), map->ctx))
> > > +               if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
> > >
> > >  #endif /* __LIBBPF_HASHMAP_H */
> > > --
> > > 2.47.0.rc0.187.ge670bccf7e-goog
> > >
> > >

