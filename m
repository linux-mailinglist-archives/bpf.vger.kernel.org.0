Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B14FED1D
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 04:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiDMCpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 22:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDMCpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 22:45:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5932440919
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 19:43:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y5so295836ilg.4
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 19:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8nWYvkNmbu1s5VnI1Lyf9nO8TuxaN7MVTah2IggA5Q=;
        b=Px5BwbKmSxDBDELiwmVrw27zLZsnWPYI6FOvgPEDJ71CTvfwIpUAr567cXs/kI6ZYP
         9Nmph6zU2bCGI7hkUoNHEX1uOQfILWMStBl/Ugl3rR0fHSVShOcGh5PgHM7IdLaK1ElG
         buYxkrSb5mEsB5CE0rW31TGKaTaWDhiBCqjXeAXKHz0wmV+EKGufr3G2w+hSba2Tq3YR
         /KPbPa/FtNcTDOqHhQoUUUvA0rihAqNpZWdNIUex4ibGwseOy9PSEw2xJHvmKYyd/p5n
         7fx2LhhuFr+rW2zbSi8emhNoZWierNj2n+seg+bvjCmqcGdXwQBdhK+B7ZKlMFK/FhH8
         7yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8nWYvkNmbu1s5VnI1Lyf9nO8TuxaN7MVTah2IggA5Q=;
        b=Kxd5KJKjeC1FEqnI1M7Rq2CGWvvpDcl5A7VG2f8DEk0uq28UyQc2Uu3dZHcpouU9ph
         lmbXwG8pUiPGHMgaJ13ZDpWHPguHXZ1+HYi4V5ri4IcilVnjuXjf1VW3kpEZWy7I1mKY
         aTMGXiqRBLVOonKCjNJp5GDtYlAMrl5BLzbAfa3XQACzuU5WAc03DZLOujCz+LWbdRag
         vlDhtS2sDf5IoekmUIw9/sBoujWigSF/5s9IJoy97e0HloO9Tf85FnEVG06P8RFhazWj
         dWr8Cev4ZgytgVrkDmKSlfMwc6tADN0o0UralMZlBvdKBcFtXTHutY7Gru25qqV9lwpq
         RjYg==
X-Gm-Message-State: AOAM530Gjd6LiyTv5TlKr2Vyu+7p7oPktkuJrj3EfpOCeS0KlGsXsMYx
        uL4GNamb9KCJsFupWjfR0ixjrV3KSQCrvK5UrI8=
X-Google-Smtp-Source: ABdhPJybrr2w0u/TdZsLlkBX1xd80vBeeEz0EoiaafCNY79G2XauMGyKcYDHz7zLP5KDcZQ3Sntkzr/kmYAD7/qsiww=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr16761559ilb.305.1649817810740; Tue, 12
 Apr 2022 19:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220412165555.4146407-1-kuifeng@fb.com> <20220412165555.4146407-2-kuifeng@fb.com>
In-Reply-To: <20220412165555.4146407-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Apr 2022 19:43:19 -0700
Message-ID: <CAEf4BzapYFLns4iDiiRx9PpXftNDOc9jVswwcU_e3ncOeJSvMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Apr 12, 2022 at 9:56 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Replace struct bpf_tramp_progs with struct bpf_tramp_links to collect
> struct bpf_tramp_link(s) for a trampoline.  struct bpf_tramp_link
> extends bpf_link to act as a linked list node.
>
> arch_prepare_bpf_trampoline() accepts a struct bpf_tramp_links to
> collects all bpf_tramp_link(s) that a trampoline should call.
>
> Change BPF trampoline and bpf_struct_ops to pass bpf_tramp_links
> instead of bpf_tramp_progs.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Looks good, see two comments below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  arch/x86/net/bpf_jit_comp.c    | 36 +++++++++--------
>  include/linux/bpf.h            | 38 ++++++++++++------
>  include/linux/bpf_types.h      |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/bpf_struct_ops.c    | 69 ++++++++++++++++++++++----------
>  kernel/bpf/syscall.c           | 23 ++++-------
>  kernel/bpf/trampoline.c        | 73 +++++++++++++++++++---------------
>  net/bpf/bpf_dummy_struct_ops.c | 35 +++++++++++++---
>  tools/bpf/bpftool/link.c       |  1 +
>  tools/include/uapi/linux/bpf.h |  1 +
>  10 files changed, 175 insertions(+), 103 deletions(-)
>

[...]

>  /* Different use cases for BPF trampoline:
> @@ -704,7 +704,7 @@ struct bpf_tramp_progs {
>  struct bpf_tramp_image;
>  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
>                                 const struct btf_func_model *m, u32 flags,
> -                               struct bpf_tramp_progs *tprogs,
> +                               struct bpf_tramp_links *tlinks,
>                                 void *orig_call);
>  /* these two functions are called from generated trampoline */
>  u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
> @@ -803,9 +803,12 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
>  {
>         return bpf_func(ctx, insnsi);
>  }
> +
> +struct bpf_link;
> +

is this forward declaration still needed? was it supposed to be a
struct bpf_tramp_link instead? and also probably higher above, before
bpf_tramp_links?

>  #ifdef CONFIG_BPF_JIT
> -int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
> -int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
> +int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
> +int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
>  struct bpf_trampoline *bpf_trampoline_get(u64 key,
>                                           struct bpf_attach_target_info *tgt_info);
>  void bpf_trampoline_put(struct bpf_trampoline *tr);
> @@ -856,12 +859,12 @@ int bpf_jit_charge_modmem(u32 size);
>  void bpf_jit_uncharge_modmem(u32 size);
>  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
>  #else
> -static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
> +static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>                                            struct bpf_trampoline *tr)
>  {
>         return -ENOTSUPP;
>  }
> -static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
> +static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
>                                              struct bpf_trampoline *tr)
>  {
>         return -ENOTSUPP;
> @@ -960,7 +963,6 @@ struct bpf_prog_aux {
>         bool tail_call_reachable;
>         bool xdp_has_frags;
>         bool use_bpf_prog_pack;
> -       struct hlist_node tramp_hlist;
>         /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>         const struct btf_type *attach_func_proto;
>         /* function name for valid attach_btf_id */
> @@ -1047,6 +1049,18 @@ struct bpf_link_ops {
>                               struct bpf_link_info *info);
>  };
>
> +struct bpf_tramp_link {
> +       struct bpf_link link;
> +       struct hlist_node tramp_hlist;
> +};
> +
> +struct bpf_tracing_link {
> +       struct bpf_tramp_link link;
> +       enum bpf_attach_type attach_type;
> +       struct bpf_trampoline *trampoline;
> +       struct bpf_prog *tgt_prog;
> +};

struct bpf_tracing_link can stay in syscall.c, no? don't see anyone
needing it outside of syscall.c

> +
>  struct bpf_link_primer {
>         struct bpf_link *link;
>         struct file *file;
> @@ -1084,8 +1098,8 @@ bool bpf_struct_ops_get(const void *kdata);
>  void bpf_struct_ops_put(const void *kdata);
>  int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
>                                        void *value);
> -int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
> -                                     struct bpf_prog *prog,
> +int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
> +                                     struct bpf_tramp_link *link,
>                                       const struct btf_func_model *model,
>                                       void *image, void *image_end);

[...]
