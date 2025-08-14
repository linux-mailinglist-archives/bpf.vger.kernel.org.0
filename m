Return-Path: <bpf+bounces-65684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A9B26F49
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B075A4367
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96B9227B9F;
	Thu, 14 Aug 2025 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMN+zCkh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF59319869;
	Thu, 14 Aug 2025 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197199; cv=none; b=PxMB9vO+8BJQegoCndFjUKljANCGuxcz/cHacGH5vSLvlOVzct7coLahz2tqbqVLdd6gc1c5bxe1UzpkxTarU9f6givBLQdjAQRpM7jpfmIifRy6bfhzlrXXb7D0M0GDGGL/22c9CAAPGbFoT+w3P2y3iNx6tN2WcfcjAtX3C1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197199; c=relaxed/simple;
	bh=kAvsoMBA6xYI5H8NQ2mliVc+ht0fk/tImjE+BQOs71o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIMLlrTOValAyj6ixX1C6mon12MTYYWzUBj6LC1qyIIRJKqzuj32MmPO5GJp4Kl6N591ROotagRRjKYrRqtKyXRHuM4oaIh3YILMLZF9uoQ16M0LCYiySsA4Nrt3CO9DSjK4O/S5aJgW3GKlA+QiK+2nZQUrVuu27dGU8+HFQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMN+zCkh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so2123592a91.1;
        Thu, 14 Aug 2025 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197197; x=1755801997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/kMcT2kry0yBs0/sDpKl1ix6uAj9hZerGRWATXXJIw=;
        b=MMN+zCkhLAkiP4LciPidY3hTWrf3PHL0egy+a439tpYLUiD/leip8Psm1Wno+gVHpL
         vFfOv+9hRymjEdhZilQ5gkAx8PYfnohKdQqpKCZImP4HOhe24csMUEWB8ZS8XUP/Nwt1
         znSA9SVot+xXBHw5IokDyQZ7Gm+Nz82WE0Z/SUu9in31EhAsGPJga/VkxRc/ZtUaBDA1
         XeoDHNYrDZyZ5IPwmiWbXPnVVBX4oVhjyxABCvkP18/u/N4DIUbwmlkEBoniLY16x6og
         GChXyywkzoFhagB/7C8KYvmnTZDOWtKm7GNrsUG2IUgPJp/MGKilLGixYnP/WmeWZcTE
         IIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197197; x=1755801997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/kMcT2kry0yBs0/sDpKl1ix6uAj9hZerGRWATXXJIw=;
        b=kemrDeSQKrWdIyLm0iZMYH+Br1On3+1cH6OcVsrTSPUwXeT3ASscNBuIwZRipQwR7g
         vTi8Zq8KbHD/iDsCJBJzXQ6yV6kBlYKmU4ICPuaG0waiQXe5E4CGlZWS3i1gv5pTDTcW
         Yiy6sfO/SEUJlcXxqtLwPQbsY/UB82BZOS2ra54QcoEmOLQ97MfUbc0GRgkuI3jFTsOv
         Ftn6WdvjKwFfYYtFJyIAnddPryUPZJfUk+TFFUfRGRooHOnJiHjbBUM8qiZsrMhFWg+w
         xfj7de8TD/3qnj49wW47gSdyPRu9hmotZMSolUJCob3PnMclwQOmX/gXsnmNgRxmPXgo
         RJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfeLkD8VJS0nTTdPJO5jO/AH+4q7CRoif1/pgdz8p3zU1vWSzCo8TT+yOD082PdzGdlcYYdrCnu20F6A4hDzXYhf3n+x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpesMkmQ253jy6scsROuuj6c4GyHx++3mVLDpUqJkxuuNxohw
	a3nsqrrAjdeVanXvB2yK74dwdwDhhPqRoYuTfcKrU+0HRv7GRZurW+Ia8HmVzgUbIr1iZ+wlbCp
	76ViUecbS4/DEWMk6700kssEh3+1weFo=
