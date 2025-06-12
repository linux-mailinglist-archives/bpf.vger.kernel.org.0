Return-Path: <bpf+bounces-60542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A6AD7EA6
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7D3B58B5
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3423D2A9;
	Thu, 12 Jun 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVcjQfbN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999F231835;
	Thu, 12 Jun 2025 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768974; cv=none; b=dVZML/4Fbff8/1rTZD9RvfUvpMI8xuofpi1sZ08GPFAXDBl6o8xWGPHF9uSlA+5XAB2Y+y+tg3wADLXPHsX/0rilqBUbtSUO0tRI4vmBlwEPP5I35lY3con7vnTTV0DmxoAulFudgD/X9b0unqT29dCFjmaOuCmc+ETZOSCTez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768974; c=relaxed/simple;
	bh=9p+Gkqc+wjH3V6q9u7scohU05frP4APWnRbRf9pzskQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjY/cy5zoFvjAF7ex/HAAtUDFNSlPXS1a7AKLVhLAPNtVOQeQi9VT6LhsAtVnm1FKAUUlUcXIa+A++FPRhkC+fuGTjO6Y268COhxzmvK+ifHqT9WWIki0RsRkWSEr3x9rsxx0uFIwZ/ZyQLUYe7koeAd6Ilz3Mg3CQgGeuSkZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVcjQfbN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742caef5896so1472952b3a.3;
        Thu, 12 Jun 2025 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749768970; x=1750373770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XM4PIPbtm15UrUEExgYG5bBUoJBU+AfiMe7VUaDiio=;
        b=WVcjQfbN5a50EbQD1oHNYTrM43InC3+pk23xnzTOarQJ0gXx5pOjMqAA9N+AVYLvME
         t2+OFhOD6niz2Kp+KZ/YlRESkvvFX57dqGlretYHkizy/gIkBVU3b74so1qSBsZyuVg0
         tPccBb5rekx0U47lnnqE0Jg2zEHHyv3qANonYigmin6Mj8YkcjRyp1e02HKf24khP9Gr
         n3CYt/cB6iIisVNkf6Jec49Jn0GY8dHGXKevgGSWRA3fJCNs6JIFBcim7X+G0FpvPOuU
         6FRv8Om0PrY2HJ96O6r32NI6an+D6TsecBsu8CAns3IM8jXIaBBYfjFJoPUefCQV5Rmb
         q2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749768970; x=1750373770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XM4PIPbtm15UrUEExgYG5bBUoJBU+AfiMe7VUaDiio=;
        b=lMh0v0oso3dcE10Tkn1oo+T+lRs6nReRBt/TcKJhVt2aD/G0lzZ5XPVy1UMe44y6tM
         dchPh9RMwcAZI0+w3ukn0hn89aNDzYIa0j2aMUCS4i9Ss6TYSeeI+hApoejfNa2ihrOL
         N0cFhc/cwf3VAFkhoY/xo4374nGGGHVyvr9T2vy0VW7+7waj4SwLW8mlTD9c6yj/c3GW
         t2CsqouQrUJfLt+/KVxRHJff34zsM7uBN0rC3ZQOX0rYZ8DsDb4J8fm3HShWFX3m9myh
         1WApZOD9uHTlc+2iiF3DqyX3v9TxH2PUkoGkC/zBjCTRm6uD28fwXNoyK7kVmUFUFzew
         Wj6g==
X-Forwarded-Encrypted: i=1; AJvYcCXeIL5WITGgJTNrUOTcvjnJetXKw5v2e5ZBR9yH0R8Ay4KEu7uxD9CnZAUzIaxH5/ghE3P1c73P4vkx5lYXjzi8x3g6zfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcsasLN2m8BCFwjph+ML1VxzXLQNC+Xvn/g6Chgkqd/wsmL7b
	uyRKjUfLb27WAxjolkTdMkYnRvoEO7+bSbxZJ1oRRBCyeDHoaNSeFY191r7BZSGKImo+SM/JrdD
	FjuvLdoAw2yDSXHA38CAcbrGV3prW+9E=
X-Gm-Gg: ASbGncvV0+7Dz4ElKtIzTLHExw7HHw/Or4HeUT5cebRXigXafeCjrZfFUNBXfJnRT+e
	pZmkHqHci5w4M3JTvSTlWP5xW/4socB3LCLGTzWmoPhzYf2tWCPizcwaQm7FnEZ/LIxj0VH3EC5
	rZOtEdAYnG4nHKY7oC3fzOtXAGXwCHtqXhbjPP16wUhNJov+fEuEYn/AwHvRg=
