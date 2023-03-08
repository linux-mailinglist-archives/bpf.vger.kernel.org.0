Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCE6AFB82
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCHAte (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHAtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:49:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64EAA7686
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:49:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ay14so55859696edb.11
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678236565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY972GGaxqy9iSN3aMUUodzrhxB+7t7W1nwMAN3AgTE=;
        b=pFmhcFdTq7a+7zS+Q3CvDarw/G1Mtc9zCjQCBXi1ge0+3W+bzn8/tnw6XGeqC4Iivn
         EV6yoMeBDDB1iAvUpMxrZVgZ8Bqf72FQSN/WPuNh7P63A70Q6IFYNNCeTD6FlDVURvnX
         fRzggYFE73WLCPqzBjDwTz9KeivPnxpgn1uA0FXwNGwF9HDxzNpsCMnEPeU48dQyYap9
         WR2yn2d6NU6ykCRM9L495aHCe7LyU8l5wuJqe09IkYY09Z/J7dNHBxCGwY7KFg2xOKFk
         c6yh6vo51t9T6/gt+eSZ5cl/c2sSFmioaR6CSZ4tEyaoxqktmKvIWYblIaonh4MUnfFT
         ioNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY972GGaxqy9iSN3aMUUodzrhxB+7t7W1nwMAN3AgTE=;
        b=LGGCLfVKfv8G88XnTzeZWP8l+/Ilw+BTX+Y6MMJlBAg6Uwno/2DpZX0ldXe8/a3GJw
         EKIIlFpNibWE+Pw8r16ypFU/B/fMA7diDPNzDDmDVvX+n708BVRdodJwHraKO19MpWUn
         HT5GeBtYoKdfxWeuKhYULU0HojC1SBTcWwuzxEOd1n3e37ifq4SegiIROz6JTNwLRQqg
         Zmba76jZMq884mhbLXARJ7sSQTPg5pDWTHA3fKdVNRi2sUzegN845JFIZtWDOlwuz7WA
         hBM21v/3FRzXiqvllp9Om/IkMIFaTLN3tn0Ax2sLYkoKNBJf/+cyAsyOLxxizAf7pT8s
         b7Fg==
X-Gm-Message-State: AO0yUKXzVGeNESOgMkcbeFuQ+po+4eO7RI1sybqUkIion7ZNhF/prVTe
        uRJGtMXA7FXlf4z/30STdZv2/YrK4JempzXL51OKHz04
X-Google-Smtp-Source: AK7set+nm8ClsW+5/NlCVlvcuaJlbuckf1yOa3knen1gqgvQKxrkgbzGfzSBgUS4aOW/QmIODqZ5xCg2A8gwOdmvd9o=
X-Received: by 2002:a17:906:3141:b0:8e5:411d:4d09 with SMTP id
 e1-20020a170906314100b008e5411d4d09mr8214953eje.15.1678236565180; Tue, 07 Mar
 2023 16:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20230307233307.3626875-1-kuifeng@meta.com> <20230307233307.3626875-7-kuifeng@meta.com>
In-Reply-To: <20230307233307.3626875-7-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:49:12 -0800
Message-ID: <CAEf4BzbK8s+VFG5HefydD7CRLzkRFKg-Er0PKV_-C2-yttfXzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] bpf: Update the struct_ops of a bpf_link.
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
> By improving the BPF_LINK_UPDATE command of bpf(), it should allow you
> to conveniently switch between different struct_ops on a single
> bpf_link. This would enable smoother transitions from one struct_ops
> to another.
>
> The struct_ops maps passing along with BPF_LINK_UPDATE should have the
> BPF_F_LINK flag.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  8 ++++--
>  kernel/bpf/bpf_struct_ops.c    | 46 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           | 43 ++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  7 +++++-
>  5 files changed, 98 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 047d2c6aba88..2b5f150e370e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1405,6 +1405,7 @@ struct bpf_link_ops {
>         void (*show_fdinfo)(const struct bpf_link *link, struct seq_file =
*seq);
>         int (*fill_link_info)(const struct bpf_link *link,
>                               struct bpf_link_info *info);
> +       int (*update_map)(struct bpf_link *link, struct bpf_map *new_map)=
;
>  };
>
>  struct bpf_tramp_link {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index eb3e435c5303..999e199ebe06 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1555,8 +1555,12 @@ union bpf_attr {
>
>         struct { /* struct used by BPF_LINK_UPDATE command */
>                 __u32           link_fd;        /* link fd */
> -               /* new program fd to update link with */
> -               __u32           new_prog_fd;
> +               union {
> +                       /* new program fd to update link with */
> +                       __u32           new_prog_fd;
> +                       /* new struct_ops map fd to update link with */
> +                       __u32           new_map_fd;
> +               };
>                 __u32           flags;          /* extra flags */
>                 /* expected link's program fd; is specified only if
>                  * BPF_F_REPLACE flag is set in flags */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c71c8d73c7ad..2b850ce11617 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -759,10 +759,56 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
>         return 0;
>  }
>
> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map)
> +{
> +       struct bpf_struct_ops_value *kvalue;
> +       struct bpf_struct_ops_map *st_map, *old_st_map;
> +       struct bpf_struct_ops_link *st_link;
> +       struct bpf_map *old_map;
> +       int err =3D 0;
> +
> +       if (new_map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> +           !(new_map->map_flags & BPF_F_LINK))
> +               return -EINVAL;
> +
> +       mutex_lock(&update_mutex);
> +
> +       st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> +
> +       /* The new and old struct_ops must be the same type. */
> +       st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
> +
> +       old_map =3D st_link->map;
> +       old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, m=
ap);
> +       if (st_map->st_ops !=3D old_st_map->st_ops ||
> +           /* Pair with smp_store_release() during map_update */
> +           smp_load_acquire(&st_map->kvalue.state) !=3D BPF_STRUCT_OPS_S=
TATE_READY) {
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       kvalue =3D &st_map->kvalue;
> +
> +       err =3D st_map->st_ops->update(kvalue->data, old_st_map->kvalue.d=
ata);
> +       if (err)
> +               goto err_out;
> +
> +       bpf_map_inc(new_map);
> +       rcu_assign_pointer(st_link->map, new_map);
> +
> +       bpf_map_put(old_map);
> +
> +err_out:
> +       mutex_unlock(&update_mutex);
> +
> +       return err;
> +}
> +
>  static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
>         .dealloc =3D bpf_struct_ops_map_link_dealloc,
>         .show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
>         .fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
> +       .update_map =3D bpf_struct_ops_map_link_update,
>  };
>
>  int bpf_struct_ops_link_create(union bpf_attr *attr)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 25b044fdd82b..94ab1336ff41 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4646,6 +4646,30 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>         return ret;
>  }
>
> +static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
> +{
> +       struct bpf_map *new_map;
> +       int ret =3D 0;
> +
> +       new_map =3D bpf_map_get(attr->link_update.new_map_fd);
> +       if (IS_ERR(new_map))
> +               return -EINVAL;
> +
> +       if (new_map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS) {
> +               ret =3D -EINVAL;
> +               goto out_put_map;
> +       }
> +
> +       if (link->ops->update_map)
> +               ret =3D link->ops->update_map(link, new_map);
> +       else
> +               ret =3D -EINVAL;
> +
> +out_put_map:
> +       bpf_map_put(new_map);
> +       return ret;
> +}
> +
>  #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>
>  static int link_update(union bpf_attr *attr)
> @@ -4658,14 +4682,25 @@ static int link_update(union bpf_attr *attr)
>         if (CHECK_ATTR(BPF_LINK_UPDATE))
>                 return -EINVAL;
>
> -       flags =3D attr->link_update.flags;
> -       if (flags & ~BPF_F_REPLACE)
> -               return -EINVAL;
> -
>         link =3D bpf_link_get_from_fd(attr->link_update.link_fd);
>         if (IS_ERR(link))
>                 return PTR_ERR(link);
>
> +       flags =3D attr->link_update.flags;
> +
> +       if (link->ops->update_map) {
> +               if (flags)      /* always replace the existing one */
> +                       ret =3D -EINVAL;
> +               else
> +                       ret =3D link_update_map(link, attr);
> +               goto out_put_link;

umm... BPF_F_REPLACE for link_update is specifying "update only if
current prog fd matches what I specify", let's not ignore it for
struct_ops. This will create a deviation in behavior unnecessarily.
Please keep it consistent.


> +       }
> +
> +       if (flags & ~BPF_F_REPLACE) {
> +               ret =3D -EINVAL;
> +               goto out_put_link;
> +       }
> +
>         new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
>         if (IS_ERR(new_prog)) {
>                 ret =3D PTR_ERR(new_prog);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index cd0ff39981e8..259b8ab4f54e 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1556,7 +1556,12 @@ union bpf_attr {
>         struct { /* struct used by BPF_LINK_UPDATE command */
>                 __u32           link_fd;        /* link fd */
>                 /* new program fd to update link with */
> -               __u32           new_prog_fd;
> +               union {
> +                       /* new program fd to update link with */
> +                       __u32           new_prog_fd;
> +                       /* new struct_ops map fd to update link with */
> +                       __u32           new_map_fd;
> +               };
>                 __u32           flags;          /* extra flags */
>                 /* expected link's program fd; is specified only if
>                  * BPF_F_REPLACE flag is set in flags */
> --
> 2.34.1
>
