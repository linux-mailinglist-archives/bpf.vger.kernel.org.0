Return-Path: <bpf+bounces-21466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E831384D779
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161D01C227D4
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251D14008;
	Thu,  8 Feb 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+/OkIIy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5111737
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354933; cv=none; b=EaXHDgnhP7SKdrQ5v3F0/PqRrWVf4di2I1u82+jjZ9XhBUCzdpmx+811sT+r/sNpt24WIMwxV5F2kZWaAEFPzWe2t6QPIt/y4FgeBBWOLWNldb1kWaDIDa3zVW7OGxi/UOGoT6bbTxbHUDaqnUABWzn6JOSnojUzqcuFq0tOgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354933; c=relaxed/simple;
	bh=WY7PrtxafGYWvIyXsogMvhnmbwjEvX8vaSsW120AmPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goUh7nqke2y4+3bn0PBVYXx+VAKCFeN7+UURJjIODQgd14mfZpbMroADEi2LjfkN45rmubDgwgsR5v6BPXtBr4QDkH+shl+042Iq4wZMzwHZWmrhXaaZJjDAQTQudJPiymojsQ3ivbMoUj2yDZS1vJakGEzwEYwoVPrpEwpBJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+/OkIIy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so635958a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 17:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707354931; x=1707959731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/0xSz4o4XgiNbMeGylPhLw595u0iFgNthUln2Acerg=;
        b=f+/OkIIy7qlejZ+uUntGxFOvhsBFHZ2RQVD1WL/P9cH353/Amff17KqKqlu7ts+GGM
         wXN9Gj6qb8S45i7aXVZNXY0fyJRImDzYmL/oKX0DSLr8lRWjCuCVwvR3fOXXaCdKAEyu
         TvGyTewFYR4SWPOUpNU0kxlnsQ3gu1JrLlMyjWUTPcgBc7Q1Ge06eCjuvviYZyctGe+Y
         qaST02Y98GK+cLK1minJtEGKqiy2+/n+98oZMFf2kbkHicCa/FzTfW+9oFaRdI8Oe+N7
         Ct/gYIWIZ9jLo3VJ9k6tjJt5jKaGmStEuRBPRAG+nDO80F5uOo9JcgcN0AWKAk/nDd4+
         MlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707354931; x=1707959731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/0xSz4o4XgiNbMeGylPhLw595u0iFgNthUln2Acerg=;
        b=pbyku/qXkak99ESuEJi6q/z7tO/WHqYhbrXMGgF7c+Y2MZQfQLtW9Xq/Ik4mDs8sEn
         WjrlpuBkRqHi5LtMvj9GAjyPEdnNGULVHABrSRm1rmDpNhzxCFvVZRcVuSGZX7cPjsbR
         GaAwmM0iOoXGenCK/YmuKq/uYSaJkFtm60ba+QGdgv0T3cH52U4dARBCFbiAM7V33nlf
         YHhPYVQw1X0MpY9Q5ynQvNFUy9EIVjC4SIjoiMr9cgCHs0dTXhfq6qfConV+FCG44ZcA
         Rg5VXdqqs3taG17e/dCDyYZ1heymnOGo54grwJUYqNAnY2lECMjgNDRyqYORw17z6p3+
         xUgw==
X-Gm-Message-State: AOJu0YxcOQ4BkR4b43+R6D07Ee00rk0/ry7XHoSzX59vow1RjKoR0gHm
	cOot/8ZY+S5SBDazVIkpPdOGHyrVfBtBPPG8TIqAhV3UJUsKWtHlYknyXX6uQfLl36+8vJIL7bu
	CkY2E7T0P4mCqwqdMR5HNO+DdH6fTA2hO
X-Google-Smtp-Source: AGHT+IFzyZ8NFJs4eGPxgKKkKD9QnCxOgmKJ7a/dIjkOiYq+8+fjSj6QgSWdg4cYZdswpr9C7Nar1SHQw8DUWQka3Wg=
X-Received: by 2002:a05:6a00:22c3:b0:6df:ef8f:4bdc with SMTP id
 f3-20020a056a0022c300b006dfef8f4bdcmr7278353pfj.21.1707354931359; Wed, 07 Feb
 2024 17:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com> <20240206220441.38311-12-alexei.starovoitov@gmail.com>
