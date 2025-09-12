Return-Path: <bpf+bounces-68252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4EB555FD
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8424FAC28FB
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51731691E;
	Fri, 12 Sep 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu6dS2Ud"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C03218AE
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701345; cv=none; b=D2aoFA70lFSlqMkU342VF/e9MbacqCTC/7le1H1lO1cwsHcFsMBd3cNyAlPeIvpTcR4vg0kfbIuJ31XCIw8Rq7clTOyAd977dQpmao++XvtdYI7iKHVuVw9eNRIKMJxmBrgSq/4Jltsdsc6o4sTVqDFcj9BV7PMHcTvPETWZE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701345; c=relaxed/simple;
	bh=A95BSOMh+Z2E+3jkk5SnGiX4n0qGagID0XREuBv4EA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mioePPcLN3jyINRr94AGs3MwZKoLF+4XX7a0vK3EBf2dLxp63kJZ/9mG8hI5qu3Q7Nfq7ZlDhxcHPlEey9FElDDUXnsmATmFl9sZfzi/TJXE4mU4unwa9bf35ikNxYJnB5j+Jm6fLl2a8mr37YeD22KEzcatZqDDLwr5WuB01g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu6dS2Ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A1DC4CEFB
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757701345;
	bh=A95BSOMh+Z2E+3jkk5SnGiX4n0qGagID0XREuBv4EA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qu6dS2Ud55NPpA+ApaJI3UiVSflsMynL5dIcuzKepbkCNGurtVZgFpmpWdiImKYeg
	 PadFrO8iriziLieQGY6xvXWLcuy0ZTPmZrwDjrf7se5gyqsab/tRzFKSpDy+n2nMMh
	 CphNaDf+Fh30M2m5/jfsimhk1JB/JNMQbqXBLkWRdu4Cr0x57O4UelUniG6AfLUN4W
	 WbaySJ4jTiRHbtSidevDmx4tBv48gk32Xw97mGGDO6Rcw36yrcsS66j9hpZkWIPTxq
	 5ll9pq5zaTVbMS73lRMd7Jap1Acuge+7jGSZDFwsV5pFDDXeGrX9TGDpiZVn2o1jDL
	 1iaqAw99pVCCA==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dfb6cadf3so19991465e9.2
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 11:22:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YytH240OEt3whBvHFfdgOe2jweQeCq8nzdY98EDCz9yXnz6sKhV
	m5w3tmDo8BZcmSvsDddY8onx1Jz+406uthAhtFV1UTvkIh8paiG3IeAJJ6A1KHR8eNuPVYZdJW8
	lz406qbc6FqEsEoXc4/JWR9hd7nq59jr7GmDjsfkS
X-Google-Smtp-Source: AGHT+IGnEyqoE04KXY+aMSWG3ZWCLz6N3v5XSLFaVBnpNxiOAYJ8uYRyvIU1fMe+mR90i1wA9RcerEzLtAc536tk7Hk=
X-Received: by 2002:a05:600c:3b85:b0:45d:e285:c4ec with SMTP id
 5b1f17b1804b1-45f216696c8mr34495905e9.4.1757701343523; Fri, 12 Sep 2025
 11:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-5-kpsingh@kernel.org>
 <CAEf4BzbV0UtzrsGm3jbfTWJKRQyu2fqzpcKg_xG8R4+1uEMqnQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbV0UtzrsGm3jbfTWJKRQyu2fqzpcKg_xG8R4+1uEMqnQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 12 Sep 2025 20:22:11 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5s0+3GUvcY3=AZCdXhcqPYW+dP5UbSdi9Gnm2ntanChw@mail.gmail.com>
