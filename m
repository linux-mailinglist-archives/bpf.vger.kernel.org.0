Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167B96AFB78
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCHAqz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCHAqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:46:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8EA92CE
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:46:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o12so59510388edb.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678236410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8aeI5lo524KNO2DY1Fc5Dc3ReuPs70EI3k4lgAx70w=;
        b=aGOjaVBpLS0jFKBTpNyHY8COWosuL7lHxIPFX097fjhYDCKmNKG1K41RMawCITef3o
         XmpBRHj2Z4+0vRTZL0//H4oAW9PZ3r4XrqKNxpSDC3kQb0BjPvJ49aq9p1IHeGIWxPz0
         dchcjsHnUbUpQxGzF2bXsJX8TEdpPgqn2eTr7i12Gl9i7OF7iePopi5xNLcXSh1KooXC
         kz5Ot+WWOyHDFdReQaxR+3WgG03ak9lCVAQBdl2YCeebaIHBG83Vhqm637erUVTdF2+k
         HgUlSgqeGGaxJK7K5qsAuM3aznTcytw2qntZ8qNJ09her2fDRUE/dUQQMHPmzv/IxbU/
         qktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8aeI5lo524KNO2DY1Fc5Dc3ReuPs70EI3k4lgAx70w=;
        b=CZImw2ENaQr9gBmOXjZSMyBD+bPOellvFz0lfLxay9lbHRc6r2BJ4MXvaWbtEzjPXk
         DvCtH05T9Gv+IFCKcIcTp1fM8vlNGHCL3lCUS2BhHtN2cHHuP0uImdq/cj1CAFP/P+Qe
         pF7zo/u2Q/10SAC6bJ8uPf23Nj2AOpuedwKb/ZIRXVX9rFI8dpZuWCaLxddFyCiRHoTu
         FVASHThJxkjhCbxBgLgRLNfqrrW5NclVapqYdwbQjUkZ36jrE9JCSHAKKMxq8qXWAptc
         SlwIw0yBVurVIMx1kAPYcfoTJSb1YrxEe0RqeXH14dBbT+F+H6n+bw+nPA5j6Xx7xmW2
         nnxA==
X-Gm-Message-State: AO0yUKUW/B8QxOXT2pFgDdxkJjx0iX3e4OQVRBSwaNb2/yS0dJoaCn9c
        vBEnHKDKy/qSFnnyN4CveGEKXyTEet8mAxjkc+A=
X-Google-Smtp-Source: AK7set8LDhHUk1Zr0rwZiA0OjsRAsVxOOmkaVUgcq0zWPEeO9OhiyuBuZDwDBPS5J2A/QgZ+SV93qLiGpcwdG39RjGQ=
X-Received: by 2002:a50:cd94:0:b0:4c2:1a44:642e with SMTP id
 p20-20020a50cd94000000b004c21a44642emr9290275edi.5.1678236410051; Tue, 07 Mar
 2023 16:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-6-kuifeng@meta.com>
