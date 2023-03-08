Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5D6AFBC1
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 02:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHBHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 20:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCHBHX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:07:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59678A9DF5
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:07:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k10so35791295edk.13
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678237640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHf4lYLekqvSrnofqd07P4Jh0r5v9FO5yGV3z0ViiIw=;
        b=T7EAkq50xtfljiByx6YMuKsEj/h2OmHQbvKbMGF+ocUu6oQfHtjeFpUm3uAm22zGMK
         /jRqunnstu9l4E7W71zxaMGCAhWmLSo0r6lSB2LXk8WWxN1rwDtM54SvtmuRFq4bmMFF
         eN1PHQ2MggAgtofhNWYdMAsL59i2Nin+9B/+ZieUcw5xr6LE0Jb7iBmKGdd7abjP+8jo
         Nf5bkZaGS5oeCMhND8RJG/1kZGyeRqw5uv/o830hf9wtb7IUPsaHo04pNn2axkeUFy5w
         RVR3mAGLudJCWuZpL1yDlV3IjL0Y7koOETVN987u1Lrf0j0YXZJOjehxsnzkjc/QOAGW
         ffmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678237640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHf4lYLekqvSrnofqd07P4Jh0r5v9FO5yGV3z0ViiIw=;
        b=ER6T5ZcN4sMhMfjZI4DBmYgHFVqnOssUiGir6mYr+VWU3D/fh9I9G4NrlE13Ur0Mud
         lr783OwEqrQmFZzKdB5sCNtZjYoPB6JmihBnWHfjqZ3Zmzem7nd6lFZR3LD3OYMmGyKI
         zaaXOMPMDxdh52gw0Vk2GL0UFGmhW5gph586gFo4qpMDlYb3mWkDIks4JbcLpy4YBbj7
         mmC/3U9FIqsdMt2C5ZQAtndRPiJCTrzv39Igp+/A+TjdbkLNBKVh5b9V8UEIKeQdYnWZ
         kW42AtbHkcy078CYiKVtoNqcAjlmRfaTDE/k7qvanoGj8KsqGOB+9pkcenP3BpNF7ETY
         hbyA==
X-Gm-Message-State: AO0yUKUyjLvGW3Iz+nQlK2K8/tmHmCHBvZQYNtBppB02i0WjH9GxcYcv
        jsy7BGb8X9zoZM4rUda0CvtMF1NwgCxzypVxKtA=
X-Google-Smtp-Source: AK7set/j2pPlX7gNXG0T9LdIwQ2CY+kFhRa7YiKpxqnR+8wbd2TWkTI0scprBcpzqYANMYNp3z5lev7fiqiZcDEMAZg=
X-Received: by 2002:a50:c057:0:b0:4c1:b5de:b72d with SMTP id
 u23-20020a50c057000000b004c1b5deb72dmr9196022edd.5.1678237639770; Tue, 07 Mar
 2023 17:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-9-kuifeng@meta.com>
In-Reply-To: <20230307233307.3626875-9-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:07:07 -0800
Message-ID: <CAEf4BzaopfY5azUh4yi=Bx3h7x9W9r=XCA1OeVrTFSK_X3s7UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/9] libbpf: Use .struct_ops.link section to
 indicate a struct_ops with a link.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 3:33=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wrot=
e:
>
> Flags a struct_ops is to back a bpf_link by putting it to the
> ".struct_ops.link" section.  Once it is flagged, the created
> struct_ops can be used to create a bpf_link or update a bpf_link that
> has been backed by another struct_ops.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 64 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 247de39d136f..d66acd2fdbaa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -467,6 +467,7 @@ struct bpf_struct_ops {
>  #define KCONFIG_SEC ".kconfig"
>  #define KSYMS_SEC ".ksyms"
>  #define STRUCT_OPS_SEC ".struct_ops"
> +#define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -596,6 +597,7 @@ struct elf_state {
>         Elf64_Ehdr *ehdr;
>         Elf_Data *symbols;
>         Elf_Data *st_ops_data;
> +       Elf_Data *st_ops_link_data;
>         size_t shstrndx; /* section index for section name strings */
>         size_t strtabidx;
>         struct elf_sec_desc *secs;
> @@ -605,6 +607,7 @@ struct elf_state {
>         int text_shndx;
>         int symbols_shndx;
>         int st_ops_shndx;
> +       int st_ops_link_shndx;
>  };
>
>  struct usdt_manager;
> @@ -1119,7 +1122,7 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
>         return 0;
>  }
>
> -static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
> +static int bpf_object__init_struct_ops_maps_link(struct bpf_object *obj,=
 bool link)

