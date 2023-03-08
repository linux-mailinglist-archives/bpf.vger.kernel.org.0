Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B46AFB5E
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCHAio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCHAi3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:38:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464736FC9
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:38:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so59450597edb.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678235878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3+VblRywuGZsjC1LadZnlc8a5f4Usj/aNIuBo2a93c=;
        b=WIYoxLs7W186b8PJUwSKBgAm0Ya7BtDULjoxw3qDcCHYCOchX5B0f2wfRnOKst7oBy
         SI2B9zD+kGzfKR9uPKnbFS/+6zUlhQwV0DoHcsfv26lEDu5j65WtxI29rUON8RilmXpR
         R6FtJh4kvpCl1lJ+4AXzWJEEk/hadIy6ikiUVgqrwWp+OflUNHqMFOmCsGMYF9/G8X23
         JsJVGm3ejyhAG8Zh0BxrR8UmxqDBXYAlEBYTmpM+34ZU8p8SElVVX3bMhwiHlE8CWwFN
         qN5FMJRzAw0MsJHSk70kAjzOb1nOhaV/mg7ZXC8m2azqIMjj1McPUrLysVKsYul4SLiN
         oE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3+VblRywuGZsjC1LadZnlc8a5f4Usj/aNIuBo2a93c=;
        b=Ttcb7fKdsSr+/8ApVFLuL36cpeEK1QotUFaHRUAcrjxu1uHtyXIApcPedIwG6v5kb/
         YnUEcXF+UxwYYR3UMkoGZhFKjcteBo6/IHTIDC8f+73MJWm7DEpPiVmQoeubY34Cn52/
         crNfG25nDgVAraS+BVEVfb47OjtLSaPwAv7OB9Sex7e0pGBkcKLhPhhfQWe63FGgrrO0
         nE2pSoV1dakNrWS0/5rDu5Xg3eh1qy2/b9VWyXqmyppHxk0zQtGy+xV0QLOUOhSk3DVm
         yT7gVA5ezdRXz0Wxh2U9BJdQabloSYUTsho4N09oIKOpl2a//lvMUi6Hf5cnnJ/aYcdY
         rEXg==
X-Gm-Message-State: AO0yUKVUpRK8kLgNZOPll5ZTk+rLopY4kvY+bmS7LMO811rLiYI6h3Dr
        RRhFFrdtHvRqc44PVB8oTVjh6Aff1RCElF6BUSOiCq6I5u0=
X-Google-Smtp-Source: AK7set8TSjO2z19JLbXW7d4ctt0TlcVp8RTsQvv0crOO+hqyy1h2H/qmtgdLxEuS9EZDQ5uugv1U/F15k6GVr5O4XPg=
X-Received: by 2002:a17:906:3141:b0:8e5:411d:4d09 with SMTP id
 e1-20020a170906314100b008e5411d4d09mr8201290eje.15.1678235878701; Tue, 07 Mar
 2023 16:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-3-kuifeng@meta.com>
In-Reply-To: <20230307233307.3626875-3-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:37:46 -0800
Message-ID: <CAEf4BzYKrO3VZ=s5JA+TyC1iMEQnWm=RJutsEVV08bM9br-new@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/9] bpf: Create links for BPF struct_ops maps.
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
> BPF struct_ops maps are employed directly to register TCP Congestion
> Control algorithms. Unlike other BPF programs that terminate when
> their links gone. The link of a BPF struct_ops map provides a uniform
> experience akin to other types of BPF programs.
>
> bpf_links are responsible for registering their associated
> struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
> set to create a bpf_link, while a structs without this flag behaves in
> the same manner as before and is registered upon updating its value.
>
> The BPF_LINK_TYPE_STRUCT_OPS serves a dual purpose. Not only is it
> used to craft the links for BPF struct_ops programs, but also to
> create links for BPF struct_ops them-self.  Since the links of BPF
> struct_ops programs are only used to create trampolines internally,
> they are never seen in other contexts. Thus, they can be reused for
> struct_ops themself.
>
> To maintain a reference to the map supporting this link, we add
> bpf_struct_ops_link as an additional type. The pointer of the map is
> RCU and won't be necessary until later in the patchset.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  include/linux/bpf.h            |  11 +++
>  include/uapi/linux/bpf.h       |  12 +++-
>  kernel/bpf/bpf_struct_ops.c    | 119 +++++++++++++++++++++++++++++++--
>  kernel/bpf/syscall.c           |  23 ++++---
>  tools/include/uapi/linux/bpf.h |  12 +++-
>  5 files changed, 163 insertions(+), 14 deletions(-)
>

[...]

> +int bpf_struct_ops_link_create(union bpf_attr *attr)
> +{
> +       struct bpf_struct_ops_link *link =3D NULL;
> +       struct bpf_link_primer link_primer;
> +       struct bpf_struct_ops_map *st_map;
> +       struct bpf_map *map;
> +       int err;
> +
> +       map =3D bpf_map_get(attr->link_create.map_fd);
> +       if (!map)
> +               return -EINVAL;
> +
> +       st_map =3D (struct bpf_struct_ops_map *)map;
> +
> +       if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flag=
s & BPF_F_LINK) ||
> +           /* Pair with smp_store_release() during map_update */
> +           smp_load_acquire(&st_map->kvalue.state) !=3D BPF_STRUCT_OPS_S=
TATE_READY) {
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       link =3D kzalloc(sizeof(*link), GFP_USER);
> +       if (!link) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL);
> +       RCU_INIT_POINTER(link->map, map);
> +
> +       err =3D bpf_link_prime(&link->link, &link_primer);
> +       if (err)
> +               goto err_out;
> +
> +       err =3D st_map->st_ops->reg(st_map->kvalue.data);
> +       if (err) {
> +               bpf_link_cleanup(&link_primer);

link =3D NULL to avoid kfree()-ing it, see bpf_tracing_prog_attach() for
similar approach

> +               goto err_out;
> +       }
> +
> +       return bpf_link_settle(&link_primer);
> +
> +err_out:
> +       bpf_map_put(map);
> +       kfree(link);
> +       return err;
> +}
> +

[...]
