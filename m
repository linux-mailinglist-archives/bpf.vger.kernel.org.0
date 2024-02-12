Return-Path: <bpf+bounces-21766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A59851E8B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5811C2261B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3567482C5;
	Mon, 12 Feb 2024 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11FMG5XN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E0481AD
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769184; cv=none; b=W2m75b+1E3GGVXqUrDL5mWOq/PtRdl4feof2tzyAXZIAqw1cc8Rxw6im5rQmL5vQFg6GsTEChNWA/HIZjG6O3OEMCoIHChgrOIbTQaO3tsWOd12J2hI/4y2nVCeNq/oivcmbdBGTpAjZVGhk4tG86gjPicTWgVDF+/9gpNZn09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769184; c=relaxed/simple;
	bh=uJODUvONYUlc20hpmSj0J1uA1bYdfMjYs2on9f3uMaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMOyMYcbEH5BFlWpomDO2WzwJbYFVfLhwaPPWmedbEyClAIJFFJuINeuKpJQIxaqSJ8+qvwD7t5aKrIVpPl5TNc75v4bE+G/FnXIzwHUmM++rWLYKA+xugS6JJB4GpU/L+eQ0S3hbGjtoIc7mOJLuoYNsoUwRHh5df6IWin/OG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11FMG5XN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d93b982761so49195ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707769182; x=1708373982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icnm5yBA0aCxHiFxkqBy8LL31RhB/IB62tLF3Y2+Rh4=;
        b=11FMG5XNHfIstKlv1zF3fyvh+Of51VOIQ2onsVY8flJARraF4gjA5LIN+TFj2G1O5W
         JWiTYiKZ+SEZLn/+eX1i9XDfHJE+fcfUbAclkhxjoN9r6sxui/mioNKfqwkLfYqQ+lHA
         H77yyFuuYc9HakPkptohUGOu4QJ7/e3wzSYQXPcQm6A3o6wGW2MciPyiWFpIvEBBCqjj
         TI/wYJ34DXgJ6R5fHY/mLEUAuhJXGEUn2yghX4Mj2RL82+ltrj89lcoxG57yLODw4jGD
         0/dmZyZAP206IU2Bk/rFDz0iwPpsvL4FvZvmbQbPZDKX6ctgz3naW+Tl+PG6p3a/gQsg
         cRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769182; x=1708373982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Icnm5yBA0aCxHiFxkqBy8LL31RhB/IB62tLF3Y2+Rh4=;
        b=PrZrxseYm4b/XP47cbOJPbjF9rV6MAMn8JV9AO9muQh+nTlP9Zp4qblnxdomCvNvMJ
         sVU6T++xI8Y9MRVgejpjDCHKXPKOSraisgN/5oijQQqn6iPbvGBwHHTR6fMwmGU8e9vf
         Mcbv/6h9jos14vnhGQOiGK4A89bdFl+RX/qH997hcMeojFx10jPIcbKIoPvZicq/kYu6
         A76vVCEy+GwFfRfZyOBOVLoR4azbl6SVqJRnLkGHddIiGEEu7jNjzhf+eS1gIq7TsdwG
         rN0zceqVxt5GEsUIeRKMyqm24ku7D2WlilgjxqC8deyTM29sy+CftbKxWdGixY0iIsKS
         zPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyANk4jxSfKb4zx46YMYeZAuqClcNaB++fedcSoMYE76Q+clwiR70Ym/qMXiZt22KPA2UC9UZ5ntAOvFMvxqAhUcKT
X-Gm-Message-State: AOJu0Yzie12223nFPh6oGrUjJYuUE7gCkrh+PA940kjgs/j0zO4payIk
	cjCAttWBcJ93ixvuJcTnMLdbvrfzHAfdOfA4CpZrpuS1uVZu+g0lH5u765efD6zMVx6SbeH6Phd
	h++sgStAUBgupIWMpasvmHlJYwa+IFTiKOhX+
X-Google-Smtp-Source: AGHT+IFlMmc/VgL27uQvdpqBTW3rRUsQvhkAr01w85UMAaL7w4vejw2tDQTJNnyrG/NRrY5ESxZBez3SdEz5nMr0uSI=
X-Received: by 2002:a17:902:c1d4:b0:1d8:e076:21f3 with SMTP id
 c20-20020a170902c1d400b001d8e07621f3mr550plc.2.1707769181746; Mon, 12 Feb
 2024 12:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com> <20240210031746.4057262-2-irogers@google.com>
 <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com>
