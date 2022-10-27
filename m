Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96EC610554
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiJ0WHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiJ0WHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:07:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0735A02DF
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:07:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sc25so8563717ejc.12
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SY8JrpmwOQicFtm0C9UfXYrXhoIVGa+Fp2ANvgCrYQ=;
        b=FHu/j1S9x5SXUUJjLT7/NhLRAcc/0z7J+ILpqeoEhpLMxmlOOTpP4vPKNQGsrG9tF8
         U0RHlohSIl+mxrC6JFAeJHRW/RgPnpM7goii9JsSKO7+49yDQ18X8J25Wvzm+k+EI9Jr
         yEJBuCMKBx5Trhh/1e/RE8K3S1kgNAc0dSctjf8BP8sknPaqvbqNjdQE8V7/8ToWHI74
         y5VPWDmUSHa+G/Vq1+eylXozcjYh8a6WdAkYU+19cgPg3BLmI3a6GpRRvKkzT6ydqWVa
         XWUPhPbLWW3R+PO8Zq4y+zXkPs22Zc8hQevtMZV/n+s36zR9fw4T7kqUz6CbWekBcoUg
         jAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SY8JrpmwOQicFtm0C9UfXYrXhoIVGa+Fp2ANvgCrYQ=;
        b=Aak5wmQ3bdfNdA3ScbVBPRNRl53z7L42ULm8s/NmlqhC1v4HpGZqkWks1DNZiIKTsB
         a2fFAUY2Q+uHQ2uGhv51L+7WiU/80AEbOxEnAXLleuRW2/G1XJYJA1JjkeWi8FQ1/PIM
         +7Ipv4kj+XtGvOR3gMhvVEWNoYTHEoz1+deuifxYTF7V9wMQQIrn3G4jnqRoPmRAxj4f
         2MjOYnrck4pTly7jWtxSN35ViBVbxt+hmwePe5PX6wOMRZMxVGs1m7bqfK4LecxNSOWP
         GO1svHmS9BvamJ5CqkdgcrZQ8wMQPlJw07AuE7LILjx0tLMKnyTnkUtM4T7wJYpfxzg5
         aq6w==
X-Gm-Message-State: ACrzQf0ZuANAfsjv/h3WL77ThlF08ezDGLy5eU++u6b48JwFDN8VO/+S
        TIKSCFfE4C+N+h0UcGLWoAIxE54HKCn1kQVQw9Q=
X-Google-Smtp-Source: AMsMyM4O7vufW3xSnv+D1lyPQWXd2EWZ1k064N/i2jM7H5EAvq1fN+KlOA2DkpTfPa6Hg5hWgQ8dS7xi74aY//U8IYU=
X-Received: by 2002:a17:907:1c88:b0:7ad:8f76:699e with SMTP id
 nb8-20020a1709071c8800b007ad8f76699emr4566660ejc.114.1666908433241; Thu, 27
 Oct 2022 15:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <20221025222802.2295103-2-eddyz87@gmail.com>
In-Reply-To: <20221025222802.2295103-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 15:07:01 -0700
Message-ID: <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/12] libbpf: Deduplicate unambigous standalone
 forward declarations
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
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
> Deduplicate forward declarations that don't take part in type graphs
> comparisons if declaration name is unambiguous. Example:
>
> CU #1:
>
> struct foo;              // standalone forward declaration
> struct foo *some_global;
>
> CU #2:
>
> struct foo { int x; };
> struct foo *another_global;
>
> The `struct foo` from CU #1 is not a part of any definition that is
> compared against another definition while `btf_dedup_struct_types`
> processes structural types. The the BTF after `btf_dedup_struct_types`
> the BTF looks as follows:
>
> [1] STRUCT 'foo' size=4 vlen=1 ...
> [2] INT 'int' size=4 ...
> [3] PTR '(anon)' type_id=1
> [4] FWD 'foo' fwd_kind=struct
> [5] PTR '(anon)' type_id=4
>
> This commit adds a new pass `btf_dedup_standalone_fwds`, that maps
> such forward declarations to structs or unions with identical name in
> case if the name is not ambiguous.
>
> The pass is positioned before `btf_dedup_ref_types` so that types
> [3] and [5] could be merged as a same type after [1] and [4] are merged.
> The final result for the example above looks as follows:
>
> [1] STRUCT 'foo' size=4 vlen=1
>         'x' type_id=2 bits_offset=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] PTR '(anon)' type_id=1
>
> For defconfig kernel with BTF enabled this removes 63 forward
> declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
> The running time of `btf__dedup` function is increased by about 3%.
>

What about modules, can you share stats for module BTFs?

