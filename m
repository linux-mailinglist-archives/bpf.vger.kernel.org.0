Return-Path: <bpf+bounces-70776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555CBCEEC6
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D26B4E5776
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 03:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3C1DE3AD;
	Sat, 11 Oct 2025 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLIP2LhA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1E1C5F13
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152560; cv=none; b=hnw+n2JldaGFtPuz6xIfflj1Ql4spsbJS5eluy1InTpcuzSlshNumwFoCQN43Son1olmAEOtpUMM+DQSpTnFGJ/z/Ro5hQj38G73D/nWbH5Taa1jPNpyjU5AgUD35iPdSZ40N0nQeTO+knffgLe15HgnWJCETmXoNI61enz+krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152560; c=relaxed/simple;
	bh=7IDJW6icysLnj+P/otFLXPQdoQ0cgV29kPtpy+GDPG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHhRIEaAcm242LvL80Yo/yMl6f+KHjMxfDwyABeOpv0iFAjSaxQqB6Xnkhgt23bIzP3AlVS+L+iSjqauBUHrK+d5bJP6jdgyTcHdnBcfZVN2PVu8hJ1QohaPNSTsCe75Dzh7lSwWrAvQMiSaE0r16qO46T3UVHle2qtsMeK5KoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLIP2LhA; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b463f986f80so599092866b.2
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 20:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760152557; x=1760757357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoFObeKZcjAucc0CF7FzK5B5iQYICPNJXB9qDwfI5lo=;
        b=BLIP2LhA5qGY7YZmNa/zBYTVPCC4cghw2DHVy7oLQpobXy91vi6BPYUwyrdHFaoAcw
         xfFjgxf++CKnjxeiduaSe3RINuPLxC0xG4MsEGBgphqCe8m/83igCnGmeQuaBrjnNDAn
         7f+l1umh+3rRoJKTM1IliZ5MFlHiFAQpTXa9nxEpm4m6Oe6GN5BhJXPq6UnEwLUI/ke3
         j9ZHJsUcZ9meRXXZNyli81nFU9YitDrCS0gK9eIdf08wGqf1qoL9s424fOH7bvKKYfTN
         ct3wnTajsCXQnzbDMwDVPVCXZqD6NFy5AoMhhmIMt1VGXw+5uSjaOg1ARdNvedEUoKLj
         TJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760152557; x=1760757357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoFObeKZcjAucc0CF7FzK5B5iQYICPNJXB9qDwfI5lo=;
        b=mSOaNVpGBrFCGtEX9+g8A/KzJPO3us5+bJSZJ6tXZM3aP6dGKaBfpaOs8L8/9FBCoE
         SkvdE/+ePFyQ8u7HQtPxyGfgAh1JCeLI/IakCZxXFO8egSFhQPlp4ljv9oVg3yvKnzwA
         WCuNYxhfe/U9R9+fuUs31z2GWUdxETY8iXyAxOrM2zmh8RF+Qu2dCX2yy20l6sfp/iHc
         L8UIDn79PCTPvylOMqhmDdiigSZf5hqBO/MSa8O/7Klaxk3YFYM8qxdRNv/DnGHNfFe5
         MRJKBIR5k8XX02e2HoWWowSzA/uvkBnGCsqPu96s3W/I3WQcVmBbufWQVmrOFf0UmIuh
         FXtQ==
X-Gm-Message-State: AOJu0Yxt/vzJlEkXi5yf1fqXiIsXQS1ASqIEmSuRlWJOyzt22bvlQnxb
	05q6nKszBcCRgUF9foBfo3VnUdV0Ljp6/CdjPHsRwx3REBsCkpZa2EHZujjwbPUwE7FI5UlmiTQ
	AH0/6b57/w9i/1jV8HxSdrD3yBp+zhP4=
X-Gm-Gg: ASbGncvWp5H74bS0eIiUIyDOf7kY50USCSlC31cOIgPznphQvr8ix2CO0iJbdjIMjl8
	QH9GP74kXr5xHGEtQz9iGMK5h4EjkNKx6idfISBgpg0cDZ5PytvIARaJG3wF2jVAiQIgu2y7NPY
	EYDBv6eUQwoqFiVnnjo8FqbFcwGx3T7qwaJOISnDV9l/rs5ipBBH1M9RZZat7JAmgZUg6CF/Ac/
	JAdeJa/3qD2r7KRLRllwTrMdOKDZIIPsXcUo5ScZR8MU5YiCq+87e8atV+cX+E4y7+3wfptoMqD
	VeGQQ55iJPFD56g6fa9VcFfvTXnkteOGAJOTGw==
X-Google-Smtp-Source: AGHT+IEZUeryFmekV2Idm4AeZf8pFp/tMkoI3mYVQ2t5qYAp02+8mIlCUa4aAgCxHs0WL1oVOSdHxmaXXZZQSO41IxE=
X-Received: by 2002:a17:907:94d0:b0:b04:7232:3e97 with SMTP id
 a640c23a62f3a-b50aa3921edmr1468241566b.21.1760152557035; Fri, 10 Oct 2025
 20:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007220349.3852807-1-memxor@gmail.com> <20251007220349.3852807-4-memxor@gmail.com>
 <CAEf4Bzbe9f7VD-6NqMjfismR0dSEUCEoqo6jOZXEDis-f9zQpw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbe9f7VD-6NqMjfismR0dSEUCEoqo6jOZXEDis-f9zQpw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 11 Oct 2025 05:15:20 +0200
