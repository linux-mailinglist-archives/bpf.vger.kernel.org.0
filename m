Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7665461E
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 19:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLVSuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 13:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVSup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 13:50:45 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E50E0
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 10:50:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m18so6989420eji.5
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+tKCSDb5pfxVZVXLKp110gxDsDEMRBUz6Lea/tHxlQ=;
        b=V7QoJuhAD7EDjmmo9c0F3zoCl5HNg7MjdVnuenKMnHhpii2d4XGXgEiWbxdhQisrBm
         +mDaWpRx+dCm99T6HqOepEmDCNcWIAwz4BtyxOuNYLDUrhJly0aN6Cosigmgzl/RdoZZ
         q/9h6YiXeaV8FTCI/H0Znr0s3zHF4hycRJuk6u7vZ7JkYZdj7KEEBTe84m8WhIdIkBVa
         qyJjzWYw+3K5CfIY6LyF/BfGc2XxsuZS0y9ykzswI/5vr4U9dj+lMh9fWpLifHOnWZ3C
         G5GYwdsIMNdXTN/8TcET6ZmPhvwCYBso3sWr+uduDyeFOSWvgiVppIJgMp5d4VFiFYD/
         A/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+tKCSDb5pfxVZVXLKp110gxDsDEMRBUz6Lea/tHxlQ=;
        b=Ww3Pb04UeSdsV4KPj00R5q0VrWBl8ChW/joSK0HAZYuPL/In+sy6d1LCbh5pPYkyxO
         lT4NDilPCs1esmo/wQQ9ZcyEeTFcatsV1XBqHkphPrKmAQoMfXCrcTdRRxlY0OxzOcds
         wKxI6XgVnQsa1wsvAhEJmb9/Kkbwz1AA2Ctla90hgf2lNwfmO6alTyvDmkVzYhyAz7qA
         myGSG67v4r/QeuMH1jh8NnEbbq668EdgMyxwTJGJ8lhIt6m7UqRx1gOUiRwmI5Fj7eMZ
         0QKWZa3Egloq5yF0akB7Shv/t8Fj43vc61g0iwlZDoGyjW56Ef/ckUbcMt/F1+4kT6GH
         Q5BA==
X-Gm-Message-State: AFqh2kq/cPdqpLoA2qziOBcW+XWYz8zOeHzniTryb4QuvOggjWsUGUyV
        +o68JKuci+bDuxRofEwxMOqXkBJKBl37mQ64FAw=
X-Google-Smtp-Source: AMrXdXupiOLcRvyIdhHqIcA6HLTWzX8Yse7kbpO3uQb2MtoPXbzxisc+KlXuR/Mu1jV0Hjc9Cg+RpkvRlui1xK6VOR4=
X-Received: by 2002:a17:906:a014:b0:7c1:8450:f964 with SMTP id
 p20-20020a170906a01400b007c18450f964mr607470ejy.176.1671735041633; Thu, 22
 Dec 2022 10:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20221217082506.1570898-1-davemarchevsky@fb.com> <20221217082506.1570898-12-davemarchevsky@fb.com>
In-Reply-To: <20221217082506.1570898-12-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Dec 2022 10:50:29 -0800
Message-ID: <CAEf4BzYYqwmAbu28exBLWONryJnSYufktXh5zgNjtnfC+fGD-A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/13] libbpf: Make BTF mandatory if program
 BTF has spin_lock or alloc_obj type
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
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

On Sat, Dec 17, 2022 at 12:25 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> If a BPF program defines a struct or union type which has a field type
> that the verifier considers special - spin_lock, graph datastructure
> heads and nodes - the verifier needs to be able to find fields of that
> type using BTF.
>
> For such a program, BTF is required, so modify kernel_needs_btf helper
> to ensure that correct "BTF is mandatory" error message is emitted.
>
> The newly-added btf_has_alloc_obj_type looks for BTF_KIND_STRUCTs with a
> name corresponding to a special type. If any such struct is found it is
> assumed that some variable is using it, and therefore that successful
> BTF load is necessary.
>
> Also add a kernel_needs_btf check to bpf_object__create_map where it was
> previously missing. When this function calls bpf_map_create, kernel may
> reject map creation due to mismatched graph owner and ownee
> types (e.g. a struct bpf_list_head with __contains tag pointing to
> bpf_rbtree_node field). In such a scenario - or any other where BTF is
> necessary for verification - bpf_map_create should not be retried
> without BTF.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2a82f49ce16f..56a905b502c9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -998,6 +998,31 @@ find_struct_ops_kern_types(const struct btf *btf, const char *tname,
>         return 0;
>  }
>
> +/* Should match alloc_obj_fields in kernel/bpf/btf.c
> + */

