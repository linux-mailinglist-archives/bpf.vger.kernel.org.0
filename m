Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F26BF521
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCQW2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCQW2K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:28:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBB4391F
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:28:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so25907073edo.2
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679092086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VZ0FExpcHxm+1gmSqR9Uugjk8XPpU/i+K18YnWCubs=;
        b=NfmsuRAWDfMC8U65jsdhhkioXC0DifsuzQl55YJPBgSig8IEvTHkqLpulGWQnlcSdz
         zOVJTJgVQZuA62n0G0wehqBSKwmXVxqaIENTbCUDjNR7reUyFf2SawMX8T//CTUsFbKI
         693GXa09Pm2vEc8kzNIDybmoCXWrzZljI0k3uhqMP2zsV4QAQ5Sm0Lw8n1VkSK/rahXb
         rhsLDcyH4IkLmnFfIKcpCd03Rh+x7sDI3OJCCOEq4JihkQJ2X+ysjwQkv4J9zlR7AnmY
         8APwVun6q+56m2+99RGaPtb3V0TfhrC/OXarQTIOG93nxWjQILJBYNoOQ8iq+BkSq1Gs
         uODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679092086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VZ0FExpcHxm+1gmSqR9Uugjk8XPpU/i+K18YnWCubs=;
        b=kTKSe5SsvL5zyT5qlg80+WdYaOjwzLP1SPFWRlH2d0Mm1V4etYr84d7WdhRs05km5o
         I7ddeMhEzz6kSRTx7EgB3ON/g/IEBe/763jQAKPWBLCZto3TpNSA5aucXZOB46Pvs1me
         /WmsC/Ut58xRZDqvOAeS0n5qKiVxJx4f9iRCDBVcgkx99CAk5m2alPEvEH6iqV9RP8tr
         weHqx4Viou15f7gwijKwlyWe3SQH20y1DcqiVOLpkZhQnDMydT23fWxG59+p2NOEK9sN
         IjHckGYzvwLOeKVZIZ9cPzbiZqyDWs7eXAq+BxRBMU1IAm7q8b12H4AL0xwcGwIcjkpq
         nN4w==
X-Gm-Message-State: AO0yUKWdISlS7og1MQVirU8s6uxnUd12vPOyrm0B/P5X8cZ97ptllQoj
        WY7iUrARcGM7f78l0oXHvKCCQXmlyUwJxTeiECE=
X-Google-Smtp-Source: AK7set9hK3n1rzFkvxsAbYjL5zbOQ3n+huRmEt6tvIMYNAbw04kHK0O+aYBaWIKi8z06kwlG4InP9stXjoCDqzc2nM8=
X-Received: by 2002:a05:6402:5193:b0:4ad:739c:b38e with SMTP id
 q19-20020a056402519300b004ad739cb38emr3236939edd.1.1679092086150; Fri, 17 Mar
 2023 15:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230316023641.2092778-1-kuifeng@meta.com> <20230316023641.2092778-6-kuifeng@meta.com>
In-Reply-To: <20230316023641.2092778-6-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 15:27:54 -0700
Message-ID: <CAEf4BzY77ntrzDK+YdFY56hhLaR2Nh3UuvR9rMU68BCPXsc1bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/8] bpf: Update the struct_ops of a bpf_link.
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

On Wed, Mar 15, 2023 at 7:37=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
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
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       |  8 +++++--
>  kernel/bpf/bpf_struct_ops.c    | 38 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           | 20 ++++++++++++++++++
>  net/bpf/bpf_dummy_struct_ops.c |  6 ++++++
>  net/ipv4/bpf_tcp_ca.c          |  6 ++++++
>  tools/include/uapi/linux/bpf.h |  8 +++++--
>  7 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 455b14bf8f28..56e6ab7559ef 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1474,6 +1474,7 @@ struct bpf_link_ops {
>         void (*show_fdinfo)(const struct bpf_link *link, struct seq_file =
*seq);
>         int (*fill_link_info)(const struct bpf_link *link,
>                               struct bpf_link_info *info);
> +       int (*update_map)(struct bpf_link *link, struct bpf_map *new_map)=
;
>  };
>
>  struct bpf_tramp_link {
> @@ -1516,6 +1517,7 @@ struct bpf_struct_ops {
>                            void *kdata, const void *udata);
>         int (*reg)(void *kdata);
>         void (*unreg)(void *kdata);
> +       int (*update)(void *kdata, void *old_kdata);
>         int (*validate)(void *kdata);
>         const struct btf_type *type;
>         const struct btf_type *value_type;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 42f40ee083bf..24e1dec4ad97 100644
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
> index 8ce6c7581ca3..5a9e10b92423 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -807,10 +807,48 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
>         return 0;
>  }
>
> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map)
> +{
> +       struct bpf_struct_ops_map *st_map, *old_st_map;
> +       struct bpf_struct_ops_link *st_link;
> +       struct bpf_map *old_map;
> +       int err =3D 0;
> +
> +       st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> +       st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
> +
> +       if (!bpf_struct_ops_valid_to_reg(new_map))
> +               return -EINVAL;
> +
> +       mutex_lock(&update_mutex);
> +
> +       old_map =3D rcu_dereference_protected(st_link->map, lockdep_is_he=
ld(&update_mutex));
> +       old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, m=
ap);
> +       /* The new and old struct_ops must be the same type. */
> +       if (st_map->st_ops !=3D old_st_map->st_ops) {
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       err =3D st_map->st_ops->update(st_map->kvalue.data, old_st_map->k=
value.data);
> +       if (err)
> +               goto err_out;
> +
> +       bpf_map_inc(new_map);
> +       rcu_assign_pointer(st_link->map, new_map);
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
> index 5a45e3bf34e2..6fa10d108278 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4676,6 +4676,21 @@ static int link_create(union bpf_attr *attr, bpfpt=
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

I was expecting a check for the BPF_F_LINK flag here. Isn't it
necessary to verify that here?



> +
> +       ret =3D link->ops->update_map(link, new_map);
> +
> +       bpf_map_put(new_map);
> +       return ret;
> +}
> +
>  #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>

[...]
