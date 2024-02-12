Return-Path: <bpf+bounces-21769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6B851EA0
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964E12827AD
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159F482E9;
	Mon, 12 Feb 2024 20:26:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E44C606;
	Mon, 12 Feb 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769587; cv=none; b=IU1DMNcNR0yATZmMY96x7ZsvmOBnaAXYiOkgfrudaufNheyHGVZBbJU9NOtpoa6WOTfPpSv23dABllBvKJ/bPzBPVN8ZmcqTxrk2posOC7AxmZDXb4gZYgrce36/CjluXMNusJqI6jBmEJciH1Rv7pgthas9ciR44sOqZloZ/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769587; c=relaxed/simple;
	bh=Rfk8H0cufu6L5HVsNaYbQMr4zRjqv98K50DDSUxp2/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUu7OtOORWTPy9mZ0LwNnNlv7W8Kz9/UtVSxEjieYQsS+WrHuaDNKRlYjAQqFYml8os+SoM/US3Nkb/+TcSBSTerCyXU+Gt0hQwp5QoTPc8CNDCEfwSymEShmnkib/m157T4XP8Yz1FUDu6cPI/DBiz6LXSkqjCeiBaiRRtILzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so1182633241.3;
        Mon, 12 Feb 2024 12:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769584; x=1708374384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oDdobSWjhMuhpl2SjOENndcMi2LuqYBF4JWDKsUtvU=;
        b=GcxnjTHQ2TfG697bYL5EMUi+J+eiqKq2ekHLKhSMIVaVeJLp/L0crq1GBkFVRVQ8SZ
         RxYH9z1Z/lZsK0+pjdN6UFYIKtMTvazP/zq+C9FKLSEDrG3veJb0Mmh5MfLlkgW3lkD9
         M+VfcWTWMNUn7icB39aaOB+xZd293+j8BYHuCmYDIjfZDMEQPSYd9z9Hlt+Mz1KdSZ9p
         ykZMKza1dhI/lVTcrlwyeoL8ybtRb0lLvda2lrflPhFQEURLyUrOfGeXlIimJGRooX8s
         ILO1VAkMi/lmiwm6X+VIr2gV7Dbs5p4JQ9+Vq3790daofbDU1WUbLCIQveqNuWQedWGG
         93EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKQ8vdfflPfKjTF2fGxj1h7UZOJhKc+UnSWH1838/OUDm5M0yu6plUTZ8KvYG/pnPIZqXVOxqG4l0qVhfyygFQz9LH0JPZS+UWuSc81HDQyzgowt7FNyW1JovRryFPVxHZeeDo/lOe8f4vEFrqiCnAJej3UZNXt1QNUedavtMUjVoVzw==
X-Gm-Message-State: AOJu0YwcFt7jyyIdq1oEbcTWEz3Z7Em56ZWOhyCiBz+4ICYyr0OOxHws
	zHLJuV1yWXNYIuWdGL68f3eHgLTof+EHxEVlch4KWmQzntG0N+SJ0QgdacgZrVGhaF/8qLS+f8B
	HbUGWHEHR7hsOohPBa/uFa4VyeBM=
X-Google-Smtp-Source: AGHT+IE8RQym1+HJzAQZXtINY2YnsP3MTnUZBRGmjYXjV3sRME09ZXH76BYYetHSlYnshiazXY7PDUwHH6xkRx/HWnw=
X-Received: by 2002:a1f:cb41:0:b0:4c0:6406:ee62 with SMTP id
 b62-20020a1fcb41000000b004c06406ee62mr3992472vkg.13.1707769584308; Mon, 12
 Feb 2024 12:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com> <20240210031746.4057262-2-irogers@google.com>
 <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com> <CAP-5=fX7h9ku-XgjYe+3B5NWOJnapLnuJ_JqxywPaTu76VxazA@mail.gmail.com>