X-Gm-Features: AS18NWC0TYGbjLn8IwDI2mxDXkE1eeDD68M_n-heY9egxJvCrn2DXrICx_wp7gE
Message-ID: <CACYkzJ5s0+3GUvcY3=AZCdXhcqPYW+dP5UbSdi9Gnm2ntanChw@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] libbpf: Support exclusive map creation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 8:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > Implement setters and getters that allow map to be registers as
>
> typo: registered
>
> > exclusive to the specified program. The registration should be done
> > before the exclusive program is loaded.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c      |  4 ++-
> >  tools/lib/bpf/bpf.h      |  4 ++-
> >  tools/lib/bpf/libbpf.c   | 66 ++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   | 18 +++++++++++
> >  tools/lib/bpf/libbpf.map |  2 ++
> >  5 files changed, 92 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index ab40dbf9f020..6a08a1559237 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -172,7 +172,7 @@ int bpf_map_create(enum bpf_map_type map_type,
> >                    __u32 max_entries,
> >                    const struct bpf_map_create_opts *opts)
> >  {
> > -       const size_t attr_sz =3D offsetofend(union bpf_attr, map_token_=
fd);
> > +       const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_=
hash);
> >         union bpf_attr attr;
> >         int fd;
> >
> > @@ -203,6 +203,8 @@ int bpf_map_create(enum bpf_map_type map_type,
> >         attr.map_ifindex =3D OPTS_GET(opts, map_ifindex, 0);
> >
> >         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
> > +       attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_has=
h, NULL));
> > +       attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size=
, 0);
> >
> >         fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >         return libbpf_err_errno(fd);
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 7252150e7ad3..675a09bb7d2f 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -54,9 +54,11 @@ struct bpf_map_create_opts {
> >         __s32 value_type_btf_obj_fd;
> >
> >         __u32 token_fd;
> > +       __u32 excl_prog_hash_size;
>
> leaving a gap here, can you please reorder and have hash first,
> followed by size?

done

>
> > +       const void *excl_prog_hash;
> >         size_t :0;
> >  };
> > -#define bpf_map_create_opts__last_field token_fd
> > +#define bpf_map_create_opts__last_field excl_prog_hash
> >
> >  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> >                               const char *map_name,
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0bb3d71dcd9f..ed3294f69271 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -499,6 +499,7 @@ struct bpf_program {
> >         __u32 line_info_rec_size;
> >         __u32 line_info_cnt;
> >         __u32 prog_flags;
> > +       __u8  hash[SHA256_DIGEST_LENGTH];
> >  };
> >
> >  struct bpf_struct_ops {
> > @@ -578,6 +579,7 @@ struct bpf_map {
> >         bool autocreate;
> >         bool autoattach;
> >         __u64 map_extra;
> > +       struct bpf_program *excl_prog;
> >  };
> >
> >  enum extern_type {
> > @@ -4488,6 +4490,43 @@ bpf_object__section_to_libbpf_map_type(const str=
uct bpf_object *obj, int shndx)
> >         }
> >  }
> >
> > +static int bpf_program__compute_hash(struct bpf_program *prog)
>
> nit: this is not an API, so please don't use double underscores.
> Something like bpf_prog_compute_hash() should do.

ack.