In-Reply-To: <20230307233307.3626875-6-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:46:37 -0800
Message-ID: <CAEf4BzbKyDUh4wB+whL-DG0oV_YWvfDV2kWbY=9-vNWzhSwsUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/9] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
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
> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> placeholder, but now it is constructing an authentic one by calling
> bpf_link_create() if the map has the BPF_F_LINK flag.
>
> You can flag a struct_ops map with BPF_F_LINK by calling
> bpf_map__set_map_flags().
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 84 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 22 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 35a698eb825d..a67efc3b3763 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -115,6 +115,7 @@ static const char * const attach_type_name[] =3D {
>         [BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]    =3D "sk_reuseport_select_=
or_migrate",
>         [BPF_PERF_EVENT]                =3D "perf_event",
>         [BPF_TRACE_KPROBE_MULTI]        =3D "trace_kprobe_multi",
> +       [BPF_STRUCT_OPS]                =3D "struct_ops",
>  };
>
>  static const char * const link_type_name[] =3D {
> @@ -7677,6 +7678,26 @@ static int bpf_object__resolve_externs(struct bpf_=
object *obj,
>         return 0;
>  }
>
> +static void bpf_map_prepare_vdata(const struct bpf_map *map)
> +{
> +       struct bpf_struct_ops *st_ops;
> +       __u32 i;
> +
> +       st_ops =3D map->st_ops;
> +       for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
> +               struct bpf_program *prog =3D st_ops->progs[i];
> +               void *kern_data;
> +               int prog_fd;
> +
> +               if (!prog)
> +                       continue;
> +
> +               prog_fd =3D bpf_program__fd(prog);
> +               kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[=
i];
> +               *(unsigned long *)kern_data =3D prog_fd;
> +       }
> +}
> +
>  static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
>  {
>         int err, i;
> @@ -7728,6 +7749,10 @@ static int bpf_object_load(struct bpf_object *obj,=
 int extra_log_level, const ch
>         btf__free(obj->btf_vmlinux);
>         obj->btf_vmlinux =3D NULL;
>
> +       for (i =3D 0; i < obj->nr_maps; i++)
> +               if (bpf_map__is_struct_ops(&obj->maps[i]))
> +                       bpf_map_prepare_vdata(&obj->maps[i]);

This is similar in spirit to what bpf_object_init_prog_arrays() is
doing, let's add this as a separate step.

How about bpf_object_prepare_struct_ops()?

> +
>         obj->loaded =3D true; /* doesn't matter if successfully or not */
>
>         if (err)
> @@ -11429,22 +11454,34 @@ struct bpf_link *bpf_program__attach(const stru=
ct bpf_program *prog)
>         return link;
>  }
>
> +struct bpf_link_struct_ops {
> +       struct bpf_link link;
> +       int map_fd;
> +};
> +
>  static int bpf_link__detach_struct_ops(struct bpf_link *link)
>  {
> +       struct bpf_link_struct_ops *st_link;
>         __u32 zero =3D 0;
>
> -       if (bpf_map_delete_elem(link->fd, &zero))
> -               return -errno;
> +       st_link =3D container_of(link, struct bpf_link_struct_ops, link);
>
> -       return 0;
> +       if (st_link->map_fd < 0) {
> +               /* Fake bpf_link */
> +               if (bpf_map_delete_elem(link->fd, &zero))
> +                       return -errno;
> +               return 0;

just `return bpf_map_delete_elem(...)`, it will return actual error
(libbpf 1.0 simplification)

> +       }
> +
> +       /* Doesn't support detaching. */
> +       return -EOPNOTSUPP;
>  }
>
>  struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>  {
> -       struct bpf_struct_ops *st_ops;
> -       struct bpf_link *link;
> -       __u32 i, zero =3D 0;
> -       int err;
> +       struct bpf_link_struct_ops *link;
> +       __u32 zero =3D 0;
> +       int err, fd;
>
>         if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
>                 return libbpf_err_ptr(-EINVAL);
> @@ -11453,31 +11490,34 @@ struct bpf_link *bpf_map__attach_struct_ops(con=
st struct bpf_map *map)
>         if (!link)
>                 return libbpf_err_ptr(-EINVAL);
>
> -       st_ops =3D map->st_ops;
> -       for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
> -               struct bpf_program *prog =3D st_ops->progs[i];
> -               void *kern_data;
> -               int prog_fd;
> +       /* kern_vdata should be prepared during the loading phase. */
> +       err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vda=
ta, 0);
> +       if (err) {
> +               err =3D -errno;

no need to deal with -errno, err is already the error you need

> +               free(link);
> +               return libbpf_err_ptr(err);
> +       }
>
> -               if (!prog)
> -                       continue;
>
> -               prog_fd =3D bpf_program__fd(prog);
> -               kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[=
i];
> -               *(unsigned long *)kern_data =3D prog_fd;
> +       if (!(map->def.map_flags & BPF_F_LINK)) {
> +               /* Fake bpf_link */
> +               link->link.fd =3D map->fd;
> +               link->map_fd =3D -1;
> +               link->link.detach =3D bpf_link__detach_struct_ops;
> +               return &link->link;
>         }
>
> -       err =3D bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0=
);
> -       if (err) {
> +       fd =3D bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);
> +       if (fd < 0) {
>                 err =3D -errno;

same, fd is an error, it's true for all low-level libbpf APIs

>                 free(link);
>                 return libbpf_err_ptr(err);
>         }
>
> -       link->detach =3D bpf_link__detach_struct_ops;
> -       link->fd =3D map->fd;
> +       link->link.fd =3D fd;
> +       link->map_fd =3D map->fd;
>
> -       return link;
> +       return &link->link;
>  }
>
>  typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
> --
> 2.34.1
>
