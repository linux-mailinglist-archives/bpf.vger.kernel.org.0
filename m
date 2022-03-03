Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25664CB434
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 02:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiCCBN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 20:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 20:13:57 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6B10FFC
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 17:13:11 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id b5so178812ilj.9
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 17:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlXrgNTs7cq4l98v3br6LcUIA/DHp0eAzOl/+9GDnNQ=;
        b=JKOtb8Aa5/2unOtGi0a3Oa0zcHyZsU1Mu21huR0bMB8kjLnI0wOywhqZ1eBZgvuFmn
         gOwchrFyJex6lxNOzl8MTz+kz5h3Gd2+s8H4NJsPgj2/Yz5T0x0hzFA00ci2/qPdJx0Y
         NR5wi47FcMwHFuYQ3r8lOKdx0ljvt4OhcW83UtpugThcd/JMyk6cYAv9gmww3L7kX7/j
         nJIK5CWPIczjWbh6dI32EGgnR1yODh0MzCr0UNQg9McfCdYEmoIAcsEvsnBAM8c32ymj
         KsuTTwLhY1QlJ+CsjM7Jb8i3PEDe6ef4YwhfYtYVQHN1jIY7EKhL+bp3FZLFEwP3XCSs
         WY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlXrgNTs7cq4l98v3br6LcUIA/DHp0eAzOl/+9GDnNQ=;
        b=IcycvWjszqpwl/Pc9tpdmWUYnlng0z2GQC0QGod6rYrahRwHutSq1CaFYU13zKYzdQ
         XFmDPPQ/12QbILL2qB5JqT2uSGK6kHPhoZUj7A0D9OHYs1T6cJ7rQPYujTdIXlJhhEGT
         hO+ovWFW0HtFhPEAZ9Ka7ncKnTSf3VGa0+OqbZaWucbxKNBczXSJSZVfM4VV2n2HQBmr
         tEoA1mqJiw6bELpGL1/FOsEid4uKpXYdV7kibK3xkLdJokbSiLw2r8/uJEqN2B0HsqxP
         19lxR7kZ8scmHpZ964lSfoR3cjtKi/Z/WkcJ0RjKWal68TIQdSfatcnA3o5YOVZLd8ae
         BEoQ==
X-Gm-Message-State: AOAM531SFvhs5UK3cOTX2QuDRZFSpWRQ4zhvpLpeU/yUHLYVclOT82yp
        Waot2AV+xNjqp1uQ1yUgSA3x3FutJ4NTURecqOc=
X-Google-Smtp-Source: ABdhPJyXt3dbB/cHUaA4a/2B5diNj7b3pLf71h4BDhaul5tDskxZUbhDOL7UyyP40jThzHeSLx7ObEIPNbF5AyXJLZQ=
X-Received: by 2002:a92:c148:0:b0:2c2:615a:49e9 with SMTP id
 b8-20020a92c148000000b002c2615a49e9mr29775987ilh.98.1646269991332; Wed, 02
 Mar 2022 17:13:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <c298c45f77ba2fc12fb54da5ea73b5a4dfbfe763.1646188795.git.delyank@fb.com>
In-Reply-To: <c298c45f77ba2fc12fb54da5ea73b5a4dfbfe763.1646188795.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Mar 2022 17:13:00 -0800
Message-ID: <CAEf4BzYqYZW_tioR+hH6_hZb3N4kgEbDvuShUngrJ-9k=tKD0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] libbpf: expose map elf section name
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
> When generating subskeletons, bpftool needs to know the elf section
> name, as that's the stable identifier that will survive into the final
> linked bpf_object.
>
> This patch adds bpf_map__section_name in symmetry with
> bpf_program__section_name.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c         | 8 ++++++++
>  tools/lib/bpf/libbpf.h         | 2 ++
>  tools/lib/bpf/libbpf.map       | 5 +++++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index be6480e260c4..d20ae8f225ee 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9180,6 +9180,14 @@ const char *bpf_map__name(const struct bpf_map *map)
>         return map->name;
>  }
>
> +const char *bpf_map__section_name(const struct bpf_map *map)
> +{
> +       if (!map)
> +               return NULL;
> +
> +       return map->real_name;
> +}
> +

First, "section_name" here is extremely confusing in the face of
bpf_program__section_name() which returns a very different thing for
BPF program. But I think we shouldn't need to do anything extra here.
Using bpf_map__name() and then bpf_object__find_map_by_name() should
just work (there is real_name special-handling for maps that start
with dot). If that real_name special handling doesn't work for
subskeletons, we should fix that special handling instead of adding a
special getter. But I'll need to look at other patches first and maybe
play around locally with subskeletons.


>  enum bpf_map_type bpf_map__type(const struct bpf_map *map)
>  {
>         return map->def.type;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index c8d8daad212e..7b66794f1c0a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -741,6 +741,8 @@ LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "use appropriate getters or setters ins
>  const struct bpf_map_def *bpf_map__def(const struct bpf_map *map);
>  /* get map name */
>  LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
> +/* get map ELF section name */
> +LIBBPF_API const char *bpf_map__section_name(const struct bpf_map *map);
>  /* get/set map type */
>  LIBBPF_API enum bpf_map_type bpf_map__type(const struct bpf_map *map);
>  LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 47e70c9058d9..5c85d297d955 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -439,3 +439,8 @@ LIBBPF_0.7.0 {
>                 libbpf_probe_bpf_prog_type;
>                 libbpf_set_memlock_rlim_max;
>  } LIBBPF_0.6.0;
> +
> +LIBBPF_0.8.0 {
> +       global:
> +    bpf_map__section_name;
> +} LIBBPF_0.7.0;
> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
> index 0fefefc3500b..61f2039404b6 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>
>  #define LIBBPF_MAJOR_VERSION 0
> -#define LIBBPF_MINOR_VERSION 7
> +#define LIBBPF_MINOR_VERSION 8
>
>  #endif /* __LIBBPF_VERSION_H */
> --
> 2.34.1
