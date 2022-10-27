Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986B6105D4
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiJ0WgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiJ0WgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:36:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553861D94
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:36:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i21so5300304edj.10
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wRTsYheCqP0zo9Rf+QGFUht1Yu83SwU5XGcnopK8PU=;
        b=LXD2zW6M1kcQnYIIUrA4IN/sfctG2hqwnNA8lAZjDoRhVLITXOhHZ3N7ShxaqKrruW
         7FqGWZGXtt+cJXXUocbNPTpb3EV3/rhOF56T7voca5nZPoHy15/U6FQ/zebp6OH4BdQU
         hnXYbnHG+pVV8oBNM+Bon0SXE8LDeAvohBDZCDNyktp9dcGjxEqTlKRksLM0w3F6ivel
         DmkhvaeXk45tSrOd+kbwBsmFpCxmWvjlo36jr9R6Jd7fFuvJfOywBloytxCV9mz6pCcb
         3tzkfCIcpbd2SFY1AN6svINMfNuZJxC0hsQ1yMvxrmzi+69YFhgRJSu4nWcAq0fCFvsn
         fqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wRTsYheCqP0zo9Rf+QGFUht1Yu83SwU5XGcnopK8PU=;
        b=ybmDwL2XYLvIlP2cm7Wa5M+z0Rajg4zuljG9HOHNFCYs4lq6sBGZMj/6vSeAcSsvLE
         9o3+jNOhAOyfmWRnVGqCmMjG42NE6RtXt87XMaBczrvQpA41MMYetUEL78Fud1+EVY/x
         HkiZM+UXH59RnCQKlKCrnH9ZlwEjcH8yPYviJcjCt2Wt1anGSCXQnSO9Ms8mDaIwGQxS
         I9Mo0PWJxU3wav3Fpglq/AV46skcgFBgDKJUPLChYZxDyy5Zy7mK89E8F3If0TJ/j2xN
         xlZsxNokMD3cHcdV7fHjbRRplT6v4sYuxOdU8CmPnkJNNUpBoAeu9r0IxWSJ8TttAdnv
         fFug==
X-Gm-Message-State: ACrzQf26BgJWIF+DB4UOj4Zf9tmna4aO4oRqqUDBEnlXUHeLwpStlJ9Y
        zqBHvHauDoq2PlpL8XUZv4rZ5HFDzsY9m+4SKKdf69XOYF8=
X-Google-Smtp-Source: AMsMyM4TevYskidMPQZIHrZR9Pwj+dgcwd2JjbINqwyOakii1OWd47HZELgtSc8Lzczc1hDWY4nAei4HL8umpboG8Qk=
X-Received: by 2002:a05:6402:3641:b0:45c:4231:ddcc with SMTP id
 em1-20020a056402364100b0045c4231ddccmr47395893edb.224.1666910172638; Thu, 27
 Oct 2022 15:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <20221025222802.2295103-4-eddyz87@gmail.com>
In-Reply-To: <20221025222802.2295103-4-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 15:36:00 -0700
Message-ID: <CAEf4BzY=r4U7dZdQtkXPhXzLuPkqE5E73Z8owQb8175FB+guVg@mail.gmail.com>
Subject: Re: [RFC bpf-next 03/12] libbpf: Support for BTF_DECL_TAG dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
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