X-Gm-Features: AS18NWCYWT2jLMj1T5Cm3be1KzExBA1CUhak-Bo73HFPNUXfVp_Vpd89vqKqHXc
Message-ID: <CAP01T75YR4xXTc57AHgEE4eG6P+3UFdw+0-L1D+au3QZPFQyzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for async cb context
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 at 19:01, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Tue, Oct 7, 2025 at 3:03=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Add tests to verify that async callback's sleepable attribute is
> > correctly determined by the callback type, not the arming program's
> > context, reflecting its true execution context.
> >
> > Introduce verifier_async_cb_context.c with tests for all three async
> > callback primitives: bpf_timer, bpf_wq, and bpf_task_work. Each
> > primitive is tested when armed from both sleepable (lsm.s/file_open) an=
d
> > non-sleepable (fentry) programs.
> >
> > Test coverage:
> > - bpf_timer callbacks: Verify they are never sleepable, even when armed
> >   from sleepable programs. Both tests should fail when attempting to us=
e
> >   sleepable helper bpf_copy_from_user() in the callback.
> >
> > - bpf_wq callbacks: Verify they are always sleepable, even when armed
> >   from non-sleepable programs. Both tests should succeed when using
> >   sleepable helpers in the callback.
> >
> > - bpf_task_work callbacks: Verify they are always sleepable, even when
> >   armed from non-sleepable programs. Both tests should succeed when
> >   using sleepable helpers in the callback.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  .../bpf/progs/verifier_async_cb_context.c     | 181 ++++++++++++++++++
> >  2 files changed, 183 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_cb=
_context.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index 28e81161e6fc..c0e8ffdaa484 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -7,6 +7,7 @@
> >  #include "verifier_arena.skel.h"
> >  #include "verifier_arena_large.skel.h"
> >  #include "verifier_array_access.skel.h"
> > +#include "verifier_async_cb_context.skel.h"
> >  #include "verifier_basic_stack.skel.h"
> >  #include "verifier_bitfield_write.skel.h"
> >  #include "verifier_bounds.skel.h"
> > @@ -280,6 +281,7 @@ void test_verifier_array_access(void)
> >                       verifier_array_access__elf_bytes,
> >                       init_array_access_maps);
> >  }
> > +void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_c=
ontext); }
> >
> >  static int init_value_ptr_arith_maps(struct bpf_object *obj)
> >  {
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_contex=
t.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> > new file mode 100644
> > index 000000000000..96ff6749168b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> > @@ -0,0 +1,181 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "bpf_misc.h"
> > +#include "bpf_experimental.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +/* Timer tests */
> > +
> > +struct timer_elem {
> > +       struct bpf_timer t;
> > +};
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 1);
> > +       __type(key, int);
> > +       __type(value, struct timer_elem);
> > +} timer_map SEC(".maps");
> > +
> > +static int timer_cb(void *map, int *key, struct bpf_timer *timer)
> > +{
> > +       u32 data;
> > +       /* Timer callbacks are never sleepable, even from non-sleepable=
 programs */
> > +       bpf_copy_from_user(&data, sizeof(data), NULL);
> > +       return 0;
> > +}
> > +
> > +SEC("fentry/bpf_fentry_test1")
> > +__failure __msg("helper call might sleep in a non-sleepable prog")
> > +int timer_non_sleepable_prog(void *ctx)
> > +{
> > +       struct timer_elem *val;
> > +       int key =3D 0;
> > +
> > +       val =3D bpf_map_lookup_elem(&timer_map, &key);
> > +       if (!val)
> > +               return 0;
> > +
> > +       bpf_timer_init(&val->t, &timer_map, 0);
> > +       bpf_timer_set_callback(&val->t, timer_cb);
> > +       return 0;
> > +}
> > +
> > +SEC("lsm.s/file_open")
> > +__failure __msg("helper call might sleep in a non-sleepable prog")
> > +int timer_sleepable_prog(void *ctx)
> > +{
> > +       struct timer_elem *val;
> > +       int key =3D 0;
> > +
> > +       val =3D bpf_map_lookup_elem(&timer_map, &key);
> > +       if (!val)
> > +               return 0;
> > +
> > +       bpf_timer_init(&val->t, &timer_map, 0);
> > +       bpf_timer_set_callback(&val->t, timer_cb);
> > +       return 0;
> > +}
>
> can you please also add (as a follow up is fine) this case:
>
> static noinline int mixed_mode_subprog(void)
> {
>     /* use one of is_storage_get_function() helpers here */
> }
>
> static int timer_cb(void *map, int *key, struct bpf_timer *timer)
> {
>     mixed_mode_subprog();
>     return 0;
> }
>
> SEC("lsm.s/file_open") /* sleepable entry program */
> int sleepable(void *ctx) {
>     ...
>     bpf_timer_set_callback(&val->t, timer_cb);
>
>     /* !!! important to call it here */
>     mixed_mode_subprog();
> }
>
> Idea being that we have a subprog that is called in both sleepable and
> non-sleepable modes. It should be rejected.
>
> Let's do the same the other way, when the entry program is
> non-sleepable but an async callback is sleepable, ok?
>
>
> Note also that noinline part is important, we need to make sure it
> doesn't get inline anywhere. If necessary, we can do __weak __hidden
> to make this happen.

I didn't get why it needs to be rejected.
That seems like something that is bound to trip up users.
Shouldn't we instead allow this, but choose the most restrictive
context when setting any necessary flags etc.?
E.g. if it's both sleepable and non-sleepable, we should simply always
do GFP_ATOMIC.

>
> [...]

