Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732494DA9D9
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 06:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbiCPFaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 01:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353618AbiCPFaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 01:30:16 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73DC35867
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:29:02 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id n16so868470ile.11
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uso7rJiJ3yj9qXgRvK6rPJ1+cK1fS811KHWyhsmzUZo=;
        b=mr0NJ4HzPx+LT2z2JrvImpiE3GyBXWJqyejBgINF1s8Mq9uasBhJnZGFa+K0WwzeGZ
         kGnLf5XQVANrSCbebnS/wIqh9ml5SmGUETVgsBBi+Ll8FLw7Kzg/+YoHGa0E3MEMKf+9
         DrKRMxcWyyT6QCXXMd6msMj1d2m5+aeXB3bA348PtU1j+9jpioS+Zp4IVgedCu0rb1Ib
         HCjnv7iGkGat+t3PK9xdRQ5NYjbEH5qGfH9wIkqw4k0kJUvZgoLISamqNJ0OWrqnarL6
         CGr/hBPfuElhy59sW8nuyBvONKuoGJxQZg374mS9q3mUFJfcjkpTNB3U9JrlR/b1K3vs
         XwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uso7rJiJ3yj9qXgRvK6rPJ1+cK1fS811KHWyhsmzUZo=;
        b=SVTJ9C+RG0F2xpSJbqrujdAV9DOxWjGzP2JDlCA7Uc+BUJAEZgzzBEQ4/cpkFSEmUh
         EcXKCFSHjFj4c93ewxAP00LIM5RbtgL/RAwyApro1nPDqXH5E8dDdun57a145GB8YT3B
         vi3GvJAecKjGD18ob8gj3LS7isXpWvNXd1EbNOY5tw3ZHplHhCsJ1GOHuddZ2z+UZ5Gl
         rQmOV9dizeTQ7ryZ0I7YdOPz7CknjLKCmq28cbBwbdGxrTOCZlh97fN1NSMrBE1jl4l2
         61zm//9B9jaw+kPrNsITvR7eATu2er5MriBqLJvj53yCaJVrQtvC3DCoPi0UM1oR68Pz
         NRdg==
X-Gm-Message-State: AOAM531lwVfwJNWidqI6m2JoFHLlJUbUyf6O6HvtPT27feXq8d6Bfzw0
        9u1BdNrwdwq/qYXA6hLiYaRW0sflu/PLYDJ0GLY=
X-Google-Smtp-Source: ABdhPJx1H7I4wD1cSTmQtyPfwCrMseeMDFQNFaLRy/oAkA5p93ZudJfnJBCo1j5FbSl6VoXDvAb0Urj4kEKsWsEqTNY=
X-Received: by 2002:a92:d241:0:b0:2c6:d22:27cf with SMTP id
 v1-20020a92d241000000b002c60d2227cfmr23384439ilg.98.1647408542196; Tue, 15
 Mar 2022 22:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647382072.git.delyank@fb.com> <bf6799b11254c6642318b0728b7452800b29c8e5.1647382072.git.delyank@fb.com>
In-Reply-To: <bf6799b11254c6642318b0728b7452800b29c8e5.1647382072.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 22:28:51 -0700
Message-ID: <CAEf4BzasE2zyhuhOg0USwiUA2mA876TOkVO7X097udTQCNk-jQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: add support for subskeletons
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

On Tue, Mar 15, 2022 at 3:15 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Subskeletons are headers which require an already loaded program to
> operate.
>
> For example, when a BPF library is linked into a larger BPF object file,
> the library userspace needs a way to access its own global variables
> without requiring knowledge about the larger program at build time.
>
> As a result, subskeletons require a loaded bpf_object to open().
> Further, they find their own symbols in the larger program by
> walking BTF type data at run time.
>
> At this time, programs, maps, and globals are supported through
> non-owning pointers.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
>  tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
>  tools/bpf/bpftool/gen.c                       | 595 +++++++++++++++---
>  3 files changed, 549 insertions(+), 85 deletions(-)
>

[...]

> -static void get_header_guard(char *guard, const char *obj_name)
> +static void get_header_guard(char *guard, const char *obj_name, const char *suffix)
>  {
>         int i;
>
> -       sprintf(guard, "__%s_SKEL_H__", obj_name);
> +       sprintf(guard, "__%s_%s__", obj_name, suffix);
>         for (i = 0; guard[i]; i++)
>                 guard[i] = toupper(guard[i]);
>  }
> @@ -231,6 +231,17 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>         return NULL;
>  }
>
> +static bool bpf_map__is_internal_mmappable(const struct bpf_map *map, char *buf, size_t sz)

nit: abc__def looks like public libbpf API which is a bit confusing,
maybe just "is_internal_mmapable_map"?

> +{
> +       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +               return false;
> +
> +       if (!get_map_ident(map, buf, sz))
> +               return false;
> +
> +       return true;
> +}
> +

[...]

> +                       /* The datasec member has KIND_VAR but we want the
> +                        * underlying type of the variable (e.g. KIND_INT).
> +                        */
> +                       var = skip_mods_and_typedefs(btf, var->type, NULL);
> +
> +                       printf("\t\t");
> +                       /* Func and array members require special handling.
> +                        * Instead of producing `typename *var`, they produce
> +                        * `typeof(typename) *var`. This allows us to keep a
> +                        * similar syntax where the identifier is just prefixed
> +                        * by *, allowing us to ignore C declaration minutae.

typo: minutiae

> +                        */
> +                       needs_typeof = btf_is_array(var) || btf_is_ptr_to_func_proto(btf, var);
> +                       if (needs_typeof)
> +                               printf("typeof(");
> +