On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> At C level BTF_DECL_TAGs are represented as __attribute__
> declarations, e.g.:
>
> struct foo {
>         ...;
> } __attribute__((btf_decl_tag("bar")));
>
> This commit covers only decl tags attached to structs and unions.
>
> BTF doc says that BTF_DECL_TAGs should follow a target type but this
> is not enforced and tests don't honor this restriction.
> This commit uses hash table to map types to the list of decl tags.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 143 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 142 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index bf0cc0e986dd..9bfe2a4ae277 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -75,6 +75,15 @@ struct btf_dump_data {
>         bool is_array_char;
>  };
>
> +/*
> + * An array of ids of BTF_DECL_TAG objects associated with a specific type.
> + */
> +struct decl_tag_array {
> +       __u16 cnt;
> +       __u16 cap;
> +       __u32 tag_ids[0];
> +};
> +
>  struct btf_dump {
>         const struct btf *btf;
>         btf_dump_printf_fn_t printf_fn;
> @@ -111,6 +120,11 @@ struct btf_dump {
>          * name occurrences
>          */
>         struct hashmap *ident_names;
> +       /*
> +        * maps type id to decl_tag_array, assume that relatively small
> +        * fraction of types has btf_decl_tag's attached
> +        */
> +       struct hashmap *decl_tags;
>         /*
>          * data for typed display; allocated if needed.
>          */
> @@ -127,6 +141,26 @@ static bool str_equal_fn(const void *a, const void *b, void *ctx)
>         return strcmp(a, b) == 0;
>  }
>
> +static size_t int_hash_fn(const void *key, void *ctx)
> +{
> +       int i;
> +       size_t h = 0;
> +       char *bytes = (char *)key;
> +
> +       for (i = 0; i < 4; ++i)
> +               h = h * 31 + bytes[i];
> +
> +       return h;
> +}

no need, you can just do what btf_dedup_identity_hash_fn() is doing
and pass int/long/size_t as is, hashmap implementation does additional
multiplicative hashing on top to find a bucket

> +
> +static bool int_equal_fn(const void *a, const void *b, void *ctx)
> +{
> +       int *ia = (int *)a;
> +       int *ib = (int *)b;
> +
> +       return *ia == *ib;
> +}

see btf_dedup_equal_fn(), no need for casting, just return a == b;

> +
>  static const char *btf_name_of(const struct btf_dump *d, __u32 name_off)
>  {
>         return btf__name_by_offset(d->btf, name_off);
> @@ -143,6 +177,7 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
>
>  static int btf_dump_mark_referenced(struct btf_dump *d);
>  static int btf_dump_resize(struct btf_dump *d);
> +static int btf_dump_assign_decl_tags(struct btf_dump *d);
>
>  struct btf_dump *btf_dump__new(const struct btf *btf,
>                                btf_dump_printf_fn_t printf_fn,
> @@ -179,11 +214,24 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
>                 d->ident_names = NULL;
>                 goto err;
>         }
> +       d->decl_tags = hashmap__new(int_hash_fn, int_equal_fn, NULL);
> +       if (IS_ERR(d->decl_tags)) {
> +               err = PTR_ERR(d->decl_tags);
> +               d->decl_tags = NULL;
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
> +       if (err)
> +               goto err;
> +

I like the bullet-proof error checking, but checking just once should
be enough ;)

>         return d;
>  err:
>         btf_dump__free(d);
> @@ -232,7 +280,8 @@ static void btf_dump_free_names(struct hashmap *map)
>
>  void btf_dump__free(struct btf_dump *d)
>  {
> -       int i;
> +       int i, bkt;
> +       struct hashmap_entry *cur;
>
>         if (IS_ERR_OR_NULL(d))
>                 return;
> @@ -250,6 +299,9 @@ void btf_dump__free(struct btf_dump *d)
>         free(d->decl_stack);
>         btf_dump_free_names(d->type_names);
>         btf_dump_free_names(d->ident_names);
> +       hashmap__for_each_entry(d->decl_tags, cur, bkt)
> +               free(cur->value);
> +       hashmap__free(d->decl_tags);
>
>         free(d);
>  }
> @@ -373,6 +425,77 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
>         return 0;
>  }
>
> +static struct decl_tag_array *btf_dump_find_decl_tags(struct btf_dump *d, __u32 id)

do we really need this wrapper?


> +{
> +       struct decl_tag_array *decl_tags = NULL;
> +
> +       hashmap__find(d->decl_tags, &id, (void **)&decl_tags);

this &id also made me realize that this is all broken, you are
remembering random pointers in hashmap (they point onto stack, which
gets reused once this function returns; but hashmap remember it, so on
next lookup or update we are going to be reading random values in
int_equal_fn?)

you should be passing (void *)(long)id instead (and better yet let's
refactor hashmap API as I suggested in previous patch)

either I'm missing something, or this works by accident, which
suggests that tests could be improved maybe?..

> +
> +       return decl_tags;
> +}
> +
> +static struct decl_tag_array *realloc_decl_tags(struct decl_tag_array *tags, __u16 new_cap)
> +{
> +       size_t new_size = sizeof(struct decl_tag_array) + new_cap * sizeof(__u32);
> +       struct decl_tag_array *new_tags = (tags
> +                                          ? realloc(tags, new_size)
> +                                          : calloc(1, new_size));

realloc allocates if passed NULL, so no need for calloc, assuming
proper initialization

but let's use libbpf_reallocarray(), we'll waste few bytes on size_t,
but given we expect few tags, it's not a big deal

> +
> +       if (!new_tags)
> +               return NULL;
> +
> +       new_tags->cap = new_cap;
> +
> +       return new_tags;
> +}
> +
> +/*
> + * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
> + * The id's of the entries are stored in the `btf_dump.decl_tags` table,
> + * grouped by a target type.
> + */
> +static int btf_dump_assign_decl_tags(struct btf_dump *d)
> +{
> +       int err;
> +       __u32 id;
> +       __u32 n = btf__type_cnt(d->btf);
> +       __u32 new_capacity;
> +       const struct btf_type *t;
> +       struct decl_tag_array *decl_tags;

few nits: generally, for new code try to do reverse Christmas try
style, where widest line is at the top, shortest at the bottom

but also here you can have id, new_capacity, and n on same line

and s/new_capacity/new_cap/

> +
> +       for (id = 0; id < n; id++) {

0 is VOID, we never really need to process it, just start with id = 1

> +               t = btf__type_by_id(d->btf, id);
> +
> +               if (btf_kind(t) != BTF_KIND_DECL_TAG)
> +                       continue;

if (!btf_is_decl_tag(t))
    continue;

> +
> +               decl_tags = btf_dump_find_decl_tags(d, t->type);
> +               if (!decl_tags) {
> +                       decl_tags = realloc_decl_tags(NULL, 1);
> +                       if (!decl_tags)
> +                               return -ENOMEM;
> +                       err = hashmap__insert(d->decl_tags, &t->type, decl_tags,
> +                                             HASHMAP_SET, NULL, NULL);
> +                       if (err)
> +                               return err;
> +               } else if (decl_tags->cnt == decl_tags->cap) {
> +                       new_capacity = decl_tags->cap * 2;
> +                       if (new_capacity > 0xffff)
> +                               return -ERANGE;
> +                       decl_tags = realloc_decl_tags(decl_tags, new_capacity);
> +                       if (!decl_tags)
> +                               return -ENOMEM;
> +                       decl_tags->cap = new_capacity;
> +                       err = hashmap__update(d->decl_tags, &t->type, decl_tags, NULL, NULL);
> +                       if (err)
> +                               return err;
> +               }

really, let's just use libbpf_reallocarray? I was going to suggest
libbpf_ensure_mem, but it allocates at least 16 elements, which seems
like an overkill. But also given we don't expect a lot of tags per
type, realloc()'ing with + 1 (no * 2 strategy) seems reasonable.
Modern allocators either way use differently sized buckets, so when
realloc size increment is small, allocator basically will do nothing.

> +               decl_tags->tag_ids[decl_tags->cnt++] = id;
> +       }
> +
> +       return 0;
> +}
> +
>  static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
>  {
>         __u32 *new_queue;
> @@ -899,6 +1022,23 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>         }
>  }
>
> +static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id)
> +{
> +       struct decl_tag_array *decl_tags = btf_dump_find_decl_tags(d, id);
> +       struct btf_type *decl_tag_t;
> +       const char *decl_tag_text;
> +       __u32 i;
> +
> +       if (!decl_tags)
> +               return;
> +
> +       for (i = 0; i < decl_tags->cnt; ++i) {
> +               decl_tag_t = btf_type_by_id(d->btf, decl_tags->tag_ids[i]);
> +               decl_tag_text = btf__name_by_offset(d->btf, decl_tag_t->name_off);
> +               btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", decl_tag_text);
> +       }
> +}

I'm wondering if we should anticipate that some compilers won't know
about btf_decl_tag attribute? It seems a bit off for btf_dump to worry
about this, but if we don't do something like:

#if __has_attribute(btf_decl_tag)
#define __btf_decl_tag(x) __attribute__((btf_decl_tag(#x)))
#else
#define __btf_decl_tag(x)
#endif

.
.
.

struct my_struct {
     ...
} __btf_decl_tag(awesomeness);


it will be hard for users to use resulting vmlinux.h with slightly older Clang?

> +
>  static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
>                                      const struct btf_type *t)
>  {
> @@ -964,6 +1104,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>         btf_dump_printf(d, "%s}", pfx(lvl));
>         if (packed)
>                 btf_dump_printf(d, " __attribute__((packed))");
> +       btf_dump_emit_decl_tags(d, id);
>  }
>
>  static const char *missing_base_types[][2] = {
> --
> 2.34.1
>
