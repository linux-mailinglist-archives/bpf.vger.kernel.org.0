Return-Path: <bpf+bounces-70849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20168BD6D65
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A059942198A
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971C3D3B3;
	Tue, 14 Oct 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMsClh19"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364743398A
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400644; cv=none; b=fYlBg9iW8AGbMFXcHNK65n55oRb9yZe1HRCYgkHaatnh1qvcLK3PLdRQXeNHowrL9YUp0G3yh0SuW8tQYheuVubh6XRr7SZEg03AvauFDwfzZS8/NX/8BjhuWjfgwBKiZPghZMY8/2DN86UT8CoFMCQqx8k7wsl0RN7APDEcz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400644; c=relaxed/simple;
	bh=zKQXpWSM/9juP+o/FRcoKuWdqiWCx/NaLVc0YDlhAdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMpdy8aUqX+TXNLMfs1Ugjff28zhMxk/+HNWdUPqlTEKmtUmbbe7eNoafFtamW1zlQM7sjO+S9a/4+AW/GIRe9d3D/s6y73RGa+BvzohX8TPtL1CYRopeEn6kE78i9ty7L/zaw8EN3GiRv+Zq00jB1fw6/R9irqvyCTFUNQX0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMsClh19; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso6177433a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400642; x=1761005442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbI7VdlcoLK5j++SIdQul9mBT5JZEkngCuUhU52TEAs=;
        b=EMsClh19yeVviBLY2hyO0+c10KbxHxM+5NUv2rW0D8q37jXf/X0EYX+4BkndiktSv2
         1vrSggpwsQ4FOkOTPWeba3kMPew+oX9fzCgcVseXU8WAljZzgf9Joj/OzclZacT5zn3T
         nzVuHbkccr0BgKtETJxRX+7RVby9AEwQDh4F9NoqNGdU5DoVwIRX3Qa3+IB6Xgul6F0N
         Ht0mfIBNnhNmEgAQx48h5c3zemFDsd0LKyLmO61ROLkPqtFF5PM/bbwQ0LPbUThNYj01
         HwGJLGw+p3muzb7e6Op5kV9rcLS39RYP1kMb38FntatJU/wR62cUJHKTgE7sTfB0Ru8F
         hDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400642; x=1761005442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbI7VdlcoLK5j++SIdQul9mBT5JZEkngCuUhU52TEAs=;
        b=cezXofcugDwL7VjER3+HxylGMGOCDyOaEk0dVntdbpb3MIbLd07m1uDEvLziFIJkUk
         Y+m1BM/3b7LRJWlKmyIP5er1KPTQJ3dHF7sAy1ydDvdafBoiddmwth0Lte9xx1MosGuc
         bNAUdRZuYrrspxZbMni6ViYxcK7dN3ZknNfRvIT/laoyrkE4AtzXMzAzlftplvje24xC
         EmkolItO8w4HXB3oqOooUM4kcKtkmY+fCorXaD9AX4G8YWa1HC2Q0MftkYlVcae6a32l
         X/YGPvXvAOi3XKy85HGbi/d7AfnD0AG+lxxffr8cXkG45YDRlqkA41VoRiJhkE/dN39+
         Wm+w==
X-Gm-Message-State: AOJu0YzZE4+orcZcvJOwYfPE4BYq1+gLFlBvyIsPib6LQ/kJBFz1+bf6
	0pipunRHgjtrsH1EftFfkLXAxjUBfKPkJBZvUCz1L7H+qcZjPm+fRPNQ5RL9GjZn+3xeDN36LpD
	s/y3juMg8ylTQ14tYt2HrY/dq/r8hnuw=
X-Gm-Gg: ASbGncsdUwSRGsjuMGTBdafYdikBfYrrQ9iqR3h8Y1jrUHKEdE9DpBrS4KA2u82PoG8
	D66+LSEFroQ/UbohqVU3U53FfQyue3p5Nnw0Eoflw4BT+GXls8/BekGsv9CB49V3QplG4IxeRt0
	SmfWQbxuy2+aJEtuj+xDkMqDAVk/xJVWJVak/LuIK2PDkdnFkVrqBHzQDl/CpmGvStOHkCfDtfm
	yOpQpSL8Whr8letrohL4QVR9v+nh8jNw0BLFeFnxrWl+ncwlPCM
X-Google-Smtp-Source: AGHT+IHbu1GM2aDcBiqmQoDs8+SoFkL8t2HF1enBCIjOCS29d6T2ouFBevmexYyoaIdhDi6zdfit7i+cqR5nm8vF60g=
X-Received: by 2002:a17:90b:4984:b0:32b:94a2:b0c4 with SMTP id
 98e67ed59e1d1-339edac69f1mr36300886a91.16.1760400642466; Mon, 13 Oct 2025
 17:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-3-ameryhung@gmail.com>
