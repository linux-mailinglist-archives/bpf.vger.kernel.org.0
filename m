Return-Path: <bpf+bounces-71063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D7BE0F43
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109EA1A24A0A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0C30EF75;
	Wed, 15 Oct 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwNP+xh7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC430E0EC
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567718; cv=none; b=lrXokfew6cQzvbQ0MgAVhJVEfyWwmZ5DHJGGRho6LrVlr9a0G1OSAEr1vmrpdzIGg4MKPr+G1wfmlBt6/ZQSPzOhSpICBy6juLqA5hQGo32iYZM9zRY+mjVSmFbyX3UtJopHteAjKk2+XP1xvyjKcbMhkK8qOVHhsMg+Qyk6BU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567718; c=relaxed/simple;
	bh=I+EPs1nM/tFurseNY9griVIUH2B3KLQYSeKxn+jFCAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD2BX36aEwwkOU4/emBDN2O2QvB3+Fby3PgU2Ys/yq8kK2bMRtqhZgF1vkwhEdyCFZg8F4mkWBFmkS7t0JBr2XVYQ8Us41f8zl3F+sYpOHTa+AANcPGJJo5L0QQ5/gvR0zOwYooxLluFy6259aa1CkHGrWOJCVzyW6mD4kZFjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwNP+xh7; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63d0692136bso143298d50.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760567716; x=1761172516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LQnHep4LQvoskqdWTslmBQiP/xWAT4BZwA6p78xI1o=;
        b=mwNP+xh7sL7XjZs0lYResLXsm+gPsOI7jr4L0YiTfCR6R3sXRvWm84tJbVg7UwmXMi
         fLa5UnsQ+V0dADmGRGzdoPazG4Zt4ZZ5eOh/iIP7KxD6V5RdGcbXkwao0KQEpcdxqgAF
         J5m6oKG94J8KR5e5A3bzT3SB783HWGa549bB4I/BP5h4PdniishMAmb5PIYUDACdEckI
         3m++hMJNG2c7tYKW4wemQFKCo7oI6V/79U6iFMIZhUSAgQzUR9/YxeM40GdujiV4frkF
         xhg7ZzexxNGHDkqh6aTN4d9iIKO95z+qRmczvG2XAKpqZTbJnLiPDL8WTB6w7hwuNUYo
         6i7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567716; x=1761172516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LQnHep4LQvoskqdWTslmBQiP/xWAT4BZwA6p78xI1o=;
        b=PDhPQ67LaF3a/QxVPT1c+m+cxVz1mYAOYyq7eR/l4CF4NkTiv1D78ImjCSV8DHFSfV
         s29ufzFDAqJEHGOJlUeSgtCwnYkqx2ogTJldB9TpeG1FJA6x3hVcfkK8WF1Q3d2zClwV
         obcGMUbaG47Ra/NMpablypSG4v7vIB934IZPbNVMTFTZfF6Cc4i0rUEpk+7QyxjRT3vu
         3VVWoXpMX3TOTGpfblNKWYtiCq35FV1AgO/2gzrSWLwqXgtKR3+AASGUopAl1PziHf4h
         +JfLVs7T3hfa/2Ly17+7oYlXJUJEnosZERDcA19SB0/ehcUqav0k2KT+TAlRg8WnLk/J
         VhNA==
X-Gm-Message-State: AOJu0YxME+/yljlsyd5BIbiqcDKC+KH+K/xMcjDxG0CqleQ5T2xAjxjt
	6inwgBx9dX1+NgNbz+9cGA+4uGDLQGGLV+VzmIKkE0sF1i2Ta4vnBgUakDraKqJ22g7kNFXdGWw
	FtiAs29b/SxTVLCaPfV9fX3E25/mpmG4=
