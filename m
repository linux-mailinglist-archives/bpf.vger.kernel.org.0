Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910426C5AB5
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 00:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCVXn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 19:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCVXnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 19:43:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFDF23A44
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:42:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so32750830eda.0
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679528563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1OPJZjqBwy0zOOVnswHpBe8pDgJAvG2anGP2Zl/KuQ=;
        b=kloCGPdfLdNg+Ky79b6NoSZXhmvO8ZS0m3b99y9QRQBrgF3RF5Gn/5Wh6gLmMoc6WM
         nc/P+rihvf5VVm5n77KXfyucrFU2FTslBmEX6Y7qd5W/j+lWvyXu/XLx0ux5oEY04qmZ
         JZec0d/Ef84nmBG4HumQNzaNjC8vxSrQCCNPjhw5+Xn5VWA328Q1+kwypl3v5xaC3yYx
         hwK73+NFP4D1DsFAE4wmxgtECTHvaNPW4APnTXCa2rrJWS9l1dkiNiNLVEEa80LXSJLR
         uWRzHBN4TAhFqkIG9bQmWEXaWZek/o/ykppQlBePyu5rTekj4OeaFn4lmnM/B20aKPqh
         aFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679528563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1OPJZjqBwy0zOOVnswHpBe8pDgJAvG2anGP2Zl/KuQ=;
        b=zIwmSXMlxK82yDXMq3f6RpCKBFcjmnaKjOHbD4U6jXvsei8lDX0Ul/rb740GYgxgtQ
         GaeC5OpxjS9Bpwb3mfJUot4/sF6F5cfVWIAG4GVgdhzb0DZCaT6fvkgrA7E4C8LBIBik
         eJjXiCyokKAeAwL2wd7l+AjUHCZik7a0e7t8W4rnfNWonv/k5iIM/N+uMt4ys1GKVJJE
         iCSv/6t1bmJ9oY/pzDCWz5z/thIZF9jHZ4au7rkqLXcxA7uVp6FpsYOpfogz8y1YNDCL
         +g5C6zXGf44WDApn5xQcFBM8b6nrpN0BZUOKKHZmOO499cRvOKShrLvmi/agNMGt2vMJ
         bMGg==
X-Gm-Message-State: AO0yUKVg3YfzxhgFZN6SxzYeH3RsFHTKHfeRRn7pKOF5zR1eGtoofckV
        yIoSPp+ar1L4M8AvHY/w/EfOXBokGNJplsoVYCU=
X-Google-Smtp-Source: AK7set/pK8kxz7wl3ZI81sVG7fnmhqY3g++rYzofxBzjzdX/iwydHeLRwSgxe2Th7B5lkXgtVZGQ+ssIaBkALB6LvsU=
X-Received: by 2002:a17:906:148d:b0:92d:591f:645f with SMTP id
 x13-20020a170906148d00b0092d591f645fmr4368254ejc.5.1679528563683; Wed, 22 Mar
 2023 16:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230321232813.3376064-1-kuifeng@meta.com> <20230321232813.3376064-7-kuifeng@meta.com>
In-Reply-To: <20230321232813.3376064-7-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Mar 2023 16:42:31 -0700
Message-ID: <CAEf4BzYSeXv=TVSenowUsY16twEULh7p0ZiqB=ZXQ=hDTofNQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 6/8] libbpf: Update a bpf_link with another struct_ops.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 4:28=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
>
> Introduce bpf_link__update_map(), which allows to atomically update
> underlying struct_ops implementation for given struct_ops BPF link
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/bpf.h      |  5 ++++-
>  tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index f0f786373238..4fae4e698a8e 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -335,7 +335,10 @@ LIBBPF_API int bpf_link_detach(int link_fd);
>  struct bpf_link_update_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;       /* extra flags */
> -       __u32 old_prog_fd; /* expected old program FD */
> +       union {
> +               __u32 old_prog_fd; /* expected old program FD */
> +               __u32 old_map_fd;  /* expected old map FD */
> +       };

so for these low-level wrappers in libbpf with OPTS we've been trying
to avoid unnecessary unions. If you look at bpf_link_create and
bpf_link_create_ops some fields that are in a union in kernel UAPI are
actually listed as separate fields, and libbpf makes sure that both
fields are not specified at the same time (like iter_info_len and
target_btf_id, for instance).

So let's do the same here, instead of making a union, let's have

__u32 old_prog_fd;
__u32 old_map_fd;

and then in bpf_link_update() implementation make sure that both can't
be set at the same time.

The rest of the patch looks good to me, thanks.


>  };
>  #define bpf_link_update_opts__last_field old_prog_fd
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3b257d5170cb..935a7da501d7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11670,6 +11670,41 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
>         return &link->link;
>  }
>
> +/*
> + * Swap the back struct_ops of a link with a new struct_ops map.
> + */
> +int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *ma=
p)
> +{
> +       struct bpf_link_struct_ops *st_ops_link;
> +       __u32 zero =3D 0;
> +       int err;
> +
> +       if (!bpf_map__is_struct_ops(map) || map->fd < 0)
> +               return -EINVAL;
> +
> +       st_ops_link =3D container_of(link, struct bpf_link_struct_ops, li=
nk);
> +       /* Ensure the type of a link is correct */
> +       if (st_ops_link->map_fd < 0)
> +               return -EINVAL;
> +
> +       err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vda=
ta, 0);
> +       /* It can be EBUSY if the map has been used to create or
> +        * update a link before.  We don't allow updating the value of
> +        * a struct_ops once it is set.  That ensures that the value
> +        * never changed.  So, it is safe to skip EBUSY.
> +        */
> +       if (err && err !=3D -EBUSY)
> +               return err;
> +
> +       err =3D bpf_link_update(link->fd, map->fd, NULL);
> +       if (err < 0)
> +               return err;
> +
> +       st_ops_link->map_fd =3D map->fd;
> +
> +       return 0;
> +}
> +
>  typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
>                                                           void *private_d=
ata);
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index db4992a036f8..1615e55e2e79 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct bpf_program=
 *prog,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> +LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
>
>  struct bpf_iter_attach_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 50dde1f6521e..a5aa3a383d69 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -386,6 +386,7 @@ LIBBPF_1.1.0 {
>  LIBBPF_1.2.0 {
>         global:
>                 bpf_btf_get_info_by_fd;
> +               bpf_link__update_map;
>                 bpf_link_get_info_by_fd;
>                 bpf_map_get_info_by_fd;
>                 bpf_prog_get_info_by_fd;
> --
> 2.34.1
>