>
> > +{
> > +       struct bpf_insn *purged;
> > +       int i, err;
> > +
> > +       purged =3D calloc(1, BPF_INSN_SZ * prog->insns_cnt);
>
> we had some patch fixing similar argument misuse issue, so I'd rather
> have calloc(prog->insns_cnt, BPF_INSN_SZ), if you don't mind
>

I don't mind :)

> > +       if (!purged)
> > +               return -ENOMEM;
> > +
> > +       /* If relocations have been done, the map_fd needs to be
> > +        * discarded for the digest calculation.
> > +        */
> > +       for (i =3D 0; i < prog->insns_cnt; i++) {
> > +               purged[i] =3D prog->insns[i];
> > +               if (purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &=
&
> > +                   (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> > +                    purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
> > +                       purged[i].imm =3D 0;
> > +                       i++;
> > +                       if (i >=3D prog->insns_cnt ||
> > +                           prog->insns[i].code !=3D 0 ||
> > +                           prog->insns[i].dst_reg !=3D 0 ||
> > +                           prog->insns[i].src_reg !=3D 0 ||
> > +                           prog->insns[i].off !=3D 0) {
> > +                               err =3D -EINVAL;
> > +                               goto out;
> > +                       }
> > +                       purged[i] =3D prog->insns[i];
> > +                       purged[i].imm =3D 0;
> > +               }
> > +       }
> > +       err =3D libbpf_sha256(purged, prog->insns_cnt * sizeof(struct b=
pf_insn), prog->hash, SHA256_DIGEST_LENGTH);
>
> too long, wrap before prog->hash?

done

>
> > +out:
> > +       free(purged);
> > +       return err;
> > +}
> > +
> >  static int bpf_program__record_reloc(struct bpf_program *prog,
> >                                      struct reloc_desc *reloc_desc,
> >                                      __u32 insn_idx, const char *sym_na=
me,
> > @@ -5227,6 +5266,18 @@ static int bpf_object__create_map(struct bpf_obj=
ect *obj, struct bpf_map *map, b
> >         create_attr.token_fd =3D obj->token_fd;
> >         if (obj->token_fd)
> >                 create_attr.map_flags |=3D BPF_F_TOKEN_FD;
> > +       if (map->excl_prog) {
> > +               if (map->excl_prog->obj->state =3D=3D OBJ_LOADED) {
> > +                       pr_warn("exclusive program already loaded\n");
> > +                       return libbpf_err(-EINVAL);
> > +               }
>
> unnecessary check, maps are always created before programs, so if
> map->excl_prog belongs to the same bpf_object (and it should), then we
> implicitly have a guarantee it's not yet created. So please drop.

Removed.

>
> > +               err =3D bpf_program__compute_hash(map->excl_prog);
> > +               if (err)
> > +                       return err;
> > +
> > +               create_attr.excl_prog_hash =3D map->excl_prog->hash;
> > +               create_attr.excl_prog_hash_size =3D SHA256_DIGEST_LENGT=
H;
> > +       }
> >
> >         if (bpf_map__is_struct_ops(map)) {
> >                 create_attr.btf_vmlinux_value_type_id =3D map->btf_vmli=
nux_value_type_id;
> > @@ -10517,6 +10568,21 @@ int bpf_map__set_inner_map_fd(struct bpf_map *=
map, int fd)
> >         return 0;
> >  }
> >
> > +int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_pro=
gram *prog)
> > +{
> > +       if (map_is_created(map)) {
> > +               pr_warn("exclusive programs must be set before map crea=
tion\n");
> > +               return libbpf_err(-EINVAL);
> > +       }
>
> should we worry about someone providing a bpf_program that doesn't
> belong to the same bpf_object that map belongs to? it's easy to check,
> just compare map->obj and prog->obj

Seems logical, added the check.

> > +       map->excl_prog =3D prog;
> > +       return 0;
> > +}
> > +
> > +struct bpf_program *bpf_map__get_exclusive_program(struct bpf_map *map=
)
>
> libbpf getters don't have "get_" prefix, so just bpf_map__exclusive_progr=
am()

updated.

>
> > +{
> > +       return map->excl_prog;
> > +}
> > +
> >  static struct bpf_map *
> >  __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj,=
 int i)
> >  {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 455a957cb702..ddaf58c8a298 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1266,7 +1266,25 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(c=
onst struct bpf_map *map,
> >   */
> >  LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
> >                                      const void *cur_key, void *next_ke=
y, size_t key_sz);
> > +/**
> > + * @brief **bpf_map__set_exclusive_program()** sets map to be exclusiv=
e to the
> > + * to the specified program. The program must not be loaded yet.
>
> typo: "to the" duplicated

fixed.

>
> Also, I think the more important restriction is that the map should
> not have been created yet (so this has to be called between opening
> and prepare/load steps, just like setting read-only global variables).
> This by implication will mean that the program is not loaded either,
> as we'll restrict bpf_program to be from the same bpf_object (which
> you can mention as well for clarity).
>

How about?

/**
* @brief **bpf_map__set_exclusive_program()** sets a map to be exclusive to=
 the
* specified program. This must be called *before* the map is created.
*
* @param map BPF map to make exclusive.
* @param prog BPF program to be the exclusive user of the map. Must belong
* to the same bpf_object as the map.
* @return 0 on success; a negative error code otherwise.
*
* This function must be called after the BPF object is opened but before
* it is loaded. Once the object is loaded, only the specified program
* will be able to access the map's contents.
*/

> > + * @param map BPF map to make exclusive.
> > + * @param prog BPF program to be the exclusive user of the map.
> > + * @return 0 on success; a negative error code otherwise.
> > + *
> > + * Once a map is made exclusive, only the specified program can access=
 its
> > + * contents.
> > + */
> > +LIBBPF_API int bpf_map__set_exclusive_program(struct bpf_map *map, str=
uct bpf_program *prog);
> >
> > +/**
> > + * @brief **bpf_map__get_exclusive_program()** returns the exclusive p=
rogram
> > + * that is registered with the map (if any).
> > + * @param map BPF map to which the exclusive program is registered.
> > + * @return the registered exclusive program.
> > + */
> > +LIBBPF_API struct bpf_program *bpf_map__get_exclusive_program(struct b=
pf_map *map);
> >  struct bpf_xdp_set_link_opts {
> >         size_t sz;
> >         int old_fd;
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index d7bd463e7017..a5c5d0f2db5c 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -436,6 +436,8 @@ LIBBPF_1.6.0 {
> >                 bpf_linker__add_buf;
> >                 bpf_linker__add_fd;
> >                 bpf_linker__new_fd;
> > +               bpf_map__set_exclusive_program;
> > +               bpf_map__get_exclusive_program;
>
> we are in LIBBPF_1.7.0 now, so please move

done

>
> pw-bot: cr
>
>
> >                 bpf_object__prepare;
> >                 bpf_prog_stream_read;
> >                 bpf_program__attach_cgroup_opts;
> > --
> > 2.43.0
> >

