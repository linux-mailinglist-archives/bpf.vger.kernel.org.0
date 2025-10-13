Return-Path: <bpf+bounces-70843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE7BD6B7E
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F9118A65E0
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12368270EA3;
	Mon, 13 Oct 2025 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meRyBmh4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECE211F
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397545; cv=none; b=Qf72gTP6vIFnDVQe27Vw0IWc89p97wpev4+I5XVhF3vfrb8+H5vFDreRQ0c7xMPo76saev3ZowwaTYBLAYue0c35EUpwFfdJ5H6keXy7G+AX0ahRdeUU11Wgg838w2kgvfQdlg956uBSxZ5gdTeVZ/lFxzpyRFSbMoxB1ywFolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397545; c=relaxed/simple;
	bh=tyWh5AmdL3AbZirCAWiUEYkSS3AFAV8lPRjWrZmIJoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwlXZC4t6k3BjcJkLiEDFlyWUD7MuuGmYnwv27jDfs9zMUnoZJ8/42/7fZdWxv3gn0dJ+/ws/GSNOreW9FY7DeD/Ft1xCnMqPEJNky4MeN8ImjhGec3xjIPDoW8ZZe4VVxlblxXRKIVfcTk6BpF0aTKriFbb8FCh4JNnCjg2vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meRyBmh4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso4252031a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760397543; x=1761002343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9kwn/z4eiW99q0345zsDUdwEvyJUhhZMdbh1VxiHFo=;
        b=meRyBmh4TpPJBIkgaKC7T5/OHAD0Tb1T5vS+FXRYVltSkX48EXYCCjxE+lOm9fGFlr
         JPI0DFpvyIxtDr/fMwN9BrDNFn6s1x6UrZW8rE8AVhXGVD9n2BnzpgH2j8jyCgNUf2ol
         kPHBOU8ZZMFvOMLjJEkJlySm5ig4FYNEKkXGJGPyes3KYhVSXEhSUoYCVCFqL6B/ULPx
         2B3pdMcbw3HsNh4mTqEut/O7bR/WFYfjrTHgq+alMpoGHOLmBF/zyQmFeKl1Uh3soHjP
         G7JW47LfbeElUAZU2DvFup0CdMF/sNhvjal0c4xE5x/I99gzZBRVD5whtbob5UTByX5b
         5Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760397543; x=1761002343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9kwn/z4eiW99q0345zsDUdwEvyJUhhZMdbh1VxiHFo=;
        b=QAbvdTw3Y5TtsVQXY466yk6ZxVRc00TpAn5gsWU494P2+Pm0Bjxkxi9FvaARmdNJ1s
         t/aQUnQN9lwwLX2SOGY3zCxgOZO6Fu+tQoItAosMkRHvhBEtMLf5BCNT+47tGLW1vjMA
         0ti6rp3NZZ4R/lfNrQWeaM1At1rWFWxH1WGEO0GglUxpV8iD2cVV7yvxO+Fz+qvqQ7MN
         Sf291MmYYxzoCX8VF3ZvYWAACTLhxIIyvJxKMaTIxuqSuTON1zSN5OuiAHIjrtQxdC1r
         VFs35Xu0JZWTII5OOXdbKOxxWypcQB9iF7oNUBcGaoq1ha3UBXUCXvqwvSa8QFvfFt10
         E8HA==
X-Gm-Message-State: AOJu0YzJa+K+zx4GX7pmmb5OO8kjxPI7mRmhZaxBw2C7XvIFfP22HDyz
	cPVyLKI3C5ju669TIzD6C/qRQ+FqG361q6rellMGNeSqz40LwIthZijgMwUa0n8aljJdaLpnGT9
	AXSa7RbTJZ8qaEBg/8iUauIZmeCxgySY=