X-Gm-Gg: ASbGncuZoi3u8rlziAApDLWsf7kg9QXksAxN4NWMG37xFXxXD7gJGTrbyeSaBqlYPNq
	NsqB1iqp7tUW6EkFLcOJxDBQNmXp8K+waVI1qlRFq/O7w7II7KJELxAJBeCPs5mcDYw9uqJBduo
	8fxAMcZvYD4q5TU0YcmoKz+P/1V1UdfwKq0rzTwFiZ5vo9oVZhtofxGI35L3/5XBFo290GfgYUx
	QmtmRmySQuhlXv/W39yi8l0LYAVvPXccpFAv5ojhwr1XbKr4FcGilyyvplatOXhH3MNiMUjp59A
	o871i50ECrbFxy3bYiXzEA==
X-Google-Smtp-Source: AGHT+IFOQFXA5WS6kJb7R8PciG7Flr1IdKR0ejCDXi3YmX/ajBlJq3wP/cx4AN7yacF3lIzA8kYFXwzNV3NkgXZj548=
X-Received: by 2002:a05:690e:164f:b0:63c:db25:6406 with SMTP id
 956f58d0204a3-63cdb2584d8mr14713560d50.42.1760567715523; Wed, 15 Oct 2025
 15:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-3-ameryhung@gmail.com>
 <CAEf4BzZgc3tqzDER5HN1Jz7JL7nN3K6MiFGTrouE69Pm-Vo+8Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZgc3tqzDER5HN1Jz7JL7nN3K6MiFGTrouE69Pm-Vo+8Q@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 15 Oct 2025 15:35:02 -0700
X-Gm-Features: AS18NWCwVgjeseYjnxu1eHsbaNGrQXqF4YKiOEnVMz4OGpzYFREj857hyRRBcwE
Message-ID: <CAMB2axN7o0pHca_u2HnbMb+pEOJubRR8Y8JewExzwxaRWtKUmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > Add a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to allow associatin=
g
> > a BPF program with a struct_ops. This command takes a file descriptor o=
f
> > a struct_ops map and a BPF program and set prog->aux->st_ops_assoc to
> > the kdata of the struct_ops map.
> >
> > The command does not accept a struct_ops program or a non-struct_ops
> > map. Programs of a struct_ops map is automatically associated with the
> > map during map update. If a program is shared between two struct_ops
> > maps, the first one will be the map associated with the program. The
> > associated struct_ops map, once set cannot be changed later. This
> > restriction may be lifted in the future if there is a use case.
> >
> > Each associated programs except struct_ops programs of the map will tak=
e
> > a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set=
,
> > is always valid. However, it is not guaranteed whether the map members
> > are fully updated nor is it attached or not. For example, a BPF program
> > can be associated with a struct_ops map before map_update. The
> > struct_ops implementer will be responsible for maintaining and checking
> > the state of the associated struct_ops map before accessing it.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf.h            | 11 ++++++++++
> >  include/uapi/linux/bpf.h       | 16 ++++++++++++++
> >  kernel/bpf/bpf_struct_ops.c    | 32 ++++++++++++++++++++++++++++
> >  kernel/bpf/core.c              |  6 ++++++
> >  kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
> >  6 files changed, 119 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a98c83346134..d5052745ffc6 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
> >                 struct rcu_head rcu;
> >         };
> >         struct bpf_stream stream[2];
> > +       struct mutex st_ops_assoc_mutex;
>
> do we need a mutex at all? cmpxchg() should work just fine. We'll also
> potentially need to access st_ops_assoc from kprobes/fentry anyways,
> and we can't just take mutex there
>
> > +       void *st_ops_assoc;
> >  };
> >
> >  struct bpf_prog {
>
> [...]
>
> >
> > @@ -1890,6 +1901,11 @@ union bpf_attr {
> >                 __u32           prog_fd;
> >         } prog_stream_read;
> >
> > +       struct {
> > +               __u32           map_fd;
> > +               __u32           prog_fd;
>
> let's add flags, we normally have some sort of flags for commands for
> extensibility

I will add a flag

>
> > +       } struct_ops_assoc_prog;
> > +
> >  } __attribute__((aligned(8)));
> >
> >  /* The description below is an attempt at providing documentation to e=
BPF
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index a41e6730edcf..e57428e1653b 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf=
_struct_ops_map *st_map)
> >         for (i =3D 0; i < st_map->funcs_cnt; i++) {
> >                 if (!st_map->links[i])
> >                         break;
> > +               bpf_struct_ops_disassoc_prog(st_map->links[i]->prog);
> >                 bpf_link_put(st_map->links[i]);
> >                 st_map->links[i] =3D NULL;
> >         }
> > @@ -801,6 +802,11 @@ static long bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> >                         goto reset_unlock;
> >                 }
> >
> > +               /* Don't stop a program from being reused. prog->aux->s=
t_ops_assoc
>
> nit: comment style, we are converging onto /* on separate line

Got it, so I assume it applies to kerne/bpf/* even existing comments
in the file are netdev style. Is it also the case for
net/core/filter.c?


>
> > +                * will point to the first struct_ops kdata.
> > +                */
> > +               bpf_struct_ops_assoc_prog(&st_map->map, prog);
>
> ignoring error? we should do something better here... poisoning this
> association altogether if program is used in multiple struct_ops seems
> like the only thing we can reasonable do, no?
>
> > +
> >                 link =3D kzalloc(sizeof(*link), GFP_USER);
> >                 if (!link) {
> >                         bpf_prog_put(prog);
>
> [...]
>
> >
> > +#define BPF_STRUCT_OPS_ASSOCIATE_PROG_LAST_FIELD struct_ops_assoc_prog=
.prog_fd
> > +
>
> looking at libbpf side, it's quite a mouthful to write out
> bpf_struct_ops_associate_prog()... maybe let's shorten this to
> BPF_STRUCT_OPS_ASSOC or BPF_ASSOC_STRUCT_OPS (with the idea that we
> associate struct_ops with a program). The latter is actually a bit
> more preferable, because then we can have a meaningful high-level
> bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map
> *map), where map has to be struct_ops. Having bpf_map__assoc_prog() is
> a bit too generic, as this works only for struct_ops maps.
>
> It's all not major, but I think that lends for a bit better naming and
> more logical usage throughout.