[...]

> +       bpf_object__for_each_map(map, obj) {
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;
> +
> +               codegen("\
> +                       \n\
> +                                                                       \n\
> +                               s->maps[%zu].name = \"%s\";         \n\
> +                               s->maps[%zu].map = &obj->maps.%s;   \n\
> +                       ",
> +                       i, bpf_map__name(map), i, ident);
> +               /* memory-mapped internal maps */
> +               if (mmaped && bpf_map__is_internal(map) &&
> +                       (bpf_map__map_flags(map) & BPF_F_MMAPABLE)) {

minor: probably could have used is_internal_mmapable_map() here as
well, but you probably didn't like overwriting ident here, right?

> +                       printf("\ts->maps[%zu].mmaped = (void **)&obj->%s;\n",
> +                               i, ident);
> +               }
> +               i++;
> +       }
> +}
> +
> +static void
> +codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_links)
> +{
> +       struct bpf_program *prog;
> +       int i;
> +
> +       if (!prog_cnt)
> +               return;
> +
> +       codegen("\
> +               \n\
> +                                                                       \n\
> +                       /* programs */                              \n\
> +                       s->prog_cnt = %zu;                          \n\
> +                       s->prog_skel_sz = sizeof(*s->progs);        \n\
> +                       s->progs = (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_skel_sz);\n\
> +                       if (!s->progs)                              \n\
> +                               goto err;                           \n\
> +               ",
> +               prog_cnt
> +       );
> +       i = 0;
> +       bpf_object__for_each_program(prog, obj) {
> +               codegen("\
> +                       \n\
> +                                                                       \n\
> +                               s->progs[%1$zu].name = \"%2$s\";    \n\
> +                               s->progs[%1$zu].prog = &obj->progs.%2$s;\n\

nit: here and in few other places \n\ are not aligned properly

> +                       ",
> +                       i, bpf_program__name(prog));
> +
> +               if (populate_links) {
> +                       codegen("\
> +                               \n\
> +                                       s->progs[%1$zu].link = &obj->links.%2$s;\n\
> +                               ",
> +                               i, bpf_program__name(prog));
> +               }
> +               i++;
> +       }
> +}
> +

[...]

> +       /* First, count how many variables we have to find.
> +        * We need this in advance so the subskel can allocate the right
> +        * amount of storage.
> +        */
> +       bpf_object__for_each_map(map, obj) {
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;
> +
> +               /* Also count all maps that have a name */
> +               map_cnt++;
> +
> +               if (!bpf_map__is_internal(map))
> +                       continue;
> +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +                       continue;

same, probably could reuse is_internal_mmapable_map() (but I'm
guessing reassigning ident threw you off)

> +
> +               map_type_id = bpf_map__btf_value_type_id(map);
> +               if (map_type_id < 0) {

well, actually map_type_id == 0 would be wrong here as well, probably
want to skip such maps (e.g., .rodata.str1.1), instead of pretending
that VOID is DATASEC.

> +                       err = map_type_id;
> +                       goto out;
> +               }
> +               map_type = btf__type_by_id(btf, map_type_id);
> +

[...]

> +
> +       /* walk through each symbol and emit the runtime representation */
> +       bpf_object__for_each_map(map, obj) {
> +               if (!bpf_map__is_internal_mmappable(map, ident, sizeof(ident)))
> +                       continue;
> +
> +               map_type_id = bpf_map__btf_value_type_id(map);
> +               if (map_type_id < 0)

<= 0 ?

> +                       /* skip over internal maps with no type*/
> +                       continue;
> +
> +               map_type = btf__type_by_id(btf, map_type_id);
> +               var = btf_var_secinfos(map_type);
> +               len = btf_vlen(map_type);
> +               for (i = 0; i < len; i++, var++) {
> +                       var_type = btf__type_by_id(btf, var->type);
> +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> +
> +                       if (btf_var(var_type)->linkage == BTF_VAR_STATIC)
> +                               continue;
> +
> +                       var_ident[0] = '\0';
> +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
> +                       sanitize_identifier(var_ident);

hm... I thought we agreed that we don't need variable name sanitization?..

> +
> +                       /* Note that we use the dot prefix in .data as the
> +                        * field access operator i.e. maps%s becomes maps.data
> +                        */
> +                       codegen("\
> +                       \n\

please emit empty line here (in codegen), similar to map and prog
initialization, for consistency

> +                               s->vars[%4$d].name = \"%1$s\";              \n\


... and if sanitization had any effect, this name would be wrong (it
has to be original var_name)

> +                               s->vars[%4$d].map = &obj->maps.%3$s;        \n\
> +                               s->vars[%4$d].addr = (void**) &obj->%2$s.%1$s;\n\
> +                       ", var_ident, ident, ident, var_idx);

with this %3$s syntax you don't need to specify ident, ident twice

and (void**) -> (void **)?

> +
> +                       var_idx++;
> +               }
> +       }
> +
> +       codegen_maps_skeleton(obj, map_cnt, false /*mmaped*/);
> +       codegen_progs_skeleton(obj, prog_cnt, false /*links*/);
> +

[...]