X-Gm-Gg: ASbGncs0UmOR2p+P+xVntmIosGm8BmAfCO6Zx6xXSyoK7D32au+lun8z72PgdM0qfqA
	N9bnifkSR+BO23SRBoGPmn8Xr6/NWzExzF0mftfsPmcvSGGBs6X/HPhKbANSQi5tFnw1qdXu9nX
	BFP6rVlvl3Fd6jrOHWffyvi5hA2Yhs6gP+iGIo0sEDy32T1NNQYff/aEuy/QrGxuYkekzZAxPnF
	iJX/wGwNekUsdwfyH/UJopBsfRY2x4ubc9pTev4Og==
X-Google-Smtp-Source: AGHT+IGG/O9RdaGWYDIiSAYiqnVRBhMjljaB4XzLVYwruOGlBwLZQlZXkCJ8VIyPjbohdef06nl1pEZhQJfULoP3l9Q=
X-Received: by 2002:a17:90b:1d10:b0:330:84c8:92d7 with SMTP id
 98e67ed59e1d1-33b5112973dmr33002571a91.12.1760397543073; Mon, 13 Oct 2025
 16:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007220349.3852807-1-memxor@gmail.com> <20251007220349.3852807-4-memxor@gmail.com>
 <CAEf4Bzbe9f7VD-6NqMjfismR0dSEUCEoqo6jOZXEDis-f9zQpw@mail.gmail.com> <CAP01T75YR4xXTc57AHgEE4eG6P+3UFdw+0-L1D+au3QZPFQyzw@mail.gmail.com>