Will change the naming.

>
> > +static int struct_ops_assoc_prog(union bpf_attr *attr)
> > +{
> > +       struct bpf_prog *prog;
> > +       struct bpf_map *map;
> > +       int ret;
> > +
> > +       if (CHECK_ATTR(BPF_STRUCT_OPS_ASSOCIATE_PROG))
> > +               return -EINVAL;
> > +
> > +       prog =3D bpf_prog_get(attr->struct_ops_assoc_prog.prog_fd);
> > +       if (IS_ERR(prog))
> > +               return PTR_ERR(prog);
> > +
> > +       map =3D bpf_map_get(attr->struct_ops_assoc_prog.map_fd);
> > +       if (IS_ERR(map)) {
> > +               ret =3D PTR_ERR(map);
> > +               goto out;
> > +       }
> > +
> > +       if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> > +           prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
>
> you can check prog->type earlier, before getting map itself

Got it. I will make it a separate check right after getting prog.

>
> > +               ret =3D -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       ret =3D bpf_struct_ops_assoc_prog(map, prog);
> > +out:
> > +       if (ret && !IS_ERR(map))
>
> nit: purely stylistic preference, but I'd rather have a clear
> error-only clean up path, and success with explicit return 0, instead
> of checking ret or IS_ERR(map)
>
>     ...
>
>     /* goto to put_{map,prog}, depending on how far we've got */
>
>     err =3D bpf_struct_ops_assoc_prog(map, prog);
>     if (err)
>         goto put_map;
>
>     return 0;
>
> put_map:
>     bpf_map_put(map);
> put_prog:
>     bpf_prog_put(prog);
>     return err;

I will separate error path out.

>
>
> > +               bpf_map_put(map);
> > +       bpf_prog_put(prog);
> > +       return ret;
> > +}
> > +
>
> [...]

