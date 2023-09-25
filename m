Return-Path: <bpf+bounces-10811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644137AE21C
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DED672814ED
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADE2628E;
	Mon, 25 Sep 2023 23:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86026288
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:09:46 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E4A11C
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:09:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1c66876aso920801166b.2
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695683382; x=1696288182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7us/X8nmoKjHK4rDags688GPedD+I0cg0uDkCxWWXg=;
        b=bmtpbBolosLsK7ynUcS2Mfby3fl257qj+qU6VSZW14yi56lD0NHOGymhlcqAyHcs6w
         5uo/g7TlbUIUMoJ8aGMz2uG/ls/lEM4w+fA14veJi/GtM56IV1BzKoMX1dmzoNa8JU6V
         qn8FdY3aJ/Gmo8rmyTVndHZhkhl04dY9+3ryUfO6TREPDLCQ0A5ygsdhT6b+93FDRThR
         /HROckOreJOVa3cIHUUhaT2XFToMNMINuU3RPkIOjJahxPHnGnHdsfZ0u+akGgxBc9zF
         6IN0uOA2r7tsBtYVsqkoRBf1fX72jfHJ42CkxQi7cjWq4yTeX9t0O8GhTNhc89GqNbbw
         Fs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695683382; x=1696288182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7us/X8nmoKjHK4rDags688GPedD+I0cg0uDkCxWWXg=;
        b=UkxOtAvkQdRbuqQNRuFqZhL2EqCbHt39sKzeLTgWRXdPDfKFQh6rLc9JLKXxoxdSST
         Y2op9UJF6yPNb5R4aJD4TdugzKk65u4otDFQTYTkSxpk9+vbTuHRUthPuJe5TogF86yV
         bcGbjkNbfRSQUSC/PHSKl46m10VwjI50IA1vcYaRWC1X7s6lXOyx6x3LoJfbxxC8fIBX
         yN0p/Zknd9RRloSwXVGY/cf0xijU+4Gk9/BR3nZW3sUTX6hrxKLoRIh0nN+M2+hSGovq
         8Aq2AXGwu/AR0RLQmh4wUmCnAEopMsO6MW40/fJRVDlIzGGMaJkwTttoMrpnlY/beAnX
         NTGw==
X-Gm-Message-State: AOJu0YxIOCl0Qj0kI/qh7PRlio2Gw+LOJqvrxm9OecLQ31sntJ0ir5+c
	jQ18pO7XCH/CSoenJADDvJe++trmBRQ72b9xxLs=
X-Google-Smtp-Source: AGHT+IEVGLizSb4bdKUbwUXMlW+z10eiPphM8ZlsIORIJEQHp4lFEnpyDGp1qRU2k1FjvQg8UT3yvvCLkD9RJ+54G3U=
X-Received: by 2002:a17:906:3015:b0:9ae:519f:8276 with SMTP id
 21-20020a170906301500b009ae519f8276mr6355015ejz.73.1695683381990; Mon, 25 Sep
 2023 16:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920155923.151136-1-thinker.li@gmail.com> <20230920155923.151136-10-thinker.li@gmail.com>
