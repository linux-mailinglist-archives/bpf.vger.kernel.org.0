Return-Path: <bpf+bounces-21765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B1851E82
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E6D1F20C6E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BE3481B9;
	Mon, 12 Feb 2024 20:15:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4246549;
	Mon, 12 Feb 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768955; cv=none; b=qNpSDimDQmVzBxJhqkpbHDKs9aqAZ2o3HUnmZqUjAVUUMhqDdT+Oww8ezRLGAycf2tl/kE3kqG6ncx4pbpCjmYmdr27ez7vbV6HY02uU06sz5icqmLFB8+Y8W+k7pgcs9u650Y6Q2ZDe07gYeMFQbCHf6cwCOcbutxs7gvsBffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768955; c=relaxed/simple;
	bh=6DeBBGjtML8X8YuhkGNNMtZfq39v4Tjs06avkaT38kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbFC49kJAUpl9EWyrAjBoh0ilriDpO11WdVlj865OgHlrm1WtMj7aqwUiFOjBYTSkUEMopQtRdo5P5aW1cRxwrFhmOC8ENDETTdCYs+69Yvsd7Z+uGysaV/HHfw7IzW3/8zpl5YD1ADfSek9ICKB94u06p0XIvsDou19IDWFJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d6a772e08dso1013856241.2;
        Mon, 12 Feb 2024 12:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768953; x=1708373753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLRvRTEoJFPB+mnvlsBs6KwuSM3ocAbsQPXOvw4Twl8=;
        b=wi2RPv1cpfwDoUyrVw+D+A2uEwKNcR4+w60kPrnLPc56zvLaeO2GVk9EsPmGvfW+kd
         u6OJtDycuSEuUYlALjioeJjYekPl4vgNL4C+aGdcShayo8j9eVHhr7lpl7HAxwNvLzub
         pm8hian5hVFzTMXnJszp3IF+kLmNwoJSuOlT1t6+PvUVnK4yWoUSKXcQBoJ4NGYMMrGX
         eZPUP0QraAeakwPJTnkKw5I7DsQsXMiRIZz+tkuij9X8+I0ao+e6aOvvzA8Feh6NUUUW
         QPC8/pkPG4PctIZlOf4z5u9/51w3pINmFjSYAzYECwb0vMHCerGZb/Vpm0OzWQaqNBEh
         ocdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZwitFb8VQYuuss5XC025492sVlw17WZBVofkJWpJ2uVkGk3tXck65TiOcGRXImZ6OHOV86V5UbZcbGRdvBwArvGtyUgkERieWXVf+e567UobMdf0ZQiWwoyC+18dw6vyOhb3i+ObNSI98s/i3X2JG5Y+iHvJRV/IngbRE2nbIYzGwYA==
X-Gm-Message-State: AOJu0YyK8Kq2Pp8piRLRnfeGfCNbGQIMuFkD5k32nviaYCJ+U8m/PunD
	ide8Q1aViu1Ufnjvh7ooHKJgTfB6xwScuYYpvtfrOKge4tji7HfR+GyabW5Z8aI9VdoYS2cSoiU
	jvfgDbwktdMWQ102hAKIGu4sNQlE=
X-Google-Smtp-Source: AGHT+IGBiP7NMzFQIwEfL8eMn322qCQQ1psPygyhoKuY5Hgm4/zaOflDwoxkLzUrfowFj+KOpgsq/zXJYMwNK0OZaFw=
X-Received: by 2002:a67:cf8c:0:b0:46e:c4d1:25b5 with SMTP id
 g12-20020a67cf8c000000b0046ec4d125b5mr1838684vsm.22.1707768952762; Mon, 12
 Feb 2024 12:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com> <20240210031746.4057262-2-irogers@google.com>
In-Reply-To: <20240210031746.4057262-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 12 Feb 2024 12:15:41 -0800
Message-ID: <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] perf maps: Switch from rbtree to lazily sorted
 array for addresses
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, leo.yan@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 7:18=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Maps is a collection of maps primarily sorted by the starting address
> of the map. Prior to this change the maps were held in an rbtree
> requiring 4 pointers per node. Prior to reference count checking, the
> rbnode was embedded in the map so 3 pointers per node were
> necessary. This change switches the rbtree to an array lazily sorted
> by address, much as the array sorting nodes by name. 1 pointer is
> needed per node, but to avoid excessive resizing the backing array may
> be twice the number of used elements. Meaning the memory overhead is
> roughly half that of the rbtree. For a perf record with
> "--no-bpf-event -g -a" of true, the memory overhead of perf inject is
> reduce fom 3.3MB to 3MB, so 10% or 300KB is saved.
>
> Map inserts always happen at the end of the array. The code tracks
> whether the insertion violates the sorting property. O(log n) rb-tree
> complexity is switched to O(1).
>
> Remove slides the array, so O(log n) rb-tree complexity is degraded to
> O(n).
>
> A find may need to sort the array using qsort which is O(n*log n), but
> in general the maps should be sorted and so average performance should
> be O(log n) as with the rbtree.
>
> An rbtree node consumes a cache line, but with the array 4 nodes fit
> on a cache line. Iteration is simplified to scanning an array rather
> than pointer chasing.
>
> Overall it is expected the performance after the change should be
> comparable to before, but with half of the memory consumed.
>
> To avoid a list and repeated logic around splitting maps,
> maps__merge_in is rewritten in terms of
> maps__fixup_overlap_and_insert. maps_merge_in splits the given mapping
> inserting remaining gaps. maps__fixup_overlap_and_insert splits the
> existing mappings, then adds the incoming mapping. By adding the new
> mapping first, then re-inserting the existing mappings the splitting
> behavior matches.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
[SNIP]
>  int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, voi=
d *data), void *data)
>  {
> -       struct map_rb_node *pos;
> +       bool done =3D false;
>         int ret =3D 0;
>
> -       down_read(maps__lock(maps));
> -       maps__for_each_entry(maps, pos) {
> -               ret =3D cb(pos->map, data);
> -               if (ret)
> -                       break;
> +       /* See locking/sorting note. */
> +       while (!done) {
> +               down_read(maps__lock(maps));
> +               if (maps__maps_by_address_sorted(maps)) {
> +                       /*
> +                        * maps__for_each_map callbacks may buggily/unsaf=
ely
> +                        * insert into maps_by_address. Deliberately relo=
ad
> +                        * maps__nr_maps and maps_by_address on each iter=
ation
> +                        * to avoid using memory freed by maps__insert gr=
owing
> +                        * the array - this may cause maps to be skipped =
or
> +                        * repeated.
> +                        */
> +                       for (unsigned int i =3D 0; i < maps__nr_maps(maps=
); i++) {
> +                               struct map **maps_by_address =3D maps__ma=
ps_by_address(maps);

Any chance they can move out of the loop?  I guess not as they are
not marked to const/pure functions..

Thanks,
Namhyung


> +                               struct map *map =3D maps_by_address[i];
> +
> +                               ret =3D cb(map, data);
> +                               if (ret)
> +                                       break;
> +                       }
> +                       done =3D true;
> +               }
> +               up_read(maps__lock(maps));
> +               if (!done)
> +                       maps__sort_by_address(maps);
>         }
> -       up_read(maps__lock(maps));
>         return ret;
>  }

