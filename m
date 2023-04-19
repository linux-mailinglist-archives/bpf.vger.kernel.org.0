Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55D6E8603
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 01:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDSXlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 19:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSXlE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 19:41:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3EA30C0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 16:41:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5068e99960fso423839a12.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681947661; x=1684539661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oo0lKspZle1ingLoDhMUgtdXpOsNryz5/XV8SINQJyM=;
        b=ish149cRTOSQt/p+6gjrPVIb82WwbVZS4mvmEAmGnDKL3XlU2EACwcKuJE8dm0IOmh
         bPra1MxfQiE9lpGJZHcJmzNttDZirxrM2+PG8yJxAPE+ROOUMcYXxQIYJUryJJ+t1qvV
         nxOdO1NqDvgXL1dAg8HPihkJX4YVYxOwTi6S10xxgYxWH8y9S9CuzAGOkmWdZ0GoV3uU
         qzp7PNfHPBc9yY3jHOVR5nWxTuU5j5ss222N88cxje+2cy5pTo+cUh/gEkPm7iaA5pl8
         f5cjOaEIn+ljDSpDvyt8HuthIMShaLV0Qk3Y3m/xl+R7BZc9A0+nhTJN//Bv9LIOUbRM
         +fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681947661; x=1684539661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo0lKspZle1ingLoDhMUgtdXpOsNryz5/XV8SINQJyM=;
        b=UgKhnkadcddCPIQNbhnnriVNjFiLqof11XiCv1m08PnUbw9p9ozhdDDgSWUquCgT1J
         klGuV7EQdKUJ3Ghh2WB16wXwBWaAjoinUW1ULF+9QESMTWz3H4dP1qqMI/fuur/tngr3
         VlcDEev/rvjYzUCbBQAQwkVUTIK+X7TuASiOdwPq8j7fjnsFqB/WFXSHhFZkJxYurrl6
         NJpP2up35cZIZGjfDJ5Z66GW+JruofvC51sTJzKz3MaJs9fYqm2qB3NLnk453SfX1DQy
         g3mBNXPc4a8peC4hUJGjBt4fjlTlaJIAKLJBA5XhQokupibz97CSUMPLpbf00dnzStje
         etHA==
X-Gm-Message-State: AAQBX9fgHO7So5ShsoVKRTX952jnIX62Ocbmbl1jks1QmTdrgxXcum37
        EYzwz5tyRqV9jjexHlruiydldA3+EJ95P6FOhYvJMg==
X-Google-Smtp-Source: AKy350Y8fIo3GWKAHjoUgSiOwMUhQQ6rI4TojGTnnQcTo+iafLp5n6GsxEz4EfMh23RCetOMe21TNoWt+sE0wD+vZeY=
X-Received: by 2002:aa7:dad8:0:b0:506:905b:816d with SMTP id
 x24-20020aa7dad8000000b00506905b816dmr8494385eds.6.1681947661379; Wed, 19 Apr
 2023 16:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230419025625.1289594-1-kuifeng@meta.com>
