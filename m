Return-Path: <bpf+bounces-21520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A484E7AD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109401F2BE99
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113F86133;
	Thu,  8 Feb 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKZSWXji"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710086129
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416988; cv=none; b=CivPY1ByWTQQ6nS1tS5QXvatg3kzQMLl5+jaM4+RNvFyaE+0xH2tdXXhshQAM0krm/z1d5NndgywiTPsPyVjvarev+5kK9p0zVckow//Bb2tUsibDXg49MIpKa2zjzpsHKbuGL6S/nHIdrdkyX7I36uYTnB4d5GpabKNhyj6WZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416988; c=relaxed/simple;
	bh=P0gu5gRh5tlFcfY+kY5Qd7jgeCkXDHeQ8UAf2WK1Rz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKfMv9inAITi6ex9tYlcEQSRm1QBh+MCmm6OLUm/ZyQR73pHF9O/I/klX46GOwaChHQ5CeTqfkDXdp/Xz2rKgx00AFXF51IbQbERTcO7ZNRiZ1+a6UtzpZViiMVmehEQ/l/X4X5CBk9oVGT2r0lF6aEnvT5M6WalUaiCfehwRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKZSWXji; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-296a02b7104so97546a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707416986; x=1708021786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yiy2726XY6zxZ3MywguUuT6LWPXhrHbitdbUp49Tq/4=;
        b=nKZSWXjiwGkh5B+MiXZs2sua/fcvx77RW62MPMxi/A1MvTR7u93nnlC9lgyA1u8w8x
         9VAm9LvH7VxaH8ZmDLtRnMn3ohl5IC7pZO9FVAtsJqb0hTIGRIA7F2u4D4OUBjbePSJO
         hbC3FtjHd7Hy8OUcq34M37r/d/t9kRhbiWbRBX1eqGMXT4ZtGJy9VMpLRkmerKCDwqeK
         vN4cF7dV3QEmSRJj/AIvidCV5cg2Dvty/yWc7QH/yOya1ebkKqWA3S9kgfMOIdoYn6np
         vm72Yw15K6oRngeyFa/sFPvcMVm1IdDo0E3/ZSbWUgSir0DrkoB+QUL3FKieIZYfEgH3
         dqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416986; x=1708021786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yiy2726XY6zxZ3MywguUuT6LWPXhrHbitdbUp49Tq/4=;
        b=FajF42cbw+N/N8s2/XQ5LceWF0eNSn7ibMX2IT0exEgC3zFIfeZo5OfE0+Lalk9x3U
         ek54ybLbifBbF8gk+9dSqWpBZkuOZnjtDHkHEjtCNZArySMjjVq+ML7HmDLcPJbr3y+Y
         nhQ3nfQeAOUYmKoNxAi8S9z7h/JawLPXDuSaulcLz+BDeErhhMkJwQ2+CKlYjsJQCW2p
         cFLOutK/8MXjo67z2dLiJiRaAXy7vyEgIbzBTcQSjPTcnhoARzAy6TxoGYFcP3j/P9aj
         p9RzHv8DEHASkN7ok6XLzUp9BqNCa3h/kF38JC956XpeS16j99pAwBXdIq+EBXgZVlQb
         BtUA==
X-Gm-Message-State: AOJu0YzUoxqAvMUah1vslVItCz5zHQPoWHnOO+h1vRJorx1DhmD/zmGl
	9DpOl3fAPkhYu9A0oNWuXrYUf5Yz5B1SfSE3nGmKr0Uw7PDHxnufPQ8K2Iof1r43uJ9ZbfW+v+D
	2hpfAYLfLQ9Bzpa6IcUJJA8jtv1Y=
X-Google-Smtp-Source: AGHT+IGSxuSi3Hxfhlfc15XElQTc98pCE+ECL/SI36tLlqv4n4K+6Jzk4NXQC2Se99qz+oxjY+aI5NTOf4AKtMQsd/0=
X-Received: by 2002:a17:90b:1012:b0:296:f417:4b79 with SMTP id
 gm18-20020a17090b101200b00296f4174b79mr99800pjb.11.1707416986028; Thu, 08 Feb
 2024 10:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-12-alexei.starovoitov@gmail.com> <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
 <CAADnVQKjkba_wiUJ9wps_k8+TYu_q3Ai5oQ1mnZQmpv+pnPfFw@mail.gmail.com>