let's shorten it and not use double underscores, as this is not a
public bpf_object API, just "init_struct_ops_maps" probably is fine

>  {
>         const struct btf_type *type, *datasec;
>         const struct btf_var_secinfo *vsi;
> @@ -1127,18 +1130,33 @@ static int bpf_object__init_struct_ops_maps(struc=
t bpf_object *obj)
>         const char *tname, *var_name;
>         __s32 type_id, datasec_id;
>         const struct btf *btf;
> +       const char *sec_name;
>         struct bpf_map *map;
> -       __u32 i;
> +       __u32 i, map_flags;
> +       Elf_Data *data;
> +       int shndx;
>
> -       if (obj->efile.st_ops_shndx =3D=3D -1)
> +       if (link) {
> +               sec_name =3D STRUCT_OPS_LINK_SEC;
> +               shndx =3D obj->efile.st_ops_link_shndx;
> +               data =3D obj->efile.st_ops_link_data;
> +               map_flags =3D BPF_F_LINK;
> +       } else {
> +               sec_name =3D STRUCT_OPS_SEC;
> +               shndx =3D obj->efile.st_ops_shndx;
> +               data =3D obj->efile.st_ops_data;
> +               map_flags =3D 0;
> +       }

let's pass these as function arguments instead

> +
> +       if (shndx =3D=3D -1)
>                 return 0;
>
>         btf =3D obj->btf;
> -       datasec_id =3D btf__find_by_name_kind(btf, STRUCT_OPS_SEC,
> +       datasec_id =3D btf__find_by_name_kind(btf, sec_name,
>                                             BTF_KIND_DATASEC);
>         if (datasec_id < 0) {
>                 pr_warn("struct_ops init: DATASEC %s not found\n",
> -                       STRUCT_OPS_SEC);
> +                       sec_name);
>                 return -EINVAL;
>         }
>
> @@ -1151,7 +1169,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
>                 type_id =3D btf__resolve_type(obj->btf, vsi->type);
>                 if (type_id < 0) {
>                         pr_warn("struct_ops init: Cannot resolve var type=
_id %u in DATASEC %s\n",
> -                               vsi->type, STRUCT_OPS_SEC);
> +                               vsi->type, sec_name);
>                         return -EINVAL;
>                 }
>
> @@ -1170,7 +1188,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
>                 if (IS_ERR(map))
>                         return PTR_ERR(map);
>
> -               map->sec_idx =3D obj->efile.st_ops_shndx;
> +               map->sec_idx =3D shndx;
>                 map->sec_offset =3D vsi->offset;
>                 map->name =3D strdup(var_name);
>                 if (!map->name)
> @@ -1180,6 +1198,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
>                 map->def.key_size =3D sizeof(int);
>                 map->def.value_size =3D type->size;
>                 map->def.max_entries =3D 1;
> +               map->def.map_flags =3D map_flags;
>
>                 map->st_ops =3D calloc(1, sizeof(*map->st_ops));
>                 if (!map->st_ops)
> @@ -1192,14 +1211,14 @@ static int bpf_object__init_struct_ops_maps(struc=
t bpf_object *obj)
>                 if (!st_ops->data || !st_ops->progs || !st_ops->kern_func=
_off)
>                         return -ENOMEM;
>
> -               if (vsi->offset + type->size > obj->efile.st_ops_data->d_=
size) {
> +               if (vsi->offset + type->size > data->d_size) {
>                         pr_warn("struct_ops init: var %s is beyond the en=
d of DATASEC %s\n",
> -                               var_name, STRUCT_OPS_SEC);
> +                               var_name, sec_name);
>                         return -EINVAL;
>                 }
>
>                 memcpy(st_ops->data,
> -                      obj->efile.st_ops_data->d_buf + vsi->offset,
> +                      data->d_buf + vsi->offset,
>                        type->size);
>                 st_ops->tname =3D tname;
>                 st_ops->type =3D type;
> @@ -1212,6 +1231,15 @@ static int bpf_object__init_struct_ops_maps(struct=
 bpf_object *obj)
>         return 0;
>  }
>
> +static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)

let's name this bpf_object_init_struct_ops, no double underscores