In-Reply-To: <20230920155923.151136-10-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Sep 2023 16:09:30 -0700
Message-ID: <CAEf4BzZWXR9SFL_hrZMYynBC6ukH=n4Bp_S9FhJ4-hH34zTADg@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/11] libbpf: Find correct module BTFs for
 struct_ops maps and progs.
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:00=E2=80=AFAM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> Find module BTFs for struct_ops maps and progs and pass them to the kerne=
l.
> It ensures the kernel resolve type IDs from correct module BTFs.
>
> For the map of a struct_ops object, mod_btf is added to bpf_map to keep a
> reference to the module BTF. It's FD is passed to the kernel as mod_btf_f=
d
> when it is created.
>
> For a prog attaching to a struct_ops object, attach_btf_obj_fd of bpf_pro=
g
> is the FD pointing to a module BTF in the kernel.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/bpf.c    |   3 +-
>  tools/lib/bpf/bpf.h    |   4 +-
>  tools/lib/bpf/libbpf.c | 121 ++++++++++++++++++++++++-----------------
>  3 files changed, 75 insertions(+), 53 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b0f1913763a3..df4b7570ad92 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    __u32 max_entries,
>                    const struct bpf_map_create_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, map_extra);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, mod_btf_fd);
>         union bpf_attr attr;
>         int fd;
>
> @@ -191,6 +191,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.btf_key_type_id =3D OPTS_GET(opts, btf_key_type_id, 0);
>         attr.btf_value_type_id =3D OPTS_GET(opts, btf_value_type_id, 0);
>         attr.btf_vmlinux_value_type_id =3D OPTS_GET(opts, btf_vmlinux_val=
ue_type_id, 0);
> +       attr.mod_btf_fd =3D OPTS_GET(opts, mod_btf_fd, 0);
>
>         attr.inner_map_fd =3D OPTS_GET(opts, inner_map_fd, 0);
>         attr.map_flags =3D OPTS_GET(opts, map_flags, 0);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 74c2887cfd24..d18f75b0ccc9 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -51,8 +51,10 @@ struct bpf_map_create_opts {
>
>         __u32 numa_node;
>         __u32 map_ifindex;
> +
> +       __u32 mod_btf_fd;

please add `size_t :0;` at the end to avoid compiler leaving garbage
in added padding at the end of opts struct

>  };
> -#define bpf_map_create_opts__last_field map_ifindex
> +#define bpf_map_create_opts__last_field mod_btf_fd
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a6108e3238b..df6ba5494adb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -519,6 +519,7 @@ struct bpf_map {
>         struct bpf_map_def def;
>         __u32 numa_node;
>         __u32 btf_var_idx;
> +       struct module_btf *mod_btf;

It would be simpler to just store btf_fd instead of entire struct
module_btf pointer. You only need this to set btf_obj_fd on map
creation and program loading, right?

>         __u32 btf_key_type_id;
>         __u32 btf_value_type_id;
>         __u32 btf_vmlinux_value_type_id;
> @@ -893,6 +894,42 @@ bpf_object__add_programs(struct bpf_object *obj, Elf=
_Data *sec_data,
>         return 0;
>  }
>
> +static int load_module_btfs(struct bpf_object *obj);
> +
> +static int find_kern_btf_id(struct bpf_object *obj, const char *kern_nam=
e,
> +                           __u16 kind, struct btf **res_btf,
> +                           struct module_btf **res_mod_btf)
> +{
> +       struct module_btf *mod_btf;
> +       struct btf *btf;
> +       int i, id, err;
> +
> +       btf =3D obj->btf_vmlinux;
> +       mod_btf =3D NULL;
> +       id =3D btf__find_by_name_kind(btf, kern_name, kind);
> +
> +       if (id =3D=3D -ENOENT) {
> +               err =3D load_module_btfs(obj);
> +               if (err)
> +                       return err;
> +
> +               for (i =3D 0; i < obj->btf_module_cnt; i++) {
> +                       /* we assume module_btf's BTF FD is always >0 */
> +                       mod_btf =3D &obj->btf_modules[i];
> +                       btf =3D mod_btf->btf;
> +                       id =3D btf__find_by_name_kind_own(btf, kern_name,=
 kind);
> +                       if (id !=3D -ENOENT)
> +                               break;
> +               }
> +       }
> +       if (id <=3D 0)
> +               return -ESRCH;
> +
> +       *res_btf =3D btf;
> +       *res_mod_btf =3D mod_btf;
> +       return id;
> +}
> +

there is no need to move the entire function body here, just add a
forward declaration. It will also make it easier to see what actually
changed about the function (if at all)

>  static const struct btf_member *
>  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>  {
> @@ -927,17 +964,23 @@ static int find_btf_by_prefix_kind(const struct btf=
 *btf, const char *prefix,
>                                    const char *name, __u32 kind);
>
>  static int
> -find_struct_ops_kern_types(const struct btf *btf, const char *tname,
> +find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
> +                          struct module_btf **mod_btf,
>                            const struct btf_type **type, __u32 *type_id,
>                            const struct btf_type **vtype, __u32 *vtype_id=
,
>                            const struct btf_member **data_member)
>  {
>         const struct btf_type *kern_type, *kern_vtype;
>         const struct btf_member *kern_data_member;
> +       struct btf *btf;
>         __s32 kern_vtype_id, kern_type_id;
>         __u32 i;
>
> -       kern_type_id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_STRU=
CT);
> +       /* XXX: should search module BTFs as well. We need module name he=
re
> +        * to locate a correct BTF type.
> +        */

aren't we searching module BTFs? Is this comment still relevant?

> +       kern_type_id =3D find_kern_btf_id(obj, tname, BTF_KIND_STRUCT,
> +                                       &btf, mod_btf);
>         if (kern_type_id < 0) {
>                 pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n",
>                         tname);
> @@ -992,13 +1035,15 @@ static bool bpf_map__is_struct_ops(const struct bp=
f_map *map)
>
>  /* Init the map's fields that depend on kern_btf */
>  static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
> -                                        const struct btf *btf,
> -                                        const struct btf *kern_btf)
> +                                        struct bpf_object *obj)

