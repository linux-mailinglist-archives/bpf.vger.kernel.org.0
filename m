Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B801D4CB5E9
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiCCEeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCCEeJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:34:09 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BDF9FBD
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:33:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id f2so3121665ilq.1
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndyZcj5NKcvqu9sMH+UPWzpk0/5lnw3OPaOJzgWF7vg=;
        b=CrzSBOKQCW134fkr9qKZvwFdnTD2pVNTZemeKerlPYPlxqapFORey3ILBV9p4tD4nm
         PtEFue37fnVNhwCxckWkjeuor95xc9YHkbkYYowqPFUHGogYQeud34nPwLRkiJrwElId
         uDgmXPx3gktdIRhC8ADdZlfSXCnRjZgu8otM58ZAIjMZJ0iQbogS2LBTHxPlCeWToAxv
         utQ+hxYpZfjWgtItFNADoARAc47BBaKvnBZ9jTp1faKdt06QMK+OVNyTakA9S/8STcgT
         MPNwHY6ooRxoeMmYXoo+MGWIzNtMyMOSnp5ZDHWpB3Ks6FSppHxV24qYQUAepGTCusBx
         320w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndyZcj5NKcvqu9sMH+UPWzpk0/5lnw3OPaOJzgWF7vg=;
        b=fROGG7gcMBuaWOFh6/CGDSHbbbf6mYTCieI47WNhVVTK/yfYIC2ERj1Wlo/mjlEoh1
         XxfGUKb7mNGgtl9QFUecmyCdDMgrItOo8eEK8Wp11oecuh8dLPiILbwDsADavJiIteRZ
         jqnNRtwecaOb9uNdrEFvkn0/7seEWwrfiTR0Z18nagT6mjXPFr/5AJNY3kODvUIJnotA
         IPI3heCjzmg87hSgAsGfRBja5xvQqumlN+j1R7ptHwzLRdFZCEA9cI9FGgP52B2Gg7kk
         cb2XpnL9zFPNA6DiwrciC5AdKJTkxQJiqSiXC3ri3k4GaQn6a3fgLtFMUp6dnCf6XUnd
         zeBw==
X-Gm-Message-State: AOAM531pRfL/L82AO93T0orM7JOL4cnlHts/xuUQVsMxTCb3oZIEupGt
        dOihOdzEX3R/TMzCmRcUcKS7MJu8zeAytLnkziG2iB2o19xPbg==
X-Google-Smtp-Source: ABdhPJy3oqVJvN30FU1pt9aSttun3cGG9XqnD9oQkX6EEP7WcN1s04Zl0z1sicnOBW1YVkwKKtUqS1/f6Q6ua9EftAY=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr30741202ilb.305.1646282003850; Wed, 02
 Mar 2022 20:33:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
In-Reply-To: <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Mar 2022 20:33:12 -0800
Message-ID: <CAEf4Bza55GsV1oZa=d9UuscNerMsvFPtXSTQ9qr8mrxPQVu7QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 1, 2022 at 6:49 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> In symmetry with bpf_object__open_skeleton(),
> bpf_object__open_subskeleton() performs the actual walking and linking
> of symbols described by bpf_sym_skeleton objects.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c   | 76 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 21 +++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 99 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d20ae8f225ee..e6c27f4b9dea 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11748,6 +11748,82 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
>         return 0;
>  }
>
> +int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
> +{
> +       int i, len, map_type_id, sym_idx;
> +       const char *var_name;
> +       struct bpf_map *map;
> +       struct btf *btf;
> +       const struct btf_type *map_type, *var_type;
> +       const struct bpf_sym_skeleton *sym;
> +       struct btf_var_secinfo *var;
> +       struct bpf_map *last_map = NULL;
> +       const struct btf_type *last_map_type = NULL;
> +
> +       if (!s->obj)
> +               return libbpf_err(-EINVAL);
> +
> +       btf = bpf_object__btf(s->obj);
> +       if (!btf)
> +               return libbpf_err(errno);

-errno

> +
> +       for (sym_idx = 0; sym_idx < s->sym_cnt; sym_idx++) {
> +               sym = &s->syms[sym_idx];
> +               if (last_map && (strcmp(sym->section, bpf_map__section_name(last_map)) == 0)) {

see above about having struct bpf_map ** instead of sym->section

> +                       map = last_map;
> +                       map_type = last_map_type;
> +               } else {
> +                       map = bpf_object__find_map_by_name(s->obj, sym->section);
> +                       if (!map) {
> +                               pr_warn("Could not find map for section %1$s, symbol %2$s",
> +                                       sym->section, s->syms[i].name);
> +                               return libbpf_err(-EINVAL);
> +                       }
> +                       map_type_id = btf__find_by_name_kind(btf, sym->section, BTF_KIND_DATASEC);

bpf_map__btf_value_type_id() ?

> +                       if (map_type_id < 0) {
> +                               pr_warn("Could not find map type in btf for section %1$s (due to symbol %2$s)",
> +                                       sym->section, sym->name);
> +                               return libbpf_err(-EINVAL);
> +                       }
> +                       map_type = btf__type_by_id(btf, map_type_id);
> +               }
> +

[...]

> +
> +void bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s)
> +{
> +       if (!s)
> +               return;
> +       if (s->syms)
> +               free(s->syms);

no need to check s->syms, free handles NULL just fine

> +       free(s);
> +}
> +
>  int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
>  {
>         int i, err;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 7b66794f1c0a..915d59c31ad5 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1291,6 +1291,27 @@ LIBBPF_API int bpf_object__attach_skeleton(struct bpf_object_skeleton *s);
>  LIBBPF_API void bpf_object__detach_skeleton(struct bpf_object_skeleton *s);
>  LIBBPF_API void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s);
>
> +struct bpf_sym_skeleton {

I tried to get used to this "sym" terminology for a bit, but it still
feels off. From user's perspective all this are variables. Any
objections to use "var" terminology?

> +       const char *name;
> +       const char *section;

what if we store a pointer to struct bpf_map * instead, that way we
won't need to search, we'll just have a pointer ready

> +       void **addr;
> +};
> +
> +struct bpf_object_subskeleton {
> +       size_t sz; /* size of this struct, for forward/backward compatibility */
> +
> +       const struct bpf_object *obj;
> +
> +       int sym_cnt;
> +       int sym_skel_sz;
> +       struct bpf_sym_skeleton *syms;

as mentioned in previous patch, let's also record maps and prog, it is
important and needed from the very beginning

> +};
> +
> +LIBBPF_API int
> +bpf_object__open_subskeleton(struct bpf_object_subskeleton *s);
> +LIBBPF_API void
> +bpf_object__destroy_subskeleton(struct bpf_object_subskeleton *s);
> +
>  struct gen_loader_opts {
>         size_t sz; /* size of this struct, for forward/backward compatiblity */
>         const char *data;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 5c85d297d955..81a1d0259866 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -443,4 +443,6 @@ LIBBPF_0.7.0 {
>  LIBBPF_0.8.0 {
>         global:
>      bpf_map__section_name;
> +    bpf_object__open_subskeleton;
> +    bpf_object__destroy_subskeleton;

indentation looks off here... global should be indented with one tab,
and then APIs with two tabs

>  } LIBBPF_0.7.0;
> --
> 2.34.1
