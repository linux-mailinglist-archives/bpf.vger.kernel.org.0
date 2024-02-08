Return-Path: <bpf+bounces-21468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1A84D7A3
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1379A1F26012
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8F14F61;
	Thu,  8 Feb 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S263lr8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69914F68
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356342; cv=none; b=if6sjHs1OVvQFj/NDOTEFutiacsWASa4E0ku74KB4/E09mDnZBNvHbSrCsNoEyOC2ztf6YgLKhRtIN3GqOpCcAmBLmi0pcRC8xVPNXxBjRAHyKJcz3qSGv/PtFa+UCRCAzXlt2Y+EdJZG7aaVVa96KZSefphCFBcbkbloK2b5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356342; c=relaxed/simple;
	bh=gpKjW42Zez0slI/ilDlGMYA59KDAydt62Ks6C+S6Nr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwUYyu+T7JvdkoxBX6OgTAiPJAZELQ5fADhFZm/st3bR6ZZHLm58aYzzXqHH3wtfDluxBtA/so+VVrKE2Qoj6xgVfRAg5P65HvP/IIunN+Qru/1SD6Z3k1CizUtUpf0yYt2JSAIdD3vD/k/dneAfCzsPXoTsEIwAMmQdLdiJ4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S263lr8D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b29b5eab5so791644f8f.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707356339; x=1707961139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRNe6eLajXHp1N0Mii1t1fdlI6+aeE+N8u2+AKrA3oE=;
        b=S263lr8Dt+l+IRzDei83mXLu9+nQ+Fykl8t0Mpev2FjRPOkJ7kG21r4De0ZEXNqgr3
         I4Gm5Wdd9zKPNNr5enfJGM7S2rPLJ324dyI0lCKY4EkjVa31MUO041zLp8A1wqho3sLD
         e3vIJ/O8KfQyhiOR4OgM0kBtI8/lPNQKhGmDbCO/hAgo2Dtbh5dIvM3XYe0CVwY0//Ut
         04gpdaJ6qFZdqeeNds+4o80RGBBDShNecjPWsSQVC0ramp8yVpcWe2gvppYeims5W4lt
         rR6uvAsSL7GaoyX+CHJ3FVvxsFHRGRCU09lvQHfkJf/rxomeUthNdTuMWWYiDjINpJg7
         P5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707356339; x=1707961139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRNe6eLajXHp1N0Mii1t1fdlI6+aeE+N8u2+AKrA3oE=;
        b=EESp3TwIBJJhKcG+mBBILMRquRbkYC+a3y1mt3hnv7tFFYyBtJYRpcBJdWLzd29D9E
         ACF2VcKp8FRZaJ4X1Cx2+ML60q0JlONf5dKj5ieV5ioeFGIIBGM7SRVBkilkgdF7o9SY
         eEnlTp9PxWfKWHPSAogkknTXMBgy5NF2hiSYBScpO05iE5KLZs7nOE3677GwkHtkYyX2
         QSd/T7b7FD+2uQJdD+UX9M2Ch/sGNss0vRMEJP+r5dK2pY+5htmvBpK9vs2aCibznyn6
         HTOwlitdgZhwXFSJgTfSeoISkpgP2jh8hEjXPpxU0ReSidtaKOda17y1J+jC/4c/RNPv
         0Vxg==
X-Gm-Message-State: AOJu0YwWOAaniHhlHHP6HgO12qIejYSUI2d8lbiVpLWTsv7bXZk1LeiO
	K7P15FNEZzHxuwEzOL6qmjxO0/Ev8jpGbskoe8aWyYHtspliQYS6YHR1/NnST3kcQJ2UiWNMGV3
	cL/9Wvs4tpdyuZOqpGHR+nBVlqcc=
X-Google-Smtp-Source: AGHT+IE1Rw86lBFE5/pKKJ7rhpAC/Xy3buk+CBjbX5lPcHqWhld/eQ4pIv4eglnGkwmZTnPT2REo7YK5u9+xvNgCLYA=
X-Received: by 2002:a5d:5964:0:b0:33b:5198:11d9 with SMTP id
 e36-20020a5d5964000000b0033b519811d9mr1377446wri.71.1707356338564; Wed, 07
 Feb 2024 17:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-12-alexei.starovoitov@gmail.com> <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
In-Reply-To: <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 17:38:47 -0800
Message-ID: <CAADnVQKjkba_wiUJ9wps_k8+TYu_q3Ai5oQ1mnZQmpv+pnPfFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > mmap() bpf_arena right after creation, since the kernel needs to
> > remember the address returned from mmap. This is user_vm_start.
> > LLVM will generate bpf_arena_cast_user() instructions where
> > necessary and JIT will add upper 32-bit of user_vm_start
> > to such pointers.
> >
> > Use traditional map->value_size * map->max_entries to calculate mmap sz=
,
> > though it's not the best fit.
>
> We should probably make bpf_map_mmap_sz() aware of specific map type
> and do different calculations based on that. It makes sense to have
> round_up(PAGE_SIZE) for BPF map arena, and use just just value_size or
> max_entries to specify the size (fixing the other to be zero).

I went with value_size =3D=3D key_size =3D=3D 8 in order to be able to exte=
nd
it in the future and allow map_lookup/update/delete to do something
useful. Ex: lookup/delete can behave just like arena_alloc/free_pages.

Are you proposing to force key/value_size to zero ?
That was my first attempt.
key_size can be zero, but syscall side of lookup/update expects
a non-zero value_size for all maps regardless of type.
We can modify bpf/syscall.c, of course, but it feels arena would be
too different of a map if generic map handling code would need
to be specialized.

Then since value_size is > 0 then what sizes make sense?
When it's 8 it can be an indirection to anything.
key/value would be user pointers to other structs that
would be meaningful for an arena.
Right now it costs nothing to force both to 8 and pick any logic
when we decide what lookup/update should do.

But then when value_size =3D=3D 8 than making max_entries to
mean the size of arena in bytes or pages.. starting to look odd
and different from all other maps.

We could go with max_entries=3D=3D0 and value_size to mean the size of
arena in bytes, but it will prevent us from defining lookup/update
in the future, which doesn't feel right.

Considering all this I went with map->value_size * map->max_entries choice.
Though it's not pretty.

> > @@ -4908,6 +4910,22 @@ static int bpf_object__create_map(struct bpf_obj=
ect *obj, struct bpf_map *map, b
> >         if (map->fd =3D=3D map_fd)
> >                 return 0;
> >
> > +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> > +               size_t mmap_sz;
> > +
> > +               mmap_sz =3D bpf_map_mmap_sz(def->value_size, def->max_e=
ntries);
> > +               map->mmaped =3D mmap((void *)map->map_extra, mmap_sz, P=
ROT_READ | PROT_WRITE,
> > +                                  map->map_extra ? MAP_SHARED | MAP_FI=
XED : MAP_SHARED,
> > +                                  map_fd, 0);
> > +               if (map->mmaped =3D=3D MAP_FAILED) {
> > +                       err =3D -errno;
> > +                       map->mmaped =3D NULL;
> > +                       pr_warn("map '%s': failed to mmap bpf_arena: %d=
\n",
> > +                               bpf_map__name(map), err);
> > +                       return err;
>
> leaking map_fd here, you need to close(map_fd) before erroring out

ahh. good catch.