no need to pass obj separately, you can get it through `map->obj`

>  {
>         const struct btf_member *member, *kern_member, *kern_data_member;
>         const struct btf_type *type, *kern_type, *kern_vtype;
>         __u32 i, kern_type_id, kern_vtype_id, kern_data_off;
>         struct bpf_struct_ops *st_ops;
> +       const struct btf *kern_btf;
> +       struct module_btf *mod_btf;
> +       const struct btf *btf =3D obj->btf;
>         void *data, *kern_data;
>         const char *tname;
>         int err;
> @@ -1006,16 +1051,19 @@ static int bpf_map__init_kern_struct_ops(struct b=
pf_map *map,
>         st_ops =3D map->st_ops;
>         type =3D st_ops->type;
>         tname =3D st_ops->tname;
> -       err =3D find_struct_ops_kern_types(kern_btf, tname,
> +       err =3D find_struct_ops_kern_types(obj, tname, &mod_btf,
>                                          &kern_type, &kern_type_id,
>                                          &kern_vtype, &kern_vtype_id,
>                                          &kern_data_member);
>         if (err)
>                 return err;
>
> +       kern_btf =3D mod_btf ? mod_btf->btf : obj->btf_vmlinux;
> +
>         pr_debug("struct_ops init_kern %s: type_id:%u kern_type_id:%u ker=
n_vtype_id:%u\n",
>                  map->name, st_ops->type_id, kern_type_id, kern_vtype_id)=
;
>
> +       map->mod_btf =3D mod_btf;
>         map->def.value_size =3D kern_vtype->size;
>         map->btf_vmlinux_value_type_id =3D kern_vtype_id;
>
> @@ -1091,6 +1139,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map,
>                                 return -ENOTSUP;
>                         }
>
> +                       /* XXX: attach_btf_obj_fd is needed as well */

seems like all these XXX comments are outdated and the code is already
doing all that, is that right? If so, please remove them, they are
confusing

> +                       if (mod_btf)
> +                               prog->attach_btf_obj_fd =3D mod_btf->fd;
>                         prog->attach_btf_id =3D kern_type_id;
>                         prog->expected_attach_type =3D kern_member_idx;
>
> @@ -1133,8 +1184,8 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
>                 if (!bpf_map__is_struct_ops(map))
>                         continue;
>
> -               err =3D bpf_map__init_kern_struct_ops(map, obj->btf,
> -                                                   obj->btf_vmlinux);
> +               /* XXX: should be a module btf if not vmlinux */
> +               err =3D bpf_map__init_kern_struct_ops(map, obj);
>                 if (err)
>                         return err;
>         }

[...]

