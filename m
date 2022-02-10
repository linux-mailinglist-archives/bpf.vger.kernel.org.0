Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C664B1844
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 23:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbiBJWgE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 17:36:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBJWgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 17:36:03 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3046F47
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:36:03 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q204so9288049iod.8
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzQyQkdfPgAbJtfqnuOnGKsnTTDqtepCiPpNwiV9TSs=;
        b=G+JjuYf5kWvMOuzyk9JGDWscFvQObwm8JFQCcb4Arxn1nT00H4eHrQ+VsVpbBFFT6K
         6h/6YtRvmyXGhpTBhUJT6Y4flbh0u/aoJSWxm18Q1P+aGlsBXaPIPGHYMUK6DA11y4Jd
         hB8auZSih0s5yCTTw/lEc9q+0ND75iNJgH/usuLsJY/NxGHYvs3vV8Cw2YAWoirkMAX/
         sjMwL75lXCFzAAePvjwurZkDlfbI8vOc04x02hYvQmLZ4b2o9t+PXjuJLv6sfyAAZUMR
         3XHFDKK+p8Uyks4CoV8PtWz92DrnDpF/PQHoTC7movBXLY+MFEe+eFmfZrn2Q2nY0sBh
         y+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzQyQkdfPgAbJtfqnuOnGKsnTTDqtepCiPpNwiV9TSs=;
        b=tyO0AuKAnnhziLFmZ//VIuNvs68IbDrr8VNMSgEfiIFpamgg9sFGSv+mnvFrFKFT6t
         YgNGvDI/UeodLwiC3+W2RUMHID+o7q+L4ZRbAz2PGfR1KnntcAx+SXzxM2dkbYD4oww8
         hDrpb8ycmF5T90AErbi9lKZFtjqDZLKdi68HkR2fWDNL5i9uA++J+PtrQTY/Dlvk2qU7
         k72twjSHGd8OdpiKuvvTBj6ENYscwoJQvItJjon+gDtB11ITIz1P+/28aO2Lp1Gk6stj
         bpf51q3rt7J1Gi/e5BeZibkgoMH3QETJaQ3cKfZgTAbtmV2fWcTsWjhZUUeZNzCa/PPX
         j19Q==
X-Gm-Message-State: AOAM533LtOHByrkM3MG/geFMRCiXL0wcvJrqo4odxjv8FQEZ+LnXATkT
        vc8HuQIOzu+yVkUEQ3ds52NBqiRKG4Bh4uqX8EM=
X-Google-Smtp-Source: ABdhPJztBgM6izILVf1/jggZSFcfnSgN1hK8uKK1IgKtWAhg8ihq8oPXqk82AcFyMyHg9o9rbmidpCFxRi1BusDjQwY=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr4935130ioj.144.1644532563034;
 Thu, 10 Feb 2022 14:36:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644453291.git.delyank@fb.com> <c37e39653b133b230dee3b393a07b4def697b61a.1644453291.git.delyank@fb.com>
In-Reply-To: <c37e39653b133b230dee3b393a07b4def697b61a.1644453291.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Feb 2022 14:35:52 -0800
Message-ID: <CAEf4BzY4RdsGHFdJH-chAMpFnP+rGojbBkOEEgjcS09nwU8XTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] libbpf: btf_dump can produce explicitly
 sized ints
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

