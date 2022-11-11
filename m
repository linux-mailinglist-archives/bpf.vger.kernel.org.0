Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426DD6261B9
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiKKS7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 13:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKS7I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 13:59:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BF5F869
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:59:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ft34so14552504ejc.12
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdCzXFKBBW7NkirtC8r0cdGq04Sb9Pl3+uTqudpwjcA=;
        b=cVrPq3++I6kQlBXVmInanm/hA5L1Ts2fn9hWjsyPO5chE57ZZO3aVpRgCTBPkWohup
         LiS3YtnxZSm7wcZ/v/fll+R5HsI3RFaYX4tuqcbXqBVMLf6JbsNfVa9bzM3yYNix/l3Y
         MDh2IhVZn0gU8u6jAB0szA1SHqW89J5y8BYv6BMIN0WauEOnpqKMi1fMBdJW8xCk2ECl
         hMUnJMlTPa42kmaH6EK1lYYxjiSK8iaprjA3to0EtVm3CuNuBUml07Ybst9c/rUiRH60
         AnwRV2LrM8whDcPTEpU1xVtY8o/cinYT9vUumQbPf7BmvdPZKIiLKE9lp4njmoWu9ter
         DmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdCzXFKBBW7NkirtC8r0cdGq04Sb9Pl3+uTqudpwjcA=;
        b=6DGMkDXlWlInODw3XumnNCyKFYirUWxY38qC+gJN+i3XvzmHHpjy85TP2yjMcq0OqN
         4qxA6J0bex66rnhCX6kV9jrpMVFNzK+Y8vafBthk2od0EJo6z4Is1jZDjjhfhwKEOSDe
         fc8SpfBbNFvr4bXO5FOY+roDD6OH1+06ifyXfJOLgOiTnlXS9jgii2XyERHesfOwA2YR
         J4T2mIw46ZjtdDEF+nLBoA4CiUAfy32NYP1ycwN2xee1GA2TMN3290l0gFnAJC82GWN7
         oljtq1pFXUAShOCzL2EMg+1qfZ899KkZXq7OS7gJkYgcT6O+6gV5sg3FdDFf7NzpC/pJ
         D78Q==
X-Gm-Message-State: ANoB5pnKbChNzeA9C9YxNNhTL3tpT+o5PsnHuX14pfhg73B+gFLC3cNY
        8CWzYFznOjvk3W9fG+sAulEHEMMsAtlrk1ktw2hZ4waJ
X-Google-Smtp-Source: AA0mqf7NATcUkcJFcFJFk4b/sjJTGJc5SkR+pmKT+EPMGUpbvWJc0aO51AkPgaL45kBEWVf4TaeiFhVv+f4C85yZXNY=
X-Received: by 2002:a17:907:2b26:b0:7ae:c460:c65f with SMTP id
 gc38-20020a1709072b2600b007aec460c65fmr2938572ejc.226.1668193145730; Fri, 11
 Nov 2022 10:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20221110144320.1075367-1-eddyz87@gmail.com> <20221110144320.1075367-2-eddyz87@gmail.com>
In-Reply-To: <20221110144320.1075367-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 10:58:53 -0800
Message-ID: <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
> as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> the type annotated with this attribute. This commit adds
> reconstitution of such attributes for BTF dump in C format.
>
> BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
> this is not enforced and tests don't honor this restriction.
> This commit uses hashmap to map types to the list of decl tags.
> The hashmap is filled incrementally by the function
> `btf_dump_assign_decl_tags` called from `btf_dump__dump_type` and
> `btf_dump__dump_type_data`.
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
>  #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
>  #else
>  #define __btf_decl_tag(x)
>  #endif
>
> The macro definition is emitted upon first call to `btf_dump__dump_type`.
>
> Clang allows to attach btf_decl_tag attributes to the following kinds
> of items:
> - struct/union                   supported
> - struct/union field             supported
> - typedef                        supported
> - global variables               supported
> - function prototype parameters  supported
> - function                       not applicable
> - function parameter             not applicable
> - local variables                not applicable
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 181 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 173 insertions(+), 8 deletions(-)
>

[...]

