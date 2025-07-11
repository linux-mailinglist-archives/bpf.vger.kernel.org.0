Return-Path: <bpf+bounces-63092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA6B02678
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 23:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A09A47BC5
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D431D432D;
	Fri, 11 Jul 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrY9x+u0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149D1991C9
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269926; cv=none; b=D8w8GK2NwZEzfugaZokvCbIeNRIiWLf5lb6mq5WTUTPU8r9GAak3Sg1QaqKfzgjjdKcB50NdM0k6A9TVZJSCIIVa4nZ3eX6MOmdtxxGBFpRkIlQQ1eV1Td52B3J0ItqeHY9AYhFXjLhMHGmA2WUiwXuwNsthyN+aINhEwnltk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269926; c=relaxed/simple;
	bh=NP3DwVhxgZpq3kKsfm1A7gFi5H8vQu5kvqTfUDYB42I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul5cKwr9XmZ5yOTADsnnm8OSjtKpJ8ABnffEn0Bb6VyE+F4g0JFtAGa+MNz1xk/gMmII/EEkN64AiOv4n4hVBQz9+iMlccxhp68mgu2h+qsxUUhfk7N0Jffm7rltuiK7LbnW5FlghCRbhGwa04v/fhizQHBo0ifLGxM24hqPv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrY9x+u0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81826d5b72so2305533276.3
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752269924; x=1752874724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh9xFNn0H66v6RtWoNFA7D+7VRZkc3xDgjrXGyw0C3A=;
        b=jrY9x+u0goQtbw3sqJ5C2Z36idOMsqBT5gVNdgSDD7ZaKkNPd3RFmqXpzxQzVQOWwM
         sVXbFjj7ASF+YqUe7lg19tuY9loJMcrQG0CdhDa7igVLW9YLHRvuSAfx01ZnNY+JUApa
         3migWP2Mrx2kB/mTaNJxrXaqIyveeTpXzRK3LYsOFvPoAIcbF5nUYKVzgKmXgDw20xT2
         s2Duqg2ZghviMxvZLwLp8Kkc47P7JzkqZEb0DxKpzrJa0M7jz4ou7l1RkYnuKVWE2JkQ
         Dr3ZEOxRV61kIqOlQjBP8G4H+t9HfMOcCoHNuhChRaDdwvuuhezG6DQ7ILuSyienlSY2
         pNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752269924; x=1752874724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh9xFNn0H66v6RtWoNFA7D+7VRZkc3xDgjrXGyw0C3A=;
        b=WaiqIBDxa/tUKNIaVUC54LB+w48rkwrX8GeOKjjxeHiJMRAfnLDHCt8u/PhmAazc9t
         z2yKPJekltrDu/NAcQaCUWzkEz70ZQhdZ4FI7/N+l7YmiLNvKs+i6ChmfPFPYB+lqS/q
         uWhS7mmhnWFp59qyPajgw8KvuJQLfuT+gDq2iICo/1PxPowZaHwqhbtB1Jbtl17a9n+m
         /oKROYI+yxnrO0iFkReC27ZbAFdtKW5fqUNl+OXrM9jAPgYlmRxedgy03hf2VuNBoC1Y
         f68lH8cDfc1taZ6RdQmmXt0CPlLnVoAumrJWFt8W3Yy1/2HkpArjw7dGXA9obWb3LPkc
         sCUg==
X-Forwarded-Encrypted: i=1; AJvYcCXk7bLYoWIMqtM5m+I764U+PqdO8ztQHlPukrawOWciftaAgspR3Pf/2we9SBWycH3Z2QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPacIdkIR2y6aklC8fZmkOo/eF+6NzwqMNDA5Pdautk4oHa73q
	KkJCeo9uOmBF5GFfny1mXo6IFa/U9LaMhjjT64OiMGmuXiUvzXcXw61z+mBJua0mwymIR+jph7q
	2MIvuP/rWjz/0ez/761s0G0U9VqeWksc=
X-Gm-Gg: ASbGncsLsOKoZr9U/rF18IGL+gMWnUgJRce2lSQthH6VrIMLZaJoejkrFuvIwAX8/XN
	vtADWPdALechIwq09EXrL0zNoEdYUu58NlJUdzMbXoqUnmuShdxfOc4549gcUxqlwjBuxrNmJR3
	N4PhvcJbiPO7lKaU5YWIdjIYLtgS974W90FswKX7iyyWzXZmSyei1EtC36b7bq5YKdQeNmzZ9/E
	FUTLosr8/y6L6RO/Q==
X-Google-Smtp-Source: AGHT+IEwJbINNqAWeOFsHPPJSjazBlmPwKSNEYFEj0Y6QNfGt0svbVPIUWjOiV1iQT/c9rLB3FHivkjSCGigWd28UiE=
X-Received: by 2002:a05:690c:3612:b0:714:5cb:df37 with SMTP id
 00721157ae682-717d5b77c74mr90972237b3.1.1752269923388; Fri, 11 Jul 2025
 14:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230825.4159486-1-ameryhung@gmail.com> <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev> <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev> <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
 <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com>
 <CAMB2axONnVJ5BY-YOASWGUGpaZa-P64Yf5f6AbX+O8fjCiZNfw@mail.gmail.com> <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