X-Google-Smtp-Source: AGHT+IEllyDg8fP09Orpn3TKLkR80BgbHLsHGOBl9DrEwdaWczuluYDKz0ps1zROHxQOdh86KrhJmGWQgJDGrRobYbI=
X-Received: by 2002:a05:6a20:939f:b0:21f:5361:d7eb with SMTP id
 adf61e73a8af0-21fad09274emr1027220637.31.1749768970278; Thu, 12 Jun 2025
 15:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-6-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-6-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 15:55:57 -0700
X-Gm-Features: AX0GCFufTxsF-WQ40jRGu6VABmM_S9mLsXKjTw-u42IldMnls1OsQOXL9JVDGcc
Message-ID: <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> Implement a convenient method i.e. bpf_map__make_exclusive which
> calculates the hash for the program and registers it with the map for
> creation as an exclusive map when the objects are loaded.
>
> The hash of the program must be computed after all the relocations are
> done.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/bpf.c            |  4 +-
>  tools/lib/bpf/bpf.h            |  4 +-
>  tools/lib/bpf/libbpf.c         | 68 +++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h         | 13 +++++++
>  tools/lib/bpf/libbpf.map       |  5 +++
>  tools/lib/bpf/libbpf_version.h |  2 +-
>  6 files changed, 92 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index a9c3e33d0f8a..11fa2d64ccca 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -172,7 +172,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    __u32 max_entries,
>                    const struct bpf_map_create_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, map_token_fd=
);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh);
>         union bpf_attr attr;
>         int fd;
>
> @@ -203,6 +203,8 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.map_ifindex =3D OPTS_GET(opts, map_ifindex, 0);
>
>         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
> +       attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash,=
 NULL));