In-Reply-To: <20230419025625.1289594-1-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 20 Apr 2023 00:40:50 +0100
Message-ID: <CACdoK4+xMGOoN_id2NVBDmYjxLCi_JY40UpmuBiadEUWi-u0ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Register struct_ops with a link.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Apr 2023 at 03:56, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>
> You can include an optional path after specifying the object name for the
> 'struct_ops register' subcommand.
>
> Since the commit 226bc6ae6405 ("Merge branch 'Transit between BPF TCP
> congestion controls.'") has been accepted, it is now possible to create a
> link for a struct_ops. This can be done by defining a struct_ops in
> SEC(".struct_ops.link") to make libbpf returns a real link. If we don't pin
> the links before leaving bpftool, they will disappear. To instruct bpftool
> to pin the links in a directory with the names of the maps, we need to
> provide the path of that directory.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Right I'd forgotten we could register several struct_ops at once with
the command. OK then, makes sense to pass a directory and pin with the
existing names in that case.

This patch looks all good, apart from a few indent nitpicks.

> ---
>  tools/bpf/bpftool/common.c     | 14 +++++++
>  tools/bpf/bpftool/main.h       |  3 ++
>  tools/bpf/bpftool/prog.c       | 13 ------
>  tools/bpf/bpftool/struct_ops.c | 76 ++++++++++++++++++++++++++++------
>  4 files changed, 80 insertions(+), 26 deletions(-)
>
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 5a73ccf14332..1360c82ae732 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1091,3 +1091,17 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>         default:        return libbpf_bpf_attach_type_str(t);
>         }
>  }
> +
> +int pathname_concat(char *buf, int buf_sz, const char *path,
> +                   const char *name)
> +{
> +       int len;
> +
> +       len = snprintf(buf, buf_sz, "%s/%s", path, name);
> +       if (len < 0)
> +               return -EINVAL;
> +       if (len >= buf_sz)
> +               return -ENAMETOOLONG;
> +
> +       return 0;
> +}
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..f09853f24422 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -262,4 +262,7 @@ static inline bool hashmap__empty(struct hashmap *map)
>         return map ? hashmap__size(map) == 0 : true;
>  }
>
> +int pathname_concat(char *buf, int buf_sz, const char *path,
> +                   const char *name);
> +
>  #endif
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index afbe3ec342c8..6024b7316875 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1472,19 +1472,6 @@ auto_attach_program(struct bpf_program *prog, const char *path)
>         return err;
>  }
>
> -static int pathname_concat(char *buf, size_t buf_sz, const char *path, const char *name)
> -{
> -       int len;
> -
> -       len = snprintf(buf, buf_sz, "%s/%s", path, name);
> -       if (len < 0)
> -               return -EINVAL;
> -       if ((size_t)len >= buf_sz)
> -               return -ENAMETOOLONG;
> -
> -       return 0;
> -}
> -
>  static int
>  auto_attach_programs(struct bpf_object *obj, const char *path)
>  {
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index b389f4830e11..41643756e400 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -475,21 +475,48 @@ static int do_unregister(int argc, char **argv)
>         return cmd_retval(&res, true);
>  }
>
> +static int pin_link(struct bpf_link *link, const char *pindir,
> +                   const char *name)
> +{
> +       char pinfile[PATH_MAX];
> +       int err;
> +
> +       err = pathname_concat(pinfile, sizeof(pinfile), pindir, name);
> +       if (err)
> +               return -1;
> +
> +       err = bpf_link__pin(link, pinfile);
> +       if (err)
> +               return -1;

"return bpf_link__pin(link, pinfile);" would work as well. But I don't
mind much.

> +
> +       return 0;
> +}
> +
>  static int do_register(int argc, char **argv)
>  {
>         LIBBPF_OPTS(bpf_object_open_opts, open_opts);
> +       __u32 link_info_len = sizeof(struct bpf_link_info);
> +       struct bpf_link_info link_info = {};
>         struct bpf_map_info info = {};
>         __u32 info_len = sizeof(info);
>         int nr_errs = 0, nr_maps = 0;
> +       const char *linkdir = NULL;
>         struct bpf_object *obj;
>         struct bpf_link *link;
>         struct bpf_map *map;
>         const char *file;
>
> -       if (argc != 1)
> +       if (argc != 1 && argc != 2)
>                 usage();
>
>         file = GET_ARG();
> +       if (argc == 1)
> +               linkdir = GET_ARG();
> +
> +       if (linkdir && mount_bpffs_for_pin(linkdir)) {
> +               p_err("can't mount bpffs for pinning");
> +               return -1;
> +       }
>
>         if (verifier_logs)
>                 /* log_level1 + log_level2 + stats, but not stable UAPI */
> @@ -519,21 +546,44 @@ static int do_register(int argc, char **argv)
>                 }
>                 nr_maps++;
>
> -               bpf_link__disconnect(link);
> -               bpf_link__destroy(link);
> -
> -               if (!bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
> -                                           &info_len))
> -                       p_info("Registered %s %s id %u",
> -                              get_kern_struct_ops_name(&info),
> -                              bpf_map__name(map),
> -                              info.id);
> -               else
> +               if (bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
> +                                          &info_len)) {
>                         /* Not p_err.  The struct_ops was attached
>                          * successfully.
>                          */
>                         p_info("Registered %s but can't find id: %s",
> -                              bpf_map__name(map), strerror(errno));
> +                             bpf_map__name(map), strerror(errno));

I think the indent was correct and this change results from your
previous version with "p_err()"?

> +                       goto clean_link;
> +               }
> +               if (!(bpf_map__map_flags(map) & BPF_F_LINK)) {
> +                       p_info("Registered %s %s id %u",
> +                              get_kern_struct_ops_name(&info),
> +                              info.name,
> +                              info.id);
> +                       goto clean_link;
> +               }
> +               if (bpf_link_get_info_by_fd(bpf_link__fd(link),
> +                                                  &link_info,

Please fix the indent.

> +                                           &link_info_len)) {
> +                       p_err("Registered %s but can't find link id: %s",
> +                             bpf_map__name(map), strerror(errno));
> +                       nr_errs++;
> +                       goto clean_link;
> +               }
> +               if (linkdir && pin_link(link, linkdir, info.name)) {
> +                       p_err("can't pin link %u for %s: %s",
> +                             link_info.id, info.name,
> +                             strerror(errno));
> +                       nr_errs++;
> +                       goto clean_link;
> +               }
> +               p_info("Registered %s %s map id %u link id %u",
> +                      get_kern_struct_ops_name(&info),
> +                      info.name, info.id, link_info.id);
> +
> +clean_link:
> +               bpf_link__disconnect(link);
> +               bpf_link__destroy(link);
>         }
>
>         bpf_object__close(obj);
> @@ -562,7 +612,7 @@ static int do_help(int argc, char **argv)
>         fprintf(stderr,
>                 "Usage: %1$s %2$s { show | list } [STRUCT_OPS_MAP]\n"
>                 "       %1$s %2$s dump [STRUCT_OPS_MAP]\n"
> -               "       %1$s %2$s register OBJ\n"
> +               "       %1$s %2$s register OBJ [LINK_DIR]\n"
>                 "       %1$s %2$s unregister STRUCT_OPS_MAP\n"
>                 "       %1$s %2$s help\n"
>                 "\n"
> --
> 2.34.1
>