On Wed, Feb 9, 2022 at 4:37 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> When emitting type declations, btf_dump can now optionally rename
> int types (including typedefs) to standard types with explicit sizes.
> Types like pid_t get renamed but types like __u32, char, and _Bool
> are left alone to preserve cast semantics in as many pre-existing
> programs as possible.
>
> This option is useful when generating data structures on a system where
> types may differ due to arch differences or just userspace and bpf program
> disagreeing on the definition of a typedef.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/btf.h      |  4 +-
>  tools/lib/bpf/btf_dump.c | 80 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 951ac7475794..dbd41bf93b13 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -347,9 +347,11 @@ struct btf_dump_emit_type_decl_opts {
>         int indent_level;
>         /* strip all the const/volatile/restrict mods */
>         bool strip_mods;
> +       /* normalize int fields to (u)?int(16|32|64)_t types */
> +       bool sizedints;

let's stick to consistent snake_case naming convention

let's also call it what the comment calls it :) "normalize_ints" ?

>         size_t :0;
>  };
> -#define btf_dump_emit_type_decl_opts__last_field strip_mods
> +#define btf_dump_emit_type_decl_opts__last_field sizedints
>
>  LIBBPF_API int
>  btf_dump__emit_type_decl(struct btf_dump *d, __u32 id,
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 07ebe70d3a30..56bafacf1cbd 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -81,6 +81,7 @@ struct btf_dump {
>         void *cb_ctx;
>         int ptr_sz;
>         bool strip_mods;
> +       bool sizedints;
>         bool skip_anon_defs;
>         int last_id;
>
> @@ -1130,7 +1131,9 @@ int btf_dump__emit_type_decl(struct btf_dump *d, __u32 id,
>         fname = OPTS_GET(opts, field_name, "");
>         lvl = OPTS_GET(opts, indent_level, 0);
>         d->strip_mods = OPTS_GET(opts, strip_mods, false);
> +       d->sizedints = OPTS_GET(opts, sizedints, false);
>         btf_dump_emit_type_decl(d, id, fname, lvl);
> +       d->sizedints = false;
>         d->strip_mods = false;
>         return 0;
>  }
> @@ -1263,6 +1266,34 @@ static void btf_dump_emit_name(const struct btf_dump *d,
>         btf_dump_printf(d, "%s%s", separate ? " " : "", name);
>  }
>
> +/* Encode custom heurstics to find char types since BTF_INT_CHAR is never set. */

typo: heuristic

> +static bool btf_is_char(const struct btf_dump *d, const struct btf_type *t)
> +{
> +       return btf_is_int(t) &&
> +              t->size == 1 &&
> +              strcmp(btf_name_of(d, t->name_off), "char") == 0;
> +}
> +
> +static bool btf_is_bool(const struct btf_type *t)
> +{
> +       return btf_is_int(t) && (btf_int_encoding(t) & BTF_INT_BOOL);
> +}
> +
> +/* returns true if type is of the '__[su](8|16|32|64)' type */
> +static bool btf_is_kernel_sizedint(const struct btf_dump *d, const struct btf_type *t)
> +{
> +       const char *name = btf_name_of(d, t->name_off);
> +
> +       return strcmp(name, "__s8") == 0 ||
> +              strcmp(name, "__u8") == 0 ||
> +              strcmp(name, "__s16") == 0 ||
> +              strcmp(name, "__u16") == 0 ||
> +              strcmp(name, "__s32") == 0 ||
> +              strcmp(name, "__u32") == 0 ||
> +              strcmp(name, "__s64") == 0 ||
> +              strcmp(name, "__u64") == 0;
> +}

So I thought about this a bit, I see how there could be a difference
of %lld vs %ld and such, but I think normalize should mean normalize
all ints, without any exceptions for kernel aliases. Let's keep the
rule simple: everything but char and bool gets converted to its
corresponding standard integer alias.

Worst case few users might need to adjust their printf specifier after
seeing a compiler warning.

> +
>  static void btf_dump_emit_type_chain(struct btf_dump *d,
>                                      struct id_stack *decls,
>                                      const char *fname, int lvl)
> @@ -1277,10 +1308,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>          * don't want to prepend space for that last pointer.
>          */
>         bool last_was_ptr = true;
> -       const struct btf_type *t;
> +       const struct btf_type *t, *rest;
>         const char *name;
>         __u16 kind;
>         __u32 id;
> +       __u8 intenc;
> +       int restypeid;
>

same about variable naming conventions

>         while (decls->cnt) {
>                 id = decls->ids[--decls->cnt];
> @@ -1295,8 +1328,51 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>                 t = btf__type_by_id(d->btf, id);
>                 kind = btf_kind(t);

just move it after the if () to not re-assign kind again inside the if

>
> +               /* If we're asked to produce stdint declarations, we need
> +                * to only do that in the following cases:
> +                *  - int types other than char and _Bool

let's make it the only case

> +                *  - typedefs to int types (including char and _Bool) except
> +                *    kernel types like __s16/__u32/etc.
> +                *
> +                * If a typedef resolves to char or _Bool, we do want to use
> +                * the resolved type instead of the stdint types (i.e. char
> +                * instead of int8_t) because the stdint types are explicitly
> +                * signed/unsigned, which affects pointer casts.
> +                *
> +                * If the typedef is of the __s32 variety, we leave it as-is
> +                * due to incompatibilities in e.g. s64 vs int64_t definitions
> +                * (one is `long long` on x86_64 and the other is not).
> +                *
> +                * Unfortunately, the BTF type info never includes BTF_INT_CHAR,
> +                * so we use a size comparison to avoid chars and
> +                * BTF_INT_BOOL to avoid bools.
> +                */
> +               if (d->sizedints && kind == BTF_KIND_TYPEDEF &&
> +                   !btf_is_kernel_sizedint(d, t)) {
> +                       restypeid = btf__resolve_type(d->btf, id);

we use skip_mods_and_typedefs() everywhere for this, it returns
btf_type (and optionally type_id as well), much more convenient (and
it can't fail, so no need for extra error handling)

also please use btf_is_typedef(t)

> +                       if (restypeid >= 0) {
> +                               rest = btf__type_by_id(d->btf, restypeid);
> +                               if (rest && btf_is_int(rest)) {
> +                                       t = rest;
> +                                       kind = btf_kind(rest);
> +                               }
> +                       }
> +               }
> +
>                 switch (kind) {
>                 case BTF_KIND_INT:
> +                       btf_dump_emit_mods(d, decls);
> +                       if (d->sizedints && !btf_is_bool(t) && !btf_is_char(d, t)) {
> +                               intenc = btf_int_encoding(t);
> +                               btf_dump_printf(d,
> +                                               intenc & BTF_INT_SIGNED ?
> +                                               "int%d_t" : "uint%d_t",
> +                                               t->size * 8);
> +                       } else {
> +                               name = btf_name_of(d, t->name_off);
> +                               btf_dump_printf(d, "%s", name);
> +                       }
> +                       break;
>                 case BTF_KIND_FLOAT:
>                         btf_dump_emit_mods(d, decls);
>                         name = btf_name_of(d, t->name_off);
> @@ -1469,7 +1545,9 @@ static void btf_dump_emit_type_cast(struct btf_dump *d, __u32 id,
>
>         d->skip_anon_defs = true;
>         d->strip_mods = true;
> +       d->sizedints = true;

this is a different use case, let's not normalize anything unconditionally

>         btf_dump_emit_type_decl(d, id, "", 0);
> +       d->sizedints = false;
>         d->strip_mods = false;
>         d->skip_anon_defs = false;
>
> --
> 2.34.1