In-Reply-To: <20251010174953.2884682-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:10:26 -0700
X-Gm-Features: AS18NWAseG-_S7Q3MH24JafLagyXqAj7vn3v4db_S9XBFH0PhSieYJiEz4HGwPI
Message-ID: <CAEf4BzZgc3tqzDER5HN1Jz7JL7nN3K6MiFGTrouE69Pm-Vo+8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Add a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to allow associating
> a BPF program with a struct_ops. This command takes a file descriptor of
> a struct_ops map and a BPF program and set prog->aux->st_ops_assoc to
> the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program or a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, the first one will be the map associated with the program. The
> associated struct_ops map, once set cannot be changed later. This
> restriction may be lifted in the future if there is a use case.
>
> Each associated programs except struct_ops programs of the map will take
> a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set,
> is always valid. However, it is not guaranteed whether the map members
> are fully updated nor is it attached or not. For example, a BPF program
> can be associated with a struct_ops map before map_update. The
> struct_ops implementer will be responsible for maintaining and checking
> the state of the associated struct_ops map before accessing it.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 11 ++++++++++
>  include/uapi/linux/bpf.h       | 16 ++++++++++++++
>  kernel/bpf/bpf_struct_ops.c    | 32 ++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  6 ++++++
>  kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
>  6 files changed, 119 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a98c83346134..d5052745ffc6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
>                 struct rcu_head rcu;
>         };
>         struct bpf_stream stream[2];
> +       struct mutex st_ops_assoc_mutex;

do we need a mutex at all? cmpxchg() should work just fine. We'll also
potentially need to access st_ops_assoc from kprobes/fentry anyways,
and we can't just take mutex there

> +       void *st_ops_assoc;
>  };
>
>  struct bpf_prog {

[...]

>
> @@ -1890,6 +1901,11 @@ union bpf_attr {
>                 __u32           prog_fd;
>         } prog_stream_read;
>
> +       struct {
> +               __u32           map_fd;
> +               __u32           prog_fd;

let's add flags, we normally have some sort of flags for commands for
extensibility

> +       } struct_ops_assoc_prog;
> +
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index a41e6730edcf..e57428e1653b 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_s=
truct_ops_map *st_map)
>         for (i =3D 0; i < st_map->funcs_cnt; i++) {
>                 if (!st_map->links[i])
>                         break;
> +               bpf_struct_ops_disassoc_prog(st_map->links[i]->prog);
>                 bpf_link_put(st_map->links[i]);
>                 st_map->links[i] =3D NULL;
>         }
> @@ -801,6 +802,11 @@ static long bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
>                         goto reset_unlock;
>                 }
>
> +               /* Don't stop a program from being reused. prog->aux->st_=
ops_assoc

nit: comment style, we are converging onto /* on separate line

> +                * will point to the first struct_ops kdata.
> +                */
> +               bpf_struct_ops_assoc_prog(&st_map->map, prog);

ignoring error? we should do something better here... poisoning this
association altogether if program is used in multiple struct_ops seems
like the only thing we can reasonable do, no?

> +
>                 link =3D kzalloc(sizeof(*link), GFP_USER);
>                 if (!link) {
>                         bpf_prog_put(prog);

[...]

>
> +#define BPF_STRUCT_OPS_ASSOCIATE_PROG_LAST_FIELD struct_ops_assoc_prog.p=
rog_fd
> +

looking at libbpf side, it's quite a mouthful to write out
bpf_struct_ops_associate_prog()... maybe let's shorten this to
BPF_STRUCT_OPS_ASSOC or BPF_ASSOC_STRUCT_OPS (with the idea that we
associate struct_ops with a program). The latter is actually a bit
more preferable, because then we can have a meaningful high-level
bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map
*map), where map has to be struct_ops. Having bpf_map__assoc_prog() is
a bit too generic, as this works only for struct_ops maps.

It's all not major, but I think that lends for a bit better naming and
more logical usage throughout.

> +static int struct_ops_assoc_prog(union bpf_attr *attr)
> +{
> +       struct bpf_prog *prog;
> +       struct bpf_map *map;
> +       int ret;
> +
> +       if (CHECK_ATTR(BPF_STRUCT_OPS_ASSOCIATE_PROG))
> +               return -EINVAL;
> +
> +       prog =3D bpf_prog_get(attr->struct_ops_assoc_prog.prog_fd);
> +       if (IS_ERR(prog))
> +               return PTR_ERR(prog);
> +
> +       map =3D bpf_map_get(attr->struct_ops_assoc_prog.map_fd);
> +       if (IS_ERR(map)) {
> +               ret =3D PTR_ERR(map);
> +               goto out;
> +       }
> +
> +       if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> +           prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {

you can check prog->type earlier, before getting map itself

> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D bpf_struct_ops_assoc_prog(map, prog);
> +out:
> +       if (ret && !IS_ERR(map))

nit: purely stylistic preference, but I'd rather have a clear
error-only clean up path, and success with explicit return 0, instead
of checking ret or IS_ERR(map)

    ...

    /* goto to put_{map,prog}, depending on how far we've got */

    err =3D bpf_struct_ops_assoc_prog(map, prog);
    if (err)
        goto put_map;

    return 0;

put_map:
    bpf_map_put(map);
put_prog:
    bpf_prog_put(prog);
    return err;


> +               bpf_map_put(map);
> +       bpf_prog_put(prog);
> +       return ret;
> +}
> +

[...]

