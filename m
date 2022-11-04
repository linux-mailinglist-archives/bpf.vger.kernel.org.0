Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0114361A2C0
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKDUyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKDUy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 16:54:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB81A049
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 13:54:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k2so16360447ejr.2
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6x/IDSvo1DKWsq40s4MpOIod4x+yegmIIb/05R7Taw=;
        b=bDbzLP9jCSgw63ybcTh+yguAGO1IpWoFVNR+QZ7Cdntfoi95PzFQns41OPJaUKDBhU
         yFT5wKwr6Of501pyBC/Hcis+8uUgpjYLmza53e102oc9A2LVNXr0dJt6JYfgDR+ZfION
         fi+T4/6wuIIu1O5L2wUAV9qyo9EJMeiVn6TpbxJiKhyUa//22pA7JsDDY9VswGWRF7By
         KJRrwrdqhYsvZg78Sx20wDl08edaqIjRUJc2N/7782PIhWSHsfKrbhVOtSW6gOXEX9kz
         4ZRq4lFawk2sgVKvcdpvgfvFNCtsJZlaDjrswpaQLNFVvBgm8zIaFtnHLcniJZEfBQQO
         Cq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6x/IDSvo1DKWsq40s4MpOIod4x+yegmIIb/05R7Taw=;
        b=zlrPkL659zSU54P6T0lQ1ZYNTsI5eRB7A8V6ITRizDMCC5iOs5c3vSIfhQSPp2lVQe
         dA1wl/BKVtRiJRE1mZKYABsL63iXY9wcEaIYwdWh3q3ixM97HfC1d8M4b0uR5CRTpK+H
         tq0ze252RH2ivAalY5dmVanyjrh4sVk+vpToBmqzaDAXLU1hmcAijaYoXklNSfOdiyqV
         TekqcpGvM7C8C2935hez4SyXOSgjLwciTdf6d9+S9QwaJiw2VK3Z7eNN18HaND0G09xJ
         PxYiUkgEAeyXN6vGXT3XteOXV1FrGNlUynXjTYrpnUzQRQjFV6uw5EDH0L402u8ay1DX
         FNOA==
X-Gm-Message-State: ACrzQf0oYiZIuzSFE3q/VJZqXlQBCcHB5PR8Y1/1c6zgtlW+wLfQNCLC
        HQxMnewoT2n7HOcSJyTO9RAgJZ1JVglDHsimChk=
X-Google-Smtp-Source: AMsMyM7ffX3Km8AqqfOpVlEAzrHH+pw+xTaM+cZlwyP0pZzfawPW7QKDTNRojF7MjqZMCWu34zRitowoq1GXBfHy/Gk=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr35741636ejn.302.1667595266314; Fri, 04
 Nov 2022 13:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221103134522.2764601-1-eddyz87@gmail.com>
In-Reply-To: <20221103134522.2764601-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 13:54:14 -0700
Message-ID: <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 6:45 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
> as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> the type annotated with this attribute. This commit adds
> reconstitution of such attributes for BTF dump in C format.
>
> BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
> this is not enforced and tests don't honor this restriction.
> This commit uses hashmap to map types to the list of decl tags.
> The hashmap is filled by `btf_dump_assign_decl_tags` function called
> from `btf_dump__new`.
>
> It is assumed that total number of types annotated with decl tags is
> relatively small, thus some space is saved by using hashmap instead of
> adding a new field to `struct btf_dump_type_aux_state`.
>
> It is assumed that list of decl tags associated with a single type is
> small. Thus the list is represented by an array which grows linearly.
>
> To accommodate older Clang versions decl tags are dumped using the
> following macro:
>
>  #if __has_attribute(btf_decl_tag)
>  #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
>  #else
>  #  define __btf_decl_tag(x)
>  #endif
>
> The macro definition is emitted upon first call to `btf_dump__dump_type`.
>
> Clang allows to attach btf_decl_tag attributes to the following kinds
> of items:
> - struct/union         supported
> - struct/union field   supported
> - typedef              supported
> - function             not applicable
> - function parameter   not applicable
> - variable             not applicable
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 163 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 160 insertions(+), 3 deletions(-)
>