> +/*
> + * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
> + * The id's of the entries are stored in the `btf_dump.decl_tags` table,
> + * grouped by a target type.
> + */
> +static int btf_dump_assign_decl_tags(struct btf_dump *d)
> +{
> +       __u32 id, new_cnt, type_cnt = btf__type_cnt(d->btf);
> +       struct decl_tag_array *old_tags, *new_tags;
> +       const struct btf_type *t;
> +       size_t new_sz;
> +       int err;
> +
> +       for (id = d->next_decl_tag_scan_id; id < type_cnt; id++) {
> +               t = btf__type_by_id(d->btf, id);
> +               if (!btf_is_decl_tag(t))
> +                       continue;
> +
> +               old_tags = NULL;
> +               hashmap__find(d->decl_tags, t->type, &old_tags);
> +               /* Assume small number of decl tags per id, increase array size by 1 */
> +               new_cnt = old_tags ? old_tags->cnt + 1 : 1;
> +               if (new_cnt == UINT_MAX)
> +                       return -ERANGE;

this can't happen, BTF IDs don't go up to UINT_MAX even, let's drop
unnecessary check

> +               new_sz = sizeof(struct decl_tag_array) + new_cnt * sizeof(old_tags->tag_ids[0]);
> +               new_tags = realloc(old_tags, new_sz);
> +               if (!new_tags)
> +                       return -ENOMEM;
> +
> +               new_tags->tag_ids[new_cnt - 1] = id;
> +               new_tags->cnt = new_cnt;
> +
> +               /* No need to update the map if realloc have not changed the pointer */
> +               if (old_tags == new_tags)
> +                       continue;

this is a nice and simple optimization, I like it

> +
> +               err = hashmap__set(d->decl_tags, t->type, new_tags, NULL, NULL);
> +               if (!err)
> +                       continue;
> +               /*
> +                * If old_tags != NULL there is a record that holds it in the map, thus
> +                * the hashmap__set() call should not fail as it does not have to
> +                * allocate. If it does fail for some bizarre reason it's a bug and double
> +                * free is imminent because of the previous realloc call.
> +                */
> +               if (old_tags)
> +                       pr_warn("hashmap__set() failed to update value for existing entry\n");
> +               free(new_tags);
> +               return err;

but this is an overkill, it should not fail and btf_dump is not the
place to log bugs in hashmap, please do just

(void)hashmap__set(...);


> +       }
> +
> +       d->next_decl_tag_scan_id = type_cnt;
> +
> +       return 0;
> +}
> +

[...]

>  static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
> @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>                 }
>                 case BTF_KIND_FUNC_PROTO: {
>                         const struct btf_param *p = btf_params(t);
> +                       struct decl_tag_array *decl_tags = NULL;
>                         __u16 vlen = btf_vlen(t);
>                         int i;
>
> +                       hashmap__find(d->decl_tags, id, &decl_tags);
> +
>                         /*
>                          * GCC emits extra volatile qualifier for
>                          * __attribute__((noreturn)) function pointers. Clang

should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
here to emit tags of FUNC_PROTO itself?

> @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>
>                                 name = btf_name_of(d, p->name_off);
>                                 btf_dump_emit_type_decl(d, p->type, name, lvl);
> +                               btf_dump_emit_decl_tags(d, decl_tags, i);
>                         }
>
>                         btf_dump_printf(d, ")");
> @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dump *d,
>                              const void *data)
>  {
>         enum btf_func_linkage linkage = btf_var(v)->linkage;
> +       struct decl_tag_array *decl_tags = NULL;
>         const struct btf_type *t;
>         const char *l;
>         __u32 type_id;
> @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_dump *d,
>         type_id = v->type;
>         t = btf__type_by_id(d->btf, type_id);
>         btf_dump_emit_type_cast(d, type_id, false);
> -       btf_dump_printf(d, " %s = ", btf_name_of(d, v->name_off));
> +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
> +       hashmap__find(d->decl_tags, id, &decl_tags);
> +       btf_dump_emit_decl_tags(d, decl_tags, -1);
> +       btf_dump_printf(d, " = ");
>         return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>  }
>
> @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>         d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
>         d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
>
> +       btf_dump_assign_decl_tags(d);
> +

I'm actually not sure we want those tags on binary data dump.
Generally data dump is not type definition dump, so this seems
unnecessary, it will just distract from data itself. Let's drop it for
now? If there would be a need we can add it easily later.

>         ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>
>         d->typed_dump = NULL;
> --
> 2.34.1
>
