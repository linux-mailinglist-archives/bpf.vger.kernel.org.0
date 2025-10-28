Return-Path: <bpf+bounces-72592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD697C15F96
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E30D355DF7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14676347BD7;
	Tue, 28 Oct 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax+uLPLK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DB316188
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670423; cv=none; b=NlhdgrxRa2TcI+kN30MATTh8CC8d1S91sogClL8j4YZuvqzT2CYBJBqhl259qitB8nvBP+UwsHbiHhyoaJVzh1THJsj3jdwY7wmSVuSgWXsligmFqsEE0vFgePTtIXQ/AzZBAlEkG3LL1Gtu7CRaSknH8bL9DPl3p+O7rATZ2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670423; c=relaxed/simple;
	bh=a+BVvzrwV1CHGlTlYUIJV+7YjR6u7eO+a8yqU1J8ytU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+NSWvpL/81BWdvpO9rtp9NDg+Cu/aXvuIpfa0v+tHY4D7aoB8V8qaR80FRzVS8+yyai3lZ4cZV7b2O4BoyVLwT6sxHJpfYAoXqYQPrUr6K2I/YAec0IOXD6JGBY5+V02ecGWWUB/qmspTD60JzapQBCPoAc5wo1+mgMhvniKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax+uLPLK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290ac2ef203so59524595ad.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670421; x=1762275221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itpY6fWxqeX4M4304ZwecURirqEEYOU47REyVN9009E=;
        b=Ax+uLPLK61NZisKuYv+/g3hFbV1vju1oaV8dve6Cjtq1lbFbqKs5TGNzykiUdmVB0T
         PTRY6J7n6YLeLw6dAasizxQhWfPQHMhFnsNtmKeBXDTY4yC/57bK4n0ShSwWpgI6Lc2t
         ooTDpUKsFs3izuAq90wKET8lFpDFhYnhlIpaanHp/67tdJydpB7e1g7bwPLQKzlZbHTT
         0tmEi37bfdvez7SGKcLX6veFci6q7/Rt71Dz4Yq6MSWzsoP5KHXh8KVC4vM0iBTOGrR4
         bYlY14M9skVjkdWWuYjSLEKLlZNel8EzEvJG0mxABHWngZ0wCxbDO0NeP9OdH72+mB0F
         qdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670421; x=1762275221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itpY6fWxqeX4M4304ZwecURirqEEYOU47REyVN9009E=;
        b=B6hkz/H1F2SRoLHMYuk/NW4Dox6bxPpwP0p+zRYEmPTl+zqnM1Rq9PnPY3gA7Of1BW
         f8+yLDj55+R/7y3KGOuCRmfkaEjFTWNbbkJveCetLOyGScI88Pwglrj7Bsw6ziH10uMa
         ovnKPmIZZStOTZhi+M7D0x1x3qo5XKQGXZZ7ud+C7HneRFfmJ0RdU9k9WKDLySzCwTgU
         SGft/JIy0ZuFUsuaulYjPFj6P34bOboMx+cxukPoARIMnhp8NX2eJIatI6ErfN7ZLZUh
         q2GK9CLKJCEZYDsTmUcxN+aAs3UTQE8/KZQEcqBd4wBgmxjlnWZBkX/gcX58tVYsUvrm
         vtHA==
X-Gm-Message-State: AOJu0YyvmgX3zDOzLDsgtLyki64+gcojt2IkPCiJW+ts6AyfqsaaDwIZ
	OU7PFieiOyk+ppgPWicqFWNZFJ6Al0zsLDDRDf0d5vcJVnNtT7kzb7FDBPN/5vL3i4HBz5aP0fF
	zOZlmi67dZ9/k7e28pAsBTjbTVqlfpSI=
X-Gm-Gg: ASbGncu2vskA4OxyvryawhTm5i1exLyVWxRWAn7oHmXOQWAyAnxeTkUTfJD25dbDmkL
	mhvRTxHpnTWqftWUWx22mWt+lxSm5VjibFDHG1XOEQ9p7V2psrpB91m/TZpXll213274sIsvUmq
	Am/gJnMcIATRHSkWCbQSZTH1uc2jq7l8lDpYZ7RpkPy8/VGYEYaOnjaVZK/0Hi6XghkFQdRupmX
	ELHA/TwruZohyXg53lIfa5ptwgOWzZnOLjThGp9mUQY/1ZlqedaytFGU9anMY0aL1PvPImoVt7P
X-Google-Smtp-Source: AGHT+IFZEuiAxXllEb5ThZ9cDzWH7QzvhaLhrFTs/VyutI0B0iRzuC0dIO1ADn/bUPkm6lWvMXjk8vR+ST2dStv0xes=
X-Received: by 2002:a17:903:228c:b0:290:ad79:c613 with SMTP id
 d9443c01a7336-294cb536f8dmr48858475ad.47.1761670421153; Tue, 28 Oct 2025
 09:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024212914.1474337-1-ameryhung@gmail.com> <20251024212914.1474337-3-ameryhung@gmail.com>