In-Reply-To: <CAADnVQJxu5hsDw0iCP68eRW3v2CXRBos8asfN1x9F=gVyGmqbw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Jul 2025 14:38:32 -0700
X-Gm-Features: Ac12FXzCrg-dFfL5aiJ9BU-P9EdCrjYbWPuByiY5jHZcorspM7SDLgoxsdWCpfE
Message-ID: <CAMB2axMw0uEojfdq33KbjqZXAtRSJwR2=f1Y1S4ma01sWJFNfg@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 11, 2025 at 12:29=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Fri, Jul 11, 2025 at 11:41=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jul 10, 2025 at 2:00=E2=80=AFPM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.l=
au@linux.dev> wrote:
> > > > >
> > > > > On 7/10/25 11:39 AM, Amery Hung wrote:
> > > > > >> On 7/8/25 4:08 PM, Amery Hung wrote:
> > > > > >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_el=
em(struct bpf_map *map, void *key,
> > > > > >>>                goto unlock;
> > > > > >>>        }
> > > > > >>>
> > > > > >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> > > > > >> A follow-up on the "using the map->id as the cookie" comment i=
n the cover
> > > > > >> letter. I meant to use the map->id here instead of 0. If the c=
ookie is intended
> > > > > >> to identify a particular struct_ops instance (i.e., the struct=
_ops map), then
> > > > > >> map->id should be a good fit, and it is automatically generate=
d by the kernel
> > > > > >> during the map creation. As a result, I suspect that most of t=
he changes in
> > > > > >> patch 1 and patch 2 will not be needed.
> > > > > >>
> > > > > > Do you mean keep using cookie as the mechanism to associate pro=
grams,
> > > > > > but for struct_ops the cookie will be map->id (i.e.,
> > > > > > bpf_get_attah_cookie() in struct_ops will return map->id)?
> > > > >
> > > > > I meant to use the map->id as the bpf_cookie stored in the bpf_tr=
amp_run_ctx.
> > > > > Then there is no need for user space to generate a unique cookie =
during
> > > > > link_create. The kernel has already generated a unique ID in the =
map->id. The
> > > > > map->id is available during the bpf_struct_ops_map_update_elem().=
 Then there is
> > > > > also no need to distinguish between SEC(".struct_ops") vs
> > > > > SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will not=
 be needed.
> > > > >
> > > > > A minor detail: note that the same struct ops program can be used=
 in different
> > > > > trampolines. Thus, to be specific, the bpf cookie is stored in th=
e trampoline.
> > > > >
> > > > > If the question is about bpf global variable vs bpf cookie, yeah,=
 I think using
> > > > > a bpf global variable should also work. The global variable can b=
e initialized
> > > > > before libbpf's bpf_map__attach_struct_ops(). At that time, the m=
ap->id should
> > > > > be known already. I don't have a strong opinion on reusing the bp=
f cookie in the
> > > > > struct ops trampoline. No one is using it now, so it is available=
 to be used.
> > > > > Exposing BPF_FUNC_get_attach_cookie for struct ops programs is pr=
etty cheap
> > > > > also. Using bpf cookie to allow the struct ops program to tell wh=
ich struct_ops
> > > > > map is calling it seems to fit well also after sleeping on it a b=
it. bpf global
> > > > > variable will also break if a bpf_prog.o has more than one SEC(".=
struct_ops").
> > > > >
> > > >
> > > > While both of them work, using cookie instead of global variable is
> > > > one less thing for the user to take care of (i.e., slightly better
> > > > usability).
> > > >
> > > > With the approach you suggested, to not mix the existing semantics =
of
> > > > bpf cookie, I think a new struct_ops kfuncs is needed to retrieve t=
he
> > >
> > > yes, if absolutely necessary, sure, let's reuse the spot that is
> > > reserved for cookie inside the trampoline, but let's not expose this
> > > as real BPF cookie (i.e., let's not allow bpf_get_attach_cookie()
> > > helper for struct_ops), because BPF cookie is meant to be fully user
> > > controllable and used for whatever they deem necessary. Not
> > > necessarily to just identify the struct_ops map. So it will be a huge
> > > violation to just pre-define what BPF cookie value is for struct_ops.
> > >
> >
> > We had some offline discussions and figured out this will not work well=
.
> >
> > sched_ext users already call scx kfuncs in global subprograms. If we
> > choose to add bpf_get_struct_ops_id() to get the id to be passed to
> > scx kfuncs, it will force the user to create two sets of the same
> > global subprog. The one called by struct_ops that calls
> > bpf_get_struct_ops_id() and tracing programs that calls
> > bpf_get_attach_cookie().
>
> Can we put cookie into map_extra during st_ops map creation time and
> later copy it into actual cookie place in a trampoline?

It should work. Currently, it makes sense to have cookie in struct_ops
map as all struct_ops implementers (hid, tcp cc, qdisc, sched_ext) do
not allow multi-attachment of the same map. A struct_ops map is
effectively an unique attachment for now.

Additionally, we will be able to support cookie for non-link
struct_ops with this way.

This approach will not block future effort to support link-specific
cookie if there is such a use case. We can revisit this patchset then.