X-Gm-Gg: ASbGncsjfcke4y7Nu3v8VvKI1K9XBok6sME68DZkpK8Uvj42W2dB22chWAAWT2xtyuU
	kOX351Uo7eO1U9XgwI9oUJvNU8eRmbgW2o+71mb8P4sJl7CGq3Wy1dmwu1MeG4K856BgT8QNmLp
	TGYJpLF8Js6wAuqh3LOivHHeqH8wczD8uY4c1bV1hHBcTTZh5tDQHuLf8VprYcBp3S8n21cerFw
	VEoyM+i+ym4Cx12Pavb5lIT5A==
X-Google-Smtp-Source: AGHT+IGqrAlBiaW7opKLNA0u8xYQ5AesTDTZQN6Y07P9+WTJRjq/reby6m1X6h/NQ0sbCEOwutVr2ClhC4LDoSMRg7o=
X-Received: by 2002:a17:90b:4acf:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-32327ac0f3dmr7017906a91.33.1755197196664; Thu, 14 Aug 2025
 11:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-5-kpsingh@kernel.org>
In-Reply-To: <20250813205526.2992911-5-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Aug 2025 11:46:21 -0700
X-Gm-Features: Ac12FXzZu7HLeE-QIrV13O90_DYAll66eLYAICUCoIKuEYyK413JqVqc7ZMu_58
Message-ID: <CAEf4BzbV0UtzrsGm3jbfTWJKRQyu2fqzpcKg_xG8R4+1uEMqnQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Implement setters and getters that allow map to be registers as

typo: registered

> exclusive to the specified program. The registration should be done
> before the exclusive program is loaded.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/bpf.c      |  4 ++-
>  tools/lib/bpf/bpf.h      |  4 ++-
>  tools/lib/bpf/libbpf.c   | 66 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 18 +++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  5 files changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index ab40dbf9f020..6a08a1559237 100644
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
> index 7252150e7ad3..675a09bb7d2f 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -54,9 +54,11 @@ struct bpf_map_create_opts {
>         __s32 value_type_btf_obj_fd;
>
>         __u32 token_fd;
> +       __u32 excl_prog_hash_size;

leaving a gap here, can you please reorder and have hash first,
followed by size?

> +       const void *excl_prog_hash;
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field token_fd
> +#define bpf_map_create_opts__last_field excl_prog_hash
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0bb3d71dcd9f..ed3294f69271 100644
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
> @@ -578,6 +579,7 @@ struct bpf_map {
>         bool autocreate;
>         bool autoattach;
>         __u64 map_extra;
> +       struct bpf_program *excl_prog;
>  };
>
>  enum extern_type {
> @@ -4488,6 +4490,43 @@ bpf_object__section_to_libbpf_map_type(const struc=
t bpf_object *obj, int shndx)
>         }
>  }
>
> +static int bpf_program__compute_hash(struct bpf_program *prog)

nit: this is not an API, so please don't use double underscores.
Something like bpf_prog_compute_hash() should do.