In-Reply-To: <20251024212914.1474337-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 09:53:26 -0700
X-Gm-Features: AWmQ_bmAQCui-ii54BCiuN56VMT3wOf7NRO0nY_eo3hlD-7GxlxaE6lxnI2x5n4
Message-ID: <CAEf4BzYnB74djXyb08m7tJE9MGxT-iVOOBsNQO3PFGFDW=vRLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Support associating BPF program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:29=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> a BPF program with a struct_ops map. This command takes a file
> descriptor of a struct_ops map and a BPF program and set
> prog->aux->st_ops_assoc to the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program nor a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> be reset since we have lost track of associated struct_ops. For other
> program types, the associated struct_ops map, once set, cannot be
> changed later. This restriction may be lifted in the future if there is
> a use case.
>
> A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> the associated struct_ops pointer. The returned pointer, if not NULL, is
> guaranteed to be valid and point to a fully updated struct_ops struct.
> For struct_ops program reused in multiple struct_ops map, the return
> will be NULL. The call must be paired with bpf_struct_ops_put() once the
> caller is done with the struct_ops.
>
> To make sure the returned pointer to be valid, the command increases the
> refcount of the map for every associated non-struct_ops programs. For
> struct_ops programs, since they do not increase the refcount of
> struct_ops map, bpf_prog_get_assoc_struct_ops() has to bump the refcount
> of the map to prevent a map from being freed while the program runs.
> This can happen if a struct_ops program schedules a time callback that
> runs after the struct_ops map is freed.
>
> struct_ops implementers should note that the struct_ops returned may or
> may not be attached. The struct_ops implementer will be responsible for
> tracking and checking the state of the associated struct_ops map if the
> use case requires an attached struct_ops.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 16 ++++++
>  include/uapi/linux/bpf.h       | 17 ++++++
>  kernel/bpf/bpf_struct_ops.c    | 98 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  3 ++
>  kernel/bpf/syscall.c           | 46 ++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 17 ++++++
>  6 files changed, 197 insertions(+)
>

[...]

> @@ -1394,6 +1414,84 @@ int bpf_struct_ops_link_create(union bpf_attr *att=
r)
>         return err;
>  }
>
> +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map=
)
> +{
> +       struct bpf_map *st_ops_assoc;
> +
> +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> +
> +       st_ops_assoc =3D rcu_access_pointer(prog->aux->st_ops_assoc);

we don't have RCU lock here, can this trigger lockdep warnings due to
rcu_access_pointer() use?

> +
> +       if (st_ops_assoc && st_ops_assoc =3D=3D map)
> +               return 0;
> +
> +       if (st_ops_assoc) {
> +               if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> +                       return -EBUSY;
> +

put st_ops_assoc map (if it's not BPF_PTR_POISON already, of course),
otherwise we are leaking refcount

pw-bot: cr

> +               rcu_assign_pointer(prog->aux->st_ops_assoc, BPF_PTR_POISO=
N);
> +       } else {
> +               if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> +                       bpf_map_inc(map);
> +
> +               rcu_assign_pointer(prog->aux->st_ops_assoc, map);
> +       }
> +
> +       return 0;
> +}
> +
> +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> +{
> +       struct bpf_map *st_ops_assoc;
> +
> +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> +
> +       st_ops_assoc =3D rcu_access_pointer(prog->aux->st_ops_assoc);
> +
> +       if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> +               return;
> +
> +       if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> +               bpf_map_put(st_ops_assoc);
> +
> +       RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL);
> +}
> +
> +/*
> + * Get a reference to the struct_ops struct (i.e., kdata) associated wit=
h a
> + * program. Must be paired with bpf_struct_ops_put().
> + *
> + * If the returned pointer is not NULL, it must points to a valid and
> + * initialized struct_ops. The struct_ops may or may not be attached.
> + * Kernel struct_ops implementers are responsible for tracking and check=
ing
> + * the state of the struct_ops if the use case requires an attached stru=
ct_ops.
> + */
> +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
> +{
> +       struct bpf_struct_ops_map *st_map;
> +       struct bpf_map *map;
> +
> +       scoped_guard(rcu) {
> +               map =3D rcu_dereference(aux->st_ops_assoc);
> +               if (!map || map =3D=3D BPF_PTR_POISON)
> +                       return NULL;
> +
> +               map =3D bpf_map_inc_not_zero(map);

I think this is buggy. When timer callback happens, the map can be
long gone, and its underlying memory reused for something else. So
this bpf_map_inc_not_zero() can crash or just corrupt some memory. RCU
inside this function doesn't do much for us, it happens way too late.

It's also suboptimal that we now require callers of
bpf_prog_get_assoc_struct_ops() to do manual ref put.

Have you considered getting prog->aux->st_ops_assoc ref incremented
when scheduling async callback instead? Then we won't need all this
hackery and caller will just be working with borrowed map reference?

> +               if (IS_ERR(map))
> +                       return NULL;
> +       }
> +
> +       st_map =3D (struct bpf_struct_ops_map *)map;
> +
> +       if (smp_load_acquire(&st_map->kvalue.common.state) =3D=3D BPF_STR=
UCT_OPS_STATE_INIT) {
> +               bpf_map_put(map);
> +               return NULL;
> +       }
> +
> +       return &st_map->kvalue.data;
> +}
> +EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
> +
>  void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_=
map *map)
>  {

[...]

