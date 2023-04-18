Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9E6E6FB6
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDRW4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDRW4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:56:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E42D42
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:56:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id xi5so77104428ejb.13
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681858568; x=1684450568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPcsDZ/WZ2gQPL4o0i+j50ZUwGkWRlBB70mlpPs6sgM=;
        b=Z2eUmbfXCtYlouYFm+jar68PDzpVm0FAuuJRkPe8vYLl8QYByXdSI7d7DiRgGjUH9h
         iGfrZ6kmoBa6qmFvbcFXy2prQEDkCyAb6En2Kktr687l4a2Kf18U1QlXWO538SX8eFpI
         Aj/bi4rkBzFHLAaiP0Nc1ixR1M+0s3s4V42Fz472PhLgomi1QJkKNCCYlfEBdr/kUzod
         hjnKmBLCXX3JNHooaszMjjMKmYVySO4eNMhFYVVPPMnjoVT63vmOQuq8j5eG/6WXFlr4
         RD9uksyxCnJJ6N1M5d+xJu22/LHT6ecs/lAl8V05sF9i4FgysJQGwlboRg5Q9fH+O9l8
         9T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858568; x=1684450568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPcsDZ/WZ2gQPL4o0i+j50ZUwGkWRlBB70mlpPs6sgM=;
        b=WdpTKvHJvFeAF5mOb/V23HYoG680P6ajrBJSAR5yYndpTdjIDCYs60C2NwjasyV0Ah
         dt79PGLsv2W61GASKdVSs6u5FNngtMPzIW5/kYJlAiUq11FherKfmjL0vCkS9FjENoT/
         kKl8yV/xPtjxx/gJ+vdhhouxmWWWSIDebqGIva/IQCYYRGZRuze3ShWCmqUMzZJZfS1P
         mQVC4z0yGNoG75w55oGkXDJhMCNZpxAzIz6RjbT7SLbBlCVXB4FUb8SVTMsuN/UV7rYv
         cohvcf30by9a0GuwVFKIxS9VqhfrwCY2yppz7UEZtUDTmnbRH08CkYZq4qMQKoyhm2iP
         sUaQ==
X-Gm-Message-State: AAQBX9cKKtLsyGz5pkSxs/mq/C6UHcbamT61mYu+AAp9deAtNbpClV1I
        R2/izSy3nT3ChJMh52ftvepRksjI+Kl5km2P/at1uA==
X-Google-Smtp-Source: AKy350YfddnlEcWavcI3cFWRZdQIMusNG8e2Rc7lTqE4fPsb+i2XvwnGxzuyJslxy8rrui9ljdKKjv0pl12gowwKMgk=
X-Received: by 2002:a17:906:35d5:b0:94e:4c8f:758 with SMTP id
 p21-20020a17090635d500b0094e4c8f0758mr11490929ejb.76.1681858568515; Tue, 18
 Apr 2023 15:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230418200058.603169-1-kuifeng@meta.com>
In-Reply-To: <20230418200058.603169-1-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 18 Apr 2023 23:55:57 +0100
Message-ID: <CACdoK4LU6Zh341YYQTgsciRhfMZYP--+_mY_=+HfBW7hBFmF7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Register struct_ops with a link.
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

On Tue, 18 Apr 2023 at 21:01, Kui-Feng Lee <thinker.li@gmail.com> wrote:
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
> ---
>  tools/bpf/bpftool/struct_ops.c | 86 ++++++++++++++++++++++++++++------
>  1 file changed, 72 insertions(+), 14 deletions(-)
>
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index b389f4830e11..d1ae39f9d8df 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -475,21 +475,62 @@ static int do_unregister(int argc, char **argv)
>         return cmd_retval(&res, true);
>  }
>
> +static int pathname_concat(char *buf, int buf_sz, const char *path,
> +                          const char *name)
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

This is nearly identical to the one in prog.c. If we do need this, we
should move it to common.c and reuse it.

