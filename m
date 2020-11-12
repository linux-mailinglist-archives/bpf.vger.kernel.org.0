Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80D2B0E87
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 20:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgKLTyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 14:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKLTyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 14:54:53 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017BC0613D1;
        Thu, 12 Nov 2020 11:54:53 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id c129so6501136yba.8;
        Thu, 12 Nov 2020 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhDzAapXr1oUoWZdn6YnD0neaHF6747IueUQzpazLeQ=;
        b=mGXbect63ROJhSwG+ShuoRduGpi0km9vNAlGnnSKwZmFMdSHNSpvyKRUjRMgoFK49V
         Kcwdg3Os48ywRhsCtt7/wXGBXUhUpheGaXZQA7bb3awK6BxjMH1YE5TOM8X01Wg78ZJP
         N/Hb9k6LiAfKPkuVcdjAFWyPo0W1asU9M6FYqRkb6QqERsdZ0q/egcL/IcSKdZ2lkS1e
         Z8kH8+Cm0Ef2zaOE+yFhV0rDonlPNbfopK69urRNgDyEgGTDa8wHTBJA9+Q94Smhmvhk
         uqn0YHFGAgdd9A8cvbMQEAt0toSgEigYtDrpzJ+hZsygJkqPbrTZXmvYi0ghfzNzTt+F
         gcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhDzAapXr1oUoWZdn6YnD0neaHF6747IueUQzpazLeQ=;
        b=asUQbj2S3VyE9ljc4uFhXbjHVislKtZAWo65r2O8OPYMN3T/4bR3XM5Ks71X00Miml
         Vg1hD3UNtspmqaTON8+4LBCWn/RqprqmaDUbkRsGZoeTjYdYNwzawQkLIvWnEVZNUl1+
         H9nFFz3QlP+h0fptXBZEH/wCswSdznK89D+qrl6BHX/gD7Frxs+dd+Rc9z7tGA1ZhBDy
         QO6j4XSIU0r2m1OSwLKi01C5BB28LjkzUvpprgefrvITeOeCOPc67atGaUziNd50O/dM
         MHLI12GO4uTI74UpRDu69qdguePgGTJGFbKLEssCX3fQMLxVtX2rmheS6Iy+mdRG7L9l
         /JAg==
X-Gm-Message-State: AOAM531vHDfDeX0klmMsi4IM/7HlnzQsa2wQ7H+Dwq0nDpclBHo08UMU
        tpmHLhPb1WBmZcdDf0SiaK6SRWOiz5nqSoWnJuY=
X-Google-Smtp-Source: ABdhPJxKOT89S4c1qs5h4Zv7Nkv0WPgjlLQuhUp4jVarEC7eB4cs9BdQEnBRMTs73dAt2SQ1J7G3wfBhsQwAFt2o0Ws=
X-Received: by 2002:a25:bdc7:: with SMTP id g7mr1606411ybk.260.1605210892245;
 Thu, 12 Nov 2020 11:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-4-jolsa@kernel.org>
