Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA776AFB96
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCHAyL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHAyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:54:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC198EB3
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:54:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k10so35699240edk.13
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678236847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACEET1NphIiJwYNGveHzqBPUdm4M1u9TTXPT5So71XY=;
        b=By3kPqYnUVNMUtH6q0hfxBfb7um86oNFIFhU9X2WDkltZQspZV5nerUBculrph1uMz
         OJISLXU1QcMhXE8WhLgz2yVicKY/dNyX9nnsz0UPwX3j6+AKBkRBYJQJfGK223r1f2MV
         yLheM0mQYKUjAVg3d95B5vFPTUkrTXw76v7PnmjOeAO9YbOvUfJ7rbeFA3CJDCg5IDbc
         pR5C1fWHTFTgJw0wqkeh82kVDAn68ksWFr0mdKf9nxsMP2XZZbjH+ARirWJoFx5BEdlB
         WfcxovDXHQLhg6AvFzEOUKBELTwr0GMrkGbBwfIc234SgwekF5x5nXY9MQ1SeptVLwj0
         1WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACEET1NphIiJwYNGveHzqBPUdm4M1u9TTXPT5So71XY=;
        b=4SUE0ACs4tEjaJQQK9e6fsi20M+A1btQUw7Byj8LKnwzLLUmnAtDf4Lk9jwFtx5UX1
         VL3ved+xBj2yvck23vhwoe9aM6X69Y4Wm89xtmZxZOdiZWejEDDh5ulCGFmdHZBcFNs/
         PhQCTB7iqLw3tlZdzZKb+CxTRWKJvN+LLvJK7jkfmtpXX4uIgxKApKNEphapR8LW45UJ
         0iNzHJ7vsG01A02h1g9a5ZEXQhXj5/htvWcoYhVhH6xlxOp5X2Smmb0KNN27FdzZ919s
         r9zzzWUJlLeuPrJsDA+LMjYtfqq1C/Uqg0XD4aI++6gW1oRWx/leETOPQTVV8SBAHKnH
         CoRw==
X-Gm-Message-State: AO0yUKVdu11GAtn59Z6eq+M5ZJFEsx8eWX9SoAAqoby2ZD8bXJsRQIEq
        KxMOy6bjBzSr8KRV68b8fHKmQ1uJzFR3L/ISI4E=
X-Google-Smtp-Source: AK7set8SCGNwrLNS88oGQb7lj5WFx7m4YxQ/92tdLXbldMXUEQ4Lu+tmEvaYvP0CzQDzZ3eorhCexPs7ozdRIw6HJj8=
X-Received: by 2002:a50:9fa8:0:b0:4ae:e5f1:7c50 with SMTP id
 c37-20020a509fa8000000b004aee5f17c50mr9227606edf.5.1678236846763; Tue, 07 Mar
 2023 16:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-8-kuifeng@meta.com>
In-Reply-To: <20230307233307.3626875-8-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:53:54 -0800
Message-ID: <CAEf4BzYVcCRpdxzw1a__QqzrcwMFga5tRyvFGekZQxywr8Ue1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/9] libbpf: Update a bpf_link with another struct_ops.
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

On Tue, Mar 7, 2023 at 3:33=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wrot=
e:
>
> Introduce bpf_link__update_struct_ops(), which will allow you to

update_map, not update_struct_ops, please update

> effortlessly transition the struct_ops map of any given bpf_link into
> an alternative.

This reads confusingly, tbh. Why not say "bpf_link__update_map()
allows to atomically update underlying struct_ops implementation for
given struct_ops BPF link" or something like this? Would it be
accurate?

>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 39 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a67efc3b3763..247de39d136f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11520,6 +11520,42 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
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
> +       if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)

let's not hard-code equality like this, < 0 is better

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
> +       if (err && errno !=3D EBUSY) {

don't use errno, err is perfectly fine to rely on

> +               err =3D -errno;
> +               free(link);

why freeing the link?...


> +               return err;
> +       }
> +
> +       fd =3D bpf_link_update(link->fd, map->fd, NULL);
> +       if (fd < 0) {
> +               err =3D -errno;
> +               free(link);

same... please write tests that exercise both successful and
unsuccessful scenarios

> +               return err;
> +       }
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
> index 2efd80f6f7b9..5e62878d184c 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program=
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
> index 11c36a3c1a9f..e83571b04c19 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -384,4 +384,6 @@ LIBBPF_1.1.0 {
>  } LIBBPF_1.0.0;
>
>  LIBBPF_1.2.0 {
> +       global:
> +               bpf_link__update_map;

please always rebase before posting new versions of patch set,
LIBBPF_1.2.0 is not empty anymore

>  } LIBBPF_1.1.0;
> --
> 2.34.1
>