In-Reply-To: <CAP-5=fX7h9ku-XgjYe+3B5NWOJnapLnuJ_JqxywPaTu76VxazA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 12 Feb 2024 12:26:12 -0800
Message-ID: <CAM9d7cgGAd7xEzwRxQFXoxpY9_gWduqYpy5jpp1zDTFjJqSxbw@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 12:19=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Feb 12, 2024 at 12:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Fri, Feb 9, 2024 at 7:18=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Maps is a collection of maps primarily sorted by the starting address
> > > of the map. Prior to this change the maps were held in an rbtree
> > > requiring 4 pointers per node. Prior to reference count checking, the
> > > rbnode was embedded in the map so 3 pointers per node were
> > > necessary. This change switches the rbtree to an array lazily sorted
> > > by address, much as the array sorting nodes by name. 1 pointer is
> > > needed per node, but to avoid excessive resizing the backing array ma=
y
> > > be twice the number of used elements. Meaning the memory overhead is
> > > roughly half that of the rbtree. For a perf record with
> > > "--no-bpf-event -g -a" of true, the memory overhead of perf inject is
> > > reduce fom 3.3MB to 3MB, so 10% or 300KB is saved.
> > >
> > > Map inserts always happen at the end of the array. The code tracks
> > > whether the insertion violates the sorting property. O(log n) rb-tree
> > > complexity is switched to O(1).
> > >
> > > Remove slides the array, so O(log n) rb-tree complexity is degraded t=
o
> > > O(n).
> > >
> > > A find may need to sort the array using qsort which is O(n*log n), bu=
t
> > > in general the maps should be sorted and so average performance shoul=
d
> > > be O(log n) as with the rbtree.
> > >
> > > An rbtree node consumes a cache line, but with the array 4 nodes fit
> > > on a cache line. Iteration is simplified to scanning an array rather
> > > than pointer chasing.
> > >
> > > Overall it is expected the performance after the change should be
> > > comparable to before, but with half of the memory consumed.
> > >
> > > To avoid a list and repeated logic around splitting maps,
> > > maps__merge_in is rewritten in terms of
> > > maps__fixup_overlap_and_insert. maps_merge_in splits the given mappin=
g
> > > inserting remaining gaps. maps__fixup_overlap_and_insert splits the
> > > existing mappings, then adds the incoming mapping. By adding the new
> > > mapping first, then re-inserting the existing mappings the splitting
> > > behavior matches.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > [SNIP]
> > >  int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map,=
 void *data), void *data)
> > >  {
> > > -       struct map_rb_node *pos;
> > > +       bool done =3D false;
> > >         int ret =3D 0;
> > >
> > > -       down_read(maps__lock(maps));
> > > -       maps__for_each_entry(maps, pos) {
> > > -               ret =3D cb(pos->map, data);
> > > -               if (ret)
> > > -                       break;
> > > +       /* See locking/sorting note. */
> > > +       while (!done) {
> > > +               down_read(maps__lock(maps));
> > > +               if (maps__maps_by_address_sorted(maps)) {
> > > +                       /*
> > > +                        * maps__for_each_map callbacks may buggily/u=
nsafely
> > > +                        * insert into maps_by_address. Deliberately =
reload
> > > +                        * maps__nr_maps and maps_by_address on each =
iteration
> > > +                        * to avoid using memory freed by maps__inser=
t growing
> > > +                        * the array - this may cause maps to be skip=
ped or
> > > +                        * repeated.
> > > +                        */
> > > +                       for (unsigned int i =3D 0; i < maps__nr_maps(=
maps); i++) {
> > > +                               struct map **maps_by_address =3D maps=
__maps_by_address(maps);
> >
> > Any chance they can move out of the loop?  I guess not as they are
> > not marked to const/pure functions..
>
> It's not because the cb(...) call below will potentially modify
> maps_by_address by inserting maps and reallocating the array. Having
> it outside the loop was what caused the original bug.

Oh, I meant if compiler can move them automatically.

Thanks,
Namhyung

> >
> >
> > > +                               struct map *map =3D maps_by_address[i=
];
> > > +
> > > +                               ret =3D cb(map, data);
> > > +                               if (ret)
> > > +                                       break;
> > > +                       }
> > > +                       done =3D true;
> > > +               }
> > > +               up_read(maps__lock(maps));
> > > +               if (!done)
> > > +                       maps__sort_by_address(maps);
> > >         }
> > > -       up_read(maps__lock(maps));
> > >         return ret;
> > >  }

