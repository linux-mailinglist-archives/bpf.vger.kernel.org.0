Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85B46081C1
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJUWif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJUWie (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:38:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03172AD33A
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:38:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m15so10982719edb.13
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ij/ckQotpqlQbT9zoXwvDWVVGTexTV0eAQxuV4TghE=;
        b=Qc08bpdhwlN4Ko3ja+3wlA3H3KqG+fFFX7Ttx4zWIG7PfHGSWjRcVomKH9XyOBJPT3
         /fz2pMMftnn9ZtJQPXqe4LpBW2TuQhR02qsQ08cydQR12bZJP3pM1AZEtX5L6Y78Edbw
         C0yVkZ2pB9qCJfSQU7VxmVcX5NWrZ8X/TOf4n3R1OiK88U54pdTFRoQ4P0Qv9vSC5RVx
         kSQfJM+YWHKb2fvDYcPQsCwHtvMHAggZ2AfAvopv/kSnGg+iPceaFQ9RWOI23gg40AsO
         qZ0WNwwMEYoAq9xLSomg6yi1ikAWOgYBbV9Od6x1XYk9zC9P0RbgSNZjSoCFgWUSu2hP
         F2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ij/ckQotpqlQbT9zoXwvDWVVGTexTV0eAQxuV4TghE=;
        b=H+ptQ7E70RHdstxtynaluyNbd3XpVi/DsKqkmFoFyfEeROa1jkWZkHYPD5cnmxq0L1
         G75onUakpcJaLHrvzNLBSYIP+ubTZMZWNaIuR+/n3BIf9fzrC9TSvHs37207qwQdCqZf
         CaarQuwpn8rCt6KAubbtH0UqIRaAb/eBVAl521POdU7pYADMfzuUzb8l84jSNCWq5zFr
         ZPOj93t45ER4siWPMz1CEALQ8HynF2pGBM7DLMHceG7JbKA+JqS7jJaGmlcL1q0mdPCt
         CbXUD5PO2ZCx4AYZvimqUm2/JewRxP0NFWOxRyYxfRUBkQjkQths8mVSPB6ShdJSmXfg
         Su+w==
X-Gm-Message-State: ACrzQf2V0JB0j2BzauVmGKtdalEITZgkNRVknzdaPBbfT0jC+2q8a5ma
        aYz1v11t7251dOnTzdxSgS8cBWfefTptFPEeToQ=
X-Google-Smtp-Source: AMsMyM4UudiRRkBR/vqrpcCtMh+PL9zAXROHsw5opqLtgKb9aWb6fIXc5tJYFeCRqCD7nAQpUWEFRqmob/fS6QCrqYI=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr8409838edq.14.1666391912147; Fri, 21 Oct
 2022 15:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221020123704.91203-1-quentin@isovalent.com> <20221020123704.91203-9-quentin@isovalent.com>
In-Reply-To: <20221020123704.91203-9-quentin@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 15:38:20 -0700
Message-ID: <CAEf4BzYc5iw62Ga+9jDMJc9g9xv85SyarJxxX6nbwSz977zr5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] bpftool: Add llvm feature to "bpftool version"
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
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

On Thu, Oct 20, 2022 at 5:37 AM Quentin Monnet <quentin@isovalent.com> wrot=
e:
>
> Similarly to "libbfd", add a "llvm" feature to the output of command
> "bpftool version" to indicate that LLVM is used for disassembling JIT-ed
> programs. This feature is mutually exclusive with "libbfd".
>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Tested-by: Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> Note: There's a conflict on this change with the patch at
> https://lore.kernel.org/bpf/20221020100332.69563-1-quentin@isovalent.com/
> Supposiing both are accepted, I will of course rebase one or the other,
> accordingly.
> ---
>  tools/bpf/bpftool/Documentation/common_options.rst |  8 ++++----
>  tools/bpf/bpftool/main.c                           | 10 ++++++++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/b=
pf/bpftool/Documentation/common_options.rst
> index 4107a586b68b..05350a1aadf9 100644
> --- a/tools/bpf/bpftool/Documentation/common_options.rst
> +++ b/tools/bpf/bpftool/Documentation/common_options.rst
> @@ -7,10 +7,10 @@
>           Print bpftool's version number (similar to **bpftool version**)=
, the
>           number of the libbpf version in use, and optional features that=
 were
>           included when bpftool was compiled. Optional features include l=
inking
> -         against libbfd to provide the disassembler for JIT-ted programs
> -         (**bpftool prog dump jited**) and usage of BPF skeletons (some
> -         features like **bpftool prog profile** or showing pids associat=
ed to
> -         BPF objects may rely on it).
> +         against LLVM or libbfd to provide the disassembler for JIT-ted
> +         programs (**bpftool prog dump jited**) and usage of BPF skeleto=
ns
> +         (some features like **bpftool prog profile** or showing pids
> +         associated to BPF objects may rely on it).
>
>  -j, --json
>           Generate JSON output. For commands that cannot produce JSON, th=
is
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index ccd7457f92bf..7e06ca2c5d42 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -89,6 +89,11 @@ static int do_version(int argc, char **argv)
>  #else
>         const bool has_libbfd =3D false;
>  #endif
> +#ifdef HAVE_LLVM_SUPPORT
> +       const bool has_llvm =3D true;
> +#else
> +       const bool has_llvm =3D false;
> +#endif
>  #ifdef BPFTOOL_WITHOUT_SKELETONS
>         const bool has_skeletons =3D false;
>  #else
> @@ -112,6 +117,7 @@ static int do_version(int argc, char **argv)
>                 jsonw_name(json_wtr, "features");
>                 jsonw_start_object(json_wtr);   /* features */
>                 jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
> +               jsonw_bool_field(json_wtr, "llvm", has_llvm);
>                 jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbp=
f);
>                 jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
>                 jsonw_end_object(json_wtr);     /* features */
> @@ -132,6 +138,10 @@ static int do_version(int argc, char **argv)
>                         printf(" libbfd");
>                         nb_features++;
>                 }
> +               if (has_llvm) {
> +                       printf(" llvm");
> +                       nb_features++;
> +               }
>                 if (!legacy_libbpf) {

completely unrelated to your patch set, but we don't have legacy
libbpf anymore, right? let's clean this part up (separately from this
patch set, of course)?


>                         printf("%s libbpf_strict", nb_features++ ? "," : =
"");
>                         nb_features++;
> --
> 2.34.1
>