> +       attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, =
0);
>
>         fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>         return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 777627d33d25..a82b79c0c349 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -54,9 +54,11 @@ struct bpf_map_create_opts {
>         __s32 value_type_btf_obj_fd;
>
>         __u32 token_fd;
> +       __u32 excl_prog_hash_size;
> +       const void *excl_prog_hash;
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field token_fd
> +#define bpf_map_create_opts__last_field excl_prog_hash
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 475038d04cb4..17de756973f4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -499,6 +499,7 @@ struct bpf_program {
>         __u32 line_info_rec_size;
>         __u32 line_info_cnt;
>         __u32 prog_flags;
> +       __u8  hash[SHA256_DIGEST_LENGTH];
>  };
>
>  struct bpf_struct_ops {
> @@ -578,6 +579,8 @@ struct bpf_map {
>         bool autocreate;
>         bool autoattach;
>         __u64 map_extra;
> +       const void *excl_prog_sha;
> +       __u32 excl_prog_sha_size;
>  };
>
>  enum extern_type {
> @@ -4485,6 +4488,43 @@ bpf_object__section_to_libbpf_map_type(const struc=
t bpf_object *obj, int shndx)
>         }
>  }
>
> +static int bpf_program__compute_hash(struct bpf_program *prog)
> +{
> +       struct bpf_insn *purged;
> +       bool was_ld_map;
> +       int i, err;
> +
> +       purged =3D calloc(1, BPF_INSN_SZ * prog->insns_cnt);
> +       if (!purged)
> +               return -ENOMEM;
> +
> +       /* If relocations have been done, the map_fd needs to be
> +        * discarded for the digest calculation.
> +        */

all this looks sketchy, let's think about some more robust approach
here rather than randomly clearing some fields of some instructions...

> +       for (i =3D 0, was_ld_map =3D false; i < prog->insns_cnt; i++) {
> +               purged[i] =3D prog->insns[i];
> +               if (!was_ld_map &&
> +                   purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +                   (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> +                    purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
> +                       was_ld_map =3D true;
> +                       purged[i].imm =3D 0;
> +               } else if (was_ld_map && purged[i].code =3D=3D 0 &&
> +                          purged[i].dst_reg =3D=3D 0 && purged[i].src_re=
g =3D=3D 0 &&
> +                          purged[i].off =3D=3D 0) {
> +                       was_ld_map =3D false;
> +                       purged[i].imm =3D 0;
> +               } else {
> +                       was_ld_map =3D false;
> +               }
> +       }

this was_ld_map business is... unnecessary? Just access purged[i + 1]
(checking i + 1 < prog->insns_cnt, of course), and i +=3D 1. This
stateful approach is an unnecessary complication, IMO

> +       err =3D libbpf_sha256(purged,
> +                           prog->insns_cnt * sizeof(struct bpf_insn),
> +                           prog->hash);

fits on a single line?

> +       free(purged);
> +       return err;
> +}
> +
>  static int bpf_program__record_reloc(struct bpf_program *prog,
>                                      struct reloc_desc *reloc_desc,
>                                      __u32 insn_idx, const char *sym_name=
,
> @@ -5214,6 +5254,10 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
>         create_attr.token_fd =3D obj->token_fd;
>         if (obj->token_fd)
>                 create_attr.map_flags |=3D BPF_F_TOKEN_FD;
> +       if (map->excl_prog_sha) {
> +               create_attr.excl_prog_hash =3D map->excl_prog_sha;
> +               create_attr.excl_prog_hash_size =3D map->excl_prog_sha_si=
ze;
> +       }
>
>         if (bpf_map__is_struct_ops(map)) {
>                 create_attr.btf_vmlinux_value_type_id =3D map->btf_vmlinu=
x_value_type_id;
> @@ -7933,6 +7977,11 @@ static int bpf_object_prepare_progs(struct bpf_obj=
ect *obj)
>                 err =3D bpf_object__sanitize_prog(obj, prog);
>                 if (err)
>                         return err;
> +               /* Now that the instruction buffer is stable finalize the=
 hash
> +                */
> +               err =3D bpf_program__compute_hash(&obj->programs[i]);
> +               if (err)
> +                       return err;

we'll do this unconditionally for any program?.. why?

>         }
>         return 0;
>  }
> @@ -8602,8 +8651,8 @@ static int bpf_object_prepare(struct bpf_object *ob=
j, const char *target_btf_pat
>         err =3D err ? : bpf_object_adjust_struct_ops_autoload(obj);
>         err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? =
: target_btf_path);
>         err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> -       err =3D err ? : bpf_object__create_maps(obj);
>         err =3D err ? : bpf_object_prepare_progs(obj);
> +       err =3D err ? : bpf_object__create_maps(obj);
>
>         if (err) {
>                 bpf_object_unpin(obj);
> @@ -10502,6 +10551,23 @@ int bpf_map__set_inner_map_fd(struct bpf_map *ma=
p, int fd)
>         return 0;
>  }
>
> +int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *pro=
g)
> +{
> +       if (map_is_created(map)) {
> +               pr_warn("%s must be called before creation\n", __func__);

we don't really add __func__ for a long while now, please drop, we
have a consistent "map '%s': what the problem is" format

but for checks like this we also just return -EBUSY or something like
that without error message, so I'd just drop the message altogether

> +               return libbpf_err(-EINVAL);
> +       }
> +
> +       if (prog->obj->state =3D=3D OBJ_LOADED) {
> +               pr_warn("%s must be called before the prog load\n", __fun=
c__);
> +               return libbpf_err(-EINVAL);
> +       }

this is unnecessary, map_is_created() takes care of this

> +       map->excl_prog_sha =3D prog->hash;
> +       map->excl_prog_sha_size =3D SHA256_DIGEST_LENGTH;

this is a hack, I assume that's why you compute that hash for any
program all the time, right? Well, first, if this is called before
bpf_object_prepare(), it will silently do the wrong thing.

But also I don't think we should calculate hash proactively, we could
do this lazily.

> +       return 0;
> +}
> +
> +
>  static struct bpf_map *
>  __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, i=
nt i)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d39f19c8396d..b6ee9870523a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1249,6 +1249,19 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(con=
st struct bpf_map *map,
>   */
>  LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
>                                      const void *cur_key, void *next_key,=
 size_t key_sz);
> +/**
> + * @brief **bpf_map__make_exclusive()** makes the map exclusive to a sin=
gle program.

we should also probably error out if map was already marked as
exclusive to some other program

> + * @param map BPF map to make exclusive.
> + * @param prog BPF program to be the exclusive user of the map.
> + * @return 0 on success; a negative error code otherwise.
> + *
> + * Once a map is made exclusive, only the specified program can access i=
ts
> + * contents. **bpf_map__make_exclusive** must be called before the objec=
ts are
> + * loaded.
> + */
> +LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_p=
rogram *prog);
> +
> +int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *pro=
g);
>
>  struct bpf_xdp_set_link_opts {
>         size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1205f9a4fe04..67b1ff4202a1 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -444,3 +444,8 @@ LIBBPF_1.6.0 {
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
>  } LIBBPF_1.5.0;
> +
> +LIBBPF_1.7.0 {
> +       global:
> +               bpf_map__make_exclusive;
> +} LIBBPF_1.6.0;

we are still in v1.6 dev phase, no need to add 1.7 just yet


> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
> index 28c58fb17250..99331e317dee 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>
>  #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 6
> +#define LIBBPF_MINOR_VERSION 7
>
>  #endif /* __LIBBPF_VERSION_H */
> --
> 2.43.0
>