> +
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
> +       const char *pindir = NULL;
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
> +               pindir = GET_ARG();
> +
> +       if (pindir && mount_bpffs_for_pin(pindir)) {
> +               p_err("can't mount bpffs for pinning");
> +               return -1;
> +       }
>
>         if (verifier_logs)
>                 /* log_level1 + log_level2 + stats, but not stable UAPI */
> @@ -519,21 +560,38 @@ static int do_register(int argc, char **argv)
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
> -                       p_info("Registered %s but can't find id: %s",
> -                              bpf_map__name(map), strerror(errno));
> +                       p_err("Registered %s but can't find id: %s",
> +                             bpf_map__name(map), strerror(errno));

See comment right above: p_info() is probably enough here. If for some
reason we do need to switch to an error message and change the
existing behaviour, can you please motivate it and make it a separate
commit (and update the comment)?

> +                       nr_errs++;
> +               } else if (!(bpf_map__map_flags(map) & BPF_F_LINK)) {
> +                       p_info("Registered %s %s id %u",
> +                              get_kern_struct_ops_name(&info),
> +                              info.name,
> +                              info.id);
> +               } else if (bpf_link_get_info_by_fd(bpf_link__fd(link),
> +                                                  &link_info,
> +                                           &link_info_len)) {
> +                       p_err("Registered %s but can't find link id: %s",
> +                             bpf_map__name(map), strerror(errno));
> +                       nr_errs++;
> +               } else if (pindir && pin_link(link, pindir, info.name)) {

Why do we have "pindir" and not a pinned path? Instead of taking a
directory name to concatenate, why not let the user specify the pinned
path directly, as we do for maps, programs, and links already? The
only existing use of dirname + concat I can think of is for "bpftool
prog loadall", but this is because we need one path to pin multiple
programs. Here we just have one, so let the user choose their path?

I would also avoid using "pin" too much in variable or function names.
I know we have "bpf_link__pin()", but I find it makes things confusing
between the concepts of pinned objects (through BPF_OBJ_PIN) and of
BPF links. How about "linkdir" or "linkpath" instead?

> +                       p_err("can't pin link %u for %s: %s",
> +                             link_info.id, info.name,
> +                             strerror(errno));
> +                       nr_errs++;
> +               } else
> +                       p_info("Registered %s %s map id %u link id %u",
> +                              get_kern_struct_ops_name(&info),
> +                              info.name, info.id, link_info.id);

Missing curly brackets on the "else" block.

I find it not easy to follow the logic in this long "else if..."
chain, it would probably feel more natural with simple "if"s and some
"goto"s to reach the bpf_link__disconnect() call below. But maybe this
is just me.

> +
> +               bpf_link__disconnect(link);
> +               bpf_link__destroy(link);
> +

Nit: We don't need this empty line.

>         }
>
>         bpf_object__close(obj);
> @@ -562,7 +620,7 @@ static int do_help(int argc, char **argv)
>         fprintf(stderr,
>                 "Usage: %1$s %2$s { show | list } [STRUCT_OPS_MAP]\n"
>                 "       %1$s %2$s dump [STRUCT_OPS_MAP]\n"
> -               "       %1$s %2$s register OBJ\n"
> +               "       %1$s %2$s register OBJ [PATH]\n"

This is not enough to understand what PATH means here. I'd use
something like "LINK_DIR", or preferably "LINK_PATH" if we let users
specify the full path. And we need to update the
bpftool-struct_ops.rst man page (under bpftool's Documentation/) to
explain what this optional argument is for, can you please take care
of this?

We usually have to update the bash completion too, but it seems that
it offers filenames multiple times already after "bpftool struct_ops
register", which is not intentional but covers completion for the new
argument.

>                 "       %1$s %2$s unregister STRUCT_OPS_MAP\n"
>                 "       %1$s %2$s help\n"
>                 "\n"
> --
> 2.34.1
>