In-Reply-To: <CAM9d7chEKepmHY_Mgvq27CEcKB1e8bENwn2=pMe-yin30nfGLA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Feb 2024 12:19:26 -0800
Message-ID: <CAP-5=fX7h9ku-XgjYe+3B5NWOJnapLnuJ_JqxywPaTu76VxazA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] perf maps: Switch from rbtree to lazily sorted
 array for addresses
To: Namhyung Kim <namhyung@kernel.org>
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

On Mon, Feb 12, 2024 at 12:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Feb 9, 2024 at 7:18=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Maps is a collection of maps primarily sorted by the starting address
> > of the map. Prior to this change the maps were held in an rbtree
> > requiring 4 pointers per node. Prior to reference count checking, the
> > rbnode was embedded in the map so 3 pointers per node were
> > necessary. This change switches the rbtree to an array lazily sorted
> > by address, much as the array sorting nodes by name. 1 pointer is
> > needed per node, but to avoid excessive resizing the backing array may
> > be twice the number of used elements. Meaning the memory overhead is
> > roughly half that of the rbtree. For a perf record with
> > "--no-bpf-event -g -a" of true, the memory overhead of perf inject is
> > reduce fom 3.3MB to 3MB, so 10% or 300KB is saved.
> >
> > Map inserts always happen at the end of the array. The code tracks
> > whether the insertion violates the sorting property. O(log n) rb-tree
> > complexity is switched to O(1).
> >
> > Remove slides the array, so O(log n) rb-tree complexity is degraded to
> > O(n).
> >
> > A find may need to sort the array using qsort which is O(n*log n), but
> > in general the maps should be sorted and so average performance should
> > be O(log n) as with the rbtree.
> >
> > An rbtree node consumes a cache line, but with the array 4 nodes fit
> > on a cache line. Iteration is simplified to scanning an array rather
> > than pointer chasing.
> >
> > Overall it is expected the performance after the change should be
> > comparable to before, but with half of the memory consumed.
> >
> > To avoid a list and repeated logic around splitting maps,
> > maps__merge_in is rewritten in terms of
> > maps__fixup_overlap_and_insert. maps_merge_in splits the given mapping
> > inserting remaining gaps. maps__fixup_overlap_and_insert splits the
> > existing mappings, then adds the incoming mapping. By adding the new
> > mapping first, then re-inserting the existing mappings the splitting
> > behavior matches.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> [SNIP]
> >  int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, v=
oid *data), void *data)
> >  {
> > -       struct map_rb_node *pos;
> > +       bool done =3D false;
> >         int ret =3D 0;
> >
> > -       down_read(maps__lock(maps));
> > -       maps__for_each_entry(maps, pos) {
> > -               ret =3D cb(pos->map, data);
> > -               if (ret)
> > -                       break;
> > +       /* See locking/sorting note. */
> > +       while (!done) {
> > +               down_read(maps__lock(maps));
> > +               if (maps__maps_by_address_sorted(maps)) {
> > +                       /*
> > +                        * maps__for_each_map callbacks may buggily/uns=
afely
> > +                        * insert into maps_by_address. Deliberately re=
load
> > +                        * maps__nr_maps and maps_by_address on each it=
eration
> > +                        * to avoid using memory freed by maps__insert =
growing
> > +                        * the array - this may cause maps to be skippe=
d or
> > +                        * repeated.
> > +                        */
> > +                       for (unsigned int i =3D 0; i < maps__nr_maps(ma=
ps); i++) {
> > +                               struct map **maps_by_address =3D maps__=
maps_by_address(maps);
>
> Any chance they can move out of the loop?  I guess not as they are
> not marked to const/pure functions..

It's not because the cb(...) call below will potentially modify
maps_by_address by inserting maps and reallocating the array. Having
it outside the loop was what caused the original bug.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                               struct map *map =3D maps_by_address[i];
> > +
> > +                               ret =3D cb(map, data);
> > +                               if (ret)
> > +                                       break;
> > +                       }
> > +                       done =3D true;
> > +               }
> > +               up_read(maps__lock(maps));
> > +               if (!done)
> > +                       maps__sort_by_address(maps);
> >         }
> > -       up_read(maps__lock(maps));
> >         return ret;
> >  }