In-Reply-To: <CAADnVQKjkba_wiUJ9wps_k8+TYu_q3Ai5oQ1mnZQmpv+pnPfFw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 10:29:34 -0800
Message-ID: <CAEf4BzYvgHoBQ0KNFOWoK8XOvRTzGNBM1QsS=zR5iPTq-Z+=4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 7, 2024 at 5:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > mmap() bpf_arena right after creation, since the kernel needs to
> > > remember the address returned from mmap. This is user_vm_start.
> > > LLVM will generate bpf_arena_cast_user() instructions where
> > > necessary and JIT will add upper 32-bit of user_vm_start
> > > to such pointers.
> > >
> > > Use traditional map->value_size * map->max_entries to calculate mmap =
sz,
> > > though it's not the best fit.
> >
> > We should probably make bpf_map_mmap_sz() aware of specific map type
> > and do different calculations based on that. It makes sense to have
> > round_up(PAGE_SIZE) for BPF map arena, and use just just value_size or
> > max_entries to specify the size (fixing the other to be zero).
>
> I went with value_size =3D=3D key_size =3D=3D 8 in order to be able to ex=
tend
> it in the future and allow map_lookup/update/delete to do something
> useful. Ex: lookup/delete can behave just like arena_alloc/free_pages.
>
> Are you proposing to force key/value_size to zero ?

Yeah, I was thinking either (value_size=3D<size-in-bytes> and
max_entries=3D0) or (value_size=3D0 and max_entries=3D<size-in-bytes>). The
latter is what we do for BPF ringbuf, for example.

What you are saying about lookup/update already seems different from
any "normal" map anyways, so I'm not sure that's a good enough reason
to have hard-coded 8 for value size. And it seems like in practice
instead of doing lookup/update through syscall, the more natural way
of working with arena is going to be mmap() anyways, so not even sure
we need to implement the syscall side of lookup/update.

But just as an extra aside, what you have in mind for lookup/update
for the arena map can be generalized into "partial lookup/update" for
any map where it makes sense. I.e., instead of expecting the user to
read/update the entire value size, we can allow them to provide a
subrange to read/update (i.e., offset+size combo to specify subrange
within full map value range). This will work for the arena, but also
for most other maps (if not all) that currently support LOOKUP/UPDATE.

but specifically for bpf_map_mmap_sz(), regardless of what we decide
we should still change it to be something like:

switch (map_type) {
case BPF_MAP_TYPE_ARRAY:
    return <whatever we are doing right now>;
case BPF_MAP_TYPE_ARENA:
    /* round up to page size */
    return round_up(<whatever based on value_size and/or max_entries>,
page_size);
default:
    return 0; /* not supported */
}

we can also add a still different case for RINGBUF, where it's (2 *
max_entries). The general point is that mmapable size rules differ by
map type, so we best express this explicitly in this helper.


> That was my first attempt.
> key_size can be zero, but syscall side of lookup/update expects
> a non-zero value_size for all maps regardless of type.
> We can modify bpf/syscall.c, of course, but it feels arena would be
> too different of a map if generic map handling code would need
> to be specialized.
>
> Then since value_size is > 0 then what sizes make sense?
> When it's 8 it can be an indirection to anything.
> key/value would be user pointers to other structs that
> would be meaningful for an arena.
> Right now it costs nothing to force both to 8 and pick any logic
> when we decide what lookup/update should do.
>
> But then when value_size =3D=3D 8 than making max_entries to
> mean the size of arena in bytes or pages.. starting to look odd
> and different from all other maps.
>
> We could go with max_entries=3D=3D0 and value_size to mean the size of
> arena in bytes, but it will prevent us from defining lookup/update
> in the future, which doesn't feel right.
>
> Considering all this I went with map->value_size * map->max_entries choic=
e.
> Though it's not pretty.
>
> > > @@ -4908,6 +4910,22 @@ static int bpf_object__create_map(struct bpf_o=
bject *obj, struct bpf_map *map, b
> > >         if (map->fd =3D=3D map_fd)
> > >                 return 0;
> > >
> > > +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> > > +               size_t mmap_sz;
> > > +
> > > +               mmap_sz =3D bpf_map_mmap_sz(def->value_size, def->max=
_entries);
> > > +               map->mmaped =3D mmap((void *)map->map_extra, mmap_sz,=
 PROT_READ | PROT_WRITE,
> > > +                                  map->map_extra ? MAP_SHARED | MAP_=
FIXED : MAP_SHARED,
> > > +                                  map_fd, 0);
> > > +               if (map->mmaped =3D=3D MAP_FAILED) {
> > > +                       err =3D -errno;
> > > +                       map->mmaped =3D NULL;
> > > +                       pr_warn("map '%s': failed to mmap bpf_arena: =
%d\n",
> > > +                               bpf_map__name(map), err);
> > > +                       return err;
> >
> > leaking map_fd here, you need to close(map_fd) before erroring out
>
> ahh. good catch.