> +{
> +       struct bpf_insn *purged;
> +       int i, err;
> +
> +       purged =3D calloc(1, BPF_INSN_SZ * prog->insns_cnt);

we had some patch fixing similar argument misuse issue, so I'd rather
have calloc(prog->insns_cnt, BPF_INSN_SZ), if you don't mind

> +       if (!purged)
> +               return -ENOMEM;
> +
> +       /* If relocations have been done, the map_fd needs to be
> +        * discarded for the digest calculation.
> +        */
> +       for (i =3D 0; i < prog->insns_cnt; i++) {
> +               purged[i] =3D prog->insns[i];
> +               if (purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +                   (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> +                    purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
> +                       purged[i].imm =3D 0;
> +                       i++;
> +                       if (i >=3D prog->insns_cnt ||
> +                           prog->insns[i].code !=3D 0 ||
> +                           prog->insns[i].dst_reg !=3D 0 ||
> +                           prog->insns[i].src_reg !=3D 0 ||
> +                           prog->insns[i].off !=3D 0) {
> +                               err =3D -EINVAL;
> +                               goto out;
> +                       }
> +                       purged[i] =3D prog->insns[i];
> +                       purged[i].imm =3D 0;
> +               }
> +       }
> +       err =3D libbpf_sha256(purged, prog->insns_cnt * sizeof(struct bpf=
_insn), prog->hash, SHA256_DIGEST_LENGTH);

too long, wrap before prog->hash?

> +out:
> +       free(purged);
> +       return err;
> +}
> +
>  static int bpf_program__record_reloc(struct bpf_program *prog,
>                                      struct reloc_desc *reloc_desc,
>                                      __u32 insn_idx, const char *sym_name=
,
> @@ -5227,6 +5266,18 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
>         create_attr.token_fd =3D obj->token_fd;
>         if (obj->token_fd)
>                 create_attr.map_flags |=3D BPF_F_TOKEN_FD;
> +       if (map->excl_prog) {
> +               if (map->excl_prog->obj->state =3D=3D OBJ_LOADED) {
> +                       pr_warn("exclusive program already loaded\n");
> +                       return libbpf_err(-EINVAL);
> +               }

unnecessary check, maps are always created before programs, so if
map->excl_prog belongs to the same bpf_object (and it should), then we
implicitly have a guarantee it's not yet created. So please drop.

> +               err =3D bpf_program__compute_hash(map->excl_prog);
> +               if (err)
> +                       return err;
> +
> +               create_attr.excl_prog_hash =3D map->excl_prog->hash;
> +               create_attr.excl_prog_hash_size =3D SHA256_DIGEST_LENGTH;
> +       }
>
>         if (bpf_map__is_struct_ops(map)) {
>                 create_attr.btf_vmlinux_value_type_id =3D map->btf_vmlinu=
x_value_type_id;
> @@ -10517,6 +10568,21 @@ int bpf_map__set_inner_map_fd(struct bpf_map *ma=
p, int fd)
>         return 0;
>  }
>
> +int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_progr=
am *prog)
> +{
> +       if (map_is_created(map)) {
> +               pr_warn("exclusive programs must be set before map creati=
on\n");
> +               return libbpf_err(-EINVAL);
> +       }

should we worry about someone providing a bpf_program that doesn't
belong to the same bpf_object that map belongs to? it's easy to check,
just compare map->obj and prog->obj

> +       map->excl_prog =3D prog;
> +       return 0;
> +}
> +
> +struct bpf_program *bpf_map__get_exclusive_program(struct bpf_map *map)

libbpf getters don't have "get_" prefix, so just bpf_map__exclusive_program=
()

> +{
> +       return map->excl_prog;
> +}
> +
>  static struct bpf_map *
>  __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, i=
nt i)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 455a957cb702..ddaf58c8a298 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1266,7 +1266,25 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(con=
st struct bpf_map *map,
>   */
>  LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
>                                      const void *cur_key, void *next_key,=
 size_t key_sz);
> +/**
> + * @brief **bpf_map__set_exclusive_program()** sets map to be exclusive =
to the
> + * to the specified program. The program must not be loaded yet.

typo: "to the" duplicated

Also, I think the more important restriction is that the map should
not have been created yet (so this has to be called between opening
and prepare/load steps, just like setting read-only global variables).
This by implication will mean that the program is not loaded either,
as we'll restrict bpf_program to be from the same bpf_object (which
you can mention as well for clarity).

> + * @param map BPF map to make exclusive.
> + * @param prog BPF program to be the exclusive user of the map.
> + * @return 0 on success; a negative error code otherwise.
> + *
> + * Once a map is made exclusive, only the specified program can access i=
ts
> + * contents.
> + */
> +LIBBPF_API int bpf_map__set_exclusive_program(struct bpf_map *map, struc=
t bpf_program *prog);
>
> +/**
> + * @brief **bpf_map__get_exclusive_program()** returns the exclusive pro=
gram
> + * that is registered with the map (if any).
> + * @param map BPF map to which the exclusive program is registered.
> + * @return the registered exclusive program.
> + */
> +LIBBPF_API struct bpf_program *bpf_map__get_exclusive_program(struct bpf=
_map *map);
>  struct bpf_xdp_set_link_opts {
>         size_t sz;
>         int old_fd;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d7bd463e7017..a5c5d0f2db5c 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,6 +436,8 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_buf;
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
> +               bpf_map__set_exclusive_program;
> +               bpf_map__get_exclusive_program;

we are in LIBBPF_1.7.0 now, so please move

pw-bot: cr


>                 bpf_object__prepare;
>                 bpf_prog_stream_read;
>                 bpf_program__attach_cgroup_opts;
> --
> 2.43.0
>