nit: keep comment on a single line?

> +static const char *alloc_obj_fields[] = {
> +       "bpf_spin_lock",
> +       "bpf_list_head",
> +       "bpf_list_node",
> +       "bpf_rb_root",
> +       "bpf_rb_node",
> +};
> +
> +static bool
> +btf_has_alloc_obj_type(const struct btf *btf)

I find "alloc_obj_type" naming completely unhelpful, tbh. Let's use
something more generic and unassuming as "special_btf_type" or
something along those lines?

> +{
> +       const char *tname;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(alloc_obj_fields); i++) {
> +               tname = alloc_obj_fields[i];
> +               if (btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT) > 0)

this will do linear search over entire program's BTF for each
alloc_obj_fields element. Given alloc_obj_fields is supposed to be a
small array, I think it's better to do single linear pass over prog
BTF and for each found STRUCT check if its name matches
alloc_obj_fields.

Having said that, it feels like the better logic would be to check
that any map value's BTF (including global var ARRAYs) have a field of
one of those special types. Just searching for any STRUCT type with
one of those names feels off.

> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static bool bpf_map__is_struct_ops(const struct bpf_map *map)
>  {
>         return map->def.type == BPF_MAP_TYPE_STRUCT_OPS;
> @@ -2794,7 +2819,8 @@ static bool libbpf_needs_btf(const struct bpf_object *obj)
>
>  static bool kernel_needs_btf(const struct bpf_object *obj)
>  {
> -       return obj->efile.st_ops_shndx >= 0;
> +       return obj->efile.st_ops_shndx >= 0 ||
> +               (obj->btf && btf_has_alloc_obj_type(obj->btf));
>  }
>
>  static int bpf_object__init_btf(struct bpf_object *obj,
> @@ -5103,16 +5129,18 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>
>                 err = -errno;
>                 cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -               pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> -                       map->name, cp, err);
> -               create_attr.btf_fd = 0;
> -               create_attr.btf_key_type_id = 0;
> -               create_attr.btf_value_type_id = 0;
> -               map->btf_key_type_id = 0;
> -               map->btf_value_type_id = 0;
> -               map->fd = bpf_map_create(def->type, map_name,
> -                                        def->key_size, def->value_size,
> -                                        def->max_entries, &create_attr);
> +               pr_warn("Error in bpf_create_map_xattr(%s):%s(%d).\n", map->name, cp, err);
> +               if (!kernel_needs_btf(obj)) {

see above about check whether a map's value BTF itself is using any of
the special type. I think this decision should be made based on
particular map's need for BTF, not based on kernel_needs_btf().

I think it would be better to have an if/else with different
pr_warn()s. Both should report that initial bpf_map_create() (btw,
gotta update the message now, missed that) failed with error, but then
in one case say that we are retrying without BTF, and in another
explain that we are not because map requires kernel to see its BTF.
WDYT?

> +                       pr_warn("Retrying bpf_map_create_xattr(%s) without BTF.\n", map->name);
> +                       create_attr.btf_fd = 0;
> +                       create_attr.btf_key_type_id = 0;
> +                       create_attr.btf_value_type_id = 0;
> +                       map->btf_key_type_id = 0;
> +                       map->btf_value_type_id = 0;
> +                       map->fd = bpf_map_create(def->type, map_name,
> +                                                def->key_size, def->value_size,
> +                                                def->max_entries, &create_attr);
> +               }
>         }
>
>         err = map->fd < 0 ? -errno : 0;
> --
> 2.30.2
>