In-Reply-To: <20240206220441.38311-12-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 17:15:19 -0800
Message-ID: <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, 
	brho@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> mmap() bpf_arena right after creation, since the kernel needs to
> remember the address returned from mmap. This is user_vm_start.
> LLVM will generate bpf_arena_cast_user() instructions where
> necessary and JIT will add upper 32-bit of user_vm_start
> to such pointers.
>
> Use traditional map->value_size * map->max_entries to calculate mmap sz,
> though it's not the best fit.

We should probably make bpf_map_mmap_sz() aware of specific map type
and do different calculations based on that. It makes sense to have
round_up(PAGE_SIZE) for BPF map arena, and use just just value_size or
max_entries to specify the size (fixing the other to be zero).

>
> Also don't set BTF at bpf_arena creation time, since it doesn't support i=
t.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c        | 18 ++++++++++++++++++
>  tools/lib/bpf/libbpf_probes.c |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..c5ce5946dc6d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -185,6 +185,7 @@ static const char * const map_type_name[] =3D {
>         [BPF_MAP_TYPE_BLOOM_FILTER]             =3D "bloom_filter",
>         [BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
>         [BPF_MAP_TYPE_CGRP_STORAGE]             =3D "cgrp_storage",
> +       [BPF_MAP_TYPE_ARENA]                    =3D "arena",
>  };
>
>  static const char * const prog_type_name[] =3D {
> @@ -4852,6 +4853,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
>         case BPF_MAP_TYPE_SOCKHASH:
>         case BPF_MAP_TYPE_QUEUE:
>         case BPF_MAP_TYPE_STACK:
> +       case BPF_MAP_TYPE_ARENA:
>                 create_attr.btf_fd =3D 0;
>                 create_attr.btf_key_type_id =3D 0;
>                 create_attr.btf_value_type_id =3D 0;
> @@ -4908,6 +4910,22 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
>         if (map->fd =3D=3D map_fd)
>                 return 0;
>
> +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> +               size_t mmap_sz;
> +
> +               mmap_sz =3D bpf_map_mmap_sz(def->value_size, def->max_ent=
ries);
> +               map->mmaped =3D mmap((void *)map->map_extra, mmap_sz, PRO=
T_READ | PROT_WRITE,
> +                                  map->map_extra ? MAP_SHARED | MAP_FIXE=
D : MAP_SHARED,
> +                                  map_fd, 0);
> +               if (map->mmaped =3D=3D MAP_FAILED) {
> +                       err =3D -errno;
> +                       map->mmaped =3D NULL;
> +                       pr_warn("map '%s': failed to mmap bpf_arena: %d\n=
",
> +                               bpf_map__name(map), err);
> +                       return err;

leaking map_fd here, you need to close(map_fd) before erroring out


> +               }
> +       }
> +
>         /* Keep placeholder FD value but now point it to the BPF map obje=
ct.
>          * This way everything that relied on this map's FD (e.g., reloca=
ted
>          * ldimm64 instructions) will stay valid and won't need adjustmen=
ts.
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index ee9b1dbea9eb..cbc7f4c09060 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -338,6 +338,12 @@ static int probe_map_create(enum bpf_map_type map_ty=
pe)
>                 key_size =3D 0;
>                 max_entries =3D 1;
>                 break;
> +       case BPF_MAP_TYPE_ARENA:
> +               key_size        =3D sizeof(__u64);
> +               value_size      =3D sizeof(__u64);
> +               opts.map_extra  =3D 0; /* can mmap() at any address */
> +               opts.map_flags  =3D BPF_F_MMAPABLE;
> +               break;
>         case BPF_MAP_TYPE_HASH:
>         case BPF_MAP_TYPE_ARRAY:
>         case BPF_MAP_TYPE_PROG_ARRAY:
> --
> 2.34.1
>