In-Reply-To: <CAP01T75YR4xXTc57AHgEE4eG6P+3UFdw+0-L1D+au3QZPFQyzw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 16:18:48 -0700
X-Gm-Features: AS18NWBH23WNJwcUh8RVjtfWDqXh96T2xGwRbdPAyaiGo4ggsTSfECloXD8imks
Message-ID: <CAEf4BzaFVNmnsO2xVdMN_c3M7dG8=UrAfwdROuMurRByC7hk8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for async cb context
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:15=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 10 Oct 2025 at 19:01, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Tue, Oct 7, 2025 at 3:03=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > Add tests to verify that async callback's sleepable attribute is
> > > correctly determined by the callback type, not the arming program's
> > > context, reflecting its true execution context.
> > >
> > > Introduce verifier_async_cb_context.c with tests for all three async
> > > callback primitives: bpf_timer, bpf_wq, and bpf_task_work. Each
> > > primitive is tested when armed from both sleepable (lsm.s/file_open) =
and
> > > non-sleepable (fentry) programs.
> > >
> > > Test coverage:
> > > - bpf_timer callbacks: Verify they are never sleepable, even when arm=
ed
> > >   from sleepable programs. Both tests should fail when attempting to =
use
> > >   sleepable helper bpf_copy_from_user() in the callback.
> > >
> > > - bpf_wq callbacks: Verify they are always sleepable, even when armed
> > >   from non-sleepable programs. Both tests should succeed when using
> > >   sleepable helpers in the callback.
> > >
> > > - bpf_task_work callbacks: Verify they are always sleepable, even whe=
n
> > >   armed from non-sleepable programs. Both tests should succeed when
> > >   using sleepable helpers in the callback.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > >  .../bpf/progs/verifier_async_cb_context.c     | 181 ++++++++++++++++=
++
> > >  2 files changed, 183 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_=
cb_context.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tool=
s/testing/selftests/bpf/prog_tests/verifier.c
> > > index 28e81161e6fc..c0e8ffdaa484 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > @@ -7,6 +7,7 @@
> > >  #include "verifier_arena.skel.h"
> > >  #include "verifier_arena_large.skel.h"
> > >  #include "verifier_array_access.skel.h"
> > > +#include "verifier_async_cb_context.skel.h"
> > >  #include "verifier_basic_stack.skel.h"
> > >  #include "verifier_bitfield_write.skel.h"
> > >  #include "verifier_bounds.skel.h"
> > > @@ -280,6 +281,7 @@ void test_verifier_array_access(void)
> > >                       verifier_array_access__elf_bytes,
> > >                       init_array_access_maps);
> > >  }
> > > +void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb=
_context); }
> > >
> > >  static int init_value_ptr_arith_maps(struct bpf_object *obj)
> > >  {
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_cont=
ext.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> > > new file mode 100644
> > > index 000000000000..96ff6749168b
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> > > @@ -0,0 +1,181 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > > +
> > > +#include <vmlinux.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include "bpf_misc.h"
> > > +#include "bpf_experimental.h"
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +/* Timer tests */
> > > +
> > > +struct timer_elem {
> > > +       struct bpf_timer t;
> > > +};
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +       __uint(max_entries, 1);
> > > +       __type(key, int);
> > > +       __type(value, struct timer_elem);
> > > +} timer_map SEC(".maps");
> > > +
> > > +static int timer_cb(void *map, int *key, struct bpf_timer *timer)
> > > +{
> > > +       u32 data;
> > > +       /* Timer callbacks are never sleepable, even from non-sleepab=
le programs */
> > > +       bpf_copy_from_user(&data, sizeof(data), NULL);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("fentry/bpf_fentry_test1")
> > > +__failure __msg("helper call might sleep in a non-sleepable prog")
> > > +int timer_non_sleepable_prog(void *ctx)
> > > +{
> > > +       struct timer_elem *val;
> > > +       int key =3D 0;
> > > +
> > > +       val =3D bpf_map_lookup_elem(&timer_map, &key);
> > > +       if (!val)
> > > +               return 0;
> > > +
> > > +       bpf_timer_init(&val->t, &timer_map, 0);
> > > +       bpf_timer_set_callback(&val->t, timer_cb);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("lsm.s/file_open")
> > > +__failure __msg("helper call might sleep in a non-sleepable prog")
> > > +int timer_sleepable_prog(void *ctx)
> > > +{
> > > +       struct timer_elem *val;
> > > +       int key =3D 0;
> > > +
> > > +       val =3D bpf_map_lookup_elem(&timer_map, &key);
> > > +       if (!val)
> > > +               return 0;
> > > +
> > > +       bpf_timer_init(&val->t, &timer_map, 0);
> > > +       bpf_timer_set_callback(&val->t, timer_cb);
> > > +       return 0;
> > > +}
> >
> > can you please also add (as a follow up is fine) this case:
> >
> > static noinline int mixed_mode_subprog(void)
> > {
> >     /* use one of is_storage_get_function() helpers here */
> > }
> >
> > static int timer_cb(void *map, int *key, struct bpf_timer *timer)
> > {
> >     mixed_mode_subprog();
> >     return 0;
> > }
> >
> > SEC("lsm.s/file_open") /* sleepable entry program */
> > int sleepable(void *ctx) {
> >     ...
> >     bpf_timer_set_callback(&val->t, timer_cb);
> >
> >     /* !!! important to call it here */
> >     mixed_mode_subprog();
> > }
> >
> > Idea being that we have a subprog that is called in both sleepable and
> > non-sleepable modes. It should be rejected.
> >
> > Let's do the same the other way, when the entry program is
> > non-sleepable but an async callback is sleepable, ok?
> >
> >
> > Note also that noinline part is important, we need to make sure it
> > doesn't get inline anywhere. If necessary, we can do __weak __hidden
> > to make this happen.
>
> I didn't get why it needs to be rejected.
> That seems like something that is bound to trip up users.
> Shouldn't we instead allow this, but choose the most restrictive
> context when setting any necessary flags etc.?
> E.g. if it's both sleepable and non-sleepable, we should simply always
> do GFP_ATOMIC.
>

Most restrictive context differs based on exactly what functionality
is being used.

E.g., for KF_RCU the most conservative approach is to assume sleepable
context and require explicit bpf_rcu_read_{lock,unlock}().

For memory allocation flags, the most conservative approach would be
to assume non-sleepable and use GFP_ATOMIC.

It might be ok to mix sleepable and non-sleepable treatment for
different instructions within the same subprog, but that seems like a
bit of a hairy approach.

Either way, let's add tests and make sure they don't do the wrong
thing. Whether we reject such subprogs or manage to wrangle them to be
always correct and safe regardless of sleepable/non-sleepable context,
that's something to think through and decide.

Does it make sense?


> >
> > [...]