Functions and their args can also have tags. This works:

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
index 7a5af8b86065..75fcabe700cd 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
@@ -54,7 +54,7 @@ struct root_struct {

 /* ------ END-EXPECTED-OUTPUT ------ */

-int f(struct root_struct *s)
+int f(struct root_struct *s __btf_decl_tag("func_arg_tag"))
__btf_decl_tag("func_tag")
 {
        return 0;
 }

And I see correct BTF:

[26] FUNC 'f' type_id=25 linkage=global
[27] DECL_TAG 'func_arg_tag' type_id=26 component_idx=0
[28] DECL_TAG 'func_tag' type_id=26 component_idx=-1

So let's add support and test for that case as well. btf_dump
shouldn't assume vmlinux.h-only case.

Also, please check if DATASEC and VARs can have decl_tags associated with them.

[...]

> @@ -143,6 +174,7 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
>
>  static int btf_dump_mark_referenced(struct btf_dump *d);
>  static int btf_dump_resize(struct btf_dump *d);
> +static int btf_dump_assign_decl_tags(struct btf_dump *d);
>
>  struct btf_dump *btf_dump__new(const struct btf *btf,
>                                btf_dump_printf_fn_t printf_fn,
> @@ -179,11 +211,21 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
>                 d->ident_names = NULL;
>                 goto err;
>         }
> +       d->decl_tags = hashmap__new(identity_hash_fn, identity_equal_fn, NULL);
> +       if (IS_ERR(d->decl_tags)) {
> +               err = PTR_ERR(d->decl_tags);
> +               d->decl_tags = NULL;

nit: no need to clear out ERR pointer, hashmap__free() handles that properly

> +               goto err;
> +       }
>
>         err = btf_dump_resize(d);
>         if (err)
>                 goto err;
>
> +       err = btf_dump_assign_decl_tags(d);
> +       if (err)
> +               goto err;
> +
>         return d;
>  err:
>         btf_dump__free(d);
> @@ -232,7 +274,8 @@ static void btf_dump_free_names(struct hashmap *map)
>
>  void btf_dump__free(struct btf_dump *d)
>  {
> -       int i;
> +       int i, bkt;
> +       struct hashmap_entry *cur;
>
>         if (IS_ERR_OR_NULL(d))
>                 return;
> @@ -248,14 +291,22 @@ void btf_dump__free(struct btf_dump *d)
>         free(d->cached_names);
>         free(d->emit_queue);
>         free(d->decl_stack);
> -       btf_dump_free_names(d->type_names);
> -       btf_dump_free_names(d->ident_names);
> +       if (d->type_names)
> +               btf_dump_free_names(d->type_names);
> +       if (d->ident_names)
> +               btf_dump_free_names(d->ident_names);
> +       if (d->decl_tags) {
> +               hashmap__for_each_entry(d->decl_tags, cur, bkt)
> +                       free(cur->value);
> +               hashmap__free(d->decl_tags);

generalize btf_dump_free_names() to btf_dump_free_strs_map() and
handle IS_ERR_OR_NULL call internally?

> +       }
>
>         free(d);
>  }
>
>  static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr);
>  static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
> +static void btf_dump_maybe_define_btf_decl_tag(struct btf_dump *d);

naming nit: btf_dump_ensure_btf_decl_tag_macro() ?

>
>  /*
>   * Dump BTF type in a compilable C syntax, including all the necessary
> @@ -284,6 +335,8 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
>         if (err)
>                 return libbpf_err(err);
>
> +       btf_dump_maybe_define_btf_decl_tag(d);
> +
>         d->emit_queue_cnt = 0;
>         err = btf_dump_order_type(d, id, false);
>         if (err < 0)
> @@ -373,6 +426,61 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
>         return 0;
>  }
>
> +/*
> + * This hashmap lookup is used in several places, so extract it as a
> + * function to hide all the ceremony with casts and NULL assignment.
> + */
> +static struct decl_tag_array *btf_dump_find_decl_tags(struct btf_dump *d, __u32 id)
> +{
> +       struct decl_tag_array *decl_tags = NULL;
> +
> +       hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
> +
> +       return decl_tags;
> +}
> +

with your hashmap void * -> long refactoring this is not necessary,
though, right?

