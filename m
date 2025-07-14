Return-Path: <bpf+bounces-63185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97287B03EB5
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6F3188DCB4
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B302475E3;
	Mon, 14 Jul 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjBdrDC3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161B221F17
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496183; cv=none; b=V4ph0N6Xy0McgNxc0J36cNf/7YPKMb5fbZiqpHkPBc1dkTcZjf2Y013dLxZZ40S6cRd/WMQqt1sIvZSDCT5HuDFZGPHLxoehEe2KpJWx+VRZNfJ+w/lmzhOjdAXg2PSB+JoFw5o8kQ4H8dnRR+USFPhZ5jTAY82COoZtrTw//rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496183; c=relaxed/simple;
	bh=AoFIvVn09SeOpwWri2C7hM0M3hAYXg9FUKMOcjemY9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kH1DeNZWLKbkPZ96x2Ka1VlVq9XIa4yVvYJvdj+o7kMUVTMdKJcPg60imeM1SfGmIJShZywVqovAoicdeL6YWjlIy44lTxXyIpqGCtQe0AESRIe59xcnaIPEbNDsAXL7tM369N1N/bebk4NgGw4g3TQ7/lRr1bgvjEOl5Yx5V1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjBdrDC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ADFC4CEF6
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752496183;
	bh=AoFIvVn09SeOpwWri2C7hM0M3hAYXg9FUKMOcjemY9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LjBdrDC3TB4qurYlNnsmnHpNGmEi+FUXvte3sSnGuvrlX+J2iN0O/SAYg+xP+BubZ
	 DnJVJJtrph3KkeQzw7YOv2h0Q6tF3tCms8RxUnnpIWj5z9+fHjQf/tu3NM5KWCQPRW
	 k5WOhvRzjFKqAQ1/iR6HPUetivr3LPFUX5+IbJ+E7FtEgxfWycIy26f8Xznz76BFBa
	 llerQl+bo3uofJlcCNYiSaha4RbKqB+G20y+j5GyV3oyiY3HmGm+A8v4NOlMf2mPB7
	 iTJsVOF5GZ92rGYls5L38/Ow+ytgiSjbTuG9K9Ge5Z1tsfekou5/0VW4GTslGyAe74
	 kSASe/s9HYRcA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so7806010a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 05:29:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9KSKO9roUYJB2TtyPRqWOnz+Ris9srSaFJk+UollYz0iRH9FB
	acxZXDIwguRsCP5N3A0AzbZR+Zb3RRIwe9BKSuTVz/K1XDxDYIOJl4q9lzKRxYWk8Tb6kqJRWBM
	ufrCnVHbLJDiqpIZH7wC7bIapSKpQ/vaNfbWFSN1F
X-Google-Smtp-Source: AGHT+IEzVsoHa6a9INkfKoFGam1OCffdVnDp0j4KBdJ+PqemIRNM0Bt2PAt9dSEahbXgsBVbeDP6SGAedzvIsSDdD5s=
X-Received: by 2002:a05:6402:42d4:b0:612:3d0c:a725 with SMTP id
 4fb4d7f45d1cf-6123d0cad4cmr3689438a12.10.1752496181331; Mon, 14 Jul 2025
 05:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-6-kpsingh@kernel.org>
 <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com>
