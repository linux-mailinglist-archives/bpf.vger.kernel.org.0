Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D586BF531
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCQWde (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCQWdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:33:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A611169
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:33:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so25934215edc.3
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679092410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNRShrL0P0laZwH9I65g3UXO1t26DFdoPJSPiGWjg1U=;
        b=bergJS6WS3ugYzM8Hia1nNQWj28wCRgxNcuroLco0Pwbz/v82bAO44YAUR902rQJr4
         K2YPyYiWvNTIP+C3xgCge0z61b8WAacpWG+KeFcTSCJ9PKcdGa1E1ZuG/MoOa8b62Ile
         huegAqCJXUx2i/IXsHfzYypEesrqVBLaAUX2JpwNXbJICvrj0RT3OSJ3XVHvDpLi8zsB
         iXsuG31thJzBlsjTsOyw582erH5Dj1LwuFJoMHY5Te9HGiWAsiZ6C0OwXiCOdYAh6ydg
         Eqd1rzKhx0CIPCg9F0HtfOQD3vJ74M9el1/QVvqRndYfbalCNFrDuOKrJlY83TGY/XgC
         87lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679092410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNRShrL0P0laZwH9I65g3UXO1t26DFdoPJSPiGWjg1U=;
        b=4WEr+9WTpsBkuZSnfVcuSnePTrsCOViDhFt+f5JMFDht2qZks7UzUcrJvyGhwe3cmg
         btcrYKKnX+8r+Vvd3CGvNEPd8wXkbSya7BvzXwMIo4+cWgUMSkafihjIOWcfYiLb3Raz
         j3z2jhs8KdqAnAJyYJjLunVo3pL3zrsZ4v1V+O2MV+TKkHMGgKDDcYX4zwZwWH6fMf2f
         dJzpI7u8PbSD5fPMBC36MShQUN+DELKYJLsgnjFt0j+ILsRCk9unOsi7Li5bZJXkYape
         ndv+SIX4Gh+XPaB9cVekz5g/m6yW11JS5o2fDB95E6UdSh7nHiwJ0nMUQPzSUqdCDsD/
         54Pw==
X-Gm-Message-State: AO0yUKUkBk2JFS7ABlw0bgUgdktV7tp700kxX0WPTolBe1ePAocsAqBe
        YKsUMz7CnXeqXIIHAt+Kgvplj+x1YDsFVtoVJH4=
X-Google-Smtp-Source: AK7set/Kvuw4Lzavn9XULw3I1Z9rzzMjxWfEm3KyuqE0l32SY/MPCZi70stiu0D+iS6UWxoyXQLyloL2T0cKV7jbpuY=
X-Received: by 2002:a50:cd86:0:b0:4fc:2096:b15c with SMTP id
 p6-20020a50cd86000000b004fc2096b15cmr2639127edi.1.1679092410075; Fri, 17 Mar
 2023 15:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230316023641.2092778-1-kuifeng@meta.com> <20230316023641.2092778-7-kuifeng@meta.com>
In-Reply-To: <20230316023641.2092778-7-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 15:33:17 -0700
Message-ID: <CAEf4BzaYUdyfA4nL-SRiUUVCKKeO-oL6xXuXqa2WSvJqOQb_7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 6/8] libbpf: Update a bpf_link with another struct_ops.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 7:37=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
>
> Introduce bpf_link__update_map(), which allows to atomically update
> underlying struct_ops implementation for given struct_ops BPF link
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 32 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6dbae7ffab48..63ec1f8fe8a0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11659,6 +11659,36 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
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
> +       int err, fd;
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
> +       if (err && err !=3D -EBUSY)

Why is it ok to ignore -EBUSY? Let's leave a comment as well, as this
is not clear.

> +               return err;
> +
> +       fd =3D bpf_link_update(link->fd, map->fd, NULL);
> +       if (fd < 0)
> +               return fd;
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
> index 50dde1f6521e..cc05be376257 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -387,6 +387,7 @@ LIBBPF_1.2.0 {
>         global:
>                 bpf_btf_get_info_by_fd;
>                 bpf_link_get_info_by_fd;
> +               bpf_link__update_map;

nit: this should go before bpf_link_get_info_by_fd ('_' orders before 'g')

>                 bpf_map_get_info_by_fd;
>                 bpf_prog_get_info_by_fd;
>  } LIBBPF_1.1.0;
> --
> 2.34.1
>