Also cc Alan as he was looking at BTF dedup improvements for kernel
module BTF dedup.

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 178 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d88647da2c7f..c34c68d8e8a0 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2881,6 +2881,7 @@ static int btf_dedup_strings(struct btf_dedup *d);
>  static int btf_dedup_prim_types(struct btf_dedup *d);
>  static int btf_dedup_struct_types(struct btf_dedup *d);
>  static int btf_dedup_ref_types(struct btf_dedup *d);
> +static int btf_dedup_standalone_fwds(struct btf_dedup *d);
>  static int btf_dedup_compact_types(struct btf_dedup *d);
>  static int btf_dedup_remap_types(struct btf_dedup *d);
>
> @@ -2988,15 +2989,16 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
>   * Algorithm summary
>   * =================
>   *
> - * Algorithm completes its work in 6 separate passes:
> + * Algorithm completes its work in 7 separate passes:
>   *
>   * 1. Strings deduplication.
>   * 2. Primitive types deduplication (int, enum, fwd).
>   * 3. Struct/union types deduplication.
> - * 4. Reference types deduplication (pointers, typedefs, arrays, funcs, func
> + * 4. Standalone fwd declarations deduplication.

Let's call this "Resolve unambiguous forward declarations", we don't
really deduplicate anything. And call the function
btf_dedup_resolve_fwds()?

> + * 5. Reference types deduplication (pointers, typedefs, arrays, funcs, func
>   *    protos, and const/volatile/restrict modifiers).
> - * 5. Types compaction.
> - * 6. Types remapping.
> + * 6. Types compaction.
> + * 7. Types remapping.
>   *
>   * Algorithm determines canonical type descriptor, which is a single
>   * representative type for each truly unique type. This canonical type is the
> @@ -3060,6 +3062,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
>                 pr_debug("btf_dedup_struct_types failed:%d\n", err);
>                 goto done;
>         }
> +       err = btf_dedup_standalone_fwds(d);
> +       if (err < 0) {
> +               pr_debug("btf_dedup_standalone_fwd failed:%d\n", err);
> +               goto done;
> +       }
>         err = btf_dedup_ref_types(d);
>         if (err < 0) {
>                 pr_debug("btf_dedup_ref_types failed:%d\n", err);
> @@ -4525,6 +4532,169 @@ static int btf_dedup_ref_types(struct btf_dedup *d)
>         return 0;
>  }
>
> +/*
> + * `name_off_map` maps name offsets to type ids (essentially __u32 -> __u32).
> + *
> + * The __u32 key/value representations are cast to `void *` before passing
> + * to `hashmap__*` functions. These pseudo-pointers are never dereferenced.
> + *
> + */
> +static struct hashmap *name_off_map__new(void)
> +{
> +       return hashmap__new(btf_dedup_identity_hash_fn,
> +                           btf_dedup_equal_fn,
> +                           NULL);
> +}

is there a point in name_off_map__new and name_off_map__find wrappers
except to add one extra function to jump through when reading the
code? If you look at other uses of hashmaps in this file, we use the
directly. Let's drop those.

> +
> +static int name_off_map__find(struct hashmap *map, __u32 name_off, __u32 *type_id)
> +{
> +       /* This has to be sizeof(void *) in order to be passed to hashmap__find */
> +       void *tmp;
> +       int found = hashmap__find(map, (void *)(ptrdiff_t)name_off, &tmp);

but this (void *) casting everything was an error in API design, mea
culpa. I've been wanting to switch hashmap to use long as key/value
type for a long while, maybe let's do it now, as we are adding even
more code that looks weird? It seems like accepting long will make
hashmap API usage cleaner in most cases. There are not a lot of places
where we use hashmap APIs in libbpf, but we'll also need to fix up
bpftool usage, and I believe perf copy/pasted hashmap.h (cc Arnaldo),
so we'd need to make sure to not break all that. But good thing it's
all in the same repo and we can convert them at the same time with no
breakage.

WDYT?

> +       /*
> +        * __u64 cast is necessary to avoid pointer to integer conversion size warning.
> +        * It is fine to get rid of this warning as `void *` is used as an integer value.
> +        */
> +       if (found)
> +               *type_id = (__u64)tmp;
> +       return found;
> +}
> +
> +static int name_off_map__set(struct hashmap *map, __u32 name_off, __u32 type_id)
> +{
> +       return hashmap__set(map, (void *)(size_t)name_off, (void *)(size_t)type_id,
> +                           NULL, NULL);
> +}

this function will also be completely unnecessary with longs

> +
> +/*
> + * Collect a `name_off_map` that maps type names to type ids for all
> + * canonical structs and unions. If the same name is shared by several
> + * canonical types use a special value 0 to indicate this fact.
> + */
> +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct hashmap *names_map)
> +{
> +       int i, err = 0;
> +       __u32 type_id, collision_id;
> +       __u16 kind;
> +       struct btf_type *t;
> +
> +       for (i = 0; i < d->btf->nr_types; i++) {
> +               type_id = d->btf->start_id + i;
> +               t = btf_type_by_id(d->btf, type_id);
> +               kind = btf_kind(t);
> +
> +               if (kind != BTF_KIND_STRUCT && kind != BTF_KIND_UNION)
> +                       continue;

let's also do ENUM FWD resolution. ENUM FWD is just ENUM with vlen=0

> +
> +               /* Skip non-canonical types */
> +               if (type_id != d->map[type_id])
> +                       continue;
> +
> +               err = 0;
> +               if (name_off_map__find(names_map, t->name_off, &collision_id)) {
> +                       /* Mark non-unique names with 0 */
> +                       if (collision_id != 0 && collision_id != type_id)
> +                               err = name_off_map__set(names_map, t->name_off, 0);
> +               } else {
> +                       err = name_off_map__set(names_map, t->name_off, type_id);
> +               }

err = hashmap__add(..., t->name_off, type_id);
if (err == -EEXISTS) {
    hashmap__set(..., 0);
    return 0;
}

see comment for hashmap_insert_strategy in hashmap.h

> +
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int btf_dedup_standalone_fwd(struct btf_dedup *d,
> +                                   struct hashmap *names_map,
> +                                   __u32 type_id)
> +{
> +       struct btf_type *t = btf_type_by_id(d->btf, type_id);
> +       __u16 kind = btf_kind(t);
> +       enum btf_fwd_kind fwd_kind = BTF_INFO_KFLAG(t->info);
> +

nit: don't break variables block in two parts, there shouldn't be empty lines

also please use btf_kflag(t)


> +       struct btf_type *cand_t;
> +       __u16 cand_kind;
> +       __u32 cand_id = 0;
> +
> +       if (kind != BTF_KIND_FWD)
> +               return 0;
> +
> +       /* Skip if this FWD already has a mapping */
> +       if (type_id != d->map[type_id])
> +               return 0;
> +

[...]