> +{
> +       int err;
> +
> +       err =3D bpf_object__init_struct_ops_maps_link(obj, false);
> +       err =3D err ?: bpf_object__init_struct_ops_maps_link(obj, true);
> +       return err;
> +}
> +
>  static struct bpf_object *bpf_object__new(const char *path,
>                                           const void *obj_buf,
>                                           size_t obj_buf_sz,
> @@ -1248,6 +1276,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
>         obj->efile.obj_buf_sz =3D obj_buf_sz;
>         obj->efile.btf_maps_shndx =3D -1;
>         obj->efile.st_ops_shndx =3D -1;
> +       obj->efile.st_ops_link_shndx =3D -1;
>         obj->kconfig_map_idx =3D -1;
>
>         obj->kern_version =3D get_kernel_version();
> @@ -1265,6 +1294,7 @@ static void bpf_object__elf_finish(struct bpf_objec=
t *obj)
>         obj->efile.elf =3D NULL;
>         obj->efile.symbols =3D NULL;
>         obj->efile.st_ops_data =3D NULL;
> +       obj->efile.st_ops_link_data =3D NULL;
>
>         zfree(&obj->efile.secs);
>         obj->efile.sec_cnt =3D 0;
> @@ -2753,12 +2783,13 @@ static bool libbpf_needs_btf(const struct bpf_obj=
ect *obj)
>  {
>         return obj->efile.btf_maps_shndx >=3D 0 ||
>                obj->efile.st_ops_shndx >=3D 0 ||
> +              obj->efile.st_ops_link_shndx >=3D 0 ||
>                obj->nr_extern > 0;
>  }
>
>  static bool kernel_needs_btf(const struct bpf_object *obj)
>  {
> -       return obj->efile.st_ops_shndx >=3D 0;
> +       return obj->efile.st_ops_shndx >=3D 0 || obj->efile.st_ops_link_s=
hndx >=3D 0;
>  }
>
>  static int bpf_object__init_btf(struct bpf_object *obj,
> @@ -3451,6 +3482,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                         } else if (strcmp(name, STRUCT_OPS_SEC) =3D=3D 0)=
 {
>                                 obj->efile.st_ops_data =3D data;
>                                 obj->efile.st_ops_shndx =3D idx;
> +                       } else if (strcmp(name, STRUCT_OPS_LINK_SEC) =3D=
=3D 0) {
> +                               obj->efile.st_ops_link_data =3D data;
> +                               obj->efile.st_ops_link_shndx =3D idx;
>                         } else {
>                                 pr_info("elf: skipping unrecognized data =
section(%d) %s\n",
>                                         idx, name);
> @@ -3465,6 +3499,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                         /* Only do relo for section with exec instruction=
s */
>                         if (!section_have_execinstr(obj, targ_sec_idx) &&
>                             strcmp(name, ".rel" STRUCT_OPS_SEC) &&
> +                           strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
>                             strcmp(name, ".rel" MAPS_ELF_SEC)) {
>                                 pr_info("elf: skipping relo section(%d) %=
s for section(%d) %s\n",
>                                         idx, name, targ_sec_idx,
> @@ -6611,7 +6646,7 @@ static int bpf_object__collect_relos(struct bpf_obj=
ect *obj)
>                         return -LIBBPF_ERRNO__INTERNAL;
>                 }
>
> -               if (idx =3D=3D obj->efile.st_ops_shndx)
> +               if (idx =3D=3D obj->efile.st_ops_shndx || idx =3D=3D obj-=
>efile.st_ops_link_shndx)
>                         err =3D bpf_object__collect_st_ops_relos(obj, shd=
r, data);

this function calls find_struct_ops_map_by_offset() which assumes we
only have one struct_ops section. This won't work now, please double
check all this, there should be no assumption about specific section
index

>                 else if (idx =3D=3D obj->efile.btf_maps_shndx)
>                         err =3D bpf_object__collect_map_relos(obj, shdr, =
data);
> @@ -8954,8 +8989,9 @@ static int bpf_object__collect_st_ops_relos(struct =
bpf_object *obj,
>                 }
>
>                 /* struct_ops BPF prog can be re-used between multiple
> -                * .struct_ops as long as it's the same struct_ops struct
> -                * definition and the same function pointer field
> +                * .struct_ops & .struct_ops.link as long as it's the
> +                * same struct_ops struct definition and the same
> +                * function pointer field
>                  */
>                 if (prog->attach_btf_id !=3D st_ops->type_id ||
>                     prog->expected_attach_type !=3D member_idx) {
> --
> 2.34.1
>