> +/*
> + * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
> + * The id's of the entries are stored in the `btf_dump.decl_tags` table,
> + * grouped by a target type.
> + */
> +static int btf_dump_assign_decl_tags(struct btf_dump *d)
> +{
> +       __u32 id, new_cnt, type_cnt = btf__type_cnt(d->btf);
> +       struct decl_tag_array *decl_tags;
> +       const struct btf_type *t;
> +       int err;
> +
> +       for (id = 1; id < type_cnt; id++) {
> +               t = btf__type_by_id(d->btf, id);
> +               if (!btf_is_decl_tag(t))
> +                       continue;
> +
> +               decl_tags = btf_dump_find_decl_tags(d, t->type);
> +               /* Assume small number of decl tags per id, increase array size by 1 */
> +               new_cnt = decl_tags ? decl_tags->cnt + 1 : 1;
> +               if (new_cnt > MAX_DECL_TAGS_PER_ID)
> +                       return -ERANGE;

why artificial limitations? user will pay the price proportional to
its BTF, and we don't really care as the memory is allocated
dynamically anyway

> +
> +               /* Allocate new_cnt + 1 to account for decl_tag_array header */
> +               decl_tags = libbpf_reallocarray(decl_tags, new_cnt + 1, sizeof(__u32));

oh, this new_cnt + 1 looks weird and error prone. we are reallocating
entire struct, not just an array, so realloc() makes more sense here.
How about:

decl_tags = realloc(decl_tags, sizeof(decl_tags) + new_cnt *
sizeof(decl_tags->tag_ids[0]));

?

> +               if (!decl_tags)
> +                       return -ENOMEM;
> +
> +               err = hashmap__insert(d->decl_tags, (void *)(uintptr_t)t->type, decl_tags,
> +                                     HASHMAP_SET, NULL, NULL);

why not using hashmap__set()?

> +               if (err) {
> +                       free(decl_tags);

hm... as this is written, it makes it look like double free can happen
if previous version of this pointer stays in d->decl_tags.

I think error shouldn't ever be returned because hashmap__insert()
won't be allocating any new memory, so I think it's best to leave a
small comment about this and just do:

(void)hashmap__set(d->decl_tag, t->type, (long)decl_tags, NULL, NULL);

and no error checking because we don't expect it to ever fail

> +                       return err;
> +               }
> +
> +               decl_tags->tag_ids[new_cnt - 1] = id;
> +               decl_tags->cnt = new_cnt;
> +       }
> +
> +       return 0;
> +}
> +
>  static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
>  {
>         __u32 *new_queue;
> @@ -899,6 +1007,51 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>         }
>  }
>
> +/*
> + * Define __btf_decl_tag to be either __attribute__ or noop.
> + */
> +static void btf_dump_maybe_define_btf_decl_tag(struct btf_dump *d)
> +{
> +       if (d->btf_decl_tag_is_defined || !hashmap__size(d->decl_tags))
> +               return;
> +
> +       d->btf_decl_tag_is_defined = true;
> +       btf_dump_printf(d, "#if __has_attribute(btf_decl_tag)\n");
> +       btf_dump_printf(d, "#  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))\n");
> +       btf_dump_printf(d, "#else\n");
> +       btf_dump_printf(d, "#  define __btf_decl_tag(x)\n");
> +       btf_dump_printf(d, "#endif\n\n");
> +}
> +

$ rg '#\s+define' | wc -l
44
$ rg '#define' | wc -l
696

not a big fan of this cuteness, #define is better IMO (more grep'able
as well, if anything)

> +/*
> + * Emits a list of __btf_decl_tag(...) attributes attached to some type.
> + * Decl tags attached to a type and to it's fields reside in a same
> + * list, thus use component_idx to filter out relevant tags:
> + * - component_idx == -1 designates the type itself;
> + * - component_idx >=  0 designates specific field.
> + */
> +static void btf_dump_emit_decl_tags(struct btf_dump *d,
> +                                   struct decl_tag_array *decl_tags,
> +                                   int component_idx)
> +{
> +       struct btf_type *decl_tag_t;

is there any ambiguity to justify verbose name? maybe just "t"?

> +       const char *decl_tag_text;
> +       struct btf_decl_tag *tag;
> +       __u32 i;
> +
> +       if (!decl_tags)
> +               return;
> +
> +       for (i = 0; i < decl_tags->cnt; ++i) {
> +               decl_tag_t = btf_type_by_id(d->btf, decl_tags->tag_ids[i]);
> +               tag = btf_decl_tag(decl_tag_t);
> +               if (tag->component_idx != component_idx)
> +                       continue;
> +               decl_tag_text = btf__name_by_offset(d->btf, decl_tag_t->name_off);
> +               btf_dump_printf(d, " __btf_decl_tag(\"%s\")", decl_tag_text);
> +       }
> +}
> +
>  static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
>                                      const struct btf_type *t)
>  {
> @@ -913,6 +1066,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>                                      const struct btf_type *t,
>                                      int lvl)
>  {
> +       struct decl_tag_array *decl_tags = btf_dump_find_decl_tags(d, id);
>         const struct btf_member *m = btf_members(t);
>         bool is_struct = btf_is_struct(t);
>         int align, i, packed, off = 0;
> @@ -945,6 +1099,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>                         m_sz = max((__s64)0, btf__resolve_size(d->btf, m->type));
>                         off = m_off + m_sz * 8;
>                 }
> +               btf_dump_emit_decl_tags(d, decl_tags, i);
>                 btf_dump_printf(d, ";");
>         }
>
> @@ -964,6 +1119,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>         btf_dump_printf(d, "%s}", pfx(lvl));
>         if (packed)
>                 btf_dump_printf(d, " __attribute__((packed))");
> +       btf_dump_emit_decl_tags(d, decl_tags, -1);
>  }
>
>  static const char *missing_base_types[][2] = {
> @@ -1104,6 +1260,7 @@ static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
>
>         btf_dump_printf(d, "typedef ");
>         btf_dump_emit_type_decl(d, t->type, name, lvl);
> +       btf_dump_emit_decl_tags(d, btf_dump_find_decl_tags(d, id), -1);
>  }
>
>  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
> --
> 2.34.1
>