In-Reply-To: <20201112150506.705430-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 11:54:41 -0800
Message-ID: <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Recent btf encoder's changes brakes BTF data for some gcc versions.
>
> The problem is that some functions can appear in dwarf data in some
> instances without arguments, while they are defined with some.
>
> Current code will record 'no arguments' for such functions and they
> disregard the rest of the DWARF data claiming otherwise.
>
> This patch changes the BTF function generation, so that in the main
> cu__encode_btf processing we do not generate any BTF function code,
> but only collect functions 'to generate' and update their arguments.
>
> When we process the whole data, we go through the functions and
> generate its BTD data.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 110 +++++++++++++++++++++++++++++++++-----------------
>  pahole.c      |   2 +-
>  2 files changed, 73 insertions(+), 39 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index efc4f48dbc5a..46cb7e6f5abe 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -35,7 +35,10 @@ struct funcs_layout {
>  struct elf_function {
>         const char      *name;
>         unsigned long    addr;
> -       bool             generated;
> +       struct cu       *cu;
> +       struct function *fn;
> +       int              args_cnt;
> +       uint32_t         type_id_off;
>  };
>
>  static struct elf_function *functions;
> @@ -64,6 +67,7 @@ static void delete_functions(void)
>  static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>  {
>         struct elf_function *new;
> +       char *name;
>
>         if (elf_sym__type(sym) != STT_FUNC)
>                 return 0;
> @@ -83,9 +87,20 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>                 functions = new;
>         }
>
> -       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> +       /*
> +        * At the time we process functions,
> +        * elf object might be already released.
> +        */
> +       name = strdup(elf_sym__name(sym, btfe->symtab));
> +       if (!name)
> +               return -1;
> +
> +       functions[functions_cnt].name = name;
>         functions[functions_cnt].addr = elf_sym__value(sym);
> -       functions[functions_cnt].generated = false;
> +       functions[functions_cnt].fn = NULL;
> +       functions[functions_cnt].cu = NULL;
> +       functions[functions_cnt].args_cnt = 0;
> +       functions[functions_cnt].type_id_off = 0;
>         functions_cnt++;
>         return 0;
>  }
> @@ -164,20 +179,6 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>         return 0;
>  }
>
> -static bool should_generate_function(const struct btf_elf *btfe, const char *name)
> -{
> -       struct elf_function *p;
> -       struct elf_function key = { .name = name };
> -
> -       p = bsearch(&key, functions, functions_cnt,
> -                   sizeof(functions[0]), functions_cmp);
> -       if (!p || p->generated)
> -               return false;
> -
> -       p->generated = true;
> -       return true;
> -}
> -
>  static bool btf_name_char_ok(char c, bool first)
>  {
>         if (c == '_' || c == '.')
> @@ -368,6 +369,21 @@ static int generate_func(struct btf_elf *btfe, struct cu *cu,
>         return err;
>  }
>
> +static int process_functions(struct btf_elf *btfe)
> +{
> +       unsigned long i;
> +
> +       for (i = 0; i < functions_cnt; i++) {
> +               struct elf_function *func = &functions[i];
> +
> +               if (!func->fn)
> +                       continue;
> +               if (generate_func(btfe, func->cu, func->fn, func->type_id_off))
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
>  int btf_encoder__encode()
>  {
>         int err;
> @@ -375,7 +391,9 @@ int btf_encoder__encode()
>         if (gobuffer__size(&btfe->percpu_secinfo) != 0)
>                 btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
>
> -       err = btf_elf__encode(btfe, 0);
> +       err = process_functions(btfe);
> +       if (!err)
> +               err = btf_elf__encode(btfe, 0);
>         delete_functions();
>         btf_elf__delete(btfe);
>         btfe = NULL;
> @@ -539,15 +557,17 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>         return 0;
>  }
>
> -static bool has_arg_names(struct cu *cu, struct ftype *ftype)
> +static bool has_arg_names(struct cu *cu, struct ftype *ftype, int *args_cnt)
>  {
>         struct parameter *param;
>         const char *name;
>
> +       *args_cnt = 0;
>         ftype__for_each_parameter(ftype, param) {
>                 name = dwarves__active_loader->strings__ptr(cu, param->name);
>                 if (name == NULL)
>                         return false;
> +               ++*args_cnt;
>         }
>         return true;
>  }
> @@ -624,32 +644,46 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 has_index_type = true;
>         }
>
> -       cu__for_each_function(cu, core_id, fn) {
> -               /*
> -                * The functions_cnt != 0 means we parsed all necessary
> -                * kernel symbols and we are using ftrace location filter
> -                * for functions. If it's not available keep the current
> -                * dwarf declaration check.
> -                */
> -               if (functions_cnt) {
> +       /*
> +        * The functions_cnt != 0 means we parsed all necessary
> +        * kernel symbols and we are using ftrace location filter
> +        * for functions. If it's not available keep the current
> +        * dwarf declaration check.
> +        */
> +       if (functions_cnt) {
> +               cu__for_each_function(cu, core_id, fn) {
> +                       struct elf_function *p;
> +                       struct elf_function key = { .name = function__name(fn, cu) };
> +                       int args_cnt = 0;
> +
>                         /*
> -                        * We check following conditions:
> -                        *   - argument names are defined
> -                        *   - there's symbol and address defined for the function
> -                        *   - function address belongs to ftrace locations
> -                        *   - function is generated only once
> +                        * Collect functions that match ftrace filter
> +                        * and pick the one with proper argument names.
> +                        * The BTF generation happens at the end in
> +                        * btf_encoder__encode function.
>                          */
> -                       if (!has_arg_names(cu, &fn->proto))
> +                       p = bsearch(&key, functions, functions_cnt,
> +                                   sizeof(functions[0]), functions_cmp);
> +                       if (!p)
>                                 continue;
> -                       if (!should_generate_function(btfe, function__name(fn, cu)))
> +
> +                       if (!has_arg_names(cu, &fn->proto, &args_cnt))

So I can't unfortunately reproduce that GCC bug with DWARF info. What
was exactly the symptom? Maybe you can also share readelf -wi dump for
your problematic vmlinux?

The reason I'm asking is because I wonder if we should still ignore
functions if fn->declaration is set. E.g., for the issue we
investigated yesterday, the function with no arguments has declaration
set to 1, so just ignoring it would solve the problem. I'm wondering
if it's enough to do just that instead of doing this whole delayed
function collection/processing.

Also, I'd imagine the only expected cases where we can override  the
function (args_cnt > p->args_cnt) would be if p->args_cnt == 0, no?
All other cases are either newly discovered "bogusness" of DWARF (and
would be good to know about this) or it's a name collision for
functions. Basically, before we go all the way to rework this again,
let's see if just skipping declarations would be enough?

>                                 continue;
> -               } else {
> +
> +                       if (!p->fn || args_cnt > p->args_cnt) {
> +                               p->fn = fn;
> +                               p->cu = cu;
> +                               p->args_cnt = args_cnt;
> +                               p->type_id_off = type_id_off;
> +                       }
> +               }
> +       } else {
> +               cu__for_each_function(cu, core_id, fn) {
>                         if (fn->declaration || !fn->external)
>                                 continue;
> +                       if (generate_func(btfe, cu, fn, type_id_off))
> +                               goto out;
>                 }

I'm trending towards disliking this completely different fallback
mechanism. It saved bpf-next accidentally, but otherwise obscured the
issue and generally makes testing pahole with artificial binary BTFs
(from test programs) harder. How about we unify approaches, but just
use mcount symbols opportunistically, as an additional filter, if it's
available?

With that, testing that we still handle functions with duplicate names
properly would be trivial (which I suspect we don't and we'll just
keep the one with more args now, right?) And it makes static functions
available for non-vmlinux binaries automatically (might be good or
bad, but still...).

> -
> -               if (generate_func(btfe, cu, fn, type_id_off))
> -                       goto out;
>         }
>
>         if (skip_encoding_vars)
> diff --git a/pahole.c b/pahole.c
> index fca27148e0bb..d6165d4164dd 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2392,7 +2392,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>                         fprintf(stderr, "Encountered error while encoding BTF.\n");
>                         exit(1);
>                 }
> -               return LSK__DELETE;
> +               return LSK__KEEPIT;
>         }
>
>         if (ctf_encode) {
> --
> 2.26.2
>