In-Reply-To: <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 14 Jul 2025 14:29:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4qs=CuKxjLkqqt+UeFTgqsqT9NvX_33C5QYGHry6femg@mail.gmail.com>
X-Gm-Features: Ac12FXx7uGA4VjrxDntGqQZgbCW9LiXxkG-vYN55l1sSVl7cgo9jZwNOmAYp1q0
Message-ID: <CACYkzJ4qs=CuKxjLkqqt+UeFTgqsqT9NvX_33C5QYGHry6femg@mail.gmail.com>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> >
> > Implement a convenient method i.e. bpf_map__make_exclusive which
> > calculates the hash for the program and registers it with the map for
> > creation as an exclusive map when the objects are loaded.
> >
> > The hash of the program must be computed after all the relocations are
> > done.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c            |  4 +-
> >  tools/lib/bpf/bpf.h            |  4 +-
> >  tools/lib/bpf/libbpf.c         | 68 +++++++++++++++++++++++++++++++++-
> >  tools/lib/bpf/libbpf.h         | 13 +++++++
> >  tools/lib/bpf/libbpf.map       |  5 +++
> >  tools/lib/bpf/libbpf_version.h |  2 +-
> >  6 files changed, 92 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index a9c3e33d0f8a..11fa2d64ccca 100644
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
> > index 777627d33d25..a82b79c0c349 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -54,9 +54,11 @@ struct bpf_map_create_opts {
> >         __s32 value_type_btf_obj_fd;
> >
> >         __u32 token_fd;
> > +       __u32 excl_prog_hash_size;
> > +       const void *excl_prog_hash;
> >         size_t :0;
> >  };
> > -#define bpf_map_create_opts__last_field token_fd
> > +#define bpf_map_create_opts__last_field excl_prog_hash
> >
> >  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> >                               const char *map_name,
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 475038d04cb4..17de756973f4 100644
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
> > @@ -578,6 +579,8 @@ struct bpf_map {
> >         bool autocreate;
> >         bool autoattach;
> >         __u64 map_extra;
> > +       const void *excl_prog_sha;
> > +       __u32 excl_prog_sha_size;
> >  };
> >
> >  enum extern_type {
> > @@ -4485,6 +4488,43 @@ bpf_object__section_to_libbpf_map_type(const str=
uct bpf_object *obj, int shndx)
> >         }
> >  }
> >
> > +static int bpf_program__compute_hash(struct bpf_program *prog)
> > +{
> > +       struct bpf_insn *purged;
> > +       bool was_ld_map;
> > +       int i, err;
> > +
> > +       purged =3D calloc(1, BPF_INSN_SZ * prog->insns_cnt);
> > +       if (!purged)
> > +               return -ENOMEM;
> > +
> > +       /* If relocations have been done, the map_fd needs to be
> > +        * discarded for the digest calculation.
> > +        */
>
> all this looks sketchy, let's think about some more robust approach
> here rather than randomly clearing some fields of some instructions...
>
> > +       for (i =3D 0, was_ld_map =3D false; i < prog->insns_cnt; i++) {
> > +               purged[i] =3D prog->insns[i];
> > +               if (!was_ld_map &&
> > +                   purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &=
&
> > +                   (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> > +                    purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
> > +                       was_ld_map =3D true;
> > +                       purged[i].imm =3D 0;
> > +               } else if (was_ld_map && purged[i].code =3D=3D 0 &&
> > +                          purged[i].dst_reg =3D=3D 0 && purged[i].src_=
reg =3D=3D 0 &&
> > +                          purged[i].off =3D=3D 0) {
> > +                       was_ld_map =3D false;
> > +                       purged[i].imm =3D 0;
> > +               } else {
> > +                       was_ld_map =3D false;
> > +               }
> > +       }
>
> this was_ld_map business is... unnecessary? Just access purged[i + 1]
> (checking i + 1 < prog->insns_cnt, of course), and i +=3D 1. This
> stateful approach is an unnecessary complication, IMO

Does this look better to you, the next instruction has to be the
second half of the double word right?

for (int i =3D 0; i < prog->insns_cnt; i++) {
    purged[i] =3D prog->insns[i];
    if (purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
        (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
         purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
        purged[i].imm =3D 0;
        i++;
        if (i >=3D prog->insns_cnt ||
            prog->insns[i].code !=3D 0 ||
            prog->insns[i].dst_reg !=3D 0 ||
            prog->insns[i].src_reg !=3D 0 ||
            prog->insns[i].off !=3D 0) {
            return -EINVAL;
        }
        purged[i] =3D prog->insns[i];
        purged[i].imm =3D 0;
    }
}



>
> > +       err =3D libbpf_sha256(purged,
> > +                           prog->insns_cnt * sizeof(struct bpf_insn),
> > +                           prog->hash);
>
> fits on a single line?
>
> > +       free(purged);
> > +       return err;
> > +}
> > +
> >  static int bpf_program__record_reloc(struct bpf_program *prog,
> >                                      struct reloc_desc *reloc_desc,
> >                                      __u32 insn_idx, const char *sym_na=
me,
> > @@ -5214,6 +5254,10 @@ static int bpf_object__create_map(struct bpf_obj=
ect *obj, struct bpf_map *map, b
> >         create_attr.token_fd =3D obj->token_fd;
> >         if (obj->token_fd)
> >                 create_attr.map_flags |=3D BPF_F_TOKEN_FD;
> > +       if (map->excl_prog_sha) {
> > +               create_attr.excl_prog_hash =3D map->excl_prog_sha;
> > +               create_attr.excl_prog_hash_size =3D map->excl_prog_sha_=
size;
> > +       }
> >
> >         if (bpf_map__is_struct_ops(map)) {
> >                 create_attr.btf_vmlinux_value_type_id =3D map->btf_vmli=
nux_value_type_id;
> > @@ -7933,6 +7977,11 @@ static int bpf_object_prepare_progs(struct bpf_o=
bject *obj)
> >                 err =3D bpf_object__sanitize_prog(obj, prog);
> >                 if (err)
> >                         return err;
> > +               /* Now that the instruction buffer is stable finalize t=
he hash
> > +                */
> > +               err =3D bpf_program__compute_hash(&obj->programs[i]);
> > +               if (err)
> > +                       return err;
>
> we'll do this unconditionally for any program?.. why?
>
> >         }
> >         return 0;
> >  }
> > @@ -8602,8 +8651,8 @@ static int bpf_object_prepare(struct bpf_object *=
obj, const char *target_btf_pat
> >         err =3D err ? : bpf_object_adjust_struct_ops_autoload(obj);
> >         err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path =
? : target_btf_path);
> >         err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> > -       err =3D err ? : bpf_object__create_maps(obj);
> >         err =3D err ? : bpf_object_prepare_progs(obj);
> > +       err =3D err ? : bpf_object__create_maps(obj);
> >
> >         if (err) {
> >                 bpf_object_unpin(obj);
> > @@ -10502,6 +10551,23 @@ int bpf_map__set_inner_map_fd(struct bpf_map *=
map, int fd)
> >         return 0;
> >  }
> >
> > +int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *p=
rog)
> > +{
> > +       if (map_is_created(map)) {
> > +               pr_warn("%s must be called before creation\n", __func__=
);
>
> we don't really add __func__ for a long while now, please drop, we
> have a consistent "map '%s': what the problem is" format
>
> but for checks like this we also just return -EBUSY or something like
> that without error message, so I'd just drop the message altogether
>
> > +               return libbpf_err(-EINVAL);
> > +       }
> > +
> > +       if (prog->obj->state =3D=3D OBJ_LOADED) {
> > +               pr_warn("%s must be called before the prog load\n", __f=
unc__);
> > +               return libbpf_err(-EINVAL);
> > +       }
>
> this is unnecessary, map_is_created() takes care of this
>
> > +       map->excl_prog_sha =3D prog->hash;
> > +       map->excl_prog_sha_size =3D SHA256_DIGEST_LENGTH;
>
> this is a hack, I assume that's why you compute that hash for any
> program all the time, right? Well, first, if this is called before
> bpf_object_prepare(), it will silently do the wrong thing.
>
> But also I don't think we should calculate hash proactively, we could
> do this lazily.
>
> > +       return 0;
> > +}
> > +
> > +
> >  static struct bpf_map *
> >  __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj,=
 int i)
> >  {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index d39f19c8396d..b6ee9870523a 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1249,6 +1249,19 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(c=
onst struct bpf_map *map,
> >   */
> >  LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
> >                                      const void *cur_key, void *next_ke=
y, size_t key_sz);
> > +/**
> > + * @brief **bpf_map__make_exclusive()** makes the map exclusive to a s=
ingle program.
>
> we should also probably error out if map was already marked as
> exclusive to some other program
>
> > + * @param map BPF map to make exclusive.
> > + * @param prog BPF program to be the exclusive user of the map.
> > + * @return 0 on success; a negative error code otherwise.
> > + *
> > + * Once a map is made exclusive, only the specified program can access=
 its
> > + * contents. **bpf_map__make_exclusive** must be called before the obj=
ects are
> > + * loaded.
> > + */
> > +LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf=
_program *prog);
> > +
> > +int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *p=
rog);
> >
> >  struct bpf_xdp_set_link_opts {
> >         size_t sz;
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 1205f9a4fe04..67b1ff4202a1 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -444,3 +444,8 @@ LIBBPF_1.6.0 {
> >                 btf__add_decl_attr;
> >                 btf__add_type_attr;
> >  } LIBBPF_1.5.0;
> > +
> > +LIBBPF_1.7.0 {
> > +       global:
> > +               bpf_map__make_exclusive;
> > +} LIBBPF_1.6.0;
>
> we are still in v1.6 dev phase, no need to add 1.7 just yet
>
>
> > diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_vers=
ion.h
> > index 28c58fb17250..99331e317dee 100644
> > --- a/tools/lib/bpf/libbpf_version.h
> > +++ b/tools/lib/bpf/libbpf_version.h
> > @@ -4,6 +4,6 @@
> >  #define __LIBBPF_VERSION_H
> >
> >  #define LIBBPF_MAJOR_VERSION 1
> > -#define LIBBPF_MINOR_VERSION 6
> > +#define LIBBPF_MINOR_VERSION 7
> >
> >  #endif /* __LIBBPF_VERSION_H */
> > --
> > 2.43.0
> >

